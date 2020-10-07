program A150PCodiciAccorpamentoCausali;

uses
  Forms,
  A150UCodiciAccorpamentoCausali in 'A150UCodiciAccorpamentoCausali.pas' {A150FCodiciAccorpamentoCausali},
  R004UGestStorico in '..\Repositary\R004UGestStorico.pas' {R004FGestStorico},
  R004UGestStoricoDTM in '..\Repositary\R004UGestStoricoDTM.pas' {R004FGestStoricoDtM: TDataModule},
  A150UCodiciAccorpamentoCausaliDtM in 'A150UCodiciAccorpamentoCausaliDtM.pas' {A150FCodiciAccorpamentoCausaliDtM: TDataModule},
  A150UAccorpamentoCausaliMW in '..\MWRilPre\A150UAccorpamentoCausaliMW.pas' {A150FAccorpamentoCausaliMW: TDataModule};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TA150FCodiciAccorpamentoCausali, A150FCodiciAccorpamentoCausali);
  Application.CreateForm(TA150FCodiciAccorpamentoCausaliDtM, A150FCodiciAccorpamentoCausaliDtM);
  Application.Run;
end.
