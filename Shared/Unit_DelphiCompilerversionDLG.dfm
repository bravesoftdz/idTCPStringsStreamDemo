object OKRightDlgDelphi: TOKRightDlgDelphi
  Left = 833
  Top = 360
  BorderStyle = bsDialog
  Caption = 'Program Build Information'
  ClientHeight = 177
  ClientWidth = 372
  Color = clBtnFace
  ParentFont = True
  OldCreateOrder = True
  Position = poOwnerFormCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Bevel1: TBevel
    Left = 8
    Top = 8
    Width = 281
    Height = 161
    Shape = bsFrame
  end
  object Label1: TLabel
    Left = 17
    Top = 13
    Width = 100
    Height = 13
    Caption = 'Compiler Information'
  end
  object OKBtn: TButton
    Left = 292
    Top = 8
    Width = 75
    Height = 25
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 0
    OnClick = OKBtnClick
  end
  object CancelBtn: TButton
    Left = 292
    Top = 38
    Width = 75
    Height = 25
    Cancel = True
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 1
    Visible = False
  end
  object EditCompilerVersion: TEdit
    Left = 17
    Top = 30
    Width = 264
    Height = 21
    TabOrder = 2
    Text = 'EditCompilerVersion'
    OnChange = FormShow
  end
  object RadioGroupBits: TRadioGroup
    Left = 17
    Top = 61
    Width = 264
    Height = 44
    Caption = 'Application Mode'
    Columns = 2
    Items.Strings = (
      '32 BIT'
      '64 BIT')
    TabOrder = 3
    OnClick = FormShow
  end
  object CharSizeRadioGroup: TRadioGroup
    Left = 17
    Top = 111
    Width = 264
    Height = 50
    Caption = 'Char Size '
    Columns = 3
    Items.Strings = (
      'AnsiChar'
      'WideChar'
      'unknown')
    TabOrder = 4
  end
end
