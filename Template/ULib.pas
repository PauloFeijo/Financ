unit ULib;

interface

uses Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Mask, DBCtrls, Buttons, ExtCtrls,
  IBDataBase, DBGrids, Grids,DB,IBCustomDataSet,DateUtils, DataSnap.DBClient,
  Vcl.OleCtnrs, System.UITypes, IBQuery, ComObj;

var CD_USUARIO_LOGADO : string ;
     corCampoRequerido : TColor = clSkyBlue;
     corTela : TColor = clGradientInactiveCaption;
     corSelecionado : TColor = clSkyBlue;
     transacao : TIBTransaction;
     s_projeto : string;

function funcCaminhoExe: string;
function funcCaminhoConf : string;
function funcCaminhoRel : string;
function funcAddCondSql(s_Sql: string; s_sqlAd: string): string;
procedure procDesabilitaCampos(dbeCampo: TDBEdit; b_Desabilita: boolean = true;b_requerido: boolean = false);
procedure procMsgErro(s_msg: String; b_Raise: boolean = false);
procedure procMsgInfo(s_msg: String);
procedure procMsgAtencao(s_msg: String);
function funcMsgConfirma(s_msg: String): boolean;
procedure procCriarQuery(var q_Query: TIBQuery; s_Sql: String = '');
procedure procCriaLimpaCds(var cds : TClientDataSet);
procedure procGridZebra(grid: TDBGrid; const Rect: TRect; DataCol: Integer;
  Column: TColumn; State: TGridDrawState);
function funcHoje: TDateTime;
function funcAgora : TDateTime;
procedure procCaixaAlta(var Key : Char);
function iif(b_teste : boolean; v_entao : variant; v_senao : Variant):Variant;
function txtToNum(s_txt : string) : double;
function caminhoBancoDados:string;
procedure procExecSql(s_sql : string; b_finaliza : boolean = true);
function funcSelect(s_sql : string) : string;
function FloatToStrDot(f_float : double) : string;
function funcValidaCpfCnpj(s_cod : string) : boolean;
procedure procRemoveCaracteres(Var s_texto : string; s_caracteres : string);
procedure procCampoValorChave(q : TIBQuery; var s_chave : string; var s_valor : string);
function funcChaveQuery(q : TIBQuery) : string;
function funcChaveExcluido(q : TIBQuery) : string;
procedure procSairCampo(form : TForm);
function funcSomaQtdeQuery(q : TIBQuery; c_campo : string) : double;
function funcIndexGridField(dbg : TDBGrid;s_campo : string) : integer;
function funcValidaCamposObrigatorios(q_query: TIBQuery): boolean;
function funcProxInt(s_Tabela,s_Campo : string;s_where : string = ''): integer;
function criptografar(s : string) : string;
function descriptografar(s : string) : string;
function funcValorArqInf(arq : string; c_chave : string) : string;
procedure procValorArqInf(arq : string; c_chave : string; c_valor : string);
function DecimalToBase(i_num : LongInt; base : byte = 36):string;
function BaseToDecimal(s_num : string; base : byte = 36):LongInt;
function funcEscurecer(cor: TColor; perc: byte): TColor;
procedure procExportarExcel(grid : TDBGrid);

implementation

function funcIndexGridField(dbg : TDBGrid;s_campo : string) : integer;
var i_cont : integer;
begin
  Result := 0;
  for i_cont := 0 to dbg.FieldCount -1 do
    if dbg.Columns[i_cont].DisplayName = s_campo then
    begin
      Result := i_cont;
      Exit;
    end;
end;
procedure procSairCampo(form : TForm);
var ctrl : TWinControl;
begin
  ctrl := form.ActiveControl;
  form.ActiveControl := nil;
  form.ActiveControl := ctrl;
end;

function funcSomaQtdeQuery(q : TIBQuery; c_campo : string) : double;
var i_pos : integer;
begin
  i_pos := q.RecNo;
  Result := 0;
  q.First;
  while not q.Eof do
  begin
    Result := Result + q.FieldByName(c_campo).AsFloat;
    q.Next;
  end;
  q.RecNo := i_pos;
end;

function caminhoBancoDados : string;
var
  arqText: TextFile;
  linha, server, path: String;
begin
   server := 'localhost';
   path   := funcCaminhoExe+s_projeto+'.fdb';
  try
    try
      AssignFile(arqText, funcCaminhoExe+s_projeto+'.inf');
      Reset(arqText);
    except
      Rewrite(arqText);
      writeln(arqText,'localhost');
      writeln(arqText,funcCaminhoExe+s_projeto+'.fdb');
      Append(arqText);
      Reset(arqText);
    end;
  finally
    Readln(arqText, linha);
    server := linha;
    Readln(arqText, linha);
    path := linha;
    CloseFile(arqText);
  end;
  Result := server+':'+path;
end;

procedure procCaixaAlta(var Key : Char);
begin
  Key := AnsiUpperCase(Key)[1];
end;

// ------------ mensagens---------------------
procedure procMsgErro(s_msg: string; b_Raise: boolean = false);
begin
  if b_Raise then
    raise Exception.Create(s_msg)
  else
    Application.MessageBox(Pchar(s_msg), Pchar('Erro'), MB_ICONERROR + MB_OK);
end;

function funcHoje: TDateTime;
var q_Query: TIBQuery;
begin
  procCriarQuery(q_Query, 'SELECT CURRENT_DATE HOJE FROM RDB$DATABASE');
  try
    q_Query.Open;
    result := q_Query.FieldByName('HOJE').AsDateTime;
  finally
    FreeAndNil(q_Query);
  end;
end;

function funcAgora : TDateTime;
var q_Query: TIBQuery;
begin
  procCriarQuery(q_Query, 'SELECT CURRENT_TIMESTAMP AGORA FROM RDB$DATABASE');
  try
    q_Query.Open;
    result := q_Query.FieldByName('AGORA').AsDateTime;
  finally
    FreeAndNil(q_Query);
  end;
end;

procedure procMsgInfo(s_msg: string);
begin
  Application.MessageBox(Pchar(s_msg), Pchar('Informação'),
    MB_ICONINFORMATION + MB_OK);
end;

procedure procMsgAtencao(s_msg: string);
begin
  Application.MessageBox(Pchar(s_msg), Pchar('Atenção'),
    MB_ICONWARNING + MB_OK);
end;

function funcMsgConfirma(s_msg: String): boolean;
begin
  result := Application.MessageBox(Pchar(s_msg), Pchar('Pergunta'),
    MB_ICONQUESTION + MB_YESNO) = mrYes;
end;

// --------------------------------------------------

function funcCaminhoExe: string;
begin
  result := ExtractFilePath(Application.ExeName)
end;

function funcCaminhoConf : string;
begin
  ForceDirectories(funcCaminhoExe+'Conf');
  Result := funcCaminhoExe+'Conf\';
end;

function funcCaminhoRel : string;
begin
  ForceDirectories(funcCaminhoExe+'Rel');
  Result := funcCaminhoExe+'Rel\';
end;

function funcAddCondSql(s_Sql: string; s_sqlAd: string): string;
begin
  if Pos('WHERE', s_Sql) = 0 then
    result := s_Sql + ' WHERE ' + s_sqlAd
  else
    result := s_Sql + ' AND ' + s_sqlAd;
end;

procedure procCriarQuery(var q_Query: TIBQuery; s_Sql: string = '');
begin
  q_Query             := TIBQuery.Create(nil);
  q_Query.Database    := transacao.DefaultDatabase;
  q_Query.Transaction := transacao;
  q_Query.SQL.Text    := s_Sql;
end;

procedure procCriaLimpaCds(var cds : TClientDataSet);
begin
  if not cds.Active then
    cds.CreateDataSet
  else
    cds.EmptyDataSet;

  cds.Open;
end;

// chamar no evento
procedure procGridZebra(grid: TDBGrid; const Rect: TRect; DataCol: Integer;
  Column: TColumn; State: TGridDrawState);
begin

  if not odd(grid.DataSource.DataSet.RecNo) and not(GdSelected in State)  Then
    grid.Canvas.Brush.color := funcEscurecer(grid.Canvas.Brush.color,10);// clMenu; // escurecer

  if (gdSelected in State) or grid.SelectedRows.CurrentRowSelected then
    grid.Canvas.Brush.color := CorSelecionado;

  grid.Canvas.FillRect(Rect);

  grid.DefaultDrawColumnCell(Rect, DataCol, Column, State);
end;

procedure procDesabilitaCampos(dbeCampo: TDBEdit; b_Desabilita: boolean = true;
  b_requerido: boolean = false);
begin
  dbeCampo.Enabled := not b_Desabilita;

  if dbeCampo.Enabled then
  begin
    if b_requerido then
      dbeCampo.color := corCampoRequerido
    else
      dbeCampo.color := clWindow;
  end
  else
    dbeCampo.color := clBtnFace;
end;

function iif(b_teste : boolean; v_entao : variant; v_senao : Variant):Variant;
begin
  if b_teste then
    result := v_entao
  else
    result := v_senao;
end;

function txtToNum(s_txt : string) : double;
begin
  try
    result := StrToFloat(s_txt);
  except
    result := 0;
  end;
end;

procedure procExecSql(s_sql : string; b_finaliza : boolean);
var q_Query: TIBQuery;
begin
  procCriarQuery(q_Query,s_sql);
  try
    q_Query.ExecSql;

    if b_finaliza and transacao.Active then
      transacao.Commit;

  finally
    FreeAndNil(q_Query);
  end;
end;

function funcSelect(s_sql : string) : string;
var q_Query: TIBQuery;
begin
  procCriarQuery(q_Query,s_sql);
  try
    q_Query.Open;
    result := q_query.Fields[0].AsString;
  finally
    FreeAndNil(q_Query);
  end;
end;
function FloatToStrDot(f_float : double) : string;
begin
  Result := StringReplace(FloatToStr(f_float),',','.',[rfReplaceAll]);
end;

function funcValidaCpfCnpj(s_cod : string) : boolean;

  function b_CPFValido(s_cod : string) : boolean;
  var
    d,x: integer;
    s_calc : string;
  begin
    s_calc := Copy(s_cod,1,9);

    d := 0;
    for x := 9 downto 1 do
      d := d + StrToInt(s_calc[x])*(11-x);
    d := 11 - (d mod 11);
    if d >= 10 then d := 0;
    s_calc := s_calc + IntToStr(d);

    d := 0;
    for x := 10 downto 1 do
      d := d + StrToInt(s_calc[x])*(12-x);
    d := 11 - (d mod 11);
    if d >= 10 then d := 0;
    s_calc := s_calc + IntToStr(d);

    Result := (s_calc = s_cod);
  end;

  function b_CNPJValido(s_cod: string): boolean;
  var
     d,x,n: integer;
     s_calc: string;
  begin
    s_calc := Copy(s_cod,1,12);

    d := 0;
    n := 2;
    for x := 12 downto 1 do
    begin
      d := d + StrToInt(s_calc[x])*n;
      inc(n);
      if n = 10 then n := 2;
    end;
    d := 11 - (d mod 11);
    if d >= 10 then d := 0;
    s_calc := s_calc + IntToStr(d);

    d := 0;
    n := 2;
    for x := 13 downto 1 do
    begin
      d := d + StrToInt(s_calc[x])*n;
      inc(n);
      if n = 10 then n := 2;
    end;
    d := 11 - (d mod 11);
    if d >= 10 then d := 0;
    s_calc := s_calc + IntToStr(d);

    Result := s_cod = s_calc;
  end;

begin
  procRemoveCaracteres(s_cod,'/-.\ ');

  if Length(s_cod) = 11 then
    Result := b_CPFValido(s_cod)

  else if Length(s_cod) = 14 then
    Result := b_CNPJValido(s_cod)

  else
    Result := False;

  if Result = False then
    procMsgErro('CPF/CNPJ Inválido');
end;

procedure procRemoveCaracteres(Var s_texto : string; s_caracteres : string);
var i : integer;
begin
  for I := 1 to Length(s_caracteres) do
    s_texto := StringReplace(s_texto,s_caracteres[i],'',[rfReplaceAll]);
end;

procedure procCampoValorChave(q : TIBQuery; var s_chave : string; var s_valor : string);
var i_cont : integer;
begin
  for i_cont := 0 to q.FieldCount -1 do
  begin
    if PfInKey in q.Fields.Fields[i_cont].ProviderFlags then
    begin
      s_chave:= q.Fields.Fields[i_cont].FieldName;
      s_valor := q.Fields.Fields[i_cont].AsString;
      exit;
    end;
  end;
end;

function funcChaveQuery(q : TIBQuery) : string;
var s_chave, s_valorChave : string;
begin
  procCampoValorChave(q,s_chave,s_valorChave);
  Result := q.Name+s_chave+'='+s_valorChave;
end;

function funcChaveExcluido(q : TIBQuery) : string;
begin
  Result := q.Name+'=EXCLUIDO'
end;

function funcValidaCamposObrigatorios(q_query: TIBQuery): boolean;
var i_field : integer;
  sl_msg : TStringList;
begin
  Result := false;
  sl_msg := TStringList.Create;
  for i_field := 0 to q_query.FieldCount - 1 do
    if q_query.Fields[i_field].Required and q_query.Fields[i_field].IsNull then
      sl_msg.add('- '+q_query.Fields[i_field].DisplayName);

  if PChar(sl_msg.GetText) <> '' then
    procMsgAtencao('Campos obrigatórios a serem informados:'+sLineBreak+PChar(sl_msg.GetText))
  else
    Result := True;
end;

function funcProxInt(s_Tabela,s_Campo : string;s_where : string = ''): integer;
begin
  Result := strToIntDef(funcSelect(Format('select coalesce(max(%s),0) +1 seq from %s %s',[s_campo,s_tabela,s_where])),0);
end;

function criptografar(s : string) : string;
var i,x: Integer;
const A : array[0..19] of byte = (2,7,6,4,3,8,7,5,1,2,4,5,9,2,4,7,5,3,8,1);
begin
  Result := EmptyStr;

  s := StringReplace(s,Char(10),'',[rfReplaceAll]);

  if s = EmptyStr then
    Exit;

  for i := 1 to Length(s) do
  begin
    x := Integer(s[i]) + A[i mod 20];

    while x in ([0,1,28..31,128..160,168]) do
      x := x + A[i mod 20];

    Result := Result + Char(x);
  end;
end;

function descriptografar(s : string) : string;
var i,x: Integer;
const A : array[0..19] of byte = (2,7,6,4,3,8,7,5,1,2,4,5,9,2,4,7,5,3,8,1);
begin
  Result := EmptyStr;

  s := StringReplace(s,Char(10),'',[rfReplaceAll]);

  if s = EmptyStr then
    Exit;

  for i := 1 to length(s) do
  begin
    x := Integer(s[i]) - A[i mod 20];

    while x in ([0,1,28..31,128..160,168]) do
      x := x - A[i mod 20];

    Result := Result + Char(x);
  end;
end;

function funcValorArqInf(arq : string; c_chave : string) : string;
var arqText: TextFile;
    linha: String;
begin
   Result := EmptyStr;
  try
    try
      AssignFile(arqText, arq);
      Reset(arqText);
    except
      Exit;
    end;

    while not Eof(arqText) do
    begin
      Readln(arqText, linha);
      if Pos(c_chave, linha) > 0 then
      begin
        Result := Copy(linha, Pos(c_chave, linha) + Length(c_chave));
        Break;
      end;
    end;

  finally
    try
      CloseFile(arqText);
    except
    end;
  end;

end;

procedure procValorArqInf(arq : string; c_chave : string; c_valor : string);
var arqText: TextFile;
    linha: String;
    b_found : boolean;
    c_conteudo : string;
begin
  b_found := False;
  c_conteudo := EmptyStr;

  try
    try
      AssignFile(arqText, arq);
      Reset(arqText);
    except
      Rewrite(arqText);
      Reset(arqText);
    end;

    while not Eof(arqText) do
    begin
      Readln(arqText, linha);
      if Pos(c_chave, linha) > 0 then
      begin
        c_conteudo := c_conteudo + c_chave + c_valor + sLineBreak;
        b_found    := True;
      end
      else if linha <> EmptyStr then
        c_conteudo := c_conteudo + linha + sLineBreak;
    end;

    if not b_found then
       c_conteudo := c_conteudo + c_chave + c_valor;

  finally
    Rewrite(arqText);
    writeln(arqText, c_conteudo);
    Append(arqText);
    CloseFile(arqText);
  end;
end;

function DecimalToBase(i_num : LongInt; base : byte = 36):string;
const ALFANUM = '0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ';
var i_resto, i_pos : integer;
begin
   Result  := '';
   i_resto := i_num;
   repeat
      if i_resto < base then
         i_pos := i_resto
      else
         i_pos := i_resto mod base;

      Result   := ALFANUM[i_pos+1] + Result;
      i_resto  := i_resto div base;
   until i_resto <= 0;
end;

function BaseToDecimal(s_num : string; base : byte = 36):LongInt;
const ALFANUM = '0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ';
var  i_index, i_baseAux: Integer;
begin
   Result := 0;
   i_baseAux := 1;
   for i_index := Length(s_num) downto 1 do
   begin
      result := result + i_baseAux * (Pos(s_num[i_index],ALFANUM)-1);
      i_baseAux := i_baseAux * base;
   end;
end;

function funcEscurecer(cor: TColor; perc: byte): TColor;
var r, g, b : integer;
begin
   r := TPaletteEntry(cor).peRed   - Trunc(TPaletteEntry(cor).peRed   * (perc / 100));
   g := TPaletteEntry(cor).peGreen - Trunc(TPaletteEntry(cor).peGreen * (perc / 100));
   b := TPaletteEntry(cor).peBlue  - Trunc(TPaletteEntry(cor).peBlue  * (perc / 100));

   Result := RGB(r,g,b);
end;

procedure procExportarExcel(grid: TDBGrid);
var
   col: integer;
   planilha: variant;
   valorcampo: string;
   ds : TDataSet;
begin
   planilha := CreateoleObject('Excel.Application');
   planilha.WorkBooks.add(1);
   planilha.Visible := False;

   ds := grid.DataSource.DataSet;
   // Titulo
   for col := 0 to grid.Columns.Count -1 do
   begin
      if grid.Columns[col].Visible then
         planilha.cells[1, col+1] := grid.Columns[col].Title.Caption;
   end;

   // Dados
   ds.First;
   while not ds.Eof do
   begin
      for col := 0 to grid.Columns.Count -1 do
      begin
         if not grid.Columns[col].Visible then
            Continue;

         if ds.FieldByName(grid.Columns[col].FieldName).ClassType = TDateField then
            valorCampo := FormatDateTime('dd/mm/yyyy',ds.FieldByName(grid.Columns[col].FieldName).AsDateTime)

         else if ds.FieldByName(grid.Columns[col].FieldName).ClassType = TBCDField then
            valorCampo := FormatFloat('###,###,##0.00', ds.FieldByName(grid.Columns[col].FieldName).AsFloat)
         else
            valorCampo := ds.FieldByName(grid.Columns[col].FieldName).AsString;

         planilha.cells[ds.RecNo+1, col+1] := valorCampo;
      end;

      ds.Next;
   end;
   planilha.Columns.Autofit;
   planilha.Caption := 'Dados';
   planilha.Visible := True;
end;

end.

