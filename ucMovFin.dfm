inherited cMovFin: TcMovFin
  Caption = 'cMovFin - Cadastros de Movimentos Financeiros'
  ClientHeight = 291
  ClientWidth = 352
  ExplicitWidth = 368
  ExplicitHeight = 330
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnGeral: TPanel
    Width = 352
    Height = 246
    ExplicitWidth = 352
    ExplicitHeight = 246
    object Label1: TLabel
      Left = 8
      Top = 8
      Width = 40
      Height = 13
      Caption = 'Cd. Mov'
      FocusControl = DBE_ID_MOVIM
    end
    object Label2: TLabel
      Left = 8
      Top = 48
      Width = 49
      Height = 13
      Caption = 'Cd. Conta'
      FocusControl = DBE_ID_CONTA
    end
    object Label3: TLabel
      Left = 64
      Top = 48
      Width = 47
      Height = 13
      Caption = 'Nr. Conta'
      FocusControl = DBE_NR_CONTA
    end
    object Label5: TLabel
      Left = 9
      Top = 167
      Width = 53
      Height = 13
      Caption = 'Valor Bruto'
    end
    object Label6: TLabel
      Left = 246
      Top = 8
      Width = 23
      Height = 13
      Caption = 'Data'
    end
    object Label7: TLabel
      Left = 9
      Top = 210
      Width = 46
      Height = 13
      Caption = 'Descri'#231#227'o'
      FocusControl = DBE_DS_MOVIM
    end
    object Label10: TLabel
      Left = 135
      Top = 48
      Width = 93
      Height = 13
      Caption = 'Descri'#231#227'o da Conta'
      FocusControl = DBE_DS_CONTA
    end
    object Label4: TLabel
      Left = 9
      Top = 88
      Width = 47
      Height = 13
      Caption = 'Categoria'
      FocusControl = DBE_ID_CATEG
    end
    object Label8: TLabel
      Left = 65
      Top = 88
      Width = 111
      Height = 13
      Caption = 'Descri'#231#227'o da Categoria'
      FocusControl = DBE_DS_CATEG
    end
    object Label9: TLabel
      Left = 9
      Top = 128
      Width = 47
      Height = 13
      Caption = 'C. Custos'
      FocusControl = DBE_ID_CCUSTO
    end
    object Label11: TLabel
      Left = 65
      Top = 128
      Width = 148
      Height = 13
      Caption = 'Descri'#231#227'o do Centro de Custos'
      FocusControl = DBE_DS_CCUSTO
    end
    object Label12: TLabel
      Left = 262
      Top = 167
      Width = 40
      Height = 13
      Caption = 'Valor Liq'
      FocusControl = DBE_VL_MOVIM
    end
    object Label13: TLabel
      Left = 107
      Top = 167
      Width = 26
      Height = 13
      Caption = 'Juros'
    end
    object Label14: TLabel
      Left = 184
      Top = 167
      Width = 45
      Height = 13
      Caption = 'Desconto'
    end
    object Label15: TLabel
      Left = 96
      Top = 186
      Width = 8
      Height = 13
      Caption = '+'
    end
    object Label16: TLabel
      Left = 177
      Top = 186
      Width = 4
      Height = 13
      Caption = '-'
    end
    object Label17: TLabel
      Left = 251
      Top = 186
      Width = 8
      Height = 13
      Caption = '='
    end
    object DBE_ID_MOVIM: TDBEdit
      Left = 8
      Top = 24
      Width = 50
      Height = 21
      DataField = 'ID_MOVIM'
      DataSource = dmFinanc.dMovimento
      TabOrder = 0
    end
    object DBE_ID_CONTA: TDBEdit
      Left = 8
      Top = 64
      Width = 50
      Height = 21
      DataField = 'ID_CONTA'
      DataSource = dmFinanc.dMovimento
      TabOrder = 2
      OnExit = DBE_ID_CONTAExit
    end
    object DBE_NR_CONTA: TDBEdit
      Left = 64
      Top = 64
      Width = 65
      Height = 21
      DataField = 'NR_CONTA'
      DataSource = dmFinanc.dMovimento
      TabOrder = 3
    end
    object DBE_DS_MOVIM: TDBEdit
      Left = 9
      Top = 226
      Width = 333
      Height = 21
      DataField = 'DS_MOVIM'
      DataSource = dmFinanc.dMovimento
      TabOrder = 13
    end
    object DBE_DS_CONTA: TDBEdit
      Left = 135
      Top = 64
      Width = 207
      Height = 21
      DataField = 'DS_CONTA'
      DataSource = dmFinanc.dMovimento
      TabOrder = 4
    end
    object DBE_ID_CATEG: TDBEdit
      Left = 9
      Top = 104
      Width = 50
      Height = 21
      DataField = 'ID_CATEG'
      DataSource = dmFinanc.dMovimento
      TabOrder = 5
      OnExit = DBE_ID_CATEGExit
    end
    object DBE_DS_CATEG: TDBEdit
      Left = 65
      Top = 104
      Width = 277
      Height = 21
      DataField = 'DS_CATEG'
      DataSource = dmFinanc.dMovimento
      TabOrder = 6
    end
    object DBE_ID_CCUSTO: TDBEdit
      Left = 9
      Top = 144
      Width = 50
      Height = 21
      DataField = 'ID_CCUSTO'
      DataSource = dmFinanc.dMovimento
      TabOrder = 7
      OnExit = DBE_ID_CCUSTOExit
    end
    object DBE_DS_CCUSTO: TDBEdit
      Left = 65
      Top = 144
      Width = 277
      Height = 21
      DataField = 'DS_CCUSTO'
      DataSource = dmFinanc.dMovimento
      TabOrder = 8
    end
    object DBE_DT_MOVIM: TJvDBDatePickerEdit
      Left = 246
      Top = 24
      Width = 96
      Height = 21
      AllowNoDate = True
      DataField = 'DT_MOVIM'
      DataSource = dmFinanc.dMovimento
      TabOrder = 1
    end
    object DBE_VL_BRUTO: TJvDBCalcEdit
      Left = 9
      Top = 183
      Width = 85
      Height = 21
      TabOrder = 9
      DecimalPlacesAlwaysShown = False
      DataField = 'VL_BRUTO'
      DataSource = dmFinanc.dMovimento
      EmptyIsNull = False
    end
    object DBE_VL_MOVIM: TDBEdit
      Left = 262
      Top = 183
      Width = 80
      Height = 21
      DataField = 'VL_MOVIM'
      DataSource = dmFinanc.dMovimento
      TabOrder = 12
    end
    object DBE_VL_JUROS: TJvDBCalcEdit
      Left = 107
      Top = 183
      Width = 65
      Height = 21
      TabOrder = 10
      DecimalPlacesAlwaysShown = False
      DataField = 'VL_JUROS'
      DataSource = dmFinanc.dMovimento
      EmptyIsNull = False
    end
    object DBE_VL_DESCON: TJvDBCalcEdit
      Left = 184
      Top = 183
      Width = 65
      Height = 21
      TabOrder = 11
      DecimalPlacesAlwaysShown = False
      DataField = 'VL_DESCON'
      DataSource = dmFinanc.dMovimento
      EmptyIsNull = False
    end
  end
  inherited paBotoes: TPanel
    Top = 246
    Width = 352
    ExplicitTop = 246
    ExplicitWidth = 352
  end
end
