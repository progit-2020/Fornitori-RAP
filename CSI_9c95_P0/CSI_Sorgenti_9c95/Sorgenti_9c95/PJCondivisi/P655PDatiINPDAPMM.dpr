program P655PDatiINPDAPMM;

uses
  Forms,
  R001UGESTTAB in '..\Repositary\R001UGESTTAB.pas' {R001FGestTab},
  R004UGESTSTORICODTM in '..\Repositary\R004UGestStoricoDTM.pas' {R004FGestStoricoDtM: TDataModule},
  SelAnagrafe in '..\Componenti\SelAnagrafe.pas' {frmSelAnagrafe: TFrame},
  P655UDatiINPDAPMM in 'P655UDatiINPDAPMM.pas' {P655FDatiINPDAPMM},
  P655UDatiINPDAPMMDtM in 'P655UDatiINPDAPMMDtM.pas' {P655FDatiINPDAPMMDtM: TDataModule},
  ToolbarFiglio in '..\Componenti\ToolbarFiglio.pas' {frmToolbarFiglio: TFrame},
  R005UDataModuleMW in '..\Repositary\R005UDataModuleMW.pas' {R005FDataModuleMW: TDataModule},
  P655UDatiINPDAPMMMW in '..\MWCondivisi\P655UDatiINPDAPMMMW.pas' {P655FDatiINPDAPMMMW: TDataModule},
  A000UMessaggi in '..\Copy\A000UMessaggi.pas';

{$R *.RES}

begin
  {$WARN SYMBOL_PLATFORM OFF}
  ReportMemoryLeaksOnShutdown:=(DebugHook <> 0);
  {$WARN SYMBOL_PLATFORM ON}
  Application.Initialize;
  Application.CreateForm(TP655FDatiINPDAPMM, P655FDatiINPDAPMM);
  //  P655FDatiINPDAPMM.sPb_NomeFlusso:='FLUPER';
//  P655FDatiINPDAPMM.sPb_NomeFlusso:='DMA';
  Application.CreateForm(TP655FDatiINPDAPMMDtM, P655FDatiINPDAPMMDtM);
  Application.Run;
end.
