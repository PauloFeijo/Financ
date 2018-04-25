inherited cBens: TcBens
  Caption = 'cBens - Cadastro de Bens'
  ClientHeight = 189
  ClientWidth = 427
  ExplicitWidth = 443
  ExplicitHeight = 228
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnGeral: TPanel
    Width = 427
    Height = 144
    ExplicitWidth = 393
    ExplicitHeight = 144
    object Label1: TLabel
      Left = 16
      Top = 16
      Width = 46
      Height = 13
      Caption = 'Cod. Bem'
      FocusControl = DBE_ID_BEM
    end
    object Label2: TLabel
      Left = 16
      Top = 56
      Width = 84
      Height = 13
      Caption = 'Descri'#231'ao do Bem'
      FocusControl = DBE_DS_BEM
    end
    object Label3: TLabel
      Left = 16
      Top = 96
      Width = 72
      Height = 13
      Caption = 'Valor Aquisi'#231#227'o'
    end
    object Label4: TLabel
      Left = 122
      Top = 96
      Width = 71
      Height = 13
      Caption = 'Data Aquisi'#231#227'o'
    end
    object Label5: TLabel
      Left = 218
      Top = 96
      Width = 52
      Height = 13
      Caption = 'Valor Atual'
    end
    object Label6: TLabel
      Left = 324
      Top = 96
      Width = 56
      Height = 13
      Caption = 'Data Venda'
    end
    object DBE_ID_BEM: TDBEdit
      Left = 16
      Top = 32
      Width = 80
      Height = 21
      DataField = 'ID_BEM'
      DataSource = dmFinanc.dBens
      TabOrder = 0
    end
    object DBE_DS_BEM: TDBEdit
      Left = 16
      Top = 72
      Width = 393
      Height = 21
      DataField = 'DS_BEM'
      DataSource = dmFinanc.dBens
      TabOrder = 1
    end
    object DBE_VL_AQUISICAO: TJvDBCalcEdit
      Left = 16
      Top = 112
      Width = 100
      Height = 21
      TabOrder = 2
      DecimalPlacesAlwaysShown = False
      DataField = 'VL_AQUISICAO'
      DataSource = dmFinanc.dBens
      EmptyIsNull = False
    end
    object DBE_VL_ATUAL: TJvDBCalcEdit
      Left = 216
      Top = 112
      Width = 100
      Height = 21
      TabOrder = 4
      DecimalPlacesAlwaysShown = False
      DataField = 'VL_ATUAL'
      DataSource = dmFinanc.dBens
      EmptyIsNull = False
    end
    object DBE_DT_AQUISICAO: TJvDBDatePickerEdit
      Left = 122
      Top = 112
      Width = 89
      Height = 21
      AllowNoDate = True
      DataField = 'DT_AQUISICAO'
      DataSource = dmFinanc.dBens
      TabOrder = 3
    end
    object DBE_DT_VENDA: TJvDBDatePickerEdit
      Left = 320
      Top = 112
      Width = 89
      Height = 21
      AllowNoDate = True
      DataField = 'DT_VENDA'
      DataSource = dmFinanc.dBens
      TabOrder = 5
    end
  end
  inherited paBotoes: TPanel
    Top = 144
    Width = 427
    ExplicitTop = 144
    ExplicitWidth = 393
  end
end
