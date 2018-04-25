inherited cPagRec: TcPagRec
  Caption = 'cPagRec - Cadastro de Contas a Pagar / Receber'
  ClientHeight = 208
  ClientWidth = 329
  ExplicitWidth = 345
  ExplicitHeight = 247
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnGeral: TPanel
    Width = 329
    Height = 163
    ExplicitWidth = 329
    ExplicitHeight = 163
    object Label1: TLabel
      Left = 16
      Top = 8
      Width = 23
      Height = 13
      Caption = 'Cod.'
      FocusControl = DBE_ID_PAGRECEB
    end
    object Label3: TLabel
      Left = 16
      Top = 48
      Width = 38
      Height = 13
      Caption = 'Cd.Cat.'
      FocusControl = DBE_ID_CATEG
    end
    object Label4: TLabel
      Left = 72
      Top = 48
      Width = 77
      Height = 13
      Caption = 'Desc. Categoria'
      FocusControl = DBE_DS_CATEG
    end
    object Label6: TLabel
      Left = 127
      Top = 88
      Width = 33
      Height = 13
      Caption = 'Vencto'
    end
    object Label7: TLabel
      Left = 228
      Top = 88
      Width = 62
      Height = 13
      Caption = 'Pago/Receb.'
      FocusControl = DBE_VL_PAGO
    end
    object Label9: TLabel
      Left = 215
      Top = 8
      Width = 28
      Height = 13
      Caption = 'Docto'
      FocusControl = DBE_NR_DOCTO
    end
    object Label11: TLabel
      Left = 16
      Top = 128
      Width = 46
      Height = 13
      Caption = 'Descri'#231#227'o'
      FocusControl = DBE_DS_DESCRI
    end
    object Label10: TLabel
      Left = 16
      Top = 88
      Width = 24
      Height = 13
      Caption = 'Valor'
    end
    object DBE_ID_PAGRECEB: TDBEdit
      Left = 16
      Top = 24
      Width = 50
      Height = 21
      DataField = 'ID_PAGRECEB'
      DataSource = dmFinanc.dPagarReceber
      TabOrder = 0
    end
    object DBE_ID_CATEG: TDBEdit
      Left = 16
      Top = 64
      Width = 50
      Height = 21
      DataField = 'ID_CATEG'
      DataSource = dmFinanc.dPagarReceber
      TabOrder = 2
      OnExit = DBE_ID_CATEGExit
    end
    object DBE_VL_PAGO: TDBEdit
      Left = 228
      Top = 104
      Width = 90
      Height = 21
      DataField = 'VL_PAGO'
      DataSource = dmFinanc.dPagarReceber
      TabOrder = 7
    end
    object DBE_NR_DOCTO: TDBEdit
      Left = 215
      Top = 24
      Width = 103
      Height = 21
      DataField = 'NR_DOCTO'
      DataSource = dmFinanc.dPagarReceber
      TabOrder = 1
    end
    object DBE_DS_DESCRI: TDBEdit
      Left = 16
      Top = 144
      Width = 302
      Height = 21
      DataField = 'DS_DESCRI'
      DataSource = dmFinanc.dPagarReceber
      TabOrder = 8
    end
    object DBE_DT_VENCTO: TJvDBDatePickerEdit
      Left = 127
      Top = 104
      Width = 95
      Height = 21
      AllowNoDate = True
      DataField = 'DT_VENCTO'
      DataSource = dmFinanc.dPagarReceber
      TabOrder = 6
    end
    object DBE_VL_VALOR: TJvDBCalcEdit
      Left = 16
      Top = 104
      Width = 105
      Height = 21
      TabOrder = 5
      DecimalPlacesAlwaysShown = False
      DataField = 'VL_VALOR'
      DataSource = dmFinanc.dPagarReceber
      EmptyIsNull = False
    end
    object gbNrParc: TGroupBox
      Left = 255
      Top = 48
      Width = 63
      Height = 37
      Caption = 'N'#186' Parcelas'
      TabOrder = 4
      object spNrParc: TSpinEdit
        Left = 7
        Top = 15
        Width = 57
        Height = 22
        MaxValue = 999999999
        MinValue = 1
        TabOrder = 0
        Value = 1
      end
    end
    object DBE_DS_CATEG: TDBEdit
      Left = 72
      Top = 64
      Width = 184
      Height = 21
      DataField = 'DS_CATEG'
      DataSource = dmFinanc.dPagarReceber
      TabOrder = 3
    end
  end
  inherited paBotoes: TPanel
    Top = 163
    Width = 329
    ExplicitTop = 163
    ExplicitWidth = 329
  end
end
