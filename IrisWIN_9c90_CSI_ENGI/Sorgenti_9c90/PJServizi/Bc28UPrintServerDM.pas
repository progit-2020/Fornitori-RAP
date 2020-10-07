unit Bc28UPrintServerDM;

{$WARN SYMBOL_PLATFORM OFF}

interface

uses
  Windows, Forms, Messages, SysUtils, StrUtils, Math, Classes, ComServ, ComObj, VCLCom, DataBkr, Variants,
  DBClient, StdVcl, QRPDFFilt, DBXJSON, OracleData,Oracle,
  A000USessione, A000UInterfaccia, Bc28PPrintServer_COM_TLB, System.JSON;

type
  TBc28PrintServer = class(TRemoteDataModule, IBc28PrintServer)
  private
    procedure AperturaSessione(DBServer, Azienda, Operatore: String);
    procedure EreditaSelezioneAnagrafica(SelezioneAnagrafica: String);
    procedure SettaDatiUtente(DatiUtente: WideString; Form: TForm);
  protected
    class procedure UpdateRegistry(Register: Boolean; const ClassID, ProgID: string); override;
    procedure ProvaStampa(const NomeFile: WideString); safecall;
    procedure PrintA045(const SelezioneAnagrafica, FilePDF, Operatore, Azienda, DBServer: WideString; const DatiUtente: WideString; var DettaglioLog: OleVariant); safecall;
    procedure PrintA061(const SelezioneAnagrafica, FilePDF, Operatore, Azienda, DBServer, DatiUtente: WideString; var DettaglioLog: OleVariant); safecall;
    procedure PrintA043(const SelezioneAnagrafica, FilePDF, Operatore, Azienda, DBServer, DatiUtente: WideString; var DettaglioLog: OleVariant); safecall;
    procedure PrintA074(const SelezioneAnagrafica, FilePDF, Operatore, Azienda, DBServer, DatiUtente: WideString; var DettaglioLog: OleVariant); safecall;
    procedure PrintA042(const SelezioneAnagrafica, FilePDF, Operatore, Azienda, DBServer, DatiUtente: WideString; var DettaglioLog: OleVariant); safecall;
    procedure PrintA092(const SelezioneAnagrafica, FilePDF, Operatore, Azienda, DBServer, DatiUtente: WideString; var DettaglioLog: OleVariant); safecall;
    procedure PrintA081(const SelezioneAnagrafica, FilePDF, Operatore, Azienda, DBServer, DatiUtente: WideString; var DettaglioLog: OleVariant); safecall;
    procedure PrintA051(const SelezioneAnagrafica, FilePDF, Operatore, Azienda, DBServer, DatiUtente: WideString; var DettaglioLog: OleVariant); safecall;
    procedure PrintA090(const SelezioneAnagrafica, FilePDF, Operatore, Azienda, DBServer, DatiUtente: WideString; var DettaglioLog: OleVariant); safecall;
    procedure PrintA116(const SelezioneAnagrafica, FilePDF, Operatore, Azienda, DBServer, DatiUtente: WideString; var DettaglioLog: OleVariant); safecall;
    procedure PrintA077(const SelezioneAnagrafica, FilePDF, Operatore, Azienda, DBServer, DatiUtente: WideString; var DettaglioLog: OleVariant); safecall;
    procedure PrintA059(const FilePDF, Operatore, Azienda, DBServer, DatiUtente: WideString; var DettaglioLog: OleVariant); safecall;
    procedure PrintA068(const SelezioneAnagrafica, FilePDF, Operatore, Azienda, DBServer, DatiUtente: WideString; var DettaglioLog: OleVariant); safecall;
    procedure PrintA058(const SelezioneAnagrafica, FilePDF, Operatore, Azienda, DBServer, DatiUtente: WideString; var DettaglioLog: OleVariant); safecall;
    procedure PrintA105(const SelezioneAnagrafica, FilePDF, Operatore, Azienda, DBServer, DatiUtente: WideString; var DettaglioLog: OleVariant); safecall;
    procedure PrintA104(const SelezioneAnagrafica, FilePDF, Operatore, Azienda, DBServer, DatiUtente: WideString; var DettaglioLog: OleVariant); safecall;
    procedure PrintA047(const SelezioneAnagrafica, FilePDF, Operatore, Azienda, DBServer,
          DatiUtente: WideString; var DettaglioLog: OleVariant); safecall;
    procedure PrintA167(const SelezioneAnagrafica, FilePDF, Operatore, Azienda, DBServer,
          DatiUtente: WideString; var DettaglioLog: OleVariant); safecall;
    procedure PrintA145(const SelezioneAnagrafica, FilePDF, Operatore, Azienda, DBServer,
          DatiUtente: WideString; var DettaglioLog: OleVariant); safecall;
    procedure PrintS715(const SelezioneAnagrafica, FilePDF, Operatore, Azienda, DBServer,
          DatiUtente: WideString; var DettaglioLog, MessaggioAggiuntivo: OleVariant);
          safecall;
    procedure PrintAc04(const SelezioneAnagrafica, FilePDF, Operatore, Azienda, DBServer, DatiUtente: WideString; var DettaglioLog: OleVariant); safecall;
  public
    { Public declarations }
  end;

implementation

{$R *.DFM}

uses Bc28UprovaStampa, A001UPasswordDtM1, A042UDialogStampa, A042UStampaPreAssDtM1, A042UGrafico, A043UDialogStampa,
     A045UDialogStampa, A047UTimbMensa, A047UDialogStampa, A047UTimbMensaDtM1, A051UTimbOrig, A051UTimbOrigDtM1, A058UPianifTurni, A058UPianifTurniDtM1,
     A059UContSquadre, A059UContSquadreDtM1, A061UDettAssenze, A068UTurniGior, A068UTurniGiorDtM1,
     A074URiepilogoBuoni, A074URiepilogoBuoniDtM1, A081UTimbCaus,
     A077UGeneratoreStampe, A077UGeneratoreStampeDtM, A077UStampa,//  P077UGeneratoreStampe, P077UGeneratoreStampeDtM, P077UStampa,
     A081UTimbCausDtM1, A090UAssenzeAnno, A090UAssenzeAnnoDtM1, A092UStampaStorico, A092UStampaStoricoDtM1,
     A105UStoricoGiustificativi, A116ULiquidazioneOreAnniPrec, A104UStampaMissioniDtm1, A104UDialogStampa,
     A167URegistraIncentivi,A167URegistraIncentiviDtm, A145UComunicazioneVisiteFiscali, A145UComunicazioneVisiteFiscaliDtM,
     Ac04UStampaRendiProj,Ac04UStampaRendiProjDM,
     S715UDialogStampa,S715UStampaValutazioniDtM,
     C700USelezioneAnagrafe, C180FunzioniGenerali;

class procedure TBc28PrintServer.UpdateRegistry(Register: Boolean; const ClassID, ProgID: string);
begin
  if Register then
  begin
    inherited UpdateRegistry(Register, ClassID, ProgID);
    EnableSocketTransport(ClassID);
    EnableWebTransport(ClassID);
  end else
  begin
    DisableSocketTransport(ClassID);
    DisableWebTransport(ClassID);
    inherited UpdateRegistry(Register, ClassID, ProgID);
  end;
end;

procedure TBc28PrintServer.ProvaStampa(const NomeFile: WideString);
begin
  with TBc28FProvaStampa.Create(nil) do
  try
    QuickRep1.ShowProgress:=False;
    QuickRep1.ExportToFilter(TQRPDFDocumentFilter.Create(NomeFile));
  finally
    Free;
  end;
end;

procedure TBc28PrintServer.PrintA045(const SelezioneAnagrafica, FilePDF, Operatore, Azienda, DBServer: WideString; const DatiUtente: WideString; var DettaglioLog: OleVariant);
begin
  //Inizializzo sessione
  AperturaSessione(DBServer,Azienda,Operatore);
  A045FDialogStampa:=TA045FDialogStampa.Create(nil);
  try
    A045FDialogStampa.DocumentoPDF:=IfThen(FilePDF <> '',FilePDF,'<VUOTO>');
    A045FDialogStampa.A045MW.TipoModulo:='COM';
    A045FDialogStampa.FormShow(A045FDialogStampa);

    //Eredito selezione anagrafe
    C700SelAnagrafe.Close;
    EreditaSelezioneAnagrafica(SelezioneAnagrafica);

    //Inizializzo form
    A045FDialogStampa.chkAnteprima.Checked:=True;
    A045FDialogStampa.chkElabora.Checked:=False;
    A045FDialogStampa.PopolaListaQualifiche;
    A045FDialogStampa.PopolaListaTipiRapporto;

    //Leggo i dati inseriti dall'utente web e li setto su  A045FDialogStampa
    SettaDatiUtente(DatiUtente,A045FDialogStampa);

    //Creo File stampa
    A045FDialogStampa.btnEseguiClick(A045FDialogStampa);
  finally
    A045FDialogStampa.Free;
  end;
end;

procedure TBc28PrintServer.PrintA061(const SelezioneAnagrafica, FilePDF, Operatore, Azienda, DBServer, DatiUtente: WideString; var DettaglioLog: OleVariant);
begin
  //Inizializzo sessione
  AperturaSessione(DBServer,Azienda,Operatore);
  A061FDettAssenze:=TA061FDettAssenze.Create(nil);
  try
    A061FDettAssenze.A061MW.DocumentoPDF:=IfThen(FilePDF <> '',FilePDF,'<VUOTO>');
    A061FDettAssenze.A061MW.TipoModulo:='COM';
    A061FDettAssenze.FormShow(A061FDettAssenze);

    //Eredito selezione anagrafe
    C700SelAnagrafe.Close;
    EreditaSelezioneAnagrafica(SelezioneAnagrafica);

    //Leggo i dati inseriti dall'utente web e li setto su  A045FDialogStampa
    SettaDatiUtente(DatiUtente,A061FDettAssenze);

    //Inizializzo form
    with A061FDettAssenze do
    begin
      DaData:=StrToDate(edtDaData.Text);
      AData:=StrToDate(edtAData.Text);
      DaRegStamp:=StrToDate(edtDaRegStamp.Text);
      ARegStamp:=StrToDate(edtARegStamp.Text);
    end;

    //Creo File stampa
    A061FDettAssenze.BtnPreViewClick(A061FDettAssenze);
  finally
    A061FDettAssenze.Free;
  end;
end;

procedure TBc28PrintServer.PrintA043(const SelezioneAnagrafica, FilePDF, Operatore, Azienda, DBServer, DatiUtente: WideString; var DettaglioLog: OleVariant);
begin
  //Inizializzo sessione
  AperturaSessione(DBServer,Azienda,Operatore);
  A043FDialogStampa:=TA043FDialogStampa.Create(nil);
  try
    A043FDialogStampa.A043MW.DocumentoPDF:=IfThen(FilePDF <> '',FilePDF,'<VUOTO>');
    A043FDialogStampa.A043MW.TipoModulo:='COM';
    A043FDialogStampa.FormShow(A043FDialogStampa);

    //Eredito selezione anagrafe
    C700SelAnagrafe.Close;
    EreditaSelezioneAnagrafica(SelezioneAnagrafica);

    //Leggo i dati inseriti dall'utente web e li setto su  A043FDialogStampa
    SettaDatiUtente(DatiUtente,A043FDialogStampa);

    //Inizializzo form
    with A043FDialogStampa do
    begin
      //Creo File stampa
      if SoloAgg = 'S' then
        BtnStampaClick(btnSoloAggiornamento)
      else
        BtnStampaClick(btnAnteprima);
    end;
    if RegistraMsg.ContieneTipoA or RegistraMsg.ContieneTipoB then
      DettaglioLog:=IntToStr(RegistraMsg.ID);
  finally
    A043FDialogStampa.Free;
  end;
end;

procedure TBc28PrintServer.PrintA074(const SelezioneAnagrafica, FilePDF, Operatore, Azienda, DBServer, DatiUtente: WideString; var DettaglioLog: OleVariant);
begin
  //Inizializzo sessione
  AperturaSessione(DBServer,Azienda,Operatore);
  A074FRiepilogoBuoni:=TA074FRiepilogoBuoni.Create(nil);
  try
    A074FRiepilogoBuoniDtM1:=TA074FRiepilogoBuoniDtM1.Create(nil);
    A074FRiepilogoBuoni.DocumentoPDF:=IfThen(FilePDF <> '',FilePDF,'<VUOTO>');
    A074FRiepilogoBuoni.TipoModulo:='COM';
    A074FRiepilogoBuoni.FormShow(A043FDialogStampa);

    //Eredito selezione anagrafe
    C700SelAnagrafe.Close;
    EreditaSelezioneAnagrafica(SelezioneAnagrafica);

    //Leggo i dati inseriti dall'utente web e li setto su A074FRiepilogoBuoni
    SettaDatiUtente(DatiUtente,A074FRiepilogoBuoni);
    A074FRiepilogoBuoni.ChkInizioAnnoClick(nil);

    //Inizializzo form
    A074FRiepilogoBuoni.BtnStampaClick(A074FRiepilogoBuoni.BtnStampa);
  finally
    A074FRiepilogoBuoni.Free;
    A074FRiepilogoBuoniDtM1.Free;
  end;
end;

procedure TBc28PrintServer.PrintA042(const SelezioneAnagrafica, FilePDF, Operatore, Azienda, DBServer, DatiUtente: WideString; var DettaglioLog: OleVariant);
begin
  //Inizializzo sessione
  AperturaSessione(DBServer,Azienda,Operatore);
  A042FDialogStampa:=TA042FDialogStampa.Create(nil);
  try
    A042FStampaPreAssDtM1:=TA042FStampaPreAssDtM1.Create(nil);
    A042FDialogStampa.DocumentoPDF:=IfThen(FilePDF <> '',FilePDF,'<VUOTO>');
    A042FDialogStampa.TipoModulo:='COM';
    A042FDialogStampa.FormShow(A042FDialogStampa);

    //Eredito selezione anagrafe
    C700SelAnagrafe.Close;
    EreditaSelezioneAnagrafica(SelezioneAnagrafica);

    //Leggo i dati inseriti dall'utente web e li setto su  A074FRiepilogoBuoni
    SettaDatiUtente(DatiUtente,A042FDialogStampa);

    //Inizializzo form
    A042FDialogStampa.BtnStampaClick(A042FDialogStampa.BtnStampa);
  finally
    A042FDialogStampa.Free;
    A042FStampaPreAssDtM1.Free;
  end;
end;

procedure TBc28PrintServer.PrintA092(const SelezioneAnagrafica, FilePDF, Operatore, Azienda, DBServer, DatiUtente: WideString; var DettaglioLog: OleVariant);
begin
  //Inizializzo sessione
  AperturaSessione(DBServer,Azienda,Operatore);
  A092FStampaStorico:=TA092FStampaStorico.Create(nil);
  try
    A092FStampaStoricoDtM1:=TA092FStampaStoricoDtM1.Create(nil);
    A092FStampaStorico.DocumentoPDF:=IfThen(FilePDF <> '',FilePDF,'<VUOTO>');
    A092FStampaStorico.TipoModulo:='COM';
    A092FStampaStorico.FormShow(A092FStampaStorico);

    //Eredito selezione anagrafe
    C700SelAnagrafe.Close;
    EreditaSelezioneAnagrafica(SelezioneAnagrafica);

    //Leggo i dati inseriti dall'utente web e li setto su  A074FRiepilogoBuoni
    SettaDatiUtente(DatiUtente,A092FStampaStorico);

    //Inizializzo form
    A092FStampaStorico.BtnPreViewClick(A092FStampaStorico.BtnStampa);
  finally
    A092FStampaStorico.Free;
    A092FStampaStoricoDtM1.Free;
  end;
end;

procedure TBc28PrintServer.PrintA081(const SelezioneAnagrafica, FilePDF, Operatore, Azienda, DBServer, DatiUtente: WideString; var DettaglioLog: OleVariant);
begin
  //Inizializzo sessione
  AperturaSessione(DBServer,Azienda,Operatore);
  A081FTimbCaus:=TA081FTimbCaus.Create(nil);
  try
    A081FTimbCausDtM1:=TA081FTimbCausDtM1.Create(nil);
    A081FTimbCaus.DocumentoPDF:=IfThen(FilePDF <> '',FilePDF,'<VUOTO>');
    A081FTimbCaus.TipoModulo:='COM';
    A081FTimbCaus.FormShow(A081FTimbCaus);

    //Eredito selezione anagrafe
    C700SelAnagrafe.Close;
    EreditaSelezioneAnagrafica(SelezioneAnagrafica);

    //Leggo i dati inseriti dall'utente web e li setto su  A074FRiepilogoBuoni
    SettaDatiUtente(DatiUtente,A081FTimbCaus);

    //Inizializzo form
    A081FTimbCaus.BtnPreViewClick(A081FTimbCaus.BtnStampa);
  finally
    A081FTimbCaus.Free;
    A081FTimbCausDtM1.Free;
  end;
end;

procedure TBc28PrintServer.PrintA051(const SelezioneAnagrafica, FilePDF, Operatore, Azienda, DBServer, DatiUtente: WideString; var DettaglioLog: OleVariant);
begin
  //Inizializzo sessione
  AperturaSessione(DBServer,Azienda,Operatore);
  A051FTimbOrig:=TA051FTimbOrig.Create(nil);
  try
    A051FTimbOrigDtM1:=TA051FTimbOrigDtM1.Create(nil);
    A051FTimbOrig.DocumentoPDF:=IfThen(FilePDF <> '',FilePDF,'<VUOTO>');
    A051FTimbOrig.TipoModulo:='COM';
    A051FTimbOrig.FormShow(A081FTimbCaus);

    //Eredito selezione anagrafe
    C700SelAnagrafe.Close;
    EreditaSelezioneAnagrafica(SelezioneAnagrafica);

    //Leggo i dati inseriti dall'utente web e li setto su  A074FRiepilogoBuoni
    SettaDatiUtente(DatiUtente,A051FTimbOrig);

    //Inizializzo form
    A051FTimbOrig.BtnStampaClick(A051FTimbOrig.BtnStampa);
  finally
    A051FTimbOrig.Free;
    A051FTimbOrigDtM1.Free;
  end;
end;

procedure TBc28PrintServer.PrintA090(const SelezioneAnagrafica, FilePDF, Operatore, Azienda, DBServer, DatiUtente: WideString; var DettaglioLog: OleVariant);
begin
  //Inizializzo sessione
  AperturaSessione(DBServer,Azienda,Operatore);
  A090FAssenzeAnno:=TA090FAssenzeAnno.Create(nil);
  try
    A090FAssenzeAnnoDtM1:=TA090FAssenzeAnnoDtM1.Create(nil);
    A090FAssenzeAnno.DocumentoPDF:=IfThen(FilePDF <> '',FilePDF,'<VUOTO>');
    A090FAssenzeAnno.TipoModulo:='COM';
    A090FAssenzeAnno.FormShow(A090FAssenzeAnno);

    //Eredito selezione anagrafe
    C700SelAnagrafe.Close;
    EreditaSelezioneAnagrafica(SelezioneAnagrafica);

    //Leggo i dati inseriti dall'utente web e li setto su  A074FRiepilogoBuoni
    SettaDatiUtente(DatiUtente,A090FAssenzeAnno);

    //Inizializzo form
    A090FAssenzeAnno.edtDaAnnoChange(A090FAssenzeAnno.edtDaAnno);
    A090FAssenzeAnno.BtnPreViewClick(A090FAssenzeAnno.BtnStampa);
  finally
    A090FAssenzeAnno.Free;
    A090FAssenzeAnnoDtM1.Free;
  end;
end;

procedure TBc28PrintServer.PrintA116(const SelezioneAnagrafica, FilePDF, Operatore, Azienda, DBServer, DatiUtente: WideString; var DettaglioLog: OleVariant);
begin
  //Inizializzo sessione
  AperturaSessione(DBServer,Azienda,Operatore);
  A116FLiquidazioneOreAnniPrec:=TA116FLiquidazioneOreAnniPrec.Create(nil);
  try
    A116FLiquidazioneOreAnniPrec.A116MW.DocumentoPDF:=IfThen(FilePDF <> '',FilePDF,'<VUOTO>');
    A116FLiquidazioneOreAnniPrec.A116MW.TipoModulo:='COM';
    A116FLiquidazioneOreAnniPrec.FormShow(A116FLiquidazioneOreAnniPrec);

    //Eredito selezione anagrafe
    C700SelAnagrafe.Close;
    EreditaSelezioneAnagrafica(SelezioneAnagrafica);

    //Leggo i dati inseriti dall'utente web e li setto su  A116FLiquidazioneOreAnniPrec
    SettaDatiUtente(DatiUtente,A116FLiquidazioneOreAnniPrec);

    //Inizializzo form
    with A116FLiquidazioneOreAnniPrec do
    begin
      //Creo File stampa
      if SoloAgg = 'S' then
        BtnStampaClick(btnEffettuaLiq)
      else
        BtnStampaClick(BtnPreView);
    end;
    if RegistraMsg.ContieneTipoA or RegistraMsg.ContieneTipoB then
      DettaglioLog:=IntToStr(RegistraMsg.ID);
  finally
    A116FLiquidazioneOreAnniPrec.Free;
  end;
end;

procedure TBc28PrintServer.PrintA077(const SelezioneAnagrafica, FilePDF, Operatore, Azienda, DBServer, DatiUtente: WideString; var DettaglioLog: OleVariant);
begin
  //Inizializzo sessione
  AperturaSessione(DBServer,Azienda,Operatore);
  A077FGeneratoreStampe:=TA077FGeneratoreStampe.Create(nil);
  try
    A077FGeneratoreStampeDtM:=TA077FGeneratoreStampeDtM.Create(nil);
    A077FGeneratoreStampe.TipoModulo:='COM';
    A077FGeneratoreStampe.FormShow(A077FGeneratoreStampe);
    A077FGeneratoreStampe.DocumentoPDF:=IfThen(FilePDF <> '',FilePDF,'<VUOTO>');
    A077FGeneratoreStampe.DropTabelleTemp:=True;
    //Eredito selezione anagrafe
    C700SelAnagrafe.Close;
    EreditaSelezioneAnagrafica(SelezioneAnagrafica);
    //Leggo i dati inseriti dall'utente web e li setto su  A077FGeneratoreStampe
    SettaDatiUtente(DatiUtente,A077FGeneratoreStampe);
    //Inizializzo form
    if FilePDF <> '' then
      A077FGeneratoreStampe.btnAnteprimaClick(A077FGeneratoreStampe)
    else if A077FGeneratoreStampeDtM.Q910.FieldByName('TABELLA_GENERATA').AsString <> '' then
      A077FGeneratoreStampe.btnAnteprimaClick(A077FGeneratoreStampe.btnTabella);
    DettaglioLog:=StringReplace(A077FGeneratoreStampe.TestoLog,'<NUM_PAG>',IntToStr(A077FStampa.QRep.PageNumber),[rfReplaceAll]);
    if (DettaglioLog = '') and (FilePDF = '') and (A077FGeneratoreStampeDtM.Q910.FieldByName('TABELLA_GENERATA').AsString <> '')  then
      DettaglioLog:='Dati registrati sulla tabella T920' + A077FGeneratoreStampe.TabellaStampa;
  finally
    A077FGeneratoreStampeDtM.Free;
    A077FGeneratoreStampe.Free;
  end;
end;

procedure TBc28PrintServer.PrintA059(const FilePDF, Operatore, Azienda, DBServer, DatiUtente: WideString; var DettaglioLog: OleVariant);
begin
  //Inizializzo sessione
  AperturaSessione(DBServer,Azienda,Operatore);
  A059FContSquadre:=TA059FContSquadre.Create(nil);
  try
    A059FContSquadreDtM1:=TA059FContSquadreDtM1.Create(nil);
    A059FContSquadre.TipoModulo:='COM';
    A059FContSquadre.FormShow(A059FContSquadre);
    A059FContSquadre.DocumentoPDF:=IfThen(FilePDF <> '',FilePDF,'<VUOTO>');
    //Leggo i dati inseriti dall'utente web e li setto su  A059FContSquadre
    SettaDatiUtente(DatiUtente,A059FContSquadre);
    //Richiamo anteprima stampa
    A059FContSquadre.BitBtn1Click(A059FContSquadre.BitBtn4);
  finally
    A059FContSquadreDtM1.Free;
    A059FContSquadre.Free;
  end;
end;

procedure TBc28PrintServer.PrintA068(const SelezioneAnagrafica, FilePDF, Operatore, Azienda, DBServer, DatiUtente: WideString; var DettaglioLog: OleVariant);
begin
  //Inizializzo sessione
  AperturaSessione(DBServer,Azienda,Operatore);
  A068FTurniGior:=TA068FTurniGior.Create(nil);
  try
    A068FTurniGiorDtM1:=TA068FTurniGiorDtM1.Create(nil);
    A068FTurniGior.TipoModulo:='COM';
    A068FTurniGior.FormShow(A068FTurniGior);
    A068FTurniGior.DocumentoPDF:=IfThen(FilePDF <> '',FilePDF,'<VUOTO>');
    //Eredito selezione anagrafe
    C700SelAnagrafe.Close;
    EreditaSelezioneAnagrafica(SelezioneAnagrafica);
    //Leggo i dati inseriti dall'utente web e li setto su  A059FContSquadre
    SettaDatiUtente(DatiUtente,A068FTurniGior);
    //Richiamo anteprima stampa
    A068FTurniGior.Label1.Caption:=FormatDateTime('dd mmmm yyyy',A068FTurniGior.Data);
    A068FTurniGior.BitBtn3Click(A068FTurniGior.BitBtn3);
  finally
    A068FTurniGiorDtM1.Free;
    A068FTurniGior.Free;
  end;
end;

procedure TBc28PrintServer.PrintA058(const SelezioneAnagrafica, FilePDF, Operatore, Azienda, DBServer, DatiUtente: WideString; var DettaglioLog: OleVariant);
begin
  //Inizializzo sessione
  AperturaSessione(DBServer,Azienda,Operatore);
  A058FPianifTurni:=TA058FPianifTurni.Create(nil);
  try
    A058FPianifTurniDtM1:=TA058FPianifTurniDtM1.Create(nil);
    A058FPianifTurni.TipoModulo:='COM';
    A058FPianifTurni.DocumentoPDF:=IfThen(FilePDF <> '',FilePDF,'<VUOTO>');
    A058FPianifTurni.FormShow(A058FPianifTurni);
    //Eredito selezione anagrafe
    C700SelAnagrafe.Close;
    EreditaSelezioneAnagrafica(SelezioneAnagrafica);
    //Leggo i dati inseriti dall'utente web e li setto su  A058FPianifTurni
    SettaDatiUtente(DatiUtente,A058FPianifTurni);
    //Richiamo anteprima stampa
    A058FPianifTurniDtM1.DataInizio:=StrToDateTime(A058FPianifTurni.edtDataDa.Text);
    A058FPianifTurniDtM1.DataFine:=StrToDateTime(A058FPianifTurni.edtDataA.Text);
    A058FPianifTurni.BEseguiClick(A058FPianifTurni.btnAnteprima);
  finally
    A058FPianifTurniDtM1.Free;
    A058FPianifTurni.Free;
  end;
end;

procedure TBc28PrintServer.PrintA105(const SelezioneAnagrafica, FilePDF, Operatore, Azienda, DBServer, DatiUtente: WideString; var DettaglioLog: OleVariant);
begin
  //Inizializzo sessione
  AperturaSessione(DBServer,Azienda,Operatore);
  A105FStoricoGiustificativi:=TA105FStoricoGiustificativi.Create(nil);
  try
    A105FStoricoGiustificativi.A105MW.DocumentoPDF:=IfThen(FilePDF <> '',FilePDF,'<VUOTO>');
    A105FStoricoGiustificativi.A105MW.TipoModulo:='COM';
    A105FStoricoGiustificativi.FormShow(A105FStoricoGiustificativi);
    //Eredito selezione anagrafe
    C700SelAnagrafe.Close;
    EreditaSelezioneAnagrafica(SelezioneAnagrafica);
    //Leggo i dati inseriti dall'utente web e li setto su  A105FStoricoGiustificativi
    SettaDatiUtente(DatiUtente,A105FStoricoGiustificativi);
    //Richiamo anteprima stampa
    A105FStoricoGiustificativi.BtnPreViewClick(A105FStoricoGiustificativi.BtnPreView);
  finally
    A105FStoricoGiustificativi.Free;
  end;
end;

procedure TBc28PrintServer.SettaDatiUtente(DatiUtente: WideString; Form:TForm);
var i,j,k:Integer;
    json: TJSONObject;
    jPairGiust: TJSONPair;
begin
  try
    json:=TJSONObject.ParseJSONValue(TEncoding.ASCII.GetBytes(DatiUtente),0) as TJSONObject;
    with Form do
      for i:=0 to json.Size - 1 do
      begin
        jPairGiust:=TJSONPair(json.Get(i));
        //Casi eccezionali da gestire sulle singole classi
        //A042
        if (Form is TA042FDialogStampa) and (jPairGiust.JsonString.Value = 'LstIntestazione') then
          R180PutCheckList(jPairGiust.JsonValue.Value,40,(Form as TA042FDialogStampa).chkLIntestazione)
        else if (Form is TA042FDialogStampa) and (jPairGiust.JsonString.Value = 'LstDettaglio') then
          R180PutCheckList(jPairGiust.JsonValue.Value,40,(Form as TA042FDialogStampa).chkLDettaglio)
        else if (Form is TA042FDialogStampa) and (jPairGiust.JsonString.Value = 'chkVisLineeV') then
          (Form as TA042FDialogStampa).VisualizzaVLine:=jPairGiust.JSONValue.Value = 'S'
        else if (Form is TA042FDialogStampa) and (jPairGiust.JsonString.Value = 'chkVisLineeH') then
          (Form as TA042FDialogStampa).VisualizzaHLine:=jPairGiust.JSONValue.Value = 'S'
        else if (Form is TA042FDialogStampa) and (jPairGiust.JsonString.Value = 'edtTitoloGrafico') then
          (Form as TA042FDialogStampa).TitoloGrafico:=jPairGiust.JSONValue.Value
        //A043
        else if (Form is TA043FDialogStampa) and (jPairGiust.JsonString.Value = 'SoloAgg') then
          (Form as TA043FDialogStampa).SoloAgg:=jPairGiust.JsonValue.Value
        else if (Form is TA043FDialogStampa) and (jPairGiust.JsonString.Value = 'edtDataDa') then
          (Form as TA043FDialogStampa).frmInputPeriodo.edtInizio.Text:=jPairGiust.JsonValue.Value
        else if (Form is TA043FDialogStampa) and (jPairGiust.JsonString.Value = 'edtDataA') then
          (Form as TA043FDialogStampa).frmInputPeriodo.edtFine.Text:=jPairGiust.JsonValue.Value
        //A045
        else if (Form is TA045FDialogStampa) and (jPairGiust.JsonString.Value = 'LstListaCausali') then
          R180PutCheckList(jPairGiust.JsonValue.Value,6,(Form as TA045FDialogStampa).LstListaCausali)
        else if (Form is TA045FDialogStampa) and (jPairGiust.JsonString.Value = 'LstListaTipiRapporto') then
          R180PutCheckList(jPairGiust.JsonValue.Value,6,(Form as TA045FDialogStampa).LstListaTipiRapporto)
        //A051
        else if  (Form is TA051FTimbOrig) and (jPairGiust.JsonString.Value = 'cmbMese') then
          (Form as TA051FTimbOrig).cmbMese.ItemIndex:=StrToInt(jPairGiust.JsonValue.Value) // necessario perchè tra web e win qua gli itemindex sono disallineati
        //A059
        else if  (Form is TA059FContSquadre) and (jPairGiust.JsonString.Value = 'edtDaData') then
          (Form as TA059FContSquadre).DataInizio:=StrToDateTime(jPairGiust.JsonValue.Value)
        else if  (Form is TA059FContSquadre) and (jPairGiust.JsonString.Value = 'edtAData') then
          (Form as TA059FContSquadre).DataFine:=StrToDateTime(jPairGiust.JsonValue.Value)
        //A061
        else if (Form is TA061FDettAssenze) and (jPairGiust.JsonString.Value = 'LstCausali') then
          R180PutCheckList(jPairGiust.JsonValue.Value,6,(Form as TA061FDettAssenze).LstCausali)
        //A047
        else if (Form is TA047FDialogStampa) and (jPairGiust.JsonString.Value = 'LstOrologi') then
          R180PutCheckList(jPairGiust.JsonValue.Value,2,(Form as TA047FDialogStampa).cbxOrologi)
        else if (Form is TA061FDettAssenze) and (jPairGiust.JsonString.Value = 'LstCodAcc') then
          R180PutCheckList(jPairGiust.JsonValue.Value,6,(Form as TA061FDettAssenze).LstCodAcc)
        //A068
        else if  (Form is TA068FTurniGior) and (jPairGiust.JsonString.Value = 'edtData') then
          (Form as TA068FTurniGior).Data:=StrToDateTime(jPairGiust.JsonValue.Value)
        //A074
        else if (Form is TA074FRiepilogoBuoni) and (jPairGiust.JsonString.Value = 'edtPwdFileSequenziale') then
          (Form as TA074FRiepilogoBuoni).FsPassword:=jPairGiust.JsonValue.Value
        else if (Form is TA074FRiepilogoBuoni) and (jPairGiust.JsonString.Value = 'ActiveTab') then
          (Form as TA074FRiepilogoBuoni).PageControl1.ActivePageIndex:=StrToInt(jPairGiust.JsonValue.Value)
        else if (Form is TA074FRiepilogoBuoni) and (jPairGiust.JsonString.Value = 'edtDa') then
          (Form as TA074FRiepilogoBuoni).DataI:=StrToDate(jPairGiust.JsonValue.Value)
        else if (Form is TA074FRiepilogoBuoni) and (jPairGiust.JsonString.Value = 'edtA') then
          (Form as TA074FRiepilogoBuoni).DataF:=StrToDate(jPairGiust.JsonValue.Value)
        //A077
        else if (Form is TA077FGeneratoreStampe) and (jPairGiust.JsonString.Value = 'edtDal') then
          (Form as TA077FGeneratoreStampe).frmInputPeriodo.edtInizio.Text:=jPairGiust.JsonValue.Value
        else if (Form is TA077FGeneratoreStampe) and (jPairGiust.JsonString.Value = 'edtAl') then
          (Form as TA077FGeneratoreStampe).frmInputPeriodo.edtFine.Text:=jPairGiust.JsonValue.Value
        else if (Form is TA077FGeneratoreStampe) and (jPairGiust.JsonString.Value = 'CodiceStampa') then
          A077FGeneratoreStampeDtM.Q910.SearchRecord('CODICE',jPairGiust.JsonValue.Value,[srFromBeginning])
        //A081
        else if (Form is TA081FTimbCaus) and (jPairGiust.JsonString.Value = 'CgpListaCausali') then
          R180PutCheckList(jPairGiust.JsonValue.Value,5,(Form as TA081FTimbCaus).CgpListaCausali)
        else if (Form is TA081FTimbCaus) and (jPairGiust.JsonString.Value = 'edtDaData') then
          (Form as TA081FTimbCaus).DaData:=StrToDateTime(jPairGiust.JsonValue.Value)
        else if (Form is TA081FTimbCaus) and (jPairGiust.JsonString.Value = 'edtAData') then
          (Form as TA081FTimbCaus).AData:=StrToDateTime(jPairGiust.JsonValue.Value)
        //A090
        else if (Form is TA090FAssenzeAnno) and (jPairGiust.JsonString.Value = 'CgpListaAnagr') then
          R180PutCheckList(jPairGiust.JsonValue.Value,50,(Form as TA090FAssenzeAnno).ListaAnagra)
        else if (Form is TA090FAssenzeAnno) and (jPairGiust.JsonString.Value = 'CgpListaCausali') then
          R180PutCheckList(jPairGiust.JsonValue.Value,5,(Form as TA090FAssenzeAnno).ListaCausali)
        //A092
        else if (Form is TA092FStampaStorico) and (jPairGiust.JsonString.Value = 'CgpAnagra') then
          R180PutCheckList(jPairGiust.JsonValue.Value,40,(Form as TA092FStampaStorico).ListaAnagra)
        else if (Form is TA092FStampaStorico) and (jPairGiust.JsonString.Value = 'edtDaData') then
          (Form as TA092FStampaStorico).DaData:=StrToDateTime(jPairGiust.JsonValue.Value)
        else if (Form is TA092FStampaStorico) and (jPairGiust.JsonString.Value = 'edtAData') then
          (Form as TA092FStampaStorico).AData:=StrToDateTime(jPairGiust.JsonValue.Value)
        //A105
        else if  (Form is TA105FStoricoGiustificativi) and (jPairGiust.JsonString.Value = 'StatoPaghe') then
          (Form as TA105FStoricoGiustificativi).A105MW.StatoPaghe:=jPairGiust.JsonValue.Value
        else if (Form is TA105FStoricoGiustificativi) and (jPairGiust.JsonString.Value = 'clbCausali') then
          R180PutCheckList(jPairGiust.JsonValue.Value,5,(Form as TA105FStoricoGiustificativi).clbCausali)
        //A116
        else if  (Form is TA116FLiquidazioneOreAnniPrec) and (jPairGiust.JsonString.Value = 'SoloAgg') then
          (Form as TA116FLiquidazioneOreAnniPrec).SoloAgg:=jPairGiust.JsonValue.Value
        else if (Form is TA116FLiquidazioneOreAnniPrec) and (jPairGiust.JsonString.Value = 'cgpIntestazione') then
          R180PutCheckList(jPairGiust.JsonValue.Value,99,(Form as TA116FLiquidazioneOreAnniPrec).clbIntestazione)
        else if (Form is TA116FLiquidazioneOreAnniPrec) and (jPairGiust.JsonString.Value = 'cgpDettaglio') then
          R180PutCheckList(jPairGiust.JsonValue.Value,99,(Form as TA116FLiquidazioneOreAnniPrec).clbDettaglio)
        //A167
        else if (Form is TA167FRegistraIncentivi) and (jPairGiust.JsonString.Value = 'edtAData') then
        begin
          (Form as TA167FRegistraIncentivi).edtAData.Text:=jPairGiust.JsonValue.Value;
          (Form as TA167FRegistraIncentivi).ImpostaDataQuote;
          (Form as TA167FRegistraIncentivi).CaricaComboTipoCalcolo;
        end
        else if (Form is TA167FRegistraIncentivi) and (jPairGiust.JsonString.Value = 'cmbTipoCalcolo') then
        begin
          //la combo deve già essere caricata, ovvero edtAData settato prima di cmbTipoCalcolo
          with (Form as TA167FRegistraIncentivi) do
          begin
            for j:=0 to cmbTipoCalcolo.Items.Count - 1 do
              if Copy(cmbTipoCalcolo.Items[j],1,1) = jPairGiust.JsonValue.Value then
                cmbTipoCalcolo.ItemIndex:=j;
            (Form as TA167FRegistraIncentivi).CambiaCalcolo;
          end;
        end
        else if (Form is TA167FRegistraIncentivi) and (jPairGiust.JsonString.Value = 'cmbCampoAnag') then
          (Form as TA167FRegistraIncentivi).dcmbCampoAnag.KeyValue:=jPairGiust.JsonValue.Value
        else if (Form is TA167FRegistraIncentivi) and (jPairGiust.JsonString.Value = 'cgpColonne') then
        begin
          R180PutCheckList(jPairGiust.JsonValue.Value,99,(Form as TA167FRegistraIncentivi).chkColonne);
          (Form as TA167FRegistraIncentivi).chkColonneClickCheck(nil);
        end
        else if  (Form is TA167FRegistraIncentivi) and (jPairGiust.JsonString.Value = 'SoloAgg') then
          (Form as TA167FRegistraIncentivi).SoloAgg:=jPairGiust.JsonValue.Value
        else if  (Form is TA145FComunicazioneVisiteFiscali) and (jPairGiust.JsonString.Value = 'cmbMedicineLegali') then
          (Form as TA145FComunicazioneVisiteFiscali).dcmbMedicineLegali.KeyValue:=jPairGiust.JsonValue.Value
        else if  (Form is TA145FComunicazioneVisiteFiscali) and (jPairGiust.JsonString.Value = 'lstElementiDettaglio') then
          (Form as TA145FComunicazioneVisiteFiscali).lstElementiDettaglioCOM.CommaText:=jPairGiust.JsonValue.Value
        else if  (Form is TS715FDialogStampa) and (jPairGiust.JsonString.Value = 'ListaTipologieQuote') then
          (Form as TS715FDialogStampa).ListaTipologieQuote:=jPairGiust.JsonValue.Value
        //Ac04
        else if (Form is TAc04FStampaRendiProj) and (jPairGiust.JsonString.Value = 'clbProgetti') then
        begin
          for k:=0 to Ac04FStampaRendiProj.clbProgetti.Items.Count - 1 do
            Ac04FStampaRendiProj.clbProgetti.Checked[k]:=False;
          Ac04FStampaRendiProjDM.Ac04FStampaRendiProjMW.ListaProjSel:=jPairGiust.JsonValue.Value;
          Ac04FStampaRendiProj.SelezionaProj;
        end
        //Se il componente non è gestito tra i casi particolari allora provo ad abbinarlo automaticamente
        else if FindComponent(jPairGiust.JsonString.Value) <> nil then
          R180JsonString2Comp(FindComponent(jPairGiust.JsonString.Value),jPairGiust)
        else
          raise Exception.Create('Componente inesistente: ' + jPairGiust.JsonString.Value);
      end;
  finally
    json.Free;
  end;
end;

procedure TBc28PrintServer.AperturaSessione(DBServer,Azienda, Operatore: String);
begin
  //Login al DB e recupero dati aziendali
  with TA001FPasswordDtM1.Create(nil) do
  try
    InizializzazioneSessione(DBServer);
    QI090.Close;
    QI090.SetVariable('Azienda',Azienda);
    QI090.Open;
    QI060.Close;
    QI060.SetVariable('Azienda',Azienda);
    QI060.SetVariable('Utente',Operatore);
    QI060.Open;
    QI070.Close;
    QI070.SetVariable('Azienda',Azienda);
    QI070.SetVariable('Utente',Operatore);
    QI070.Open;
    if (QI060.RecordCount > 0) or (QI070.RecordCount = 0) then
    begin
      QI070.Close;
      QI070.SetVariable('Azienda',Azienda);
      QI070.SetVariable('Utente','SYSMAN');
      QI070.Open;
    end;
    RegistraInibizioni;
    Parametri.Database:=DBServer;
  finally
    Free;
  end;
  SessioneOracle.LogonDataBase:=DBServer;
  try
    A000ParamDBOracle(SessioneOracle);
    RegistraMsg.IniziaMessaggio('Bc28');
  except
    on E:Exception do
      R180ScriviMsgLog('Bc28PPrintServer.log',E.Message);
  end;
  Parametri.Operatore:=Operatore;
end;

procedure TBc28PrintServer.EreditaSelezioneAnagrafica(SelezioneAnagrafica: String);
var
  S: String;
  pS,pF,pO: Integer;
begin
  S:=SelezioneAnagrafica;
  //Massimo 21/11/2013 --ini - modifica per IrisWeb
  if S.IndexOf(':DATADAL') <> -1 then
    S:=ReplaceStr(S,':DATADAL',':C700DATADAL');
  if S.IndexOf(':C700DATADAL') <> -1 then
  begin
    C700SelAnagrafe.DeclareVariable('C700DATADAL',otDate);
    C700SelAnagrafe.SetVariable('C700DATADAL',C700DataDal);
  end;
  //Massimo 21/11/2013 --fine
  RegistraMsg.InserisciMessaggio('I','Selezione iniziale: ' + S);
  pF:=R180CercaParolaIntera('FROM',UpperCase(S),'.,;');
  pS:=R180CercaParolaIntera('SELECT',UpperCase(S),'.,;');
  if (pF > 0) and (pS > 0) then
  begin
    pS:=pS + 7; // 'SELECT '
    C700DatiSelezionati:=Copy(S,pS,pF - pS - 1);
    C700DatiSelezionati:=StringReplace(C700DatiSelezionati,',V430.',',',[rfReplaceAll,rfIgnoreCase]);
    Delete(S,pS,pF - pS);
    C700DatiSelezionati:=C700CompletaDatiSelezionati;
    Insert(C700DatiSelezionati + ' ',S,pS);
  end
  else
    RegistraMsg.InserisciMessaggio('A','Selezione anagrafica errata: ' + S);
  RegistraMsg.InserisciMessaggio('I','Selezione finale: ' + S);
  C700SelAnagrafe.SQL.Text:=S;
  pF:=R180CercaParolaIntera('FROM',UpperCase(S),'.,;');
  if pF > 0 then
    S:=Trim(Copy(S,pF + 4,Length(S)));
  pO:=R180CercaParolaIntera('ORDER BY',UpperCase(S),'.,;');
  if pO > 0 then
    S:=Trim(Copy(S,1,pO - 1));
  C700FSelezioneAnagrafe.CorpoSQL.Text:=S;
end;

procedure TBc28PrintServer.PrintA104(const SelezioneAnagrafica, FilePDF, Operatore,
          Azienda, DBServer, DatiUtente: WideString; var DettaglioLog: OleVariant);

begin
  //Inizializzo sessione
  AperturaSessione(DBServer,Azienda,Operatore);
  A104FDialogStampa:=TA104FDialogStampa.Create(nil);
  try
    A104FStampaMissioniDtM1:=TA104FStampaMissioniDtM1.Create(nil);
    A104FDialogStampa.DocumentoPDF:=IfThen(FilePDF <> '',FilePDF,'<VUOTO>');
    A104FDialogStampa.TipoModulo:='COM';
    A104FDialogStampa.FormShow(nil);

    //Eredito selezione anagrafe
    C700SelAnagrafe.Close;
    EreditaSelezioneAnagrafica(SelezioneAnagrafica);

    //Leggo i dati inseriti dall'utente web e li setto su  A074FRiepilogoBuoni
    SettaDatiUtente(DatiUtente,A104FDialogStampa);

    //Inizializzo form
    A104FDialogStampa.BtnStampaClick(A104FDialogStampa.BtnStampa);
  finally
    A104FDialogStampa.Free;
    A104FStampaMissioniDtM1.Free;
  end;
end;
procedure TBc28PrintServer.PrintA047(const SelezioneAnagrafica, FilePDF, Operatore,
          Azienda, DBServer, DatiUtente: WideString; var DettaglioLog: OleVariant);

begin
  //Inizializzo sessione
  AperturaSessione(DBServer,Azienda,Operatore);
  A047FTimbMensa:=TA047FTimbMensa.Create(nil);
  try
    A047FTimbMensaDtM1:=TA047FTimbMensaDtM1.Create(nil);
    A047FTimbMensa.FormShow(nil);

    A047FDialogStampa.TipoModulo:='COM';
    A047FDialogStampa.DocumentoPDF:=IfThen(FilePDF <> '',FilePDF,'<VUOTO>');

    A047FTimbMensa.frmSelAnagrafe.OnCambiaProgressivo:=nil;
    A047FDialogStampa.FormShow(A058FPianifTurni);

    //Eredito selezione anagrafe
    C700SelAnagrafe.Close;
    EreditaSelezioneAnagrafica(SelezioneAnagrafica);
    //Leggo i dati inseriti dall'utente web e li setto su  A058FPianifTurni
    SettaDatiUtente(DatiUtente,A047FDialogStampa);
    //Richiamo anteprima stampa
    A047FDialogStampa.DataI:=StrToDateTime(A047FDialogStampa.eDaData.Text);
    A047FDialogStampa.DataF:=StrToDateTime(A047FDialogStampa.eAData.Text);
    A047FDialogStampa.BtnStampaClick(A047FDialogStampa.btnStampa);
  finally
    A047FTimbMensaDtM1.Free;
    A047FTimbMensa.Free;
  end;
end;

procedure TBc28PrintServer.PrintA167(const SelezioneAnagrafica, FilePDF, Operatore,
          Azienda, DBServer, DatiUtente: WideString; var DettaglioLog: OleVariant);

begin
  //Inizializzo sessione
  AperturaSessione(DBServer,Azienda,Operatore);
  A167FRegistraIncentivi:=TA167FRegistraIncentivi.Create(nil);
  A167FRegistraIncentiviDtm:=TA167FRegistraIncentiviDtm.Create(nil);
  try
    A167FRegistraIncentivi.DocumentoPDF:=IfThen(FilePDF <> '',FilePDF,'<VUOTO>');
    A167FRegistraIncentivi.TipoModulo:='COM';
    A167FRegistraIncentivi.FormShow(A167FRegistraIncentivi);

    //Eredito selezione anagrafe
    C700SelAnagrafe.Close;
    EreditaSelezioneAnagrafica(SelezioneAnagrafica);
    C700SelAnagrafe.Open;

    //Leggo i dati inseriti dall'utente web e li setto su  A116FLiquidazioneOreAnniPrec
    SettaDatiUtente(DatiUtente,A167FRegistraIncentivi);
    //Inizializzo form
    with A167FRegistraIncentivi do
    begin
      //Creo File stampa
      if SoloAgg = 'S' then
        btnAggiornamentoClick(btnAggiornamento)
      else
        BtnAnteprimaClick(BtnStampa);
    end;

    if RegistraMsg.ContieneTipoA or RegistraMsg.ContieneTipoB then
      DettaglioLog:=IntToStr(RegistraMsg.ID);

  finally
    A167FRegistraIncentivi.close;
    A167FRegistraIncentivi.Free;
    A167FRegistraIncentiviDtm.Free;
  end;
end;

procedure TBc28PrintServer.PrintA145(const SelezioneAnagrafica, FilePDF, Operatore,
          Azienda, DBServer, DatiUtente: WideString; var DettaglioLog: OleVariant);

begin

  //Inizializzo sessione
  AperturaSessione(DBServer,Azienda,Operatore);
  A145FComunicazioneVisiteFiscali:=TA145FComunicazioneVisiteFiscali.Create(nil);
  A145FComunicazioneVisiteFiscaliDtm:=TA145FComunicazioneVisiteFiscaliDtm.Create(nil);
  try
    A145FComunicazioneVisiteFiscali.DocumentoPDF:=IfThen(FilePDF <> '',FilePDF,'<VUOTO>');
    A145FComunicazioneVisiteFiscali.TipoModulo:='COM';
    A145FComunicazioneVisiteFiscali.FormShow(A145FComunicazioneVisiteFiscali);

    //Eredito selezione anagrafe
    C700SelAnagrafe.Close;
    EreditaSelezioneAnagrafica(SelezioneAnagrafica);
    C700SelAnagrafe.Open;

    SettaDatiUtente(DatiUtente,A145FComunicazioneVisiteFiscali);
    //Inizializzo form
    with A145FComunicazioneVisiteFiscali do
    begin
      if FilePDF = ''then
      begin
        btnEseguiClick(btnEsegui);
        DettaglioLog:=MessaggioDCOM;
      end
      else
      begin
        btnStampaClick(btnStampa);
        DettaglioLog:=MessaggioDCOM;
      end;
    end;
  finally
    A145FComunicazioneVisiteFiscali.close;
    A145FComunicazioneVisiteFiscali.Free;
    A145FComunicazioneVisiteFiscaliDtm.Free;
  end;
end;

procedure TBc28PrintServer.PrintS715(const SelezioneAnagrafica, FilePDF, Operatore,
          Azienda, DBServer, DatiUtente: WideString; var DettaglioLog, MessaggioAggiuntivo: OleVariant);

begin
  //Inizializzo sessione
  AperturaSessione(DBServer,Azienda,Operatore);
  S715FDialogStampa:=TS715FDialogStampa.Create(nil);
  S715FStampaValutazioniDtm:=TS715FStampaValutazioniDtm.Create(nil);
  try
    S715FDialogStampa.DocumentoPDF:=IfThen(FilePDF <> '',FilePDF,'<VUOTO>');
    S715FDialogStampa.TipoModulo:='COM';
    S715FDialogStampa.FormShow(S715FDialogStampa);

    //Eredito selezione anagrafe
    C700SelAnagrafe.Close;
    EreditaSelezioneAnagrafica(SelezioneAnagrafica);
    C700SelAnagrafe.Open;
    SettaDatiUtente(DatiUtente,S715FDialogStampa);

    S715FDialogStampa.AbilitaComponenti;
    //Forza settaggio variabili
    S715FDialogStampa.edtDataDaExit(S715FDialogStampa.edtDataDa);
    S715FDialogStampa.edtDataAExit(S715FDialogStampa.edtDataA);

    S715FDialogStampa.btnEseguiClick(S715FDialogStampa.btnEsegui);
    MessaggioAggiuntivo:=S715FDialogStampa.MessaggioDCOM;
    if RegistraMsg.ContieneTipoA or RegistraMsg.ContieneTipoB then
      DettaglioLog:=IntToStr(RegistraMsg.ID);
  finally
    S715FDialogStampa.Close;
    S715FDialogStampa.Free;
    S715FStampaValutazioniDtm.Free;
  end;
end;

procedure TBc28PrintServer.PrintAc04(const SelezioneAnagrafica, FilePDF, Operatore,
          Azienda, DBServer, DatiUtente: WideString; var DettaglioLog: OleVariant);
begin
  //Inizializzo sessione
  AperturaSessione(DBServer,Azienda,Operatore);
  Ac04FStampaRendiProj:=TAc04FStampaRendiProj.Create(nil);
  Ac04FStampaRendiProjDM:=TAc04FStampaRendiProjDM.Create(nil);
  try
    Ac04FStampaRendiProj.DocumentoPDF:=IfThen(FilePDF <> '',FilePDF,'<VUOTO>');
    Ac04FStampaRendiProj.TipoModulo:='COM';
    Ac04FStampaRendiProj.FormShow(Ac04FStampaRendiProj);

    //Eredito selezione anagrafe
    C700SelAnagrafe.Close;
    EreditaSelezioneAnagrafica(SelezioneAnagrafica);
    C700SelAnagrafe.Open;
    SettaDatiUtente(DatiUtente,Ac04FStampaRendiProj);//Per impostare le date

    //Forza settaggio variabili
    Ac04FStampaRendiProj.SEMeseChange(Ac04FStampaRendiProj.SEMese);//Per cercare i progetti in base alle date
    SettaDatiUtente(DatiUtente,Ac04FStampaRendiProj);//Per selezionare il progetto

    Ac04FStampaRendiProj.btnStampaClick(Ac04FStampaRendiProj.btnStampa);
    if RegistraMsg.ContieneTipoA or RegistraMsg.ContieneTipoB then
      DettaglioLog:=IntToStr(RegistraMsg.ID);
  finally
    Ac04FStampaRendiProj.Close;
    Ac04FStampaRendiProj.Free;
    Ac04FStampaRendiProjDM.Free;
  end;
end;

initialization
  TComponentFactory.Create(ComServer, TBc28PrintServer,
    Class_Bc28PrintServer, ciSingleInstance, tmSingle);
end.

