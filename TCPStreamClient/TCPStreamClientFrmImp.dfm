object TCPStreamClientFrm: TTCPStreamClientFrm
  Left = 0
  Top = 0
  Caption = 'TCP Stream Client'
  ClientHeight = 252
  ClientWidth = 457
  Color = clBtnFace
  Constraints.MinHeight = 291
  Constraints.MinWidth = 473
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  DesignSize = (
    457
    252)
  PixelsPerInch = 96
  TextHeight = 13
  object StatusBar1: TStatusBar
    Left = 0
    Top = 233
    Width = 457
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
    ExplicitTop = 499
    ExplicitWidth = 671
  end
  object PageControl1: TPageControl
    Left = 8
    Top = 102
    Width = 446
    Height = 123
    ActivePage = TbsLogs
    Anchors = [akLeft, akRight, akBottom]
    TabOrder = 1
    object TbsLogs: TTabSheet
      Caption = 'Logs'
      ExplicitHeight = 104
      object MemoLogs: TMemo
        Left = 0
        Top = 0
        Width = 438
        Height = 95
        Align = alClient
        TabOrder = 0
        ExplicitHeight = 104
      end
    end
    object TbsMsg: TTabSheet
      Caption = 'Message'
      ImageIndex = 1
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 646
      ExplicitHeight = 157
      object Memo1: TMemo
        Left = 0
        Top = 0
        Width = 438
        Height = 104
        Align = alClient
        TabOrder = 0
        ExplicitWidth = 646
        ExplicitHeight = 157
      end
    end
  end
  object MemoMsgs: TMemo
    Left = 184
    Top = 8
    Width = 270
    Height = 57
    Anchors = [akLeft, akTop, akRight, akBottom]
    ScrollBars = ssBoth
    TabOrder = 2
  end
  object Button_SendStream: TButton
    Left = 184
    Top = 69
    Width = 89
    Height = 27
    Anchors = [akLeft, akBottom]
    Caption = 'Send Request'
    TabOrder = 3
    OnClick = Button_SendStreamClick
  end
  object GroupBox1: TGroupBox
    Left = 8
    Top = 8
    Width = 169
    Height = 89
    Anchors = [akLeft, akTop, akBottom]
    Caption = 'Connection'
    TabOrder = 4
    object Label1: TLabel
      Left = 8
      Top = 16
      Width = 10
      Height = 13
      Caption = 'IP'
    end
    object Label2: TLabel
      Left = 8
      Top = 40
      Width = 20
      Height = 13
      Caption = 'Port'
    end
    object SpeedButton1: TSpeedButton
      Left = 8
      Top = 64
      Width = 153
      Height = 22
      Caption = 'Connect/Disconnect'
      OnClick = SpeedButton1Click
    end
    object EdtIP: TEdit
      Left = 32
      Top = 16
      Width = 129
      Height = 21
      TabOrder = 0
      Text = '127.0.0.1'
    end
    object EdtPort: TSpinEdit
      Left = 32
      Top = 40
      Width = 57
      Height = 22
      MaxValue = 0
      MinValue = 0
      TabOrder = 1
      Value = 6000
    end
  end
  object TCPClient: TIdTCPClient
    OnDisconnected = TCPClientDisconnected
    OnConnected = TCPClientConnected
    ConnectTimeout = 0
    IPVersion = Id_IPv4
    Port = 0
    ReadTimeout = -1
    Left = 424
    Top = 80
  end
end
