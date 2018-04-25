unit ufrmCCusto;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, 
  Dialogs, StdCtrls, IBX.IBQuery, uLib, uConst, upCCusto, udmFinanc,
  Data.DB;

type
  TfrmCCusto = class(TFrame)
    edCodigo: TEdit;
    edDescricao: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    procedure edCodigoExit(Sender: TObject);
  private
    { Private declarations }
    function getCCusto: integer;
    procedure setCCusto(const Value: integer);
    function b_funcRecuperaCCusto : boolean;
  public
    { Public declarations }
    property CCusto : integer read getCCusto write setCCusto;
  end;

implementation

{$R *.dfm}

{ TfrmCCusto }
function TfrmCCusto.b_funcRecuperaCCusto: boolean;
var q : TIBQuery;
begin
  procCriarQuery(q);
  try
    q.SQL.Text := 'SELECT A.DS_CCUSTO            '+
                  '  FROM CCUSTO A               '+
                  ' WHERE A.ID_CCUSTO = :CCUSTO  '+
                  '   AND A.CD_USUARIO = :USUARIO';

    q.ParamByName('CCUSTO').AsInteger := CCusto;
    q.ParamByName('USUARIO').AsString := CD_USUARIO_LOGADO;
    q.Open;

    edDescricao.Text := q.FieldByName('DS_CCUSTO').AsString;
    Result           := not q.IsEmpty;
  finally
    FreeAndNil(q);
  end;
end;

procedure TfrmCCusto.edCodigoExit(Sender: TObject);
  procedure procPesquisaCCusto;
  begin
    TpCCusto.funcAbreTela(Self,True,False);
    if not dmFinanc.PesCCusto.IsEmpty then
    begin
      edCodigo.Text    := dmFinanc.PesCCustoID_CCUSTO.AsString;
      edDescricao.Text := dmFinanc.PesCCustoDS_CCUSTO.AsString;
    end;
    if edCodigo.CanFocus then
      edCodigo.SetFocus;
  end;
begin
  edDescricao.Text := EmptyStr;
  if Trim(edCodigo.Text) = EmptyStr then
    Exit;

  if not b_funcRecuperaCCusto then
    procPesquisaCCusto;
end;

function TfrmCCusto.getCCusto: integer;
begin
  Result := StrToIntDef(edCodigo.Text,0);
end;

procedure TfrmCCusto.setCCusto(const Value: integer);
begin
  edCodigo.Text := IntToStr(Value);
  if not b_funcRecuperaCCusto then
    edCodigo.Clear;
end;

end.
