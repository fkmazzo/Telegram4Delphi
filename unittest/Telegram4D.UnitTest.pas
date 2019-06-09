unit Telegram4D.UnitTest;

interface
uses
  DUnitX.TestFramework,
  System.IniFiles,
  System.SysUtils;

type

  [TestFixture]
  TMyTestObject = class(TObject) 
  private
    MyIniFile: TIniFile;
  public
    [Setup]
    procedure Setup;
    [TearDown]
    procedure TearDown;
    [Test]
    procedure getMeTest;
  end;


implementation

uses
  Telegram4D.Impl;


procedure TMyTestObject.getMeTest;
var
  Telegram4D: ITelegram4D;
begin
  Telegram4D := TTelegram4DImpl.Create;
  Telegram4D.getTelegram4DObject.baseURL  := MyIniFile.ReadString('Configuration', 'baseURL', '');
  Telegram4D.getTelegram4DObject.botToken := MyIniFile.ReadString('Configuration', 'botToken', '');

  Assert.IsTrue(Telegram4D.getMe.GetValue<String>('ok') = 'true');
end;



procedure TMyTestObject.Setup;
begin
  MyIniFile := TIniFile.Create(GetCurrentDir + '\configuration.ini');
end;



procedure TMyTestObject.TearDown;
begin
  MyIniFile.Free;
end;



initialization
  TDUnitX.RegisterTestFixture(TMyTestObject);
end.
