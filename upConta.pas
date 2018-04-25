unit upConta;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uPesqPadrao, StdCtrls, ComCtrls, Grids, DBGrids, Buttons, ExtCtrls,
  Menus;

type
  TpConta = class(TpPesqPadrao)
    edCodigo: TEdit;
    Label1: TLabel;
    edNome: TEdit;
    Label2: TLabel;
    edNrConta: TEdit;
    Label3: TLabel;
    pnTotal: TPanel;
    edTotal: TEdit;
    Label4: TLabel;
    rgAtivo: TRadioGroup;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    procedure procSaldoTotal;
  public
    { Public declarations }
    procedure procMontaWhere;override;
    procedure procRecupera;override;
  end;

var
  pConta: TpConta;

implementation

uses udmFinanc, uConst, uLib;

{$R *.dfm}

procedure TpConta.FormCreate(Sender: TObject);
begin
  inherited;
  s_filho := 'TcConta';
end;

procedure TpConta.FormShow(Sender: TObject);
begin
  inherited;
  procSaldoTotal;
end;

procedure TpConta.procMontaWhere;
begin
  inherited;
  s_Where := SQL_CONTA + ' WHERE A.CD_USUARIO = '+QuotedStr(CD_USUARIO_LOGADO);

  if edCodigo.Text <> EmptyStr then
    s_Where := funcAddCondSql(s_Where, 'A.ID_CONTA = ' + edCodigo.Text);

  if edNome.Text <> EmptyStr then
    s_Where := funcAddCondSql(s_Where, 'A.DS_CONTA ' + QuotedStr('%'+edNome.Text+'%'));

  if Trim(edNrConta.Text) <> EmptyStr then
    s_Where := funcAddCondSql(s_Where, 'A.NR_CONTA = ' + edNrConta.Text);

  case rgAtivo.ItemIndex of
    0 : s_Where := funcAddCondSql(s_Where, 'A.FL_ATIVO = ''A''');
    1 : s_Where := funcAddCondSql(s_Where, 'A.FL_ATIVO = ''I''');
  end;

end;

procedure TpConta.procRecupera;
begin
  inherited;
  procSaldoTotal;
end;

procedure TpConta.procSaldoTotal;
var f_total : double;
begin
  f_total := 0;

  dmFinanc.Conta.DisableControls;
  try
    dmFinanc.Conta.First;
    while not dmFinanc.Conta.Eof do
    begin
      f_total := f_total + dmFinanc.ContaVL_SALDO.AsFloat;
      dmFinanc.Conta.Next;
    end;
    dmFinanc.Conta.First;
    edTotal.Text := FormatFloat('###,###,##0.00',f_total);
  finally
    dmFinanc.Conta.EnableControls;
  end;
end;

end.
