inherited pMovFin: TpMovFin
  Caption = 'pMovFin - Pesquisa de Movimentos Financeiros'
  ClientHeight = 437
  ClientWidth = 799
  ExplicitWidth = 815
  ExplicitHeight = 476
  PixelsPerInch = 96
  TextHeight = 13
  inherited paBotoes: TPanel
    Top = 392
    Width = 799
    ExplicitTop = 392
    ExplicitWidth = 799
    inherited sbSair: TSpeedButton
      Left = 734
      ExplicitLeft = 428
    end
    inherited sbRelatorio: TSpeedButton
      ExplicitLeft = 166
    end
    inherited sbPesquisar: TSpeedButton
      ExplicitLeft = 83
    end
  end
  inherited dbgPesq: TDBGrid
    Top = 94
    Width = 799
    Height = 281
    DataSource = dmFinanc.dMovimento
    Columns = <
      item
        Expanded = False
        FieldName = 'ID_MOVIM'
        Width = 50
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'ID_CATEG'
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
        FieldName = 'ID_CONTA'
        Width = 50
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'NR_CONTA'
        Width = 50
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'DS_CONTA'
        Width = 220
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'FL_TIPO'
        Width = 60
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'DT_MOVIM'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'VL_MOVIM'
        Width = 80
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'VL_BRUTO'
        Width = 80
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'VL_JUROS'
        Width = 60
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'VL_DESCON'
        Width = 80
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'DS_MOVIM'
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
        Width = 220
        Visible = True
      end>
  end
  inherited gbFiltro: TGroupBox
    Width = 799
    Height = 94
    ExplicitWidth = 799
    ExplicitHeight = 94
    inherited psFiltros: TPageScroller
      Width = 795
      Height = 77
      ExplicitWidth = 795
      ExplicitHeight = 77
      inherited paFiltros: TPanel
        Width = 1265
        Height = 77
        ExplicitWidth = 1265
        ExplicitHeight = 77
        object Label1: TLabel
          Left = 745
          Top = -1
          Width = 40
          Height = 13
          Caption = 'Cd. Mov'
        end
        object Label5: TLabel
          Left = 292
          Top = 37
          Width = 46
          Height = 13
          Caption = 'Descri'#231#227'o'
        end
        inline frmPeriodo1: TfrmPeriodo
          Left = 573
          Top = 1
          Width = 166
          Height = 34
          TabOrder = 2
          ExplicitLeft = 573
          ExplicitTop = 1
          ExplicitWidth = 166
        end
        object edCdMov: TEdit
          Left = 745
          Top = 14
          Width = 50
          Height = 21
          NumbersOnly = True
          TabOrder = 3
        end
        inline frmCateg1: TfrmCateg
          Left = 6
          Top = -2
          Width = 280
          Height = 37
          TabOrder = 0
          ExplicitLeft = 6
          ExplicitTop = -2
          ExplicitWidth = 280
          inherited edDescricao: TEdit
            Width = 220
            ExplicitWidth = 220
          end
        end
        inline frmConta1: TfrmConta
          Left = 6
          Top = 35
          Width = 280
          Height = 37
          TabOrder = 4
          ExplicitLeft = 6
          ExplicitTop = 35
          ExplicitWidth = 280
          inherited edDescricao: TEdit
            Width = 220
            ExplicitWidth = 220
          end
        end
        object cbTransf: TCheckBox
          Left = 655
          Top = 53
          Width = 127
          Height = 17
          Caption = 'Mostrar Transfer'#234'ncias'
          TabOrder = 6
        end
        inline frmCCusto1: TfrmCCusto
          Left = 290
          Top = -2
          Width = 280
          Height = 37
          TabOrder = 1
          ExplicitLeft = 290
          ExplicitTop = -2
          ExplicitWidth = 280
          inherited edDescricao: TEdit
            Width = 220
            ExplicitWidth = 220
          end
        end
        object edDescricao: TEdit
          Left = 290
          Top = 51
          Width = 359
          Height = 21
          TabOrder = 5
        end
      end
    end
  end
  object pnTotal: TPanel [3]
    Left = 0
    Top = 375
    Width = 799
    Height = 17
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 3
    object Label2: TLabel
      Left = 676
      Top = 0
      Width = 45
      Height = 13
      Align = alRight
      BiDiMode = bdRightToLeft
      Caption = 'Posi'#231#227'o   '
      ParentBiDiMode = False
    end
    object Label3: TLabel
      Left = 543
      Top = 0
      Width = 55
      Height = 13
      Align = alRight
      BiDiMode = bdRightToLeft
      Caption = 'Despesas   '
      ParentBiDiMode = False
    end
    object Label4: TLabel
      Left = 415
      Top = 0
      Width = 50
      Height = 13
      Align = alRight
      BiDiMode = bdRightToLeft
      Caption = 'Receitas   '
      ParentBiDiMode = False
    end
    object edResult: TEdit
      Left = 721
      Top = 0
      Width = 78
      Height = 17
      Align = alRight
      Alignment = taRightJustify
      Color = clBtnFace
      Enabled = False
      TabOrder = 0
      ExplicitHeight = 21
    end
    object edDespesa: TEdit
      Left = 598
      Top = 0
      Width = 78
      Height = 17
      Align = alRight
      Alignment = taRightJustify
      Color = clBtnFace
      Enabled = False
      TabOrder = 1
      ExplicitHeight = 21
    end
    object edReceita: TEdit
      Left = 465
      Top = 0
      Width = 78
      Height = 17
      Align = alRight
      Alignment = taRightJustify
      Color = clBtnFace
      Enabled = False
      TabOrder = 2
      ExplicitHeight = 21
    end
  end
  inherited pmPad: TPopupMenu
    Left = 112
    Top = 256
  end
end
