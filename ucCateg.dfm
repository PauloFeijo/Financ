inherited cCateg: TcCateg
  Caption = 'cCateg - Cadastro de Categorias'
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
      Width = 49
      Height = 13
      Caption = 'Cd. Categ'
      FocusControl = DBE_ID_CATEG
    end
    object Label3: TLabel
      Left = 24
      Top = 96
      Width = 38
      Height = 13
      Caption = 'Cat. Pai'
      FocusControl = DBE_ID_CATPAI
    end
    object Label4: TLabel
      Left = 24
      Top = 57
      Width = 96
      Height = 13
      Caption = 'Descri'#231#227'o Categoria'
      FocusControl = DBE_DS_CATEG
    end
    object DBE_ID_CATEG: TDBEdit
      Left = 24
      Top = 32
      Width = 50
      Height = 21
      DataField = 'ID_CATEG'
      DataSource = dmFinanc.DCategoria
      TabOrder = 0
    end
    object DBE_ID_CATPAI: TDBEdit
      Left = 24
      Top = 112
      Width = 50
      Height = 21
      DataField = 'ID_CATPAI'
      DataSource = dmFinanc.DCategoria
      TabOrder = 2
      OnExit = DBE_ID_CATPAIExit
    end
    object DBE_DS_CATEG: TDBEdit
      Left = 24
      Top = 73
      Width = 300
      Height = 21
      DataField = 'DS_CATEG'
      DataSource = dmFinanc.DCategoria
      TabOrder = 1
    end
    object edDsCatPai: TEdit
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
      DataSource = dmFinanc.DCategoria
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
