object frmPeriodo: TfrmPeriodo
  Left = 0
  Top = 0
  Width = 168
  Height = 34
  TabOrder = 0
  object Label1: TLabel
    Left = 3
    Top = 0
    Width = 53
    Height = 13
    Caption = 'Data Inicial'
  end
  object Label2: TLabel
    Left = 88
    Top = 0
    Width = 48
    Height = 13
    Caption = 'Data Final'
  end
  object meDtIni: TJvDatePickerEdit
    Left = 2
    Top = 13
    Width = 81
    Height = 21
    AllowNoDate = True
    Checked = True
    TabOrder = 0
    OnExit = meDtIniExit
  end
  object meDtFin: TJvDatePickerEdit
    Left = 85
    Top = 13
    Width = 81
    Height = 21
    AllowNoDate = True
    Checked = True
    TabOrder = 1
    OnExit = meDtFinExit
  end
end
