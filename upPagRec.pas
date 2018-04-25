unit upPagRec;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, udmFinanc, uPesqPadrao, Menus, ComCtrls, StdCtrls, Grids, DBGrids,
  Buttons, ExtCtrls, ufrmPeriodo, ufrmCateg, uLib, uConst,
  DB, ucMovFin, DateUtils, Math, udmRelatorio, Vcl.OleCtnrs;

type
  TpPagRec = class(TpPesqPadrao)
    edCod: TEdit;
    Label1: TLabel;
    frmCateg1: TfrmCateg;
    gbVencto: TGroupBox;
    frmPeriodo1: TfrmPeriodo;
    cbBaixados: TCheckBox;
    Panel1: TPanel;
    Splitter1: TSplitter;
    dbgMovimento: TDBGrid;
    ds: TDataSource;
    sbBaixar: TSpeedButton;
    pmMovim: TPopupMenu;
    EditarMovimento1: TMenuItem;
    edDescricao: TEdit;
    Label5: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure dsDataChange(Sender: TObject; Field: TField);
    procedure sbBaixarClick(Sender: TObject);
    procedure EditarMovimento1Click(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure SalvarConfiguraodaGrade1Click(Sender: TObject);
    procedure RestaurarConfiguraodaGrade1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure sbRelatorioClick(Sender: TObject);
    procedure dbgPesqDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
  private
    { Private declarations }
    d_hoje : TDate;
    procedure procAbreManutencaoMovimento;
  public
    { Public declarations }
    procedure procMontaWhere;override;
    procedure procHabilitaBotoes;override;
    class function funcAbreTela(pai : TComponent; b_pesquisa : boolean = false; b_final : boolean = true; b_alerta : boolean = False):boolean; overload;
  end;

var
  pPagRec: TpPagRec;

implementation

{$R *.dfm}

{ TpPagRec }

class function TpPagRec.funcAbreTela(pai: TComponent; b_pesquisa, b_final, b_alerta: boolean): boolean;
begin
  pPagRec := TpPagRec.Create(pai);
  try
    pPagRec.b_somentePesquisa := b_pesquisa;
    pPagRec.b_finaliza := b_final;

    if b_alerta then
    begin
      pPagRec.procRecupera;
      if not dmFinanc.PagarReceber.IsEmpty then
        pPagRec.ShowModal;
    end
    else
      pPagRec.ShowModal;
  finally
    FreeAndNil(pPagRec);
  end;
  result := true;
end;

procedure TpPagRec.dbgPesqDrawColumnCell(Sender: TObject; const Rect: TRect;
  DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
   {if (Column.Field = dmFinanc.PagarReceberDT_VENCTO) and
      (dmFinanc.PagarReceberDT_VENCTO.AsDateTime <= d_hoje) and
      (dmFinanc.PagarReceberVL_PAGO.AsFloat < dmFinanc.PagarReceberVL_VALOR.AsFloat) then
      TDBGrid(Sender).Canvas.Brush.color := clRed;}
   inherited;
end;

procedure TpPagRec.dsDataChange(Sender: TObject; Field: TField);
begin
  inherited;
  dmFinanc.Movimento.Close;
  dmFinanc.Movimento.SQL.Text := SQL_MOVIMENTO+
                                 ' WHERE A.ID_PAGRECEB = :PAGRECEB';
  dmFinanc.Movimento.ParamByName('PAGRECEB').AsInteger := dmFinanc.PagarReceberID_PAGRECEB.AsInteger;
  dmFinanc.Movimento.Open;
  EditarMovimento1.Visible := not dmFinanc.Movimento.IsEmpty;
end;

procedure TpPagRec.EditarMovimento1Click(Sender: TObject);
begin
  inherited;
  dmFinanc.Movimento.Edit;
  procAbreManutencaoMovimento;
end;

procedure TpPagRec.FormCreate(Sender: TObject);
begin
  inherited;
  s_filho := 'TcPagRec';
  frmPeriodo1.meDtIni.Clear;
  frmPeriodo1.dtFin := DateUtils.EndOfTheMonth(funcHoje);
end;

procedure TpPagRec.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  case Key of
    VK_F7:sbBaixar.Click;
  end;
end;

procedure TpPagRec.FormShow(Sender: TObject);
begin
  inherited;
  d_hoje := funcHoje;
  try
    dbgMovimento.Columns.LoadFromFile(funcCaminhoConf+Self.Name+'_'+CD_USUARIO_LOGADO+'2');
  Except
  end;
end;

procedure TpPagRec.procAbreManutencaoMovimento;
var i_mov : integer;
begin
  i_mov := dmFinanc.MovimentoID_MOVIM.AsInteger;
  procLocate(tlChave);

  TcMovFin.b_funcAbreTela(Self,True,False,False);

  procRecupera;
  procLocate(tlLocate);
  dmFinanc.Movimento.Locate('ID_MOVIM',i_mov,[loCaseInsensitive]);
end;

procedure TpPagRec.procHabilitaBotoes;
begin
  inherited;
  sbBaixar.Enabled := not dmFinanc.PagarReceber.IsEmpty;
end;

procedure TpPagRec.procMontaWhere;
begin
  inherited;
  s_Where := SQL_PAGAR_RECEBER +
             ' WHERE A.CD_USUARIO = '+QuotedStr(CD_USUARIO_LOGADO);

  if edCod.Text <> EmptyStr then
    s_Where := funcAddCondSql(s_Where, 'A.ID_PAGRECEB = ' + edCod.Text);

  if frmPeriodo1.dtIni <> 0 then
    s_Where := funcAddCondSql(s_Where, 'A.DT_VENCTO >= ' + frmPeriodo1.dtIniSql);

  if frmPeriodo1.dtFin <> 0 then
    s_Where := funcAddCondSql(s_Where, 'A.DT_VENCTO <= ' + frmPeriodo1.dtFinSql);

  if frmCateg1.Categoria > 0 then
    s_Where := funcAddCondSql(s_Where, 'A.ID_CATEG IN(' + dmFinanc.funcListaCategoria(frmCateg1.Categoria)+')');

  if Trim(edDescricao.Text) <> EmptyStr then
    s_Where := funcAddCondSql(s_Where, 'A.DS_DESCRI LIKE ' + QuotedStr('%'+Trim(edDescricao.Text)+'%'));

  if not cbBaixados.Checked then
    s_Where := funcAddCondSql(s_Where, ' A.VL_VALOR > '+
      '(SELECT COALESCE(SUM(                 '+
      '           IIF(B.FL_TIPO = ''R'',     '+
      '              -B.VL_MOVIM,            '+
      '               B.VL_MOVIM)+           '+
      '           B.VL_DESCON),0)            '+
      '   FROM MOVIMENTO B                   '+
      '  WHERE B.ID_PAGRECEB = A.ID_PAGRECEB)');
end;

procedure TpPagRec.RestaurarConfiguraodaGrade1Click(Sender: TObject);
begin
  inherited;
  try
    DeleteFile(funcCaminhoConf+Self.Name+'Grid2'+'_'+CD_USUARIO_LOGADO);
  except
  end;
  dbgMovimento.Columns.RebuildColumns;
end;

procedure TpPagRec.SalvarConfiguraodaGrade1Click(Sender: TObject);
begin
  inherited;
  dbgMovimento.Columns.SaveToFile(funcCaminhoConf+Self.Name+'Grid2'+'_'+CD_USUARIO_LOGADO);
end;

procedure TpPagRec.sbBaixarClick(Sender: TObject);
begin
  inherited;
   if not sbBaixar.Enabled then
      Exit;

  dmFinanc.Movimento.Append;
  dmFinanc.MovimentoVL_BRUTO.AsFloat      := dmFinanc.PagarReceberVL_VALOR.AsFloat - dmFinanc.PagarReceberVL_PAGO.AsFloat;
  dmFinanc.MovimentoDS_MOVIM.AsString     := dmFinanc.PagarReceberDS_DESCRI.AsString;
  dmFinanc.MovimentoFL_TIPO.AsString      := IIF(dmFinanc.PagarReceberFL_TIPO.AsString = 'R','D','R');
  dmFinanc.MovimentoID_CATEG.AsInteger    := dmFinanc.PagarReceberID_CATEG.AsInteger;
  dmFinanc.MovimentoDS_CATEG.AsString     := dmFinanc.PagarReceberDS_CATEG.AsString;
  dmFinanc.MovimentoID_PAGRECEB.AsInteger := dmFinanc.PagarReceberID_PAGRECEB.AsInteger;

  procAbreManutencaoMovimento;
end;

procedure TpPagRec.sbRelatorioClick(Sender: TObject);
begin
  inherited;
  dmRelatorio.b_funcMostraRelatorio('relPagarReceber.fr3');
end;

end.
