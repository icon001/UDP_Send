program UdpSend;

uses
  Forms,
  uMain in 'uMain.pas' {Form1},
  uLomosUtil in 'uLomosUtil.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
