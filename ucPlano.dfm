inherited cPlano: TcPlano
  Caption = 'cPlano - Cadastro de Planos Financeiros'
  ClientHeight = 249
  ClientWidth = 401
  ExplicitWidth = 417
  ExplicitHeight = 288
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnGeral: TPanel
    Width = 401
    Height = 204
    ExplicitWidth = 401
    ExplicitHeight = 204
    object Label1: TLabel
      Left = 16
      Top = 8
      Width = 52
      Height = 13
      Caption = 'Cod. Plano'
      FocusControl = DBE_ID_PLANO
    end
    object Label3: TLabel
      Left = 16
      Top = 49
      Width = 59
      Height = 13
      Caption = 'Cod. Categ.'
      FocusControl = DBE_ID_CATEG
    end
    object Label4: TLabel
      Left = 16
      Top = 89
      Width = 61
      Height = 13
      Caption = 'Cod. CCusto'
      FocusControl = DBE_ID_CCUSTO
    end
    object Label5: TLabel
      Left = 16
      Top = 128
      Width = 24
      Height = 13
      Caption = 'Valor'
    end
    object Label7: TLabel
      Left = 16
      Top = 168
      Width = 46
      Height = 13
      Caption = 'Descri'#231#227'o'
      FocusControl = DBE_DS_PLANO
    end
    object Label8: TLabel
      Left = 73
      Top = 49
      Width = 96
      Height = 13
      Caption = 'Descri'#231#227'o Categoria'
      FocusControl = DBE_DS_CATEG
    end
    object Label9: TLabel
      Left = 72
      Top = 89
      Width = 133
      Height = 13
      Caption = 'Descri'#231#227'o Centro de Custos'
      FocusControl = DBE_DS_CCUSTO
    end
    object DBE_ID_PLANO: TDBEdit
      Left = 16
      Top = 24
      Width = 50
      Height = 21
      DataField = 'ID_PLANO'
      DataSource = dmFinanc.dPlano
      TabOrder = 0
    end
    object DBE_ID_CATEG: TDBEdit
      Left = 16
      Top = 65
      Width = 50
      Height = 21
      DataField = 'ID_CATEG'
      DataSource = dmFinanc.dPlano
      TabOrder = 1
      OnExit = DBE_ID_CATEGExit
    end
    object DBE_ID_CCUSTO: TDBEdit
      Left = 16
      Top = 105
      Width = 50
      Height = 21
      DataField = 'ID_CCUSTO'
      DataSource = dmFinanc.dPlano
      TabOrder = 3
      OnExit = DBE_ID_CCUSTOExit
    end
    object DBE_DS_PLANO: TDBEdit
      Left = 16
      Top = 184
      Width = 369
      Height = 21
      DataField = 'DS_PLANO'
      DataSource = dmFinanc.dPlano
      TabOrder = 7
    end
    object DBE_DS_CATEG: TDBEdit
      Left = 73
      Top = 65
      Width = 312
      Height = 21
      DataField = 'DS_CATEG'
      DataSource = dmFinanc.dPlano
      TabOrder = 2
    end
    object DBE_DS_CCUSTO: TDBEdit
      Left = 72
      Top = 105
      Width = 313
      Height = 21
      DataField = 'DS_CCUSTO'
      DataSource = dmFinanc.dPlano
      TabOrder = 4
    end
    object DBR_FL_ALERTA: TDBRadioGroup
      Left = 151
      Top = 132
      Width = 138
      Height = 33
      Caption = 'A'#231#227'o se Exceder'
      Columns = 2
      DataField = 'FL_ALERTA'
      DataSource = dmFinanc.dPlano
      Items.Strings = (
        'Alerta'
        'Barra')
      TabOrder = 6
      Values.Strings = (
        'A'
        'B')
    end
    object DBE_VL_VALOR: TJvDBCalcEdit
      Left = 16
      Top = 144
      Width = 129
      Height = 21
      TabOrder = 5
      DecimalPlacesAlwaysShown = False
      DataField = 'VL_VALOR'
      DataSource = dmFinanc.dPlano
      EmptyIsNull = False
    end
  end
  inherited paBotoes: TPanel
    Top = 204
    Width = 401
    ExplicitTop = 204
    ExplicitWidth = 401
  end
end
