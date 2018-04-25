inherited pCCusto: TpCCusto
  Caption = 'pCCusto - Pesquisa de Centros de Custos'
  ClientHeight = 341
  ClientWidth = 514
  ExplicitWidth = 530
  ExplicitHeight = 380
  PixelsPerInch = 96
  TextHeight = 13
  object JvNetscapeSplitter1: TJvNetscapeSplitter [0]
    Left = 160
    Top = 56
    Height = 240
    Align = alLeft
    Maximized = False
    Minimized = False
    ButtonCursor = crDefault
    ExplicitLeft = 153
    ExplicitTop = 0
    ExplicitHeight = 305
  end
  inherited paBotoes: TPanel
    Top = 296
    Width = 514
    ExplicitTop = 296
    ExplicitWidth = 514
    inherited sbSair: TSpeedButton
      Left = 449
      ExplicitLeft = 484
    end
    inherited sbRelatorio: TSpeedButton
      Width = 0
      Enabled = False
      Visible = False
      ExplicitLeft = 249
      ExplicitWidth = 0
    end
    inherited sbPesquisar: TSpeedButton
      ExplicitLeft = 249
    end
  end
  inherited dbgPesq: TDBGrid
    Left = 170
    Top = 56
    Width = 344
    Height = 240
    DataSource = dmFinanc.dPesCCusto
    Columns = <
      item
        Expanded = False
        FieldName = 'ID_CCUSTO'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'DS_CCUSTO'
        Width = 320
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'FL_ATIVO'
        Width = 35
        Visible = True
      end>
  end
  inherited gbFiltro: TGroupBox
    Width = 514
    Height = 56
    ExplicitWidth = 514
    ExplicitHeight = 56
    inherited psFiltros: TPageScroller
      Width = 510
      Height = 39
      ExplicitWidth = 510
      ExplicitHeight = 39
      inherited paFiltros: TPanel
        Height = 39
        ExplicitHeight = 39
        object Label1: TLabel
          Left = 8
          Top = 2
          Width = 33
          Height = 13
          Caption = 'C'#243'digo'
        end
        object Label2: TLabel
          Left = 55
          Top = 2
          Width = 46
          Height = 13
          Caption = 'Descri'#231#227'o'
        end
        object edCodigo: TEdit
          Left = 8
          Top = 17
          Width = 41
          Height = 21
          CharCase = ecUpperCase
          NumbersOnly = True
          TabOrder = 0
        end
        object edNome: TEdit
          Left = 55
          Top = 17
          Width = 277
          Height = 21
          TabOrder = 1
        end
        object rgAtivo: TRadioGroup
          Left = 338
          Top = 2
          Width = 154
          Height = 37
          Caption = 'Ativo?'
          Columns = 3
          ItemIndex = 0
          Items.Strings = (
            'Sim'
            'N'#227'o'
            'Ambos')
          TabOrder = 2
        end
      end
    end
  end
  object Tree: TTreeView [4]
    Left = 0
    Top = 56
    Width = 160
    Height = 240
    Align = alLeft
    AutoExpand = True
    Indent = 19
    TabOrder = 3
    OnChange = TreeChange
  end
  inherited pmPad: TPopupMenu
    Left = 200
    Top = 88
  end
end
