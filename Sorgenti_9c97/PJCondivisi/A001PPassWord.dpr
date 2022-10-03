program A001PPassWord;

uses
  Forms,
  A001UPassWord in 'A001UPassWord.pas' {A001FPassWord},
  A001UPassWordDtM1 in 'A001UPassWordDtM1.pas' {A001FPassWordDtM1: TDataModule};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TA001FPassWord, A001FPassWord);
  Application.CreateForm(TA001FPassWordDtM1, A001FPassWordDtM1);
  Application.Run;
end.
