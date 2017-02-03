unit TCPStreamServerFrmImp;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, IdContext, StdCtrls, IdBaseComponent, IdComponent, IdCustomTCPServer,
  IdTCPServer, IdSync, Unit_Indy_Classes, Unit_Indy_Functions, Vcl.Imaging.jpeg,
  Vcl.ExtCtrls, Vcl.ComCtrls, Vcl.Buttons, Vcl.Samples.Spin, Vcl.CheckLst,
  IdStack;

type
  TTCPStreamServerFrm = class(TForm)
    TCPServer: TIdTCPServer;
    StatusBar1: TStatusBar;
    Panel1: TPanel;
    SpeedButton1: TSpeedButton;
    Label1: TLabel;
    EdtPort: TSpinEdit;
    GroupBox1: TGroupBox;
    MemoLogs: TMemo;
    GroupBox2: TGroupBox;
    MemoMsgs: TMemo;
    ClbIPs: TCheckListBox;
    procedure FormCreate(Sender: TObject);
    procedure ClientConnected;
    procedure ClientDisconnected;
    procedure TCPServerExecute(AContext: TIdContext);
    procedure TCPServerConnect(AContext: TIdContext);
    procedure TCPServerDisconnect(AContext: TIdContext);
    procedure FormDestroy(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
  private
    procedure ShowCannotGetBufferErrorMessage;
    procedure ShowCannotSendBufferErrorMessage;
    procedure StreamReceived;
    procedure WMSysCommand(var Msg: TMessage); message WM_SYSCOMMAND;
    procedure ActiveServer(doConnect : Boolean = True);
    { Private declarations }
  public
    { Public declarations }
  end;

var
  TCPStreamServerFrm: TTCPStreamServerFrm;
  //MyErrorMessage: string;
implementation

{$R *.dfm}

uses Unit_DelphiCompilerversionDLG;

const
  ID_INFOCOMPILER = WM_USER + 1;
  ID_NEWLINE = WM_USER + 4;

procedure TTCPStreamServerFrm.ActiveServer(doConnect : Boolean);
  var
    i : Integer;
begin
  StatusBar1.Panels[3].Text := EmptyStr;
  try
    try
      if doConnect and TCPServer.Active then
        raise Exception.Create('The server is running.');

      TCPServer.Bindings.Clear;
      if doConnect then
      begin
        for i := 0 to ClbIPs.Items.Count - 1 do
        begin
          if ClbIPs.Checked[i] then
            TCPServer.Bindings.Add.IP := ClbIPs.Items[i];
        end;
      end;

      TCPServer.Bindings.Add.Port := EdtPort.Value;

      TCPServer.Active := doConnect;
    except
      on e : exception do
      begin
        MemoLogs.Lines.Add(e.Message)
      end;
    end;
  finally
    if TCPServer.Active then
      StatusBar1.Panels[3].Text := 'Running';
  end;
end;

procedure TTCPStreamServerFrm.ClientConnected;
begin
  MemoLogs.Lines.Add('A Client connected');
end;

procedure TTCPStreamServerFrm.ClientDisconnected;
begin
  MemoLogs.Lines.Add('A Client disconnected');
end;

procedure TTCPStreamServerFrm.FormCreate(Sender: TObject);
var
  SysMenu: THandle;
begin
  SysMenu := GetSystemMenu(Handle, False);
  InsertMenu(SysMenu, Word(-1), MF_SEPARATOR, ID_NEWLINE, '');
  InsertMenu(SysMenu, Word(-1), MF_BYPOSITION, ID_INFOCOMPILER, 'Program build information.');

  with ClbIPs do
  begin
    Clear;
    Items := GStack.LocalAddresses;
    If Items.Strings[0] <> '127.0.0.1' then
      Items.Insert(0, '127.0.0.1');

    Checked[0] := true;
  end;

  ActiveServer(True);
end;

procedure TTCPStreamServerFrm.FormDestroy(Sender: TObject);
begin
  TCPServer.Active := False;
end;

procedure TTCPStreamServerFrm.TCPServerConnect(AContext: TIdContext);
begin
  TIdNotify.NotifyMethod(ClientConnected);
end;

procedure TTCPStreamServerFrm.TCPServerDisconnect(AContext: TIdContext);
begin
  TIdNotify.NotifyMethod(ClientDisconnected);
end;

procedure TTCPStreamServerFrm.TCPServerExecute(AContext: TIdContext);
  var
    FStreamR : TStringStream;
    FStreamS : TStringStream;
    lSlResponse : TStrings;
begin
  FStreamR := TStringStream.Create;
  FStreamS := TStringStream.Create;
  lSlResponse := TStringList.Create;
  try
    MemoLogs.Lines.Add('Server starting  .... ');
    AContext.Connection.IOHandler.ReadTimeout := 9000;

    if (ReceiveStream(AContext, TStream(FStreamR)) = False) then
    begin
      TIdNotify.NotifyMethod(ShowCannotGetBufferErrorMessage);
      Exit;
    end;
    FStreamR.Position := 0;
    MemoMsgs.Lines.Clear;
    MemoMsgs.Lines.LoadFromStream(FStreamR);
    TIdNotify.NotifyMethod(StreamReceived);

    MemoLogs.Lines.Add('Stream Size: ' + IntToStr(FStreamR.Size));

    //Response
    lSlResponse.Add('TCPStreamServerResponse');
    lSlResponse.Add(Format('Time: %s', [FormatDateTime('DD/MM/YYYY HH:NN:SS.ZZZ', now)]));
    lSlResponse.Add(Format('Count: %s', [IntToStr(MemoMsgs.Lines.Count)]));
    lSlResponse.SaveToStream(FStreamS);
    FStreamS.Position := 0;
    if (SendStream(AContext, TStream(FStreamS)) = False) then
    begin
      TIdNotify.NotifyMethod(ShowCannotSendBufferErrorMessage);
      Exit;
    end;

    MemoLogs.Lines.Add('Stream sent');
    MemoLogs.Lines.Add('Server done .... ');
  finally
    FreeAndNil(lSlResponse);
    FreeAndNil(FStreamR);
    FreeAndNil(FStreamS);
  end;
end;

procedure TTCPStreamServerFrm.StreamReceived;
begin
  MemoLogs.Lines.Add('Stream received');
end;

procedure TTCPStreamServerFrm.WMSysCommand(var Msg: TMessage);
begin
  case Msg.wParam of
    ID_INFOCOMPILER : OKRightDlgDelphi.Show;
  end;
  inherited;
end;

procedure TTCPStreamServerFrm.ShowCannotGetBufferErrorMessage;
begin
  MemoLogs.Lines.Add('Cannot get stream from client, Unknown error occured');
end;

procedure TTCPStreamServerFrm.ShowCannotSendBufferErrorMessage;
begin
  MemoLogs.Lines.Add('Cannot send stream to client, Unknown error occured');
end;

procedure TTCPStreamServerFrm.SpeedButton1Click(Sender: TObject);
begin
  ActiveServer(not TCPServer.Active);
end;

end.
