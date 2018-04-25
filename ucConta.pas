unit ucConta;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uCadPadrao, StdCtrls, Mask, DBCtrls, Buttons, ExtCtrls, Menus, DB,
  udmFinanc, JvExMask, JvToolEdit, JvBaseEdits, JvDBControls;

type
  TcConta = class(TcCadPadrao)
    Label1: TLabel;
    Label4: TLabel;
    DBE_DS_CONTA: TDBEdit;
    Label5: TLabel;
    Label6: TLabel;
    DBE_CD_CONTA: TDBEdit;
    DBE_VL_SALDO: TJvDBCalcEdit;
    dbRgAtivo: TDBRadioGroup;
    DBE_ID_CONTA: TDBEdit;
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    f_saldoInicial : double;
  public
    { Public declarations }
    procedure procAntesDoPost;override;
    procedure procDepoisDoPost;override;
  end;

var
  cConta: TcConta;

implementation

uses uLib;

{$R *.dfm}

procedure TcConta.FormShow(Sender: TObject);
begin
  inherited;
  procDesabilitaCampos(DBE_ID_CONTA);

  if dmFinanc.Conta.State = dsInsert then
    DBE_VL_SALDO.Color := corCampoRequerido
  else
    DBE_VL_SALDO.Enabled := False;
end;

procedure TcConta.procAntesDoPost;
begin
  inherited;
  f_saldoInicial := IIF(dmFinanc.Conta.State = dsInsert, dmFinanc.ContaVL_SALDO.AsFloat, 0);

  if (f_saldoInicial > 0) and (id_ccpad = 0) then
    raise Exception.Create(
       'Erro ao cadastrar Conta!'+sLineBreak+sLineBreak+
       'Descrição do erro: Conta cadastrada com saldo maior que zero e não há Centro de Custos Padrão.'+sLineBreak+sLineBreak+
       'Solução: Configure em contas do usuário, o Centro de Custos Padrão, ou cadastre a Conta com saldo 0 e gere um Movimento Financeiro manualmente.'
    );
end;

procedure TcConta.procDepoisDoPost;
begin
  inherited;
  if f_saldoInicial > 0 then
    dmFinanc.procCriaAtualizaMovimento(
      -1,dmFinanc.ContaID_CONTA.AsInteger,
      f_saldoInicial,
      'Deposito Inicial','D',
      dmFinanc.i_funcCategPadrao('R'),
      funcHoje, id_ccpad
    );
end;

initialization
RegisterClass(TcConta);

finalization
UnRegisterClass(TcConta);

end.
