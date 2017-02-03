program TCPStreamServer;

uses
  Vcl.Forms,
  Unit_Indy_Classes in '..\Shared\Unit_Indy_Classes.pas',
  Unit_Indy_Functions in '..\Shared\Unit_Indy_Functions.pas',
  Unit_DelphiCompilerVersion in '..\Shared\Unit_DelphiCompilerVersion.pas',
  Unit_DelphiCompilerversionDLG in '..\Shared\Unit_DelphiCompilerversionDLG.pas' {OKRightDlgDelphi},
  TCPStreamServerFrmImp in 'TCPStreamServerFrmImp.pas' {TCPStreamServerFrm};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TTCPStreamServerFrm, TCPStreamServerFrm);
  Application.CreateForm(TOKRightDlgDelphi, OKRightDlgDelphi);
  Application.Run;
end.
