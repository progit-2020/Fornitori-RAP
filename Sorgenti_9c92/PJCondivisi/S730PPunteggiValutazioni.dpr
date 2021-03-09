program S730PPunteggiValutazioni;

uses
  Forms,
  R004UGestStorico in '..\Repositary\R004UGestStorico.pas' {R004FGestStorico},
  S730UPunteggiValutazioni in 'S730UPunteggiValutazioni.pas' {S730FPunteggiValutazioni},
  R004UGestStoricoDTM in '..\Repositary\R004UGestStoricoDTM.pas' {R004FGestStoricoDtM: TDataModule},
  S730UPunteggiValutazioniDtM in 'S730UPunteggiValutazioniDtM.pas' {S730FPunteggiValutazioniDtM: TDataModule},
  R005UDataModuleMW in '..\Repositary\R005UDataModuleMW.pas' {R005FDataModuleMW: TDataModule},
  S730UPunteggiValutazioniMW in '..\MWCondivisi\S730UPunteggiValutazioniMW.pas' {S730FPunteggiValutazioniMW: TDataModule};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TS730FPunteggiValutazioni, S730FPunteggiValutazioni);
  Application.CreateForm(TS730FPunteggiValutazioniDtM, S730FPunteggiValutazioniDtM);
  Application.Run;
end.
