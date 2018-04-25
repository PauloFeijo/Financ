unit upTransf;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, udmFinanc, uPesqPadrao, ComCtrls, StdCtrls, Grids, DBGrids, Buttons,
  ExtCtrls, uLib, ufrmPeriodo, uConst, DateUtils,
  ufrmConta, Menus;

type
  TpTransf = class(TpPesqPadrao)
    Label1: TLabel;
    frmPeriodo1: TfrmPeriodo;
    edCdTransf: TEdit;
    frmConta1: TfrmConta;
    Label5: TLabel;
    edDescricao: TEdit;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure procMontaWhere;override;
  end;

var
  pTransf: TpTransf;

implementation

{$R *.dfm}

procedure TpTransf.FormCreate(Sender: TObject);
begin
  inherited;
  s_filho  := 'TcTransf';
  frmPeriodo1.dtIni := DateUtils.StartOfTheMonth(funcHoje);
  frmPeriodo1.dtFin := DateUtils.EndOfTheMonth(frmPeriodo1.dtIni);
end;

procedure TpTransf.procMontaWhere;
begin
  inherited;
    s_Where := SQL_TRANSFERENCIA +
    ' WHERE A.CD_USUARIO = '+QuotedStr(CD_USUARIO_LOGADO);

  if edCdTransf.Text <> EmptyStr then
    s_Where := funcAddCondSql(s_Where, 'A.ID_TRANSFER = ' + edCdTransf.Text);

  if frmPeriodo1.dtIni <> 0 then
    s_Where := funcAddCondSql(s_Where, 'A.DT_TRANSF >= ' + frmPeriodo1.dtIniSql);

  if frmPeriodo1.dtFin <> 0 then
    s_Where := funcAddCondSql(s_Where, 'A.DT_TRANSF <= ' + frmPeriodo1.dtFinSql);

  if Trim(edDescricao.Text) <> EmptyStr then
    s_Where := funcAddCondSql(s_Where, 'A.DS_TRANSF LIKE ' + QuotedStr('%'+Trim(edDescricao.Text)+'%'));
end;

end.
