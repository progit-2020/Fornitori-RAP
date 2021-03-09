program A150PAccorpamentoCausali;

uses
  Forms,
  A150UAccorpamentoCausali in 'A150UAccorpamentoCausali.pas' {A150FAccorpamentoCausali},
  R004UGestStoricoDTM in '..\Repositary\R004UGestStoricoDTM.pas' {R004FGestStoricoDtM: TDataModule},
  A150UAccorpamentoCausaliDtM in 'A150UAccorpamentoCausaliDtM.pas' {A150FAccorpamentoCausaliDtM: TDataModule},
  R001UGESTTAB in '..\Repositary\R001UGESTTAB.pas' {R001FGestTab},
  A150UTipoAccorpamentoCausali in 'A150UTipoAccorpamentoCausali.pas' {A150FTipoAccorpamentoCausali},
  R004UGestStorico in '..\Repositary\R004UGestStorico.pas' {R004FGestStorico},
  A150UAccorpamentoCausaliMW in '..\MWRilPre\A150UAccorpamentoCausaliMW.pas' {A150FAccorpamentoCausaliMW: TDataModule};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TA150FAccorpamentoCausali, A150FAccorpamentoCausali);
  Application.CreateForm(TA150FAccorpamentoCausaliDtM, A150FAccorpamentoCausaliDtM);
  Application.Run;
end.
