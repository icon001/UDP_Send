object Form1: TForm1
  Left = 192
  Top = 114
  Width = 785
  Height = 516
  Caption = 'UdpSend'
  Color = clBtnFace
  Font.Charset = HANGEUL_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = #44404#47548#52404
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 12
  object GroupBox1: TGroupBox
    Left = 0
    Top = 0
    Width = 777
    Height = 145
    Align = alTop
    Caption = #45936#51060#53552#51204#49569
    TabOrder = 0
    object Label1: TLabel
      Left = 40
      Top = 32
      Width = 36
      Height = 12
      Caption = #53440#44191'IP'
    end
    object Label2: TLabel
      Left = 280
      Top = 32
      Width = 48
      Height = 12
      Caption = #53440#44191#54252#53944
    end
    object Label4: TLabel
      Left = 40
      Top = 56
      Width = 48
      Height = 12
      Caption = #51204#49569'Data'
    end
    object Label3: TLabel
      Left = 40
      Top = 80
      Width = 24
      Height = 12
      Caption = #54943#49688
    end
    object Label5: TLabel
      Left = 168
      Top = 80
      Width = 48
      Height = 12
      Caption = #45824#44592#49884#44036
    end
    object Label6: TLabel
      Left = 296
      Top = 80
      Width = 12
      Height = 12
      Caption = 'ms'
    end
    object btn_Send: TSpeedButton
      Left = 144
      Top = 104
      Width = 113
      Height = 25
      Caption = #51204#49569
      OnClick = btn_SendClick
    end
    object btn_Close: TSpeedButton
      Left = 400
      Top = 104
      Width = 113
      Height = 25
      Caption = #45803#44592
      OnClick = btn_CloseClick
    end
    object ed_IP: TEdit
      Left = 96
      Top = 28
      Width = 177
      Height = 20
      ImeName = 'Microsoft IME 2010'
      TabOrder = 0
    end
    object ed_Port: TEdit
      Left = 344
      Top = 28
      Width = 65
      Height = 20
      ImeName = 'Microsoft IME 2010'
      TabOrder = 1
    end
    object rg_Type: TRadioGroup
      Left = 432
      Top = 16
      Width = 289
      Height = 33
      Columns = 3
      ItemIndex = 0
      Items.Strings = (
        'UDP'
        'TCP/IP'
        'Broad')
      TabOrder = 2
      OnClick = rg_TypeClick
    end
    object ed_Data: TEdit
      Left = 96
      Top = 52
      Width = 625
      Height = 20
      ImeName = 'Microsoft IME 2010'
      TabOrder = 3
    end
    object ed_count: TEdit
      Left = 96
      Top = 76
      Width = 65
      Height = 20
      ImeName = 'Microsoft IME 2010'
      TabOrder = 4
      Text = '1'
    end
    object ed_DelayTime: TEdit
      Left = 224
      Top = 76
      Width = 65
      Height = 20
      ImeName = 'Microsoft IME 2010'
      TabOrder = 5
      Text = '1000'
    end
    object chk_HextoASCII: TCheckBox
      Left = 328
      Top = 78
      Width = 305
      Height = 17
      Caption = 'HEX'#51204#49569
      TabOrder = 6
    end
  end
  object GroupBox2: TGroupBox
    Left = 0
    Top = 145
    Width = 777
    Height = 337
    Align = alClient
    Caption = #45936#51060#53552#49688#49888
    TabOrder = 1
    object Label7: TLabel
      Left = 40
      Top = 24
      Width = 48
      Height = 12
      Caption = #49688#49888#54252#53944
    end
    object btn_Receive: TSpeedButton
      Left = 192
      Top = 16
      Width = 105
      Height = 25
      Caption = #45824#44592
      OnClick = btn_ReceiveClick
    end
    object btn_Clear: TSpeedButton
      Left = 304
      Top = 16
      Width = 105
      Height = 25
      Caption = 'Clear'
      OnClick = btn_ClearClick
    end
    object ed_RcvPort: TEdit
      Left = 104
      Top = 20
      Width = 65
      Height = 20
      ImeName = 'Microsoft IME 2010'
      TabOrder = 0
    end
    object Memo1: TMemo
      Left = 16
      Top = 48
      Width = 745
      Height = 281
      ImeName = 'Microsoft IME 2010'
      Lines.Strings = (
        'Memo1')
      ScrollBars = ssBoth
      TabOrder = 1
    end
    object chk_AsctoHex: TCheckBox
      Left = 424
      Top = 22
      Width = 305
      Height = 17
      Caption = 'HEX'#54364#49884
      TabOrder = 2
    end
  end
  object IdTCPClient: TIdTCPClient
    MaxLineAction = maException
    ReadTimeout = 1000
    OnDisconnected = IdTCPClientDisconnected
    OnConnected = IdTCPClientConnected
    Port = 0
    Left = 56
    Top = 8
  end
  object IdUDPClient1: TIdUDPClient
    Port = 0
    Left = 24
    Top = 8
  end
  object IdUDPServer1: TIdUDPServer
    Bindings = <>
    DefaultPort = 0
    OnUDPRead = IdUDPServer1UDPRead
    Left = 296
    Top = 115
  end
end
