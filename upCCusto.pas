unit upCCusto;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uPesqPadrao, ExtCtrls, ComCtrls, StdCtrls, Grids, DBGrids, Buttons,
  uLib, uConst, IBX.IBQuery, udmFinanc, DB, Vcl.Menus,
  JvExExtCtrls, JvNetscapeSplitter;

type
  TpCCusto = class(TpPesqPadrao)
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
    procedure procMontaArvoreCCusto;
    procedure procAbreTelaManutencao(i_ccusto : integer);
    procedure procExcluirCCustoEAfins;
  public
    { Public declarations }
    procedure procMontaWhere;override;
    procedure procRecupera;override;
  end;

  TCCusto = class(TObject)
                   idCCusto : integer;
                   dsCCusto : string;
                   idCCPai : integer;
               end;

var
  pCCusto: TpCCusto;
  CCusto : TCCusto;
implementation

{$R *.dfm}

uses ucCCusto;

{ TpCCusto }

procedure TpCCusto.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  procRemoveItens;
  inherited;
end;

procedure TpCCusto.FormShow(Sender: TObject);
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
  procMontaArvoreCCusto;

  if b_somentePesquisa then
  begin
    sbAdicionar.Visible := False;
    sbRemover.Visible := False;
    sbAlterar.Visible := False;
  end;
  procHeightTree;
end;

procedure TpCCusto.procAbreTelaManutencao(i_ccusto: integer);
var i_centroCusto : integer;
begin
  dmFinanc.CCusto.Close;
  dmFinanc.CCusto.SQL.Text := SQL_CCUSTO+
                                 'WHERE A.ID_CCUSTO = :CCUSTO';
  dmFinanc.CCusto.ParamByName('CCUSTO').AsInteger := i_ccusto;
  dmFinanc.CCusto.Open;

  if i_ccusto = 0 then
  begin
    dmFinanc.CCusto.Append;

    if dmFinanc.PesCCustoID_CCUSTO.AsInteger > 0 then
      dmFinanc.CCustoID_CCPAI.AsInteger := dmFinanc.PesCCustoID_CCUSTO.AsInteger;
  end
  else
    dmFinanc.CCusto.Edit;

  i_centroCusto := dmFinanc.CCustoID_CCUSTO.AsInteger;
  TcCCusto.b_funcAbreTela(Self,b_finaliza);

  procRecupera;
  q_Principal.Locate('ID_CCUSTO',i_centroCusto,[loCaseInsensitive]);
  procMontaArvoreCCusto;
  procHabilitaBotoes;
end;

procedure TpCCusto.procExcluirCCustoEAfins;
  procedure procErroAoDeletar(c_msgErro : string);
  begin
    if b_finaliza and dmFinanc.tdb.InTransaction then
      dmFinanc.tdb.Rollback;
    procMsgErro('Não foi possível excluir o registro.'+sLineBreak+sLineBreak+
                'Causa: '+c_msgErro);
  end;

begin
  if not funcMsgConfirma('Deseja remover o Centro de Custos selecionado, seus Centros de Custos filhos e seus movimentos?') then
    Exit;

  try
    procExecSql(Format('DELETE FROM CCUSTO A'+
                       ' WHERE A.ID_CCUSTO = %s',
                       [dmFinanc.PesCCustoID_CCUSTO.AsString]),False);

    if b_finaliza and dmFinanc.tdb.InTransaction then
      dmFinanc.tdb.Commit;
  except
     on e : EDatabaseError do
     begin
       if(pos('lock',e.Message) > 0) then
         procErroAoDeletar('Existem Centros de Custos/Movimentos vinculados à este Centro de Custo que estão sendo editados por outro usuário.')

       else if (pos('FOREIGN',e.Message) > 0) then
         procErroAoDeletar('Centro de Custos possui relacionamentos.')

       else
         procErroAoDeletar(e.Message);
     end;

    on e: Exception do
        procErroAoDeletar(e.Message);
  end;

  procRecupera;
  procHabilitaBotoes;
  procMontaArvoreCCusto;
end;

procedure TpCCusto.procMontaArvoreCCusto;
var i_index : integer;

  procedure procNovoCCusto(i_ccusto : integer; s_ccusto : string; i_ccpai : integer);
  begin
    Ccusto := TCCusto.Create;
    CCusto.idCCusto  := i_ccusto;
    CCusto.dsCCusto  := s_ccusto;
    CCusto.idCCPai   := i_ccpai
  end;

  procedure procPopulaCCusto(no : TTreeNode; i_ccusto : integer);
  var q : TIBQuery;
  begin
    procCriarQuery(
       q,Format(SQL_CCUSTO+
       ' WHERE A.CD_USUARIO = ''%s'' '+
       ' AND A.ID_CCPAI %s ',
       [CD_USUARIO_LOGADO,
       IIF(i_ccusto > 0,'= '+intToStr(i_ccusto),'IS NULL')]));

    try
      q.Open;
      while not q.Eof do
      begin
        procNovoCCusto(
           q.FieldByName('ID_CCUSTO').AsInteger,
           q.FieldByName('DS_CCUSTO').AsString,
           q.FieldByName('ID_CCPAI').AsInteger);

        Tree.Items.AddChildObject(
           no,CCusto.dsCCusto,CCusto);

        Inc(i_index);

        procPopulaCCusto(
           Tree.Items[i_index],
           TCCusto(Tree.Items[i_index].Data).idCCusto);

          if not dmFinanc.PesCCusto.Locate(
             'ID_CCUSTO',TCCusto(Tree.Items[i_index].Data).idCCusto,
             [loCaseInsensitive]) then
          begin
            TCCusto(Tree.Items[i_index].Data).Free;
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

  procPopulaCCusto(nil,0);

  if Tree.CanFocus then
    Tree.SetFocus
end;

procedure TpCCusto.procMontaWhere;
begin
  inherited;
  s_Where := SQL_CCUSTO +
             ' WHERE A.CD_USUARIO = '+QuotedStr(CD_USUARIO_LOGADO);

  if edCodigo.Text <> EmptyStr then
    s_Where := funcAddCondSql(s_Where, 'A.ID_CCUSTO = ' + edCodigo.Text);

  if edNome.Text <> EmptyStr then
    s_Where := funcAddCondSql(s_Where, 'A.DS_CCUSTO LIKE ' + QuotedStr('%'+edNome.Text+'%'));

  case rgAtivo.ItemIndex of
    0 : s_Where := funcAddCondSql(s_Where, 'A.FL_ATIVO = ''A''');
    1 : s_Where := funcAddCondSql(s_Where, 'A.FL_ATIVO = ''I''');
  end;
end;

procedure TpCCusto.procRecupera;
begin
  inherited;
  procMontaArvoreCCusto;
end;

procedure TpCCusto.procRemoveItens;
var
  i: Integer;
begin
  for i := 0 to Tree.Items.Count - 1 do
  begin
    TCCusto(Tree.Items[i].Data).Free;
  end;
end;

procedure TpCCusto.RestaurarConfiguraodaGrade1Click(Sender: TObject);
begin
  inherited;
  DeleteFile(funcCaminhoConf+Self.Name+'Out'+'_'+CD_USUARIO_LOGADO);
end;

procedure TpCCusto.SalvarConfiguraodaGrade1Click(Sender: TObject);
begin
  inherited;
  uLib.procValorArqInf(funcCaminhoConf+Self.Name+'Out'+'_'+CD_USUARIO_LOGADO,'<tree_width>',IntToStr(Tree.Width));
end;

procedure TpCCusto.sbAdicionarClick(Sender: TObject);
begin
  if not sbAdicionar.Enabled then
    Exit;

  procAbreTelaManutencao(0);
end;

procedure TpCCusto.sbAlterarClick(Sender: TObject);
begin
  if not sbAlterar.Enabled then
    Exit;

  procAbreTelaManutencao(dmFinanc.PesCCustoID_CCUSTO.AsInteger);
end;

procedure TpCCusto.sbRemoverClick(Sender: TObject);
begin
  if not sbRemover.Enabled then
    Exit;

  procExcluirCCustoEAfins;
end;

procedure TpCCusto.TreeChange(Sender: TObject; Node: TTreeNode);
begin
  inherited;
  if dmFinanc.PesCCUsto.State <> dsInactive then
    dmFinanc.PesCCUsto.Locate('ID_CCUSTO',TCCusto(Tree.Selected.Data).idCCusto,[loCaseInsensitive])
end;

end.
