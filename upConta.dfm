inherited pConta: TpConta
  Caption = 'pConta - Pesquisa de Contas Banc'#225'rias'
  ClientHeight = 341
  ClientWidth = 498
  ExplicitWidth = 514
  ExplicitHeight = 380
  PixelsPerInch = 96
  TextHeight = 13
  inherited paBotoes: TPanel
    Top = 296
    Width = 498
    ExplicitTop = 296
    ExplicitWidth = 498
    inherited sbSair: TSpeedButton
      Left = 433
      ExplicitLeft = 433
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
    Top = 61
    Width = 498
    Height = 217
    DataSource = dmFinanc.dConta
    Columns = <
      item
        Expanded = False
        FieldName = 'ID_CONTA'
        Width = 50
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'NR_CONTA'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'DS_CONTA'
        Width = 250
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'VL_SALDO'
        Width = 80
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
    Width = 498
    Height = 61
    ExplicitWidth = 498
    ExplicitHeight = 61
    inherited psFiltros: TPageScroller
      Width = 494
      Height = 44
      ExplicitWidth = 494
      ExplicitHeight = 44
      inherited paFiltros: TPanel
        Height = 44
        ExplicitHeight = 44
        object Label1: TLabel
          Left = 8
          Top = -3
          Width = 33
          Height = 13
          Caption = 'C'#243'digo'
        end
        object Label2: TLabel
          Left = 55
          Top = -3
          Width = 46
          Height = 13
          Caption = 'Descri'#231#227'o'
        end
        object Label3: TLabel
          Left = 311
          Top = -3
          Width = 47
          Height = 13
          Caption = 'Nr. Conta'
        end
        object edCodigo: TEdit
          Left = 8
          Top = 12
          Width = 41
          Height = 21
          CharCase = ecUpperCase
          NumbersOnly = True
          TabOrder = 0
        end
        object edNome: TEdit
          Left = 55
          Top = 12
          Width = 250
          Height = 21
          TabOrder = 1
        end
        object edNrConta: TEdit
          Left = 311
          Top = 12
          Width = 68
          Height = 21
          CharCase = ecUpperCase
          TabOrder = 2
        end
        object rgAtivo: TRadioGroup
          Left = 385
          Top = -2
          Width = 154
          Height = 37
          Caption = 'Ativo?'
          Columns = 3
          ItemIndex = 0
          Items.Strings = (
            'Sim'
            'N'#227'o'
            'Ambos')
          TabOrder = 3
        end
      end
    end
  end
  object pnTotal: TPanel [3]
    Left = 0
    Top = 278
    Width = 498
    Height = 18
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 3
    object Label4: TLabel
      Left = 391
      Top = 0
      Width = 24
      Height = 18
      Align = alRight
      Caption = 'Total'
      ExplicitHeight = 13
    end
    object edTotal: TEdit
      Left = 415
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
