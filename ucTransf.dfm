inherited cTransf: TcTransf
  Caption = 'cTransf - Cadastro de Transfer'#234'ncias'
  ClientHeight = 242
  ClientWidth = 448
  ExplicitWidth = 464
  ExplicitHeight = 281
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnGeral: TPanel
    Width = 448
    Height = 197
    ExplicitWidth = 448
    ExplicitHeight = 197
    object Label1: TLabel
      Left = 16
      Top = 8
      Width = 55
      Height = 13
      Caption = 'Cd. Transf.'
      FocusControl = DBE_ID_TRANSFER
    end
    object Label2: TLabel
      Left = 88
      Top = 8
      Width = 50
      Height = 13
      Caption = 'Mov. Deb.'
      FocusControl = DBE_ID_MOVDEB
    end
    object Label3: TLabel
      Left = 161
      Top = 8
      Width = 54
      Height = 13
      Caption = 'Mov. Cred.'
      FocusControl = DBE_ID_MOVCRE
    end
    object Label4: TLabel
      Left = 17
      Top = 158
      Width = 46
      Height = 13
      Caption = 'Descri'#231#227'o'
      FocusControl = DBE_DS_TRANSF
    end
    object Label5: TLabel
      Left = 162
      Top = 121
      Width = 23
      Height = 13
      Caption = 'Data'
    end
    object Label6: TLabel
      Left = 17
      Top = 122
      Width = 24
      Height = 13
      Caption = 'Valor'
    end
    object Label7: TLabel
      Left = 161
      Top = 47
      Width = 63
      Height = 13
      Caption = 'Conta D'#233'bito'
      FocusControl = DBE_DS_CDEB
    end
    object Label8: TLabel
      Left = 16
      Top = 47
      Width = 53
      Height = 13
      Caption = 'Cd. C. Deb'
      FocusControl = DBE_ID_CDEB
    end
    object Label9: TLabel
      Left = 75
      Top = 47
      Width = 67
      Height = 13
      Caption = 'Nr. Ct. D'#233'bito'
      FocusControl = DBE_NR_CDEB
    end
    object Label10: TLabel
      Left = 16
      Top = 85
      Width = 57
      Height = 13
      Caption = 'Cd. C. Cred'
      FocusControl = DBE_ID_CCRED
    end
    object Label11: TLabel
      Left = 161
      Top = 85
      Width = 82
      Height = 13
      Caption = 'Conta de Cr'#233'dito'
      FocusControl = DBE_DS_CCRED
    end
    object Label12: TLabel
      Left = 72
      Top = 85
      Width = 59
      Height = 13
      Caption = 'Nr. C. Cred.'
      FocusControl = DBE_NR_CCRED
    end
    object DBE_ID_TRANSFER: TDBEdit
      Left = 16
      Top = 24
      Width = 50
      Height = 21
      DataField = 'ID_TRANSFER'
      DataSource = dmFinanc.dTransferencia
      TabOrder = 0
    end
    object DBE_ID_MOVDEB: TDBEdit
      Left = 88
      Top = 24
      Width = 50
      Height = 21
      DataField = 'ID_MOVDEB'
      DataSource = dmFinanc.dTransferencia
      TabOrder = 1
    end
    object DBE_ID_MOVCRE: TDBEdit
      Left = 161
      Top = 24
      Width = 50
      Height = 21
      DataField = 'ID_MOVCRE'
      DataSource = dmFinanc.dTransferencia
      TabOrder = 2
    end
    object DBE_DS_TRANSF: TDBEdit
      Left = 17
      Top = 174
      Width = 416
      Height = 21
      DataField = 'DS_TRANSF'
      DataSource = dmFinanc.dTransferencia
      TabOrder = 11
    end
    object DBE_DS_CDEB: TDBEdit
      Left = 161
      Top = 63
      Width = 272
      Height = 21
      DataField = 'DS_CDEB'
      DataSource = dmFinanc.dTransferencia
      TabOrder = 5
    end
    object DBE_ID_CDEB: TDBEdit
      Left = 16
      Top = 63
      Width = 50
      Height = 21
      DataField = 'ID_CDEB'
      DataSource = dmFinanc.dTransferencia
      TabOrder = 3
      OnExit = DBE_ID_CDEBExit
    end
    object DBE_NR_CDEB: TDBEdit
      Left = 75
      Top = 63
      Width = 80
      Height = 21
      DataField = 'NR_CDEB'
      DataSource = dmFinanc.dTransferencia
      TabOrder = 4
    end
    object DBE_ID_CCRED: TDBEdit
      Left = 16
      Top = 101
      Width = 50
      Height = 21
      DataField = 'ID_CCRED'
      DataSource = dmFinanc.dTransferencia
      TabOrder = 6
      OnExit = DBE_ID_CDEBExit
    end
    object DBE_DS_CCRED: TDBEdit
      Left = 161
      Top = 101
      Width = 272
      Height = 21
      DataField = 'DS_CCRED'
      DataSource = dmFinanc.dTransferencia
      TabOrder = 8
    end
    object DBE_NR_CCRED: TDBEdit
      Left = 72
      Top = 101
      Width = 83
      Height = 21
      DataField = 'NR_CCRED'
      DataSource = dmFinanc.dTransferencia
      TabOrder = 7
    end
    object DBE_DT_TRANSF: TJvDBDatePickerEdit
      Left = 161
      Top = 137
      Width = 112
      Height = 21
      AllowNoDate = True
      DataField = 'DT_TRANSF'
      DataSource = dmFinanc.dTransferencia
      TabOrder = 10
    end
    object DBE_VL_TRANSF: TJvDBCalcEdit
      Left = 16
      Top = 137
      Width = 139
      Height = 21
      TabOrder = 9
      DecimalPlacesAlwaysShown = False
      DataField = 'VL_TRANSF'
      DataSource = dmFinanc.dTransferencia
      EmptyIsNull = False
    end
  end
  inherited paBotoes: TPanel
    Top = 197
    Width = 448
    ExplicitTop = 197
    ExplicitWidth = 448
  end
end
