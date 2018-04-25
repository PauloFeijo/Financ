unit udmFinanc;

interface

uses
  SysUtils, Classes, DB, IBX.IBDatabase, uLib, IBX.IBCustomDataSet,
  IBX.IBUpdateSQL, IBX.IBQuery, DBClient, uConst, DateUTils, Datasnap.Provider;

type
  TdmFinanc = class(TDataModule)
    tdb: TIBTransaction;
    db: TIBDatabase;
    Conta: TIBQuery;
    uConta: TIBUpdateSQL;
    dConta: TDataSource;
    ContaID_CONTA: TIntegerField;
    ContaCD_USUARIO: TIBStringField;
    ContaNR_CONTA: TIntegerField;
    ContaDS_CONTA: TIBStringField;
    Movimento: TIBQuery;
    uMovimento: TIBUpdateSQL;
    dMovimento: TDataSource;
    MovimentoID_MOVIM: TIntegerField;
    MovimentoID_CONTA: TIntegerField;
    MovimentoVL_MOVIM: TIBBCDField;
    MovimentoDS_MOVIM: TIBStringField;
    MovimentoNR_CONTA: TIntegerField;
    MovimentoDS_CONTA: TIBStringField;
    MovimentoFL_TIPO: TIBStringField;
    Categoria: TIBQuery;
    UCategoria: TIBUpdateSQL;
    DCategoria: TDataSource;
    CategoriaID_CATEG: TIntegerField;
    CategoriaCD_USUARIO: TIBStringField;
    CategoriaID_CATPAI: TIntegerField;
    CategoriaDS_CATEG: TIBStringField;
    CategoriaFL_TIPO: TIBStringField;
    PesCategoria: TIBQuery;
    dPesCategoria: TDataSource;
    PesCategoriaID_CATEG: TIntegerField;
    PesCategoriaCD_USUARIO: TIBStringField;
    PesCategoriaID_CATPAI: TIntegerField;
    PesCategoriaDS_CATEG: TIBStringField;
    PesCategoriaFL_TIPO: TIBStringField;
    MovimentoID_CATEG: TIntegerField;
    MovimentoDS_CATEG: TIBStringField;
    ContaVL_SALDO: TIBBCDField;
    MovimentoDT_MOVIM: TDateField;
    MovimentoCD_USUARIO: TIBStringField;
    Transferencia: TIBQuery;
    uTransferencia: TIBUpdateSQL;
    dTransferencia: TDataSource;
    TransferenciaID_TRANSFER: TIntegerField;
    TransferenciaID_MOVDEB: TIntegerField;
    TransferenciaID_MOVCRE: TIntegerField;
    TransferenciaDS_TRANSF: TIBStringField;
    TransferenciaDT_TRANSF: TDateField;
    TransferenciaVL_TRANSF: TIBBCDField;
    TransferenciaDS_CDEB: TIBStringField;
    TransferenciaNR_CDEB: TIntegerField;
    TransferenciaDS_CCRED: TIBStringField;
    TransferenciaNR_CCRED: TIntegerField;
    TransferenciaID_CDEB: TIntegerField;
    TransferenciaID_CCRED: TIntegerField;
    TransferenciaCD_USUARIO: TIBStringField;
    cdsAnalise: TClientDataSet;
    cdsAnaliseID_CATEG: TIntegerField;
    cdsAnaliseCATEG: TStringField;
    cdsAnaliseVALOR: TFloatField;
    cdsAnaliseNIVEL: TIntegerField;
    cdsAnaliseFL_TIPO: TStringField;
    cdsAnaliseB_PAI: TBooleanField;
    PagarReceber: TIBQuery;
    uPagarReceber: TIBUpdateSQL;
    dPagarReceber: TDataSource;
    PagarReceberID_PAGRECEB: TIntegerField;
    PagarReceberCD_USUARIO: TIBStringField;
    PagarReceberID_CATEG: TIntegerField;
    PagarReceberVL_VALOR: TIBBCDField;
    PagarReceberDT_VENCTO: TDateField;
    PagarReceberFL_TIPO: TIBStringField;
    PagarReceberDS_CATEG: TIBStringField;
    PagarReceberDS_DESCRI: TIBStringField;
    PagarReceberVL_PAGO: TIBBCDField;
    MovimentoID_PAGRECEB: TIntegerField;
    PagarReceberNR_DOCTO: TIBStringField;
    cdsAnual: TClientDataSet;
    cdsAnualID_CATEG: TIntegerField;
    cdsAnualCATEG: TStringField;
    cdsAnualNIVEL: TIntegerField;
    cdsAnualFL_TIPO: TStringField;
    cdsAnualB_PAI: TBooleanField;
    cdsAnualVL_M1: TFloatField;
    cdsAnualVL_M2: TFloatField;
    cdsAnualVL_M3: TFloatField;
    cdsAnualVL_M4: TFloatField;
    cdsAnualVL_M5: TFloatField;
    cdsAnualVL_M6: TFloatField;
    cdsAnualVL_M7: TFloatField;
    cdsAnualVL_M8: TFloatField;
    cdsAnualVL_M9: TFloatField;
    cdsAnualVL_M10: TFloatField;
    cdsAnualVL_M11: TFloatField;
    cdsAnualVL_M12: TFloatField;
    CCusto: TIBQuery;
    uCCusto: TIBUpdateSQL;
    dCCusto: TDataSource;
    PesCCusto: TIBQuery;
    dPesCCusto: TDataSource;
    CCustoID_CCUSTO: TIntegerField;
    CCustoCD_USUARIO: TIBStringField;
    CCustoID_CCPAI: TIntegerField;
    CCustoDS_CCUSTO: TIBStringField;
    PesCCustoID_CCUSTO: TIntegerField;
    PesCCustoCD_USUARIO: TIBStringField;
    PesCCustoID_CCPAI: TIntegerField;
    PesCCustoDS_CCUSTO: TIBStringField;
    MovimentoID_CCUSTO: TIntegerField;
    MovimentoDS_CCUSTO: TIBStringField;
    Plano: TIBQuery;
    uPlano: TIBUpdateSQL;
    dPlano: TDataSource;
    PlanoID_PLANO: TIntegerField;
    PlanoCD_USUARIO: TIBStringField;
    PlanoID_CATEG: TIntegerField;
    PlanoID_CCUSTO: TIntegerField;
    PlanoVL_VALOR: TIBBCDField;
    PlanoFL_ALERTA: TIBStringField;
    PlanoDS_PLANO: TIBStringField;
    PlanoDS_CATEG: TIBStringField;
    PlanoDS_CCUSTO: TIBStringField;
    PlanoDS_ACAO: TIBStringField;
    MovimentoVL_JUROS: TIBBCDField;
    MovimentoVL_DESCON: TIBBCDField;
    MovimentoVL_BRUTO: TIBBCDField;
    ContaFL_ATIVO: TIBStringField;
    CategoriaFL_ATIVO: TIBStringField;
    PesCategoriaFL_ATIVO: TIBStringField;
    CCustoFL_ATIVO: TIBStringField;
    PesCCustoFL_ATIVO: TIBStringField;
    Bens: TIBQuery;
    uBens: TIBUpdateSQL;
    dBens: TDataSource;
    BensID_BEM: TIntegerField;
    BensCD_USUARIO: TIBStringField;
    BensDS_BEM: TIBStringField;
    BensVL_AQUISICAO: TIBBCDField;
    BensDT_AQUISICAO: TDateField;
    BensVL_ATUAL: TIBBCDField;
    BensDT_VENDA: TDateField;
    procedure DataModuleCreate(Sender: TObject);
    procedure ContaAfterInsert(DataSet: TDataSet);
    procedure MovimentoAfterInsert(DataSet: TDataSet);
    procedure CategoriaAfterInsert(DataSet: TDataSet);
    function i_funcNextSequence(s_seq : string) : integer;
    procedure TransferenciaAfterInsert(DataSet: TDataSet);
    procedure TransferenciaVL_TRANSFValidate(Sender: TField);
    procedure MovimentoBeforePost(DataSet: TDataSet);
    procedure PagarReceberAfterInsert(DataSet: TDataSet);
    procedure PagarReceberVL_VALORValidate(Sender: TField);
    procedure PagarReceberVL_BRUTOValidate(Sender: TField);
    procedure CCustoAfterInsert(DataSet: TDataSet);
    procedure PlanoAfterInsert(DataSet: TDataSet);
    procedure MovimentoAfterEdit(DataSet: TDataSet);
    procedure MovimentoVL_JUROSValidate(Sender: TField);
    procedure MovimentoVL_DESCONValidate(Sender: TField);
    procedure MovimentoVL_BRUTOValidate(Sender: TField);
    procedure ContaFL_ATIVOGetText(Sender: TField; var Text: string;
      DisplayText: Boolean);
    procedure CategoriaFL_ATIVOGetText(Sender: TField; var Text: string;
      DisplayText: Boolean);
    procedure PesCategoriaFL_ATIVOGetText(Sender: TField; var Text: string;
      DisplayText: Boolean);
    procedure CCustoFL_ATIVOGetText(Sender: TField; var Text: string;
      DisplayText: Boolean);
    procedure PesCCustoFL_ATIVOGetText(Sender: TField; var Text: string;
      DisplayText: Boolean);
    procedure MovimentoFL_TIPOGetText(Sender: TField; var Text: string;
      DisplayText: Boolean);
    procedure CategoriaFL_TIPOGetText(Sender: TField; var Text: string;
      DisplayText: Boolean);
    procedure PagarReceberFL_TIPOGetText(Sender: TField; var Text: string;
      DisplayText: Boolean);
    procedure BensAfterInsert(DataSet: TDataSet);
    procedure BensVL_ATUALValidate(Sender: TField);
    procedure BensVL_AQUISICAOValidate(Sender: TField);
    procedure BensDT_VENDAValidate(Sender: TField);
    procedure BensDT_AQUISICAOValidate(Sender: TField);
  private
    { Private declarations }
    procedure procInsereMascara;
    procedure procCalculaMovimentoVL_MOVIM;
  public
    { Public declarations }
    function funcListaCategoria(i_categ : integer = 0) : string;
    function funcListaCCusto(i_ccusto : integer = 0) : string;
    function b_funcTemCCustoHierarquia(i_ccusto, i_ccpai : integer) : boolean;
    function b_funcTemCategHierarquia(i_categ, i_catpai : integer) : boolean;
    procedure procCriaAtualizaMovimento(i_movto,i_conta : integer; f_valor : double; s_descri, s_tipo : string; i_categ : integer; d_data : TDate; i_ccusto : integer);
    function i_funcCategPadrao(s_tipo : string) : integer;
    procedure procValidaFieldNumericoPositivo(campo : TField);
    procedure procValidaFieldNumericoMaiorQueZero(campo: TField);
    procedure procValidaFieldNumericoPercentual(campo: TField);
    function funcValidaMovimentoDentroDoPlano(i_mov, i_ccusto, i_categ : integer; f_valor : double; d_data : TDateTime):boolean;
    procedure procGetTextAtivoInativo(Sender: TField; var Text: string; DisplayText: Boolean);
    procedure procGetText(Sender: TField; var Text: string; DisplayText: Boolean; c_argumentos : string);
  end;

var
  dmFinanc: TdmFinanc;
  id_CCPad  : integer;
  id_ConPad : integer;

implementation

{$R *.dfm}

procedure TdmFinanc.CategoriaAfterInsert(DataSet: TDataSet);
begin
  CategoriaID_CATEG.AsInteger  := i_funcNextSequence('GEN_CATEGORIA');
  CategoriaCD_USUARIO.AsString := CD_USUARIO_LOGADO;
  CategoriaFL_ATIVO.AsString   := 'A';
end;

procedure TdmFinanc.CategoriaFL_ATIVOGetText(Sender: TField; var Text: string;
  DisplayText: Boolean);
begin
  procGetTextAtivoInativo(Sender, Text, DisplayText);
end;

procedure TdmFinanc.CategoriaFL_TIPOGetText(Sender: TField; var Text: string;
  DisplayText: Boolean);
begin
  procGetText(Sender, Text, DisplayText,
    'R=Receita'+sLineBreak+
    'D=Despesa'
  );
end;

procedure TdmFinanc.CCustoAfterInsert(DataSet: TDataSet);
begin
  CCustoID_CCUSTO.AsInteger := i_funcNextSequence('GEN_CCUSTO');
  CCustoCD_USUARIO.AsString := CD_USUARIO_LOGADO;
  CCustoFL_ATIVO.AsString   := 'A';
end;

procedure TdmFinanc.CCustoFL_ATIVOGetText(Sender: TField; var Text: string;
  DisplayText: Boolean);
begin
  procGetTextAtivoInativo(Sender, Text, DisplayText);
end;

procedure TdmFinanc.ContaAfterInsert(DataSet: TDataSet);
begin
  ContaID_CONTA.AsInteger  := i_funcNextSequence('GEN_CONTA');
  ContaCD_USUARIO.AsString := CD_USUARIO_LOGADO;
  ContaFL_ATIVO.AsString   := 'A';
end;

procedure TdmFinanc.ContaFL_ATIVOGetText(Sender: TField; var Text: string;
  DisplayText: Boolean);
begin
  procGetTextAtivoInativo(Sender, Text, DisplayText);
end;

procedure TdmFinanc.DataModuleCreate(Sender: TObject);
begin
  Ulib.transacao := tdb;
  Ulib.s_projeto := 'Financ';
  DB.Connected   := false;
  try
    DB.DatabaseName := caminhoBancoDados;
    DB.Connected    := true;
  except
    procMsgErro('Erro ao conectar ao banco de dados. Verifique a conexão pelo arquivo ''financ.inf''.',True);
  end;

  try
    procInsereMascara;
  except
    on e : Exception do
      procMsgErro('Erro ao inicializar o sistema.'+sLineBreak+'Descrição do erro:'+sLineBreak+e.Message,True);
  end;
end;

function TdmFinanc.funcListaCategoria(i_categ: integer): string;
begin
  Result := funcSelect(Format(
    'WITH RECURSIVE CAT_TREE AS(        '+
    '   SELECT A.ID_CATEG               '+
    '     FROM CATEGORIA A              '+
    '    WHERE A.ID_CATEG = %d          '+
    '    UNION ALL                      '+
    '                                   '+
    '   SELECT A.ID_CATEG               '+
    '     FROM CATEGORIA A              '+
    '    INNER JOIN CAT_TREE B ON       '+
    '          B.ID_CATEG = A.ID_CATPAI)'+
    '                                   '+
    '   SELECT LIST(A.ID_CATEG) LISTA   '+
    '     FROM CAT_TREE A               ',
    [i_categ]));
end;

function TdmFinanc.i_funcCategPadrao(s_tipo: string): integer;
begin
  Result := strToIntDef(
     funcSelect(Format(
        'SELECT A.ID_CATEG           '+
        '  FROM CATEGORIA A          '+
        ' WHERE A.CD_USUARIO = ''%s'''+
        '   AND A.FL_TIPO    = ''%s'''+
        '   AND A.ID_CATPAI IS NULL  ',
        [CD_USUARIO_LOGADO,s_tipo])),0
     );
end;

function TdmFinanc.funcListaCCusto(i_ccusto: integer): string;
begin
  Result := funcSelect(Format(
    'WITH RECURSIVE CC_TREE AS(         '+
    '   SELECT A.ID_CCUSTO              '+
    '     FROM CCUSTO A                 '+
    '    WHERE A.ID_CCUSTO = %d         '+
    '    UNION ALL                      '+
    '                                   '+
    '   SELECT A.ID_CCUSTO              '+
    '     FROM CCUSTO A                 '+
    '    INNER JOIN CC_TREE B ON        '+
    '          B.ID_CCUSTO = A.ID_CCPAI)'+
    '                                   '+
    '   SELECT LIST(A.ID_CCUSTO) LISTA  '+
    '     FROM CC_TREE A                ',
    [i_ccusto]));
end;

function TdmFinanc.funcValidaMovimentoDentroDoPlano(i_mov,i_ccusto,i_categ: integer; f_valor : double; d_data : TDateTime): boolean;
  function funcValidaCCusto : boolean;
  var q1,q2,q3 : TIBQuery;
  begin
    Result := False;
    procCriarQuery(q1);
    procCriarQuery(q2);
    procCriarQuery(q3);
    try
      q1.SQL.Text :=
        'WITH RECURSIVE CC_TREE AS(         '+
        '   SELECT A.ID_CCPAI,              '+
        '          A.ID_CCUSTO              '+
        '     FROM CCUSTO A                 '+
        '    WHERE A.ID_CCUSTO = '+IntToStr(i_ccusto)+
        '    UNION ALL                      '+
        '                                   '+
        '   SELECT A.ID_CCPAI,              '+
        '          A.ID_CCUSTO              '+
        '     FROM CCUSTO A                 '+
        '    INNER JOIN CC_TREE B ON        '+
        '          B.ID_CCPAI = A.ID_CCUSTO)'+
        '                                   '+
        '   SELECT A.ID_CCUSTO              '+
        '     FROM CC_TREE A                ';
      q1.Open;

      while not q1.Eof do
      begin
        q2.sql.Text :=
          'SELECT A.VL_VALOR,                               '+
          '       A.FL_ALERTA,                              '+
          '       A.DS_PLANO,                               '+
          '       B.DS_CCUSTO                               '+
          '  FROM PLANO A                                   '+
          ' INNER JOIN CCUSTO B ON B.ID_CCUSTO = A.ID_CCUSTO'+
          ' WHERE A.ID_CCUSTO = :CCUSTO                     ';
        q2.ParamByName('CCUSTO').AsInteger := q1.FieldByName('ID_CCUSTO').AsInteger;
        q2.Open;

        if not q2.IsEmpty then
        begin
          q3.sql.Text :=
            'SELECT COALESCE(SUM(A.VL_MOVIM),0) * -1 VL_VALOR   '+
            '  FROM MOVIMENTO A                                 '+
            ' WHERE A.ID_CCUSTO IN ('+
            funcListaCCusto(q1.FieldByName('ID_CCUSTO').AsInteger)+')'+
            '   AND A.DT_MOVIM BETWEEN :DATAINI AND :DATAFIN    '+
            '   AND A.FL_TIPO = ''R''                           '+
            '   AND A.ID_MOVIM <> :ESTEMOV                      '+
            '   AND NOT EXISTS(SELECT 1 FROM TRANSFERENCIA C    '+
            '                   WHERE (C.ID_MOVDEB = A.ID_MOVIM '+
            '                      OR C.ID_MOVCRE = A.ID_MOVIM))';
          q3.ParamByName('DATAINI').AsDateTime := DateUtils.StartOfTheMonth(d_data);
          q3.ParamByName('DATAFIN').AsDateTime := DateUtils.EndOfTheMonth(d_data);
          q3.ParamByName('ESTEMOV').AsInteger  := i_mov;
          q3.Open;

          if (q3.FieldByName('VL_VALOR').AsFloat + f_valor) > q2.FieldByName('VL_VALOR').AsFloat then
          begin
            if q2.FieldByName('FL_ALERTA').AsString = 'B' then
              raise Exception.Create(Format(
                 'Não será possivel continuar pois o Centro de Custos %s está configurado no '+
                 'Plano %s para movimentar apenas R$ %s mensalmente, e com esta movimentação ficaria com o valor de R$ %s.',
                 [q2.FieldByName('DS_CCUSTO').AsString,
                  q2.FieldByName('DS_PLANO').AsString,
                  FormatFloat('###,###,##0.00',q2.FieldByName('VL_VALOR').AsFloat),
                  FormatFloat('###,###,##0.00',q3.FieldByName('VL_VALOR').AsFloat + f_valor)
                 ]))
            else
              if not funcMsgConfirma(Format(
                 'O Centro de Custos %s está configurado no Plano %s para movimentar apenas R$ %s mensalmente, '+
                 'e com esta movimentação ficará com o valor de R$ %s. Deseja continuar?',
                 [q2.FieldByName('DS_CCUSTO').AsString,
                  q2.FieldByName('DS_PLANO').AsString,
                  FormatFloat('###,###,##0.00',q2.FieldByName('VL_VALOR').AsFloat),
                  FormatFloat('###,###,##0.00',q3.FieldByName('VL_VALOR').AsFloat + f_valor)
                 ])) then

                 raise Exception.Create(Format(
                    'Não foi possivel continuar pois o Centro de Custos %s está configurado no '+
                    'Plano %s para movimentar apenas R$ %s mensalmente, e com esta movimentação ficaria com o valor de R$ %s, '+
                    'e o usuário optou por cancelar.',
                 [q2.FieldByName('DS_CCUSTO').AsString,
                  q2.FieldByName('DS_PLANO').AsString,
                  FormatFloat('###,###,##0.00',q2.FieldByName('VL_VALOR').AsFloat),
                  FormatFloat('###,###,##0.00',q3.FieldByName('VL_VALOR').AsFloat + f_valor)
                 ]));
          end;
        end;

        q1.Next;
      end;

      Result := True;
    finally
      FreeAndNil(q1);
      FreeAndNil(q2);
      FreeAndNil(q3);
    end;
  end;

  function funcValidaCategoria : boolean;
  var q1,q2,q3 : TIBQuery;
  begin
    Result := False;
    procCriarQuery(q1);
    procCriarQuery(q2);
    procCriarQuery(q3);
    try
      q1.SQL.Text :=
        'WITH RECURSIVE CAT_TREE AS(        '+
        '   SELECT A.ID_CATPAI,             '+
        '          A.ID_CATEG               '+
        '     FROM CATEGORIA A              '+
        '    WHERE A.ID_CATEG = '+IntToStr(i_categ)+
        '    UNION ALL                      '+
        '                                   '+
        '   SELECT A.ID_CATPAI,             '+
        '          A.ID_CATEG               '+
        '     FROM CATEGORIA A              '+
        '    INNER JOIN CAT_TREE B ON       '+
        '          B.ID_CATPAI = A.ID_CATEG)'+
        '                                   '+
        '   SELECT A.ID_CATEG               '+
        '     FROM CAT_TREE A               ';
      q1.Open;

      while not q1.Eof do
      begin
        q2.sql.Text :=
          'SELECT A.VL_VALOR,                                '+
          '       A.FL_ALERTA,                               '+
          '       A.DS_PLANO,                                '+
          '       B.DS_CATEG                                 '+
          '  FROM PLANO A                                    '+
          ' INNER JOIN CATEGORIA B ON B.ID_CATEG = A.ID_CATEG'+
          ' WHERE A.ID_CATEG = :CATEG                        ';
        q2.ParamByName('CATEG').AsInteger := q1.FieldByName('ID_CATEG').AsInteger;
        q2.Open;

        if not q2.IsEmpty then
        begin
          q3.sql.Text :=
            'SELECT COALESCE(SUM(A.VL_MOVIM),0) * -1 VL_VALOR   '+
            '  FROM MOVIMENTO A                                 '+
            ' WHERE A.ID_CATEG IN ('+
            funcListaCategoria(q1.FieldByName('ID_CATEG').AsInteger)+')'+
            '   AND A.DT_MOVIM BETWEEN :DATAINI AND :DATAFIN    '+
            '   AND A.FL_TIPO = ''R''                           '+
            '   AND A.ID_MOVIM <> :ESTEMOV                      '+
            '   AND NOT EXISTS(SELECT 1 FROM TRANSFERENCIA C    '+
            '                   WHERE (C.ID_MOVDEB = A.ID_MOVIM '+
            '                      OR C.ID_MOVCRE = A.ID_MOVIM))';
          q3.ParamByName('DATAINI').AsDateTime := DateUtils.StartOfTheMonth(d_data);
          q3.ParamByName('DATAFIN').AsDateTime := DateUtils.EndOfTheMonth(d_data);
          q3.ParamByName('ESTEMOV').AsInteger  := i_mov;
          q3.Open;

          if (q3.FieldByName('VL_VALOR').AsFloat + f_valor) > q2.FieldByName('VL_VALOR').AsFloat then
          begin
            if q2.FieldByName('FL_ALERTA').AsString = 'B' then
              raise Exception.Create(Format(
                 'Não será possivel continuar pois a Categoria %s está configurada no '+
                 'Plano %s para movimentar apenas R$ %s mensalmente, e com esta movimentação ficaria com o valor de R$ %s.',
                 [q2.FieldByName('DS_CATEG').AsString,
                  q2.FieldByName('DS_PLANO').AsString,
                  FormatFloat('###,###,##0.00',q2.FieldByName('VL_VALOR').AsFloat),
                  FormatFloat('###,###,##0.00',q3.FieldByName('VL_VALOR').AsFloat + f_valor)
                 ]))
            else
              if not funcMsgConfirma(Format(
                 'A Categoria %s está configurada no Plano %s para movimentar apenas R$ %s mensalmente, '+
                 'e com esta movimentação ficará com o valor de R$ %s. Deseja continuar?',
                 [q2.FieldByName('DS_CATEG').AsString,
                  q2.FieldByName('DS_PLANO').AsString,
                  FormatFloat('###,###,##0.00',q2.FieldByName('VL_VALOR').AsFloat),
                  FormatFloat('###,###,##0.00',q3.FieldByName('VL_VALOR').AsFloat + f_valor)
                 ])) then

                 raise Exception.Create(Format(
                    'Não foi possivel continuar pois a Categoria %s está configurada no '+
                    'Plano %s para movimentar apenas R$ %s mensalmente, e com esta movimentação ficaria com o valor de R$ %s, '+
                    'e o usuário optou por cancelar.',
                 [q2.FieldByName('DS_CATEG').AsString,
                  q2.FieldByName('DS_PLANO').AsString,
                  FormatFloat('###,###,##0.00',q2.FieldByName('VL_VALOR').AsFloat),
                  FormatFloat('###,###,##0.00',q3.FieldByName('VL_VALOR').AsFloat + f_valor)
                 ]));
          end;
        end;

        q1.Next;
      end;

      Result := True;
    finally
      FreeAndNil(q1);
      FreeAndNil(q2);
      FreeAndNil(q3);
    end;
  end;
begin
  Result := funcValidaCCusto;

  if result then
    Result := funcValidaCategoria;
end;

function TdmFinanc.b_funcTemCCustoHierarquia(i_ccusto, i_ccpai : integer) : boolean;
begin
  Result := (Trim(funcSelect(Format(
    'WITH RECURSIVE CC_TREE AS(         '+
    '   SELECT A.ID_CCUSTO              '+
    '     FROM CCUSTO A                 '+
    '    WHERE A.ID_CCUSTO = %d         '+
    '    UNION ALL                      '+
    '                                   '+
    '   SELECT A.ID_CCUSTO              '+
    '     FROM CCUSTO A                 '+
    '    INNER JOIN CC_TREE B ON        '+
    '          B.ID_CCUSTO = A.ID_CCPAI)'+
    '                                   '+
    '   SELECT A.ID_CCUSTO              '+
    '     FROM CC_TREE A                '+
    '    WHERE A.ID_CCUSTO = %d         ',
    [i_ccusto, i_ccpai]))) <> EmptyStr);
end;

procedure TdmFinanc.BensAfterInsert(DataSet: TDataSet);
begin
   BensID_BEM.AsInteger := i_funcNextSequence('GEN_BENS');
   BensDT_AQUISICAO.AsDateTime := funcHoje;
   BensCD_USUARIO.AsString := CD_USUARIO_LOGADO;
end;

procedure TdmFinanc.BensDT_AQUISICAOValidate(Sender: TField);
begin
  BensDT_VENDAValidate(Sender);
end;

procedure TdmFinanc.BensDT_VENDAValidate(Sender: TField);
begin
  if (not BensDT_VENDA.IsNull) and (BensDT_VENDA.AsDateTime < BensDT_AQUISICAO.AsDateTime) then
    raise Exception.Create('Data de Venda não pode ser menor que a data de aquisição');
end;

procedure TdmFinanc.BensVL_AQUISICAOValidate(Sender: TField);
begin
  procValidaFieldNumericoPositivo(Sender);
end;

procedure TdmFinanc.BensVL_ATUALValidate(Sender: TField);
begin
  procValidaFieldNumericoPositivo(Sender);
end;

function TdmFinanc.b_funcTemCategHierarquia(i_categ, i_catpai : integer) : boolean;
begin
  Result := (Trim(funcSelect(Format(
    'WITH RECURSIVE CAT_TREE AS(        '+
    '   SELECT A.ID_CATEG               '+
    '     FROM CATEGORIA A              '+
    '    WHERE A.ID_CATEG = %d          '+
    '    UNION ALL                      '+
    '                                   '+
    '   SELECT A.ID_CATEG               '+
    '     FROM CATEGORIA A              '+
    '    INNER JOIN CAT_TREE B ON       '+
    '          B.ID_CATEG = A.ID_CATPAI)'+
    '                                   '+
    '   SELECT LIST(A.ID_CATEG) LISTA   '+
    '     FROM CAT_TREE A               '+
    '    WHERE A.ID_CATEG = %d          ',
    [i_categ, i_catpai]))) <> EmptyStr);
end;

function TdmFinanc.i_funcNextSequence(s_seq: string): integer;
begin
  Result := strToInt(funcSelect('SELECT GEN_ID('+s_seq+',1) FROM RDB$DATABASE'));
end;

procedure TdmFinanc.MovimentoAfterEdit(DataSet: TDataSet);
begin
  if MovimentoVL_MOVIM.AsFloat < 0 then
  begin
     MovimentoVL_BRUTO.AsFloat := MovimentoVL_BRUTO.AsFloat * -1;
  end;
end;

procedure TdmFinanc.MovimentoAfterInsert(DataSet: TDataSet);
begin
  MovimentoID_MOVIM.AsInteger  := i_funcNextSequence('GEN_MOVIMENTO'); //i_funcProxInt('MOVIMENTO','ID_MOVIM');
  MovimentoDT_MOVIM.AsDateTime := funcHoje;
  MovimentoCD_USUARIO.AsString := CD_USUARIO_LOGADO;
  MovimentoVL_MOVIM.AsFloat    := 0;
  MovimentoVL_JUROS.AsFloat    := 0;
  MovimentoVL_DESCON.AsFloat   := 0;
  MovimentoVL_BRUTO.AsFloat    := 0;

  if id_ConPad > 0 then
    MovimentoID_CONTA.AsInteger  := id_ConPad;

  if id_CCPad > 0 then
    MovimentoID_CCUSTO.AsInteger := id_CCPad;
end;

procedure TdmFinanc.MovimentoBeforePost(DataSet: TDataSet);
begin
  if MovimentoVL_MOVIM.AsFloat = 0 then
    procMsgErro('Valor não pode ser zero!',True);

  if ((MovimentoFL_TIPO.AsString = 'R') and (MovimentoVL_MOVIM.AsFloat > 0)) or
     ((MovimentoFL_TIPO.AsString = 'D') and (MovimentoVL_MOVIM.AsFloat < 0)) then
     MovimentoVL_MOVIM.AsFloat := MovimentoVL_MOVIM.AsFloat * -1;
end;

procedure TdmFinanc.MovimentoFL_TIPOGetText(Sender: TField; var Text: string;
  DisplayText: Boolean);
begin
  procGetText(Sender, Text, DisplayText,
    'R=Retirada'+sLineBreak+
    'D=Depósito'
  );
end;

procedure TdmFinanc.MovimentoVL_BRUTOValidate(Sender: TField);
begin
  procValidaFieldNumericoPositivo(Sender);
  procCalculaMovimentoVL_MOVIM;
end;

procedure TdmFinanc.MovimentoVL_DESCONValidate(Sender: TField);
begin
   procValidaFieldNumericoPositivo(Sender);
   procCalculaMovimentoVL_MOVIM;
end;

procedure TdmFinanc.MovimentoVL_JUROSValidate(Sender: TField);
begin
  procValidaFieldNumericoPositivo(Sender);
  procCalculaMovimentoVL_MOVIM;
end;

procedure TdmFinanc.PagarReceberAfterInsert(DataSet: TDataSet);
begin
  PagarReceberID_PAGRECEB.AsInteger := i_funcNextSequence('GEN_PAGRECEB');
  PagarReceberDT_VENCTO.AsDateTime  := funcHoje;
  PagarReceberCD_USUARIO.AsString   := CD_USUARIO_LOGADO;
  PagarReceberVL_VALOR.AsFloat      := 0;
  PagarReceberVL_PAGO.AsFloat       := 0;
end;

procedure TdmFinanc.PagarReceberFL_TIPOGetText(Sender: TField; var Text: string;
  DisplayText: Boolean);
begin
  procGetText(Sender, Text, DisplayText,
    'P=Pagar'+sLineBreak+
    'R=Receber'
  );
end;

procedure TdmFinanc.PagarReceberVL_BRUTOValidate(Sender: TField);
begin
  procValidaFieldNumericoPositivo(Sender);
end;

procedure TdmFinanc.PagarReceberVL_VALORValidate(Sender: TField);
begin
  procValidaFieldNumericoPositivo(Sender);
end;

procedure TdmFinanc.PesCategoriaFL_ATIVOGetText(Sender: TField;
  var Text: string; DisplayText: Boolean);
begin
  procGetTextAtivoInativo(Sender, Text, DisplayText);
end;

procedure TdmFinanc.PesCCustoFL_ATIVOGetText(Sender: TField; var Text: string;
  DisplayText: Boolean);
begin
  procGetTextAtivoInativo(Sender, Text, DisplayText);
end;

procedure TdmFinanc.PlanoAfterInsert(DataSet: TDataSet);
begin
  PlanoID_PLANO.AsInteger  := i_funcNextSequence('GEN_PLANO');
  PlanoCD_USUARIO.AsString := CD_USUARIO_LOGADO;
  PlanoVL_VALOR.AsFloat    := 0;
  PlanoFL_ALERTA.AsString  := 'A';
end;

procedure TdmFinanc.procCalculaMovimentoVL_MOVIM;
begin
  MovimentoVL_MOVIM.AsFloat :=
     MovimentoVL_BRUTO.AsFloat -
     MovimentoVL_DESCON.AsFloat +
     MovimentoVL_JUROS.AsFloat;
end;

procedure TdmFinanc.procCriaAtualizaMovimento(i_movto,i_conta : integer; f_valor : double; s_descri, s_tipo : string; i_categ : integer; d_data : TDate; i_ccusto : integer);
begin
  dmFinanc.Movimento.Close;
  dmFinanc.Movimento.sql.Text := SQL_MOVIMENTO +
                                 ' WHERE A.CD_USUARIO = :USUARIO'+
                                 '   AND A.ID_MOVIM   = :MOVIM  ';

  dmFinanc.Movimento.ParamByName('USUARIO').AsString := CD_USUARIO_LOGADO;
  dmFinanc.Movimento.ParamByName('MOVIM').AsInteger  := i_movto;

  dmFinanc.Movimento.Open;

  if dmFinanc.Movimento.IsEmpty then
    dmFinanc.Movimento.Append
  else
    dmFinanc.Movimento.Edit;

    dmFinanc.MovimentoID_CONTA.AsInteger  := i_conta;
    dmFinanc.MovimentoVL_MOVIM.AsFloat    := f_valor;
    dmFinanc.MovimentoDS_MOVIM.AsString   := s_descri;
    dmFinanc.MovimentoFL_TIPO.AsString    := s_tipo;
    dmFinanc.MovimentoID_CATEG.AsInteger  := i_categ;
    dmFinanc.MovimentoDT_MOVIM.AsDateTime := d_data;
    dmFinanc.MovimentoID_CCUSTO.AsInteger := i_ccusto;
    dmFinanc.MovimentoCD_USUARIO.AsString := CD_USUARIO_LOGADO;

    dmFinanc.Movimento.Post;
end;

procedure TdmFinanc.procGetText(Sender: TField; var Text: string;
  DisplayText: Boolean; c_argumentos: string);
  var slArgumentos : TStrings;
      i : integer;
begin
  Text := Sender.AsString;

  if DisplayText then
  begin

    slArgumentos := TStringList.Create;
    try
      slArgumentos.Text := c_argumentos;
      for i := 0 to slArgumentos.Count -1 do
      begin

        if Text = slArgumentos.Names[i] then
        begin
          Text := slArgumentos.ValueFromIndex[i];
          Break;
        end;

      end;

    finally
      FreeAndNil(slArgumentos);
    end;

  end;
end;

procedure TdmFinanc.procGetTextAtivoInativo(Sender: TField; var Text: string;
  DisplayText: Boolean);
begin
  procGetText(Sender, Text, DisplayText,
    'A=Ativo'+sLineBreak+
    'I=Inativo'
  );
end;

procedure TdmFinanc.procInsereMascara;
var iDm, iQry : integer;
  function getFrac(iTam : integer) : string;
  var i : integer;
  begin
    result := '';
    for i := 0 to iTam - 1 do
    begin
      result := result + '0';
    end;
  end;

begin
  for iDm := 0 to self.ComponentCount - 1 do
  begin
    if self.Components[iDm].ClassType = TIBQuery then
    begin
      for iQry := 0 to TIBQuery(self.Components[iDm]).FieldCount - 1 do
      begin

        //id e inteiros
        if TIBQuery(self.Components[iDm]).Fields[iQry].ClassType = TIntegerField then
           TIntegerField(TIBQuery(self.Components[iDm]).Fields[iQry]).DisplayFormat := '###,###,###'

        //datas
        else if TIBQuery(self.Components[iDm]).Fields[iQry].ClassType = TDateField then
           TDateField(TIBQuery(self.Components[iDm]).Fields[iQry]).EditMask := '!99/99/9999;1;_'//'!99/99/9999;_'

        //Datas e horas
        else if TIBQuery(self.Components[iDm]).Fields[iQry].ClassType = TDateTimeField then
           TDateTimeField(TIBQuery(self.Components[iDm]).Fields[iQry]).EditMask := '!99/99/9999 99:99:99;1;_' // '!99/99/9999 99:99;1;_'}

        //quantidade e valores
        else if TIBQuery(self.Components[iDm]).Fields[iQry].ClassType = TIBBCDField then
          TIBBCDField(TIBQuery(self.Components[iDm]).Fields[iQry]).DisplayFormat := '###,###,##0.'+
                      getFrac(TIBBCDField(TIBQuery(self.Components[iDm]).Fields[iQry]).Size);
      end;
    end;

  end;
end;

procedure TdmFinanc.procValidaFieldNumericoMaiorQueZero(campo: TField);
begin
   if campo.IsNull then
    Exit;
  if campo.Value <= 0 then
    procMsgErro('Campo '''+campo.DisplayLabel+''' deve ser maior que zero.',True);
end;

procedure TdmFinanc.procValidaFieldNumericoPercentual(campo: TField);
begin
  if (campo.Value < 0) or (campo.Value > 100) then
    procMsgErro('Campo '''+campo.DisplayLabel+''' deve ser entre 0 e 100.',True);
end;

procedure TdmFinanc.procValidaFieldNumericoPositivo(campo: TField);
begin
  if campo.IsNull then
    exit;
  if campo.Value < 0 then
    procMsgErro('Campo '''+campo.DisplayLabel+''' deve ser maior ou igual a zero.',True);
end;

procedure TdmFinanc.TransferenciaAfterInsert(DataSet: TDataSet);
begin
  TransferenciaID_TRANSFER.AsInteger := i_funcNextSequence('GEN_TRANSF');
  TransferenciaDT_TRANSF.AsDateTime  := funcHoje;
  TransferenciaCD_USUARIO.AsString   := CD_USUARIO_LOGADO;
  TransferenciaVL_TRANSF.AsFloat     := 0;
end;

procedure TdmFinanc.TransferenciaVL_TRANSFValidate(Sender: TField);
begin
  procValidaFieldNumericoPositivo(Sender);
end;

end.
