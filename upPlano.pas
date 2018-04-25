unit upPlano;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uPesqPadrao, Vcl.Menus, Vcl.ComCtrls,
  Vcl.StdCtrls, Vcl.Grids, Vcl.DBGrids, Vcl.Buttons, Vcl.ExtCtrls, ufrmCateg,
  ufrmCCusto;

type
  TpPlano = class(TpPesqPadrao)
    pnTotal: TPanel;
    Label4: TLabel;
    edTotal: TEdit;
    frmCCusto1: TfrmCCusto;
    frmCateg1: TfrmCateg;
    Label5: TLabel;
    edDescricao: TEdit;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    procedure procTotal;
  public
    { Public declarations }
    procedure procMontaWhere;override;
    procedure procRecupera;override;
  end;

var
  pPlano: TpPlano;

implementation

{$R *.dfm}

uses udmFinanc, uLib, uConst;

procedure TpPlano.FormCreate(Sender: TObject);
begin
  inherited;
  s_filho  := 'TcPlano';
end;

procedure TpPlano.procMontaWhere;
begin
  inherited;

  s_Where := SQL_PLANO +
             ' WHERE A.CD_USUARIO = '+QuotedStr(CD_USUARIO_LOGADO);

  if frmCateg1.Categoria > 0 then
    s_Where := funcAddCondSql(s_Where, 'A.ID_CATEG IN(' + dmFinanc.funcListaCategoria(frmCateg1.Categoria)+')');

  if frmCCusto1.CCusto > 0 then
    s_Where := funcAddCondSql(s_Where, 'A.ID_CCUSTO IN(' + dmFinanc.funcListaCCusto(frmCCusto1.CCusto)+')');

  if Trim(edDescricao.Text) <> EmptyStr then
    s_Where := funcAddCondSql(s_Where, 'A.DS_PLANO LIKE ' + QuotedStr('%'+Trim(edDescricao.Text)+'%'));

end;

procedure TpPlano.procRecupera;
begin
  inherited;
  procTotal;
end;

procedure TpPlano.procTotal;
var f_total : double;
begin
  f_total := 0;

  dmFinanc.Plano.DisableControls;
  try
    dmFinanc.Plano.First;
    while not dmFinanc.Plano.Eof do
    begin
      f_total := f_total + dmFinanc.PlanoVL_VALOR.AsFloat;
      dmFinanc.Plano.Next;
    end;
    dmFinanc.Plano.First;
    edTotal.Text := FormatFloat('###,###,##0.00',f_total);
  finally
    dmFinanc.Plano.EnableControls;
  end;
end;

end.
