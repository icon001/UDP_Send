{*******************************************************}
{                                                       }
{         화일명: uLomosUtil.pas                        }
{         설  명: 유틸리티                              }
{         작성일:                                       }
{         작성자: 전진운                                }
{         Copyright                                     }
{                                                       }
{*******************************************************}
//OpenPictureDialog1.InitialDir:= ExtractFileDir(Application.ExeName);
unit uLomosUtil;

interface
uses
  shellapi,
  ComCtrls,
  winsock,
  DBTables,
  Windows,
  SysUtils,
  Controls,
  Classes,
  Graphics,
  Forms,
  DB,
  DBGrids,
  iniFiles,
  DateUtils,
  StdCtrls,
  Messages,
  Nb30,
  TlHelp32;

const
  STX = #$2;
  ETX = #$3;
  ENQ = #$5;
  ACK = #$6;
  NAK = #$15;
  EOT = #$04;
  TAB = #$09;
  HexString : String = '0123456789ABCDEF';

const
  MB_TIMEDOUT = 32000;

type
 TNBLanaResources = (lrAlloc, lrFree);
type
 PMACAddress = ^TMACAddress;
 TMACAddress = array[0..5] of Byte;

type CString = string[100];

 TIsHungAppWindow = function(Wnd: HWND): Bool; stdcall;
 TIsHungThread = function(lpThreadId: DWORD): Bool; stdcall;

  function ActivateScreenSaver( Activate : Boolean ) : Boolean;
  function Ascii2Hex(aData:string;bReverse:Boolean = False;bConvert:Boolean=False;aConvertDec:integer=30;aStart:string='';aEnd:string=''):string;
  function AsciiLen2Hex(aData:string;aLen:integer;bReverse:Boolean = False):string;
  function Bin2Dec(BinString: string): LongInt;
  function BinaryToHex(Binary:string):string;
  Function BinToHexStr(aData:string):string;
  function BinToInt(Value : String) : Integer;
  Function ByteCopy(p:pAnsiChar;n:cardinal):String;
  procedure CDLogSave(aFileName: String;ast:string);
  function char2Hex(aData:char):string;
  function CheckDataPacket(aData:String; var bData:String):string;
  function CheckSumCheck(aBuff:string):Boolean;
  procedure ClearBitB(var b:byte; BitToClear: integer);
  //인증키값을 비교하자
  Function CompareKey(aSaupId,aKey:string):Boolean;
  Function CompareKey2(aSaupId,aKey:string):Boolean;
  Function CompareKey3(aSaupId,aKey:string;aSeq:integer=0):Boolean;
  Function CompareOffLineKey(aSaupId,aKey,aGubun:string):Boolean;
  Function DataConvert1(aMakeValue:Byte;aData:String):String;
  Function DataConvert2(aMakeValue:Byte;aData:String):String;
  Function DateCheck(aDate:string):Boolean;
  function Dec2Bin(Value : LongInt) : string;
  function Dec2Hex(N: LongInt; A: Byte): string;
  function Dec2Hex64(N: int64; A: Byte): string;
  function DecodeCardNo(aCardNo: string;aLength : integer = 8;bHex:Boolean = False): String;
  function DecTime(ATime: TDateTime; Hours, Minutes, Seconds,
    MSecs: Integer): TDateTime;
  procedure Delay(MSecs: Longint);
  function DelChars(const S: string; Chr: Char): string;
  Function DeleteChar(st : String; DelChar : Char) : String;
  function EncodeCardNo(aCardNo: string;bHex : Boolean = False): String;
  function EncodeData(aKey:Byte; aData: String): String;
  procedure ErrorLogSave(aFileName: String;aError:String;ast:string);
  function ExecFileAndWait(const aCmdLine: String; Hidden, doWait: Boolean): Boolean;
  function FileAppend(aFileName,ast:string;aDirCheck:Boolean=True):Boolean;
  function FillCharString(aNo:String;aChar:char; aLength:Integer;bFront:Boolean = False): string;
  function FillSpace(aData:string;aLen:integer;bFront:Boolean = False):string;
  function FillZeroNumber(aNo:Int64; aLength:Integer): string;
  function FillZeroNumber2(aNo:Int64; aLength:Integer): string;
  function FillZeroStrNum(aNo:String; aLength:Integer;bFront:Boolean = True): string;
  Function FindCharCopy(SourceStr : String; Index : integer; aChar:Char) : String;
  function Get_Local_IPAddr : string;
  //인증키를 가져오자
  Function GetAuthKey(aGubun:string) : string;
  Function GetAuthKey1(aGubun:string) : string;
  function GetFixedCardNoCheck(aCardNo:string;bCardFixedUse:Boolean;
         aCardFixedFillChar:string;nCardFixedPosition,nCardFixedLength:integer):string;
  Function GetKeyIniCheck():Boolean;
  Function GetIpFromDomain(aDomain:string):string;
  Function GetOffLineAuthState(aGubun:string) : Boolean;
  function GetMACAddressXe2(LanaNum: Byte; MACAddress: PMACAddress): Byte;
  function GetNodeByText(ATree : TTreeView; AValue:String; AVisible: Boolean): TTreeNode;
  //사업자등록번호를 가져오자
  Function GetSaupId(aGubun:string) : string;
  function GetWeekCode(aDate:string):integer;
  function GetWinHandle(dwProcessID:DWORD):THandle;
  procedure GridtoFile(adbGrid: TDBGrid; aFileName: string);
  function Hex2Ascii(St: String;bConvert:Boolean=False;aConvertDec:integer=30): String;
  procedure Hex2BinFile(aFilName,aHeader,aHexData:string);
  function Hex2Dec(const S: string): Longint;
  function Hex2Dec64(const S: string): int64;
  Function Hex2DecStr(S:String):String;
  function Hex2ViewData(St: String):String;
  function HexToBinary(Hexadecimal: string): string;
  function IncTime(ATime: TDateTime; Hours, Minutes, Seconds,
    MSecs: Integer): TDateTime;
  function IntegerCharUse(aData:string):Boolean;
  function IntToBin(Value: Longint; Digits:Integer): string;
  procedure InverseString(var S:string;Count:Integer);
  function IsBitSetB(const b:byte; BitToCheck:integer):Boolean;
  function IsDate(aDate:string):Boolean;
  function Isdigit(st: string):Boolean;
  function IsHungWindow(Wnd: HWND): Boolean;
  function IsIPTypeCheck(ip: string): Boolean;
  function IsSunday(const D: TDateTime): Boolean;
  procedure LogAdd(aFileName,aData:string);
  procedure LogSave(aFileName,ast:string);
  Function MakeCSData(aData: string):String;
  Function MakeDatetimeStr(aTime: String;aTimeForamt:Boolean=True):String;
  function MakeSum(st:string):Char;
  function MakeXOR(st:string):Char;
  Function MakeWorkTime_Minute(aEndTime,aStartTime:string;aCheck:integer):integer;
  Function MinuteToString(aMinute:integer):string;
  procedure My_RunDosCommand(Command : string;  nShow : Boolean = False; bWait:Boolean = True;bInherited:Boolean = True);
  function MyF_UsingWinNT: Boolean;
  procedure MyProcessMessage;
  function Pchar2Hex(aData:pchar;aLen:integer;bReverse:Boolean = False;bConvert:Boolean=False;aConvertDec:integer=30):string;
  function posCount(SubStr,S:string):integer;
  function PosIndex(SubStr,S:string;nIndex:integer):integer;
  procedure Process32List(Slist: TStringList);
  function ResetLana(LanaNum, ReqSessions, ReqNames: Byte;LanaRes: TNBLanaResources): Byte;
  function RightPos(aDelimiter : Char; S:string):integer;
  procedure SetBitB(var b:byte; BittoSet: integer);
  function SetlengthStr(st : String; aLength : Integer): String;
  Procedure ShellExecute_AndWait(FileName:String;Params:String);
  procedure Snooze(ms: Cardinal);
  function SpecialCharUse(aData:string):Boolean;
  function StringCharUse(aData:string):Boolean;
  Function StringToBin(aData:string):string;
  function StrToBin(const S: string): string;
  procedure TerminateApplication;
  function ToHexStr(st:string):String;
  function ToHexStrNoSpace(st:string):String;
  function  ufFindQuery(sQuery : TQuery; sField, sData : String; iClassify : Integer) : Boolean; OverLoad;
  function  ufFindQuery(sQuery : TQuery; sField1, sField2, sData1, sData2 : String; iClassify1, iClassify2 : Integer) : Boolean; OverLoad;
  function  ufFindQuery(sQuery : TQuery; sField1, sField2, sField3, sData1, sData2, sData3 : String; iClassify1, iClassify2, iClassify3 : Integer) : Boolean; OverLoad;
  Function WonStringFormat(aAmt:string):string;











{MessageBoxTimeout:사용법
procedure TForm1.Button1Click(Sender: TObject) ;
var
  iRet: Integer;
  iFlags: Integer;
begin
  iFlags := MB_OK or MB_SETFOREGROUND or MB_SYSTEMMODAL or MB_ICONINFORMATION;
  MessageBoxTimeout(Application.Handle, 'Test a timeout of 2 seconds.', 'MessageBoxTimeout Test', iFlags, 0, 2000) ;

  iFlags := MB_YESNO or MB_SETFOREGROUND or MB_SYSTEMMODAL or MB_ICONINFORMATION;
  iRet := MessageBoxTimeout(Application.Handle, 'Test a timeout of 5 seconds.', 'MessageBoxTimeout Test', iFlags, 0, 5000) ;
  case iRet of
    IDYES:
      ShowMessage('Yes') ;
    IDNO:
      ShowMessage('No') ;
    MB_TIMEDOUT:
      ShowMessage('TimedOut') ;
  end;
end;
 }

  function MessageBoxTimeOut(hWnd: HWND; lpText: PChar; lpCaption: PChar; uType: UINT; wLanguageId: WORD; dwMilliseconds: DWORD): Integer; stdcall; external user32 name 'MessageBoxTimeoutA';
  function GetMacAddress: string;
  function GetMacFromIP(IP:string):string;
  function numberformat(s: string): string;


Implementation


function CoCreateGuid(var guid: TGUID): HResult; stdcall; far external 'ole32.dll';
function SendARP(Destip,scrip:DWORD;pmacaddr:PDWORD;VAR phyAddrlen:DWORD):DWORD; stdcall; external 'iphlpapi.dll';

function numberformat(s: string): string;
begin
  if s = '' then s := '0'
  else
  begin
    s := formatfloat('###,###,##0',StrToint(StringReplace(s,',','',[rfReplaceAll])));
    result :=s;
  end;
end;


function GetMacFromIP(IP:string):string;
type
  Tinfo = array[0..7] of byte;
var
  dwTargetIP:dword;
  dwMacAddress:array[0..1] of DWORD;
  dwMacLen : DWORD;
  dwResult : DWORD;
  X:Tinfo;
  stemp:string;
  iloop:integer;
begin
  dwTargetIP := Inet_Addr(pchar(ip));
  dwMacLen := 6;
  dwResult := SendARP(dwtargetip,0,@dwmacaddress[0],dwMaclen);
  if dwResult = NO_ERROR then
  begin
    x:= tinfo(dwMacAddress);
    for iloop :=0 to 5 do
    begin
      stemp := stemp + inttohex(x[iloop],2);
    end;
    result := stemp;
  end;
end;

function GetMACAddress:String;
var
UuidCreateFunc : function (var guid: TGUID):HResult;stdcall;
handle : THandle;
g:TGUID;
WinVer:_OSVersionInfoA;
i:integer;
begin
WinVer.dwOSVersionInfoSize := sizeof(WinVer);
getversionex(WinVer);

handle := LoadLibrary('RPCRT4.DLL');
if WinVer.dwMajorVersion >= 5 then {Windows 2000 }
@UuidCreateFunc := GetProcAddress(Handle, 'UuidCreateSequential')
else
@UuidCreateFunc := GetProcAddress(Handle, 'UuidCreate') ;

UuidCreateFunc(g);
result:='';
for i:=2 to 7 do
result:=result+IntToHex(g.d4[i],2);
end;

{function GetMacAddress: string;
var
g: TGUID;
i: Byte;
begin
Result := '';
CoCreateGUID(g);
for i := 2 to 7 do
Result := Result + IntToHex(g.D4[i], 2);
end;  }

function BinaryToHex(Binary:string):string;
  function Bit2Dec(aBit:string):integer;
  begin
    result := 0;
    if Length(aBit) <> 4 then Exit;
    result := strtoint(aBit[1]) * 8 +
              strtoint(aBit[2]) * 4 +
              strtoint(aBit[3]) * 2 +
              strtoint(aBit[4]) * 1;
  end;
var
  nReminder : integer;
  i : integer;
  nDiv : integer;
  nDec : integer;
begin
  result := '';
  nReminder := length(Binary) mod 4;
  if nReminder <> 0 then
  begin
    for i := nReminder to 3 do
    begin
      Binary := '0' + Binary;
    end;
  end;
  nDiv := length(Binary) div 4;
  if length(Binary) = 0 then Exit;
  for i := 1 to nDiv do
  begin
    nDec := Bit2Dec(copy(Binary,(i - 1) * 4 + 1,4));
    result := result + Dec2Hex(nDec,1);
  end;
end;

procedure Hex2BinFile(aFilName,aHeader,aHexData:string);
 var
 Texta, Buffer : PChar;
 CHKready:Tfilestream;
 before:String;
 i: integer;
begin
  CHKReady:=Tfilestream.Create(aFilName,fmCreate ,fmShareDenyWrite );
  try
    CHKReady.Write(aHeader[1], Length(aHeader));
    before:=aHexData;
    Texta := PChar(before);
    GetMem(Buffer, 2);
    for i:= 0 to length(aHexData) div 2 - 1 do begin
      FillChar(Buffer^, 2, #0);
      HexToBin(Pchar(before) +(i*2), Buffer, 2);
      //Delete(before,1,2);
      //before := before + 2;
      Application.ProcessMessages;
      CHKReady.WriteBuffer(buffer^,sizeof(buffer^));
    end;
  finally
    FreeMem(Buffer, 2);
    chkready.Free;
  end;
end;

function HexToBinary(Hexadecimal: string): string;
const 
  BCD: array [0..15] of string = 
    ('0000', '0001', '0010', '0011', '0100', '0101', '0110', '0111', 
    '1000', '1001', '1010', '1011', '1100', '1101', '1110', '1111'); 
var 
  i: integer; 
begin
  result := '';
  Try
    for i := Length(Hexadecimal) downto 1 do
      Result := BCD[StrToInt('$' + Hexadecimal[i])] + Result;
  Except
    Exit;
  End;
end;

function posCount(SubStr,S:string):integer;
var
  nCount : integer;
  stTemp : string;
  nPosition : integer;
begin
  nCount := 0;
  stTemp := S;
  nPosition := pos(substr,stTemp);
  while Not(nPosition = 0) do
  begin
    inc(nCount);
    stTemp := copy(stTemp,nPosition + 1 ,Length(stTemp) - nPosition);
    nPosition := pos(substr,stTemp);
  end;
  result := nCount;
end;

function PosIndex(SubStr,S:string;nIndex:integer):integer;
var
  nPosition : integer;
  stTemp : string;
  i : integer;
  nTemp : integer;
begin
  nPosition := 0;
  stTemp := S;
  nTemp := pos(substr,stTemp);
  for i := 1 to nIndex do
  begin
    nPosition := nPosition + nTemp;
    stTemp := copy(stTemp,nTemp + 1 ,Length(stTemp) - nTemp);
    nTemp := pos(substr,stTemp);
  end;
  result := nPosition;
end;

function Pchar2Hex(aData:pchar;aLen:integer;bReverse:Boolean = False;bConvert:Boolean=False;aConvertDec:integer=30):string;
var
  i : integer;
  stHex : string;
  nOrd : integer;
begin
  stHex := '';
  for i:= 0 to aLen - 1 do
  begin
    nOrd := Ord(aData[i]);
    if bConvert then
    begin
      if nOrd = aConvertDec then nOrd := 0;
    end;
    if Not bReverse then stHex := stHex + Dec2Hex(nOrd,2)
    else stHex := Dec2Hex(nOrd,2) + stHex;
  end;
  result := stHex;
end;

function char2Hex(aData:char):string;
var
  i : integer;
  stHex : string;
  nOrd : integer;
begin
  stHex := '';
  nOrd := Ord(aData);
  stHex := Dec2Hex(nOrd,2);
  result := stHex;
end;

function Ascii2Hex(aData:string;bReverse:Boolean = False;bConvert:Boolean=False;aConvertDec:integer=30;aStart:string='';aEnd:string=''):string;
var
  i : integer;
  stHex : string;
  nOrd : integer;
begin
  stHex := '';
  for i:= 1 to Length(aData) do
  begin
    nOrd := Ord(aData[i]);
    if bConvert then
    begin
      if nOrd = aConvertDec then nOrd := 0;
    end;
    if Not bReverse then stHex := stHex + aStart + Dec2Hex(nOrd,2) + aEnd
    else stHex := aStart+ Dec2Hex(nOrd,2) + aEnd + stHex;
  end;
  result := stHex;
end;

function AsciiLen2Hex(aData:string;aLen:integer;bReverse:Boolean = False):string;
var
  i : integer;
  stHex : string;
  nOrd : integer;
begin
  stHex := '';
  for i:= 1 to aLen do
  begin
    nOrd := Ord(aData[i]);
    if Not bReverse then stHex := stHex + Dec2Hex(nOrd,2)
    else stHex := Dec2Hex(nOrd,2) + stHex;
  end;
  result := stHex;
end;

Function MinuteToString(aMinute:integer):string;
var
  nDD : integer;
  nHH : integer;
  nMM : integer;
begin
  result := '';
  Try
    nHH := aMinute div 60;
    nMM := aMinute mod 60; //분...
    if nHH = 0 then
    begin
      result := inttostr(nMM) + '분';
      Exit;
    end;
    nDD := nHH div 60;
    nHH := nHH mod 60; //시간
    if nDD = 0 then
    begin
      result := inttostr(nHH) + '시간 ' + inttostr(nMM) + '분';
      Exit;
    end;
    result := inttostr(nDD) + '일 ' +inttostr(nHH) + '시간 ' + inttostr(nMM) + '분';
  Except
    Exit;
  End;

end;

Function WonStringFormat(aAmt:string):string;
begin
  result := '0';
  Try
    if aAmt = '' then
      aAmt := '0'
    else begin
      aAmt := formatfloat('###,###,##0',StrToint(StringReplace(aAmt,',','',[rfReplaceAll])));
    end;
    result :=aAmt;
  Except
    Exit;
  End;
end;


function IsSunday(const D: TDateTime): Boolean;
begin
  Result := DayOfWeek(D) = 1;
end;

function GetWeekCode(aDate:string):integer;
var
  dtPresent: TDateTime;
  wYear    : word;
  wMonth   : word;
  wDay     : word;
begin
  Result := -1;
  Try
    wYear  := StrtoInt(Copy(aDate,1,4));
    wMonth := StrtoInt(Copy(aDate,5,2));
    wDay   := StrtoInt(Copy(aDate,7,2));
    dtPresent:= EncodeDatetime(wYear, wMonth, wDay, 00, 00, 00,00);

    Result := DayOfWeek(dtPresent);
  Except
    Exit;
  End;
end;

function GetWinHandle(dwProcessID:DWORD):THandle;
var
  hWnd: THandle;
  dwProcessID2: DWORD;
  //sCaption : string;
begin
  hWnd := FindWindow(nil, nil); // 최상위 윈도우 핸들 찾기
  Result := 0;
  while( hWnd <> 0 ) do
  begin
    if( 0 = GetParent(hWnd)) then // 최상위 핸들인지 체크, 버튼 등도 핸들을 가질 수 있으므로 무시하기 위해
    begin
      GetWindowThreadProcessId( hWnd, @dwProcessID2 );
      if( dwProcessID2 = dwProcessID ) then
      begin
        //sCaption := GetWindowText(hWnd) ;
        Result := hWnd;
        break;
      end;
    end;
    hWnd := GetWindow(hWnd, GW_HWNDNEXT); // 다음 윈도우 핸들 찾기
  end;
end;


procedure InverseString(var S:string;Count:Integer);
var
   TmpStr:string;
   Ctr:Integer;
   Ch:Char;
begin
   TmpStr:=Copy(S,1,Count);
   Ctr:=0;
   while Count>0 do begin
      Ch:=TmpStr[Count];
      Dec(Count);
      Move(Ch,S[Ctr+1],1);
      Inc(Ctr);
   end;
end;


procedure TerminateApplication;
begin
  with Application do begin
    ShowMainForm := False;
    if Handle <> 0 then ShowOwnedPopups(Handle, False);
    Terminate;
  end;
  CallTerminateProcs;
  Halt(10);
end;


{
 내용설명 : DB-Grid의 해당 내용으로 포커스를 이동한다.
          : 찾을 데이터의 필드명과 값은 주로 PK가 온다.(PK가 1개일 경우)
 파라메터 : sQuery : DataSource와 연결되어 있는 쿼리
            sField : 찾을 필드명
            sData : 찾을 데이터 값(Value)
            iClassify : 필드타입(1:문자, 2:숫자)
 사용예제 : ufFindQuery(qryList, 'Bank_CD', edtBank_CD.Text, 1)
 리 턴 값 : True/False

}
function ufFindQuery(sQuery : TQuery; sField, sData : String; iClassify : Integer) : Boolean; OverLoad;
begin
  with sQuery do
  begin
    case iClassify of
      1 : Filter := sField + ' = ' + #39 + sData + #39;
      2 : Filter := sField + ' = ' + sData;
    end;
    if FindFirst then Result := TRUE else Result := FALSE;
  end;
end;



{
 내용설명 : DB-Grid의 해당 내용으로 포커스를 이동한다.                     
          : 찾을 데이터의 필드명과 값은 주로 PK가 온다.(PK가 2개일 경우)
 파라메터 : sQuery : DataSource와 연결되어 있는 쿼리                       
            sField1, sField2 : 찾을 필드명                                 
            sData1, sData2 : 찾을 데이터 값(Value)                         
            iClassify1, iClassify2 : 필드타입(1:문자, 2:숫자)              
 사용예제 : ufFindQuery(qryList, 'Reg_Date', 'Seq', datReg_Date.Text,      
                        vSeq, 1, 2)                                        
 리 턴 값 : True/False                                                     

}
function ufFindQuery(sQuery : TQuery; sField1, sField2, sData1, sData2 : String; iClassify1, iClassify2 : Integer) : Boolean ;OverLoad;
var
  sTempData : String;
begin
  with sQuery do
  begin
    case iClassify1 of
      1 : sTempData := sField1+' = ' + #39 + sData1 + #39 + ' AND ';
      2 : sTempData := sField1+' = ' + sData1 + ' AND ';
    end;
    case iClassify2 of
      1 : sTempData := sTempData+sField2+' = ' + #39 + sData2 + #39;
      2 : sTempData := sTempData+sField2+' = ' + sData2;
    end;
    Filter := sTempData;
    if FindFirst then Result := TRUE else Result := FALSE;
  end;
end;


{

 내용설명 : DB-Grid의 해당 내용으로 포커스를 이동한다.
          : 찾을 데이터의 필드명과 값은 주로 PK가 온다.(PK가 3개일 경우)
 파라메터 : sQuery : DataSource와 연결되어 있는 쿼리
            sField1, sField2, sField3 : 찾을 필드명
            sData1, sData2, sData3 : 찾을 데이터 값(Value)
            iClassify1, iClassify2, iClassify3 : 필드타입(1:문자, 2:숫자)
 사용예제 : ufFindQuery(qryList, 'Reg_Date', 'Seq', 'Kind',
                        datReg_Date.Text, vSeq, cmbKind.Text, 1, 2, 1)
 리 턴 값 : True/False

}
function ufFindQuery(sQuery : TQuery; sField1, sField2, sField3, sData1, sData2, sData3 : String; iClassify1, iClassify2, iClassify3 : Integer) : Boolean; OverLoad;
var
  sTempData : String;
begin
  with sQuery do
  begin
    case iClassify1 of
      1 : sTempData := sField1+' = ' + #39 + sData1 + #39 + ' AND ';
      2 : sTempData := sField1+' = ' + sData1 + ' AND ';
    end;
    case iClassify2 of
      1 : sTempData := sTempData+sField2 + ' = ' + #39 + sData2 + #39 + ' AND ';
      2 : sTempData := sTempData+sField2 + ' = ' + sData2 + ' AND ';
    end;
    case iClassify3 of
      1 : sTempData := sTempData+sField3+' = ' + #39 + sData3 + #39;
      2 : sTempData := sTempData+sField3+' = ' + sData3;
    end;
    Filter := sTempData;
    if FindFirst then Result := TRUE else Result := FALSE;
  end;
end;

 
  

   



function IsHungWindow(Wnd: HWND): Boolean;
var
 IsHungAppWindow: TIsHungAppWindow;
 IsHungThread: TIsHungThread;
 DllHandle: THandle;
 ThreadID: DWORD;
begin
 Result := False;
 DllHandle := LoadLibrary('user32.dll');
 if DllHandle <> 0 then
 begin
   try
     // 윈도우 NT 계열
     if (Win32Platform = VER_PLATFORM_WIN32_NT) then
     begin
       @IsHungAppWindow := GetProcAddress(DLLHandle, 'IsHungAppWindow');
       if Addr(IsHungAppWindow) <> nil then
         Result := IsHungAppWindow(Wnd);
     end
     // 윈도우 9x 계열
     else begin
       @IsHungThread := GetProcAddress(DLLHandle, 'IsHungThread');
       if Addr(IsHungThread) <> nil then
       begin
         GetWindowThreadProcessId(Wnd, @ThreadID);
         Result := IsHungThread(ThreadID);
       end;
     end;
   finally
     FreeLibrary(DllHandle);
   end;
 end;
end;

function IsIPTypeCheck(ip: string): Boolean;
var
   z, i: byte;
   st: array[1..3] of byte;
const
   ziff = ['0'..'9'];
begin
   st[1]  := 0;
   st[2]  := 0;
   st[3]  := 0;
   z      := 0;
   Result := False;
   for i := 1 to Length(ip) do
   if ip[i] in ziff then
   else
   begin
     if ip[i] = '.' then
     begin
       Inc(z);
       if z < 4 then st[z] := i
       else
       begin
         Exit;
       end;
     end
     else
     begin
       Exit;
     end;
   end;
   if (z <> 3) or (st[1] < 2) or (st[3] = Length(ip)) or (st[1] + 2 > st[2]) or
     (st[2] + 2 > st[3]) or (st[1] > 4) or (st[2] > st[1] + 4) or (st[3] > st[2] + 4) then
   begin
     Exit;
   end;
   z := StrToInt(Copy(ip, 1, st[1] - 1));
   if (z > 255) or (ip[1] = '0') then
   begin
     Exit;
   end;
   z := StrToInt(Copy(ip, st[1] + 1, st[2] - st[1] - 1));
   if (z > 255) or ((z <> 0) and (ip[st[1] + 1] = '0')) then
   begin
     Exit;
   end;
   z := StrToInt(Copy(ip, st[2] + 1, st[3] - st[2] - 1));
   if (z > 255) or ((z <> 0) and (ip[st[2] + 1] = '0')) then
   begin
     Exit;
   end;
   z := StrToInt(Copy(ip, st[3] + 1, Length(ip) - st[3]));
   if (z > 255) or ((z <> 0) and (ip[st[3] + 1] = '0')) then
   begin
     Exit;
   end;
   result := True;
end;

function ExecFileAndWait(const aCmdLine: String; Hidden, doWait: Boolean): Boolean;
var
StartupInfo : TStartupInfo;
ProcessInfo : TProcessInformation;
begin
{setup the startup information for the application }
  FillChar(StartupInfo, SizeOf(TStartupInfo), 0);
  with StartupInfo do
  begin
    cb:= SizeOf(TStartupInfo);
    dwFlags:= STARTF_USESHOWWINDOW or STARTF_FORCEONFEEDBACK;
    if Hidden
    then wShowWindow:= SW_HIDE
    else wShowWindow:= SW_SHOWNORMAL;
  end;

  Result := CreateProcess(nil,PChar(aCmdLine), nil, nil, False,
  NORMAL_PRIORITY_CLASS, nil, nil, StartupInfo, ProcessInfo);
  if doWait then
  if Result then
  begin
  WaitForInputIdle(ProcessInfo.hProcess, INFINITE);
  WaitForSingleObject(ProcessInfo.hProcess, INFINITE);
  end;
end;

Procedure ShellExecute_AndWait(FileName:String;Params:String);
var
  exInfo : TShellExecuteInfo;
  Ph     : DWORD;
  errmsg  : String;
begin
 FillChar( exInfo, Sizeof(exInfo), 0 );
 with exInfo do
 begin
   cbSize:= Sizeof( exInfo );
   fMask := SEE_MASK_NOCLOSEPROCESS or SEE_MASK_FLAG_DDEWAIT;
   Wnd := GetActiveWindow();
   ExInfo.lpVerb := 'open';
   ExInfo.lpParameters := PChar(Params);
   lpFile:= PChar(FileName);
   nShow := SW_SHOWNORMAL;
 end;
 if ShellExecuteEx(@exInfo) then
 begin
   Ph := exInfo.HProcess;
 end
 else
 begin
   errmsg:= SysErrorMessage(GetLastError);
   Application.MessageBox (PChar(errmsg),PChar('error'),MB_ICONSTOP or MB_OK);
   exit;
 end;

 while WaitForSingleObject(ExInfo.hProcess, 50) <> WAIT_OBJECT_0 do
 Application.ProcessMessages;
 CloseHandle(Ph);
end;

procedure Snooze(ms: Cardinal);
var
  Stop: Cardinal;
begin
  SetTimer(Application.Handle, 1235, ms, nil);
  Stop := GetTickCount + ms;
  repeat
    Application.HandleMessage;
  until Application.Terminated or (Integer(GetTickCount - Stop) >= 0);
  KillTimer(Application.Handle, 1235);
end;

function GetNodeByText(ATree : TTreeView; AValue:String; AVisible: Boolean): TTreeNode;
var
    Node: TTreeNode;
begin

  Result := nil;
  if ATree.Items.Count = 0 then Exit;
  Node := ATree.Items[0];
  while Node <> nil do
  begin
    if UpperCase(Node.Text) = UpperCase(AValue) then
    begin
      Result := Node;
      if AVisible then
        Result.MakeVisible;
      Break;
    end;
    Node := Node.GetNext;
  end;
end;

function DecodeCardNo(aCardNo: string;aLength : integer = 8;bHex:Boolean = False): String;
var
  I: Integer;
  st: string;
  bCardNo: int64;
begin

  for I := 1 to aLength do
  begin

    if (I mod 2) <> 0 then
    begin
      aCardNo[I] := Char((Ord(aCardNo[I]) shl 4));
    end else
    begin
      aCardNo[I] := Char(Ord(aCardNo[I]) - $30); //상위니블을 0으로 만든다.
      //st:= st + char(ord(aCardNo[I-1]) +ord(aCardNo[I]));
      st:= st + char(ord(aCardNo[I-1]) + ord(aCardNo[I]))
    end;
    //aCardNo[I] := Char(Ord(aCardNo[I]) - $30);
    //st := st + aCardNo[I];
  end;


  st:= tohexstrNospace(st);


  if Not bHex then  //숫자 변환이면
  begin
    bCardNo:= Hex2Dec64(st);
    st:= FillZeroNumber2(bCardNo,10);
  end;
  //SHowMessage(st);
  Result:= st;

end;

function EncodeCardNo(aCardNo: string;bHex : Boolean = False): String;
var
  I: Integer;
  xCardNo: String;
  st: String;
begin
  result := '';
  Try
    if Not bHex then aCardNo:= Dec2Hex64(StrtoInt64(aCardNo),8);
    xCardNo:= Hex2Ascii(aCardNo);
    for I:= 1 to 4 do
    begin
      st := st + Char((Ord(xCardNo[I]) shr 4) + $30) + Char((Ord(xCardNo[I]) and $F) + $30);
    end;
    Result:= st;
  Except
    Exit;
  End;
end;

function ActivateScreenSaver( Activate : Boolean ) : Boolean;
var
  IntActive : Byte;
begin
  if Activate then
     IntActive := 1
  else
     IntActive := 0;

  Result := SystemParametersInfo( SPI_SETSCREENSAVEACTIVE, IntActive, nil, 0 );
end;


function DelChars(const S: string; Chr: Char): string;
var
  I: Integer;
begin
  Result := S;
  for I := Length(Result) downto 1 do begin
    if Result[I] = Chr then Delete(Result, I, 1);
  end;
end;

{DBGrid를 CSV화일로 저장}
procedure GridtoFile(adbGrid: TDBGrid; aFileName: string);
var
  st: string;
  st2:string;
  CurMark: TBookmark;
  CurColumn: Integer;
  aStringList: Tstringlist;
begin

  aStringList := TStringList.Create;
  aStringList.Clear;
  //그리드 내용 저장

  with aDBGrid.Columns do
  begin
    for CurColumn := 0 to Count - 1 do
    begin
      if (CurColumn > 0) then st := st + ', ';
      st := st + aDBGrid.Columns.Items[CurColumn].Title.Caption;
    end;
    aStringList.Add(st);
  end;
  //Title 저장
  with aDBGrid.DataSource.Dataset do
  begin
    DisableControls;
    CurMark := GetBookmark; {현재 레코드 포인터 저장}
    First;
    while not eof do
    begin
      st := '';
      for CurColumn := 0 to aDBGrid.Columns.Count - 1 do
      begin
        if (CurColumn > 0) then st := st + ', ';
        st2:=aDBGrid.Columns[CurColumn].Field.Text;
        st2:= DelChars(st2,',');
        st := st +st2 ; {필드값}
      end;
      aStringList.Add(st);
      Next;
    end;
    GotoBookmark(CurMark);
    EnableControls;
  end;

  aStringList.SaveToFile(aFileName);
  aStringList.Free;

end;
{
procedure Delay(MSecs: Longint);
var
  FirstTickCount, Now: Longint;
begin
  FirstTickCount := GetTickCount;
  repeat
    sleep(1);
    //Application.ProcessMessages;
    MyProcessMessage;
    { allowing access to other controls, etc. }

{    Now := GetTickCount;
  until (Now - FirstTickCount >= MSecs) or (Now < FirstTickCount);
end; }

procedure Delay(MSecs: Longint);
{by Hagen Reddmann}
var
  Tick: DWORD;
  Event: THandle;
begin
  Event := CreateEvent(nil, False, False, nil);
  try
    Tick := GetTickCount + DWORD(MSecs);
    while (MSecs > 0) and
      (MsgWaitForMultipleObjects(1, Event, False, MSecs,
      QS_ALLINPUT) <> WAIT_TIMEOUT) do
    begin
      sleep(1);
      MyProcessMessage;
      //Application.ProcessMessages;
      Try
        MSecs := Tick - GetTickCount;
      Except
        Exit;
      End;
    end;
  finally
    CloseHandle(Event);
  end;
end;

//Delay 에서 Application.ProcessMessages; 문제가 발생하여 생성하여 씀
procedure MyProcessMessage;
var
  Msg: TMsg;
begin
  if PeekMessage(Msg, 0, 0, 0, PM_REMOVE) then
  begin
    if Msg.Message = WM_QUIT then
    begin
      PostQuitMessage(0);
    end else
    begin
      TranslateMessage(Msg);
      DispatchMessage(Msg);
    end;
  end;
end;

Function DeleteChar(st : String; DelChar : Char) : String;
begin
  While POS(DelChar,st) <> 0 do
    st := Copy(st,1,POS(DelChar,st)-1) + Copy(st,POS(DelChar,st)+1,255);
  Result := st;
end;

procedure LogAdd(aFileName,aData:string);
Var
  f: TextFile;
  st: string;
  stDir : string;
begin
  {$I-}
  stDir := ExtractFilePath(aFileName);
  if not DirectoryExists(stDir) then CreateDir(stDir);

  AssignFile(f, aFileName);
  Append(f);
  if IOResult <> 0 then Rewrite(f);
  WriteLn(f,aData);
  System.Close(f);
  {$I+}
end;

procedure LogSave(aFileName,ast:string);
Var
  f: TextFile;
  st: string;
  stDir : string;
begin
  {$I-}
  stDir := ExtractFilePath(aFileName);
  if not DirectoryExists(stDir) then CreateDir(stDir);

  AssignFile(f, aFileName);
  Append(f);
  if IOResult <> 0 then Rewrite(f);
  st := FormatDateTIme('yyyy-mm-dd hh:nn:ss:zzz">"',Now) + ' ' + ast;
  WriteLn(f,st);
  System.Close(f);
  {$I+}
end;

Function FileAppend(aFileName,ast:string;aDirCheck:Boolean=True):Boolean;
Var
  f: TextFile;
  st: string;
  stDir : string;
begin
  {$I-}
  result := False;
  if aDirCheck then
  begin
    stDir := ExtractFilePath(aFileName);
    if not DirectoryExists(stDir) then CreateDir(stDir);
  end;

  AssignFile(f, aFileName);
  Append(f);
  if IOResult <> 0 then Rewrite(f);
  st := ast;
  WriteLn(f,st);
  System.Close(f);
  result := True;
  {$I+}
end;

Function MakeDatetimeStr(aTime: String;aTimeForamt:Boolean=True):String;
var
  stResult : string;
begin
  if Length(aTime) < 8 then stResult := aTime
  else
  begin
    stResult:= Copy(aTime,1,4)+'-'+Copy(aTime,5,2)+'-'+Copy(aTime,7,2) ;
    if aTimeForamt then
    begin
      if Length(aTime) = 14 then
         stResult:= stResult + ' ' + Copy(aTime,9,2)+':'+Copy(aTime,11,2)+':'+Copy(aTime,13,2);
    end;
  end;
  Result := stResult;
end;

procedure ErrorLogSave(aFileName: String;aError:String;ast:string);
Var
  f: TextFile;
  st: string;
  stDir : string;
begin
  {$I-}
  stDir := ExtractFilePath(aFileName);
  if not DirectoryExists(stDir) then CreateDir(stDir);
//  aFileName:= 'c:\lomos\log\log'+ FormatDateTIme('yyyymmdd',Now)+'.log';
  AssignFile(f, aFileName);
  Append(f);
  if IOResult <> 0 then Rewrite(f);
  st := FormatDateTIme('hh:nn:ss:zzz">"',Now) + '['+aError+']' + ast;
  WriteLn(f,st);
  System.Close(f);
  {$I+}
end;

procedure CDLogSave(aFileName: String;ast:string);
Var
  f: TextFile;
  st: string;
//  aFileName: String;
  stDir : string;
begin
  {$I-}
  stDir := ExtractFilePath(aFileName);
  if not DirectoryExists(stDir) then CreateDir(stDir);
  //aFileName:= 'c:\lomos\log\CDlog'+ FormatDateTIme('yyyymmdd',Now)+'.log';
  AssignFile(f, aFileName);
  Append(f);
  if IOResult <> 0 then Rewrite(f);
  st := FormatDateTIme('hh:nn:ss:zzz">"',Now) + ' ' + ast;
  WriteLn(f,st);
  System.Close(f);
  {$I+}
end;


Function FindCharCopy(SourceStr : String; Index : integer; aChar:Char) : String;
Var
  a, b : Integer;
  st   : String;
begin
  a := 0;
  b := 1;
  st := '';
  if (Length(SourceStr) < 1) then begin result:= ''; exit;  end;
  for b:=1 to Length(SourceStr) do
  begin
    if a = index then break;
    if SourceStr[b] = aChar then Inc(a);
  end;
  if (a = Index) then
  begin
    while (b <= Length(SourceStr)) and (SourceStr[b] <> aChar) do
    begin
      st := st + SourceStr[b];
      Inc(b);
    end;
  end;
  Result := st;
end;

function IntegerCharUse(aData:string):Boolean;
var
  i : integer;
  nLen : integer;
begin
  result := False;
  nLen := Length(aData);
  if nLen = 0 then Exit;
  for i := 1 to nLen do
  begin
    if (ord(aData[i]) >= 48) and (ord(aData[i]) <= 57) then
    begin
      result := True;
      break;
    end;
  end;
end;

function IntToBin(Value: Longint; Digits:Integer): string;
begin
  Result := '';
  Try
    if Digits > 32 then Digits := 32;
    while Digits > 0 do begin
      Dec(Digits);
      Result := Result + IntToStr((Value shr Digits) and 1);
    end;
  Except
    Exit;
  End;
end;

function FillZeroStrNum(aNo:String; aLength:Integer;bFront:Boolean = True): string;
var
  I       : Integer;
  st      : string;
  strNo   : String;
  StrCount: Integer;
begin
  Strno:= aNo;
  StrCount:= Length(Strno);
  St:= '';
  StrCount:=  aLength - StrCount;
  if StrCount > 0 then
  begin
    st:='';
    for I:=1 to StrCount do St:=st+'0';
    if bFront then  St:= St + StrNo
    else St:= StrNo + St;
    
    FillZeroStrNum:= st;
  end else FillZeroStrNum:= copy(Strno,1,aLength);
end;

function FillCharString(aNo:String;aChar:char; aLength:Integer;bFront:Boolean = False): string;
var
  I       : Integer;
  st      : string;
  strNo   : String;
  StrCount: Integer;
begin
  Strno:= aNo;
  StrCount:= Length(Strno);
  St:= '';
  StrCount:=  aLength - StrCount;
  if StrCount > 0 then
  begin
    st:='';
    for I:=1 to StrCount do St:=st+ aChar;
    if bFront then  St:= St + StrNo
    else St:= StrNo + St;
    
    FillCharString := st;
  end else FillCharString := copy(Strno,1,aLength);
end;


function FillZeroNumber(aNo:Int64; aLength:Integer): string;
var
  I       : Integer;
  st      : string;
  strNo   : String;
  StrCount: Integer;
begin
  Strno:= InttoStr(aNo);
  StrCount:= Length(Strno);
  St:= '';
  StrCount:=  aLength - StrCount;
  if StrCount > 0 then
  begin
    st:='';
    for I:=1 to StrCount do St:=st+'0';
    St:= St + StrNo;
    FillZeroNumber:= st;
  end else FillZeroNumber:= copy(Strno,1,aLength);
end;

function FillZeroNumber2(aNo:INt64; aLength:Integer): string;
var
  I       : Integer;
  st      : string;
  strNo   : String;
  StrCount: Integer;
begin
  Strno:= InttoStr(aNo);
  StrCount:= Length(Strno);
  St:= '';
  StrCount:=  aLength - StrCount;
  if StrCount > 0 then
  begin
    st:='';
    for I:=1 to StrCount do St:=st+'0';
    St:= St + StrNo;
    FillZeroNumber2:= st;
  end else FillZeroNumber2:= copy(Strno,1,aLength);
end;






function SetlengthStr(st : String; aLength : Integer) : String;
begin
  result := st;
  while Length(Result) < aLength do
    Result := Result + ' ';
  Result := Copy(Result,1,aLength);
end;

function BinToInt(Value : String) : Integer;
var
  i   : Integer;
begin
  Result := 0;
  for i := 1 to Length(Value) do
  begin
    Result := Result shl 1;
    Result := Result + Integer((Value[i] = '1'));
  end;
end;

Function ByteCopy(p:pAnsiChar;n:cardinal):String;
var
  rP:pAnsiChar;
begin
  setLength(result,n);
  rP:=pAnsiChar(result);
  while n <> 0 do
  begin
    rP^:=p^;
    inc(rP);
    inc(p);
    dec(n);
  end;
end;

function Dec2Bin(Value : LongInt) : string;
var  
  i : integer;   
  s : string;   
begin  
  s := '';   
  
  for i := 31 downto 0 do  
    if (Value and (1 shl i)) <> 0 then s := s + '1'  
                                  else s := s + '0';   
  
  Result := s;   
end;   


function Bin2Dec(BinString: string): LongInt;
var  
  i : Integer;   
  Num : LongInt;   
begin  
  Num := 0;   
  
  for i := 1 to Length(BinString) do  
    if BinString[i] = '1' then Num := (Num shl 1) + 1  
                          else Num := (Num shl 1);   
  
  Result := Num;   
end;

function Dec2Hex(N: LongInt; A: Byte): string;
begin
  Result := IntToHex(N, A);
end;

function Dec2Hex64(N: int64; A: Byte): string;
begin
    Result := IntToHex(N, A);
end;

Function Hex2DecStr(S:String):String;
var
  i: longint;
  L: int64;
begin
  Result := '';
  if Length(s) = 0 then Exit;
  L:=0;
  for i := 1 to length(S) do L:=L*16 + pos(S[i],HexString)-1;
  Result:=intToStr(L);
end;


procedure SetBitB(var b:byte; BittoSet: integer);
{ set a bit in a byte }
begin
  if (BittoSet < 0) or (BittoSet > 7) then exit;
  b:= b or ( 1 SHL BittoSet);
end;

procedure ClearBitB(var b:byte; BitToClear: integer);
{ clear a bit in a byte }
begin
  if (BitToClear < 0) or (BitToClear > 7) then exit;
  b := b and not (1 shl BitToClear);
end;

function IsBitSetB(const b:byte; BitToCheck:integer):Boolean;
{ Test bit in a byte }
begin
  Result := false;
  if (BitToCheck < 0) or (BitToCheck > 7) then exit;
  Result := (b and (1 shl BitToCheck)) <> 0;
end;

function MakeSum(st:string):Char;
var
  i: Integer;
  aBcc: Byte;
  BCC: string;
begin
  Result:= #0;
  if st = '' then Exit;
  aBcc := Ord(st[1]);
  for i := 2 to Length(st) do
    aBcc := aBcc + Ord(st[i]);
  BCC := Chr(aBcc);
  Result := BCC[1];
end;


function MakeXOR(st:string):Char;
var
  i: Integer;
  aBcc: Byte;
  BCC: string;
begin
  Result:= #0;
  if st = '' then Exit;
  aBcc := Ord(st[1]);
  for i := 2 to Length(st) do
    aBcc := aBcc XOR Ord(st[i]);
  BCC := Chr(aBcc);
  Result := BCC[1];
end;

Function MakeWorkTime_Minute(aEndTime,aStartTime:string;aCheck:integer):integer;
var
  stHH,stMM : string;
  nHH,nMM : integer;
begin
  result := 0;
  if Trim(aEndTime) = '' then aEndTime := '0000';
  if Trim(aStartTime) = '' then aStartTime := '0000';
  if Length(aEndTime) <> 4 then aEndTime := FillZeroStrNum(Trim(aEndTime),4,False);
  if Length(aStartTime) <> 4 then aStartTime := FillZeroStrNum(Trim(aStartTime),4,False);
  if aCheck = 1 then
  begin
    if aEndTime = '0000' then Exit; //기준시간이 0000 이면 사용 안하는 경우임
  end else if aCheck = 2 then
  begin
    if aStartTime = '0000' then Exit; //기준시간이 0000 이면 사용 안하는 경우임
  end else if aCheck = 3 then
  begin
    if aEndTime = '0000' then Exit; //기준시간이 0000 이면 사용 안하는 경우임
    if aStartTime = '0000' then Exit; //기준시간이 0000 이면 사용 안하는 경우임
  end;

  if strtoint(aEndTime) >= strtoint(aStartTime) then
  begin
    //정상적인 경우
    nHH := strtoint(copy(aEndTime,1,2)) - strtoint(copy(aStartTime,1,2));
    nMM := strtoint(copy(aEndTime,3,2)) - strtoint(copy(aStartTime,3,2));
    result := (nHH * 60) + nMM;
  end else
  begin
    //퇴근시간이 오전이고 출근시간이 전일인경우
    nHH := 24 - strtoint(copy(aStartTime,1,2)) + strtoint(copy(aEndTime,1,2));
    nMM := 0 - strtoint(copy(aStartTime,3,2)) + strtoint(copy(aEndTime,3,2));
    result := (nHH * 60) + nMM;
  end;
end;

{CheckSum을 만든다}
Function MakeCSData(aData: string):String;
var
  aSum: Integer;
  st: string;
begin
  aSum:= Ord(MakeSum(aData));
  aSum:= aSum*(-1);
  st:= Dec2Hex(aSum,2);

  Result:= copy(st,Length(st)-1,2);
end;

{난수 번호만(BIT4,BIT3,BIT2,BIT1,BIT0) 을 data와 XOR 한다.}
Function DataConvert1(aMakeValue:Byte;aData:String):String;
var
  I: Integer;
  bData: String;
begin
  bData:= aData;
  for I:= 1 to Length(bData) do
  begin
    bData[I]:= Char(ord(bData[I]) XOR aMakeValue);
  end;
  Result:= bData;
end;

{ 난수 번호만(BIT4,BIT3,BIT2,BIT1,BIT0) 을 data와 XOR 후 Message No의 하위 Nibble과 다시 XOR 한다.}
Function DataConvert2(aMakeValue:Byte;aData:String):String;
var
  I: Integer;
  bMakeValue: Byte;
  bData: String;
  TempByte: Byte;
begin
  bData:= aData;
  {13번쩨 Byte 가 MessageNo}
  bMakeValue:= Ord(aData[13]) and $F;
  Result:= '';
  for I:= 1 to Length(bData) do
  begin
    if I <> 13 then
    begin
      TempByte:= ord(bData[I]) XOR aMakeValue;
      bData[I]:= Char(TempByte XOR bMakeValue);
    end;
  end;
  Result:= bData;
end;

function EncodeData(aKey:Byte; aData: String): String;
var
  Encodetype: Integer;
  aMakeValue: Byte;
  I: Integer;
begin
  EncodeType:= aKey SHR 6; //7,6 번 Bit가 엔코딩 타입
  aMakeValue:= aKey;
  for I:= 5 to 7 do ClearBitB(aMakeValue,I); //1,2,3,4,5 Bit가 난수번호

  case EncodeType of
    0: Result:= DataConvert1(aMakeValue,aData);
    1: Result:= DataConvert2(aMakeValue,aData);
    else Result:= aData;
  end;
end;


function ToHexStr(st:string):String;
var
  I : Integer;
  st2: string;
  st3: string[3];
begin
  for I:= 1 to length(st) do
  begin
    st3:= Dec2Hex(ord(st[I]),1);
    if Length(st3) < 2 then st3:= '0'+ st3;
    st2:=st2 +st3 +' ';
  end;
  ToHexStr:= st2;
end;

function ToHexStrNoSpace(st:string):String;
var
  I : Integer;
  st2: string;
  st3: string[3];
begin
  for I:= 1 to length(st) do
  begin
    st3:= Dec2Hex(ord(st[I]),1);
    if Length(st3) < 2 then st3:= '0'+ st3;
    st2:=st2 +st3;
  end;
  ToHexStrnospace:= st2;
end;

function Hex2ViewData(St: String):String;
var
  st2: string;
  I: Integer;
  aLength: Integer;
  aa: Integer;
begin
  st2:= '';
  for I:= 1 to Length(st) do
  begin
    if st[i] <> #$20 then st2:= st2 + st[I];
  end;
  if Length(st2) MOD 2 <> 0 then
  begin
    aLength:= Length(st2);
    st:= copy(st2,1,aLength-1) + '0'+ st2[aLength];
  end else
  begin
   st:= st2;
  end;

  st2:= '';
  while st <> '' do
  begin
    if pos(st[1],'34567') = 0 then st2 := st2+'['+copy(st,1,2) + ']'
    else
    begin
      aa:= Hex2Dec(copy(st,1,2));
      st2:= st2 + Char(aa);
    end;
    delete(st,1,2);
  end;
  result := st2;
end;

function Hex2Ascii(St: String;bConvert:Boolean=False;aConvertDec:integer=30): String;
var
  st2: string;
  I: Integer;
  aLength: Integer;
  aa: Integer;
begin
  st2:= '';
  for I:= 1 to Length(st) do
  begin
    if st[i] <> #$20 then st2:= st2 + st[I];
  end;
  if Length(st2) MOD 2 <> 0 then
  begin
    aLength:= Length(st2);
    st:= copy(st2,1,aLength-1) + '0'+ st2[aLength];
  end else
  begin
   st:= st2;
  end;

  st2:= '';
  while st <> '' do
  begin
    aa:= Hex2Dec(copy(st,1,2));
    if bConvert then
    begin
      if aa = 0 then aa := aConvertDec;
    end;
    st2:= st2 + Char(aa);
    delete(st,1,2);
  end;
  Hex2Ascii:= st2;
end;


function Hex2Dec(const S: string): Longint;
var
  HexStr: string;
begin
  result := -1;
  Try
    if Pos('$', S) = 0 then HexStr := '$' + S
    else HexStr := S;
    Result := StrToIntDef(HexStr, 0);
  Except
    Exit;
  End;
end;

function Hex2Dec64(const S: string): int64;
var
  HexStr: string;
begin
  result := -1;
  Try
    if Pos('$', S) = 0 then HexStr := '$' + S
    else HexStr := S;
    Result := StrToInt64Def(HexStr, 0);
  Except
    Exit;
  End;
end;

function Isdigit(st: string):Boolean;
var
  I: Integer;
begin
  result:=True;
  if Length(st) < 1 then
  begin
    result:=False;
    Exit;
  end;
  for I:=1 to Length(st) do
    if (st[I]< '0') or (st[I] > '9')  then result:=False
end;

function GetNibble(aValue: Byte; Var NibbleHi:Byte; Var NibbleLo:Byte):Boolean;
begin
  NibbleHi := aValue shr 4;
  NibbleLo := aValue and $F;
  Result:= True;
end;

function IncTime(ATime: TDateTime; Hours, Minutes, Seconds,
  MSecs: Integer): TDateTime;
begin
  Result := ATime + (Hours div 24) + (((Hours mod 24) * 3600000 +
    Minutes * 60000 + Seconds * 1000 + MSecs) / MSecsPerDay);
  if Result < 0 then Result := Result + 1;
end;

function DecTime(ATime: TDateTime; Hours, Minutes, Seconds,
  MSecs: Integer): TDateTime;
begin
  Result := ATime - (Hours div 24) - (((Hours mod 24) * 3600000 -
    Minutes * 60000 - Seconds * 1000 + MSecs) / MSecsPerDay);
  if Result < 0 then Result := Result + 1;
end;

function Get_Local_IPAddr : string;
 type
   TaPInAddr = array [0..10] of PInAddr;
   PaPInAddr = ^TaPInAddr;
 var
   phe : PHostEnt;
   pptr : PaPInAddr;
   Buffer : array [0..63] of char;
   I : Integer;
   GInitData : TWSADATA;
begin
 try
   WSAStartup($101, GInitData);
   Result := '';
   GetHostName(Buffer, SizeOf(Buffer));
   phe := GetHostByName(buffer);
   if phe = nil then Exit;
   pptr := PaPInAddr(Phe^.h_addr_list);
   i := 0;
   result := '';
   while pptr^[I] <> nil do
   begin
     result:= result + StrPas(inet_ntoa(pptr^[I]^)) + ' ';
     Inc(I);
   end;
 finally WSACleanup; end;
end;


Function DateCheck(aDate:string):Boolean;
var
  CheckDate : TDateTime;
begin

  Result := True;
  try
    CheckDate := StrtoDate(aDate);
    Result := True;
  except
    Result := False;
  end;

end;

function StrToBin(const S: string): string;
const
   BitArray: array[0..15] of string =
       ('0000', '0001', '0010', '0011', 
        '0100', '0101', '0110', '0111',
        '1000', '1001', '1010', '1011', 
        '1100', '1101', '1110', '1111');
var
   Index: Integer;
   LoBits: Byte;
   HiBits: Byte;
begin
   Result := '';
   for Index := 1 to Length(S) do
   begin
       HiBits := (Byte( S[Index]) and $F0) shr 4;
       LoBits := Byte( S[Index]) and $0F;
       Result := Result + BitArray[HiBits];
       Result := Result + BitArray[LoBits];
   end;
end;

function RightPos(aDelimiter : Char; S:string):integer;
var
  nLen:integer;
  nPos : integer;
  i:integer;
begin
  nLen := Length(S);
  nPos := 0;
  for i := nLen downto 0 do
  begin
    if S[i] = aDelimiter then
    begin
      nPos := i;
      Break;
    end;
  end;
  result := nPos;
end;

function FillSpace(aData:string;aLen:integer;bFront:Boolean = False):string;
var
  i:integer;
begin
  if Length(aData)>= aLen then
  begin
    result := copy(aData,1,aLen);
    Exit;
  end;
  for i:= Length(aData) to aLen do
  begin
    if bFront then aData := ' ' + aData
    else  aData := aData + ' ';
  end;
  result := copy(aData,1,aLen);

end;

function IsDate(aDate:string):Boolean;
var
  dtTime : TDateTime;
begin
  result := False;
  Try
    dtTime := strtoDate(aDate);
  Except
    Exit;
  End;
  result := True;
end;

function SpecialCharUse(aData:string):Boolean;
var
  SpecialChar : string;
  i : integer;
  nLen : integer;
begin
  result := False;
  SpecialChar := '`~!@#$%^&*()-_=+|\/?:;.,<>{}[]"'' ';
  nLen := Length(aData);
  if nLen = 0 then Exit;
  for i := 1 to nLen do
  begin
    if Pos(aData[i],SpecialChar) > 0 then
    begin
      result := True;
      break;
    end;
  end;
end;

function StringCharUse(aData:string):Boolean;
var
  i : integer;
  nLen : integer;
begin
  result := False;
  nLen := Length(aData);
  if nLen = 0 then Exit;
  for i := 1 to nLen do
  begin
    if ((ord(aData[i]) >= 65) and (ord(aData[i]) <= 90)) or ((ord(aData[i]) >= 97) and (ord(aData[i]) <= 122)) then
    begin
      result := True;
      break;
    end;
  end;
end;

Function StringToBin(aData:string):string;
var
  i:integer;
  stTemp : string;
begin
  result := '';
  Try
    stTemp := '';
    for i:=1 to Length(aData) do
    begin
      stTemp := stTemp + IntToBin(strtoint(aData[i]),4);
    end;
    result := stTemp;
  Except
    Exit;
  End;
end;

Function BinToHexStr(aData:string):string;
var
  stTemp : string;
  nTemp : integer;
  i : integer;
  stResult : string;
begin
  if (Length(aData) mod 4) <> 0 then Exit;

  stResult := '';
  for i:= 0 to (Length(aData) div 4) -1 do
  begin
    stTemp := copy(aData,(i * 4) + 1,4);
    nTemp := BinToInt(stTemp);
    stResult := stResult + Dec2Hex(nTemp,1);
  end;
  result := stResult;
end;

//인증키를 가져오자
Function GetAuthKey(aGubun:string) : string;
var
  stExeFolder : string;
  ini_fun : TiniFile;
begin
  stExeFolder := ExtractFileDir(Application.ExeName);
  ini_fun := TiniFile.Create(stExeFolder + '\' + 'Key.ini');
  Try
    result := ini_fun.ReadString('사업자정보','인증키' + aGubun,'');
  Finally
    ini_fun.Free;
  End;
end;

//인증키를 가져오자
Function GetAuthKey1(aGubun:string) : string;
var
  stExeFolder : string;
  ini_fun : TiniFile;
begin
  stExeFolder := ExtractFileDir(Application.ExeName);
  ini_fun := TiniFile.Create(stExeFolder + '\' + 'Key1.ini');
  Try
    result := ini_fun.ReadString('사업자정보','인증키' + aGubun,'');
  Finally
    ini_fun.Free;
  End;
end;
//카드 고정길이 사용유무 체크해서 고정길이로 만들어줌
function GetFixedCardNoCheck(aCardNo:string;bCardFixedUse:Boolean;
         aCardFixedFillChar:string;nCardFixedPosition,nCardFixedLength:integer):string;
var
  bFront : Boolean;
begin
  result := aCardNo;
  if Not bCardFixedUse then Exit; //고정길이 사용하지 않으면 원 카드데이터 리턴
  bFront := True;
  if nCardFixedPosition <> 0 then bFront := False;//뒤에 채움문자 채우는 경우
  result := FillCharString(aCardNo,aCardFixedFillChar[1],nCardFixedLength,bFront);
end;

Function GetKeyIniCheck():Boolean;
var
  stExeFolder : string;
  ini_fun : TiniFile;
begin
  result := False;
  stExeFolder := ExtractFileDir(Application.ExeName);
  ini_fun := TiniFile.Create(stExeFolder + '\' + 'Key.ini');
  Try
    if ini_fun.ReadString('KEY','CHECK','TRUE') = 'FALSE' then result := True;
  Finally
    ini_fun.Free;
  End;
end;

Function GetIpFromDomain(aDomain:string):string;
var
  WSAData1: WSADATA;
  HostEnt: PHostEnt;
  pAddr: PChar;
  addr: in_addr;
begin
  Result:='';
 
  // GetHostByName 을 쓰기 위해 WSAStartup 을 한번 해줘야 함
  if WSAStartup(MAKEWORD(2, 2), WSAData1)<>0 then Exit;
 
  // WSAStartup 호출이 제대로 되지 않음을 체크(?)
  if (LOBYTE(WSAData1.wVersion)<>2) or (HIBYTE(WSAData1.wVersion)<>2) then begin
    WSACleanup;
    Exit;
  end;
 
  // HostEnt 로 매개변수로 받아온 도메인이름의 정보를 받아옴
  HostEnt := GetHostByName(pAnsiChar(aDomain));
  if HostEnt=nil then Exit;
 
  // PChar 형 변수로 ip 주소를 옮김
  pAddr := HostEnt^.h_addr_list^;
  if pAddr=nil then Exit;
 
  // 옮긴 ip 주소를 in_addr 로 적절히 변환
  addr.S_un_b.s_b1 := pAddr[0];
  addr.S_un_b.s_b2 := pAddr[1];
  addr.S_un_b.s_b3 := pAddr[2];
  addr.S_un_b.s_b4 := pAddr[3];
 
  // 변환된 ip 주소를 반환
  Result := inet_ntoa(addr);
end;

Function GetOffLineAuthState(aGubun:string) : Boolean;
var
  stExeFolder : string;
  ini_fun : TiniFile;
begin
  result := False;
  stExeFolder := ExtractFileDir(Application.ExeName);
  ini_fun := TiniFile.Create(stExeFolder + '\' + 'Key.ini');
  Try
    if UpperCase(ini_fun.ReadString('KEY','OFFLINE'+aGubun,'FALSE')) = 'TRUE' then result := True;
  Finally
    ini_fun.Free;
  End;
end;

//사업자등록번호를 가져오자
Function GetSaupId(aGubun:string) : string;
var
  stExeFolder : string;
  ini_fun : TiniFile;
begin
  stExeFolder := ExtractFileDir(Application.ExeName);
  ini_fun := TiniFile.Create(stExeFolder + '\' + 'Key.ini');
  result := ini_fun.ReadString('사업자정보','사업자등록번호' + aGubun,'');
end;
//인증키값을 비교하자
Function CompareKey(aSaupId,aKey:string):Boolean;
var
  nSaupID : integer;
  stMac : string;
  nMac : integer;
  stTemp :string;
  i : integer;
  stKey : string;
begin
  result := False;
  nSaupId := 0;
  for i:=1 to Length(aSaupId) do
  begin
    nSaupId := nSaupId + Ord(aSaupId[i]);
  end;
  stMac := UpperCase(GetMacAddress);
  nMac := 0;
  for i:=1 to Length(stMac) do
  begin
    nMac := nMac + Ord(stMac[i]);
  end;
  nSaupId := nSaupId + nMac;
  stTemp := inttostr(nSaupId);
  stTemp := StringToBin(stTemp);
  stTemp := FillZeroStrNum(stTemp,40);
  stTemp := copy(stTemp,21,Length(stTemp)-20) +copy(stTemp,11,10) + copy(stTemp,1,10);
  stTemp := copy(stTemp,16,Length(stTemp)-15) + copy(stTemp,1,15);
  stTemp := copy(stTemp,30,Length(stTemp)-29) +copy(stTemp,16,14) + copy(stTemp,1,15);

  stTemp := BinToHexStr(stTemp);
  stKey := copy(stTemp,1,3) + '-' + copy(stTemp,4,4) + '-' + copy(stTemp,8,3);

  if stKey = aKey then Result := True;
end;
//인증키값을 비교하자
Function CompareKey2(aSaupId,aKey:string):Boolean;
var
  nSaupID : integer;
  stMac : string;
  nMac : integer;
  stTemp :string;
  i : integer;
  stKey : string;
begin
  result := False;
  nSaupId := 0;
  for i:=1 to Length(aSaupId) do
  begin
    nSaupId := nSaupId + Ord(aSaupId[i]);
  end;
  stMac := UpperCase(GetMacFromIP(Get_Local_IPAddr));
  nMac := 0;
  for i:=1 to Length(stMac) do
  begin
    nMac := nMac + Ord(stMac[i]);
  end;
  nSaupId := nSaupId + nMac;
  stTemp := inttostr(nSaupId);
  stTemp := StringToBin(stTemp);
  stTemp := FillZeroStrNum(stTemp,40);
  stTemp := copy(stTemp,21,Length(stTemp)-20) +copy(stTemp,11,10) + copy(stTemp,1,10);
  stTemp := copy(stTemp,16,Length(stTemp)-15) + copy(stTemp,1,15);
  stTemp := copy(stTemp,30,Length(stTemp)-29) +copy(stTemp,16,14) + copy(stTemp,1,15);

  stTemp := BinToHexStr(stTemp);
  stKey := copy(stTemp,1,3) + '-' + copy(stTemp,4,4) + '-' + copy(stTemp,8,3);

  if stKey = aKey then Result := True;
end;
//인증키값을 비교하자
Function CompareKey3(aSaupId,aKey:string;aSeq:integer=0):Boolean;
var
  nSaupID : integer;
  stMac : string;
  nMac : integer;
  stTemp :string;
  i : integer;
  stKey : string;
  MACAddress: PMACAddress;
  RetCode: Byte;
begin
  result := False;
  nSaupId := 0;
  for i:=1 to Length(aSaupId) do
  begin
    nSaupId := nSaupId + Ord(aSaupId[i]);
  end;
  RetCode := ResetLana(0, 0, 0, lrAlloc);

  New(MACAddress);
  try
    RetCode := GetMACAddressXe2(aSeq, MACAddress);
    if RetCode = NRC_GOODRET then
    begin
      stMac := Format('%2.2x%2.2x%2.2x%2.2x%2.2x%2.2x',
        [MACAddress[0], MACAddress[1], MACAddress[2],
         MACAddress[3], MACAddress[4], MACAddress[5]]);
    end else
    begin
      stMac := '';
    end;
  finally
    Dispose(MACAddress);
  end;


  //stMac := UpperCase(GetMacFromIP(GetLocalIPAddr));
  nMac := 0;
  for i:=1 to Length(stMac) do
  begin
    nMac := nMac + Ord(stMac[i]);
  end;
  nSaupId := nSaupId + nMac;
  stTemp := inttostr(nSaupId);
  stTemp := StringToBin(stTemp);
  stTemp := FillZeroStrNum(stTemp,40);
  stTemp := copy(stTemp,21,Length(stTemp)-20) +copy(stTemp,11,10) + copy(stTemp,1,10);
  stTemp := copy(stTemp,16,Length(stTemp)-15) + copy(stTemp,1,15);
  stTemp := copy(stTemp,30,Length(stTemp)-29) +copy(stTemp,16,14) + copy(stTemp,1,15);

  stTemp := BinToHexStr(stTemp);
  stKey := copy(stTemp,1,3) + '-' + copy(stTemp,4,4) + '-' + copy(stTemp,8,3);

  if stKey = aKey then Result := True;
end;

Function CompareOffLineKey(aSaupId,aKey,aGubun:string):Boolean;
var
  stMac : string;
  stTemp :string;
  stKey : string;

  stExeFolder : string;
  ini_fun : TiniFile;
  stOffLine : string;
  stKeyID : string;
  stKeyPassword : string;
  nSaupID : integer;
  nMac : integer;
  i : integer;
begin
  result := False;
  stExeFolder := ExtractFileDir(Application.ExeName);
  Try
    ini_fun := TiniFile.Create(stExeFolder + '\' + 'Key.ini');
    stOffLine := ini_fun.ReadString('KEY','OFFLINE' + aGubun,'FALSE');
    if UpperCase(stOffLine) <> 'TRUE' then Exit; //오프라인 인증이 아니면 인증 실패
    stKeyID := ini_fun.ReadString('Key','ID','');
    stKeyPassword := ini_fun.ReadString('Key','Password','11');
    if stKeyID <> aSaupId then Exit;
    nSaupId := 0;
    for i:=1 to Length(aSaupId) do
    begin
      nSaupId := nSaupId + Ord(aSaupId[i]);
    end;
    nMac := 0;
    for i:=1 to Length(stKeyPassword) do
    begin
      nMac := nMac + Ord(stKeyPassword[i]);
    end;
    nSaupId := nSaupId + nMac;
    stTemp := inttostr(nSaupId);
    stTemp := StringToBin(stTemp);
    stTemp := FillZeroStrNum(stTemp,40);
    stTemp := copy(stTemp,21,Length(stTemp)-20) +copy(stTemp,11,10) + copy(stTemp,1,10);
    stTemp := copy(stTemp,16,Length(stTemp)-15) + copy(stTemp,1,15);
    stTemp := copy(stTemp,30,Length(stTemp)-29) +copy(stTemp,16,14) + copy(stTemp,1,15);

    stTemp := BinToHexStr(stTemp);
    stKey := copy(stTemp,1,3) + '-' + copy(stTemp,4,4) + '-' + copy(stTemp,8,3);
    if stKey = aKey then Result := True;
  Finally
    ini_fun.Free;
  End;
end;

procedure Process32List(Slist: TStringList);
var
  Process32: TProcessEntry32;
  SHandle: THandle; // the handle of the Windows object
  Next: BOOL;
begin
  Process32.dwSize := SizeOf(TProcessEntry32);
  SHandle := CreateToolHelp32Snapshot(TH32CS_SNAPPROCESS, 0);

  if Process32First(SHandle, Process32) then
  begin
    // 실행화일명과 process object 저장
    Slist.AddObject(Process32.szExeFile, TObject(Process32.th32ProcessID));
    repeat
      Next := Process32Next(SHandle, Process32);
      if Next then
        Slist.AddObject(Process32.szExeFile, TObject(Process32.th32ProcessID));
    until not Next;
  end;
  CloseHandle(SHandle); // closes an open object handle
end;

function ResetLana(LanaNum, ReqSessions, ReqNames: Byte;
  LanaRes: TNBLanaResources): Byte;
var
  ResetNCB: PNCB;
begin
  New(ResetNCB);
  ZeroMemory(ResetNCB, SizeOf(TNCB));
  try
    with ResetNCB^ do
    begin
      ncb_lana_num := Ansichar(LanaNum);        // Set Lana_Num
      ncb_lsn := Ansichar(LanaRes);             // Allocation of new resources
      ncb_callname[0] := Ansichar(ReqSessions); // Query of max sessions
      ncb_callname[1] := #0;                // Query of max NCBs (default)
      ncb_callname[2] := Ansichar(ReqNames);    // Query of max names
      ncb_callname[3] := #0;                // Query of use NAME_NUMBER_1
      ncb_command  := Ansichar(NCBRESET);
      NetBios(ResetNCB);
      Result := Byte(ncb_cmd_cplt);
    end;
  finally
    Dispose(ResetNCB);
  end;
end;

function GetMACAddressXe2(LanaNum: Byte; MACAddress: PMACAddress): Byte;
var
  AdapterStatus: PAdapterStatus;
  StatNCB: PNCB;
begin
  New(StatNCB);
  ZeroMemory(StatNCB, SizeOf(TNCB));
  StatNCB.ncb_length := SizeOf(TAdapterStatus) +  255 * SizeOf(TNameBuffer);
  GetMem(AdapterStatus, StatNCB.ncb_length);
  try
    with StatNCB^ do
    begin
      ZeroMemory(MACAddress, SizeOf(TMACAddress));
      ncb_buffer := PAnsiChar(AdapterStatus);
      ncb_callname := '*              ' + #0;
      ncb_lana_num := AnsiChar(LanaNum);
      ncb_command  := AnsiChar(NCBASTAT);
      NetBios(StatNCB);
      Result := Byte(ncb_cmd_cplt);
      if Result = NRC_GOODRET then
        MoveMemory(MACAddress, AdapterStatus, SizeOf(TMACAddress));
    end;
  finally
    FreeMem(AdapterStatus);
    Dispose(StatNCB);
  end;
end;




// 도스 명령 실행 함수/프로시져

function MyF_UsingWinNT: Boolean;
var
  OS: TOSVersionInfo; 
begin 
  OS.dwOSVersionInfoSize := Sizeof(OS); 
  GetVersionEx(OS);
  if OS.dwPlatformId = VER_PLATFORM_WIN32_NT then Result:= True 
  else Result:= False; 
end; 


// 도스 명령 실행 프로시져 
procedure My_RunDosCommand(Command : string;  nShow : Boolean = False; bWait:Boolean = True;bInherited:Boolean = True);
var 
  hReadPipe : THandle; 
  hWritePipe : THandle; 
  SI : TStartUpInfo; 
  PI : TProcessInformation; 
  SA : TSecurityAttributes; 
  SD : TSecurityDescriptor;
  BytesRead : DWORD; 
  Dest : array[0..1023] of char; 
  CmdLine : array[0..512] of char;
  TmpList : TStringList; 
  S, Param : string; 
  Avail, ExitCode, wrResult : DWORD; 
begin
  if MyF_UsingWinNT then begin
    InitializeSecurityDescriptor(@SD, SECURITY_DESCRIPTOR_REVISION); 
    SetSecurityDescriptorDacl(@SD, True, nil, False); 
    SA.nLength := SizeOf(SA); 
    SA.lpSecurityDescriptor := @SD; 
    SA.bInheritHandle := True; 
    Createpipe(hReadPipe, hWritePipe, @SA, 1024); 
  end else begin 
    Createpipe(hReadPipe, hWritePipe, nil, 1024); 
  end; 
  try
     //Screen.Cursor := crHourglass; 
     FillChar(SI, SizeOf(SI), 0); 
     SI.cb := SizeOf(TStartUpInfo); 
     if nShow then begin 
       SI.wShowWindow := SW_SHOWNORMAL 
     end else begin 
       SI.wShowWindow := SW_HIDE; 
     end;
     SI.dwFlags := STARTF_USESHOWWINDOW;
     SI.dwFlags := SI.dwFlags or STARTF_USESTDHANDLES; 
     SI.hStdOutput := hWritePipe; 
     SI.hStdError := hWritePipe; 
     StrPCopy(CmdLine, Command); 
     //if CreateProcess(nil,CmdLine , nil, nil, True, NORMAL_PRIORITY_CLASS, nil, nil, SI, PI) then begin
     //if CreateProcess(nil,pchar(Command) , nil, nil, True,  DETACHED_PROCESS, nil, nil, SI, PI) then begin
     if CreateProcess(nil,pchar(Command) , nil, nil, bInherited,  DETACHED_PROCESS, nil, nil, SI, PI) then begin
       if bWait then
       begin
         ExitCode := 0;
         while ExitCode = 0 do begin
           wrResult := WaitForSingleObject(PI.hProcess, 50);
           if PeekNamedPipe(hReadPipe, nil, 0, nil, @Avail, nil) then begin 
             if Avail > 0 then begin 
               TmpList := TStringList.Create; 
               try 
                 FillChar(Dest, SizeOf(Dest), 0); 
                 ReadFile(hReadPipe, Dest, Avail, BytesRead, nil); 
               finally
                 TmpList.Free; 
               end; 
             end; 
           end;
           if wrResult <> WAIT_TIMEOUT then begin
             ExitCode := 1;
           end; 
           Application.ProcessMessages;
         end; 
         GetExitCodeProcess(PI.hProcess, ExitCode); 
         CloseHandle(PI.hProcess); 
         CloseHandle(PI.hThread);
       end;
     end; 
  finally 
     CloseHandle(hReadPipe); 
     CloseHandle(hWritePipe); 
     Screen.Cursor := crDefault; 
  end;
end;

function  CheckDataPacket(aData:String; var bData:String):string;
var
  aIndex: Integer;
  Lenstr: String;
  DefinedDataLength: Integer;
  StrBuff: String;
  etxIndex: Integer;
begin
  Result:= '';
  if Length(aData) < 5 then
  begin
    result := ''; //자릿수가 작게 들어온 경우
    bData:= aData;
    Exit;
  end;
  Lenstr:= Copy(aData,2,3);
  //데이터 길이 위치 데이터가 숫자가 아니면...
  if not isDigit(Lenstr) then
  begin
    Delete(aData,1,1);       //1'st STX 삭제
    aIndex:= Pos(STX,aData); // 다음 STX 찾기
    if aIndex = 0 then       //STX가 없으면...
    begin
      //전체 데이터 버림
      bData:= '';
    end else if aIndex > 1 then // STX가 1'st가 아니면
    begin
      Delete(aData,1,aIndex-1);//STX 앞 데이터 삭제
      bData:= aData;
    end else
    begin
      bData:= aData;
    end;
    Exit;
  end;

  //패킷에 정의된 길이
  DefinedDataLength:= StrtoInt(Lenstr);
  //패킷에 정의된 길이보다 실제 데이터가 작으면
  if Length(aData) < DefinedDataLength then
  begin

    //실제 데이터가 길이가 작으면(아직 다 못받은 상태)
    etxIndex:= POS(ETX,aData);
    if etxIndex > 0 then
    begin
     Delete(aData,1,etxIndex);
     //ShowMessage(toHExstr(aData));
    end;
    
    bData:= aData;
    Exit;
  end;

  // 정의된 길이 마지막 데이터가 ETX가 맞는가?
  if aData[DefinedDataLength] = ETX then
  begin
    StrBuff:= Copy(aData,1,DefinedDataLength);
    Result:=StrBuff;
    Delete(aData, 1, DefinedDataLength);
    bData:= aData;
  end else
  begin
    //마직막 데이터가 EXT가 아니면 1'st STX지우고 다음 STX를 찾는다.
    Delete(aData,1,1);
    aIndex:= Pos(STX,aData); // 다음 STX 찾기
    if aIndex = 0 then       //STX가 없으면...
    begin
      //전체 데이터 버림
      bData:= '';
    end else if aIndex > 1 then // STX가 1'st가 아니면
    begin
      Delete(aData,1,aIndex-1);//STX 앞 데이터 삭제
      bData:= aData;
    end else
    begin
      bData:= aData;
    end;
  end;
end;

function CheckSumCheck(aBuff:string):Boolean;
var
  ACKStr: String;
  stCheckSum : string;
begin
  result := False;
  ACKStr := copy(aBuff,1,Length(aBuff) - 3);
  stCheckSum := copy(aBuff,Length(aBuff) - 2,2);
  if stCheckSum = MakeCSData(ACKStr+ETX) then result := True;
end;



end.




//Application.MessageBox('올바른 날짜가 아닙니다.', '입력 확인', MB_OK + MB_ICONWARNING);




{Select All DbGrid ==============================>
var
  TempBookmark: TBookmark;
begin
    ...
    with Dataset do
    begin
      if (BOF and EOF) then Exit;
      DisableControls;
      try
        TempBookmark:= GetBookmark;
        try
          First;
          while not EOF do
          begin
            DBGrid1.SelectedRows.CurrentRowSelected := True;
            Next;
          end;
        finally
          try
            GotoBookmark(TempBookmark);
          except
          end;
          FreeBookmark(TempBookmark);
        end;
      finally
        EnableControls;
      end;
    ...
end;

}



{Windwos 프로그램 응답없음 찾기}

// 1. The Documented way

{
  An application can check if a window is responding to messages by
  sending the WM_NULL message with the SendMessageTimeout function.

  Um zu uberprufen, ob ein anderes Fenster (Anwendung) noch reagiert,
  kann man ihr mit der SendMessageTimeout() API eine WM_NULL Nachricht schicken.
}

function AppIsResponding(ClassName: string): Boolean;
const
  { Specifies the duration, in milliseconds, of the time-out period }
  TIMEOUT = 50;
var
  Res: DWORD;
  h: HWND;
begin
  h := FindWindow(PChar(ClassName), nil);
  if h <> 0 then
    Result := SendMessageTimeOut(H,
      WM_NULL,
      0,
      0,
      SMTO_NORMAL or SMTO_ABORTIFHUNG,
      TIMEOUT,
      Res) <> 0
  else
    ShowMessage(Format('%s not found!', [ClassName]));
end;

procedure TForm1.Button1Click(Sender: TObject);
begin 
  if AppIsResponding('OpusApp') then 
    { OpusApp is the Class Name of WINWORD }
    ShowMessage('App. responding');
end; 

// 2. The Undocumented way 

{ 
  // Translated form C to Delphi by Thomas Stutz 
  // Original Code: 
  // (c)1999 Ashot Oganesyan K, SmartLine, Inc 
  // mailto:ashot@aha.ru, http://www.protect-me.com, http://www.codepile.com 

The code doesn't use the Win32 API SendMessageTimout function to
determine if the target application is responding but calls
undocumented functions from the User32.dll.

--> For NT/2000/XP the IsHungAppWindow() API:

The function IsHungAppWindow retrieves the status (running or not responding)
of the specified application

IsHungAppWindow(Wnd: HWND): // handle to main app's window
BOOL;

--> For Windows 95/98/ME we call the IsHungThread() API

The function IsHungThread retrieves the status (running or not responding) of
the specified thread

IsHungThread(DWORD dwThreadId): // The thread's identifier of the main app's window
BOOL;

Unfortunately, Microsoft doesn't provide us with the exports symbols in the
User32.lib for these functions, so we should load them dynamically using the
GetModuleHandle and GetProcAddress functions:
}

// For Win9X/ME
function IsAppRespondig9X(dwThreadId: DWORD): Boolean;
type
  TIsHungThread = function(dwThreadId: DWORD): BOOL; stdcall;
var
  hUser32: THandle;
  IsHungThread: TIsHungThread;
begin
  Result := True;
  hUser32 := GetModuleHandle('user32.dll');
  if (hUser32 > 0) then
  begin
    @IsHungThread := GetProcAddress(hUser32, 'IsHungThread');
    if Assigned(IsHungThread) then
    begin
      Result := not IsHungThread(dwThreadId);
    end;
  end;
end;

// For Win NT/2000/XP
function IsAppRespondigNT(wnd: HWND): Boolean;
type
  TIsHungAppWindow = function(wnd:hWnd): BOOL; stdcall;
var
  hUser32: THandle;
  IsHungAppWindow: TIsHungAppWindow;
begin
  Result := True;
  hUser32 := GetModuleHandle('user32.dll');
  if (hUser32 > 0) then
  begin
    @IsHungAppWindow := GetProcAddress(hUser32, 'IsHungAppWindow');
    if Assigned(IsHungAppWindow) then
    begin
      Result := not IsHungAppWindow(wnd);
    end;
  end;
end;

function IsAppRespondig(Wnd: HWND): Boolean;
begin
if not IsWindow(Wnd) then
begin
   ShowMessage('Incorrect window handle!');
   Exit;
end;
if Win32Platform = VER_PLATFORM_WIN32_NT then
   Result := IsAppRespondigNT(wnd)
else
   Result := IsAppRespondig9X(GetWindowThreadProcessId(Wnd,nil));
end;

// Example: Check if Word is hung/responding

procedure TForm1.Button3Click(Sender: TObject);
var
  Res: DWORD;
  h: HWND;
begin
  // Find Winword by classname
  h := FindWindow(PChar('OpusApp'), nil);
  if h <> 0 then
  begin
    if IsAppRespondig(h) then
      ShowMessage('Word is responding!')
    else
      ShowMessage('Word is not responding!');
  end
  else
    ShowMessage('Word is not open!');
end;



