object dmRelatorio: TdmRelatorio
  OldCreateOrder = False
  Height = 271
  Width = 366
  object DB: TfrxIBXComponents
    DefaultDatabase = dmFinanc.db
    Left = 4
    Top = 68
  end
  object fcdsAnalise: TfrxDBDataset
    UserName = 'fcdsAnalise'
    CloseDataSource = False
    FieldAliases.Strings = (
      'ID_CATEG=ID_CATEG'
      'CATEG=CATEG'
      'VALOR=VALOR'
      'NIVEL=NIVEL'
      'FL_TIPO=FL_TIPO'
      'B_PAI=B_PAI'
      'DATA=DATA')
    DataSet = dmFinanc.cdsAnalise
    BCDToCurrency = False
    Left = 56
    Top = 5
  end
  object frxMovimento: TfrxDBDataset
    UserName = 'frxMovimento'
    CloseDataSource = False
    DataSet = dmFinanc.Movimento
    BCDToCurrency = False
    Left = 56
    Top = 68
  end
  object frxPagarReceber: TfrxDBDataset
    UserName = 'frxPagarReceber'
    CloseDataSource = False
    FieldAliases.Strings = (
      'ID_PAGRECEB=ID_PAGRECEB'
      'CD_USUARIO=CD_USUARIO'
      'ID_CATEG=ID_CATEG'
      'DS_CATEG=DS_CATEG'
      'VL_VALOR=VL_VALOR'
      'DT_VENCTO=DT_VENCTO'
      'FL_TIPO=FL_TIPO'
      'DS_DESCRI=DS_DESCRI'
      'VL_PAGO=VL_PAGO'
      'NR_DOCTO=NR_DOCTO')
    DataSet = dmFinanc.PagarReceber
    BCDToCurrency = False
    Left = 103
    Top = 68
  end
  object fcdsAnual: TfrxDBDataset
    UserName = 'fcdsAnual'
    CloseDataSource = False
    FieldAliases.Strings = (
      'ID_CATEG=ID_CATEG'
      'CATEG=CATEG'
      'NIVEL=NIVEL'
      'FL_TIPO=FL_TIPO'
      'B_PAI=B_PAI'
      'VL_M1=VL_M1'
      'VL_M2=VL_M2'
      'VL_M3=VL_M3'
      'VL_M4=VL_M4'
      'VL_M5=VL_M5'
      'VL_M6=VL_M6'
      'VL_M7=VL_M7'
      'VL_M8=VL_M8'
      'VL_M9=VL_M9'
      'VL_M10=VL_M10'
      'VL_M11=VL_M11'
      'VL_M12=VL_M12')
    DataSet = dmFinanc.cdsAnual
    BCDToCurrency = False
    Left = 104
    Top = 5
  end
  object Relatorio: TfrxReport
    Version = '5.4.3'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Default'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 39069.938386493100000000
    ReportOptions.LastChange = 42380.475204224540000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'var f_receitas, f_despesas : double;'
      'procedure mdAnaliseOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  if <fcdsAnalise."B_PAI"> then'
      '  begin'
      '     if <fcdsAnalise."VALOR"> > 0 then'
      '        f_receitas := f_receitas +  <fcdsAnalise."VALOR">'
      '     else'
      '        f_despesas := f_despesas +  <fcdsAnalise."VALOR">;'
      '  end;'
      'end;'
      ''
      'procedure MasterData1OnBeforePrint(Sender: TfrxComponent);'
      'begin'
      'end;'
      ''
      'begin'
      'end.')
    Left = 8
    Top = 5
    Datasets = <
      item
        DataSet = fcdsAnalise
        DataSetName = 'fcdsAnalise'
      end
      item
        DataSet = Relatorio.Receita
        DataSetName = 'Receita'
      end
      item
        DataSet = Relatorio.Despesa
        DataSetName = 'Despesa'
      end
      item
        DataSet = Relatorio.Barra
        DataSetName = 'Barra'
      end>
    Variables = <
      item
        Name = ' geral'
        Value = Null
      end
      item
        Name = 'usuario'
        Value = #39#39
      end
      item
        Name = 'categorias'
        Value = #39#39
      end
      item
        Name = 'conta'
        Value = '0'
      end
      item
        Name = 'd_inicio'
        Value = '0'
      end
      item
        Name = 'd_final'
        Value = '0'
      end>
    Style = <>
    object Data: TfrxDataPage
      Height = 1000.000000000000000000
      Width = 1000.000000000000000000
      object Receita: TfrxIBXQuery
        UserName = 'Receita'
        CloseDataSource = True
        BCDToCurrency = False
        IgnoreDupParams = False
        Params = <>
        SQL.Strings = (
          'SELECT A.ID_CATEG,'
          '       B.DS_CATEG,'
          '       SUM(A.VL_MOVIM) VLR'
          '  FROM MOVIMENTO A'
          ' INNER JOIN CATEGORIA B ON B.ID_CATEG = A.ID_CATEG'
          ' WHERE B.FL_TIPO = '#39'R'#39'     '
          
            'GROUP BY 1,2                                                    ' +
            '       ')
        pLeft = 20
        pTop = 8
        Parameters = <>
      end
      object Despesa: TfrxIBXQuery
        UserName = 'Despesa'
        CloseDataSource = True
        BCDToCurrency = False
        IgnoreDupParams = False
        Params = <>
        SQL.Strings = (
          'SELECT A.ID_CATEG,'
          '       B.DS_CATEG,'
          '       SUM(A.VL_MOVIM) VLR'
          '  FROM MOVIMENTO A'
          ' INNER JOIN CATEGORIA B ON B.ID_CATEG = A.ID_CATEG'
          ' WHERE B.FL_TIPO = '#39'D'#39'     '
          
            'GROUP BY 1,2                                                    ' +
            '       ')
        pLeft = 68
        pTop = 8
        Parameters = <>
      end
      object Barra: TfrxIBXQuery
        UserName = 'Barra'
        CloseDataSource = True
        BCDToCurrency = False
        IgnoreDupParams = False
        Params = <>
        SQL.Strings = (
          'SELECT * FROM('
          'SELECT 1 ID,'
          '       '#39'Dep'#243'sitos'#39' DS_TIPO,'
          '       SUM(A.VL_MOVIM) VL_VALOR'
          '  FROM MOVIMENTO A'
          'WHERE A.FL_TIPO = '#39'D'#39
          'UNION'
          'SELECT 2 ID,'
          '       '#39'Retiradas'#39' DS_TIPO,'
          '       SUM(A.VL_MOVIM) *-1 VL_VALOR'
          '  FROM MOVIMENTO A'
          'WHERE A.FL_TIPO = '#39'R'#39
          'UNION'
          'SELECT 3 ID,'
          '       '#39'Posi'#231#227'o'#39' DS_TIPO,'
          '       SUM(A.VL_MOVIM) VL_VALOR'
          '  FROM MOVIMENTO A)'
          
            '  ORDER BY 1                                                    ' +
            '             ')
        pLeft = 120
        pTop = 8
        Parameters = <>
      end
    end
    object Page1: TfrxReportPage
      PaperWidth = 210.000000000000000000
      PaperHeight = 297.000000000000000000
      PaperSize = 9
      LeftMargin = 10.000000000000000000
      RightMargin = 10.000000000000000000
      TopMargin = 10.000000000000000000
      BottomMargin = 10.000000000000000000
      LargeDesignHeight = True
      object ReportTitle1: TfrxReportTitle
        FillType = ftBrush
        Height = 75.590600000000000000
        Top = 18.897650000000000000
        Width = 718.110700000000000000
        object SysMemo4: TfrxSysMemoView
          Align = baClient
          Width = 718.110700000000000000
          Height = 75.590600000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haRight
          ParentFont = False
        end
        object Memo1: TfrxMemoView
          Left = 3.779530000000000000
          Top = 37.795300000000000000
          Width = 718.110700000000000000
          Height = 26.456710000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -21
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            'An'#225'lise')
          ParentFont = False
        end
        object Memo2: TfrxMemoView
          Left = 3.779530000000000000
          Top = 7.559060000000000000
          Width = 389.291590000000000000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'FINANC - Sistema Financeiro Pessoal')
          ParentFont = False
        end
        object SysMemo1: TfrxSysMemoView
          Left = 657.638220000000000000
          Top = 7.559060000000000000
          Width = 56.692950000000000000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[Page#] de [TotalPages#]')
          ParentFont = False
        end
        object SysMemo2: TfrxSysMemoView
          Left = 477.323130000000000000
          Top = 7.559060000000000000
          Width = 128.504020000000000000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[Date] [Time]')
          ParentFont = False
        end
        object Memo3: TfrxMemoView
          Left = 608.504330000000000000
          Top = 7.559060000000000000
          Width = 49.133890000000000000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'P'#225'gina')
          ParentFont = False
        end
        object SysMemo5: TfrxSysMemoView
          Left = 401.732530000000000000
          Top = 7.559060000000000000
          Width = 68.031540000000000000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Data e Hora')
          ParentFont = False
        end
      end
      object mdAnalise: TfrxMasterData
        FillType = ftBrush
        Height = 17.007874020000000000
        Top = 200.315090000000000000
        Width = 718.110700000000000000
        OnBeforePrint = 'mdAnaliseOnBeforePrint'
        DataSet = fcdsAnalise
        DataSetName = 'fcdsAnalise'
        RowCount = 0
        object Memo7: TfrxMemoView
          Align = baClient
          Width = 718.110700000000000000
          Height = 17.007874020000000000
          DataSet = fcdsAnalise
          DataSetName = 'fcdsAnalise'
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Highlight.Font.Charset = DEFAULT_CHARSET
          Highlight.Font.Color = clRed
          Highlight.Font.Height = -13
          Highlight.Font.Name = 'Arial'
          Highlight.Font.Style = []
          Highlight.Condition = '<line> mod 2 = 0'
          Highlight.FillType = ftBrush
          Highlight.Fill.BackColor = 16053492
          ParentFont = False
        end
        object fcdsAnaliseCATEG: TfrxMemoView
          Width = 600.945270000000000000
          Height = 17.007874020000000000
          DataField = 'CATEG'
          DataSet = fcdsAnalise
          DataSetName = 'fcdsAnalise'
          Memo.UTF8W = (
            '[fcdsAnalise."CATEG"]')
        end
        object fcdsAnaliseVALOR: TfrxMemoView
          Left = 600.945270000000000000
          Width = 117.165430000000000000
          Height = 17.007874020000000000
          DataSet = fcdsAnalise
          DataSetName = 'fcdsAnalise'
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Highlight.Font.Charset = DEFAULT_CHARSET
          Highlight.Font.Color = clRed
          Highlight.Font.Height = -13
          Highlight.Font.Name = 'Arial'
          Highlight.Font.Style = []
          Highlight.Condition = '<fcdsAnalise."VALOR"> < 0'
          Highlight.FillType = ftBrush
          Memo.UTF8W = (
            '[fcdsAnalise."VALOR"]')
          ParentFont = False
        end
      end
      object hAnalise: TfrxHeader
        FillType = ftBrush
        Height = 22.677167800000000000
        Top = 154.960730000000000000
        Width = 718.110700000000000000
        object Memo6: TfrxMemoView
          Top = 3.000000000000000000
          Width = 718.110700000000000000
          Height = 18.897637800000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Fill.BackColor = clWindow
          HAlign = haRight
          ParentFont = False
        end
        object Memo4: TfrxMemoView
          Top = 3.000000000000000000
          Width = 597.165740000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Categoria')
          ParentFont = False
        end
        object Memo5: TfrxMemoView
          Left = 600.945270000000000000
          Top = 3.000000000000000000
          Width = 117.165430000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'Valor')
          ParentFont = False
        end
      end
      object fAnalise: TfrxFooter
        FillType = ftBrush
        Height = 17.007874020000000000
        Top = 241.889920000000000000
        Width = 718.110700000000000000
        object Memo8: TfrxMemoView
          Left = 623.622450000000000000
          Width = 94.488188980000000000
          Height = 17.007874020000000000
          DataSet = fcdsAnalise
          DataSetName = 'fcdsAnalise'
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Highlight.Font.Charset = DEFAULT_CHARSET
          Highlight.Font.Color = clRed
          Highlight.Font.Height = -13
          Highlight.Font.Name = 'Arial'
          Highlight.Font.Style = []
          Highlight.Condition = '(<f_receitas> + <f_despesas>) < 0'
          Highlight.FillType = ftBrush
          Memo.UTF8W = (
            '[<f_receitas> + <f_despesas>]')
          ParentFont = False
        end
        object Memo9: TfrxMemoView
          Left = 551.811380000000000000
          Width = 71.811070000000000000
          Height = 17.007874020000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'Posi'#231#227'o')
          ParentFont = False
        end
        object Memo11: TfrxMemoView
          Left = 366.614410000000000000
          Width = 71.811070000000000000
          Height = 17.007874020000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'Despesas')
          ParentFont = False
        end
        object Memo12: TfrxMemoView
          Left = 253.228510000000000000
          Width = 94.488188980000000000
          Height = 17.007874020000000000
          DataSet = fcdsAnalise
          DataSetName = 'fcdsAnalise'
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[<f_receitas>]')
          ParentFont = False
        end
        object Memo13: TfrxMemoView
          Left = 181.417440000000000000
          Width = 71.811070000000000000
          Height = 17.007874020000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'Receitas')
          ParentFont = False
        end
        object Memo10: TfrxMemoView
          Left = 438.425480000000000000
          Width = 94.488188980000000000
          Height = 17.007874020000000000
          DataSet = fcdsAnalise
          DataSetName = 'fcdsAnalise'
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Highlight.Font.Charset = DEFAULT_CHARSET
          Highlight.Font.Color = clRed
          Highlight.Font.Height = -13
          Highlight.Font.Name = 'Arial'
          Highlight.Font.Style = []
          Highlight.Condition = '<f_despesas> < 0'
          Highlight.FillType = ftBrush
          Memo.UTF8W = (
            '[<f_despesas>]')
          ParentFont = False
        end
      end
      object mdPizzaR: TfrxMasterData
        FillType = ftBrush
        Height = 257.008040000000000000
        Top = 306.141930000000000000
        Width = 718.110700000000000000
        RowCount = 1
        object Chart1: TfrxChartView
          Align = baClient
          Width = 718.110700000000000000
          Height = 257.008040000000000000
          HighlightColor = clBlack
          Chart = {
            5450463006544368617274054368617274044C656674020003546F7002000557
            696474680390010648656967687403FA00144261636B57616C6C2E50656E2E56
            697369626C65080B4178697356697369626C65080D4672616D652E5669736962
            6C6508175669657733444F7074696F6E732E456C65766174696F6E033B011856
            69657733444F7074696F6E732E4F7274686F676F6E616C08195669657733444F
            7074696F6E732E50657273706563746976650200165669657733444F7074696F
            6E732E526F746174696F6E0368010B56696577334457616C6C73080A42657665
            6C4F75746572070662764E6F6E6505436F6C6F720707636C57686974650D4465
            6661756C7443616E766173060E54474449506C757343616E76617311436F6C6F
            7250616C65747465496E646578020D000A545069655365726965730753657269
            6573310E4C6567656E642E56697369626C65080B536572696573436F6C6F7207
            06636C426C75650C53686F77496E4C6567656E64080D5856616C7565732E4F72
            646572070B6C6F417363656E64696E670C5956616C7565732E4E616D65060350
            69650D5956616C7565732E4F7264657207066C6F4E6F6E65194F74686572536C
            6963652E4C6567656E642E56697369626C6508000000}
          ChartElevation = 315
          SeriesData = <
            item
              InheritedName = 'TfrxSeriesItem2'
              DataType = dtDBData
              DataBand = Relatorio.mdReceita
              DataSet = Relatorio.Receita
              DataSetName = 'Receita'
              SortOrder = soAscending
              TopN = 0
              XType = xtText
              Source1 = 'Receita."DS_CATEG"'
              Source2 = 'Receita."VLR"'
              XSource = 'Receita."DS_CATEG"'
              YSource = 'Receita."VLR"'
            end>
        end
        object Memo14: TfrxMemoView
          Top = 22.677180000000000000
          Width = 718.110700000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            'Receitas')
          ParentFont = False
        end
      end
      object mdReceita: TfrxMasterData
        FillType = ftBrush
        Top = 283.464750000000000000
        Width = 718.110700000000000000
        DataSet = Relatorio.Receita
        DataSetName = 'Receita'
        RowCount = 0
      end
      object mdDespesa: TfrxMasterData
        FillType = ftBrush
        Top = 585.827150000000000000
        Width = 718.110700000000000000
        DataSet = Relatorio.Despesa
        DataSetName = 'Despesa'
        RowCount = 0
      end
      object mdGBarra: TfrxMasterData
        FillType = ftBrush
        Height = 136.063080000000000000
        Top = 994.016390000000000000
        Width = 718.110700000000000000
        RowCount = 1
        object Chart3: TfrxChartView
          Align = baClient
          Width = 718.110700000000000000
          Height = 136.063080000000000000
          HighlightColor = clBlack
          Chart = {
            5450463006544368617274054368617274044C656674020003546F7002000557
            696474680390010648656967687403FA00144261636B57616C6C2E50656E2E56
            697369626C65080D4672616D652E56697369626C6508165669657733444F7074
            696F6E732E526F746174696F6E02000A426576656C4F75746572070662764E6F
            6E6505436F6C6F720707636C57686974650D44656661756C7443616E76617306
            0E54474449506C757343616E76617311436F6C6F7250616C65747465496E6465
            78020D000F54486F72697A42617253657269657307536572696573311B426172
            42727573682E4772616469656E742E446972656374696F6E070B67644C656674
            5269676874124772616469656E742E446972656374696F6E070B67644C656674
            52696768740C5856616C7565732E4E616D6506034261720D5856616C7565732E
            4F7264657207066C6F4E6F6E650C5956616C7565732E4E616D650601590D5956
            616C7565732E4F72646572070B6C6F417363656E64696E67000000}
          ChartElevation = 345
          SeriesData = <
            item
              InheritedName = 'TfrxSeriesItem2'
              DataType = dtDBData
              DataBand = Relatorio.mdBarra
              DataSet = Relatorio.Barra
              DataSetName = 'Barra'
              SortOrder = soNone
              TopN = 0
              XType = xtText
              Source1 = 'Barra."DS_TIPO"'
              Source2 = 'Barra."VL_VALOR"'
              Source3 = 'Barra."ID"'
              XSource = 'Barra."DS_TIPO"'
              YSource = 'Barra."VL_VALOR"'
            end>
        end
      end
      object mdBarra: TfrxMasterData
        FillType = ftBrush
        Top = 971.339210000000000000
        Width = 718.110700000000000000
        DataSet = Relatorio.Barra
        DataSetName = 'Barra'
        RowCount = 0
      end
      object mdPizzaD: TfrxMasterData
        FillType = ftBrush
        Height = 340.157700000000000000
        Top = 608.504330000000000000
        Width = 718.110700000000000000
        RowCount = 1
        object Chart2: TfrxChartView
          Align = baClient
          Width = 718.110700000000000000
          Height = 340.157700000000000000
          HighlightColor = clBlack
          Chart = {
            5450463006544368617274054368617274044C656674020003546F7002000557
            696474680390010648656967687403FA00144261636B57616C6C2E50656E2E56
            697369626C65080B4178697356697369626C65080D4672616D652E5669736962
            6C6508175669657733444F7074696F6E732E456C65766174696F6E033B011856
            69657733444F7074696F6E732E4F7274686F676F6E616C08195669657733444F
            7074696F6E732E50657273706563746976650200165669657733444F7074696F
            6E732E526F746174696F6E0368010B56696577334457616C6C73080A42657665
            6C4F75746572070662764E6F6E6505436F6C6F720707636C57686974650D4465
            6661756C7443616E766173060E54474449506C757343616E76617311436F6C6F
            7250616C65747465496E646578020D000A545069655365726965730753657269
            6573310E4C6567656E642E56697369626C65080C53686F77496E4C6567656E64
            080D5856616C7565732E4F72646572070B6C6F417363656E64696E670C595661
            6C7565732E4E616D6506035069650D5956616C7565732E4F7264657207066C6F
            4E6F6E65194F74686572536C6963652E4C6567656E642E56697369626C650800
            0000}
          ChartElevation = 315
          SeriesData = <
            item
              InheritedName = 'TfrxSeriesItem2'
              DataType = dtDBData
              DataBand = Relatorio.mdDespesa
              DataSet = Relatorio.Despesa
              DataSetName = 'Despesa'
              SortOrder = soAscending
              TopN = 0
              XType = xtText
              Source1 = 'Despesa."DS_CATEG"'
              Source2 = 'Despesa."VLR"'
              XSource = 'Despesa."DS_CATEG"'
              YSource = 'Despesa."VLR"'
            end>
        end
        object Memo15: TfrxMemoView
          Top = 26.456710000000000000
          Width = 718.110700000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            'Despesas')
          ParentFont = False
        end
      end
    end
  end
  object frxDOCXExport1: TfrxDOCXExport
    UseFileCache = True
    ShowProgress = True
    OverwritePrompt = False
    DataOnly = False
    OpenAfterExport = False
    PictureType = gpPNG
    Left = 24
    Top = 144
  end
  object frxPDFExport1: TfrxPDFExport
    UseFileCache = True
    ShowProgress = True
    OverwritePrompt = False
    DataOnly = False
    PrintOptimized = False
    Outline = False
    Background = False
    HTMLTags = True
    Quality = 95
    Transparency = False
    Author = 'FastReport'
    Subject = 'FastReport PDF export'
    ProtectionFlags = [ePrint, eModify, eCopy, eAnnot]
    HideToolbar = False
    HideMenubar = False
    HideWindowUI = False
    FitWindow = False
    CenterWindow = False
    PrintScaling = False
    PdfA = False
    Left = 264
    Top = 144
  end
  object frxJPEGExport1: TfrxJPEGExport
    UseFileCache = True
    ShowProgress = True
    OverwritePrompt = False
    DataOnly = False
    Left = 184
    Top = 144
  end
  object frxXLSXExport1: TfrxXLSXExport
    UseFileCache = True
    ShowProgress = True
    OverwritePrompt = False
    DataOnly = False
    ChunkSize = 0
    PictureType = gpPNG
    Left = 104
    Top = 144
  end
  object frxChartObject1: TfrxChartObject
    Left = 24
    Top = 200
  end
  object frxRichObject1: TfrxRichObject
    Left = 104
    Top = 200
  end
  object frxCrossObject1: TfrxCrossObject
    Left = 184
    Top = 200
  end
end
