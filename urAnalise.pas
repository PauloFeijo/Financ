unit urAnalise;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ufrmConta, ufrmCateg, ufrmPeriodo, Buttons, ExtCtrls,
  udmFinanc, udmRelatorio, uLib, uConst, IBX.IBQuery, DB, Grids,
  DBGrids, DBCtrls, DBClient, DateUtils, ufrmCCusto;

type
  TrAnalise = class(TForm)
    paBotoes: TPanel;
    sbSair: TSpeedButton;
    sbRelatorio: TSpeedButton;
    pnFundo: TPanel;
    frmPeriodo1: TfrmPeriodo;
    frmCateg1: TfrmCateg;
    frmConta1: TfrmConta;
    cbSubCateg: TCheckBox;
    cbTransf: TCheckBox;
    frmCCusto1: TfrmCCusto;
    cbSubCCusto: TCheckBox;
    procedure sbRelatorioClick(Sender: TObject);
    procedure frmCateg1edCodigoExit(Sender: TObject);
    procedure sbSairClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
    procedure frmCCusto1edCodigoExit(Sender: TObject);
  private
    { Private declarations }
    procedure procPopulaCdsAnalise;
  public
    { Public declarations }
    class function b_funcAbreTela(c_pai : TComponent):boolean;
  end;

var
  rAnalise: TrAnalise;

implementation

{$R *.dfm}

class function TrAnalise.b_funcAbreTela(c_pai: TComponent): boolean;
begin
  rAnalise := TrAnalise.Create(c_pai);
  try
    rAnalise.ShowModal;
  finally
    FreeAndNil(rAnalise);
  end;
  Result := True;
end;

procedure TrAnalise.FormCreate(Sender: TObject);
begin
  frmPeriodo1.dtIni := DateUtils.StartOfTheMonth(funcHoje);
  frmPeriodo1.dtFin := DateUtils.EndOfTheMonth(frmPeriodo1.dtIni);
end;

procedure TrAnalise.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case Key of
    VK_F6:sbRelatorio.Click;
    VK_ESCAPE:sbSair.Click;
  end;
end;

procedure TrAnalise.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if key = #13 then
  begin
    Key := #0;
    Perform(WM_NEXTDLGCTL,0,0);
  end;
end;

procedure TrAnalise.frmCateg1edCodigoExit(Sender: TObject);
begin
  frmCateg1.edCodigoExit(Sender);
  cbSubCateg.Enabled := frmCateg1.Categoria > 0;

  if not cbSubCateg.Enabled then
    cbSubCateg.Checked := True;

end;

procedure TrAnalise.frmCCusto1edCodigoExit(Sender: TObject);
begin
  frmCCusto1.edCodigoExit(Sender);
  cbSubCCusto.Enabled := frmCCusto1.CCusto > 0;

  if not cbSubCCusto.Enabled then
    cbSubCCusto.Checked := True;
end;

procedure TrAnalise.procPopulaCdsAnalise;

  function getDescri(i_nivel : integer) : string;
  var i: Integer;
  begin
    Result := EmptyStr;
    for i := 1 to i_nivel do
      Result := '....'+Result;
  end;

  function funcValorMovimentado(i_categ : integer) : double;
  var s_sql : string;
  begin
    s_sql := 'SELECT COALESCE(SUM(A.VL_MOVIM),0)'+
             '  FROM MOVIMENTO A                ';

    if cbSubCateg.Checked then
      s_sql := funcAddCondSql(s_sql,' A.ID_CATEG IN('+dmFinanc.funcListaCategoria(i_categ)+') ')
    else
      s_sql := funcAddCondSql(s_sql,' A.ID_CATEG = '+IntToStr(i_categ));

    if frmCCusto1.CCusto > 0 then
    begin
      if cbSubCCusto.Checked then
        s_sql := funcAddCondSql(s_sql,' A.ID_CCUSTO IN('+dmFinanc.funcListacCusto(frmCCusto1.CCusto)+') ')
      else
        s_sql := funcAddCondSql(s_sql,' A.ID_CCUSTO = '+IntToStr(frmCCusto1.CCusto));
    end;

    if frmPeriodo1.dtIni <> 0 then
      s_sql := funcAddCondSql(s_sql,' A.DT_MOVIM >= '+frmPeriodo1.dtIniSql);

    if frmPeriodo1.dtFin <> 0 then
      s_sql := funcAddCondSql(s_sql,' A.DT_MOVIM <= '+frmPeriodo1.dtFinSql);

    if frmConta1.Conta > 0 then
      s_sql := funcAddCondSql(s_sql,' A.ID_CONTA = '+intToStr(frmConta1.Conta));

    if not cbTransf.Checked then
      s_sql := funcAddCondSql(s_sql,
         'NOT EXISTS (SELECT 1 FROM TRANSFERENCIA G                          '+
         '    WHERE (G.ID_MOVDEB = A.ID_MOVIM) OR (G.ID_MOVCRE = A.ID_MOVIM))');

    Result := StrToFloatDef(funcSelect(s_sql),0);
  end;

  procedure procPopulaCategoria(i_categ, i_nivel : integer; b_catPai : boolean = True);
  var q : TIBQuery;
      f_valor : double;
  begin
    procCriarQuery(
       q,Format(SQL_CATEGORIA+
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
        f_valor := funcValorMovimentado(q.FieldByName('ID_CATEG').AsInteger);

        if f_valor <> 0 then
        begin
          dmFinanc.cdsAnalise.Append;
          dmFinanc.cdsAnaliseID_CATEG.AsInteger := q.FieldByName('ID_CATEG').AsInteger;
          dmFinanc.cdsAnaliseCATEG.AsString     := getDescri(i_nivel) + q.FieldByName('DS_CATEG').AsString;
          dmFinanc.cdsAnaliseFL_TIPO.AsString   := q.FieldByName('FL_TIPO').AsString;
          dmFinanc.cdsAnaliseNIVEL.AsInteger    := i_nivel;
          dmFinanc.cdsAnaliseB_PAI.AsBoolean    := (i_categ = 0) or not b_catPai;
          dmFinanc.cdsAnaliseVALOR.AsFloat      := f_valor;
          dmFinanc.cdsAnalise.Post;

          if cbSubCateg.Checked then
             procPopulaCategoria(dmFinanc.cdsAnaliseID_CATEG.AsInteger,
                                 dmFinanc.cdsAnaliseNIVEL.AsInteger + 1);
        end;

        q.Next;
      end;
    finally
      FreeAndNil(q);
    end;
  end;

begin
  procCriaLimpaCds(dmFinanc.cdsAnalise);

  if frmCateg1.Categoria > 0 then
    procPopulaCategoria(frmCateg1.Categoria, 0, False)
  else
    procPopulaCategoria(0,0);
end;

procedure TrAnalise.sbRelatorioClick(Sender: TObject);
  function getSelect(s_tipo : string) : string;
  var s_where : string;
  begin
     s_where := EmptyStr;

     if frmCateg1.Categoria > 0 then
     begin
       if cbSubCateg.Checked then
          s_where := s_where +' AND A.ID_CATEG IN('+dmFinanc.funcListaCategoria(frmCateg1.Categoria)+')'
        else
          s_where := s_where + ' AND A.ID_CATEG = '+IntToStr(frmCateg1.Categoria);
     end;

     if frmCCusto1.CCusto > 0 then
     begin
       if cbSubCCusto.Checked then
         s_where := s_where +' AND A.ID_CCUSTO IN('+dmFinanc.funcListacCusto(frmCCusto1.CCusto)+')'
       else
         s_where := s_where +' AND A.ID_CCUSTO = '+IntToStr(frmCCusto1.CCusto);
     end;

     if frmPeriodo1.dtIni <> 0 then
      s_where := s_where + ' AND A.DT_MOVIM >= '+frmPeriodo1.dtIniSql;

     if frmPeriodo1.dtFin <> 0 then
        s_where := s_where + ' AND A.DT_MOVIM <= '+frmPeriodo1.dtFinSql;

     if frmConta1.Conta > 0 then
        s_where := s_where + ' AND A.ID_CONTA = '+intToStr(frmConta1.Conta);

     Result :=  'SELECT A.ID_CATEG,                                   '+
                '       B.DS_CATEG,                                   '+
                '       SUM(A.VL_MOVIM) VLR                           '+
                '  FROM MOVIMENTO A                                   '+
                ' INNER JOIN CATEGORIA B ON B.ID_CATEG = A.ID_CATEG   '+
                ' WHERE A.FL_TIPO = '+ QuotedStr(s_tipo)+
                '   AND A.CD_USUARIO = '+QuotedStr(CD_USUARIO_LOGADO)+
                '   AND NOT EXISTS(SELECT 1 FROM TRANSFERENCIA C      '+
                '                   WHERE (C.ID_MOVDEB = A.ID_MOVIM OR'+
                '                          C.ID_MOVCRE = A.ID_MOVIM)) '+
                '     '+s_where+ '                                    '+
                'GROUP BY 1,2                                         ';

  end;

  function getSelectBarra : string;
  var s_where : string;
  begin
     s_where := EmptyStr;

     if frmCateg1.Categoria > 0 then
     begin
       if cbSubCateg.Checked then
          s_where := s_where +' AND A.ID_CATEG IN('+dmFinanc.funcListaCategoria(frmCateg1.Categoria)+')'
        else
          s_where := s_where + ' AND A.ID_CATEG = '+IntToStr(frmCateg1.Categoria);
     end;

     if frmCCusto1.CCusto > 0 then
     begin
       if cbSubCCusto.Checked then
         s_where := s_where +' AND A.ID_CCUSTO IN('+dmFinanc.funcListacCusto(frmCCusto1.CCusto)+')'
       else
         s_where := s_where +' AND A.ID_CCUSTO = '+IntToStr(frmCCusto1.CCusto);
     end;

     if frmPeriodo1.dtIni <> 0 then
      s_where := s_where + ' AND A.DT_MOVIM >= '+frmPeriodo1.dtIniSql;

     if frmPeriodo1.dtFin <> 0 then
        s_where := s_where + ' AND A.DT_MOVIM <= '+frmPeriodo1.dtFinSql;

     if frmConta1.Conta > 0 then
        s_where := s_where + ' AND A.ID_CONTA = '+intToStr(frmConta1.Conta);

     Result :=  ' SELECT * FROM( '+
                ' SELECT 1 ID, '+
                '        ''Depósitos'' DS_TIPO, '+
                '        SUM(A.VL_MOVIM) VL_VALOR '+
                '   FROM MOVIMENTO A '+
                ' WHERE A.FL_TIPO = ''D'' '+
                '   AND NOT EXISTS(SELECT 1 FROM TRANSFERENCIA C      '+
                '                   WHERE (C.ID_MOVDEB = A.ID_MOVIM OR'+
                '                          C.ID_MOVCRE = A.ID_MOVIM)) '+
                 s_where+
                ' UNION '+
                ' SELECT 2 ID, '+
                '        ''Retiradas'' DS_TIPO, '+
                '        SUM(A.VL_MOVIM) *-1 VL_VALOR '+
                '   FROM MOVIMENTO A '+
                ' WHERE A.FL_TIPO = ''R'' '+
                '   AND NOT EXISTS(SELECT 1 FROM TRANSFERENCIA C      '+
                '                   WHERE (C.ID_MOVDEB = A.ID_MOVIM OR'+
                '                          C.ID_MOVCRE = A.ID_MOVIM)) '+
                s_where+
                ' UNION '+
                ' SELECT 3 ID, '+
                '        ''Posição'' DS_TIPO, '+
                '        SUM(A.VL_MOVIM) VL_VALOR '+
                '   FROM MOVIMENTO A '+
                '  WHERE NOT EXISTS(SELECT 1 FROM TRANSFERENCIA C     '+
                '                   WHERE (C.ID_MOVDEB = A.ID_MOVIM OR'+
                '                          C.ID_MOVCRE = A.ID_MOVIM)) '+
                s_where+' )'+
                '  ORDER BY 1 ';

  end;

begin
  if not dmRelatorio.b_funcCarregaRelatorio('relAnalise.fr3') then
    Exit;

   procPopulaCdsAnalise;

    if dmFinanc.cdsAnalise.IsEmpty then
    begin
      procMsgInfo('Não há informacões para os filtros informados');
      Exit;
    end;

  dmRelatorio.procAtribuirSelect('Despesa', getSelect('R'));
  dmRelatorio.procAtribuirSelect('Receita', getSelect('D'));
  dmRelatorio.procAtribuirSelect('Barra', getSelectBarra);

  dmRelatorio.Relatorio.ShowReport();
end;

procedure TrAnalise.sbSairClick(Sender: TObject);
begin
  Close;
end;

end.
