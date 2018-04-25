unit urAnaliseCross;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ufrmConta, ufrmCateg, ufrmPeriodo, Buttons, ExtCtrls,
  udmFinanc, udmRelatorio, uProcedimentos, uConstante, IBQuery, DB, Grids,
  DBGrids, DBCtrls, DBClient, DateUtils;

type
  TrAnaliseCross = class(TForm)
    paBotoes: TPanel;
    sbSair: TSpeedButton;
    sbRelatorio: TSpeedButton;
    pnFundo: TPanel;
    frmPeriodo1: TfrmPeriodo;
    frmCateg1: TfrmCateg;
    frmConta1: TfrmConta;
    cbSubCateg: TCheckBox;
    cbTransf: TCheckBox;
    procedure sbRelatorioClick(Sender: TObject);
    procedure frmCateg1edCodigoExit(Sender: TObject);
    procedure sbSairClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    procedure procPopulaCdsAnalise;
  public
    { Public declarations }
    class function b_funcAbreTela(c_pai : TComponent):boolean;
  end;

var
  rAnaliseCross: TrAnaliseCross;

implementation

{$R *.dfm}

class function TrAnaliseCross.b_funcAbreTela(c_pai: TComponent): boolean;
begin
  rAnaliseCross := TrAnaliseCross.Create(c_pai);
  try
    rAnaliseCross.ShowModal;
  finally
    FreeAndNil(rAnaliseCross);
  end;
  Result := True;
end;

procedure TrAnaliseCross.FormCreate(Sender: TObject);
begin
  frmPeriodo1.dtIni := DateUtils.StartOfTheYear(d_funcHoje);
  frmPeriodo1.dtFin := DateUtils.EndOfTheYear(frmPeriodo1.dtIni);
end;

procedure TrAnaliseCross.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case Key of
    VK_F6:sbRelatorio.Click;
    VK_ESCAPE:sbSair.Click;
  end;
end;

procedure TrAnaliseCross.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if key = #13 then
  begin
    Key := #0;
    Perform(WM_NEXTDLGCTL,0,0);
  end;
end;

procedure TrAnaliseCross.frmCateg1edCodigoExit(Sender: TObject);
begin
  frmCateg1.edCodigoExit(Sender);
  cbSubCateg.Enabled := frmCateg1.Categoria > 0;

  if not cbSubCateg.Enabled then
    cbSubCateg.Checked := True;

end;

procedure TrAnaliseCross.procPopulaCdsAnalise;
var i_no : integer;
  function getDescri(i_nivel : integer) : string;
  var i: Integer;
  begin
    Result := EmptyStr;
    for i := 1 to i_nivel do
      Result := '...'+Result;
  end;

  function funcSqlValores(i_categ : integer) : string;
  var s_sql : string;
  begin
    s_sql := 'SELECT CAST(SUBSTRING(CAST(A.DT_MOVIM AS VARCHAR(10))'+
             '       FROM 1 FOR 8)||''01''AS DATE) DATA,           '+
             '       COALESCE(SUM(A.VL_MOVIM),0) VALOR             '+
             '  FROM MOVIMENTO A                                   ';

    if cbSubCateg.Checked then
      s_sql := s_funcAddCondSql(s_sql,' A.ID_CATEG IN('+dmFinanc.funcListaCategoria(i_categ)+') ')
    else
      s_sql := s_funcAddCondSql(s_sql,' A.ID_CATEG = '+IntToStr(i_categ));

    if frmPeriodo1.dtIniStr <> EmptyStr then
      s_sql := s_funcAddCondSql(s_sql,' A.DT_MOVIM >= '+frmPeriodo1.dtIniSql);

    if frmPeriodo1.dtFinStr <> EmptyStr then
      s_sql := s_funcAddCondSql(s_sql,' A.DT_MOVIM <= '+frmPeriodo1.dtFinSql);

    if frmConta1.Conta > 0 then
      s_sql := s_funcAddCondSql(s_sql,' A.ID_CONTA = '+intToStr(frmConta1.Conta));

    if not cbTransf.Checked then
      s_sql := s_funcAddCondSql(s_sql, 'NOT EXISTS (SELECT 1 FROM TRANSFERENCIA G                                           '+
                                       '                     WHERE (G.ID_MOVDEB = A.ID_MOVIM) OR (G.ID_MOVCRE = A.ID_MOVIM))');
    s_sql  := s_sql + ' GROUP BY 1 ';
    Result := s_sql;
  end;

  procedure procPopulaCategoria(i_categ, i_nivel : integer; b_catPai : boolean = True);
  var q, q2 : TIBQuery;
  begin
    procCriarQuery(q2);
    procCriarQuery(q,Format(SQL_CATEGORIA+
                            ' WHERE A.CD_USUARIO = ''%s'' '+
                            '   AND  %s %s'+
                            ' ORDER BY A.ID_CATEG',
                            [CD_USUARIO_LOGADO,
                            IIF(b_catPai,' A.ID_CATPAI',' A.ID_CATEG'),
                            IIF(i_categ > 0,'= '+intToStr(i_categ),'IS NULL')]));
    try

      q.Open;
      while not q.Eof do
      begin
        q2.Close;
        q2.SQL.Text := funcSqlValores(q.FieldByName('ID_CATEG').AsInteger);
        q2.Open;
        while not q2.Eof do
        begin
          if (dmFinanc.cdsAnalise.RecordCount > 1) and
             (dmFinanc.cdsAnalise.RecNo < dmFinanc.cdsAnalise.RecordCount) then
          begin
            dmFinanc.cdsAnalise.RecNo := dmFinanc.cdsAnalise.RecNo +1;
            dmFinanc.cdsAnalise.Insert;
          end
          else
             dmFinanc.cdsAnalise.Append;

          dmFinanc.cdsAnaliseID_CATEG.AsInteger := q.FieldByName('ID_CATEG').AsInteger;
          dmFinanc.cdsAnaliseCATEG.AsString     := getDescri(i_nivel) + q.FieldByName('DS_CATEG').AsString;
          dmFinanc.cdsAnaliseFL_TIPO.AsString   := q.FieldByName('FL_TIPO').AsString;
          dmFinanc.cdsAnaliseNIVEL.AsInteger    := i_nivel;
          dmFinanc.cdsAnaliseB_PAI.AsBoolean    := (i_categ = 0) or not b_catPai;
          dmFinanc.cdsAnaliseVALOR.AsFloat      := q2.FieldByName('VALOR').AsFloat;
          dmFinanc.cdsAnaliseDATA.AsDateTime    := q2.FieldByName('DATA').AsDateTime;
          dmFinanc.cdsAnalise.Post;

          q2.Next;
        end;

        q.Next;
      end;
    finally
      FreeAndNil(q);
      FreeAndNil(q2);
    end;
  end;
begin
  try
    dmFinanc.cdsAnalise.CreateDataSet;
  except
    dmFinanc.cdsAnalise.Destroy;
    dmFinanc.cdsAnalise.CreateDataSet;
    {dmFinanc.cdsAnalise.First;
    while not dmFinanc.cdsAnalise.Eof do
      dmFinanc.cdsAnalise.Delete;}
  end;

  dmFinanc.cdsAnalise.Open;

  if frmCateg1.Categoria > 0 then
    procPopulaCategoria(frmCateg1.Categoria,0,False)
  else
    procPopulaCategoria(0,0);

  if not cbSubCateg.Checked then
    Exit;

  i_no := 1;
  while true do
  begin
    dmFinanc.cdsAnalise.RecNo := i_no;
    procPopulaCategoria(dmFinanc.cdsAnaliseID_CATEG.AsInteger,
                        dmFinanc.cdsAnaliseNIVEL.AsInteger + 1);
    Inc(i_no);

    if i_no >  dmFinanc.cdsAnalise.RecordCount then
      Break;
  end;
end;

procedure TrAnaliseCross.sbRelatorioClick(Sender: TObject);
begin
  if not dmRelatorio.b_funcCarregaRelatorio('relAnaliseCross.fr3') then
    Exit;

   procPopulaCdsAnalise;

  dmRelatorio.Relatorio.ShowReport();
end;

procedure TrAnaliseCross.sbSairClick(Sender: TObject);
begin
  Close;
end;

end.
