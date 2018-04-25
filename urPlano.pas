unit urPlano;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Mask, Vcl.Buttons,
  Vcl.ExtCtrls, DateUtils, ufrmCCusto, ufrmConta, ufrmCateg;

type
  TrPlano = class(TForm)
    paBotoes: TPanel;
    sbSair: TSpeedButton;
    sbRelatorio: TSpeedButton;
    pnFundo: TPanel;
    frmCateg1: TfrmCateg;
    frmConta1: TfrmConta;
    frmCCusto1: TfrmCCusto;
    meDtIni: TMaskEdit;
    meDtFin: TMaskEdit;
    Label1: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure sbRelatorioClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure sbSairClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    class function b_funcAbreTela(c_pai : TComponent):boolean;
  end;

var
  rPlano: TrPlano;

implementation

{$R *.dfm}

uses uLib, udmRelatorio;

class function TrPlano.b_funcAbreTela(c_pai: TComponent): boolean;
begin
  rPlano := TrPlano.Create(c_pai);
  try
    rPlano.ShowModal;
  finally
    FreeAndNil(rPlano);
  end;
  Result := True;
end;

procedure TrPlano.FormCreate(Sender: TObject);
begin
   meDtIni.Text := formatDateTime('MM/YYYY',funcHoje);
   meDtFin.Text := meDtIni.Text;
end;

procedure TrPlano.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case Key of
    VK_F6:sbRelatorio.Click;
    VK_ESCAPE:sbSair.Click;
  end;
end;

procedure TrPlano.sbRelatorioClick(Sender: TObject);
begin
   procSairCampo(Self);
  if Trim(meDtini.Text) = '/' then
    procMsgAtencao('Favor informe um mes de referência inicial!');

  if Trim(meDtFin.Text) = '/' then
    procMsgAtencao('Favor informe um mes de referência final!');

  if not dmRelatorio.b_funcCarregaRelatorio('relPlano.fr3') then
    Exit;

  dmRelatorio.Relatorio.Variables['D_INI']      := strToDateTime('01/'+meDtini.Text);
  dmRelatorio.Relatorio.Variables['D_FIN']      := DateUtils.EndOfTheMonth(strToDateTime('01/'+meDtFin.Text));
  dmRelatorio.Relatorio.Variables['CD_USUARIO'] := QuotedStr(CD_USUARIO_LOGADO);
  dmRelatorio.Relatorio.Variables['I_CATEG']    := frmCateg1.Categoria;
  dmRelatorio.Relatorio.Variables['I_CCUSTO']   := frmCCusto1.CCusto;
  dmRelatorio.Relatorio.Variables['I_CONTA']    := frmConta1.Conta;
  dmRelatorio.Relatorio.ShowReport();
end;

procedure TrPlano.sbSairClick(Sender: TObject);
begin
  Close;
end;

end.
