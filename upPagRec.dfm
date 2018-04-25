inherited pPagRec: TpPagRec
  Caption = 'pPagRec - Pesquisa de Contas a Pagar / Receber'
  ClientHeight = 365
  ClientWidth = 755
  ExplicitWidth = 771
  ExplicitHeight = 404
  PixelsPerInch = 96
  TextHeight = 13
  inherited paBotoes: TPanel
    Top = 320
    Width = 755
    ExplicitTop = 320
    ExplicitWidth = 755
    inherited sbSair: TSpeedButton
      Left = 690
      ExplicitLeft = 489
    end
    object sbBaixar: TSpeedButton
      Left = 325
      Top = 0
      Width = 65
      Height = 45
      Hint = 'Baixar Conta'
      Align = alLeft
      Anchors = []
      Caption = 'F7-Baixar'
      Flat = True
      Glyph.Data = {
        E6040000424DE604000000000000360000002800000014000000140000000100
        180000000000B0040000C40E0000C40E00000000000000000000FFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEEEEEEF1F1F1FFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFDBDBDBA3A3A37E7E7E656565A3A3A3E5E5E5FFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFD3D3D3A2A2A29C9C9CD8D8D8C8C8C86A6A6A626262686868A0A0A0E2E2E2FF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFDEDEDE9B9B9B9D9D9D
        D1D1D1FAFAFAFFFFFFC9C9C97777777E7E7E7373736464646969699E9E9EEDED
        EDFFFFFFFFFFFFFFFFFFFFFFFFFCFCFC999999858585CDCDCDF5F5F5F2F2F2ED
        EDEDFBFBFBC2C2C26060607878787D7D7D7B7B7B7575756161616161619F9F9F
        FEFEFEFFFFFFD4D4D4818181C2C2C2F5F5F5EAEAEADEDEDEE2E2E2F0F0F0FDFD
        FDFFFFFFCDCDCD8686867171717575757979797B7B7B767676575757575757D5
        D5D5B0B0B0D9D9D9E1E1E1D2D2D2D9D9D9EFEFEFFEFEFEF2F2F2C6C7C6ADADAC
        E1E3E1F4F4F4C6C6C68D8D8D7474747070707474747E7E7E636363C2C2C2B5B5
        B5C9C9C9CCCCCCEFEFEFFFFFFFE4E4E4B0B0B08B8C8B917E8EA2889F9E909DA2
        A4A2D5D5D5E9E9E9C5C5C59393937272726E6E6E636363C3C3C3AFAFAFEBEBEB
        FBFBFBCBCBCB8D8D8D6D6D6D6366637969775E895E4B93499D9E9AE3C7E2D4D5
        D4E6E8E6F3F2F3F0F0F0D8D8D8ABABAB5C5C5CC4C4C4C5C5C5BCBCBCD7D7D7BD
        BDBD949494686968675C66696B6216C13A27D85600A70B90C18BFFECFFF7EFF7
        FFFFFFEEEEEEBDBDBD9D9D9DADADADFDFDFDFFFFFFFFFFFFD0D0D0C7C7C7D3D3
        D3E1DEE0D1C1CD22B23C3BE3764CE58551EA8B00B0142AA92FCEC4C9AF9CAEA8
        A7A8CECECEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF1F1F1F2DEEE
        69BD7530DC6447DD7B43DC7649E37E5EF19729D252009208456942DAD0D8FFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFD3EED72AC85448
        E07D44DD7648E17B46E27A49E77F61F59967F69534C64C25782D879687FEFEFE
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF7F3F535BE5741DF7746DF7A48E1
        7B49E37C52E7836BF19C69F39C45E87C1DCA4E05B21F7FAF81FEFEFEFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFF68C78033D76852E6864AE37D4AE37D47E67E
        68EB911BA82014AC2D51AE5DB4DEB4FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFAEE3BB24D25960F7945EEF8D50E6814EE7814DE98167EE9320
        B22C0E901CD2BDCEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFEAFAEEA4E8B783DE9B58CD754CE57E52EB854EEC8366F1942BBD4617A1
        2FA9ABA9FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFBCEFCB51EB8359F28C5EF69274FBA33ACC610AA02CA2A6A2
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFF9EE9B447EC7D5BF38E49E67C40D76D3BCB6251C46AE1E3E1FFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        E2F6E783D79A5ECC7C8FD39EC7E8CCFFFAFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFF}
      Layout = blGlyphTop
      ParentShowHint = False
      ShowHint = True
      OnClick = sbBaixarClick
    end
  end
  inherited dbgPesq: TDBGrid
    Width = 755
    Height = 159
    DataSource = dmFinanc.dPagarReceber
    Columns = <
      item
        Expanded = False
        FieldName = 'ID_PAGRECEB'
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
        FieldName = 'VL_VALOR'
        Width = 80
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'DT_VENCTO'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'VL_PAGO'
        Width = 80
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'NR_DOCTO'
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
        FieldName = 'DS_DESCRI'
        Width = 250
        Visible = True
      end>
  end
  inherited gbFiltro: TGroupBox
    Width = 755
    ExplicitWidth = 755
    inherited psFiltros: TPageScroller
      Width = 751
      ExplicitWidth = 751
      inherited paFiltros: TPanel
        object Label1: TLabel
          Left = 6
          Top = 8
          Width = 23
          Height = 13
          Caption = 'Cod.'
        end
        object Label5: TLabel
          Left = 494
          Top = 8
          Width = 46
          Height = 13
          Caption = 'Descri'#231#227'o'
        end
        object edCod: TEdit
          Left = 6
          Top = 23
          Width = 50
          Height = 21
          NumbersOnly = True
          TabOrder = 0
        end
        inline frmCateg1: TfrmCateg
          Left = 62
          Top = 7
          Width = 251
          Height = 37
          TabOrder = 1
          ExplicitLeft = 62
          ExplicitTop = 7
          ExplicitWidth = 251
          inherited edDescricao: TEdit
            Width = 194
            ExplicitWidth = 194
          end
        end
        object gbVencto: TGroupBox
          Left = 319
          Top = -3
          Width = 169
          Height = 52
          Caption = 'Vencimento'
          TabOrder = 2
          inline frmPeriodo1: TfrmPeriodo
            Left = 3
            Top = 13
            Width = 166
            Height = 34
            TabOrder = 0
            ExplicitLeft = 3
            ExplicitTop = 13
            ExplicitWidth = 166
          end
        end
        object cbBaixados: TCheckBox
          Left = 635
          Top = 0
          Width = 97
          Height = 17
          Caption = 'Mostrar Baixados'
          TabOrder = 3
        end
        object edDescricao: TEdit
          Left = 494
          Top = 23
          Width = 261
          Height = 21
          TabOrder = 4
        end
      end
    end
  end
  object Panel1: TPanel [3]
    Left = 0
    Top = 224
    Width = 755
    Height = 96
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 3
    object Splitter1: TSplitter
      Left = 0
      Top = 0
      Width = 755
      Height = 3
      Cursor = crVSplit
      Align = alTop
      ExplicitLeft = 1
      ExplicitTop = 1
      ExplicitWidth = 39
    end
    object dbgMovimento: TDBGrid
      Left = 0
      Top = 3
      Width = 755
      Height = 93
      Align = alClient
      DataSource = dmFinanc.dMovimento
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
      PopupMenu = pmMovim
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'Tahoma'
      TitleFont.Style = []
      OnDrawColumnCell = dbgPesqDrawColumnCell
      OnKeyDown = dbgPesqKeyDown
      OnTitleClick = dbgPesqTitleClick
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
          FieldName = 'VL_DESCON'
          Width = 60
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
          FieldName = 'DS_MOVIM'
          Width = 200
          Visible = True
        end>
    end
  end
  inherited pmPad: TPopupMenu
    Left = 48
    Top = 184
  end
  object ds: TDataSource
    DataSet = dmFinanc.PagarReceber
    OnDataChange = dsDataChange
    Left = 16
    Top = 184
  end
  object pmMovim: TPopupMenu
    Left = 16
    Top = 264
    object EditarMovimento1: TMenuItem
      Caption = 'Editar Movimento'
      OnClick = EditarMovimento1Click
    end
  end
end
