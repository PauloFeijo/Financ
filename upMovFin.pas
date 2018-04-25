unit upMovFin;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, udmFinanc, uPesqPadrao, ComCtrls, StdCtrls, Grids, DBGrids,
  Buttons, ExtCtrls, uLib, ufrmPeriodo,uConst, Menus,DB,
  ufrmCateg, ufrmConta, DateUtils, udmRelatorio, VclTee.TeeGDIPlus,
  VCLTee.TeEngine, VCLTee.TeeProcs, VCLTee.Chart, ufrmCCusto;

type
  TpMovFin = class(TpPesqPadrao)
    frmPeriodo1: TfrmPeriodo;
    edCdMov: TEdit;
    Label1: TLabel;
    frmCateg1: TfrmCateg;
    frmConta1: TfrmConta;
    cbTransf: TCheckBox;
    pnTotal: TPanel;
    edResult: TEdit;
    Label2: TLabel;
    edDespesa: TEdit;
    Label3: TLabel;
    edReceita: TEdit;
    Label4: TLabel;
    frmCCusto1: TfrmCCusto;
    edDescricao: TEdit;
    Label5: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure sbRelatorioClick(Sender: TObject);
    procedure dbgPesqDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
  private
    { Private declarations }
    procedure procCalculaValores;
  public
    { Public declarations }
    procedure procMontaWhere;override;
    procedure procRecupera;override;
  end;

var
  pMovFin: TpMovFin;

implementation

{$R *.dfm}

procedure TpMovFin.dbgPesqDrawColumnCell(Sender: TObject; const Rect: TRect;
  DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
  inherited;

  if (dmFinanc.MovimentoFL_TIPO.AsString = 'R') and
     (column.FieldName = 'VL_MOVIM') then
      dbgPesq.Canvas.Font.Color := clRed;

  dbgPesq.Canvas.FillRect(Rect);
  dbgPesq.DefaultDrawColumnCell(Rect, DataCol, Column, State);
end;

procedure TpMovFin.FormCreate(Sender: TObject);
begin
  inherited;
  s_filho  := 'TcMovFin';
  frmPeriodo1.dtIni := DateUtils.StartOfTheMonth(funcHoje);
  frmPeriodo1.dtFin := DateUtils.EndOfTheMonth(frmPeriodo1.dtIni);
end;

procedure TpMovFin.procCalculaValores;
var i_no : integer;
    f_receita, f_despesa: double;
begin
  f_receita := 0;
  f_despesa := 0;

  if not dmFinanc.Movimento.IsEmpty  then
  begin
    i_no := q_principal.RecNo;
    dmFinanc.Movimento.DisableControls;
    dmFinanc.Movimento.First;
    try
      while not dmFinanc.Movimento.Eof do
      begin
        if dmFinanc.MovimentoFL_TIPO.AsString = 'R' then
          f_despesa := f_despesa + dmFinanc.MovimentoVL_MOVIM.AsFloat
        else
          f_receita := f_receita + dmFinanc.MovimentoVL_MOVIM.AsFloat;
        dmFinanc.Movimento.Next;
      end;
    finally
      q_principal.RecNo := i_no;
      dmFinanc.Movimento.EnableControls;
    end;
  end;

  edReceita.Text := FormatFloat('###,###,##0.00',f_receita);
  edDespesa.Text := FormatFloat('###,###,##0.00',f_despesa);
  edResult.Text  := FormatFloat('###,###,##0.00',f_receita + f_despesa);
end;

procedure TpMovFin.procMontaWhere;
begin
  inherited;
    s_Where := SQL_MOVIMENTO +
    ' WHERE A.CD_USUARIO = '+QuotedStr(CD_USUARIO_LOGADO);

  if edCdMov.Text <> EmptyStr then
    s_Where := funcAddCondSql(s_Where, 'A.ID_MOVIM = ' + edCdMov.Text);

  if frmPeriodo1.dtIni <> 0 then
    s_Where := funcAddCondSql(s_Where, 'A.DT_MOVIM >= ' + frmPeriodo1.dtIniSql);

  if frmPeriodo1.dtFin <> 0 then
    s_Where := funcAddCondSql(s_Where, 'A.DT_MOVIM <= ' + frmPeriodo1.dtFinSql);

  if frmCateg1.Categoria > 0 then
    s_Where := funcAddCondSql(s_Where, 'A.ID_CATEG IN(' + dmFinanc.funcListaCategoria(frmCateg1.Categoria)+')');

  if frmCCusto1.CCusto > 0 then
    s_Where := funcAddCondSql(s_Where, 'A.ID_CCUSTO IN(' + dmFinanc.funcListaCCusto(frmCCusto1.CCusto)+')');

  if frmConta1.Conta > 0 then
    s_Where := funcAddCondSql(s_Where, 'A.ID_CONTA = ' + intToStr(frmConta1.Conta));

  if Trim(edDescricao.Text) <> EmptyStr then
    s_Where := funcAddCondSql(s_Where, 'A.DS_MOVIM LIKE ' + QuotedStr('%'+Trim(edDescricao.Text)+'%'));

  if not cbTransf.Checked then
    s_Where := funcAddCondSql(s_Where, 'NOT EXISTS (SELECT 1 FROM TRANSFERENCIA G                                          '+
                                         '                     WHERE (G.ID_MOVDEB = A.ID_MOVIM) OR (G.ID_MOVCRE = A.ID_MOVIM))');
end;

procedure TpMovFin.procRecupera;
begin
  inherited;
  procCalculaValores;
end;

procedure TpMovFin.sbRelatorioClick(Sender: TObject);
begin
  inherited;
  dmRelatorio.b_funcMostraRelatorio('relMovimento.fr3');
end;

end.
