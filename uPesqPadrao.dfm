object pPesqPadrao: TpPesqPadrao
  Left = 0
  Top = 0
  Caption = 'pPesqPadrao'
  ClientHeight = 245
  ClientWidth = 384
  Color = clGradientInactiveCaption
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poMainFormCenter
  OnActivate = FormActivate
  OnClose = FormClose
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnKeyDown = FormKeyDown
  OnKeyPress = FormKeyPress
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object paBotoes: TPanel
    Left = 0
    Top = 200
    Width = 384
    Height = 45
    Align = alBottom
    BevelOuter = bvNone
    Color = clInactiveCaption
    ParentBackground = False
    TabOrder = 0
    object sbAlterar: TSpeedButton
      Left = 65
      Top = 0
      Width = 65
      Height = 45
      Hint = 'Editar Registro'
      Align = alLeft
      Anchors = []
      Caption = 'F3-Editar'
      Flat = True
      Glyph.Data = {
        E6040000424DE604000000000000360000002800000014000000140000000100
        180000000000B0040000C40E0000C40E00000000000000000000FFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFF5F8FA9BC2D0ABB9C0EBE8E7FFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFF91DBEE7BCADA7CB3BF76A6B48EAFBBD1D0D0F6F5F4FFFFFEFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFC7E1
        ED8DE2F3E7FFFFD3F6FA8CCFDB69B1C0769EAC95B4BCB9CACFDCDCDDFEFBF9FF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF2F9FC78D6EDCEFCFF
        C6EAEF91B2B5AFC2C5E6FFFFC6FAFF81C5D572A7B487A4ACAFC8CFE5E0E3F9F6
        F5FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEFEBBE4F292E8F7EAFFFFB0DAE04C
        6C7B617C92A4CED8E3F8FBE4FAFFCEF6F9A6E3ED71B4C58BA0AAAABFC6CBD9DD
        EBE8E8FAF9F9FFFFFFFFFFFFEBF7FC83DBEFBBF9FCD9FAFCCCF0F479909D3F6D
        642987546AB7AAACD8F3BFEAF7D2F4F8DAF2F7B0E5E985C4D56CA5B583A3ACDF
        DFDFFFFFFFFFFFFFD6F1F98EE6F5BAF6F893D7E5AEE3F584C6B745C06D1FB835
        1F923E74B9B799D1EE89C3D89FD0E1CCF1F5E3FAFDB5E3EE64BBD1D8DDDFFFFF
        FFF6FAFCACE2F2A3F3FBB8FBFB88D4E47AC1E151C0994FEF7F5EFE8722A53547
        A35FB3E1DDC7F0FB85C7DA89C1D4CFEDF2BCF2FB9ACFE1F4F6F7FFFFFFE8F5FB
        88DDF0B3F8FCCAFFFFC2FDFEB3E8F67FDDC34BE37C60FF9350E37A219E2F62B1
        74D9FBF9E3FAFFBAE5ECADE9F082CFE2DDEAEFFFFFFFFFFFFFE6F8FD89E5F5A1
        EDF391DFE9ACEFF4CEFFFFD2FFFF8DEFBC56F37C68FF9843D26613912345A673
        D0FAF5EEFFFF8DDDEBB6D4E1FFFEFEFFFFFFFFFEFDCEEAF493F0FA94EBF067C1
        D663C1D67AD2E19DE3F4AEEAFF67D5A24CF5766EFF9F38D35A00760959A789B7
        FCFF8ECDE1FFF8F7FFFFFFFFFFFFFCFCFE9FDDF095F5FAADFFFFA2F7F989DEE9
        70C7DB63BED477C5E870BED846D47E51FC7E5EF79055A8556C856B7DB2C6C0D2
        D6FFFFFFFFFFFFFFFFFFFAFDFD8FDFEF92F5F9A0F7F9A7F8FAB1FEFEB1FFFFA7
        F8FA95EAEF8ED3F85AC6B043DB7485E29ADBD7C59A8EAE343F7CA2A1A7F5F5F4
        FFFFFFFFFFFFF8FBFD88E5F58AF2F66BD0DE6ACCDC80DDE893EDF3A4F6F9ACFB
        FBB9FAFFA5F8F890E2C2D3E0C9E5DBFD5C7AF5010DAA3D3C88D0D0D4FFFFFFFF
        FFFFE5ECF480E4F397F9FC83E5EC71D7E466CCDD63C7DA69CADB75D0E083DAE4
        9AF3F8B6F8FAB6CDE5728CF42A5CFF0E1DBB3A399DDDDDE1FFFFFFFFFFFFC4DE
        ED6EDBED97FAFDA5FFFFA2FDFD97F1F589E9F07BDFE970D1E265C8DB62C3D975
        D1DF7BCBE54B80E70C26CF474AB3B3B3D6FBFBFCFFFFFFFFFFFFD8EDF58CDBEF
        7DE0F079E5F473E6F284F1F992FCFF9BFFFF9CFBFB9CF2F58CE3EB81DDE68FF0
        F566B4DC5863B7C7C5E4FDFDF9FFFFFFFFFFFFFFFFFFFCFDFEE2F1F9C0E6F4AF
        E6F3A7E5F195E0F287E2F381E7F57DEAF57CECF78BF6FD98FBFD9BFFFF69C3CB
        C3C9CEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEFFFDFDFEFCFDFEFCFD
        FEF8FBFDE5EFF4BBE2F29FDEEF94DFF187DFF189E9F574E5F679C4D2E9EBEBFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFEFEE9EDF6BAE0F1CEEAF3FFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFF}
      Layout = blGlyphTop
      ParentShowHint = False
      ShowHint = True
      OnClick = sbAlterarClick
      ExplicitHeight = 40
    end
    object sbRemover: TSpeedButton
      Left = 130
      Top = 0
      Width = 65
      Height = 45
      Hint = 'Excluir Registro Corrente'
      Align = alLeft
      Anchors = []
      Caption = 'F4-Excluir'
      Flat = True
      Glyph.Data = {
        E6040000424DE604000000000000360000002800000014000000140000000100
        180000000000B0040000C40E0000C40E00000000000000000000FFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFCCC9D06C
        688F9E9C92E9E9E0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFC4C1BA
        DADACFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFDAD6E40012C8022AD60110
        AA3F3C74ADAC9EFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF7573B40003AD2B2B797D
        7A82BBBBB2FFFFFFFFFFFFFFFFFFFFFFFF454BC71048FF194AFC1648F50529CF
        14178D84827CF7F7F2FFFFFFFFFFFE716DB2001ADD0A3DF4012BD9000DBE2525
        73BBBAADFFFFFFFFFFFFF8F6F8041CCF265CFF1D4FFE1C4DFF1A4CFB0F3CE108
        119D736F71FFFEE6716CB40022E20F43F90D3DF40C3BF20839ED0019C2423E6F
        E8E8E0FFFFFFFFFFFFB9B2E01437E22658FF2153FF2051FF1D4FFF1647ED0616
        A9362F7D002BEF1548FD1142F60F3FF50E3EF40B3AF30838EC000AA8AFADA1FF
        FFFFFFFFFFBDB8E41D4BF52C5DFF2858FF2758FF2456FF2052FF1847EC1039EC
        1A4EFF1747FA1345F91243F71040F50D3EF60034F8000FB2E0DEDCFFFFFFFFFF
        FFC3C0EA112ED93A70FF3364FF2A5BFF2A5AFF2759FF2355FF1F51FE1B4DFE1A
        4AFD1747FA1445F91245FB002CEE3134AEF8F5EEFFFFFFFFFFFFFFFFFFFFFFFF
        E8E3F33B43CE2A57F24073FF3061FF2B5CFF295AFF2557FF2051FF1C4EFE194A
        FD184BFF0025E7625FB1FFFFFBFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFF9692DD1834DA467BFF3364FF2D5EFF2A5AFF2556FF2051FF1B4EFF0930E6
        7874B9FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFBFB7DC1D3FE23C6DFF3363FF2F5FFF295AFF2657FF1A4BF710159AA4A18CFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF5054CA
        3E71FF3D6CFF3666FF3363FF2D5EFF295AFF2254FD0E36DA23227FCAC9B8FFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF2EEF11533DC4A7CFF41
        70FF3C6BFF3A6BFF386AFF2C5DFF2759FF1F51FC0220C8504C71EBEBE3FFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF6C68CC4D80FF4A79FF4473FF4071
        FF264EEF2848E23C6FFF295AFF2355FF1A4CF50514AA807D7EFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFB3142D75789FF4C7AFF4A78FF3568FF3F41B1
        A5A0D91C41E6366AFF2657FF1F50FF103CE11B1D8BBCBBABFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFB8B4E53F68F25887FF517EFF4A7DFF182ACCE1DED7FFFFFF99
        94DC1F46EA3164FF2152FF1B4DFC0224CE433F71E6E6DDFFFFFFFFFFFFFFFFFF
        FFFFFF6B6DE06395FE5E8CFF5382FF2C57F77E79B3FFFFFFFFFFFFFFFFFF7C79
        D81B4AF2295CFF1C4DFF1749F50013B58A888BFFFFFFFFFFFFFFFFFFFFFFFFE9
        E7F83441D65A88FA598FFF2027B8FFFDEAFFFFFFFFFFFFFFFFFFFFFFFF5C5CD5
        2051FB1A51FF0434F70518CDC0BED8FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FF9D98E7333BD7C3C1D6FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF3C44D231
        3ECEACA6D9FFFFFCFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEFFFFFEFFFF
        FFFFFFFFFFFFFFFFFFFF}
      Layout = blGlyphTop
      ParentShowHint = False
      ShowHint = True
      OnClick = sbRemoverClick
      ExplicitHeight = 40
    end
    object sbSair: TSpeedButton
      Left = 319
      Top = 0
      Width = 65
      Height = 45
      Hint = 'Sair do Programa'
      Align = alRight
      Caption = 'Esc-Sair'
      Flat = True
      Glyph.Data = {
        E6040000424DE604000000000000360000002800000013000000140000000100
        180000000000B0040000C40E0000C40E00000000000000000000FFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFCBCBCBE6E6
        E6FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFDAC9C98F6D6D816F6FA5A3A3
        E1E1E1FFFFFFFFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFD4D4D4C8C8C8D4D4D4BDA3A3C99999966161845656765B5B8C
        8484C8C8C8F9F9F9FFFFFF000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        C8C8C86869686E696D857C85A3898DC998979C6868A57171A26D6D8D5A5A7552
        527C6D6DC8C8C8000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFB2B3B27F
        787E608C6C68C284A2AC96CA94989D6969A37070A37070A67272A87272855858
        757474000000FFFFFFFFFFFFFFFFFFFFFFFFEDF5EDD5D5D5AFABAF897D863C88
        4E00A8286D9F69D499A2A06C6CA57272A67373A47171A8747491656572717100
        0000FFFFFFFFFFFFFFFFFFFFFFFFD2EFD22D7B308C898B9284913A7D46009119
        719666D69DA5A46F6FA97575A77474A77474AA7676916565777575000000F8FA
        F8C4C4C4B3B3B3BBBBBB95A99522AE454DA9599B8F97336D390075006C8D5BDA
        A1AAA66F6F9C6E6EA17070A87676AD7878946868797777000000A8CBA822933A
        259840269A41269C4143D47338CF684FA356508655137827789068DBA1A8AC91
        91A0A4A49E7B7BAB7676AF7B7B986C6C7B7979000000A1C49F3BC76742E07946
        E17C4AE4804CE57F52ED8739CA6450BF69A2F9EDBECCCDCF9797CDC0C0E1ECEC
        B08D8DAE7878B17C7C9A6E6E7D7B7B000000A0C59F46C96D3FDE7542E07747E4
        7B4CE88053ED865FFA9828BC489CE5B4E3D2DBCF9D9DB48484B99494B28080B1
        7E7EB37F7F9D71717E7C7C0000009AC19A58D17C66EB9669EC9771F29E6DF19A
        5CF79240E66F85D389FCFFFDE8CECED0A2A2B07B7BB57E7EB48181B38080B681
        819F74747F7D7D000000B7D6B759BA6967C67968C9795FC4706EEC964CF07C54
        A35ADCCCD0FFFFFEE7CBC8D2A5A5B37F7FB78484B78484B58282B88383A27676
        817F7F000000FFFFFFFFFFFFFFFFFFFFFFFFD6E2D632CA526CBC73978D96C5BA
        B3FFFEEDE9CAC4D2A6A8BE8989C28F8FB98585B47F7FB58080A4797983828200
        0000FFFFFFFFFFFFFFFFFFFFFFFFC8E9C87EBD7EC8BEC7919295C6B8ABFFF6DB
        EAC7BED1A4A6D5A9A9FDE6E6F3CFCFE8BFBFDBA8A8A67A7A848282000000FFFF
        FFFFFFFFFFFFFFFFFFFFF9FCF9FFFFFFCBCACB939698C7B5A3FFECC9ECC6B9D3
        A7A9D2ACACFFFFFFFFF4F4FFF0F0FACFCFA77979858484000000FFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFC8C9C895989CCBB39BFFEABAF1C6B6D7ACB0C191
        91D7B6B6DCBCBCE6C5C5E1B5B5A87C7C878585000000FFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFCBCBCBA0A2A4988D80B0A086D5AFA6EBC1C3D09B9BC89090
        C38A8AC18989C18A8AB08282878585000000FFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFCBCBCBB3B3B29B9C9E929599A09899B2A09FB29F9FB49D9DB59B9BB4
        9797B793939F8181909090000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        D6D6D6B3B3B3B7B7B7B5B4B4ABAEAE9EA4A49BA2A29499999095958B8F8F8589
        898A8C8CD1D2D2000000}
      Layout = blGlyphTop
      ParentShowHint = False
      ShowHint = True
      OnClick = sbSairClick
      ExplicitLeft = 331
      ExplicitTop = 6
      ExplicitHeight = 40
    end
    object sbRelatorio: TSpeedButton
      Left = 260
      Top = 0
      Width = 65
      Height = 45
      Hint = 'Imprimir Relat'#243'rio'
      Align = alLeft
      Anchors = []
      Caption = 'F6-Relat'#243'rio'
      Flat = True
      Glyph.Data = {
        E6040000424DE604000000000000360000002800000014000000140000000100
        180000000000B0040000C40E0000C40E00000000000000000000FFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFC7C7C7A3A3A3A5A5A5A5A5A5DDDDDDFDFD
        FDFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFEAEAEAB2B2B2A6A6A6C9C9C9BDBDBD707070707070747474858585AFAFAF
        E5E5E5FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFCCCCCCA9A9A9B1B1
        B1DADADAFDFDFDFFFFFFCDCDCD7F7F7F7F7F7F8484848383837575757474748C
        8C8CBEBEBEEEEEEEFFFFFFFFFFFFF4F4F4BABABAC2C2C2EFEFEFFFFFFFFFFFFF
        FDFDFDFFFFFFC6C6C68787878787877373736F6F6F7878788484847F7F7F7474
        74777777949494D9D9D9DADADADDDDDDFFFFFFFFFFFFFCFCFCF1F1F1DEDEDED0
        D0D0ACACAC8181818181818484848181817878786D6D6D6C6C6C787878848484
        7373739A9A9ADDDDDDE0E0E0FDFDFDEAEAEAD9D9D9D1D1D1D5D5D5E6E6E6CCCC
        CC9B9B9B9B9B9B9393938989898686868484847E7E7E7070707171718989899E
        9E9EE0E0E0CFCFCFE2E2E2DCDCDCE3E3E3E9E9E9E7E7E7E0E0E0D4D4D4BDBDBD
        BDBDBDB3B3B3ABABABA0A0A09494948A8A8A8586858484848484849F9F9FE1E1
        E1D1D1D1EFEFEFEAEAEAE4E4E4DFDFDFD9D9D9D9D9D9E9E9E9E6E6E6E6E6E6DA
        DADACDCDCDBFBFBFB3B3B3AFADAEABA0A8A0979F8383839D9D9DE0E0E0D2D2D2
        E9E9E9DFDFDFD9D9D9DBDBDBE2E2E2F3F3F3F5F5F5F0F0F0F0F0F0EEEEEEECEC
        ECE6E6E6E4DFE2A6B6AA44C15B73BF7CA7A1A6A6A6A6EAEAEAC5C5C5DCDCDCDC
        DCDCE2E2E2BDBEBFABADAFC5C7C8E2E2E2F0F0F0F0F0F0F6F6F6F5F5F5F2F2F2
        F5F2F4D2D7D473C1838FD397A29DA1DADADAEAEAEAC5C5C5DCDCDCDCDCDCE2E2
        E2BDBEBFABADAFC5C7C8E2E2E2F0F0F0F0F0F0F6F6F6F5F5F5F2F2F2F5F2F4D2
        D7D473C1838FD397A29DA1DADADAFFFFFFE5E5E5C8C8C8D0D0D0D3D4D5A1978C
        9D938485807A7F7F7F8F91948F9194ABAEB1CDCFD1E3E3E3F0F0F0FCFAFBF1E5
        EFC2B8C1CFCFCFFFFFFFFFFFFFFFFFFFFFFFFFFEFEFECACCCEDAC7B3FFF3D2FD
        E0C0E8CBAEC4B098C4B098A797878A837BA3A2A1D3D3D4C5C5C5C1C1C1E7E7E7
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFCECECEE9D8C6FFEAD3FFE5CCFFE5
        C9FFE8C8FFE8C8FFE6C3FFDDB89F978EDADBDBF8F8F8FFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFC1BEBAFDF0E1FFECDBFFEAD6FFE7D2FFE5CE
        FFE5CEFFE4CAF5DAC0A5A3A0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFDADADAD8D5CFFFFBF1FFF1E6FFF0E1FFEDDDFFEBD7FFEBD7FF
        F1DACEBFAECACACBFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        F9F9F9C2C2C2FDFCFBFFFCF7FFF7F1FFF5ECFFF2E7FFF1E4FFF1E4FCEFE0ADAA
        A6FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFC8C8C8DD
        DDDDF8F8F8F8F8F8FFFDFCFFFFFEFFFEF9FFFFF7FFFFF7C1BDB7DEDEDEFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF7F7F7ECECECE0E0
        E0DDDDDDDDDDDDDADADADEDEDED0CFCED0CFCED4D4D5FFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFEFEFEFEBEBEBEBEBEBFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFF}
      Layout = blGlyphTop
      ParentShowHint = False
      ShowHint = True
      OnClick = sbRelatorioClick
      ExplicitLeft = 278
      ExplicitHeight = 40
    end
    object sbAdicionar: TSpeedButton
      Left = 0
      Top = 0
      Width = 65
      Height = 45
      Hint = 'Adicionar Novo Registro'
      Align = alLeft
      Anchors = []
      Caption = 'F2-Adicionar'
      Flat = True
      Glyph.Data = {
        E6040000424DE604000000000000360000002800000014000000140000000100
        180000000000B0040000C40E0000C40E00000000000000000000FFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFD9DED9A4ABA4A8ADA8AFB4AFAFB3AFA6ACA6A6AE
        A6E2E4E2FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFF5FAF577BC7F2A923A3694453C98493A97482D903A2E7C34B8C4B8
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFEAF1E96BCC7B4BDC733AD36936CF6437D16633CC60238F35A9B8A9FFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEAF1E9
        77D0865CE58745E07941D97341DB7639D36A298F3BACB8ACFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF1F8F083D58E5F
        DC8342D9743DD36D3FD56F36CC62298F3CB7C4B7FFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF8ED4946BE38B44DC
        783CD46D40D87038CF642B8C3CC8C8C8FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFCEDFCFB3C3B4ABBAABABBBACC1C9C1B1BAB15FB96E65EF8F4BE17E3ED671
        43DA743BD469248B34818D81C1C7C1B3BFB3ABB7ABAAB8AAB6C1B6E0E2E043AD
        4E47AF5D32A14932A34B379E4D319B4633C25B4BE98048E07B44DB7545DA7642
        D6722DB34C2793382D92402A923E29933E2791382A7A30A4ADA442BE507FF59E
        59ED8949E67C4EE57F50E67E4DE57E48DE7847DE7945DC7645DA7543D77544DB
        7540DA703CD3693AD1673CD87033CE60299236A7AEA73FBC4F89F2A36FF29859
        EB875CEC8A5BEB8A56E68453E28050E27D49DF7946DC7746DB7646DD7742DB74
        40D8713FD66F42DC7737CF643A9846B0B5B041BD5088F0A16FF0975BEA875CEB
        885AEA8954E88453E58254E5804FE37E49DF7946DD7743DA743DD7703BD46D3B
        D36C3FD87236CC613A9746AFB5AF45C05393F6AC84FBA974F69D74F59E74F59E
        6CF1955AE88854E68253E4804FE27D47DE7A4AE17E4EE27F46DC7741DA7544DE
        7B37D067339540AAB0AA3EBE4F88F0A08EF6A889F4A385F1A088F3A397FCB281
        F2A15AE78854E58353E27F47DF7954EF8A6FF2946AE28B5EE0855FE6894BD973
        1F9131A4ACA45EC36979D3857DD3887FD48986D48E79C98177D78595F9AE6BF0
        9656E78656E78449E07836C25A62BF6F8CD6947DD18972CC8168C97873BE7DD9
        E0D9E9F4E9E9F0E9E9EFE9EAF0EAF4F5F4E6E9E675C97D86F1A074F69D5CEA88
        5BEC8B49DF762A903AB0B6B0F7F9F7EEF4EEE7EEE7E8F0E7F5FAF5FFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFEFEFE88D69183EF9D73F69D5EEB885BEC8A48
        E075309542C4C4C4FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFEBF2EB82D68D87F0A073F59B5BEB8757EA8842DF742E9B
        43ADBDADFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFEAF1EA81D58C8DF4A685FAA871F2986DF39952E57F2C9B3FABBAAB
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFEAF2EA7DD48A87EE9D90F7A987F1A188F2A376EE9540A851B3C2B3FFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEAF5EA
        5EC36A3BBD4D41BF533FBC4F3EBD4F3DBE4F3EAA4BCDDECEFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFF}
      Layout = blGlyphTop
      ParentShowHint = False
      ShowHint = True
      OnClick = sbAdicionarClick
      ExplicitHeight = 40
    end
    object sbPesquisar: TSpeedButton
      Left = 195
      Top = 0
      Width = 65
      Height = 45
      Hint = 'Pesquisar Informa'#231#245'es'
      Align = alLeft
      Anchors = []
      Caption = 'F5-Pesquisar'
      Flat = True
      Glyph.Data = {
        E6040000424DE604000000000000360000002800000014000000140000000100
        180000000000B0040000C40E0000C40E00000000000000000000FFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFF6F6F6D6D6D6FAFAFAFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFF8F8F8DDDDDDC4C4C4BAB7B7B6B3B3B8B8B8C8C8C8DDDDDDF5F5F5
        FFFFFFF8F7F7A9A6B087827FA2A3A3F6F6F6FFFFFFFFFFFFFFFFFFD2CDCDC2AF
        AFBFA2A2BD9A9ABF9696BF9393B78A8AAC80809D767788686A866C629D8C8B73
        8CD95896EFCAD1C48C8881DBDBDBFFFFFFFFFFFFDCC6C6E3C0C0ECC4C4E6B9B9
        DBA8A8D9A5A5D7A4A4CE9A99C38F8FB88484B57B73A570776066B73A90F964D0
        FF64A7F4A19EA7EBEBEBFFFFFFEFD9D9F5D4D4FAD3D3F7CCCCF1C3C3E4B5B5E3
        AEAEE8AEAEDAA6A9C7959BCA918EC38C867175AD308BFA64D5FF45A2FF6689DF
        F0F0F3FDFDFDFFFFFFF1CFCFFFE1E1FBE0E0EECFCFE1BDBDE1AEADD8A5A8B899
        A1A69496A89590A2888BA1888D9DAAB869BFFA3497FF5767BEA99DABFFFFFFFF
        FFFFFFFFFFF4D8D8FAE5E5F0D4D4E8C3C3E3B2B2DAA9AEAE989BB09E86D5B685
        E0C08ECEB28C9F92859AA09EA4B6C45F6BA980525CACA0A0FFFFFFFFFFFFFFFF
        FFF2DADAFCE0E0F6D2D2EEC1C1F1B9BBBFA3AAB9AA90E5C589F4CD8EF1C98CF4
        CB8EDABD8F9F94878F787D905D5A78463EA9A5A6FFFFFFFFFFFFFFFFFFF3D4D4
        FFDCDCFDDCDCF6CFCFE6C3CAB9AAA3DCC595FCDBA1EDD1A1E9CA97EDC890F5D0
        94CDB490886D6F854A47693D3EA7A2A2FFFFFFFFFFFFFFFFFFF5D6D6FCE4E4F2
        D9D9EFC8C7D4B6BEC1B19EEAD6ACFDE8C1F0DDB7EFD7ABE8CA99F1CC92E2C598
        97817F824D52724444A39C9CFFFFFFFFFFFFFFFFFFF6DBDBFAE4E4F3D4D4EFC1
        C0DEB3B9BEADA0EAE2C3FFFDEAF7EED9F1E0BCECD2A5F4D197D7BD938E7A7C85
        4F52774B4AABA6A6FFFFFFFFFFFFFEFEFEF6D8D8FEDBDBFCD5D5F5C9C9F2C1C3
        CAB2B1D4D3C0FBFFF0FFFFF3FEEECCFEE1ADEACF99B2A38E8B68717C43437044
        44ADA9A9FFFFFFFFFFFFFDFBFBF8D6D6FFE1E1F9DBDBEFCCCCEBC0BFDDB5B8C3
        B4B2D2D4C4E8EAD1EEE1BCE2CFA4BAAD959881849862657E48486E4141A6A0A0
        FFFFFFFFFFFFFEFCFCF8DCDCFAE6E6F3D9D9EBC8C8DEB6B6DCA8A8D4A6AAC0A9
        A9BDB0A3BFB1A1AE9F98A0848AA26F73965E5D855252774B4BA8A2A2FFFFFFFF
        FFFFFEFEFEF8DEDEFADFDFF4CFCFF0C3C3E6B6B6D8A5A5DEA5A4DEA7AACB9FA4
        BB949BB98A90B67E7FA36C6C8D5A5A804C4C794D4DAEAAAAFFFFFFFFFFFFFDFA
        FAFAD6D6FFDCDCFBD8D8F2C9C9E7BABADBAAAAD9A7A7D7A3A3D19898C68C8CB9
        8282AD7A79A16F6F8F5C5C7845456C4141ABA7A7FFFFFFFFFFFFFEFBFBFAD9D9
        FFE0E0FADADAF3CECEEDC4C4E4B8B8E1B3B3DFB0B0D7A6A6CC9A9AC28F8FB582
        82A67373925F5F7D4A4A704444A8A3A3FFFFFFFFFFFFFEFBFBFCE0E0FEE9E9FC
        DEDEF8D4D4F6CECEF5CBCBF2C6C6F0C2C2ECBDBDE8B7B7E1AFAFD7A4A4CB9898
        BB88889F6C6C7E5353B5B0B0FFFFFFFFFFFFFFFFFFFDF1F1FCD6D6FAC8C8F5C1
        C1F2BEBEEFBBBBECB7B7E8B4B4E5B3B3E3B1B1E1AEAEDFAEAEDDACACDAA9A9C3
        9595AF9191F3F3F3FFFFFFFFFFFFFFFFFFFFFFFFFEFAFAFDEEEEF7E1E1F1D4D4
        ECCCCCE9C6C6E6C2C2E1BEBEDEBBBBD9B8B8D7B9B9D7BCBCDAC7C7EAE3E3FFFF
        FFFFFFFFFFFFFFFFFFFF}
      Layout = blGlyphTop
      ParentShowHint = False
      ShowHint = True
      OnClick = sbPesquisarClick
      ExplicitHeight = 40
    end
  end
  object dbgPesq: TDBGrid
    Left = 0
    Top = 65
    Width = 384
    Height = 135
    Align = alClient
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
    PopupMenu = pmPad
    TabOrder = 1
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
        Visible = True
      end>
  end
  object gbFiltro: TGroupBox
    Left = 0
    Top = 0
    Width = 384
    Height = 65
    Align = alTop
    Caption = 'Filtros'
    Color = clGradientInactiveCaption
    ParentBackground = False
    ParentColor = False
    TabOrder = 2
    object psFiltros: TPageScroller
      Left = 2
      Top = 15
      Width = 380
      Height = 48
      Align = alClient
      Color = clGradientInactiveCaption
      Control = paFiltros
      ParentBackground = False
      ParentColor = False
      TabOrder = 0
      object paFiltros: TPanel
        Left = 0
        Top = 0
        Width = 1000
        Height = 48
        Align = alLeft
        BevelOuter = bvNone
        Color = clGradientInactiveCaption
        ParentBackground = False
        ShowCaption = False
        TabOrder = 0
      end
    end
  end
  object pmPad: TPopupMenu
    Left = 128
    Top = 40
    object SalvarConfiguraodaGrade1: TMenuItem
      Caption = 'Salvar Configura'#231#227'o da Grade'
      OnClick = SalvarConfiguraodaGrade1Click
    end
    object RestaurarConfiguraodaGrade1: TMenuItem
      Caption = 'Restaurar Configura'#231#227'o da Grade'
      OnClick = RestaurarConfiguraodaGrade1Click
    end
    object ExportardadosparaPlanilhaExcel1: TMenuItem
      Caption = 'Exportar dados para Planilha Excel'
      OnClick = ExportardadosparaPlanilhaExcel1Click
    end
  end
end
