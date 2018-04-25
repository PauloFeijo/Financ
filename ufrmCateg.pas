unit ufrmCateg;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, 
  Dialogs, StdCtrls, IBX.IBQuery, uLib, uConst, upCateg, udmFinanc,
  Data.DB;

type
  TfrmCateg = class(TFrame)
    edCodigo: TEdit;
    edDescricao: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    procedure edCodigoExit(Sender: TObject);
  private
    { Private declarations }
    s_tipo : string;
    function getCategoria: integer;
    procedure setCategoria(const Value: integer);
    function b_funcRecuperaCategoria : boolean;
    function getTipo: string;
  public
    { Public declarations }
    property Categoria : integer read getCategoria write setCategoria;
    property tipo : string read getTipo;
  end;

implementation

{$R *.dfm}

{ TfrmCateg }
function TfrmCateg.b_funcRecuperaCategoria: boolean;
var q : TIBQuery;
begin
  procCriarQuery(q);
  try
    q.SQL.Text := 'SELECT A.DS_CATEG, A.FL_TIPO  '+
                  '  FROM CATEGORIA A            '+
                  ' WHERE A.ID_CATEG = :CATEG    '+
                  '   AND A.CD_USUARIO = :USUARIO';

    q.ParamByName('CATEG').AsInteger  := Categoria;
    q.ParamByName('USUARIO').AsString := CD_USUARIO_LOGADO;
    q.Open;

    s_tipo           := q.FieldByName('FL_TIPO').AsString;
    edDescricao.Text := q.FieldByName('DS_CATEG').AsString;
    Result           := not q.IsEmpty;
  finally
    FreeAndNil(q);
  end;
end;

procedure TfrmCateg.edCodigoExit(Sender: TObject);
  procedure procPesquisaCategoria;
  begin
    TpCateg.funcAbreTela(Self,True,False);
    if not dmFinanc.PesCategoria.IsEmpty then
    begin
      edCodigo.Text    := dmFinanc.PesCategoriaID_CATEG.AsString;
      edDescricao.Text := dmFinanc.PesCategoriaDS_CATEG.AsString;
      s_tipo           := IIF(dmFinanc.PesCategoriaFL_TIPO.AsString = 'R','D','R');
    end;
    if edCodigo.CanFocus then
      edCodigo.SetFocus;
  end;
begin
  edDescricao.Text := EmptyStr;
  if Trim(edCodigo.Text) = EmptyStr then
    Exit;

  if not b_funcRecuperaCategoria then
    procPesquisaCategoria;
end;

function TfrmCateg.getCategoria: integer;
begin
  Result := StrToIntDef(edCodigo.Text,0);
end;

function TfrmCateg.getTipo: string;
begin
  Result := s_tipo;
end;

procedure TfrmCateg.setCategoria(const Value: integer);
begin
  edCodigo.Text := IntToStr(Value);
  if not b_funcRecuperaCategoria then
    edCodigo.Clear;
end;

end.
