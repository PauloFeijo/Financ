unit upBens;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uPesqPadrao, Vcl.StdCtrls, Vcl.Menus,
  Vcl.ComCtrls, Vcl.Grids, Vcl.DBGrids, Vcl.Buttons, Vcl.ExtCtrls, IBX.IBQuery,
  JvExExtCtrls, JvNetscapeSplitter, Data.DB;

type
  TpBens = class(TpPesqPadrao)
    edDescricao: TEdit;
    Label2: TLabel;
    pnTotal: TPanel;
    rgStatus: TRadioGroup;
    pnTotal2: TPanel;
    Label1: TLabel;
    edTotalAquisicao: TEdit;
    Label4: TLabel;
    edTotalAtual: TEdit;
    Label3: TLabel;
    edTotalContas: TEdit;
    edTotalGeral: TEdit;
    Label5: TLabel;
    split: TJvNetscapeSplitter;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    procedure procTotal;
  public
    { Public declarations }
    procedure procMontaWhere;override;
    procedure procRecupera;override;
  end;

var
  pBens: TpBens;

implementation

{$R *.dfm}

uses udmFinanc, uConst, ULib;

procedure TpBens.FormCreate(Sender: TObject);
begin
  inherited;
  s_filho  := 'TcBens';
end;

procedure TpBens.FormShow(Sender: TObject);
begin
  inherited;
  split.Maximized := True;
end;

procedure TpBens.procMontaWhere;
begin
  inherited;
  s_Where := 'SELECT * FROM BENS A ' +
             ' WHERE A.CD_USUARIO = '+QuotedStr(CD_USUARIO_LOGADO);

  if edDescricao.Text <> EmptyStr then
    s_Where := funcAddCondSql(s_Where, 'A.DS_BEM LIKE ''%'''+edDescricao.Text+'''%''');

  case rgStatus.ItemIndex of
    0 : s_Where := funcAddCondSql(s_Where, 'A.DT_VENDA IS NULL');
    1 : s_Where := funcAddCondSql(s_Where, 'A.DT_VENDA IS NOT NULL');
  end;
end;

procedure TpBens.procRecupera;
begin
  inherited;
  procTotal;
end;

procedure TpBens.procTotal;
var f_aquisicao, f_atual : double;
    Qry : TIBQuery;
begin
  f_aquisicao := 0;
  f_atual := 0;

  dmFinanc.Bens.DisableControls;
  try
    dmFinanc.Bens.First;
    while not dmFinanc.Bens.Eof do
    begin
      f_aquisicao := f_aquisicao + dmFinanc.BensVL_AQUISICAO.AsFloat;
      f_atual     := f_atual     + dmFinanc.BensVL_ATUAL.AsFloat;
      dmFinanc.Bens.Next;
    end;
    dmFinanc.Bens.First;
    edTotalAtual.Text     := FormatFloat('###,###,##0.00',f_atual);
    edTotalAquisicao.Text := FormatFloat('###,###,##0.00',f_aquisicao);
  finally
    dmFinanc.Bens.EnableControls;
  end;

  procCriarQuery(Qry,
     'SELECT SUM(A.VL_MOVIM) TOTAL '+
     '  FROM MOVIMENTO A '+
     ' WHERE A.CD_USUARIO = '+QuotedStr(CD_USUARIO_LOGADO));
  try
    Qry.Open;
    edTotalContas.Text := FormatFloat('###,###,##0.00',Qry.FieldByName('TOTAL').AsFloat);
    edTotalGeral.Text  := FormatFloat('###,###,##0.00',Qry.FieldByName('TOTAL').AsFloat + f_atual);
  finally
    FreeAndNil(Qry);
  end;
end;

end.
