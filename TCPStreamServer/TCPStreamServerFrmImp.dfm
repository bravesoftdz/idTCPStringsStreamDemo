object TCPStreamServerFrm: TTCPStreamServerFrm
  Left = 0
  Top = 0
  Caption = 'TCP Stream Server'
  ClientHeight = 538
  ClientWidth = 296
  Color = clBtnFace
  Constraints.MinHeight = 464
  Constraints.MinWidth = 312
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object StatusBar1: TStatusBar
    Left = 0
    Top = 519
    Width = 296
    Height = 19
    Panels = <
      item
        Text = 'IP'
        Width = 50
      end
      item
        Text = '127.0.0.1'
        Width = 80
      end
      item
        Text = 'Status'
        Width = 50
      end
      item
        Width = 200
      end>
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 296
    Height = 65
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 1
    object SpeedButton1: TSpeedButton
      Left = 176
      Top = 40
      Width = 105
      Height = 22
      Caption = 'Start/Stop Server'
      OnClick = SpeedButton1Click
    end
    object Label1: TLabel
      Left = 176
      Top = 8
      Width = 24
      Height = 13
      Caption = 'Port:'
    end
    object EdtPort: TSpinEdit
      Left = 208
      Top = 8
      Width = 73
      Height = 22
      MaxValue = 0
      MinValue = 0
      TabOrder = 1
      Value = 6000
    end
    object ClbIPs: TCheckListBox
      Left = 8
      Top = 8
      Width = 161
      Height = 49
      ItemHeight = 13
      TabOrder = 0
    end
  end
  object GroupBox1: TGroupBox
    Left = 0
    Top = 408
    Width = 296
    Height = 111
    Align = alBottom
    Caption = 'Logs'
    TabOrder = 2
    object MemoLogs: TMemo
      Left = 2
      Top = 15
      Width = 292
      Height = 94
      Align = alClient
      TabOrder = 0
    end
  end
  object GroupBox2: TGroupBox
    Left = 0
    Top = 65
    Width = 296
    Height = 343
    Align = alClient
    Caption = 'Messages'
    TabOrder = 3
    object MemoMsgs: TMemo
      Left = 2
      Top = 15
      Width = 292
      Height = 326
      TabStop = False
      Align = alClient
      Color = clInfoBk
      ReadOnly = True
      ScrollBars = ssBoth
      TabOrder = 0
    end
  end
  object TCPServer: TIdTCPServer
    Bindings = <>
    DefaultPort = 0
    OnConnect = TCPServerConnect
    OnDisconnect = TCPServerDisconnect
    OnExecute = TCPServerExecute
    Left = 136
    Top = 8
  end
end
