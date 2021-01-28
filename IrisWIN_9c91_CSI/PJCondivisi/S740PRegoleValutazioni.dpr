program S740PRegoleValutazioni;

uses
  Forms,
  R004UGestStorico in '..\Repositary\R004UGestStorico.pas' {R004FGestStorico},
  S740URegoleValutazioni in 'S740URegoleValutazioni.pas' {S740FRegoleValutazioni},
  R004UGestStoricoDTM in '..\Repositary\R004UGestStoricoDTM.pas' {R004FGestStoricoDtM: TDataModule},
  S740URegoleValutazioniDtM in 'S740URegoleValutazioniDtM.pas' {S740FRegoleValutazioniDtM: TDataModule},
  C600USelAnagrafe in '..\Copy\C600USelAnagrafe.pas' {C600frmSelAnagrafe: TFrame};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TS740FRegoleValutazioni, S740FRegoleValutazioni);
  Application.CreateForm(TS740FRegoleValutazioniDtM, S740FRegoleValutazioniDtM);
  Application.Run;
end.
