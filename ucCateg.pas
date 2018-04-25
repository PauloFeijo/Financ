unit ucCateg;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, udmFinanc, uCadPadrao, StdCtrls, Mask, DBCtrls, Buttons, ExtCtrls,
  uLib, uConst, IBX.IBQuery, Data.DB;

type
  TcCateg = class(TcCadPadrao)
    Label1: TLabel;
    DBE_ID_CATEG: TDBEdit;
    Label3: TLabel;
    DBE_ID_CATPAI: TDBEdit;
    Label4: TLabel;
    DBE_DS_CATEG: TDBEdit;
    edDsCatPai: TEdit;
    dbRgAtivo: TDBRadioGroup;
    procedure FormShow(Sender: TObject);
    procedure DBE_ID_CATPAIExit(Sender: TObject);
  private
    { Private declarations }
    function b_funcRecuperaCategoria : boolean;
  public
    { Public declarations }
    class function b_funcAbreTela(c_pai : TComponent; b_final:boolean=true):boolean;
    function b_funcValidaCampos: boolean;override;
  end;

var
  cCateg: TcCateg;

implementation

uses upCateg;

{$R *.dfm}

class function TcCateg.b_funcAbreTela(c_pai: TComponent; b_final: boolean): boolean;
begin

  cCateg := TcCateg.Create(c_pai);
  try
    cCateg.b_finaliza:= b_final;
    cCateg.ShowModal;
  finally
    FreeAndNil(cCateg);
  end;
  result := true;
end;

function TcCateg.b_funcRecuperaCategoria: boolean;
var q : TIBQuery;
begin
  procCriarQuery(q);
  try
    q.SQL.Text := 'SELECT A.DS_CATEG, A.FL_TIPO  '+
                  '  FROM CATEGORIA A            '+
                  ' WHERE A.ID_CATEG = :CATEG    '+
                  '   AND A.CD_USUARIO = :USUARIO';

    q.ParamByName('CATEG').AsInteger := dmFinanc.CategoriaID_CATPAI.AsInteger;
    q.ParamByName('USUARIO').AsString := CD_USUARIO_LOGADO;
    q.Open;
    edDsCatPai.Text := q.FieldByName('DS_CATEG').AsString;
    dmFinanc.CategoriaFL_TIPO.AsString := q.FieldByName('FL_TIPO').AsString;
    Result := not q.IsEmpty;
  finally
    FreeAndNil(q);
  end;
end;

function TcCateg.b_funcValidaCampos: boolean;
begin
  Result := inherited;

  if Result then
  begin
    Result := not dmFinanc.b_funcTemCategHierarquia(
                  dmFinanc.CategoriaID_CATEG.AsInteger,
                  dmFinanc.CategoriaID_CATPAI.AsInteger);
    if not Result then
      procMsgErro('Categoria '+dmFinanc.CategoriaID_CATPAI.AsString+
                  ' não pode ser adicionada como Categoria Pai pois faz parte '+
                  'da Hierarquia da Categoria '+dmFinanc.CategoriaID_CATEG.AsString+'.');
  end;
end;

procedure TcCateg.DBE_ID_CATPAIExit(Sender: TObject);
  procedure procPesquisaCategoria;
  begin
    TpCateg.funcAbreTela(Self,True,False);
    if not dmFinanc.PesCategoria.IsEmpty then
    begin
      dmFinanc.CategoriaID_CATPAI.AsInteger := dmFinanc.PesCategoriaID_CATEG.AsInteger;
      dmFinanc.CategoriaFL_TIPO.AsString    := dmFinanc.PesCategoriaFL_TIPO.AsString;
    end;
    if DBE_ID_CATPAI.CanFocus then
      DBE_ID_CATPAI.SetFocus;
  end;
begin
  inherited;
  edDsCatPai.Text := EmptyStr;
  if not b_funcRecuperaCategoria then
    procPesquisaCategoria;
end;

procedure TcCateg.FormShow(Sender: TObject);
begin
  inherited;
  procDesabilitaCampos(DBE_ID_CATEG);
  b_funcRecuperaCategoria;
end;

initialization
RegisterClass(TcCateg);

finalization
UnRegisterClass(TcCateg);
end.
