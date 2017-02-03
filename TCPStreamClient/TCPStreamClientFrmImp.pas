unit TCPStreamClientFrmImp;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, IdBaseComponent, IdComponent, IdTCPConnection, IdTCPClient, StdCtrls,
  Vcl.ExtCtrls, Vcl.Samples.Spin, Vcl.Buttons, Vcl.ComCtrls, Vcl.CheckLst;

type
  TTCPStreamClientFrm = class(TForm)
    TCPClient: TIdTCPClient;
    StatusBar1: TStatusBar;
    PageControl1: TPageControl;
    TbsLogs: TTabSheet;
    MemoLogs: TMemo;
    TbsMsg: TTabSheet;
    Memo1: TMemo;
    MemoMsgs: TMemo;
    Button_SendStream: TButton;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    SpeedButton1: TSpeedButton;
    EdtIP: TEdit;
    EdtPort: TSpinEdit;
    procedure TCPClientConnected(Sender: TObject);
    procedure TCPClientDisconnected(Sender: TObject);
    procedure Button_SendStreamClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
  private
    FStreamS : TStringStream;
    FStreamR : TStringStream;
    procedure WMSysCommand(var Msg: TMessage); message WM_SYSCOMMAND;
    procedure ActiveClient(doConnect : Boolean);
    { Private declarations }
  public
    { Public declarations }
  end;

var
  TCPStreamClientFrm: TTCPStreamClientFrm;

implementation

uses Unit_Indy_Classes, Unit_Indy_Functions, Unit_DelphiCompilerversionDLG;

const
  ID_INFOCOMPILER = WM_USER + 1;
  ID_NEWLINE = WM_USER + 4;

{$R *.dfm}

procedure TTCPStreamClientFrm.Button_SendStreamClick(Sender: TObject);
  var
    lSlTemp : TStrings;
begin
  FStreamS := TStringStream.Create;
  FStreamR := TStringStream.Create;
  lSlTemp := TStringList.Create;
  try
    MemoLogs.Lines.Add('Try send stream to server.....');

    ActiveClient(True); //Connect

    lSlTemp.Clear;
    lSlTemp.Add('TCPStreamClientMessage');
    lSlTemp.Add(Format('Time: %s', [FormatDateTime('DD/MM/YYYY HH:NN:SS.ZZZ', now)]));
    lSlTemp.Add(Format('<<<BOF', [MemoMsgs.Lines.Text]));
    lSlTemp.Add(Format('%s', [MemoMsgs.Lines.Text]));
    lSlTemp.Add(Format('EOF>>>', [MemoMsgs.Lines.Text]));
    lSlTemp.SaveToStream(FStreamS);
    FStreamS.Position := 0;
    if (SendStream(TCPClient, TStream(FStreamS)) = False) then
    begin
      MemoLogs.Lines.Add('Cannot send STREAM to server, Unknown error occured');
      Exit;
    end;
    FStreamS.Position := 0;
    Memo1.Lines.LoadFromStream(FStreamS);
    MemoLogs.Lines.Add('Stream successfully sent');

    if (ReceiveStream(TCPClient, TStream(FStreamR)) = False) then
    begin
      MemoLogs.Lines.Add('Cannot get STREAM from server, Unknown error occured');
      Exit;
    end;

    FStreamR.Position := 0;
    lSlTemp.Clear;
    lSlTemp.LoadFromStream(FStreamR);

    MemoLogs.Lines.Add('Response: '+lSlTemp.Text);
  finally
    ActiveClient(False); //Disconnect
    FreeAndNil(lSlTemp);
    FreeAndNil(FStreamS);
    FreeAndNil(FStreamR);
  end;
end;

procedure TTCPStreamClientFrm.SpeedButton1Click(Sender: TObject);
begin
  ActiveClient(not TCPClient.Connected);
end;

procedure TTCPStreamClientFrm.WMSysCommand(var Msg: TMessage);
begin
  case Msg.wParam of
    ID_INFOCOMPILER : OKRightDlgDelphi.Show;
  end;
  inherited;
end;

procedure TTCPStreamClientFrm.ActiveClient(doConnect : Boolean);
begin
  StatusBar1.Panels[3].Text := EmptyStr;
  try
    try
      if doConnect and TCPClient.Connected then
        raise Exception.Create('The client is connected.');

      if doConnect then
      begin
        TCPClient.Host := EdtIP.Text;
        TCPClient.Port := EdtPort.Value;
        TCPClient.Connect;
      end
      else
        TCPClient.Disconnect;
    except
      on E: Exception do
        MemoLogs.Lines.Add(e.Message)
    end;
  finally
    if TCPClient.Connected then
      StatusBar1.Panels[3].Text := 'Connected';
  end;
end;

procedure TTCPStreamClientFrm.FormCreate(Sender: TObject);
var
  SysMenu: THandle;
begin
  SysMenu := GetSystemMenu(Handle, False);
  InsertMenu(SysMenu, Word(-1), MF_SEPARATOR, ID_NEWLINE, '');
  InsertMenu(SysMenu, Word(-1), MF_BYPOSITION, ID_INFOCOMPILER, 'Program build information.');
end;

procedure TTCPStreamClientFrm.TCPClientConnected(Sender: TObject);
begin
  MemoLogs.Lines.Add('Client has connected to server');
end;

procedure TTCPStreamClientFrm.TCPClientDisconnected(Sender: TObject);
begin
  MemoLogs.Lines.Add('Client has disconnected from server');
end;

end.
