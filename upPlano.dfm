inherited pPlano: TpPlano
  Caption = 'pPlano - Pesquisa de Planos Financeiros'
  ClientHeight = 341
  ClientWidth = 632
  ExplicitWidth = 648
  ExplicitHeight = 380
  PixelsPerInch = 96
  TextHeight = 13
  inherited paBotoes: TPanel
    Top = 296
    Width = 632
    ExplicitTop = 296
    ExplicitWidth = 632
    inherited sbSair: TSpeedButton
      Left = 567
      ExplicitLeft = 552
    end
    inherited sbRelatorio: TSpeedButton
      Width = 0
      Enabled = False
      Visible = False
      ExplicitLeft = 260
      ExplicitWidth = 0
      ExplicitHeight = 45
    end
  end
  inherited dbgPesq: TDBGrid
    Width = 632
    Height = 213
    DataSource = dmFinanc.dPlano
    Columns = <
      item
        Expanded = False
        FieldName = 'ID_PLANO'
        Width = 50
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'ID_CATEG'
        Width = 50
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'DS_CATEG'
        Width = 200
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'ID_CCUSTO'
        Width = 50
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'DS_CCUSTO'
        Width = 200
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'VL_VALOR'
        Width = 80
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'DS_PLANO'
        Width = 250
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'DS_ACAO'
        Width = 60
        Visible = True
      end>
  end
  inherited gbFiltro: TGroupBox
    Width = 632
    ExplicitWidth = 632
    inherited psFiltros: TPageScroller
      Width = 628
      ExplicitWidth = 628
      inherited paFiltros: TPanel
        Width = 1144
        ExplicitWidth = 1144
        object Label5: TLabel
          Left = 576
          Top = -2
          Width = 46
          Height = 13
          Caption = 'Descri'#231#227'o'
        end
        inline frmCCusto1: TfrmCCusto
          Left = 290
          Top = -2
          Width = 280
          Height = 37
          TabOrder = 0
          ExplicitLeft = 290
          ExplicitTop = -2
          ExplicitWidth = 280
          inherited edDescricao: TEdit
            Width = 220
            ExplicitWidth = 220
          end
        end
        inline frmCateg1: TfrmCateg
          Left = 6
          Top = -2
          Width = 280
          Height = 37
          TabOrder = 1
          ExplicitLeft = 6
          ExplicitTop = -2
          ExplicitWidth = 280
          inherited edDescricao: TEdit
            Width = 220
            ExplicitWidth = 220
          end
        end
        object edDescricao: TEdit
          Left = 576
          Top = 13
          Width = 281
          Height = 21
          TabOrder = 2
        end
      end
    end
  end
  object pnTotal: TPanel [3]
    Left = 0
    Top = 278
    Width = 632
    Height = 18
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 3
    object Label4: TLabel
      Left = 525
      Top = 0
      Width = 24
      Height = 13
      Align = alRight
      Caption = 'Total'
    end
    object edTotal: TEdit
      Left = 549
      Top = 0
      Width = 83
      Height = 18
      Align = alRight
      Alignment = taRightJustify
      Color = clBtnFace
      Enabled = False
      TabOrder = 0
      ExplicitHeight = 21
    end
  end
end
