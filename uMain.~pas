unit uMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, IdBaseComponent, IdComponent,
  IdTCPConnection, IdTCPClient, IdUDPBase, IdUDPClient,IniFiles, ExtCtrls,
  IdUDPServer,IdSocketHandle;

type
  TForm1 = class(TForm)
    IdTCPClient: TIdTCPClient;
    IdUDPClient1: TIdUDPClient;
    IdUDPServer1: TIdUDPServer;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    ed_IP: TEdit;
    Label2: TLabel;
    ed_Port: TEdit;
    rg_Type: TRadioGroup;
    ed_Data: TEdit;
    Label4: TLabel;
    Label3: TLabel;
    ed_count: TEdit;
    Label5: TLabel;
    ed_DelayTime: TEdit;
    Label6: TLabel;
    chk_HextoASCII: TCheckBox;
    btn_Send: TSpeedButton;
    btn_Close: TSpeedButton;
    GroupBox2: TGroupBox;
    Label7: TLabel;
    ed_RcvPort: TEdit;
    btn_Receive: TSpeedButton;
    Memo1: TMemo;
    btn_Clear: TSpeedButton;
    chk_AsctoHex: TCheckBox;
    procedure btn_CloseClick(Sender: TObject);
    procedure btn_SendClick(Sender: TObject);
    procedure IdTCPClientConnected(Sender: TObject);
    procedure IdTCPClientDisconnected(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure rg_TypeClick(Sender: TObject);
    procedure btn_ReceiveClick(Sender: TObject);
    procedure IdUDPServer1UDPRead(Sender: TObject; AData: TStream;
      ABinding: TIdSocketHandle);
    procedure btn_ClearClick(Sender: TObject);
  private
    L_bConnected : Boolean;
    { Private declarations }
    procedure DataSend;
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

uses
  uLomosUtil;
{$R *.dfm}

procedure Delay(MSecs: Longint);
var
  FirstTickCount, Now: Longint;
begin
  FirstTickCount := GetTickCount;
  repeat
    Application.ProcessMessages;
    { allowing access to other controls, etc. }
    Now := GetTickCount;
  until (Now - FirstTickCount >= MSecs) or (Now < FirstTickCount);
end;

procedure TForm1.btn_CloseClick(Sender: TObject);
begin
  Close;
end;

procedure TForm1.btn_SendClick(Sender: TObject);
var
  i : integer;
begin
  btn_Send.Enabled := False;
  for i := 1 to strtoint(ed_count.Text) do
  begin
    DataSend;
    Delay(strtoint(ed_DelayTime.text));
  end;

  btn_Send.Enabled := True;
end;

procedure TForm1.IdTCPClientConnected(Sender: TObject);
begin
  L_bConnected := True;
end;

procedure TForm1.IdTCPClientDisconnected(Sender: TObject);
begin
  L_bConnected := False;
end;

procedure TForm1.FormClose(Sender: TObject; var Action: TCloseAction);
var
  ini_fun : TiniFile;
begin
  Try
    ini_fun := TiniFile.Create(ExtractFileDir(Application.ExeName) + '\config.INI');
    ini_fun.Writestring('Setting','IP',ed_IP.Text);
    ini_fun.Writestring('Setting','PORT',ed_PORT.Text);
    ini_fun.WriteInteger('Setting','TYPE',rg_Type.ItemIndex);
    ini_fun.Writestring('Setting','DATA',ed_Data.Text);
    ini_fun.Writestring('Setting','COUNT',ed_count.Text);
    ini_fun.Writestring('Setting','RcvPORT',ed_RcvPORT.Text);

  Finally
    ini_fun.Free;
  End;

end;

procedure TForm1.FormCreate(Sender: TObject);
var
  ini_fun : TiniFile;
begin
  Try
    ini_fun := TiniFile.Create(ExtractFileDir(Application.ExeName) + '\config.INI');
    ed_IP.Text := ini_fun.Readstring('Setting','IP','');
    ed_PORT.Text := ini_fun.Readstring('Setting','PORT','');
    rg_Type.ItemIndex := ini_fun.ReadInteger('Setting','TYPE',0);
    ed_Data.Text := ini_fun.Readstring('Setting','DATA','');
    ed_count.Text := ini_fun.Readstring('Setting','COUNT','1');
    ed_RcvPORT.Text := ini_fun.Readstring('Setting','RcvPORT','');

  Finally
    ini_fun.Free;
  End;
  Memo1.Lines.Clear;
end;

procedure TForm1.DataSend;
var
  stSendData : string;
begin
  stSendData := ed_Data.Text;
  if chk_HextoASCII.Checked then
  begin
    stSendData := stringReplace(stSendData,' ','',[rfReplaceAll]);
    stSendData := stringReplace(stSendData,'[','',[rfReplaceAll]);
    stSendData := stringReplace(stSendData,']','',[rfReplaceAll]);
    stSendData := Hex2Ascii(stSendData);
  end;

  if rg_Type.ItemIndex = 0 then
  begin
    IdUDPClient1.Host := ed_IP.Text;
    IdUDPClient1.Port := strtoint(ed_Port.Text);
    IdUDPClient1.Send(stSendData);
  end else if rg_Type.ItemIndex = 1 then
  begin
    if IdTCPClient.Connected then IdTCPClient.Disconnect;
    IdTCPClient.Host := ed_IP.Text;
    IdTCPClient.Port := strtoint(ed_Port.Text);
    IdTCPClient.Connect(1000);
    if Not L_bConnected then
    begin
      showmessage('Connected Fail');
      Exit;
    end;
    IdTCPClient.Write(stSendData);
  end else if rg_Type.ItemIndex = 2 then
  begin
    IdUDPClient1.Broadcast(stSendData,strtoint(ed_Port.Text));
//    IdUDPClient1.Active := True;
  end;
end;

procedure TForm1.rg_TypeClick(Sender: TObject);
begin
  if rg_Type.ItemIndex = 2 then ed_IP.Enabled := False
  else ed_IP.Enabled := True;
end;

procedure TForm1.btn_ReceiveClick(Sender: TObject);
begin
  btn_Receive.Enabled := False;
  IdUDPServer1.Active := False;
  IdUDPServer1.DefaultPort := strtoint(ed_RcvPort.Text);
  IdUDPServer1.Active := True;
end;

procedure TForm1.IdUDPServer1UDPRead(Sender: TObject; AData: TStream;
  ABinding: TIdSocketHandle);
var
  DataStringStream: TStringStream;
  RecvData : String;
begin
  DataStringStream := TStringStream.Create('');
  try
    DataStringStream.CopyFrom(AData, AData.Size);
    RecvData:=DataStringStream.DataString;
  finally
    DataStringStream.Free;
  end;
  if chk_AsctoHex.Checked then
  begin
    RecvData := Ascii2Hex(RecvData,False,False,30,'[',']');
  end;
  memo1.Lines.Add(RecvData);
end;

procedure TForm1.btn_ClearClick(Sender: TObject);
begin
  memo1.Lines.Clear;
end;

end.
