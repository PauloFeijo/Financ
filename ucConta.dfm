inherited cConta: TcConta
  Caption = 'cConta - Cadastro de Contas Banc'#225'rias'
  ClientHeight = 173
  ClientWidth = 352
  ExplicitWidth = 368
  ExplicitHeight = 212
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnGeral: TPanel
    Width = 352
    Height = 128
    ExplicitWidth = 352
    ExplicitHeight = 128
    object Label1: TLabel
      Left = 16
      Top = 8
      Width = 46
      Height = 13
      Caption = 'Cd.Conta'
    end
    object Label4: TLabel
      Left = 16
      Top = 48
      Width = 46
      Height = 13
      Caption = 'Descri'#231#227'o'
      FocusControl = DBE_DS_CONTA
    end
    object Label5: TLabel
      Left = 16
      Top = 88
      Width = 26
      Height = 13
      Caption = 'Saldo'
    end
    object Label6: TLabel
      Left = 178
      Top = 88
      Width = 47
      Height = 13
      Caption = 'Nr. Conta'
      FocusControl = DBE_CD_CONTA
    end
    object DBE_DS_CONTA: TDBEdit
      Left = 16
      Top = 64
      Width = 321
      Height = 21
      DataField = 'DS_CONTA'
      DataSource = dmFinanc.dConta
      TabOrder = 0
    end
    object DBE_CD_CONTA: TDBEdit
      Left = 178
      Top = 104
      Width = 159
      Height = 21
      DataField = 'NR_CONTA'
      DataSource = dmFinanc.dConta
      TabOrder = 2
    end
    object DBE_VL_SALDO: TJvDBCalcEdit
      Left = 16
      Top = 104
      Width = 139
      Height = 21
      TabOrder = 1
      DecimalPlacesAlwaysShown = False
      DataField = 'VL_SALDO'
      DataSource = dmFinanc.dConta
      EmptyIsNull = False
    end
    object dbRgAtivo: TDBRadioGroup
      Left = 246
      Top = 15
      Width = 91
      Height = 30
      Caption = 'Ativo'
      Columns = 2
      DataField = 'FL_ATIVO'
      DataSource = dmFinanc.dConta
      Items.Strings = (
        'Sim'
        'N'#227'o')
      TabOrder = 3
      Values.Strings = (
        'A'
        'I')
    end
    object DBE_ID_CONTA: TDBEdit
      Left = 16
      Top = 23
      Width = 50
      Height = 21
      DataField = 'ID_CONTA'
      DataSource = dmFinanc.dConta
      TabOrder = 4
    end
  end
  inherited paBotoes: TPanel
    Top = 128
    Width = 352
    ExplicitTop = 128
    ExplicitWidth = 352
  end
end
