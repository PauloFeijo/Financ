inherited pTransf: TpTransf
  Caption = 'pTransf - Pesquisa de Transfer'#234'ncias'
  ClientHeight = 416
  ClientWidth = 738
  ExplicitWidth = 754
  ExplicitHeight = 455
  PixelsPerInch = 96
  TextHeight = 13
  inherited paBotoes: TPanel
    Top = 371
    Width = 738
    ExplicitTop = 371
    ExplicitWidth = 738
    inherited sbSair: TSpeedButton
      Left = 673
      ExplicitLeft = 626
    end
    inherited sbRelatorio: TSpeedButton
      Width = 0
      Enabled = False
      Visible = False
      ExplicitWidth = 0
    end
  end
  inherited dbgPesq: TDBGrid
    Width = 738
    Height = 306
    DataSource = dmFinanc.dTransferencia
    Columns = <
      item
        Expanded = False
        FieldName = 'ID_TRANSFER'
        Width = 50
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'ID_MOVDEB'
        Visible = False
      end
      item
        Expanded = False
        FieldName = 'ID_MOVCRE'
        Visible = False
      end
      item
        Expanded = False
        FieldName = 'DT_TRANSF'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'VL_TRANSF'
        Width = 60
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'ID_CDEB'
        Width = 50
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'NR_CDEB'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'DS_CDEB'
        Width = 200
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'ID_CCRED'
        Width = 50
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'NR_CCRED'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'DS_CCRED'
        Width = 200
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'DS_TRANSF'
        Visible = True
      end>
  end
  inherited gbFiltro: TGroupBox
    Width = 738
    ExplicitWidth = 738
    inherited psFiltros: TPageScroller
      Width = 734
      ExplicitWidth = 734
      inherited paFiltros: TPanel
        object Label1: TLabel
          Left = 6
          Top = 8
          Width = 55
          Height = 13
          Caption = 'Cd. Transf.'
        end
        object Label5: TLabel
          Left = 487
          Top = 8
          Width = 46
          Height = 13
          Caption = 'Descri'#231#227'o'
        end
        inline frmPeriodo1: TfrmPeriodo
          Left = 315
          Top = 10
          Width = 166
          Height = 34
          TabOrder = 2
          ExplicitLeft = 315
          ExplicitTop = 10
          ExplicitWidth = 166
          inherited Label1: TLabel
            Top = -2
            ExplicitTop = -2
          end
          inherited Label2: TLabel
            Top = -2
            ExplicitTop = -2
          end
        end
        object edCdTransf: TEdit
          Left = 6
          Top = 23
          Width = 50
          Height = 21
          NumbersOnly = True
          TabOrder = 0
        end
        inline frmConta1: TfrmConta
          Left = 67
          Top = 7
          Width = 242
          Height = 37
          TabOrder = 1
          ExplicitLeft = 67
          ExplicitTop = 7
          ExplicitWidth = 242
          inherited edDescricao: TEdit
            Width = 186
            ExplicitWidth = 186
          end
        end
        object edDescricao: TEdit
          Left = 487
          Top = 23
          Width = 261
          Height = 21
          TabOrder = 3
        end
      end
    end
  end
end
