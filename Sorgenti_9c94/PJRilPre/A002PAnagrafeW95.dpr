program A002PAnagrafeW95;



uses
  Forms,
  SysUtils,
  Controls,
  HtmlHelpViewer,
  MidasLib,
  A000UInterfaccia,
  A001UPassword,
  A002UAnagrafeDtM1 in 'A002UAnagrafeDtM1.pas' {A002FAnagrafeDtM1: TDataModule},
  A002ULayout in 'A002ULayout.pas' {A002FLayout},
  A002USplash in 'A002USplash.pas' {A002FSplash},
  A002UBadgeMsg in 'A002UBadgeMsg.pas' {A002FBadgeMsg},
  L001Call in '..\Copy\L001Call.pas',
  L021Call in  '..\Copy\L021Call.pas',
  A000Versione in '..\Copy\A000Versione.pas',
  A002UAnagrafeVistaPadre in '..\Repositary\A002UAnagrafeVistaPadre.pas' {A002FAnagrafeVistaPadre},
  A002UAnagrafeGestPadre in '..\Repositary\A002UAnagrafeGestPadre.pas' {A002FAnagrafeGestPadre},
  A002UAnagrafeGest in 'A002UAnagrafeGest.pas' {A002FAnagrafeGest},
  A002UAnagrafeVista in 'A002UAnagrafeVista.pas' {A002FAnagrafeVista},
  SelAnagrafe in '..\Componenti\SelAnagrafe.pas' {frmSelAnagrafe: TFrame},
  A082UCdcPercentDtM in '..\PJCondivisi\A082UCdcPercentDtM.pas',
  A082UCdCPercent in '..\PJCondivisi\A082UCdCPercent.pas';

var Oper:Integer;

{$R *.RES}

begin
  Application.Initialize;
  Application.Title:='Presenze-Assenze';
  Parametri.Applicazione:='RILPRE';
  Parametri.NomePJ:='Presenze-Assenze';
  Parametri.VersionePJ:=VersionePA;
  Parametri.BuildPJ:=BuildPA;
  Parametri.DataPJ:=DataPA;
  Oper:=Password('Presenze-Assenze ' + VersionePA);
  //Oper:=0;
  if Oper = -1 then
    begin
    Application.Terminate;
    exit;
    end;
  Application.HelpFile := 'Help\Iriswin.chm';
  Application.CreateForm(TA002FAnagrafeVista, A002FAnagrafeVista);
  Application.CreateForm(TA002FSplash, A002FSplash);
  A002FSplash.Show;
  A002FSplash.Repaint;
  A002FAnagrafeVista.ProgOper:=Oper;
  Application.CreateForm(TA002FAnagrafeGest, A002FAnagrafeGest);
  Application.CreateForm(TA002FAnagrafeDtM1, A002FAnagrafeDtM1);
  Application.CreateForm(TA002FLayout, A002FLayout);
  A002FSplash.Close;
  Application.Run;
end.
