unit urAnual;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ufrmConta, ufrmCateg, Buttons, ExtCtrls,
  udmFinanc, udmRelatorio, uLib, uConst, IBX.IBQuery, DB, Grids,
  DBGrids, DBCtrls, DBClient, DateUtils, ufrmCCusto, Vcl.Samples.Spin;

type
  TrAnual = class(TForm)
    paBotoes: TPanel;
    sbSair: TSpeedButton;
    sbRelatorio: TSpeedButton;
    pnFundo: TPanel;
    frmCateg1: TfrmCateg;
    frmConta1: TfrmConta;
    cbSubCateg: TCheckBox;
    cbTransf: TCheckBox;
    Label1: TLabel;
    frmCCusto1: TfrmCCusto;
    cbSubCCusto: TCheckBox;
    seAno: TSpinEdit;
    procedure sbRelatorioClick(Sender: TObject);
    procedure frmCateg1edCodigoExit(Sender: TObject);
    procedure sbSairClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
    procedure frmCCusto1edCodigoExit(Sender: TObject);
  private
    { Private declarations }
    procedure procPopulacdsAnual;
  public
    { Public declarations }
    class function b_funcAbreTela(c_pai: TComponent): boolean;
  end;

var
  rAnual: TrAnual;

implementation

{$R *.dfm}

class function TrAnual.b_funcAbreTela(c_pai: TComponent): boolean;
begin
  rAnual := TrAnual.Create(c_pai);
  try
    rAnual.ShowModal;
  finally
    FreeAndNil(rAnual);
  end;
  Result := True;
end;

procedure TrAnual.FormCreate(Sender: TObject);
begin
  seAno.Value := DateUtils.YearOf(funcHoje);
end;

procedure TrAnual.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case Key of
    VK_F6:
      sbRelatorio.Click;
    VK_ESCAPE:
      sbSair.Click;
  end;
end;

procedure TrAnual.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    Perform(WM_NEXTDLGCTL, 0, 0);
  end;
end;

procedure TrAnual.frmCateg1edCodigoExit(Sender: TObject);
begin
  frmCateg1.edCodigoExit(Sender);
  cbSubCateg.Enabled := frmCateg1.Categoria > 0;

  if not cbSubCateg.Enabled then
    cbSubCateg.Checked := True;

end;

procedure TrAnual.frmCCusto1edCodigoExit(Sender: TObject);
begin
  frmCCusto1.edCodigoExit(Sender);
  cbSubCCusto.Enabled := frmCCusto1.CCusto > 0;

  if not cbSubCCusto.Enabled then
    cbSubCCusto.Checked := True;
end;

procedure TrAnual.procPopulacdsAnual;
  function getDescri(i_nivel: integer): string;
  var
    i: integer;
  begin
    Result := EmptyStr;
    for i := 1 to i_nivel do
      Result := '...' + Result;
  end;

  procedure procAlimentaValores(i_categ: integer);
  var
    s_sql: string;
    i: integer;
  begin
    s_sql := 'SELECT COALESCE(SUM(A.VL_MOVIM),0)' +
      '  FROM MOVIMENTO A                ';

    if cbSubCateg.Checked then
      s_sql := funcAddCondSql(s_sql, ' A.ID_CATEG IN(' +
        dmFinanc.funcListaCategoria(i_categ) + ') ')
    else
      s_sql := funcAddCondSql(s_sql, ' A.ID_CATEG = ' + IntToStr(i_categ));

    if frmConta1.Conta > 0 then
      s_sql := funcAddCondSql(s_sql, ' A.ID_CONTA = ' +
        IntToStr(frmConta1.Conta));

     if frmCCusto1.CCusto > 0 then
     begin
       if cbSubCCusto.Checked then
         s_sql := s_sql +' AND A.ID_CCUSTO IN('+dmFinanc.funcListacCusto(frmCCusto1.CCusto)+')'
       else
         s_sql := s_sql +' AND A.ID_CCUSTO = '+IntToStr(frmCCusto1.CCusto);
     end;

    if not cbTransf.Checked then
      s_sql := funcAddCondSql(s_sql,
        'NOT EXISTS (SELECT 1 FROM TRANSFERENCIA G                                          '
        + '                     WHERE (G.ID_MOVDEB = A.ID_MOVIM) OR (G.ID_MOVCRE = A.ID_MOVIM))');

    for i := 1 to 12 do
    begin
      dmFinanc.cdsAnual.FieldByName('VL_M' + IntToStr(i)).AsFloat :=
        StrToFloatDef
        (funcSelect(s_sql +
        Format(' AND A.DT_MOVIM BETWEEN ''%s'' AND ''%s'' ',
        [FormatDateTime('dd.mm.yyyy', StrToDate('01/' + FormatFloat('00',
        i) + '/' + IntToStr(seAno.Value))), FormatDateTime('dd.mm.yyyy',
        DateUtils.EndOfTheMonth(StrToDate('01/' + FormatFloat('00',
        i) + '/' + IntToStr(seAno.Value))))])), 0);
    end;
  end;

  function funcSomaMeses: double;
  var
    i: integer;
  begin
    Result := 0;
    for i := 1 to 12 do
      Result := Result + dmFinanc.cdsAnual.FieldByName
        ('VL_M' + IntToStr(i)).AsFloat;
  end;

  procedure procPopulaCategoria(i_categ, i_nivel: integer;
    b_catPai: boolean = True);
  var
    q: TIBQuery;
  begin
    procCriarQuery(q, Format(SQL_CATEGORIA + ' WHERE A.CD_USUARIO = ''%s'' ' +
      '   AND  %s %s' + ' ORDER BY A.ID_CATEG', [CD_USUARIO_LOGADO,
      IIF(b_catPai, ' A.ID_CATPAI', ' A.ID_CATEG'), IIF(i_categ > 0,
      '= ' + IntToStr(i_categ), 'IS NULL')]));
    try
      q.Open;
      while not q.Eof do
      begin
        dmFinanc.cdsAnual.Append;
        procAlimentaValores(q.FieldByName('ID_CATEG').AsInteger);

        if funcSomaMeses <> 0 then
        begin
          dmFinanc.cdsAnualID_CATEG.AsInteger := q.FieldByName('ID_CATEG')
            .AsInteger;
          dmFinanc.cdsAnualCATEG.AsString := getDescri(i_nivel) +
            q.FieldByName('DS_CATEG').AsString;
          dmFinanc.cdsAnualFL_TIPO.AsString := q.FieldByName('FL_TIPO')
            .AsString;
          dmFinanc.cdsAnualNIVEL.AsInteger := i_nivel;
          dmFinanc.cdsAnualB_PAI.AsBoolean := (i_categ = 0) or not b_catPai;
          dmFinanc.cdsAnual.Post;

          if cbSubCateg.Checked then
            procPopulaCategoria(dmFinanc.cdsAnualID_CATEG.AsInteger,
              dmFinanc.cdsAnualNIVEL.AsInteger + 1);
        end
        else
          dmFinanc.cdsAnual.Cancel;

        q.Next;
      end;
    finally
      FreeAndNil(q);
    end;
  end;

begin
  procCriaLimpaCds(dmFinanc.cdsAnual);

  if frmCateg1.Categoria > 0 then
    procPopulaCategoria(frmCateg1.Categoria, 0, False)
  else
    procPopulaCategoria(0, 0);
end;

procedure TrAnual.sbRelatorioClick(Sender: TObject);
begin
  if seAno.Value <= 0 then
  begin
    procMsgErro('Informe um ano!');
    Exit;
  end;

  if not dmRelatorio.b_funcCarregaRelatorio('relAnual.fr3') then
    Exit;

  procPopulacdsAnual;

  if dmFinanc.cdsAnual.IsEmpty then
  begin
    procMsgInfo('Não há informacões para os filtros informados');
    Exit;
  end;

  dmRelatorio.Relatorio.ShowReport();
end;

procedure TrAnual.sbSairClick(Sender: TObject);
begin
  Close;
end;

end.
