inherited cCCusto: TcCCusto
  Caption = 'cCCusto - Cadastro de Centros de Custos'
  ClientHeight = 185
  ClientWidth = 350
  ExplicitWidth = 366
  ExplicitHeight = 224
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnGeral: TPanel
    Width = 350
    Height = 140
    ExplicitWidth = 350
    ExplicitHeight = 140
    object Label1: TLabel
      Left = 24
      Top = 16
      Width = 62
      Height = 13
      Caption = 'Cd. C. Custo'
      FocusControl = DBE_ID_CCUSTO
    end
    object Label3: TLabel
      Left = 24
      Top = 96
      Width = 56
      Height = 13
      Caption = 'C.Custo Pai'
      FocusControl = DBE_ID_CCPAI
    end
    object Label4: TLabel
      Left = 24
      Top = 57
      Width = 133
      Height = 13
      Caption = 'Descri'#231#227'o Centro de Custos'
      FocusControl = DBE_DS_CCUSTO
    end
    object DBE_ID_CCUSTO: TDBEdit
      Left = 24
      Top = 32
      Width = 50
      Height = 21
      DataField = 'ID_CCUSTO'
      DataSource = dmFinanc.dCCusto
      TabOrder = 0
    end
    object DBE_ID_CCPAI: TDBEdit
      Left = 24
      Top = 112
      Width = 50
      Height = 21
      DataField = 'ID_CCPAI'
      DataSource = dmFinanc.dCCusto
      TabOrder = 2
      OnExit = DBE_ID_CCPAIExit
    end
    object DBE_DS_CCUSTO: TDBEdit
      Left = 24
      Top = 73
      Width = 300
      Height = 21
      DataField = 'DS_CCUSTO'
      DataSource = dmFinanc.dCCusto
      TabOrder = 1
    end
    object edDsCCPai: TEdit
      Left = 80
      Top = 112
      Width = 244
      Height = 21
      Color = clBtnFace
      Enabled = False
      TabOrder = 3
    end
    object dbRgAtivo: TDBRadioGroup
      Left = 233
      Top = 23
      Width = 91
      Height = 30
      Caption = 'Ativo'
      Columns = 2
      DataField = 'FL_ATIVO'
      DataSource = dmFinanc.dCCusto
      Items.Strings = (
        'Sim'
        'N'#227'o')
      TabOrder = 4
      Values.Strings = (
        'A'
        'I')
    end
  end
  inherited paBotoes: TPanel
    Top = 140
    Width = 350
    ExplicitTop = 140
    ExplicitWidth = 350
  end
end
