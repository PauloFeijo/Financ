object frmConta: TfrmConta
  Left = 0
  Top = 0
  Width = 336
  Height = 37
  TabOrder = 0
  object Label1: TLabel
    Left = 2
    Top = 1
    Width = 49
    Height = 13
    Caption = 'Cd. Conta'
  end
  object Label2: TLabel
    Left = 55
    Top = 1
    Width = 93
    Height = 13
    Caption = 'Descri'#231#227'o da Conta'
  end
  object edCodigo: TEdit
    Left = 0
    Top = 16
    Width = 50
    Height = 21
    NumbersOnly = True
    TabOrder = 0
    OnExit = edCodigoExit
  end
  object edDescricao: TEdit
    Left = 55
    Top = 16
    Width = 279
    Height = 21
    Color = clBtnFace
    Enabled = False
    TabOrder = 1
  end
end
