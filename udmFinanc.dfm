object dmFinanc: TdmFinanc
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 223
  Width = 508
  object tdb: TIBTransaction
    Left = 8
    Top = 56
  end
  object db: TIBDatabase
    DatabaseName = 'localhost:d:\projetos\financ\fontes\financ.fdb'
    Params.Strings = (
      'user_name=sysdba'
      'password=feijokey')
    LoginPrompt = False
    DefaultTransaction = tdb
    ServerType = 'IBServer'
    Left = 8
    Top = 8
  end
  object Conta: TIBQuery
    Database = db
    Transaction = tdb
    AfterInsert = ContaAfterInsert
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'SELECT A.*,'
      '       (SELECT CAST(SUM(IIF(B.FL_TIPO = '#39'D'#39','
      '                            B.VL_MOVIM,'
      '                            B.VL_MOVIM * -1)) AS VL_08_02)'
      '          FROM MOVIMENTO B'
      '         WHERE B.ID_CONTA = A.ID_CONTA) VL_SALDO'
      'FROM CONTA A WHERE A.ID_CONTA = -1')
    UpdateObject = uConta
    Left = 56
    Top = 8
    object ContaID_CONTA: TIntegerField
      DisplayLabel = 'Cd. Conta'
      FieldName = 'ID_CONTA'
      Origin = '"CONTA"."ID_CONTA"'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object ContaCD_USUARIO: TIBStringField
      DisplayLabel = 'Usu'#225'rio'
      FieldName = 'CD_USUARIO'
      Origin = '"CONTA"."CD_USUARIO"'
      Required = True
    end
    object ContaNR_CONTA: TIntegerField
      DisplayLabel = 'N'#250'mero'
      FieldName = 'NR_CONTA'
      Origin = '"CONTA"."NR_CONTA"'
    end
    object ContaDS_CONTA: TIBStringField
      DisplayLabel = 'Descri'#231#227'o da Conta'
      FieldName = 'DS_CONTA'
      Origin = '"CONTA"."DS_CONTA"'
      Required = True
      Size = 60
    end
    object ContaVL_SALDO: TIBBCDField
      DisplayLabel = 'Saldo'
      FieldName = 'VL_SALDO'
      ProviderFlags = []
      Precision = 18
      Size = 2
    end
    object ContaFL_ATIVO: TIBStringField
      DisplayLabel = 'Ativo'
      FieldName = 'FL_ATIVO'
      Origin = '"CONTA"."FL_ATIVO"'
      OnGetText = ContaFL_ATIVOGetText
      Size = 1
    end
  end
  object uConta: TIBUpdateSQL
    RefreshSQL.Strings = (
      'SELECT A.*,'
      '       (SELECT CAST(SUM(IIF(B.FL_TIPO = '#39'D'#39','
      '                            B.VL_MOVIM,'
      '                            B.VL_MOVIM * -1)) AS VL_08_02)'
      '          FROM MOVIMENTO B'
      '         WHERE B.ID_CONTA = A.ID_CONTA) VL_SALDO'
      'FROM CONTA A WHERE A.ID_CONTA = :ID_CONTA')
    ModifySQL.Strings = (
      'update CONTA'
      'set'
      '  CD_USUARIO = :CD_USUARIO,'
      '  DS_CONTA = :DS_CONTA,'
      '  FL_ATIVO = :FL_ATIVO,'
      '  ID_CONTA = :ID_CONTA,'
      '  NR_CONTA = :NR_CONTA'
      'where'
      '  ID_CONTA = :OLD_ID_CONTA')
    InsertSQL.Strings = (
      'insert into CONTA'
      '  (CD_USUARIO, DS_CONTA, FL_ATIVO, ID_CONTA, NR_CONTA)'
      'values'
      '  (:CD_USUARIO, :DS_CONTA, :FL_ATIVO, :ID_CONTA, :NR_CONTA)')
    DeleteSQL.Strings = (
      'delete from CONTA'
      'where'
      '  ID_CONTA = :OLD_ID_CONTA')
    Left = 93
    Top = 8
  end
  object dConta: TDataSource
    DataSet = Conta
    Left = 128
    Top = 8
  end
  object Movimento: TIBQuery
    Database = db
    Transaction = tdb
    AfterEdit = MovimentoAfterEdit
    AfterInsert = MovimentoAfterInsert
    BeforePost = MovimentoBeforePost
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'SELECT DISTINCT A.*,'
      '       A.VL_MOVIM +'
      '       IIF (A.VL_MOVIM < 0,'
      '          A.VL_JUROS - A.VL_DESCON,'
      '          - A.VL_JUROS + A.VL_DESCON)'
      '       VL_BRUTO,'
      '       B.NR_CONTA,'
      '       B.DS_CONTA,'
      '       E.DS_CCUSTO,'
      '       CASE A.ID_MOVIM'
      '          WHEN D.ID_MOVDEB  THEN (SELECT F.DS_CONTA'
      '                                    FROM MOVIMENTO E'
      
        '                                   INNER JOIN CONTA F ON F.ID_CO' +
        'NTA = E.ID_CONTA'
      
        '                                   WHERE E.ID_MOVIM = D.ID_MOVCR' +
        'E)'
      '          WHEN D.ID_MOVCRE  THEN (SELECT F.DS_CONTA'
      '                                    FROM MOVIMENTO E'
      
        '                                   INNER JOIN CONTA F ON F.ID_CO' +
        'NTA = E.ID_CONTA'
      
        '                                   WHERE E.ID_MOVIM = D.ID_MOVDE' +
        'B)'
      '          ELSE C.DS_CATEG'
      '       END DS_CATEG'
      '  FROM MOVIMENTO A'
      ' INNER JOIN CONTA B ON B.ID_CONTA = A.ID_CONTA'
      ' INNER JOIN CATEGORIA C ON C.ID_CATEG = A.ID_CATEG'
      
        '  LEFT JOIN TRANSFERENCIA D ON (D.ID_MOVDEB = A.ID_MOVIM OR D.ID' +
        '_MOVCRE = A.ID_MOVIM)'
      ' INNER JOIN CCUSTO E ON E.ID_CCUSTO = A.ID_CCUSTO'
      'WHERE A.ID_MOVIM = -1')
    UpdateObject = uMovimento
    Left = 176
    Top = 8
    object MovimentoID_MOVIM: TIntegerField
      DisplayLabel = 'Cd. Mov.'
      FieldName = 'ID_MOVIM'
      Origin = '"MOVIMENTO"."ID_MOVIM"'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object MovimentoID_CONTA: TIntegerField
      DisplayLabel = 'Cd. Conta'
      FieldName = 'ID_CONTA'
      Origin = '"MOVIMENTO"."ID_CONTA"'
      Required = True
    end
    object MovimentoDS_CONTA: TIBStringField
      DisplayLabel = 'Descri'#231#227'o da Conta'
      FieldName = 'DS_CONTA'
      Origin = '"CONTA"."DS_CONTA"'
      Size = 60
    end
    object MovimentoID_CATEG: TIntegerField
      DisplayLabel = 'Categoria'
      FieldName = 'ID_CATEG'
      Origin = '"MOVIMENTO"."ID_CATEG"'
      Required = True
    end
    object MovimentoDS_CATEG: TIBStringField
      DisplayLabel = 'Descri'#231#227'o da Categoria'
      FieldName = 'DS_CATEG'
      Origin = '"CATEGORIA"."DS_CATEG"'
      Size = 60
    end
    object MovimentoVL_MOVIM: TIBBCDField
      DisplayLabel = 'Valor Liq'
      FieldName = 'VL_MOVIM'
      Origin = '"MOVIMENTO"."VL_MOVIM"'
      Required = True
      Precision = 18
      Size = 2
    end
    object MovimentoDS_MOVIM: TIBStringField
      DisplayLabel = 'Descri'#231#227'o'
      FieldName = 'DS_MOVIM'
      Origin = '"MOVIMENTO"."DS_MOVIM"'
      Required = True
      Size = 60
    end
    object MovimentoNR_CONTA: TIntegerField
      DisplayLabel = 'Nr. Conta'
      FieldName = 'NR_CONTA'
      Origin = '"CONTA"."NR_CONTA"'
    end
    object MovimentoFL_TIPO: TIBStringField
      DisplayLabel = 'Tipo'
      FieldName = 'FL_TIPO'
      Origin = '"MOVIMENTO"."FL_TIPO"'
      Required = True
      OnGetText = MovimentoFL_TIPOGetText
      Size = 1
    end
    object MovimentoDT_MOVIM: TDateField
      DisplayLabel = 'Data'
      FieldName = 'DT_MOVIM'
      Origin = '"MOVIMENTO"."DT_MOVIM"'
      Required = True
    end
    object MovimentoCD_USUARIO: TIBStringField
      DisplayLabel = 'Usu'#225'rio'
      FieldName = 'CD_USUARIO'
      Origin = '"MOVIMENTO"."CD_USUARIO"'
      Required = True
    end
    object MovimentoID_PAGRECEB: TIntegerField
      DisplayLabel = 'Cd. Pagar/Receber'
      FieldName = 'ID_PAGRECEB'
      Origin = '"MOVIMENTO"."ID_PAGRECEB"'
    end
    object MovimentoID_CCUSTO: TIntegerField
      DisplayLabel = 'C. Custos'
      FieldName = 'ID_CCUSTO'
      Origin = '"MOVIMENTO"."ID_CCUSTO"'
      Required = True
    end
    object MovimentoDS_CCUSTO: TIBStringField
      DisplayLabel = 'Descri'#231#227'o do Centro de Custos'
      FieldName = 'DS_CCUSTO'
      Origin = '"CCUSTO"."DS_CCUSTO"'
      Size = 60
    end
    object MovimentoVL_JUROS: TIBBCDField
      DisplayLabel = 'Juros'
      FieldName = 'VL_JUROS'
      Origin = '"MOVIMENTO"."VL_JUROS"'
      Required = True
      OnValidate = MovimentoVL_JUROSValidate
      Precision = 18
      Size = 2
    end
    object MovimentoVL_DESCON: TIBBCDField
      DisplayLabel = 'Desconto'
      FieldName = 'VL_DESCON'
      Origin = '"MOVIMENTO"."VL_DESCON"'
      Required = True
      OnValidate = MovimentoVL_DESCONValidate
      Precision = 18
      Size = 2
    end
    object MovimentoVL_BRUTO: TIBBCDField
      DisplayLabel = 'Valor Bruto'
      FieldName = 'VL_BRUTO'
      ProviderFlags = []
      Required = True
      OnValidate = MovimentoVL_BRUTOValidate
      Precision = 18
      Size = 2
    end
  end
  object uMovimento: TIBUpdateSQL
    RefreshSQL.Strings = (
      'SELECT DISTINCT A.*,'
      '       A.VL_MOVIM +'
      '       IIF (A.VL_MOVIM < 0,'
      '          -A.VL_JUROS +A.VL_DESCON,'
      '          A.VL_JUROS -A.VL_DESCON)'
      '       VL_BRUTO,'
      '       B.NR_CONTA,'
      '       B.DS_CONTA,'
      '       E.DS_CCUSTO,'
      '       CASE A.ID_MOVIM'
      '          WHEN D.ID_MOVDEB  THEN (SELECT F.DS_CONTA'
      '                                    FROM MOVIMENTO E'
      
        '                                   INNER JOIN CONTA F ON F.ID_CO' +
        'NTA = E.ID_CONTA'
      
        '                                   WHERE E.ID_MOVIM = D.ID_MOVCR' +
        'E)'
      '          WHEN D.ID_MOVCRE  THEN (SELECT F.DS_CONTA'
      '                                    FROM MOVIMENTO E'
      
        '                                   INNER JOIN CONTA F ON F.ID_CO' +
        'NTA = E.ID_CONTA'
      
        '                                   WHERE E.ID_MOVIM = D.ID_MOVDE' +
        'B)'
      '          ELSE C.DS_CATEG'
      '       END DS_CATEG'
      '  FROM MOVIMENTO A'
      ' INNER JOIN CONTA B ON B.ID_CONTA = A.ID_CONTA'
      ' INNER JOIN CATEGORIA C ON C.ID_CATEG = A.ID_CATEG'
      
        '  LEFT JOIN TRANSFERENCIA D ON (D.ID_MOVDEB = A.ID_MOVIM OR D.ID' +
        '_MOVCRE = A.ID_MOVIM)'
      ' INNER JOIN CCUSTO E ON E.ID_CCUSTO = A.ID_CCUSTO'
      'WHERE ID_MOVIM = :ID_MOVIM')
    ModifySQL.Strings = (
      'update MOVIMENTO'
      'set'
      '  CD_USUARIO = :CD_USUARIO,'
      '  DS_MOVIM = :DS_MOVIM,'
      '  DT_MOVIM = :DT_MOVIM,'
      '  FL_TIPO = :FL_TIPO,'
      '  ID_CATEG = :ID_CATEG,'
      '  ID_CCUSTO = :ID_CCUSTO,'
      '  ID_CONTA = :ID_CONTA,'
      '  ID_MOVIM = :ID_MOVIM,'
      '  ID_PAGRECEB = :ID_PAGRECEB,'
      '  VL_DESCON = :VL_DESCON,'
      '  VL_JUROS = :VL_JUROS,'
      '  VL_MOVIM = :VL_MOVIM'
      'where'
      '  ID_MOVIM = :OLD_ID_MOVIM')
    InsertSQL.Strings = (
      'insert into MOVIMENTO'
      
        '  (CD_USUARIO, DS_MOVIM, DT_MOVIM, FL_TIPO, ID_CATEG, ID_CCUSTO,' +
        ' ID_CONTA, '
      '   ID_MOVIM, ID_PAGRECEB, VL_DESCON, VL_JUROS, VL_MOVIM)'
      'values'
      
        '  (:CD_USUARIO, :DS_MOVIM, :DT_MOVIM, :FL_TIPO, :ID_CATEG, :ID_C' +
        'CUSTO, '
      
        '   :ID_CONTA, :ID_MOVIM, :ID_PAGRECEB, :VL_DESCON, :VL_JUROS, :V' +
        'L_MOVIM)')
    DeleteSQL.Strings = (
      'delete from MOVIMENTO'
      'where'
      '  ID_MOVIM = :OLD_ID_MOVIM')
    Left = 213
    Top = 8
  end
  object dMovimento: TDataSource
    DataSet = Movimento
    Left = 248
    Top = 8
  end
  object Categoria: TIBQuery
    Database = db
    Transaction = tdb
    AfterInsert = CategoriaAfterInsert
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'SELECT A.*'
      '  FROM CATEGORIA A'
      'WHERE A.ID_CATEG = -1                 ')
    UpdateObject = UCategoria
    Left = 296
    Top = 8
    object CategoriaID_CATEG: TIntegerField
      DisplayLabel = 'Cd. Categ'
      FieldName = 'ID_CATEG'
      Origin = '"CATEGORIA"."ID_CATEG"'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object CategoriaCD_USUARIO: TIBStringField
      DisplayLabel = 'Usu'#225'rio'
      FieldName = 'CD_USUARIO'
      Origin = '"CATEGORIA"."CD_USUARIO"'
      Required = True
    end
    object CategoriaID_CATPAI: TIntegerField
      DisplayLabel = 'Cat. Pai'
      FieldName = 'ID_CATPAI'
      Origin = '"CATEGORIA"."ID_CATPAI"'
      Required = True
    end
    object CategoriaDS_CATEG: TIBStringField
      DisplayLabel = 'Descri'#231#227'o Categoria'
      FieldName = 'DS_CATEG'
      Origin = '"CATEGORIA"."DS_CATEG"'
      Required = True
      Size = 60
    end
    object CategoriaFL_TIPO: TIBStringField
      DisplayLabel = 'Tipo'
      FieldName = 'FL_TIPO'
      Origin = '"CATEGORIA"."FL_TIPO"'
      Required = True
      OnGetText = CategoriaFL_TIPOGetText
      Size = 1
    end
    object CategoriaFL_ATIVO: TIBStringField
      DisplayLabel = 'Ativo'
      FieldName = 'FL_ATIVO'
      Origin = '"CATEGORIA"."FL_ATIVO"'
      OnGetText = CategoriaFL_ATIVOGetText
      Size = 1
    end
  end
  object UCategoria: TIBUpdateSQL
    RefreshSQL.Strings = (
      'SELECT A.*'
      '  FROM CATEGORIA A'
      'WHERE A.ID_CATEG = :ID_CATEG')
    ModifySQL.Strings = (
      'update categoria'
      'set'
      '  CD_USUARIO = :CD_USUARIO,'
      '  DS_CATEG = :DS_CATEG,'
      '  FL_TIPO = :FL_TIPO,'
      '  ID_CATEG = :ID_CATEG,'
      '  ID_CATPAI = :ID_CATPAI,'
      '  FL_ATIVO = :FL_ATIVO'
      'where'
      '  ID_CATEG = :OLD_ID_CATEG')
    InsertSQL.Strings = (
      'insert into categoria'
      '  (CD_USUARIO, DS_CATEG, FL_TIPO, ID_CATEG, ID_CATPAI, FL_ATIVO)'
      'values'
      
        '  (:CD_USUARIO, :DS_CATEG, :FL_TIPO, :ID_CATEG, :ID_CATPAI, :FL_' +
        'ATIVO)')
    DeleteSQL.Strings = (
      'delete from categoria'
      'where'
      '  ID_CATEG = :OLD_ID_CATEG')
    Left = 333
    Top = 8
  end
  object DCategoria: TDataSource
    DataSet = Categoria
    Left = 368
    Top = 8
  end
  object PesCategoria: TIBQuery
    Database = db
    Transaction = tdb
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'SELECT A.* '
      '  FROM CATEGORIA A'
      'WHERE A.ID_CATEG = -1             ')
    Left = 408
    Top = 8
    object PesCategoriaID_CATEG: TIntegerField
      DisplayLabel = 'Cod. Categoria'
      FieldName = 'ID_CATEG'
      Origin = '"CATEGORIA"."ID_CATEG"'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object PesCategoriaCD_USUARIO: TIBStringField
      DisplayLabel = 'Usu'#225'rio'
      FieldName = 'CD_USUARIO'
      Origin = '"CATEGORIA"."CD_USUARIO"'
      Required = True
    end
    object PesCategoriaID_CATPAI: TIntegerField
      DisplayLabel = 'Cat. Pai'
      FieldName = 'ID_CATPAI'
      Origin = '"CATEGORIA"."ID_CATPAI"'
    end
    object PesCategoriaDS_CATEG: TIBStringField
      DisplayLabel = 'Descri'#231#227'o da Categoria'
      FieldName = 'DS_CATEG'
      Origin = '"CATEGORIA"."DS_CATEG"'
      Required = True
      Size = 60
    end
    object PesCategoriaFL_TIPO: TIBStringField
      DisplayLabel = 'Tipo'
      FieldName = 'FL_TIPO'
      Origin = '"CATEGORIA"."FL_TIPO"'
      Required = True
      OnGetText = CategoriaFL_TIPOGetText
      Size = 1
    end
    object PesCategoriaFL_ATIVO: TIBStringField
      DisplayLabel = 'Ativo'
      FieldName = 'FL_ATIVO'
      Origin = '"CATEGORIA"."FL_ATIVO"'
      OnGetText = PesCategoriaFL_ATIVOGetText
      Size = 1
    end
  end
  object dPesCategoria: TDataSource
    DataSet = PesCategoria
    Left = 448
    Top = 8
  end
  object Transferencia: TIBQuery
    Database = db
    Transaction = tdb
    AfterInsert = TransferenciaAfterInsert
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'SELECT A.*,'
      '       E.ID_CONTA ID_CDEB,'
      '       E.DS_CONTA DS_CDEB,'
      '       E.NR_CONTA NR_CDEB,'
      '       D.ID_CONTA ID_CCRED,'
      '       D.DS_CONTA DS_CCRED,'
      '       D.NR_CONTA NR_CCRED'
      '  FROM TRANSFERENCIA A'
      ' INNER JOIN MOVIMENTO B ON B.ID_MOVIM = A.ID_MOVCRE'
      ' INNER JOIN CONTA     D ON D.ID_CONTA = B.ID_CONTA'
      ' INNER JOIN MOVIMENTO C ON C.ID_MOVIM = A.ID_MOVDEB'
      ' INNER JOIN CONTA     E ON E.ID_CONTA = C.ID_CONTA')
    UpdateObject = uTransferencia
    Left = 176
    Top = 56
    object TransferenciaID_TRANSFER: TIntegerField
      DisplayLabel = 'Cd. Transf.'
      FieldName = 'ID_TRANSFER'
      Origin = '"TRANSFERENCIA"."ID_TRANSFER"'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object TransferenciaID_MOVDEB: TIntegerField
      DisplayLabel = 'Mov. Deb.'
      FieldName = 'ID_MOVDEB'
      Origin = '"TRANSFERENCIA"."ID_MOVDEB"'
    end
    object TransferenciaID_MOVCRE: TIntegerField
      DisplayLabel = 'Mov. Cred.'
      FieldName = 'ID_MOVCRE'
      Origin = '"TRANSFERENCIA"."ID_MOVCRE"'
    end
    object TransferenciaDS_TRANSF: TIBStringField
      DisplayLabel = 'Descri'#231#227'o'
      FieldName = 'DS_TRANSF'
      Origin = '"TRANSFERENCIA"."DS_TRANSF"'
      Required = True
      Size = 60
    end
    object TransferenciaDT_TRANSF: TDateField
      DisplayLabel = 'Data'
      FieldName = 'DT_TRANSF'
      Origin = '"TRANSFERENCIA"."DT_TRANSF"'
      Required = True
    end
    object TransferenciaVL_TRANSF: TIBBCDField
      DisplayLabel = 'Valor'
      FieldName = 'VL_TRANSF'
      Origin = '"TRANSFERENCIA"."VL_TRANSF"'
      Required = True
      OnValidate = TransferenciaVL_TRANSFValidate
      Precision = 18
      Size = 2
    end
    object TransferenciaDS_CDEB: TIBStringField
      DisplayLabel = 'Conta D'#233'bito'
      FieldName = 'DS_CDEB'
      Origin = '"CONTA"."DS_CONTA"'
      Size = 60
    end
    object TransferenciaID_CDEB: TIntegerField
      DisplayLabel = 'Cd. C. Deb'
      FieldName = 'ID_CDEB'
      Origin = '"CONTA"."ID_CONTA"'
      Required = True
    end
    object TransferenciaNR_CDEB: TIntegerField
      DisplayLabel = 'Cd. C. Deb'
      FieldName = 'NR_CDEB'
      Origin = '"CONTA"."NR_CONTA"'
    end
    object TransferenciaID_CCRED: TIntegerField
      DisplayLabel = 'Cd. C. Cred'
      FieldName = 'ID_CCRED'
      Origin = '"CONTA"."ID_CONTA"'
      Required = True
    end
    object TransferenciaDS_CCRED: TIBStringField
      DisplayLabel = 'Conta de Cr'#233'dito'
      FieldName = 'DS_CCRED'
      Origin = '"CONTA"."DS_CONTA"'
      Size = 60
    end
    object TransferenciaNR_CCRED: TIntegerField
      DisplayLabel = 'Nr. C. Cred.'
      FieldName = 'NR_CCRED'
      Origin = '"CONTA"."NR_CONTA"'
    end
    object TransferenciaCD_USUARIO: TIBStringField
      DisplayLabel = 'Usu'#225'rio'
      FieldName = 'CD_USUARIO'
      Origin = '"TRANSFERENCIA"."CD_USUARIO"'
      Required = True
    end
  end
  object uTransferencia: TIBUpdateSQL
    RefreshSQL.Strings = (
      'Select '
      '  ID_TRANSFER,'
      '  ID_MOVDEB,'
      '  ID_MOVCRE,'
      '  DS_TRANSF,'
      '  DT_TRANSF,'
      '  VL_TRANSF,'
      '  CD_USUARIO,'
      '  ID_CDEB,'
      '  DS_CDEB,'
      '  NR_CDEB,'
      '  ID_CCRED,'
      '  DS_CCRED,'
      '  NR_CCRED'
      'from TRANSFERENCIA '
      'where'
      '  ID_TRANSFER = :ID_TRANSFER')
    ModifySQL.Strings = (
      'update TRANSFERENCIA'
      'set'
      '  CD_USUARIO = :CD_USUARIO,'
      '  DS_TRANSF = :DS_TRANSF,'
      '  DT_TRANSF = :DT_TRANSF,'
      '  ID_MOVCRE = :ID_MOVCRE,'
      '  ID_MOVDEB = :ID_MOVDEB,'
      '  ID_TRANSFER = :ID_TRANSFER,'
      '  VL_TRANSF = :VL_TRANSF'
      'where'
      '  ID_TRANSFER = :OLD_ID_TRANSFER')
    InsertSQL.Strings = (
      'insert into TRANSFERENCIA'
      
        '  (CD_USUARIO, DS_TRANSF, DT_TRANSF, ID_MOVCRE, ID_MOVDEB, ID_TR' +
        'ANSFER, '
      '   VL_TRANSF)'
      'values'
      
        '  (:CD_USUARIO, :DS_TRANSF, :DT_TRANSF, :ID_MOVCRE, :ID_MOVDEB, ' +
        ':ID_TRANSFER, '
      '   :VL_TRANSF)')
    DeleteSQL.Strings = (
      'delete from TRANSFERENCIA'
      'where'
      '  ID_TRANSFER = :OLD_ID_TRANSFER')
    Left = 213
    Top = 56
  end
  object dTransferencia: TDataSource
    DataSet = Transferencia
    Left = 248
    Top = 56
  end
  object cdsAnalise: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 8
    Top = 109
    object cdsAnaliseID_CATEG: TIntegerField
      FieldName = 'ID_CATEG'
    end
    object cdsAnaliseCATEG: TStringField
      FieldName = 'CATEG'
      Size = 100
    end
    object cdsAnaliseVALOR: TFloatField
      FieldName = 'VALOR'
    end
    object cdsAnaliseNIVEL: TIntegerField
      FieldName = 'NIVEL'
    end
    object cdsAnaliseFL_TIPO: TStringField
      FieldName = 'FL_TIPO'
      Size = 1
    end
    object cdsAnaliseB_PAI: TBooleanField
      FieldName = 'B_PAI'
    end
  end
  object PagarReceber: TIBQuery
    Database = db
    Transaction = tdb
    AfterInsert = PagarReceberAfterInsert
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'SELECT A.*,'
      '       B.DS_CATEG,                                         '
      
        '       (SELECT COALESCE(SUM(IIF(C.FL_TIPO = '#39'R'#39', -C.VL_MOVIM, C.' +
        'VL_MOVIM)),0)'
      '                FROM MOVIMENTO C'
      '               WHERE C.ID_PAGRECEB = A.ID_PAGRECEB) VL_PAGO'
      ''
      '  FROM PAGRECEB A                                          '
      ' INNER JOIN CATEGORIA B ON B.ID_CATEG = A.ID_CATEG'
      'WHERE A.ID_PAGRECEB = -1'
      '')
    UpdateObject = uPagarReceber
    Left = 56
    Top = 56
    object PagarReceberID_PAGRECEB: TIntegerField
      DisplayLabel = 'Cod.'
      FieldName = 'ID_PAGRECEB'
      Origin = '"PAGRECEB"."ID_PAGRECEB"'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object PagarReceberCD_USUARIO: TIBStringField
      DisplayLabel = 'Usu'#225'rio'
      FieldName = 'CD_USUARIO'
      Origin = '"PAGRECEB"."CD_USUARIO"'
      Required = True
    end
    object PagarReceberID_CATEG: TIntegerField
      DisplayLabel = 'Cd.Cat.'
      FieldName = 'ID_CATEG'
      Origin = '"PAGRECEB"."ID_CATEG"'
      Required = True
    end
    object PagarReceberDS_CATEG: TIBStringField
      DisplayLabel = 'Desc. Categoria'
      FieldName = 'DS_CATEG'
      Origin = '"CATEGORIA"."DS_CATEG"'
      Size = 60
    end
    object PagarReceberVL_VALOR: TIBBCDField
      DisplayLabel = 'Total'
      FieldName = 'VL_VALOR'
      Origin = '"PAGRECEB"."VL_VALOR"'
      Required = True
      OnValidate = PagarReceberVL_VALORValidate
      Precision = 18
      Size = 2
    end
    object PagarReceberDT_VENCTO: TDateField
      DisplayLabel = 'Vencto'
      FieldName = 'DT_VENCTO'
      Origin = '"PAGRECEB"."DT_VENCTO"'
      Required = True
    end
    object PagarReceberFL_TIPO: TIBStringField
      DisplayLabel = 'Tipo'
      FieldName = 'FL_TIPO'
      Origin = '"PAGRECEB"."FL_TIPO"'
      Required = True
      OnGetText = PagarReceberFL_TIPOGetText
      Size = 1
    end
    object PagarReceberDS_DESCRI: TIBStringField
      DisplayLabel = 'Descri'#231#227'o'
      FieldName = 'DS_DESCRI'
      Origin = '"PAGRECEB"."DS_DESCRI"'
      Required = True
      Size = 60
    end
    object PagarReceberVL_PAGO: TIBBCDField
      DisplayLabel = 'Pago/Receb.'
      FieldName = 'VL_PAGO'
      ProviderFlags = []
      Precision = 18
      Size = 2
    end
    object PagarReceberNR_DOCTO: TIBStringField
      DisplayLabel = 'Docto'
      FieldName = 'NR_DOCTO'
      Origin = '"PAGRECEB"."NR_DOCTO"'
      Size = 15
    end
  end
  object uPagarReceber: TIBUpdateSQL
    RefreshSQL.Strings = (
      'Select '
      '  ID_PAGRECEB,'
      '  CD_USUARIO,'
      '  ID_CATEG,'
      '  VL_VALOR,'
      '  DT_VENCTO,'
      '  FL_TIPO,'
      '  NR_DOCTO,'
      '  DS_DESCRI,'
      '  DS_CATEG,'
      '  DS_TIPO,'
      '  VL_PAGO'
      'from PAGRECEB '
      'where'
      '  ID_PAGRECEB = :ID_PAGRECEB')
    ModifySQL.Strings = (
      'update PAGRECEB'
      'set'
      '  CD_USUARIO = :CD_USUARIO,'
      '  DS_DESCRI = :DS_DESCRI,'
      '  DT_VENCTO = :DT_VENCTO,'
      '  FL_TIPO = :FL_TIPO,'
      '  ID_CATEG = :ID_CATEG,'
      '  ID_PAGRECEB = :ID_PAGRECEB,'
      '  NR_DOCTO = :NR_DOCTO,'
      '  VL_VALOR = :VL_VALOR'
      'where'
      '  ID_PAGRECEB = :OLD_ID_PAGRECEB')
    InsertSQL.Strings = (
      'insert into PAGRECEB'
      
        '  (CD_USUARIO, DS_DESCRI, DT_VENCTO, FL_TIPO, ID_CATEG, ID_PAGRE' +
        'CEB, NR_DOCTO, '
      '   VL_VALOR)'
      'values'
      
        '  (:CD_USUARIO, :DS_DESCRI, :DT_VENCTO, :FL_TIPO, :ID_CATEG, :ID' +
        '_PAGRECEB, '
      '   :NR_DOCTO, :VL_VALOR)')
    DeleteSQL.Strings = (
      'delete from PAGRECEB'
      'where'
      '  ID_PAGRECEB = :OLD_ID_PAGRECEB')
    Left = 93
    Top = 56
  end
  object dPagarReceber: TDataSource
    DataSet = PagarReceber
    Left = 128
    Top = 56
  end
  object cdsAnual: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 8
    Top = 157
    object cdsAnualID_CATEG: TIntegerField
      FieldName = 'ID_CATEG'
    end
    object cdsAnualCATEG: TStringField
      FieldName = 'CATEG'
      Size = 100
    end
    object cdsAnualNIVEL: TIntegerField
      FieldName = 'NIVEL'
    end
    object cdsAnualFL_TIPO: TStringField
      FieldName = 'FL_TIPO'
      Size = 1
    end
    object cdsAnualB_PAI: TBooleanField
      FieldName = 'B_PAI'
    end
    object cdsAnualVL_M1: TFloatField
      FieldName = 'VL_M1'
    end
    object cdsAnualVL_M2: TFloatField
      FieldName = 'VL_M2'
    end
    object cdsAnualVL_M3: TFloatField
      FieldName = 'VL_M3'
    end
    object cdsAnualVL_M4: TFloatField
      FieldName = 'VL_M4'
    end
    object cdsAnualVL_M5: TFloatField
      FieldName = 'VL_M5'
    end
    object cdsAnualVL_M6: TFloatField
      FieldName = 'VL_M6'
    end
    object cdsAnualVL_M7: TFloatField
      FieldName = 'VL_M7'
    end
    object cdsAnualVL_M8: TFloatField
      FieldName = 'VL_M8'
    end
    object cdsAnualVL_M9: TFloatField
      FieldName = 'VL_M9'
    end
    object cdsAnualVL_M10: TFloatField
      FieldName = 'VL_M10'
    end
    object cdsAnualVL_M11: TFloatField
      FieldName = 'VL_M11'
    end
    object cdsAnualVL_M12: TFloatField
      FieldName = 'VL_M12'
    end
  end
  object CCusto: TIBQuery
    Database = db
    Transaction = tdb
    AfterInsert = CCustoAfterInsert
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'SELECT A.* FROM CCUSTO A WHERE A.ID_CCUSTO = -1')
    UpdateObject = uCCusto
    Left = 296
    Top = 56
    object CCustoID_CCUSTO: TIntegerField
      DisplayLabel = 'C.Custo'
      FieldName = 'ID_CCUSTO'
      Origin = '"CCUSTO"."ID_CCUSTO"'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object CCustoCD_USUARIO: TIBStringField
      DisplayLabel = 'Usu'#225'rio'
      FieldName = 'CD_USUARIO'
      Origin = '"CCUSTO"."CD_USUARIO"'
      Required = True
    end
    object CCustoID_CCPAI: TIntegerField
      DisplayLabel = 'C.Custo Pai'
      FieldName = 'ID_CCPAI'
      Origin = '"CCUSTO"."ID_CCPAI"'
    end
    object CCustoDS_CCUSTO: TIBStringField
      DisplayLabel = 'Descri'#231#227'o Centro de Custo'
      FieldName = 'DS_CCUSTO'
      Origin = '"CCUSTO"."DS_CCUSTO"'
      Required = True
      Size = 60
    end
    object CCustoFL_ATIVO: TIBStringField
      DisplayLabel = 'Ativo'
      FieldName = 'FL_ATIVO'
      Origin = '"CCUSTO"."FL_ATIVO"'
      OnGetText = CCustoFL_ATIVOGetText
      Size = 1
    end
  end
  object uCCusto: TIBUpdateSQL
    RefreshSQL.Strings = (
      'Select '
      '  ID_CCUSTO,'
      '  CD_USUARIO,'
      '  ID_CCPAI,'
      '  DS_CCUSTO,'
      '  FL_ATIVO'
      'from CCUSTO '
      'where'
      '  ID_CCUSTO = :ID_CCUSTO')
    ModifySQL.Strings = (
      'update CCUSTO'
      'set'
      '  CD_USUARIO = :CD_USUARIO,'
      '  DS_CCUSTO = :DS_CCUSTO,'
      '  ID_CCPAI = :ID_CCPAI,'
      '  ID_CCUSTO = :ID_CCUSTO,'
      '  FL_ATIVO = :FL_ATIVO'
      'where'
      '  ID_CCUSTO = :OLD_ID_CCUSTO')
    InsertSQL.Strings = (
      'insert into CCUSTO'
      '  (CD_USUARIO, DS_CCUSTO, ID_CCPAI, ID_CCUSTO, FL_ATIVO)'
      'values'
      '  (:CD_USUARIO, :DS_CCUSTO, :ID_CCPAI, :ID_CCUSTO, :FL_ATIVO)')
    DeleteSQL.Strings = (
      'delete from CCUSTO'
      'where'
      '  ID_CCUSTO = :OLD_ID_CCUSTO')
    Left = 333
    Top = 56
  end
  object dCCusto: TDataSource
    DataSet = CCusto
    Left = 368
    Top = 56
  end
  object PesCCusto: TIBQuery
    Database = db
    Transaction = tdb
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'SELECT A.* FROM CCUSTO A WHERE A.ID_CCUSTO = -1')
    Left = 408
    Top = 56
    object PesCCustoID_CCUSTO: TIntegerField
      DisplayLabel = 'C.Custo'
      FieldName = 'ID_CCUSTO'
      Origin = '"CCUSTO"."ID_CCUSTO"'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object PesCCustoCD_USUARIO: TIBStringField
      DisplayLabel = 'Usu'#225'rio'
      FieldName = 'CD_USUARIO'
      Origin = '"CCUSTO"."CD_USUARIO"'
      Required = True
    end
    object PesCCustoID_CCPAI: TIntegerField
      DisplayLabel = 'C.Custo Pai'
      FieldName = 'ID_CCPAI'
      Origin = '"CCUSTO"."ID_CCPAI"'
    end
    object PesCCustoDS_CCUSTO: TIBStringField
      DisplayLabel = 'Descri'#231#227'o Centro de Custo'
      FieldName = 'DS_CCUSTO'
      Origin = '"CCUSTO"."DS_CCUSTO"'
      Required = True
      Size = 60
    end
    object PesCCustoFL_ATIVO: TIBStringField
      DisplayLabel = 'Ativo'
      FieldName = 'FL_ATIVO'
      Origin = '"CCUSTO"."FL_ATIVO"'
      OnGetText = PesCCustoFL_ATIVOGetText
      Size = 1
    end
  end
  object dPesCCusto: TDataSource
    DataSet = PesCCusto
    Left = 440
    Top = 56
  end
  object Plano: TIBQuery
    Database = db
    Transaction = tdb
    AfterInsert = PlanoAfterInsert
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'SELECT A.*,'
      '       B.DS_CATEG,'
      '       C.DS_CCUSTO,'
      '       IIF(A.FL_ALERTA = '#39'A'#39', '#39'Alerta'#39', '#39'Barra'#39') DS_ACAO'
      '  FROM PLANO A'
      '  LEFT JOIN CATEGORIA B ON B.ID_CATEG = A.ID_CATEG'
      '  LEFT JOIN CCUSTO C ON C.ID_CCUSTO = A.ID_CCUSTO'
      ' WHERE A.ID_PLANO = -1')
    UpdateObject = uPlano
    Left = 56
    Top = 104
    object PlanoID_PLANO: TIntegerField
      DisplayLabel = 'Cod. Plano'
      FieldName = 'ID_PLANO'
      Origin = '"PLANO"."ID_PLANO"'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object PlanoCD_USUARIO: TIBStringField
      DisplayLabel = 'Usu'#225'rio'
      FieldName = 'CD_USUARIO'
      Origin = '"PLANO"."CD_USUARIO"'
      Required = True
    end
    object PlanoID_CATEG: TIntegerField
      DisplayLabel = 'Cod. Categ.'
      FieldName = 'ID_CATEG'
      Origin = '"PLANO"."ID_CATEG"'
    end
    object PlanoID_CCUSTO: TIntegerField
      DisplayLabel = 'Cod. CCusto'
      FieldName = 'ID_CCUSTO'
      Origin = '"PLANO"."ID_CCUSTO"'
    end
    object PlanoVL_VALOR: TIBBCDField
      DisplayLabel = 'Valor'
      FieldName = 'VL_VALOR'
      Origin = '"PLANO"."VL_VALOR"'
      Required = True
      Precision = 18
      Size = 2
    end
    object PlanoFL_ALERTA: TIBStringField
      DisplayLabel = 'Alerta'
      FieldName = 'FL_ALERTA'
      Origin = '"PLANO"."FL_ALERTA"'
      Required = True
      Size = 1
    end
    object PlanoDS_PLANO: TIBStringField
      DisplayLabel = 'Descri'#231#227'o'
      FieldName = 'DS_PLANO'
      Origin = '"PLANO"."DS_PLANO"'
      Required = True
      Size = 60
    end
    object PlanoDS_CATEG: TIBStringField
      DisplayLabel = 'Descri'#231#227'o Categoria'
      FieldName = 'DS_CATEG'
      Origin = '"CATEGORIA"."DS_CATEG"'
      Size = 60
    end
    object PlanoDS_CCUSTO: TIBStringField
      DisplayLabel = 'Descri'#231#227'o Centro de Custos'
      FieldName = 'DS_CCUSTO'
      Origin = '"CCUSTO"."DS_CCUSTO"'
      Size = 60
    end
    object PlanoDS_ACAO: TIBStringField
      DisplayLabel = 'A'#231#227'o'
      FieldName = 'DS_ACAO'
      ProviderFlags = []
      FixedChar = True
      Size = 6
    end
  end
  object uPlano: TIBUpdateSQL
    RefreshSQL.Strings = (
      'Select '
      '  ID_PLANO,'
      '  CD_USUARIO,'
      '  ID_CATEG,'
      '  ID_CCUSTO,'
      '  VL_VALOR,'
      '  FL_ALERTA,'
      '  DS_PLANO,'
      '  DS_CATEG,'
      '  DS_CCUSTO,'
      '  DS_ACAO'
      'from PLANO '
      'where'
      '  ID_PLANO = :ID_PLANO')
    ModifySQL.Strings = (
      'update PLANO'
      'set'
      '  CD_USUARIO = :CD_USUARIO,'
      '  DS_PLANO = :DS_PLANO,'
      '  FL_ALERTA = :FL_ALERTA,'
      '  ID_CATEG = :ID_CATEG,'
      '  ID_CCUSTO = :ID_CCUSTO,'
      '  ID_PLANO = :ID_PLANO,'
      '  VL_VALOR = :VL_VALOR'
      'where'
      '  ID_PLANO = :OLD_ID_PLANO')
    InsertSQL.Strings = (
      'insert into PLANO'
      
        '  (CD_USUARIO, DS_PLANO, FL_ALERTA, ID_CATEG, ID_CCUSTO, ID_PLAN' +
        'O, VL_VALOR)'
      'values'
      
        '  (:CD_USUARIO, :DS_PLANO, :FL_ALERTA, :ID_CATEG, :ID_CCUSTO, :I' +
        'D_PLANO, '
      '   :VL_VALOR)')
    DeleteSQL.Strings = (
      'delete from PLANO'
      'where'
      '  ID_PLANO = :OLD_ID_PLANO')
    Left = 93
    Top = 104
  end
  object dPlano: TDataSource
    DataSet = Plano
    Left = 128
    Top = 104
  end
  object Bens: TIBQuery
    Database = db
    Transaction = tdb
    AfterInsert = BensAfterInsert
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'SELECT A.*'
      'FROM BENS A'
      'WHERE A.ID_BEM = -1')
    UpdateObject = uBens
    Left = 176
    Top = 104
    object BensID_BEM: TIntegerField
      DisplayLabel = 'Cod. Bem'
      FieldName = 'ID_BEM'
      Origin = '"BENS"."ID_BEM"'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object BensCD_USUARIO: TIBStringField
      DisplayLabel = 'Usu'#225'rio'
      FieldName = 'CD_USUARIO'
      Origin = '"BENS"."CD_USUARIO"'
      Required = True
    end
    object BensDS_BEM: TIBStringField
      DisplayLabel = 'Descri'#231'ao do Bem'
      FieldName = 'DS_BEM'
      Origin = '"BENS"."DS_BEM"'
      Required = True
      Size = 60
    end
    object BensVL_AQUISICAO: TIBBCDField
      DisplayLabel = 'Valor Aquisi'#231#227'o'
      FieldName = 'VL_AQUISICAO'
      Origin = '"BENS"."VL_AQUISICAO"'
      Required = True
      OnValidate = BensVL_AQUISICAOValidate
      Precision = 18
      Size = 2
    end
    object BensDT_AQUISICAO: TDateField
      DisplayLabel = 'Data Aquisi'#231#227'o'
      FieldName = 'DT_AQUISICAO'
      Origin = '"BENS"."DT_AQUISICAO"'
      Required = True
      OnValidate = BensDT_AQUISICAOValidate
    end
    object BensVL_ATUAL: TIBBCDField
      DisplayLabel = 'Valor Atual'
      FieldName = 'VL_ATUAL'
      Origin = '"BENS"."VL_ATUAL"'
      OnValidate = BensVL_ATUALValidate
      Precision = 18
      Size = 2
    end
    object BensDT_VENDA: TDateField
      DisplayLabel = 'Data Venda'
      FieldName = 'DT_VENDA'
      Origin = '"BENS"."DT_VENDA"'
      OnValidate = BensDT_VENDAValidate
    end
  end
  object uBens: TIBUpdateSQL
    RefreshSQL.Strings = (
      'Select '
      '  ID_BEM,'
      '  CD_USUARIO,'
      '  DS_BEM,'
      '  VL_AQUISICAO,'
      '  DT_AQUISICAO,'
      '  VL_ATUAL,'
      '  DT_VENDA'
      'from BENS '
      'where'
      '  ID_BEM = :ID_BEM')
    ModifySQL.Strings = (
      'update BENS'
      'set'
      '  CD_USUARIO = :CD_USUARIO,'
      '  DS_BEM = :DS_BEM,'
      '  DT_AQUISICAO = :DT_AQUISICAO,'
      '  DT_VENDA = :DT_VENDA,'
      '  ID_BEM = :ID_BEM,'
      '  VL_AQUISICAO = :VL_AQUISICAO,'
      '  VL_ATUAL = :VL_ATUAL'
      'where'
      '  ID_BEM = :OLD_ID_BEM')
    InsertSQL.Strings = (
      'insert into BENS'
      
        '  (CD_USUARIO, DS_BEM, DT_AQUISICAO, DT_VENDA, ID_BEM, VL_AQUISI' +
        'CAO, VL_ATUAL)'
      'values'
      
        '  (:CD_USUARIO, :DS_BEM, :DT_AQUISICAO, :DT_VENDA, :ID_BEM, :VL_' +
        'AQUISICAO, '
      '   :VL_ATUAL)')
    DeleteSQL.Strings = (
      'delete from BENS'
      'where'
      '  ID_BEM = :OLD_ID_BEM')
    Left = 213
    Top = 104
  end
  object dBens: TDataSource
    DataSet = Bens
    Left = 248
    Top = 104
  end
end
