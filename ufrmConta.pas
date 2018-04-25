unit ufrmConta;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, IBX.IBQuery, uLib, uConst, upConta, udmFinanc,
  Data.DB;

type
  TfrmConta = class(TFrame)
    edCodigo: TEdit;
    edDescricao: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    procedure edCodigoExit(Sender: TObject);
  private
    { Private declarations }
    function getConta: integer;
    procedure setConta(const Value: integer);
    function b_funcRecuperaConta : boolean;
  public
    { Public declarations }
    property Conta : integer read getConta write setConta;
  end;

implementation

{$R *.dfm}

{ TfrmConta }

{ TfrmConta }

function TfrmConta.b_funcRecuperaConta: boolean;
var q : TIBQuery;
begin
  procCriarQuery(q);
  try
    q.SQL.Text := 'SELECT A.DS_CONTA             '+
                  '  FROM CONTA A                '+
                  ' WHERE A.ID_CONTA = :CONTA    '+
                  '   AND A.CD_USUARIO = :USUARIO';

    q.ParamByName('CONTA').AsInteger  := Conta;
    q.ParamByName('USUARIO').AsString := CD_USUARIO_LOGADO;
    q.Open;

    edDescricao.Text := q.FieldByName('DS_CONTA').AsString;
    Result           := not q.IsEmpty;
  finally
    FreeAndNil(q);
  end;
end;

procedure TfrmConta.edCodigoExit(Sender: TObject);
  procedure procPesquisaConta;
  begin
    TpConta.funcAbreTela(Self,True,False);
    if not dmFinanc.Conta.IsEmpty then
    begin
      edCodigo.Text    := dmFinanc.ContaID_CONTA.AsString;
      edDescricao.Text := dmFinanc.ContaDS_CONTA.AsString;
    end;
    if edCodigo.CanFocus then
      edCodigo.SetFocus;
  end;
begin
  edDescricao.Text := EmptyStr;
  if Trim(edCodigo.Text) = EmptyStr then
    Exit;

  if not b_funcRecuperaConta then
    procPesquisaConta;
end;

function TfrmConta.getConta: integer;
begin
  Result := StrToIntDef(edCodigo.Text,0);
end;

procedure TfrmConta.setConta(const Value: integer);
begin
  edCodigo.Text := IntToStr(Value);
  if not b_funcRecuperaConta then
    edCodigo.Clear;
end;

end.
