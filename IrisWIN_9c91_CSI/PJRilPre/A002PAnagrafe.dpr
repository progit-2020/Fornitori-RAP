program A002PAnagrafe;

uses
  Forms,
  SysUtils,
  Controls,
  HtmlHelpViewer,
  MidasLib,
  OracleMonitor,
  A000UInterfaccia,
  A001UPassword,
  A002UAnagrafeDtM1 in 'A002UAnagrafeDtM1.pas' {A002FAnagrafeDtM1: TDataModule},
  A002ULayout in 'A002ULayout.pas' {A002FLayout},
  A002USplash in 'A002USplash.pas' {A002FSplash},
  A002UBadgeMsg in 'A002UBadgeMsg.pas' {A002FBadgeMsg},
  L001Call in '..\Copy\L001Call.pas',
  L021Call in '..\Copy\L021Call.pas',
  A000Versione in '..\Copy\A000Versione.pas',
  A002UAnagrafeVistaPadre in '..\Repositary\A002UAnagrafeVistaPadre.pas' {A002FAnagrafeVistaPadre},
  A002UAnagrafeGestPadre in '..\Repositary\A002UAnagrafeGestPadre.pas' {A002FAnagrafeGestPadre},
  A002UAnagrafeGest in 'A002UAnagrafeGest.pas' {A002FAnagrafeGest},
  A002UAnagrafeVista in 'A002UAnagrafeVista.pas' {A002FAnagrafeVista},
  SelAnagrafe in '..\Componenti\SelAnagrafe.pas' {frmSelAnagrafe: TFrame},
  A082UCdcPercentDtM in '..\PJCondivisi\A082UCdcPercentDtM.pas',
  A082UCdCPercent in '..\PJCondivisi\A082UCdCPercent.pas',
  C006UStoriaDip in '..\Copy\C006UStoriaDip.pas' {C006FStoriaDip},
  A002UCercaCampo in 'A002UCercaCampo.pas' {A002FCercaCampo},
  R005UDataModuleMW in '..\Repositary\R005UDataModuleMW.pas' {R005FDataModuleMW: TDataModule},
  A002UAnagrafeMW in '..\MWRilPre\A002UAnagrafeMW.pas' {A002FAnagrafeMW: TDataModule},
  A000UMessaggi in '..\Copy\A000UMessaggi.pas',
  C180FunzioniGenerali;

var
  Oper:Integer;
  CHMFile:String;

{$R *.RES}

begin
  {$WARN SYMBOL_PLATFORM OFF}
  ReportMemoryLeaksOnShutdown:=(DebugHook <> 0);
  {$WARN SYMBOL_PLATFORM ON}
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.Title:='Presenze-Assenze';
  Parametri.Applicazione:='RILPRE';
  Parametri.NomePJ:='Presenze-Assenze';
  Parametri.VersionePJ:=VersionePA;
  Parametri.BuildPJ:=BuildPA;
  Parametri.DataPJ:=DataPA;
  Oper:=Password('Presenze-Assenze ' + Format('%s(%s)',[VersionePA,BuildPA]));
  //Oper:=0;
  if Oper = -1 then
  begin
    Application.Terminate;
    exit;
  end;

  Application.HelpFile:='Help\Iriswin.chm';
  if False then
  begin
    // Copia del file CHM in directory temporanea
    // Per il momento questa funzione è implementata, ma è inutilizzata
    CHMFile:=R180PreparaFileHelpTemp('Iriswin.chm');
    if CHMFile <> '' then
      Application.HelpFile:=CHMFile
    else
      Application.HelpFile:='Help\Iriswin.chm';
  end;

  Application.CreateForm(TA002FAnagrafeVista, A002FAnagrafeVista);
  Application.CreateForm(TA002FSplash, A002FSplash);
  if UpperCase(Parametri.RagioneSociale) <> 'AZIENDA OSPEDALIERA SANT''ANDREA' then
    A002FSplash.Show;
  A002FSplash.Repaint;
  A002FAnagrafeVista.ProgOper:=Oper;
  Application.CreateForm(TA002FAnagrafeGest, A002FAnagrafeGest);
  Application.CreateForm(TA002FAnagrafeDtM1, A002FAnagrafeDtM1);
  A002FSplash.Free;
  Application.Run;
end.
