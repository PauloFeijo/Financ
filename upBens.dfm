inherited pBens: TpBens
  Caption = 'pBens - Pesquisa de Bens'
  ClientHeight = 398
  ClientWidth = 666
  ExplicitWidth = 682
  ExplicitHeight = 437
  PixelsPerInch = 96
  TextHeight = 13
  object split: TJvNetscapeSplitter [0]
    Left = 0
    Top = 265
    Width = 666
    Height = 10
    Cursor = crVSplit
    Align = alBottom
    Maximized = False
    Minimized = False
    ButtonCursor = crDefault
    ExplicitTop = 65
    ExplicitWidth = 258
  end
  inherited paBotoes: TPanel
    Top = 353
    Width = 666
    ExplicitTop = 353
    ExplicitWidth = 666
    inherited sbSair: TSpeedButton
      Left = 601
      ExplicitLeft = 526
    end
    inherited sbRelatorio: TSpeedButton
      Visible = False
    end
  end
  inherited dbgPesq: TDBGrid
    Width = 666
    Height = 200
    DataSource = dmFinanc.dBens
    Columns = <
      item
        Expanded = False
        FieldName = 'ID_BEM'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'DS_BEM'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'VL_AQUISICAO'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'DT_AQUISICAO'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'VL_ATUAL'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'DT_VENDA'
        Visible = True
      end>
  end
  inherited gbFiltro: TGroupBox
    Width = 666
    ExplicitWidth = 666
    inherited psFiltros: TPageScroller
      Width = 469
      ExplicitWidth = 469
      inherited paFiltros: TPanel
        object Label2: TLabel
          Left = 6
          Top = 1
          Width = 84
          Height = 13
          Caption = 'Descri'#231#227'o do Bem'
        end
        object edDescricao: TEdit
          Left = 6
          Top = 18
          Width = 459
          Height = 21
          Anchors = [akLeft, akTop, akRight]
          Color = clBtnFace
          TabOrder = 0
        end
      end
    end
    object rgStatus: TRadioGroup
      Left = 471
      Top = 15
      Width = 193
      Height = 48
      Align = alRight
      Caption = 'Status'
      Columns = 3
      ItemIndex = 0
      Items.Strings = (
        'Ativo'
        'Vendido'
        'Ambos')
      TabOrder = 1
    end
  end
  object pnTotal: TPanel [4]
    Left = 0
    Top = 275
    Width = 666
    Height = 78
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 3
    object pnTotal2: TPanel
      Left = 345
      Top = 0
      Width = 321
      Height = 78
      Align = alRight
      BevelOuter = bvNone
      Color = clGradientInactiveCaption
      ParentBackground = False
      TabOrder = 0
      object Label1: TLabel
        Left = 4
        Top = 6
        Width = 72
        Height = 13
        Caption = 'Total Aquisi'#231#227'o'
      end
      object Label4: TLabel
        Left = 173
        Top = 6
        Width = 52
        Height = 13
        Caption = 'Total Atual'
      end
      object Label3: TLabel
        Left = 145
        Top = 29
        Width = 78
        Height = 13
        Caption = 'Total em Contas'
      end
      object Label5: TLabel
        Left = 194
        Top = 52
        Width = 24
        Height = 13
        Caption = 'Total'
      end
      object edTotalAquisicao: TEdit
        Left = 81
        Top = 6
        Width = 83
        Height = 21
        Alignment = taRightJustify
        Color = clBtnFace
        Enabled = False
        TabOrder = 0
      end
      object edTotalAtual: TEdit
        Left = 229
        Top = 6
        Width = 83
        Height = 21
        Alignment = taRightJustify
        Color = clBtnFace
        Enabled = False
        TabOrder = 1
      end
      object edTotalContas: TEdit
        Left = 229
        Top = 29
        Width = 83
        Height = 21
        Alignment = taRightJustify
        Color = clBtnFace
        Enabled = False
        TabOrder = 2
      end
      object edTotalGeral: TEdit
        Left = 229
        Top = 52
        Width = 83
        Height = 21
        Alignment = taRightJustify
        Color = clBtnFace
        Enabled = False
        TabOrder = 3
      end
    end
  end
end
