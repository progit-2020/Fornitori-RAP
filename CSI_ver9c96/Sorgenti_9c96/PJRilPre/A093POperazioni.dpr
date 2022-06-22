program A093POperazioni;

uses
  Forms,
  A093UOperazioniDtM1 in 'A093UOperazioniDtM1.pas' {A093FOperazioniDtM1: TDataModule},
  A093UOperazioni in 'A093UOperazioni.pas' {A093FOperazioni},
  A093UStampa in 'A093UStampa.pas' {A093FStampa},
  A093UVideo in 'A093UVideo.pas' {A093FVideo},
  SelAnagrafe in '..\Componenti\SelAnagrafe.pas' {frmSelAnagrafe: TFrame};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TA093FOperazioni, A093FOperazioni);
  Application.CreateForm(TA093FOperazioniDtM1, A093FOperazioniDtM1);
  Application.Run;
end.
