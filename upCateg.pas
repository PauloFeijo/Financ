unit upCateg;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uPesqPadrao, ExtCtrls, ComCtrls, StdCtrls, Grids, DBGrids, Buttons,
  uLib, uConst, IBX.IBQuery, udmFinanc, DB, Vcl.Menus,
  JvExComCtrls, JvDBTreeView, JvExControls, JvDBLookupTreeView, JvExExtCtrls,
  JvNetscapeSplitter;

type
  TpCateg = class(TpPesqPadrao)
    Tree: TTreeView;
    JvNetscapeSplitter1: TJvNetscapeSplitter;
    Label1: TLabel;
    Label2: TLabel;
    edCodigo: TEdit;
    edNome: TEdit;
    rgAtivo: TRadioGroup;
    procedure FormShow(Sender: TObject);
    procedure sbAdicionarClick(Sender: TObject);
    procedure sbAlterarClick(Sender: TObject);
    procedure sbRemoverClick(Sender: TObject);
    procedure TreeChange(Sender: TObject; Node: TTreeNode);
    procedure procRemoveItens;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure SalvarConfiguraodaGrade1Click(Sender: TObject);
    procedure RestaurarConfiguraodaGrade1Click(Sender: TObject);
  private
    { Private declarations }
    c_tipo : string;
    procedure procMontaArvoreCategoria;
    procedure procAbreTelaManutencao(i_cat : integer);
    procedure procExcluirCategoriaEAfins;
  public
    { Public declarations }
    procedure procMontaWhere;override;
    procedure procRecupera;override;
    class function funcAbreTela(pai : TComponent; b_pesquisa : boolean = false;b_final:boolean=true; c_tipo : string = ''):boolean; overload;
  end;

  TCategoria = class(TObject)
                   idCateg : integer;
                   dsCateg : string;
                   idCatPai : integer;
               end;

var
  pCateg: TpCateg;
  Categoria : TCategoria;
implementation

{$R *.dfm}

uses ucCateg;

{ TpCateg }

class function TpCateg.funcAbreTela(pai: TComponent; b_pesquisa,
  b_final: boolean; c_tipo: string): boolean;
begin
  pCateg := TpCateg.Create(pai);
  try
    pCateg.b_somentePesquisa := b_pesquisa;
    pCateg.b_finaliza := b_final;
    pCateg.c_tipo := c_tipo;
    pCateg.ShowModal;
  finally
    FreeAndNil(pCateg);
  end;
  result := true;
end;

procedure TpCateg.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  procRemoveItens;
  inherited;
end;

procedure TpCateg.FormShow(Sender: TObject);
   procedure procHeightTree;
   var i_width : integer;
   begin
      i_width := StrToIntDef(
                    uLib.funcValorArqInf(
                       funcCaminhoConf+Self.Name+'Out'+'_'+CD_USUARIO_LOGADO,'<tree_width>'),0
                  );
      if i_width > 0 then
        Tree.Width := i_width;
   end;
begin
  inherited;
  if b_somentePesquisa then
  begin
    sbAdicionar.Visible := False;
    sbRemover.Visible := False;
    sbAlterar.Visible := False;
  end;
  procHeightTree;
end;

procedure TpCateg.procAbreTelaManutencao(i_cat: integer);
var i_categ : integer;
begin
  dmFinanc.Categoria.Close;
  dmFinanc.Categoria.SQL.Text := SQL_CATEGORIA+
                                 'WHERE A.ID_CATEG = :CATEG';
  dmFinanc.Categoria.ParamByName('categ').AsInteger := i_cat;
  dmFinanc.Categoria.Open;

  if i_cat = 0 then
  begin
    dmFinanc.Categoria.Append;
    dmFinanc.CategoriaID_CATPAI.AsInteger := dmFinanc.PesCategoriaID_CATEG.AsInteger;
    dmFinanc.CategoriaFL_TIPO.AsString    := dmFinanc.PesCategoriaFL_TIPO.AsString;
  end
  else
    dmFinanc.Categoria.Edit;

  i_categ := dmFinanc.CategoriaID_CATEG.AsInteger;
  TcCateg.b_funcAbreTela(Self,b_finaliza);

  procRecupera;
  q_Principal.Locate('ID_CATEG',i_categ,[loCaseInsensitive]);
  procMontaArvoreCategoria;
  procHabilitaBotoes;
end;

procedure TpCateg.procExcluirCategoriaEAfins;
  procedure procErroAoDeletar(c_msgErro : string);
  begin
    if b_finaliza and dmFinanc.tdb.InTransaction then
      dmFinanc.tdb.Rollback;
    procMsgErro('Não foi possível excluir o registro.'+sLineBreak+sLineBreak+
                'Causa: '+c_msgErro);
  end;

begin
  if not funcMsgConfirma('Deseja remover a categoria selecionada, suas categorias filhas e seus movimentos?') then
    Exit;

  try
    procExecSql(Format('DELETE FROM CATEGORIA A'+
                       ' WHERE A.ID_CATEG = %s',
                       [dmFinanc.PesCategoriaID_CATEG.AsString]),False);

    if b_finaliza and dmFinanc.tdb.InTransaction then
      dmFinanc.tdb.Commit;
  except
     on e : EDatabaseError do
     begin
       if(pos('lock',e.Message) > 0) then
         procErroAoDeletar('Existem Categorias/Movimentos vinculados à esta categoria que estão sendo editados por outro usuário.')

       else if (pos('FOREIGN',e.Message) > 0) then
         procErroAoDeletar('Categoria possui relacionamentos.')

       else
         procErroAoDeletar(e.Message);
     end;

    on e: Exception do
        procErroAoDeletar(e.Message);
  end;

  procRecupera;
  procHabilitaBotoes;
  procMontaArvoreCategoria;
end;

procedure TpCateg.procMontaArvoreCategoria;
var i_index : integer;

  procedure procNovaCategoria(i_cat : integer; s_cat : string; i_catpai : integer);
  begin
    Categoria := TCategoria.Create;
    Categoria.idCateg  := i_cat;
    Categoria.dsCateg  := s_cat;
    Categoria.idCatPai := i_catpai
  end;

  procedure procPopulaCategoria(no : TTreeNode; i_categ : integer);
  var q : TIBQuery;
  begin
    procCriarQuery(
       q,Format(SQL_CATEGORIA+
       ' WHERE A.CD_USUARIO = ''%s'' '+
       ' AND A.ID_CATPAI %s %s',
       [CD_USUARIO_LOGADO,
        IIF(i_categ > 0,'= '+intToStr(i_categ),'IS NULL'),
        IIF(Trim(c_tipo) <> EmptyStr, ' AND A.FL_TIPO = '+QuotedStr(c_tipo),EmptyStr)
       ]));

    try
      q.Open;
      while not q.Eof do
      begin
        procNovaCategoria(
           q.FieldByName('ID_CATEG').AsInteger,
           q.FieldByName('DS_CATEG').AsString,
           q.FieldByName('ID_CATPAI').AsInteger);

        Tree.Items.AddChildObject(
           no,Categoria.dsCateg,Categoria);

        Inc(i_index);

        procPopulaCategoria(
           Tree.Items[i_index],
           TCategoria(Tree.Items[i_index].Data).idCateg);

          if not dmFinanc.PesCategoria.Locate(
             'ID_CATEG',TCategoria(Tree.Items[i_index].Data).idCateg,
             [loCaseInsensitive]) then
          begin
            TCategoria(Tree.Items[i_index].Data).Free;
            Tree.Items.Item[i_index].Delete;
            Dec(i_index);
          end;

        q.Next;
      end;
    finally
      FreeAndNil(q);
    end;
  end;

begin
  procRemoveItens;
  Tree.Items.Clear;
  i_index := -1;

  procPopulaCategoria(nil,0);

  if Tree.CanFocus then
    Tree.SetFocus
end;

procedure TpCateg.procMontaWhere;
begin
  inherited;
  s_Where := SQL_CATEGORIA +
             ' WHERE A.CD_USUARIO = '+QuotedStr(CD_USUARIO_LOGADO);

  if edCodigo.Text <> EmptyStr then
    s_Where := funcAddCondSql(s_Where, 'A.ID_CATEG = ' + edCodigo.Text);

  if edNome.Text <> EmptyStr then
    s_Where := funcAddCondSql(s_Where, 'A.DS_CATEG LIKE ' + QuotedStr('%'+edNome.Text+'%'));

  case rgAtivo.ItemIndex of
    0 : s_Where := funcAddCondSql(s_Where, 'A.FL_ATIVO = ''A''');
    1 : s_Where := funcAddCondSql(s_Where, 'A.FL_ATIVO = ''I''');
  end;
end;

procedure TpCateg.procRecupera;
begin
  inherited;
  procMontaArvoreCategoria;
end;

procedure TpCateg.procRemoveItens;
var
  i: Integer;
begin
  for i := 0 to Tree.Items.Count - 1 do
  begin
    TCategoria(Tree.Items[i].Data).Free;
  end;
end;

procedure TpCateg.RestaurarConfiguraodaGrade1Click(Sender: TObject);
begin
  inherited;
  DeleteFile(funcCaminhoConf+Self.Name+'Out'+'_'+CD_USUARIO_LOGADO);
end;

procedure TpCateg.SalvarConfiguraodaGrade1Click(Sender: TObject);
begin
  inherited;
  uLib.procValorArqInf(funcCaminhoConf+Self.Name+'Out'+'_'+CD_USUARIO_LOGADO,'<tree_width>',IntToStr(Tree.Width));
end;

procedure TpCateg.sbAdicionarClick(Sender: TObject);
begin
  if not sbAdicionar.Enabled then
    Exit;

  procAbreTelaManutencao(0);
end;

procedure TpCateg.sbAlterarClick(Sender: TObject);
begin
  if not sbAlterar.Enabled then
    Exit;

  if dmFinanc.PesCategoriaID_CATPAI.IsNull then
    Exit;

  procAbreTelaManutencao(dmFinanc.PesCategoriaID_CATEG.AsInteger);
end;

procedure TpCateg.sbRemoverClick(Sender: TObject);
begin
  if not sbRemover.Enabled then
    Exit;

  if dmFinanc.PesCategoriaID_CATPAI.IsNull then
    Exit;

  procExcluirCategoriaEAfins;
end;

procedure TpCateg.TreeChange(Sender: TObject; Node: TTreeNode);
begin
  inherited;
  if dmFinanc.PesCategoria.State <> dsInactive then
    dmFinanc.PesCategoria.Locate('ID_CATEG',TCategoria(Tree.Selected.Data).idCateg,[loCaseInsensitive])
end;

end.
