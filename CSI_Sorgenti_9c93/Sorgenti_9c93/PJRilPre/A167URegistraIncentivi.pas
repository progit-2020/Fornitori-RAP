unit A167URegistraIncentivi;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Mask, ExtCtrls, DBCtrls, Buttons, SelAnagrafe,
  C700USelezioneAnagrafe, A000USessione, A000UInterfaccia, A003UDataLavoroBis,
  ComCtrls, Oracle, OracleData, DB, C180FunzioniGenerali, QueryStorico, Math,
  C004UParamForm, StrUtils, R450, R600, CheckLst, DateUtils,
  DBClient, C001StampaLib, Printers, C013UCheckList, A083UMsgElaborazioni,
  Generics.Collections, A167URegistraIncentiviMW, QRPDFFilt, A000UMessaggi;

type
  TGiorniMese = record
    Data:TDateTime;
    GG:Real;
    QuotaGG:Real;
    SaltaProva,SospendiPT,SospendiQuote:String;
  end;

  TFondi = record
    CodTipoQuota,Dato1,Dato2,Dato3:String;
    Numeri:Real;
    FondoQuotaSaldo,SommaSaldiDett:Currency;//Il tipo Real crea problemi nei calcoli per via della precisione decimale
  end;

  TA167FRegistraIncentivi = class(TForm)
    frmSelAnagrafe: TfrmSelAnagrafe;
    Panel2: TPanel;
    lblMeseDal: TLabel;
    sbtDaData: TSpeedButton;
    lblMeseAl: TLabel;
    sbtAData: TSpeedButton;
    chkAggiorna: TCheckBox;
    edtDaData: TMaskEdit;
    edtAData: TMaskEdit;
    StatusBar: TStatusBar;
    ProgressBar1: TProgressBar;
    BtnClose: TBitBtn;
    btnAnomalie: TBitBtn;
    btnAggiornamento: TBitBtn;
    BtnStampa: TBitBtn;
    BtnAnteprima: TBitBtn;
    BtnPrinterSetUp: TBitBtn;
    PrinterSetupDialog1: TPrinterSetupDialog;
    gpbStampa: TGroupBox;
    chkColonne: TCheckListBox;
    dcmbCampoAnag: TDBLookupComboBox;
    Label3: TLabel;
    chkSaltoPagina: TCheckBox;
    chkDettaglio: TCheckBox;
    Label1: TLabel;
    rgpTipoDati: TRadioGroup;
    edtQuote: TEdit;
    btnQuote: TSpeedButton;
    lblQuote: TLabel;
    cmbTipoCalcolo: TComboBox;
    Label2: TLabel;
    chkAnnulla: TCheckBox;
    procedure btnAggiornamentoClick(Sender: TObject);
    procedure sbtDaDataClick(Sender: TObject);
    procedure sbtADataClick(Sender: TObject);
    procedure dcmbCampoAnagKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure frmSelAnagrafebtnSelezioneClick(Sender: TObject);
    procedure chkAggiornaClick(Sender: TObject);
    procedure BtnPrinterSetUpClick(Sender: TObject);
    procedure btnAnomalieClick(Sender: TObject);
    procedure edtADataDblClick(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure BtnAnteprimaClick(Sender: TObject);
    procedure chkColonneClickCheck(Sender: TObject);
    procedure dcmbCampoAnagCloseUp(Sender: TObject);
    procedure dcmbCampoAnagKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnQuoteClick(Sender: TObject);
    procedure edtADataExit(Sender: TObject);
    procedure cmbTipoCalcoloChange(Sender: TObject);
    procedure chkAnnullaClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    QuotaIntera,QuotaProporzionata,QuotaNetta,   //Incentivi
      GGIntera,GGProporzionata,GGNetta,
      GGPT,GGSenzaRegole,
      GGAssenza,QuotaAssenza,
      GGRisparmio,QuotaRisparmio,
      TotGGAssenza,TotQuotaAssenza,
      TotGGRisparmio,TotQuotaRisparmio,
      TotaleGG,TotaleQuota,TotaleIntera,
      AbbattimentoGS,AbbattimentoPT,AbbattimentoAS,
      MaxPenalizzazione,PercPenalizzazione,
      PercGGEff,
      PesoIndivid,PesoStrutt,ValutIndivid,ValutStrutt:Real;
    CodQuota,TipoQuota,TipoCalcolo,TipoQuoteQuant,ProporzioneIncentivi,ProporzionePT,ScaglioniGgEff,Dato1,Dato2,Dato3,RegDato1,RegDato2,RegDato3:String;
    QSIncentivi:TQueryStorico;
    DSIncentivi:TDipendenteInServizio;
    RegoleC,Decurta,MaturaIncentivi,InterrompiElaborazione,Anteprima,Cancella,AccontoValutativo:Boolean;
    DataI,DataF,MeseCorr,InizioProva,FineProva:TDateTime;
    DurataProva,TotMesiSaldoI:Integer;
    R450DtM1:TR450DtM1;
    R600DtM1:TR600DtM1;
    ElencoPT:TStringList;
    GiorniMese: array [1..31] of TGiorniMese;
    Fondi: array of TFondi;
    CodForm: String;
    procedure GetParametriFunzione;
    procedure PutParametriFunzione;
    procedure Controlli;
    procedure Azzeramento;
    procedure OperazioniIniziali(DataFine:TDateTime);
    procedure CancellaMese(Data:TDateTime);
    procedure RegistraMese(Data:TDateTime; Giorni,Quota:Real; TipoImporto:String);
    procedure RegistraAbbattimenti(Data:TDateTime; Quota:Real; TipoAbb:String);
    procedure CaricaTabellaAcconti(Giorni,Quota:Real; TipoImporto:String);
    procedure Proporzionamenti;
    procedure ElaboraAcconto(DataFine:TDateTime;Dal:TDateTime = 0;Al:TDateTime = 0);
    procedure ElaboraAssenzeGG(DataCorr,OldData,DataFine:TDateTime;OldCausale:String);
    procedure ElaboraSaldo;
    procedure ElaboraPenalizzazioni;
    procedure ElaboraRateizzazioni(Data:TDateTime);
    procedure ElaboraSaldoProporzionato(AData:TDateTime);
    procedure ElaboraQuotaQuantitativa(AData:TDateTime);
    procedure Arrotondamento(Data:TDateTime);
    procedure CreaTabellaAcconti;
    procedure CreaTabellaTipoD;
    procedure CaricaTabellaTipoD(DataReg:TDateTime);
    procedure ElaboraTabellaTipoD;
    procedure CreaTabellaStampa(DataSet:TClientDataset);
    procedure CaricaTabellaStampa(Data:TDateTime; Giorni,Quota:Real; TipoImporto:String);
    procedure TotalizzaTabellaStampa;
  public
    { Public declarations }
    Lung:Integer;
    Decimali:Real;
    lstColonne:TStringList;
    PeriodoProva:TPeriodoProva;
    TipoModulo:String; //CS=ClientServer, COM=COMServer
    DocumentoPDF:String;
    SoloAgg:String;//Usato per richiamo tramite B028
    procedure CaricaComboTipoCalcolo; //lasciare public; richiamata da B028
    procedure ImpostaDataQuote;       //lasciare public; richiamata da B028
    procedure CambiaCalcolo;          //lasciare public; richiamata da B028
  end;

var
  A167FRegistraIncentivi: TA167FRegistraIncentivi;

  procedure OpenA167RegistraIncentivi(Prog:LongInt);

implementation

uses A167URegistraIncentiviDtM, A167UStampaIncentivi;

{$R *.dfm}

procedure OpenA167RegistraIncentivi(Prog:LongInt);
begin
  SolaLetturaOriginale:=SolaLettura;
  SolaLettura:=False;
  case A000GetInibizioni('Funzione','OpenA167RegistraIncentivi') of
    'N':begin
        ShowMessage('Funzione non abilitata!');
        Exit;
        end;
    'R':SolaLettura:=True;
  end;
  A167FRegistraIncentivi:=TA167FRegistraIncentivi.Create(nil);
  with A167FRegistraIncentivi do
    try
      C700Progressivo:=Prog;
      A167FRegistraIncentiviDtM:=TA167FRegistraIncentiviDtM.Create(nil);
      ShowModal;
    finally
      SolaLettura:=SolaLetturaOriginale;
      A167FRegistraIncentiviDtM.Free;
      Free;
    end;
end;

procedure TA167FRegistraIncentivi.btnAggiornamentoClick(Sender: TObject);  //Aggiornamento incentivi su tabelle
var Cessaz,MeseApp,DApp:TDateTime;
  i:Integer;
  DatiStorici,s:String;
  Continua:Boolean;
  lstQuote:TStringList;
  TabellaTest:String;
begin
  Anteprima:=(Sender = btnAnteprima) or (Sender = btnStampa);
  Controlli;
  //Se si tratta di una cancellazione - chiedo ulteriore conferma
  if TipoModulo = 'CS' then
    if chkAnnulla.Checked then
      if R180MessageBox(Format(A000MSG_A167_MSG_FMT_CONFERMA_CANC,[edtQuote.Text,edtDaData.Text,edtAData.Text]),'DOMANDA') <> mrYes then
        Exit;
  QSIncentivi:=TQueryStorico.Create(nil);
  QSIncentivi.Session:=SessioneOracle;
  DSIncentivi:=TDipendenteInServizio.Create(nil);
  DSIncentivi.Session:=SessioneOracle;
  ElencoPT:=TStringList.Create;
  lstQuote:=TStringList.Create;

  if Trim(dcmbCampoAnag.Text) <> '' then
  begin
    S:=C700SelAnagrafe.SQL.Text;
    if R180InserisciColonna(S,VarToStr(dcmbCampoAnag.KeyValue)) then
    begin
      C700SelAnagrafe.Close;
      C700SelAnagrafe.SQL.Text:=S;
    end;
  end;
  if frmSelAnagrafe.SettaPeriodoSelAnagrafe(StrToDate('01/' + edtDaData.Text),R180FineMese(StrToDate('01/' + edtAData.Text))) then
    C700SelAnagrafe.Close;
  C700SelAnagrafe.Open;

  Screen.Cursor:=crHourGlass;
  A167FRegistraIncentivi.KeyPreview:=True;
  RegistraMsg.IniziaMessaggio(CodForm);
  btnAnomalie.Enabled:=False;
  lstQuote.Clear;
  if edtQuote.Visible then
    lstQuote.CommaText:=edtQuote.Text
  else
    lstQuote.Add('A#D');
  with A167FRegistraIncentiviDtM do
  begin
    CreaTabellaTipoD;
    SetLength(Fondi,0);
    //Ciclo sui dip. selezionati
    C700SelAnagrafe.First;
    StatusBar.Panels[1].Text:='Elaborazione in corso...premere Esc per interrompere';
    ProgressBar1.Position:=0;
    ProgressBar1.Max:=C700SelAnagrafe.RecordCount;
    while not C700SelAnagrafe.Eof do
    begin
      Application.ProcessMessages;
      if InterrompiElaborazione then
      begin
        InterrompiElaborazione:=False;
        Screen.Cursor:=crDefault;
        ProgressBar1.Position:=0;
        StatusBar.Panels[1].Text:='';
        raise exception.Create('Operazione interrotta dall''operatore.');
      end;
      frmSelAnagrafe.VisualizzaDipendente;
      ProgressBar1.StepBy(1);
      //Apertura dataset x aggiornamento
      selT762.Close;
      selT762.SetVariable('PROG',C700Progressivo);
      selT762.SetVariable('ANNO',R180Anno(StrToDate('01/' + edtAData.Text)));
      selT762.Open;
      selT762Risp.Close;
      selT762Risp.SetVariable('PROG',C700Progressivo);
      selT762Risp.SetVariable('ANNO',R180Anno(StrToDate('01/' + edtAData.Text)));
      selT762Risp.Open;
      selT763.Close;
      selT763.SetVariable('PROG',C700Progressivo);
      selT763.SetVariable('ANNO',R180Anno(StrToDate('01/' + edtAData.Text)));
      selT763.Open;
      //Ciclo sulle quote da elaborare
      for i:=0 to lstQuote.Count - 1 do
      begin
        CodQuota:=lstQuote.Strings[i];
        if TipoQuota = 'Q' then
          DataI:=R180FineMese(StrToDate('01/01/' + Copy(edtDaData.Text,4,4)))
        else
          DataI:=R180FineMese(StrToDate('01/' + edtDaData.Text));
        DataF:=R180FineMese(StrToDate('01/' + edtAData.Text));
        TotaleGG:=0;
        TotaleQuota:=0;
        TotaleIntera:=0;
        TotGGAssenza:=0;
        TotQuotaAssenza:=0;
        TotGGRisparmio:=0;
        TotQuotaRisparmio:=0;
        TotMesiSaldoI:=0;
        Continua:=True;
        Cancella:=True;
        //Se si tratta di una cancellazione - cancello il periodo e salto al dip.successivo
        if chkAnnulla.Checked then
        begin
          if TipoQuota = 'Q' then
            MeseCorr:=DataF
          else
            MeseCorr:=DataI;
          while MeseCorr <= DataF do
          begin
            CancellaMese(MeseCorr);
            MeseCorr:=R180FineMese(R180AddMesi(R180InizioMese(MeseCorr),1));
          end;
          Continua:=False;
        end;
        //Se il dip. non è in servizio nel periodo lo salto e passo al dip.successivo
        if not DSIncentivi.DipendenteInServizio(C700Progressivo,R180InizioMese(DataI),DataF) then
          Continua:=False;
        if TipoQuota = 'D' then
        begin
          //Controllo i periodi di rapporto lavorativo
          selT430Lav.Close;
          selT430Lav.SetVariable('PROGRESSIVO',C700Progressivo);
          selT430Lav.SetVariable('DAL',R180InizioMese(DataI));
          selT430Lav.SetVariable('AL',DataF);
          selT430Lav.Open;
          DApp:=R180InizioMese(DataI);
          while not selT430Lav.Eof do
          begin
            if selT430Lav.FieldByName('INI').AsDateTime < DApp then
            begin
              s:='Periodi di assunzione/cessazione incongruenti tra il ' + DateToStr(R180InizioMese(DataI)) + ' e il ' + DateToStr(DataF);
              RegistraMsg.InserisciMessaggio('A',s,'',C700SelAnagrafe.FieldByName('PROGRESSIVO').AsInteger);
              Continua:=False;
              Break;
            end;
            DApp:=selT430Lav.FieldByName('FIN').AsDateTime + 1;
            selT430Lav.Next;
          end;
        end;
        if Continua then
        begin
          //Leggo i dati storici che intersecano il periodo di elaborazione
          DatiStorici:='T430INIZIO,T430FINE,T430PARTTIME';
          if Parametri.CampiRiferimento.C6_DurataProva <> '' then
            DatiStorici:=DatiStorici + ',T430' + Parametri.CampiRiferimento.C6_DurataProva;
          if Parametri.CampiRiferimento.C6_InizioProva <> '' then
            DatiStorici:=DatiStorici + ',T430' + Parametri.CampiRiferimento.C6_InizioProva;
          if Parametri.CampiRiferimento.C7_Dato1 <> '' then
            DatiStorici:=DatiStorici + ',T430' + Parametri.CampiRiferimento.C7_Dato1;
          if Parametri.CampiRiferimento.C7_Dato2 <> '' then
            DatiStorici:=DatiStorici + ',T430' + Parametri.CampiRiferimento.C7_Dato2;
          if Parametri.CampiRiferimento.C7_Dato3 <> '' then
            DatiStorici:=DatiStorici + ',T430' + Parametri.CampiRiferimento.C7_Dato3;
          QSIncentivi.GetDatiStorici(DatiStorici,C700Progressivo,R180InizioMese(DataI),DataF);
          //Ciclo su ogni mese del periodo
          if R180In(TipoQuota,['D','Q']) then
            MeseCorr:=DataF
          else
            MeseCorr:=DataI;
          while MeseCorr <= DataF do
          begin
            Continua:=True;
            QSIncentivi.LocDatoStorico(MeseCorr); //Leggo i dati storici a fine mese
            //Se il dip. non è in servizio nel mese lo salto e passo al mese successivo
            if (not R180In(TipoQuota,['D','Q'])) and (not DSIncentivi.DipendenteInServizio(C700Progressivo,R180InizioMese(MeseCorr),MeseCorr)) then
              Continua:=False;
            if Continua and (not R180In(TipoQuota,['D','Q'])) and (not QSIncentivi.FieldByName('T430FINE').IsNull) and
               (QSIncentivi.FieldByName('T430FINE').AsDateTime < R180InizioMese(MeseCorr)) then
            begin  //Dip. in servizio ma con una cessazione anteriore a inizio periodo
              Continua:=False;
              s:='Periodi di assunzione/cessazione incongruenti al ' + DateToStr(MeseCorr);
              RegistraMsg.InserisciMessaggio('A',s,'',C700SelAnagrafe.FieldByName('PROGRESSIVO').AsInteger);
            end;
            AccontoValutativo:=False;
            Azzeramento;  //Azzeramento variabili
            if Parametri.CampiRiferimento.C7_Dato1 <> '' then
              Dato1:=QSIncentivi.FieldByName('T430' + Parametri.CampiRiferimento.C7_Dato1).AsString;
            if Parametri.CampiRiferimento.C7_Dato2 <> '' then
              Dato2:=QSIncentivi.FieldByName('T430' + Parametri.CampiRiferimento.C7_Dato2).AsString;
            if Parametri.CampiRiferimento.C7_Dato3 <> '' then
              Dato3:=QSIncentivi.FieldByName('T430' + Parametri.CampiRiferimento.C7_Dato3).AsString;
            Cessaz:=DataF;
            QSIncentivi.LocDatoStorico(DataF); //Leggo i dati storici a fine periodo
            if (not QSIncentivi.FieldByName('T430FINE').IsNull) and
               (R180FineMese(QSIncentivi.FieldByName('T430FINE').AsDateTime) >= DataI) and
               (R180FineMese(QSIncentivi.FieldByName('T430FINE').AsDateTime) <= DataF) then
              Cessaz:=R180FineMese(QSIncentivi.FieldByName('T430FINE').AsDateTime);
(*            if (TipoQuota = 'Q') and (not DSIncentivi.DipendenteInServizio(C700Progressivo,R180InizioMese(MeseCorr),MeseCorr)) then  //Lorena 08/10/2012
            begin
              s:='Dipendente non in servizio nel periodo (cessato al ' + DateToStr(Cessaz) + '). Le schede vengono riepilogate sul mese di cessazione.' + #$D#$A;
              s:=s + 'Attenzione: in caso di ri-elaborazione bisogna prima cancellare manualmente il riepilogo mensile e pulire l''assestamento della scheda riep.';
              RegistraMsg.InserisciMessaggio('A',s,'',C700SelAnagrafe.FieldByName('PROGRESSIVO').AsInteger);
            end;*)
            QSIncentivi.LocDatoStorico(MeseCorr); //Leggo i dati storici a fine mese
            //Elaborazione acconto per saldo valutativo
            if (TipoQuota = 'V') and Continua then
            begin
              AccontoValutativo:=False;
              OperazioniIniziali(Cessaz);
              Proporzionamenti;
              ElaboraAcconto(Cessaz);
              AccontoValutativo:=True;
              Azzeramento;
            end;
            if TipoQuota = 'D' then  //SALDO COLLETTIVO VALUTATIVO
            begin
              if chkAggiorna.Checked then
              begin
                MeseApp:=DataI;
                while MeseApp <= DataF do
                begin
                  CancellaMese(MeseApp);
                  MeseApp:=R180FineMese(R180AddMesi(R180InizioMese(MeseApp),1));
                end;
              end;
              CaricaTabellaTipoD(Cessaz);
            end
            else
            begin
              //Cancellazione record esistenti + Operazioni iniziali per calcolo QuotaIntera
              OperazioniIniziali(Cessaz);
              if (TipoQuota <> 'C' ) and (TipoQuota <> 'Q') and
                 (TipoQuota <> 'P') and (TipoQuota <> 'R') and
                 Continua and (QuotaIntera <> 0) then  //INCENTIVI
              begin
                Proporzionamenti;
                if (TipoQuota = 'S') or (TipoQuota = 'T') then
                  ElaboraSaldo;
                if (TipoQuota = 'A') or (TipoQuota = 'I') or (TipoQuota = 'V') then
                  ElaboraAcconto(Cessaz);
                if (TipoQuota = 'A') or (TipoQuota = 'S') then
                  Arrotondamento(MeseCorr);
              end
              else if (TipoQuota = 'C') and (QuotaIntera <> 0) then  //SALDO COLLETTIVO PROPORZIONATO
                ElaboraSaldoProporzionato(Cessaz)
              else if TipoQuota = 'P' then  //PENALIZZAZIONI
                ElaboraPenalizzazioni;
            end;
            MeseCorr:=R180FineMese(R180AddMesi(R180InizioMese(MeseCorr),1));
          end;
          //Verifico se il dipendente è cessato nel periodo
          //Registro le operazioni finali (i totali) sull'ultimo mese di servizio
          if TipoQuota = 'Q' then
            DataI:=R180FineMese(StrToDate('01/01/' + Copy(edtDaData.Text,4,4)))
          else
            DataI:=R180FineMese(StrToDate('01/' + edtDaData.Text));
          QSIncentivi.LocDatoStorico(DataF); //Leggo i dati storici a fine mese
          if (TipoQuota <> 'D') and
             (not QSIncentivi.FieldByName('T430FINE').IsNull) and
             (R180FineMese(QSIncentivi.FieldByName('T430FINE').AsDateTime) >= DataI) and
             (R180FineMese(QSIncentivi.FieldByName('T430FINE').AsDateTime) <= DataF) then
            DataF:=R180FineMese(QSIncentivi.FieldByName('T430FINE').AsDateTime);
          //Quando esco dal ciclo sul periodo elaboro i totali
          if (TipoQuota = 'C') or (TipoQuota = 'I') or (TipoQuota = 'V') then  //SALDI
            Arrotondamento(DataF);
          if (TipoQuota = 'T') and (TotaleQuota <> 0) then      //INCENTIVI
          begin
            if chkAggiorna.Checked then
            begin
              RegistraMese(DataF,365,TotaleIntera,'1');
              RegistraMese(DataF,TotaleGG,TotaleQuota,'2');
              RegistraMese(DataF,TotaleGG,TotaleQuota,'3');
            end;
            if Anteprima then
            begin
              CaricaTabellaStampa(DataF,365,TotaleIntera,'1');
              CaricaTabellaStampa(DataF,TotaleGG,TotaleQuota,'2');
              CaricaTabellaStampa(DataF,TotaleGG,TotaleQuota,'3');
            end;
          end;
          if TipoQuota = 'Q' then  //QUOTA QUANTITATIVA
          begin
            ElaboraQuotaQuantitativa(DataF);
            Arrotondamento(DataF);
          end;
          if TipoQuota = 'P' then  //PENALIZZAZIONI
          begin
            if Anteprima then
              CaricaTabellaStampa(DataF,TotaleGG,TotaleQuota,'-');
            if chkAggiorna.Checked then
            begin
              TipoCalcolo:='P';
              CancellaMese(DataF);
              if TotaleQuota <> 0 then
                RegistraMese(DataF,TotaleGG,TotaleQuota,'-');
              CodQuota:='_';
              CancellaMese(DataF);
              if TotaleQuota <> 0 then
                RegistraMese(DataF,TotaleGG,TotaleQuota,'3');
              Arrotondamento(DataF);
            end;
          end;
          if TipoQuota = 'R' then //RATEIZZAZIONI
            ElaboraRateizzazioni(DataF);
        end;
      end;
      C700SelAnagrafe.Next;
    end;
    ElaboraTabellaTipoD;
    (*SOLO_PER_TEST inizio*)
    if (TipoQuota = 'D') and (TabellaTipoD.RecordCount > 0) and chkAggiorna.Checked then
    begin
      TabellaTest:='T764_INC_DETTAGLIO_CALCOLO' (*+ '_' + FormatDateTime('yyyymmdd_hhnn',Now)*);
      CreaTabellaTest.Session:=SessioneOracle;
      CreaTabellaTest.Lines.Clear;
      CreaTabellaTest.Lines.Add('DROP TABLE ' + TabellaTest);
      CreaTabellaTest.Execute;
      CreaTabellaTest.Lines.Clear;
      CreaTabellaTest.Lines.Add('CREATE TABLE ' + TabellaTest +
                               ' (PROGRESSIVO NUMBER(8),' +
                               '  CODTIPOQUOTA VARCHAR2(5),' +
                               '  QUOTA_IND NUMBER,' +
                               '  DAL_SCHEDA DATE,' +
                               '  AL_SCHEDA DATE,' +
                               '  GIORNI_SCHEDA_TEORICI NUMBER,' +
                               '  GIORNI_SENZA_RAPPORTO NUMBER,' +
                               '  GIORNI_SCHEDA_EFFETTIVI NUMBER,' +
                               '  PERC_GIORNI_SCHEDA NUMBER,' +
                               '  GIORNI_ASSENZA NUMBER,' +
                               '  GIORNI_PRESENZA NUMBER,' +
                               '  PERC_GIORNI_PRESENZA NUMBER,' +
                               '  FASCIA_GIORNI_PRESENZA NUMBER,' +
                               '  INIZIO DATE,' +
                               '  FINE DATE,' +
                               '  GIORNI_LAVORATI NUMBER,' +
                               '  PERC_GIORNI_LAVORATI NUMBER,' +
                               '  DAL_DETTAGLIO DATE,' +
                               '  AL_DETTAGLIO DATE,' +
                               '  GIORNI_DETTAGLIO NUMBER,' +
                               '  PERC_GIORNI_DETTAGLIO NUMBER,' +
                               '  PARTTIME VARCHAR2(5),' +
                               '  PERC_PARTTIME NUMBER,' +
                               '  FASCIA_PARTTIME NUMBER,' +
                               '  DATO1_ANAGRAFE VARCHAR2(20),' +
                               '  DATO2_ANAGRAFE VARCHAR2(20),' +
                               '  DATO3_ANAGRAFE VARCHAR2(20),' +
                               '  DATO1_QUOTASALDO VARCHAR2(20),' +
                               '  DATO2_QUOTASALDO VARCHAR2(20),' +
                               '  DATO3_QUOTASALDO VARCHAR2(20),' +
                               '  FONDO_QUOTASALDO NUMBER,' +
                               '  SOLO_QUOTASALDO VARCHAR2(1),' +
                               '  QUOTA_ACCONTI NUMBER,' +
                               '  NUMERI_DETTAGLIO NUMBER,' +
                               '  NUMERI_TOTFONDO NUMBER,' +
                               '  PESO_DETTAGLIO NUMBER,' +
                               '  SALDO NUMBER,' +
                               '  DATA_REGISTRAZIONE DATE)');
      CreaTabellaTest.Execute;
      selTabellaTest.Close;
      selTabellaTest.SetVariable('TABELLA',TabellaTest);
      selTabellaTest.Open;
      TabellaTipoD.IndexName:='Primario';
      TabellaTipoD.First;
      while not TabellaTipoD.Eof do
      begin
        selTabellaTest.Append;
        for i:=0 to TabellaTipoD.FieldList.Count - 1 do
          if TabellaTipoD.Fields[i].DataType = ftInteger then
            selTabellaTest.Fields[i].AsInteger:=TabellaTipoD.Fields[i].AsInteger
          else if TabellaTipoD.Fields[i].DataType = ftFloat then
            selTabellaTest.Fields[i].AsFloat:=TabellaTipoD.Fields[i].AsFloat
          else if TabellaTipoD.Fields[i].DataType = ftString then
            selTabellaTest.Fields[i].AsString:=TabellaTipoD.Fields[i].AsString
          else if TabellaTipoD.Fields[i].DataType = ftDateTime then
            selTabellaTest.Fields[i].AsDateTime:=TabellaTipoD.Fields[i].AsDateTime;
        selTabellaTest.Post;
        TabellaTipoD.Next;
      end;
      SessioneOracle.Commit;
    end;
    (*SOLO_PER_TEST fine*)
  end;
  QSIncentivi.Free;
  DSIncentivi.Free;
  FreeAndNil(ElencoPT);
  FreeAndNil(lstQuote);
  ProgressBar1.Position:=0;
  A167FRegistraIncentivi.KeyPreview:=False;
  StatusBar.Panels[1].Text:='';
  Screen.Cursor:=crDefault;
  btnAnomalie.Enabled:=(RegistraMsg.ContieneTipoA) or (RegistraMsg.ContieneTipoB);
  if not Anteprima then
    if TipoModulo = 'CS' then
      if (RegistraMsg.ContieneTipoA) or (RegistraMsg.ContieneTipoB) then
      begin
        if (R180MessageBox('Elaborazione terminata con anomalie. Si desidera visualizzarle?',DOMANDA) = mrYes) then
          btnAnomalieClick(nil);
      end
      else
        R180MessageBox('Elaborazione terminata',INFORMA);
end;

procedure TA167FRegistraIncentivi.Controlli;
var s:String;
begin
  //Controlli
  if C700SelAnagrafe.RecordCount <= 0 then
    raise exception.Create('Nessun dipendente selezionato!');
  if Copy(edtDaData.Text,4,4) <> Copy(edtAData.Text,4,4) then
    raise Exception.Create('L''elaborazione deve essere effettuata per un anno alla volta!');
  if StrToDate('01/' + edtDaData.Text) > StrToDate('01/' + edtAData.Text) then
    raise Exception.Create('La data iniziale deve essere minore di quella finale!');
  if (edtQuote.Visible) and (Trim(edtQuote.Text) = '') then
    raise Exception.Create('Inserire almeno una Quota da elaborare!');
  s:='';
  if Pos(',',edtQuote.Text) <= 0 then
    s:=edtQuote.Text
  else
    s:=Copy(edtQuote.Text,1,Pos(',',edtQuote.Text)-1);
  if (Trim(s) <> '') and (TipoQuota <> VarToStr(A167FRegistraIncentiviDtM.A167FRegistraIncentiviMW.selT765.Lookup('CODICE',s,'TIPOQUOTA'))) then
    raise Exception.Create('Incongruenza tra il Tipo di calcolo e le Quote da elaborare: impostare correttamente i parametri richiesti!');
  if (TipoQuota = 'D')
  and ((R180Mese(StrToDate('01/' + edtDaData.Text)) <> 1) or
       (R180Mese(StrToDate('01/' + edtAData.Text)) <> 12)) then
    raise Exception.Create('Per il tipo di calcolo selezionato, il periodo di riferimento dev''essere l''intero anno. Correggere la situazione!!');
  if (TipoQuota = 'R') and (edtDaData.Text <> edtAData.Text) then
    raise Exception.Create('Il calcolo delle Rateizzazioni va eseguito un mese alla volta!');
  if (TipoQuota = 'Q') and (edtDaData.Text <> edtAData.Text) then
    raise Exception.Create('Il calcolo delle Quote quantitative va eseguito un mese alla volta!');
  if ((TipoQuota = 'T') or (TipoQuota = 'I') or (TipoQuota = 'V') or (TipoQuota = 'C')) and
     ((StrToIntDef(Copy(edtDaData.Text,1,2),0) <> 1) or (StrToIntDef(Copy(edtAData.Text,1,2),0) <> 12)) then
    raise Exception.Create('Il calcolo del saldo va eseguito per tutto l''anno!');
  if Anteprima and (lstColonne.Count <= 0) then
    raise exception.Create('Scegliere almeno una colonna da stampare!');
  with A167FRegistraIncentiviDtM do
  begin
    s:='';
    ControlloT257.Close;
    ControlloT257.Open;
    while not ControlloT257.Eof do
    begin
      if Trim(s) <> '' then
        s:=s + ',';
      s:=s + ControlloT257.FieldByName('COD_CAUSALE').AsString;
      ControlloT257.Next;
    end;
    if Trim(s) <> '' then
      raise Exception.Create('Le causali di assenza ' + s + ' sono legate a più di un accorpamento relativo agli incentivi!');
  end;
  //Apertura dataset di base
  with A167FRegistraIncentiviDtM do
  begin
    //Lettura valuta
    selP150.SetVariable('Decorrenza',R180FineMese(StrToDate('01/' + edtAData.Text)));
    selP150.Close;
    selP150.Open;
    selP030.SetVariable('Cod_Valuta',selP150.FieldByName('COD_VALUTA_BASE').AsString);
    selP030.SetVariable('Decorrenza',R180FineMese(StrToDate('01/' + edtAData.Text)));
    selP030.Close;
    selP030.Open;
    if rgpTipoDati.ItemIndex = 0 then
      Decimali:=selP030.FieldByName('DECIMALI').AsFloat
    else
      Decimali:=0.01;
  end;
end;

procedure TA167FRegistraIncentivi.Azzeramento;
var i:Integer;
begin //Azzeramento per ogni dip per ogni mese
  QuotaIntera:=0;
  QuotaProporzionata:=0;
  QuotaNetta:=0;
  GGIntera:=0;
  GGProporzionata:=0;
  GGNetta:=0;
  QuotaAssenza:=0;
  GGAssenza:=0;
  PercGGEff:=100;
  QuotaRisparmio:=0;
  GGRisparmio:=0;
  AbbattimentoGS:=0;
  AbbattimentoPT:=0;
  AbbattimentoAS:=0;
  ElencoPT.Clear;
  for i:=1 to 31 do
  begin
    GiorniMese[i].Data:=0;
    GiorniMese[i].GG:=0;
    GiorniMese[i].QuotaGG:=0;
    GiorniMese[i].SaltaProva:='';
    GiorniMese[i].SospendiPT:='';
    GiorniMese[i].SospendiQuote:='';
  end;
  if not AccontoValutativo then
  begin
    Dato1:=' ';
    Dato2:=' ';
    Dato3:=' ';
    RegDato1:=' ';
    RegDato2:=' ';
    RegDato3:=' ';
  end;
end;

procedure TA167FRegistraIncentivi.OperazioniIniziali(DataFine:TDateTime);
var s:String;
  GG,i,j:Integer;
  App,Acconto:Real;
  lstAcconti:TStringList;
begin   //Operazioni fatte prima del ciclo su tutti i giorni del mese
  with A167FRegistraIncentiviDtM do
  begin
    //Leggo le regole di calcolo a fine mese
    if (not selT760.Active) or
      ((selT760.Active) and
      ((selT760.GetVariable('LIVELLO') <> Dato1) or
       (selT760.GetVariable('DECORRENZA') <> MeseCorr))) then
    begin
      selT760.Close;
      selT760.SetVariable('LIVELLO',Dato1);
      selT760.SetVariable('DECORRENZA',MeseCorr);
      selT760.Open;
    end;
    if selT760.RecordCount <= 0 then
    begin
      if selT762.SearchRecord('MESE',R180Mese(MeseCorr),[srFromBeginning]) then
      begin
        s:='Dip.senza regole ma con quote maturate!';
        RegistraMsg.InserisciMessaggio('A',s,'',C700SelAnagrafe.FieldByName('PROGRESSIVO').AsInteger);
      end;
      Exit;
    end;
    TipoCalcolo:=selT760.FieldByName('TIPO').AsString;
    TipoQuoteQuant:=selT760.FieldByName('TIPO_QUOTEQUANT').AsString; //Lorena 01/06/2011
    MaxPenalizzazione:=selT760.FieldByName('ABBATTIMENTO_MAX').AsFloat;
    ProporzioneIncentivi:=selT760.FieldByName('PROPORZIONE_INCENTIVI').AsString;
    ProporzionePT:=selT760.FieldByName('PROPORZIONE_PARTTIME').AsString;
    ScaglioniGgEff:=selT760.FieldByName('SCAGLIONI_GGEFF').AsString;
    GGIntera:=R180GiorniMese(MeseCorr);
    PercPenalizzazione:=0;
    PesoIndivid:=100;
    PesoStrutt:=0;
    ValutIndivid:=100;
    ValutStrutt:=100;
    Acconto:=0;
    for i:=1 to 31 do
    begin
      if (R180InizioMese(MeseCorr)-1) + i <= R180FineMese(MeseCorr) then
      begin
        GiorniMese[i].Data:=(R180InizioMese(MeseCorr)-1) + i;
        GiorniMese[i].GG:=1;
        GiorniMese[i].QuotaGG:=0;
        GiorniMese[i].SaltaProva:='N';
        GiorniMese[i].SospendiPT:='N';
        GiorniMese[i].SospendiQuote:='N';
      end;
    end;
    if TipoCalcolo = 'D' then  //Giorni utili
    begin
      CodQuota:='A#D';
      TipoQuota:='A';
      if chkAggiorna.Checked then
        CancellaMese(MeseCorr); //Cancello le registrazioni esistenti
      if (Parametri.CampiRiferimento.C7_Dato3 = '') or (Pos(',' + Dato3 + ',',',' + selT760.FieldByName('ELENCOLIV').AsString + ',') > 0) then
        QuotaIntera:=GGIntera;
      for i:=1 to 31 do
        GiorniMese[i].QuotaGG:=1;
    end
    else if TipoCalcolo = 'C' then  //Quote incentivanti
    begin
      if TipoQuota = 'Q' then     //Quote quantitative
      begin
        //Controllo se ci sono schede riep. successive con quote quantitative già elaborate
        s:='Si';
        if ControlloT070.Active and
          (C700Progressivo = ControlloT070.GetVariable('PROG')) then
          s:='No';
        ControlloT070.Close;
        ControlloT070.SetVariable('PROG',C700Progressivo);
        ControlloT070.SetVariable('DATA',DataFine);
        ControlloT070.SetVariable('CAUSALE',VarToStr(A167FRegistraIncentiviMW.selT765.Lookup('CODICE',CodQuota,'CAUSALE_ASSESTAMENTO')));
        ControlloT070.Open;
        if ControlloT070.FieldByName('CONTA').AsInteger > 0 then
        begin
          if s = 'Si' then
          begin
            //Anomalia bloccante
            s:='Elaborazione impossibile, sono presenti quote quantitative successive al ' + DateToStr(DataFine);
            RegistraMsg.InserisciMessaggio('A',s,'',C700SelAnagrafe.FieldByName('PROGRESSIVO').AsInteger);
          end;
          Exit;
        end;
      end;
      if chkAggiorna.Checked then
      begin
        if (((TipoQuota = 'I') or (TipoQuota = 'C') or ((TipoQuota = 'V') and not AccontoValutativo)) or
           ((TipoQuota = 'Q') and (not DSIncentivi.DipendenteInServizio(C700Progressivo,R180InizioMese(MeseCorr),MeseCorr)))) and
          Cancella then
        begin
          CancellaMese(DataFine);
          Cancella:=False;
        end
        else if (TipoQuota = 'A') or (TipoQuota = 'S') or (TipoQuota = 'T') or
               ((TipoQuota = 'Q') and (DSIncentivi.DipendenteInServizio(C700Progressivo,R180InizioMese(MeseCorr),MeseCorr))) then
          CancellaMese(MeseCorr); //Cancello le registrazioni esistenti
      end;
      //Considero eventuali pesature - apro il dataset relativo
      if TipoQuota = 'I' then
      begin
        selT774.Close;
        selT774.SetVariable('ANNO',R180Anno(DataFine));
        selT774.SetVariable('PROG',C700Progressivo);
        selT774.SetVariable('QUOTA',CodQuota);
        selT774.Open;
      end;
      //Leggo la quota intera sulle quote aziendali o individuali
      if (not selT770.Active) or
        ((selT770.Active) and
        ((selT770.GetVariable('DATO1') <> Dato1) or
         (selT770.GetVariable('DATO2') <> Dato2) or
         (selT770.GetVariable('DATO3') <> Dato3) or
         (selT770.GetVariable('DATA') <> MeseCorr))) then
      begin
        selT770.Close;
        selT770.SetVariable('DATO1',Dato1);
        selT770.SetVariable('DATO2',Dato2);
        selT770.SetVariable('DATO3',Dato3);
        selT770.SetVariable('DATA',MeseCorr);
        selT770.Open;
      end;
//      if (TipoQuota <> 'V') or ((TipoQuota = 'V') and AccontoValutativo) then  //Lorena 01/06/2011
      if ((TipoQuota = 'V') and AccontoValutativo) or
         ((TipoQuota = 'Q') and (TipoQuoteQuant = 'G')) or
         ((TipoQuota <> 'Q') and (TipoQuota <> 'V')) then
      begin
        //Leggo la quota intera sulle quote aziendali o individuali
        if selT770.SearchRecord('CODTIPOQUOTA',CodQuota,[srFromBeginning]) then
        begin
          QuotaIntera:=selT770.FieldByName('IMPORTO').AsFloat;
          if ((TipoQuota = 'I') or (TipoQuota = 'V') or (TipoQuota = 'C')) and
            (selT770.FieldByName('VALUT_STRUTTURALE').AsFloat <> 100) then
            QuotaIntera:=QuotaIntera * selT770.FieldByName('VALUT_STRUTTURALE').AsFloat / 100;
          if TipoQuota = 'Q' then
            GGIntera:=R180OreMinutiExt(selT770.FieldByName('NUM_ORE').AsString);
          RegDato1:=selT770.FieldByName('DATO1').AsString;
          RegDato2:=selT770.FieldByName('DATO2').AsString;
          RegDato3:=selT770.FieldByName('DATO3').AsString;
          for i:=1 to 31 do
            GiorniMese[i].QuotaGG:=QuotaIntera / R180GiorniMese(MeseCorr);
          if (TipoQuota = 'V') or (TipoQuota = 'I') or (TipoQuota = 'C')  then
          begin
            PesoIndivid:=selT770.FieldByName('PERC_INDIVIDUALE').AsFloat;
            PesoStrutt:=selT770.FieldByName('PERC_STRUTTURALE').AsFloat;
          end;
          if TipoQuota = 'P' then
            PercPenalizzazione:=selT770.FieldByName('PENALIZZAZIONE').AsFloat;
        end;
      end;
      //Considerazione quote individuali che variano la Quota intera letta
      if (not selT775.Active) or
        ((selT775.Active) and
        ((selT775.GetVariable('PROGRESSIVO') <> C700Progressivo) or
         (selT775.GetVariable('DINI') <> R180InizioMese(MeseCorr)) or
         (selT775.GetVariable('DFIN') <> MeseCorr))) then
      begin
        selT775.Close;
        selT775.SetVariable('PROGRESSIVO',C700Progressivo);
        selT775.SetVariable('DINI',R180InizioMese(MeseCorr));
        selT775.SetVariable('DFIN',MeseCorr);
        selT775.Open;
      end;
//      if ((TipoQuota <> 'C') and (TipoQuota <> 'V')) or ((TipoQuota = 'V') and AccontoValutativo) then  //Lorena 01/06/2011
      if ((TipoQuota = 'V') and AccontoValutativo) or
         ((TipoQuota = 'Q') and (TipoQuoteQuant = 'G')) or
         ((TipoQuota <> 'C') and (TipoQuota <> 'Q') and (TipoQuota <> 'V')) then
      begin
        if selT775.SearchRecord('CODTIPOQUOTA',CodQuota,[srFromBeginning]) then
        begin
          if not selT775.FieldByName('PENALIZZAZIONE').IsNull then
            PercPenalizzazione:=selT775.FieldByName('PENALIZZAZIONE').AsFloat;
          GG:=0;
          App:=0;
          ValutIndivid:=0;
          ValutStrutt:=0;
          while (not selT775.Eof) and
            (selT775.FieldByName('CODTIPOQUOTA').AsString = CodQuota) do
          begin
            GG:=GG + selT775.FieldByName('GIORNI').AsInteger;
            if TipoQuota = 'Q' then
            begin
              App:=App + (R180OreMinutiExt(selT775.FieldByName('NUM_ORE').AsString) *
                          selT775.FieldByName('GIORNI').AsInteger / R180GiorniMese(MeseCorr));
              QuotaIntera:=selT775.FieldByName('IMPORTO').AsFloat;
            end
            else if TipoQuota <> 'Q' then
            begin
              if selT775.FieldByName('IMPORTO').AsFloat <> -1 then
              begin
                App:=App + (selT775.FieldByName('IMPORTO').AsFloat *
                            selT775.FieldByName('GIORNI').AsInteger / R180GiorniMese(MeseCorr));
                for i:=1 to 31 do
                begin
                  if (GiorniMese[i].Data <= selT775.FieldByName('SCADENZA').AsDateTime) and
                     (GiorniMese[i].Data >= selT775.FieldByName('DECORRENZA').AsDateTime) then
                    GiorniMese[i].QuotaGG:=selT775.FieldByName('IMPORTO').AsFloat / R180GiorniMese(MeseCorr);
                end;
              end
              else
              begin
                App:=App + (QuotaIntera * selT775.FieldByName('PERCENTUALE').AsFloat / 100) *
                           (selT775.FieldByName('GIORNI').AsInteger / R180GiorniMese(MeseCorr));
                for i:=1 to 31 do
                begin
                  if (GiorniMese[i].Data <= selT775.FieldByName('SCADENZA').AsDateTime) and
                     (GiorniMese[i].Data >= selT775.FieldByName('DECORRENZA').AsDateTime) then
                    GiorniMese[i].QuotaGG:=(QuotaIntera * selT775.FieldByName('PERCENTUALE').AsFloat / 100) / R180GiorniMese(MeseCorr);
                end;
              end;
              if (TipoQuota = 'V') or (TipoQuota = 'I') then
              begin
                ValutIndivid:=ValutIndivid + selT775.FieldByName('PERC_INDIVIDUALE').AsFloat *
                           (selT775.FieldByName('GIORNI').AsInteger / R180GiorniMese(MeseCorr));
                ValutStrutt:=ValutStrutt + selT775.FieldByName('PERC_STRUTTURALE').AsFloat *
                           (selT775.FieldByName('GIORNI').AsInteger / R180GiorniMese(MeseCorr));
              end;
            end;
            selT775.Next;
          end;
          if TipoQuota = 'Q' then
          begin
            if R180GiorniMese(MeseCorr) - GG > 0 then
              App:=App + (GGIntera * (R180GiorniMese(MeseCorr) - GG) / R180GiorniMese(MeseCorr));
            GGIntera:=App;
          end
          else
          begin
            if R180GiorniMese(MeseCorr) - GG > 0 then
            begin
              App:=App + (QuotaIntera * (R180GiorniMese(MeseCorr) - GG) / R180GiorniMese(MeseCorr));
              if (TipoQuota = 'V') or (TipoQuota = 'I') then
              begin
                ValutIndivid:=ValutIndivid + 100 *
                           ((R180GiorniMese(MeseCorr) - GG) / R180GiorniMese(MeseCorr));
                ValutStrutt:=ValutStrutt + 100 *
                           ((R180GiorniMese(MeseCorr) - GG) / R180GiorniMese(MeseCorr));
              end;
            end;
            QuotaIntera:=App;
          end;
        end;
      end;
      //saldo valutativo - leggo gli acconti di riferimento
      if (TipoQuota = 'V') and (not AccontoValutativo) then
      begin
        lstAcconti:=TStringList.Create;
        lstAcconti.Clear;
        lstAcconti.CommaText:=VarToStr(A167FRegistraIncentiviMW.selT765.Lookup('CODICE',CodQuota,'ACCONTI'));
        for i:=0 to lstAcconti.Count - 1 do
        begin
          //sommo alla quota intera saldo tutte le quote intere acconto di riferimento
          if selT770.SearchRecord('CODTIPOQUOTA',lstAcconti.Strings[i],[srFromBeginning]) then
          begin
            QuotaIntera:=selT770.FieldByName('IMPORTO').AsFloat;
            for j:=1 to 31 do
              GiorniMese[j].QuotaGG:=QuotaIntera / R180GiorniMese(MeseCorr);
          end;
          //Considerazione quote individuali che variano la Quota intera letta
          if selT775.SearchRecord('CODTIPOQUOTA',lstAcconti.Strings[i],[srFromBeginning]) then
          begin
            GG:=0;
            App:=0;
            while (not selT775.Eof) and
              (selT775.FieldByName('CODTIPOQUOTA').AsString = lstAcconti.Strings[i]) do
            begin
              GG:=GG + selT775.FieldByName('GIORNI').AsInteger;
              if selT775.FieldByName('IMPORTO').AsFloat <> -1 then
              begin
                App:=App + (selT775.FieldByName('IMPORTO').AsFloat *
                            selT775.FieldByName('GIORNI').AsInteger / R180GiorniMese(MeseCorr));
                for j:=1 to 31 do
                begin
                  if (GiorniMese[j].Data <= selT775.FieldByName('SCADENZA').AsDateTime) and
                     (GiorniMese[j].Data >= selT775.FieldByName('DECORRENZA').AsDateTime) then
                    GiorniMese[j].QuotaGG:=selT775.FieldByName('IMPORTO').AsFloat / R180GiorniMese(MeseCorr);
                end;
              end
              else
              begin
                App:=App + (QuotaIntera * selT775.FieldByName('PERCENTUALE').AsFloat / 100) *
                           (selT775.FieldByName('GIORNI').AsInteger / R180GiorniMese(MeseCorr));
                for j:=1 to 31 do
                begin
                  if (GiorniMese[j].Data <= selT775.FieldByName('SCADENZA').AsDateTime) and
                     (GiorniMese[j].Data >= selT775.FieldByName('DECORRENZA').AsDateTime) then
                    GiorniMese[j].QuotaGG:=(QuotaIntera * selT775.FieldByName('PERCENTUALE').AsFloat / 100) / R180GiorniMese(MeseCorr);
                end;
              end;
              selT775.Next;
            end;
            if R180GiorniMese(MeseCorr) - GG > 0 then
              App:=App + (QuotaIntera * (R180GiorniMese(MeseCorr) - GG) / R180GiorniMese(MeseCorr));
            QuotaIntera:=App;
          end;
          Acconto:=Acconto + QuotaIntera;
          QuotaIntera:=0;
        end;
        FreeAndNil(lstAcconti);
        QuotaIntera:=Acconto;
      end;
      //Considerazione Assenze che decurtano la quota intera
      if (QuotaIntera <> 0) and ((TipoQuota = 'A') or (TipoQuota = 'I') or (TipoQuota = 'V')) then
      begin
        if (not selT040B.Active) or
          ((selT040B.Active) and
          ((selT040B.GetVariable('DATO1') <> Dato1) or
           (selT040B.GetVariable('DATO2') <> Dato2) or
           (selT040B.GetVariable('DATO3') <> Dato3) or
           (selT040B.GetVariable('ADATA') <> MeseCorr) or
           (selT040B.GetVariable('PROG') <> C700Progressivo))) then
        begin
          selT040B.Close;
          selT040B.SetVariable('DATO1',Dato1);
          selT040B.SetVariable('DATO2',Dato2);
          selT040B.SetVariable('DATO3',Dato3);
          selT040B.SetVariable('DADATA',R180InizioMese(MeseCorr));
          selT040B.SetVariable('ADATA',MeseCorr);
          selT040B.SetVariable('PROG',C700Progressivo);
          selT040B.Open;
        end;
        App:=0;
        GG:=R180GiorniMese(MeseCorr);
        selT040B.First;
        while not selT040B.Eof do
        begin
          GG:=GG - 1;
          if (TipoQuota = 'A') or
           (((TipoQuota = 'I') or (TipoQuota = 'V')) and (selT040B.FieldByName('CONSIDERA_SALDO').AsString = 'S')) then
          begin
            if selT040B.FieldByName('IMPORTO').AsFloat <> -1 then
            begin
              App:=App + (selT040B.FieldByName('IMPORTO').AsFloat / R180GiorniMese(MeseCorr));
              GiorniMese[R180Giorno(selT040B.FieldByName('DATA').AsDateTime)].QuotaGG:=selT040B.FieldByName('IMPORTO').AsFloat / R180GiorniMese(MeseCorr);
            end
            else
            begin
              App:=App + ((QuotaIntera * selT040B.FieldByName('PERCENTUALE').AsFloat / 100) / R180GiorniMese(MeseCorr));
              GiorniMese[R180Giorno(selT040B.FieldByName('DATA').AsDateTime)].QuotaGG:=(QuotaIntera * selT040B.FieldByName('PERCENTUALE').AsFloat / 100) / R180GiorniMese(MeseCorr);
            end;
          end
          else //TipoQuota = 'I'/'V' e non considera saldo
          begin
            GiorniMese[R180Giorno(selT040B.FieldByName('DATA').AsDateTime)].QuotaGG:=0;
            GiorniMese[R180Giorno(selT040B.FieldByName('DATA').AsDateTime)].GG:=0;
            GGIntera:=GGIntera-1;
          end;
          selT040B.Next;
        end;
        QuotaIntera:=App + (QuotaIntera / R180GiorniMese(MeseCorr) * GG);
      end;
      //QUOTA QUANTITATIVA - leggo le schede quant. individuali
      if (TipoQuota = 'Q') and (TipoQuoteQuant = 'S') then       //Lorena 01/06/2011
      begin
        selT768.Close;
        selT768.SetVariable('PROG',C700Progressivo);
        selT768.SetVariable('ANNO',R180Anno(MeseCorr));
        selT768.SetVariable('CODQUOTA',CodQuota);
        selT768.Open;
        if selT768.RecordCount > 0 then
        begin
          QuotaIntera:=selT768.FieldByName('IMPORTO_ORARIO').AsFloat;
          GGIntera:=R180OreMinutiExt(selT768.FieldByName('NUMORE_ACCETTATE').AsString) +
                    R180OreMinutiExt(selT768.FieldByName('NUMORE_EXTRA').AsString);
        end;
      end;
      //Regole generali valide per tutte le quote
      if selT775.SearchRecord('CODTIPOQUOTA',' ',[srFromBeginning]) then
        while (not selT775.Eof) and
          (selT775.FieldByName('CODTIPOQUOTA').AsString = ' ') do
        begin
          for i:=1 to 31 do
          begin
            if (GiorniMese[i].Data <= selT775.FieldByName('SCADENZA').AsDateTime) and
               (GiorniMese[i].Data >= selT775.FieldByName('DECORRENZA').AsDateTime) then
            begin
              GiorniMese[i].SaltaProva:=selT775.FieldByName('SALTAPROVA').AsString;
              GiorniMese[i].SospendiPT:=selT775.FieldByName('SOSPENDI_PT').AsString;
              GiorniMese[i].SospendiQuote:=selT775.FieldByName('SOSPENDI_QUOTE').AsString;
            end;
          end;
          selT775.Next;
        end;
    end;
    //--Considero il Periodo di prova alla data FINE del mese che sto elaborando con impostazione a 0 di QuotaIntera
    // SE NON E' UNA QUOTA QUANTITATIVA
    DurataProva:=0;
    FineProva:=QSIncentivi.FieldByName('T430INIZIO').AsDateTime;
    if (TipoQuota <> 'Q') and (Parametri.CampiRiferimento.C6_DurataProva <> '') then
      DurataProva:=QSIncentivi.FieldByName('T430' + Parametri.CampiRiferimento.C6_DurataProva).AsInteger;
    if DurataProva <> 0 then
    begin
      InizioProva:=QSIncentivi.FieldByName('T430INIZIO').AsDateTime;
      if (Parametri.CampiRiferimento.C6_InizioProva <> '') then
      begin
        if QSIncentivi.FieldByName('T430' + Parametri.CampiRiferimento.C6_InizioProva).AsDateTime <> 0 then
          InizioProva:=QSIncentivi.FieldByName('T430' + Parametri.CampiRiferimento.C6_InizioProva).AsDateTime;
      end;
      FineProva:=InizioProva + DurataProva - 1;
      if PeriodoProva.GetPeriodoProva(C700Progressivo,DurataProva,InizioProva) then
        FineProva:=PeriodoProva.FinePeriodoProva;
      DurataProva:=Trunc(FineProva - InizioProva) + 1;
      //Se il dip. a fine mese è in prova non matura incentivi
      if MeseCorr - InizioProva + 1 <= DurataProva then
      begin
        if GiorniMese[R180Giorno(MeseCorr)].SaltaProva = 'N' then
          QuotaIntera:=0;
      end;
    end;
  end;
end;

procedure TA167FRegistraIncentivi.ElaboraPenalizzazioni;
begin
  with A167FRegistraIncentiviDtM.selT762 do
  begin
    SearchRecord('MESE',R180Mese(MeseCorr),[srFromBeginning]);
    while not Eof and
      (FieldByName('MESE').AsInteger = R180Mese(MeseCorr)) do
    begin
      //Conteggio tutte le quote nette
      if (FieldByName('TIPOIMPORTO').AsString = '3') and
         (FieldByName('CODTIPOQUOTA').AsString <> '_') and
         (FieldByName('IMPORTO').AsFloat > 0) then
      begin
        TotaleGG:=TotaleGG + (FieldByName('GIORNI_ORE').AsFloat * PercPenalizzazione / 100);
        TotaleQuota:=TotaleQuota + (FieldByName('IMPORTO').AsFloat * PercPenalizzazione / 100);
      end;
      Next;
    end;
  end;
end;

procedure TA167FRegistraIncentivi.ElaboraRateizzazioni(Data:TDateTime);
begin
  with A167FRegistraIncentiviDtM.selT762 do
  begin
    SearchRecord('MESE',R180Mese(Data),[srFromBeginning]);
    while not Eof and
      (FieldByName('MESE').AsInteger = R180Mese(Data)) do
    begin
      //Rateizzo
      if (FieldByName('CODTIPOQUOTA').AsString = '_') and (FieldByName('IMPORTO').AsFloat > MaxPenalizzazione) then
      begin
        TotaleGG:=FieldByName('GIORNI_ORE').AsFloat;
        TotaleQuota:=FieldByName('IMPORTO').AsFloat - MaxPenalizzazione;
        TipoCalcolo:='P';
        CodQuota:='_';
        if chkAggiorna.Checked then
        begin
          CancellaMese(Data);
          if TotaleQuota > 0 then
            RegistraMese(Data,TotaleGG,MaxPenalizzazione,'3')
          else
            RegistraMese(Data,TotaleGG,0,'3');
          CancellaMese(R180AddMesi(Data,1));
          RegistraMese(R180AddMesi(Data,1),TotaleGG,TotaleQuota,'3');
        end;
        if Anteprima then
        begin
          if TotaleQuota > 0 then
            CaricaTabellaStampa(Data,TotaleGG,MaxPenalizzazione,'3')
          else
            CaricaTabellaStampa(Data,TotaleGG,0,'3');
          CaricaTabellaStampa(R180AddMesi(Data,1),TotaleGG,TotaleQuota,'3');
        end;
      end;
      Next;
    end;
  end;
end;

procedure TA167FRegistraIncentivi.ElaboraSaldoProporzionato(AData:TDateTime);
var AccTot, RispTot, AccProg, AccProg100, SaldoProg4, SaldoNettoProg, AccNettoTot, AccNettoProg, AccNettoProg100, QuotaNoRisp:Real;
  s:String;
begin
  //QuotaIntera = quota totale (acc+saldo) annuale collettiva
  QuotaIntera:=QuotaIntera / 12;
  with A167FRegistraIncentiviDtM do
  begin
    //Trovo la quota acconto di tutti i dip. dello stesso gruppo
    selT762ImpTot.Close;
    selT762ImpTot.SetVariable('ANNO',R180Anno(MeseCorr));
    selT762ImpTot.SetVariable('MESE',R180Mese(MeseCorr));
    s:='';
    if (Parametri.CampiRiferimento.C7_Dato1 <> '') and (Trim(RegDato1) <> '')  then
      s:=s + ' AND NVL(' + Parametri.CampiRiferimento.C7_Dato1 + ','''') = NVL(''' + Trim(RegDato1) + ''',' + Parametri.CampiRiferimento.C7_Dato1 + ')';
    if (Parametri.CampiRiferimento.C7_Dato2 <> '') and (Trim(RegDato2) <> '') then
      s:=s + ' AND NVL(' + Parametri.CampiRiferimento.C7_Dato2 + ','''') = NVL(''' + Trim(RegDato2) + ''',' + Parametri.CampiRiferimento.C7_Dato2 + ')';
    if (Parametri.CampiRiferimento.C7_Dato3 <> '') and (Trim(RegDato3) <> '') then
      s:=s + ' AND NVL(' + Parametri.CampiRiferimento.C7_Dato3 + ','''') = NVL(''' + Trim(RegDato3) + ''',' + Parametri.CampiRiferimento.C7_Dato3 + ')';
    selT762ImpTot.SetVariable('FILTROPROG',s);
    selT762ImpTot.SetVariable('ACCONTI','''' + StringReplace(VarToStr(A167FRegistraIncentiviMW.selT765.Lookup('CODICE',CodQuota,'ACCONTI')),',',''',''',[rfReplaceAll]) + '''');
    selT762ImpTot.SetVariable('COD',CodQuota);
    selT762ImpTot.SetVariable('PESO_STRUTT',PesoStrutt);
    selT762ImpTot.SetVariable('PESO_IND',PesoIndivid);
    selT762ImpTot.Open;
    //Trovo il risparmio totale derivante dagli acconti
    RispTot:=StrToFloatDef(VarToStr(selT762ImpTot.Lookup('RISPARMIO','S','IMPORTO')),0);
    //AccTot = acconti netti totali di tutti i dip.
    AccTot:=StrToFloatDef(VarToStr(selT762ImpTot.Lookup('TIPOIMPORTO','3','IMPORTO')),0);
    //QuotaNetta = quota saldo netta (al netto del risparmio) data da quota saldo totale * (coeff. di risparmio dato da (acconti netti totali / (acconti netti + risparmio totali)))
    if (AccTot + RispTot) = 0 then
    begin
      QuotaNetta:=0;
      s:='Attenzione: la struttura del dip. ha il totale quota acconto di riferimento a zero per ' + DateToStr(MeseCorr);
      RegistraMsg.InserisciMessaggio('A',s,'',C700SelAnagrafe.FieldByName('PROGRESSIVO').AsInteger);
    end
    else
      QuotaNetta:=QuotaIntera * (AccTot / (AccTot + RispTot));
    if QuotaNetta = 0 then
      Exit;
    //Trovo la quota acconto del dipendente corrente
    selT762Imp.Close;
    selT762Imp.SetVariable('ANNO',R180Anno(MeseCorr));
    selT762Imp.SetVariable('MESE',R180Mese(MeseCorr));
    selT762Imp.SetVariable('PROG',C700Progressivo);
    selT762Imp.SetVariable('ACCONTI','''' + StringReplace(VarToStr(A167FRegistraIncentiviMW.selT765.Lookup('CODICE',CodQuota,'ACCONTI')),',',''',''',[rfReplaceAll]) + '''');
    selT762Imp.SetVariable('COD',CodQuota);
    selT762Imp.SetVariable('PESO_STRUTT',PesoStrutt);
    selT762Imp.SetVariable('PESO_IND',PesoIndivid);
    selT762Imp.Open;
    //Ciclo su tutti i tipo importo acconto
    selT762ImpTot.First;
    SaldoProg4:=0;
    SaldoNettoProg:=0;
    AccNettoTot:=0;
    AccNettoProg:=0;
    AccNettoProg100:=0;
    QuotaNoRisp:=0;
    while not selT762ImpTot.Eof do
    begin
      TotaleQuota:=0;
      AccTot:=selT762ImpTot.FieldByName('IMPORTO').AsFloat;
      AccProg:=0;
      AccProg100:=0;
      if selT762Imp.SearchRecord('TIPOIMPORTO',selT762ImpTot.FieldByName('TIPOIMPORTO').AsString,[srFromBeginning]) then
      begin
        AccProg:=selT762Imp.FieldByName('IMPORTO').AsFloat;
        AccProg100:=selT762Imp.FieldByName('IMPORTO100').AsFloat;
      end;
      if (selT762ImpTot.FieldByName('TIPOIMPORTO').AsString = '1') or
         (selT762ImpTot.FieldByName('TIPOIMPORTO').AsString = '4') then
      begin
        TotaleQuota:=(QuotaIntera / AccTot * AccProg) - AccProg100;
        if selT762ImpTot.FieldByName('TIPOIMPORTO').AsString = '4' then
          SaldoProg4:=TotaleQuota;
      end
      else if selT762ImpTot.FieldByName('TIPOIMPORTO').AsString = '3' then
      begin
        TotaleQuota:=(QuotaNetta / AccTot * AccProg) - AccProg100;
        SaldoNettoProg:=TotaleQuota;
        AccNettoTot:=AccTot;
        AccNettoProg:=AccProg;
        AccNettoProg100:=AccProg100;
      end
      else if (selT762ImpTot.FieldByName('RISPARMIO').AsString = 'S') and (SaldoProg4 > SaldoNettoProg) then
        TotaleQuota:=SaldoProg4 - SaldoNettoProg
      else if (selT762ImpTot.FieldByName('RISPARMIO').AsString = 'N') and (AccProg > 0) then
      begin
        //TotaleQuota=QuotaNetta / Netto+NoRispAcc Tot * Netto+NoRispAcc Prog - Netto+NoRispAcc Prog.
        TotaleQuota:=QuotaNetta / (AccNettoTot + AccTot) * (AccNettoProg + AccProg) - (AccNettoProg100 + AccProg100);
        //TotaleQuota=Netto+NoRisp Saldo Prog. - Netto Saldo Prog = NoRisp.Saldo Prog
        TotaleQuota:=TotaleQuota - SaldoNettoProg;
        QuotaNoRisp:=TotaleQuota;
      end;
      if (chkAggiorna.Checked) and (TotaleQuota <> 0) then
        RegistraMese(AData,0,TotaleQuota,selT762ImpTot.FieldByName('TIPOIMPORTO').AsString);
      if Anteprima then
        CaricaTabellaStampa(AData,0,TotaleQuota,selT762ImpTot.FieldByName('TIPOIMPORTO').AsString);
      selT762ImpTot.Next;
    end;
    //Trovo la quota proporzionata come somma tra TotaleQuota e Quota4
    TotaleQuota:=SaldoProg4+QuotaNoRisp;
    if (chkAggiorna.Checked) and (TotaleQuota <> 0) then
      RegistraMese(AData,0,TotaleQuota,'2');
    if Anteprima then
      CaricaTabellaStampa(AData,0,TotaleQuota,'2');
  end;
end;

procedure TA167FRegistraIncentivi.ElaboraSaldo;
var QuotaProg,GGProg:Real;
  InizioPeriodo,FinePeriodo:TDateTime;
begin
  if R180Arrotonda(QuotaIntera,Decimali,'P') = 0 then
    Exit;
  with A167FRegistraIncentiviDtM do
  begin
    selT762.SearchRecord('MESE',R180Mese(MeseCorr),[srFromBeginning]);
    while not selT762.Eof and
      (selT762.FieldByName('MESE').AsInteger = R180Mese(MeseCorr)) do
    begin
      //Se esiste una quota acconto netto significativo per stesso anno e mese allora registro il saldo
      if (VarToStr(A167FRegistraIncentiviMW.selT765.Lookup('CODICE',selT762.FieldByName('CODTIPOQUOTA').AsString,'TIPOQUOTA')) = 'A') and
         (selT762.FieldByName('TIPOIMPORTO').AsString = '3') and (selT762.FieldByName('IMPORTO').AsFloat <> 0) then
      begin
        InizioPeriodo:=R180InizioMese(MeseCorr);
        FinePeriodo:=MeseCorr;
        //Abbattimento GS + PT
        GGProg:=FinePeriodo - InizioPeriodo + 1 - GGSenzaRegole;
        if (ProporzioneIncentivi = '0') and (GGProg <= 15) then //Lavorato >= 15gg
          GGProg:=0;
        QuotaProg:=QuotaIntera * GGProg / GGIntera;
        if GGProg <> 0 then
        begin
          QuotaProg:=QuotaProg * GGPT / GGProg;
          GGProg:=GGPT;
        end;
        if TipoQuota = 'S' then
        begin
          if chkAggiorna.Checked then
          begin
            RegistraMese(MeseCorr,GGIntera,QuotaIntera,'1');
            RegistraMese(MeseCorr,GGProg,QuotaProg,'2');
            RegistraMese(MeseCorr,GGProg,QuotaProg,'3');
          end;
          if Anteprima then
          begin
            CaricaTabellaStampa(MeseCorr,GGIntera,QuotaIntera,'1');
            CaricaTabellaStampa(MeseCorr,GGProg,QuotaProg,'2');
            CaricaTabellaStampa(MeseCorr,GGProg,QuotaProg,'3');
          end;
        end
        else if TipoQuota = 'T' then
        begin
          TotaleGG:=TotaleGG + R180Arrotonda(GGProg,0.01,'P');
          TotaleQuota:=TotaleQuota + R180Arrotonda(QuotaProg,Decimali,'P');
          TotaleIntera:=TotaleIntera + R180Arrotonda(QuotaIntera,Decimali,'P');
        end;
        Break;
      end;
      selT762.Next;
    end;
  end;
end;

procedure TA167FRegistraIncentivi.ElaboraQuotaQuantitativa(AData:TDateTime);
var s,MaxOre,MeseRif:String;
  Imp,Minuti,PercOre,OrePagate:Real;
begin
  with A167FRegistraIncentiviDtM do
  begin
    if (QuotaIntera = 0) or (GGIntera = 0) then  //Lorena 01/06/2011
      Exit;
    if selDatiBloccati.DatoBloccato(C700Progressivo,R180InizioMese(AData),'T070') then
      Exit;
    if (TipoQuota = 'Q') and (not DSIncentivi.DipendenteInServizio(C700Progressivo,StrToDate('01/'+edtAData.Text),R180FineMese(StrToDate('01/'+edtAData.Text)))) then
    begin
//      s:='Dipendente non in servizio nel periodo (cessato al ' + DateToStr(Cessaz) + '). Le schede vengono riepilogate sul mese di cessazione.' + #$D#$A;  //Lorena 08/10/2012
      s:='Dipendente non in servizio nel periodo. Le schede vengono riepilogate sul mese di cessazione.' + #$D#$A;
      s:=s + 'Attenzione: in caso di ri-elaborazione bisogna prima cancellare manualmente il riepilogo mensile e pulire l''assestamento della scheda riep.';
      RegistraMsg.InserisciMessaggio('A',s,'',C700SelAnagrafe.FieldByName('PROGRESSIVO').AsInteger);
    end;
    Minuti:=GGIntera;
    if TipoQuoteQuant = 'S' then  //Lorena 01/06/2011
    begin  //Schede quant.quantitative ind.
      //Guardo le ore che sono state pagate fino al mese precedente quello di elaborazione
      A167FRegistraIncentiviMW.selSQL.Close;
      A167FRegistraIncentiviMW.selSQL.SQL.Clear;
      A167FRegistraIncentiviMW.selSQL.SQL.Add('SELECT SUM(GIORNI_ORE) TOTORE FROM T762_INCENTIVIMATURATI');
      A167FRegistraIncentiviMW.selSQL.SQL.Add('WHERE ANNO = ' + selT768.FieldByName('ANNO').AsString);
//      selSQL.SQL.Add('  AND MESE < ' + IntToStr(R180Mese(AData)));  //Lorena 08/10/2012
      A167FRegistraIncentiviMW.selSQL.SQL.Add('  AND MESE < ' + Copy(edtAData.Text,1,2));
      A167FRegistraIncentiviMW.selSQL.SQL.Add('  AND CODTIPOQUOTA = ''' + selT768.FieldByName('CODTIPOQUOTA').AsString + '''');
      A167FRegistraIncentiviMW.selSQL.SQL.Add('  AND PROGRESSIVO = ' + IntToStr(C700Progressivo));
      A167FRegistraIncentiviMW.selSQL.Execute;
      OrePagate:=StrToFloatDef(VarToStr(A167FRegistraIncentiviMW.selSQL.Field(0)),0);
      MaxOre:='999.59';
      PercOre:=100;
      MeseRif:=IntToStr(StrToIntDef(Copy(edtAData.Text,1,2),0));
      R180SetVariable(selT767,'ANNO',selT768.FieldByName('ANNO').AsInteger);
      R180SetVariable(selT767,'CODGRUPPO',selT768.FieldByName('CODGRUPPO').AsString);
      R180SetVariable(selT767,'CODQUOTA',selT768.FieldByName('CODTIPOQUOTA').AsString);
      selT767.Open;
      if (not selT767.FieldByName('PAG' + MeseRif + '_MAX').IsNull) and
        (selT767.FieldByName('PAG' + MeseRif + '_MAX').AsString <> '') then
        MaxOre:=selT767.FieldByName('PAG' + MeseRif + '_MAX').AsString;
      if (not selT767.FieldByName('PAG' + MeseRif + '_PERC').IsNull) and
         (selT767.FieldByName('PAG' + MeseRif + '_PERC').AsFloat <> -1) then
        PercOre:=selT767.FieldByName('PAG' + MeseRif + '_PERC').AsFloat;
      if (MaxOre <> '999.59') and (Minuti > R180OreMinutiExt(MaxOre)) then
        Minuti:=R180OreMinutiExt(MaxOre);
      if PercOre <> 100 then
        Minuti:=R180Arrotonda(Minuti * PercOre / 100,1,'P');
      if Minuti > (GGIntera - OrePagate) then //se le ore calcolate sono > alle ore restanti da pagare --> forzo
        Minuti:=GGIntera - OrePagate;
      if Minuti <= 0 then
        Exit;
    end;
    //Nel caso di dipendente cessato registro sull'ultimo mese di servizio
    selT070.Close;
    selT070.SetVariable('PROG',C700Progressivo);
    selT070.SetVariable('DATA',R180InizioMese(AData));
    selT070.Open;
    selT071.Close;
    selT071.SetVariable('PROG',C700Progressivo);
    selT071.SetVariable('DATA',R180InizioMese(AData));
    selT071.Open;
    if selT070.RecordCount > 0 then
    begin
      if (Trim(selT070.FieldByName('CAUSALE1MINASS').AsString) <> '') and
         (Trim(selT070.FieldByName('CAUSALE2MINASS').AsString) <> '') then
      begin
        //Anomalia bloccante
        s:='Elaborazione quota quantitativa impossibile, causali di assestamento già utilizzate';
        RegistraMsg.InserisciMessaggio('A',s,'',C700SelAnagrafe.FieldByName('PROGRESSIVO').AsInteger);
      end
      else
      begin
        if R450DtM1 = nil then
          R450DtM1:=TR450DtM1.Create(Self);
        R450DtM1.ConteggiMese('Generico',R180Anno(AData),R180Mese(AData),C700Progressivo);
        if (Minuti > R450DtM1.salannoatt) then
        begin
          //Anomalia supero saldo complessivo
          s:='La quota quantitativa supera il saldo complessivo';
          RegistraMsg.InserisciMessaggio('A',s,'',C700SelAnagrafe.FieldByName('PROGRESSIVO').AsInteger);
        end
        else if (Minuti > R450DtM1.salcompannoatt + R450DtM1.salliqannoatt) then
        begin
          //Anomalia supero saldo anno corrente
          s:='La quota quantitativa supera il saldo anno corrente';
          RegistraMsg.InserisciMessaggio('A',s,'',C700SelAnagrafe.FieldByName('PROGRESSIVO').AsInteger);
        end;
        if chkAggiorna.Checked then
        begin
          if Trim(selT070.FieldByName('CAUSALE1MINASS').AsString) = '' then
          begin
            selT070.Edit;
            selT070.FieldByName('CAUSALE1MINASS').AsString:=VarToStr(A167FRegistraIncentiviMW.selT765.Lookup('CODICE',CodQuota,'CAUSALE_ASSESTAMENTO'));
            RegistraLog.SettaProprieta('M','T070_SCHEDARIEPIL',CodForm,selT070,True);
            selT070.Post;
            RegistraLog.RegistraOperazione;
            selT071.Edit;
            selT071.FieldByName('ORE1ASSEST').AsString:='-' + StringReplace(Format('%6s',[R180MinutiOre(Trunc(Minuti))]),' ','0',[rfReplaceAll]);
            RegistraLog.SettaProprieta('M','T071_SCHEDAFASCE',CodForm,selT071,True);
            selT071.Post;
            RegistraLog.RegistraOperazione;
          end
          else if Trim(selT070.FieldByName('CAUSALE2MINASS').AsString) = '' then
          begin
            selT070.Edit;
            selT070.FieldByName('CAUSALE2MINASS').AsString:=VarToStr(A167FRegistraIncentiviMW.selT765.Lookup('CODICE',CodQuota,'CAUSALE_ASSESTAMENTO'));
            RegistraLog.SettaProprieta('M','T070_SCHEDARIEPIL',CodForm,selT070,True);
            selT070.Post;
            RegistraLog.RegistraOperazione;
            selT071.Edit;
            selT071.FieldByName('ORE2ASSEST').AsString:='-' + StringReplace(Format('%6s',[R180MinutiOre(Trunc(Minuti))]),' ','0',[rfReplaceAll]);
            RegistraLog.SettaProprieta('M','T071_SCHEDAFASCE',CodForm,selT071,True);
            selT071.Post;
            RegistraLog.RegistraOperazione;
          end;
          Imp:=StrToFloatDef(StringReplace(R180Centesimi(Trunc(Minuti)),'.',',',[rfReplaceAll]),0) * QuotaIntera;
          RegistraMese(AData,Minuti,Imp,'5');
        end;
        if Anteprima then
        begin
          Imp:=StrToFloatDef(StringReplace(R180Centesimi(Trunc(Minuti)),'.',',',[rfReplaceAll]),0) * QuotaIntera;
          CaricaTabellaStampa(AData,Minuti,Imp,'5');
        end;
      end;
    end
    else
    begin
      //Anomalia bloccante
      s:='Elaborazione quota quantitativa impossibile, scheda riepilogativa non esistente';
      RegistraMsg.InserisciMessaggio('A',s,'',C700SelAnagrafe.FieldByName('PROGRESSIVO').AsInteger);
    end;
  end;
end;

procedure TA167FRegistraIncentivi.Proporzionamenti;
var InizioPeriodo,FinePeriodo:TDateTime;
  s,Flex:String;
  GGOK,SospendiPT:Boolean;
  PT:Real;
begin
  //PROPORZIONAMENTI ALL'INTERNO DEL MESE
  with A167FRegistraIncentiviDtM do
  begin
    //se non ho pesature faccio i proporzionamenti altrimenti no perchè il peso è già proporzionato
    if (TipoQuota = 'I') and (selT774.RecordCount > 0) and (selT774.FieldByName('PESO').AsFloat > 0) then
    begin
      TotMesiSaldoI:=TotMesiSaldoI+1;
      Exit;
    end;
    GGSenzaRegole:=0;
    GGPT:=0;
    InizioPeriodo:=R180InizioMese(MeseCorr);
    FinePeriodo:=MeseCorr;
    while InizioPeriodo <= FinePeriodo do  //Ciclo sui giorni del mese
    begin
      GGOK:=True;
      QSIncentivi.LocDatoStorico(InizioPeriodo); //Leggo i dati storici per ogni giorno del periodo
      //Proporzionamento sui giorni di servizio
      if (not DSIncentivi.DipendenteInServizio(C700Progressivo,InizioPeriodo,InizioPeriodo)) and
         (GiorniMese[R180Giorno(InizioPeriodo)].QuotaGG <> 0) then
      begin
        GGSenzaRegole:=GGSenzaRegole + 1;
        GGOK:=False;
        GiorniMese[R180Giorno(InizioPeriodo)].GG:=0;
        GiorniMese[R180Giorno(InizioPeriodo)].QuotaGG:=0;
      end;
      //Se Dato1 del giorno è diverso da quello delle regole T760 controllo che cmq. ci siano le regole anche per lui
      if GGOK and (QSIncentivi.FieldByName('T430' + Parametri.CampiRiferimento.C7_Dato1).AsString <> Dato1) then //Dato1: regole T760
      begin
        selT760.Close;
        selT760.SetVariable('LIVELLO',QSIncentivi.FieldByName('T430' + Parametri.CampiRiferimento.C7_Dato1).AsString);
        selT760.SetVariable('DECORRENZA',InizioPeriodo);
        selT760.Open;
        if selT760.RecordCount <= 0 then
        begin
          GGSenzaRegole:=GGSenzaRegole + 1;
          GGOK:=False;
          GiorniMese[R180Giorno(InizioPeriodo)].GG:=0;
          GiorniMese[R180Giorno(InizioPeriodo)].QuotaGG:=0;
        end;
        selT760.Close;
        selT760.SetVariable('LIVELLO',Dato1);
        selT760.SetVariable('DECORRENZA',FinePeriodo);
        selT760.Open;
      end;
      if GGOK and (TipoCalcolo = 'D') and //Controllo se per i dati del giorno esiste cmq. un livello valido
        (Parametri.CampiRiferimento.C7_Dato3 <> '') and
        (QSIncentivi.FieldByName('T430' + Parametri.CampiRiferimento.C7_Dato3).AsString <> Dato3) and
        (Pos(',' + QSIncentivi.FieldByName('T430' + Parametri.CampiRiferimento.C7_Dato3).AsString + ',',',' + selT760.FieldByName('ELENCOLIV').AsString + ',') <= 0) then
      begin
        GGSenzaRegole:=GGSenzaRegole + 1;
        GGOK:=False;
        GiorniMese[R180Giorno(InizioPeriodo)].GG:=0;
        GiorniMese[R180Giorno(InizioPeriodo)].QuotaGG:=0;
      end;
      if GGOK and (TipoCalcolo = 'C') and //Controllo se per i dati del giorno esistono cmq. delle quote
        (((Trim(RegDato1) <> '') and
         (QSIncentivi.FieldByName('T430' + Parametri.CampiRiferimento.C7_Dato1).AsString <> RegDato1)) or
        ((Parametri.CampiRiferimento.C7_Dato2 <> '') and (Trim(RegDato2) <> '') and
         (QSIncentivi.FieldByName('T430' + Parametri.CampiRiferimento.C7_Dato2).AsString <> RegDato2)) or
        ((Parametri.CampiRiferimento.C7_Dato3 <> '') and (Trim(RegDato3) <> '') and
         (QSIncentivi.FieldByName('T430' + Parametri.CampiRiferimento.C7_Dato3).AsString <> RegDato3))) then
      begin
        ControlloT770.Close;
        ControlloT770.SetVariable('DATO1',QSIncentivi.FieldByName('T430' + Parametri.CampiRiferimento.C7_Dato1).AsString);
        if Trim(Parametri.CampiRiferimento.C7_Dato2) <> '' then
          ControlloT770.SetVariable('DATO2',QSIncentivi.FieldByName('T430' + Parametri.CampiRiferimento.C7_Dato2).AsString)
        else
          ControlloT770.SetVariable('DATO2','');
        if Trim(Parametri.CampiRiferimento.C7_Dato3) <> '' then
          ControlloT770.SetVariable('DATO3',QSIncentivi.FieldByName('T430' + Parametri.CampiRiferimento.C7_Dato3).AsString)
        else
          ControlloT770.SetVariable('DATO3','');
        ControlloT770.SetVariable('CODQUOTA',CodQuota);
        ControlloT770.SetVariable('DATA',MeseCorr);
        ControlloT770.Open;
        if ControlloT770.RecordCount <= 0 then
        begin
          GGSenzaRegole:=GGSenzaRegole + 1;
          GGOK:=False;
          GiorniMese[R180Giorno(InizioPeriodo)].GG:=0;
          GiorniMese[R180Giorno(InizioPeriodo)].QuotaGG:=0;
        end;
      end;
      //Proporzionamento sulla sospensione della maturazione - Quote individuali
      if GGOK then
      begin
        if GiorniMese[R180Giorno(InizioPeriodo)].SospendiQuote = 'S' then
        begin
          GGSenzaRegole:=GGSenzaRegole + 1;
          GGOK:=False;
          GiorniMese[R180Giorno(InizioPeriodo)].GG:=0;
          GiorniMese[R180Giorno(InizioPeriodo)].QuotaGG:=0;
        end;
      end;
      //Proporzionamento sul periodo di prova
      if GGOK and (GiorniMese[R180Giorno(InizioPeriodo)].QuotaGG <> 0) then
      begin
        //Considero il Periodo di prova alla data del giorno che sto elaborando
        DurataProva:=0;
        FineProva:=QSIncentivi.FieldByName('T430INIZIO').AsDateTime;
        if Parametri.CampiRiferimento.C6_DurataProva <> '' then
          DurataProva:=QSIncentivi.FieldByName('T430' + Parametri.CampiRiferimento.C6_DurataProva).AsInteger;
        if DurataProva <> 0 then
        begin
          InizioProva:=QSIncentivi.FieldByName('T430INIZIO').AsDateTime;
          if (Parametri.CampiRiferimento.C6_InizioProva <> '') then
          begin
            if QSIncentivi.FieldByName('T430' + Parametri.CampiRiferimento.C6_InizioProva).AsDateTime <> 0 then
              InizioProva:=QSIncentivi.FieldByName('T430' + Parametri.CampiRiferimento.C6_InizioProva).AsDateTime;
          end;
          FineProva:=InizioProva + DurataProva - 1;
          if PeriodoProva.GetPeriodoProva(C700Progressivo,DurataProva,InizioProva) then
            FineProva:=PeriodoProva.FinePeriodoProva;
          DurataProva:=Trunc(FineProva - InizioProva) + 1;
          //Se il dip. alla data del giorno è in prova non matura incentivi
          if InizioPeriodo - InizioProva + 1 <= DurataProva then
          begin
            if GiorniMese[R180Giorno(InizioPeriodo)].SaltaProva = 'N' then
            begin
              GGSenzaRegole:=GGSenzaRegole + 1;
              GGOK:=False;
              GiorniMese[R180Giorno(InizioPeriodo)].GG:=0;
              GiorniMese[R180Giorno(InizioPeriodo)].QuotaGG:=0;
            end;
          end;
        end;
      end;
      if GGOK and (GiorniMese[R180Giorno(InizioPeriodo)].GG > 0) then  //Proporzionamento part-time
      begin
        PT:=1;
        if (ProporzionePT = 'S') and
           (Trim(QSIncentivi.FieldByName('T430PARTTIME').AsString) <> '') then
        begin
          if selT460.SearchRecord('CODICE',QSIncentivi.FieldByName('T430PARTTIME').AsString,[srFromBeginning]) then
          begin
            SospendiPT:=False;
            if (selT040B.Active) and (selT040B.SearchRecord('DATA',InizioPeriodo,[srFromBeginning])) and
               (selT040B.FieldByName('SOSPENDI_PT').AsString = 'S') then
              SospendiPT:=True;
            if GiorniMese[R180Giorno(InizioPeriodo)].SospendiPT = 'S' then
              SospendiPT:=True;
            if SospendiPT then
            begin
              if (selT460.FieldByName('PIANTA').AsFloat <> 0) and (selT460.FieldByName('PIANTA').AsFloat <> 100) then
              begin
                PT:=(selT460.FieldByName('PIANTA').AsFloat / 100);
                ElencoPT.Add(selT460.FieldByName('PIANTA').AsString + '%');
                GiorniMese[R180Giorno(InizioPeriodo)].GG:=GiorniMese[R180Giorno(InizioPeriodo)].GG * selT460.FieldByName('PIANTA').AsFloat / 100;
                GiorniMese[R180Giorno(InizioPeriodo)].QuotaGG:=GiorniMese[R180Giorno(InizioPeriodo)].QuotaGG * selT460.FieldByName('PIANTA').AsFloat / 100;
              end;
            end
            else
            begin
              if (selT460.FieldByName('INCENTIVI').AsFloat <> 0) and (selT460.FieldByName('INCENTIVI').AsFloat <> 100) then
              begin
(*                PT:=(selT460.FieldByName('INCENTIVI').AsFloat / 100);
                ElencoPT.Add(selT460.FieldByName('INCENTIVI').AsString + '%');
                GiorniMese[R180Giorno(InizioPeriodo)].GG:=GiorniMese[R180Giorno(InizioPeriodo)].GG * selT460.FieldByName('INCENTIVI').AsFloat / 100;
                GiorniMese[R180Giorno(InizioPeriodo)].QuotaGG:=GiorniMese[R180Giorno(InizioPeriodo)].QuotaGG * selT460.FieldByName('INCENTIVI').AsFloat / 100;*)
                PT:=selT460.FieldByName('INCENTIVI').AsFloat;
                Flex:='*';
                if TipoQuoteQuant = 'S' then   //Schede quant.
                begin
                  selT768Flex.Close;
                  selT768Flex.SetVariable('ANNO',R180Anno(InizioPeriodo));
                  selT768Flex.SetVariable('QUOTA',CodQuota);
                  selT768Flex.SetVariable('PROG',C700Progressivo);
                  selT768Flex.Open;
                  if selT768Flex.RecordCount > 0 then //se la scheda del dip. è firmata per l'anno guardo la flex
                  begin
                    if Pos(',',selT768Flex.FieldByName('FLESSIBILITA').AsString) > 0 then //Flex
                      Flex:='S'
                    else
                      Flex:='N';
                  end
                  else //altrimenti guardo se è firmata per l'anno prec.
                  begin
                    selT768Flex.Close;
                    selT768Flex.SetVariable('ANNO',R180Anno(InizioPeriodo)-1);
                    selT768Flex.Open;
                    if selT768Flex.RecordCount > 0 then
                    begin
                      if Pos(',',selT768Flex.FieldByName('FLESSIBILITA').AsString) > 0 then //Flex
                        Flex:='S'
                      else
                        Flex:='N';
                    end;
                  end;
                end;
                R180SetVariable(selSG735,'TIPOLOGIA','I');
                R180SetVariable(selSG735,'QUOTA',CodQuota);
                R180SetVariable(selSG735,'FLEX',Flex);
                R180SetVariable(selSG735,'DATARIF',InizioPeriodo);
                R180SetVariable(selSG735,'PERCRIF',PT);
                selSG735.Open;
                if selSG735.RecordCount > 0 then
                  PT:=selSG735.FieldByName('PERC').AsFloat;

                ElencoPT.Add(FloatToStr(PT) + '%');
                GiorniMese[R180Giorno(InizioPeriodo)].GG:=GiorniMese[R180Giorno(InizioPeriodo)].GG * PT / 100;
                GiorniMese[R180Giorno(InizioPeriodo)].QuotaGG:=GiorniMese[R180Giorno(InizioPeriodo)].QuotaGG * PT / 100;
                PT:=(PT / 100);
              end;
            end;
          end
          else
          begin
            s:='Part-time ' + QSIncentivi.FieldByName('T430PARTTIME').AsString +
               ' non esistente sulla tabella corrispondente (T460)';
            RegistraMsg.InserisciMessaggio('A',s,'',C700SelAnagrafe.FieldByName('PROGRESSIVO').AsInteger);
          end;
        end;
        GGPT:=GGPT + PT;
      end;
      InizioPeriodo:=InizioPeriodo + 1;
    end;
  end;
end;

procedure TA167FRegistraIncentivi.ElaboraAcconto(DataFine:TDateTime;Dal:TDateTime = 0;Al:TDateTime = 0);  //acconto oppure saldo I
var InizioPeriodo,FinePeriodo,OldData:TDateTime;
  OldCausale:String;
  QuotaAcc,AppInd,AppStrutt:Real;
begin
  with A167FRegistraIncentiviDtM do
  begin
    if TipoQuota = 'D' then
    begin
      InizioPeriodo:=Dal;
      FinePeriodo:=Al;
    end
    else
    begin
      InizioPeriodo:=R180InizioMese(MeseCorr);
      FinePeriodo:=MeseCorr;
    end;
    //Registrazione giornaliera cumulativa delle assenze
    MaturaIncentivi:=True;
    Decurta:=False;
    if (not selT040.Active) or
      ((selT040.Active) and
      ((selT040.GetVariable('PROG') <> C700Progressivo) or
       (selT040.GetVariable('ADATA') <> FinePeriodo) or
       (selT040.GetVariable('DATO1') <> Dato1) or
       (selT040.GetVariable('DATO2') <> Dato2) or
       (selT040.GetVariable('DATO3') <> Dato3))) then
    begin
      selT040.Close;
      selT040.SetVariable('PROG',C700Progressivo);
      selT040.SetVariable('DADATA',InizioPeriodo);
      selT040.SetVariable('ADATA',FinePeriodo);
      selT040.SetVariable('DATO1',Dato1);
      selT040.SetVariable('DATO2',Dato2);
      selT040.SetVariable('DATO3',Dato3);
      selT040.Open;
    end;
    if (not selT769.Active) or
      ((selT769.Active) and
      ((selT769.GetVariable('DATA') <> FinePeriodo) or
       (selT040.GetVariable('DATO1') <> Dato1) or
       (selT040.GetVariable('DATO2') <> Dato2) or
       (selT040.GetVariable('DATO3') <> Dato3))) then
    begin
      selT769.Close;
      selT769.SetVariable('DATA',FinePeriodo);
      selT769.SetVariable('DATO1',Dato1);
      selT769.SetVariable('DATO2',Dato2);
      selT769.SetVariable('DATO3',Dato3);
      selT769.Open;
    end;
    selT040.First;
    OldCausale:='';
    OldData:=0;
    if not AccontoValutativo then
      CreaTabellaAcconti;
    while not selT040.Eof do
    begin
      QSIncentivi.LocDatoStorico(selT040.FieldByName('DATA').AsDateTime); //Leggo i dati storici per trovare il PT
      if DSIncentivi.DipendenteInServizio(C700Progressivo,selT040.FieldByName('DATA').AsDateTime,selT040.FieldByName('DATA').AsDateTime) then
      begin
        ElaboraAssenzeGG(selT040.FieldByName('DATA').AsDateTime,OldData,DataFine,OldCausale);
        if not MaturaIncentivi then  //Rinnovo
          Break;
      end;
      OldCausale:=selT040.FieldByName('CAUSALE').AsString;
      OldData:=selT040.FieldByName('DATA').AsDateTime;
      selT040.Next;
    end;
    //Abbattimento GS
    GGProporzionata:=FinePeriodo - InizioPeriodo + 1 - GGSenzaRegole;
    if GGProporzionata < GGIntera then
    begin
      if (ProporzioneIncentivi = '0') and (GGProporzionata <= 15) then //Lavorato > 15gg
      begin
        GGProporzionata:=0;
        QuotaProporzionata:=0;
        AbbattimentoGS:=QuotaIntera;
      end
      else
      begin
        QuotaProporzionata:=QuotaIntera;
        AbbattimentoGS:=0;
      end;
      if (ProporzioneIncentivi = '1') and (GGIntera <> 0) then
      begin
        QuotaProporzionata:=QuotaIntera * GGProporzionata / GGIntera;
        AbbattimentoGS:=QuotaIntera - QuotaProporzionata;
      end;
    end
    else
    begin
      GGProporzionata:=GGIntera;
      QuotaProporzionata:=QuotaIntera;
      AbbattimentoGS:=0;
    end;
    if GGProporzionata <> 0 then
    begin
      if (GGProporzionata > GGPT) and (GGPT <> 0) then
      begin
        AbbattimentoPT:=QuotaProporzionata * (GGProporzionata - GGPT) / GGProporzionata;
        QuotaProporzionata:=QuotaProporzionata * GGPT / GGProporzionata;
        GGProporzionata:=GGPT;
      end;
      //Abbattimento Assenza
      if not MaturaIncentivi then  //Rinnovo
      begin
        if Decurta then
        begin
          GGAssenza:=GGProporzionata * 2;
          QuotaAssenza:=QuotaProporzionata * 2;
        end
        else
        begin
          GGAssenza:=GGProporzionata;
          QuotaAssenza:=QuotaProporzionata;
        end;
      end;
      if (GGProporzionata >= GGAssenza) or Decurta then
        GGNetta:=GGProporzionata - GGAssenza
      else
        GGNetta:=0;
      if (QuotaProporzionata >= QuotaAssenza) or Decurta then
      begin
        QuotaNetta:=QuotaProporzionata - QuotaAssenza;
        AbbattimentoAS:=QuotaAssenza;
      end
      else
      begin
        QuotaNetta:=0;
        AbbattimentoAS:=QuotaProporzionata;
      end;
    end;
    if (TipoQuota = 'A') or (TipoQuota = 'I') or (TipoQuota = 'D') then
      //Proporziono i giorni effettivi in base agli scaglioni
      if (ProporzioneIncentivi = '1') and (ScaglioniGgEff = 'S') then
      begin
        if GGProporzionata <> 0 then
          PercGGEff:=GGNetta * 100 / GGProporzionata
        else
          PercGGEff:=0;
        R180SetVariable(selSG735,'TIPOLOGIA','G');
        R180SetVariable(selSG735,'QUOTA',CodQuota);
        R180SetVariable(selSG735,'FLEX','*');
        R180SetVariable(selSG735,'DATARIF',MeseCorr);
        R180SetVariable(selSG735,'PERCRIF',PercGGEff);
        selSG735.Open;
        if selSG735.RecordCount > 0 then
          PercGGEff:=selSG735.FieldByName('PERC').AsFloat;
        GGNetta:=GGProporzionata * PercGGEff / 100;
        QuotaNetta:=QuotaProporzionata * PercGGEff / 100;
      end;
    if (TipoQuota = 'V') and AccontoValutativo then //Tolgo gli acconti già pagati
    begin
      TabellaAcconti.First;
      while not TabellaAcconti.Eof do
      begin
        //Proporzionamento su % di valutazione in base alle % di incidenza
        QuotaAcc:=TabellaAcconti.FieldByName('IMPORTO').AsFloat;
        if TabellaAcconti.FieldByName('TIPOIMPORTO').AsString = '1' then
        begin
          AppInd:=(QuotaIntera + QuotaAcc) * PesoIndivid / 100;
          if ValutIndivid <> 100 then
            AppInd:=AppInd * ValutIndivid / 100;
          AppStrutt:=(QuotaIntera + QuotaAcc) * PesoStrutt / 100;
          if ValutStrutt <> 100 then
            AppStrutt:=AppStrutt * ValutStrutt / 100;
          QuotaIntera:=AppInd + AppStrutt - QuotaAcc;
        end
        else if TabellaAcconti.FieldByName('TIPOIMPORTO').AsString = '2' then
        begin
          AppInd:=(QuotaProporzionata + QuotaAcc) * PesoIndivid / 100;
          if ValutIndivid <> 100 then
            AppInd:=AppInd * ValutIndivid / 100;
          AppStrutt:=(QuotaProporzionata + QuotaAcc) * PesoStrutt / 100;
          if ValutStrutt <> 100 then
            AppStrutt:=AppStrutt * ValutStrutt / 100;
          QuotaProporzionata:=AppInd + AppStrutt - QuotaAcc;
        end
        else if TabellaAcconti.FieldByName('TIPOIMPORTO').AsString = '3' then
        begin
          AppInd:=(QuotaNetta + QuotaAcc) * PesoIndivid / 100;
          if ValutIndivid <> 100 then
            AppInd:=AppInd * ValutIndivid / 100;
          AppStrutt:=(QuotaNetta + QuotaAcc) * PesoStrutt / 100;
          if ValutStrutt <> 100 then
            AppStrutt:=AppStrutt * ValutStrutt / 100;
          QuotaNetta:=AppInd + AppStrutt - QuotaAcc;
        end
        else //Abb.Assenze
        begin
          AppInd:=(QuotaAcc + TabellaAcconti.FieldByName('IMPASSSALDO').AsFloat) * PesoIndivid / 100;
          if ValutIndivid <> 100 then
            AppInd:=AppInd * ValutIndivid / 100;
          AppStrutt:=(QuotaAcc + TabellaAcconti.FieldByName('IMPASSSALDO').AsFloat) * PesoStrutt / 100;
          if ValutStrutt <> 100 then
            AppStrutt:=AppStrutt * ValutStrutt / 100;
          if chkAggiorna.Checked  then //registro abbattimento assenze
            RegistraMese(DataFine,GGAssenza,AppInd + AppStrutt - QuotaAcc,TabellaAcconti.FieldByName('TIPOIMPORTO').AsString);
          if Anteprima  then
            CaricaTabellaStampa(DataFine,GGAssenza,AppInd + AppStrutt - QuotaAcc,TabellaAcconti.FieldByName('TIPOIMPORTO').AsString);
        end;
        TabellaAcconti.Next;
      end;
    end;
    //-------  Registrazione quote
    if (TipoQuota = 'V') and not AccontoValutativo then
    begin
      CaricaTabellaAcconti(GGIntera,QuotaIntera,'1');
      CaricaTabellaAcconti(GGProporzionata,QuotaProporzionata,'2');
      CaricaTabellaAcconti(GGNetta,QuotaNetta,'3');
    end;
    if chkAggiorna.Checked then
    begin
      //------- Registrazione quote se acconto
      if TipoQuota = 'A' then
      begin
        RegistraMese(MeseCorr,GGIntera,QuotaIntera,'1');
        RegistraMese(MeseCorr,GGProporzionata,QuotaProporzionata,'2');
        RegistraMese(MeseCorr,GGNetta,QuotaNetta,'3');
        //------- Registrazione abbattimenti
        AbbattimentoGS:=R180Arrotonda(AbbattimentoGS,Decimali,'P');
        if AbbattimentoGS <> 0 then
          RegistraAbbattimenti(MeseCorr,AbbattimentoGS,'GS');
        AbbattimentoPT:=R180Arrotonda(AbbattimentoPT,Decimali,'P');
        if AbbattimentoPT <> 0 then
          RegistraAbbattimenti(MeseCorr,AbbattimentoPT,'PT');
        AbbattimentoAS:=R180Arrotonda(AbbattimentoAS,Decimali,'P');
        if AbbattimentoAS <> 0 then
          RegistraAbbattimenti(MeseCorr,AbbattimentoAS,'AS');
      end
      else if (TipoQuota = 'I') or ((TipoQuota = 'V') and AccontoValutativo) then
      begin
        RegistraMese(DataFine,GGIntera,QuotaIntera,'1');
        RegistraMese(DataFine,GGProporzionata,QuotaProporzionata,'2');
        RegistraMese(DataFine,GGNetta,QuotaNetta,'3');
        if (TipoQuota = 'I') and (MeseCorr = DataFine) then
        begin  //Proporziono su % di valutazione in base alle % di incidenza
          selT762.SearchRecord('MESE;CODTIPOQUOTA',VarArrayOf([R180Mese(DataFine),CodQuota]),[srFromBeginning]);
          while (not selT762.Eof) and
            (selT762.FieldByName('MESE').AsInteger = R180Mese(DataFine)) and
            (selT762.FieldByName('CODTIPOQUOTA').AsString = CodQuota) do
          begin
            AppInd:=selT762.FieldByName('IMPORTO').AsFloat * PesoIndivid / 100;
            if ValutIndivid <> 100 then
              AppInd:=AppInd * ValutIndivid / 100;
            AppStrutt:=selT762.FieldByName('IMPORTO').AsFloat * PesoStrutt / 100;
            if ValutStrutt <> 100 then
              AppStrutt:=AppStrutt * ValutStrutt / 100;
            AppInd:=AppInd + AppStrutt;
            if (selT774.RecordCount > 0) and (selT774.FieldByName('PESO').AsFloat > 0) then
            begin
              if TotMesiSaldoI <> 12 then
                AppInd:=AppInd * 12 / TotMesiSaldoI;
              AppInd:=AppInd * selT774.FieldByName('PESO').AsFloat;
            end;
            selT762.Edit;
            selT762.FieldByName('IMPORTO').AsFloat:=AppInd;
            selT762.Post;
            selT762.Next;
          end;
          SessioneOracle.Commit;
        end;
      end;
    end;
    if Anteprima then
    begin
      if TipoQuota = 'A' then
      begin
        CaricaTabellaStampa(MeseCorr,GGIntera,QuotaIntera,'1');
        CaricaTabellaStampa(MeseCorr,GGProporzionata,QuotaProporzionata,'2');
        CaricaTabellaStampa(MeseCorr,GGNetta,QuotaNetta,'3');
      end
      else if (TipoQuota = 'I') or ((TipoQuota = 'V') and AccontoValutativo) then
      begin
        CaricaTabellaStampa(DataFine,GGIntera,QuotaIntera,'1');
        CaricaTabellaStampa(DataFine,GGProporzionata,QuotaProporzionata,'2');
        CaricaTabellaStampa(DataFine,GGNetta,QuotaNetta,'3');
        if (TipoQuota = 'I') and (MeseCorr = DataFine) then
        begin  //Proporziono su % di valutazione in base alle % di incidenza
          TabellaStampa.Locate('ANNO;MESE;CODTIPOQUOTA',VarArrayOf([R180Anno(DataFine),R180Mese(DataFine),CodQuota]),[]);
          if (TabellaStampa.FieldByName('ANNO').AsInteger = R180Anno(DataFine)) and
            (TabellaStampa.FieldByName('MESE').AsInteger = R180Mese(DataFine)) and
            (TabellaStampa.FieldByName('CODTIPOQUOTA').AsString = CodQuota) then
          begin
            TabellaStampa.Edit;
            AppInd:=TabellaStampa.FieldByName('QuotaIntera').AsFloat * PesoIndivid / 100;
            if ValutIndivid <> 100 then
              AppInd:=AppInd * ValutIndivid / 100;
            AppStrutt:=TabellaStampa.FieldByName('QuotaIntera').AsFloat * PesoStrutt / 100;
            if ValutStrutt <> 100 then
              AppStrutt:=AppStrutt * ValutStrutt / 100;
            AppInd:=AppInd + AppStrutt;
            if (selT774.RecordCount > 0) and (selT774.FieldByName('PESO').AsFloat > 0) then
            begin
              if TotMesiSaldoI <> 12 then  //se i mesi sono <> 12 riproporziono la quota su tutto l'anno perchè il peso è annuale
                AppInd:=AppInd * 12 / TotMesiSaldoI;
              AppInd:=AppInd * selT774.FieldByName('PESO').AsFloat;
            end;
            TabellaStampa.FieldByName('QuotaIntera').AsFloat:=AppInd;
            AppInd:=TabellaStampa.FieldByName('QuotaProporzionata').AsFloat * PesoIndivid / 100;
            if ValutIndivid <> 100 then
              AppInd:=AppInd * ValutIndivid / 100;
            AppStrutt:=TabellaStampa.FieldByName('QuotaProporzionata').AsFloat * PesoStrutt / 100;
            if ValutStrutt <> 100 then
              AppStrutt:=AppStrutt * ValutStrutt / 100;
            AppInd:=AppInd + AppStrutt;
            if (selT774.RecordCount > 0) and (selT774.FieldByName('PESO').AsFloat > 0) then
            begin
              if TotMesiSaldoI <> 12 then
                AppInd:=AppInd * 12 / TotMesiSaldoI;
              AppInd:=AppInd * selT774.FieldByName('PESO').AsFloat;
            end;
            TabellaStampa.FieldByName('QuotaProporzionata').AsFloat:=AppInd;
            AppInd:=TabellaStampa.FieldByName('QuotaNetta').AsFloat * PesoIndivid / 100;
            if ValutIndivid <> 100 then
              AppInd:=AppInd * ValutIndivid / 100;
            AppStrutt:=TabellaStampa.FieldByName('QuotaNetta').AsFloat * PesoStrutt / 100;
            if ValutStrutt <> 100 then
              AppStrutt:=AppStrutt * ValutStrutt / 100;
            AppInd:=AppInd + AppStrutt;
            if (selT774.RecordCount > 0) and (selT774.FieldByName('PESO').AsFloat > 0) then
            begin
              if TotMesiSaldoI <> 12 then
                AppInd:=AppInd * 12 / TotMesiSaldoI;
              AppInd:=AppInd * selT774.FieldByName('PESO').AsFloat;
            end;
            TabellaStampa.FieldByName('QuotaNetta').AsFloat:=AppInd;
            AppInd:=TabellaStampa.FieldByName('QuotaNettaRisp').AsFloat * PesoIndivid / 100;
            if ValutIndivid <> 100 then
              AppInd:=AppInd * ValutIndivid / 100;
            AppStrutt:=TabellaStampa.FieldByName('QuotaNettaRisp').AsFloat * PesoStrutt / 100;
            if ValutStrutt <> 100 then
              AppStrutt:=AppStrutt * ValutStrutt / 100;
            AppInd:=AppInd + AppStrutt;
            if (selT774.RecordCount > 0) and (selT774.FieldByName('PESO').AsFloat > 0) then
            begin
              if TotMesiSaldoI <> 12 then
                AppInd:=AppInd * 12 / TotMesiSaldoI;
              AppInd:=AppInd * selT774.FieldByName('PESO').AsFloat;
            end;
            TabellaStampa.FieldByName('QuotaNettaRisp').AsFloat:=AppInd;
            AppInd:=TabellaStampa.FieldByName('AbbRispIncentivi').AsFloat * PesoIndivid / 100;
            if ValutIndivid <> 100 then
              AppInd:=AppInd * ValutIndivid / 100;
            AppStrutt:=TabellaStampa.FieldByName('AbbRispIncentivi').AsFloat * PesoStrutt / 100;
            if ValutStrutt <> 100 then
              AppStrutt:=AppStrutt * ValutStrutt / 100;
            AppInd:=AppInd + AppStrutt;
            if (selT774.RecordCount > 0) and (selT774.FieldByName('PESO').AsFloat > 0) then
            begin
              if TotMesiSaldoI <> 12 then
                AppInd:=AppInd * 12 / TotMesiSaldoI;
              AppInd:=AppInd * selT774.FieldByName('PESO').AsFloat;
            end;
            TabellaStampa.FieldByName('AbbRispIncentivi').AsFloat:=AppInd;
            AppInd:=TabellaStampa.FieldByName('AbbNoRispIncentivi').AsFloat * PesoIndivid / 100;
            if ValutIndivid <> 100 then
              AppInd:=AppInd * ValutIndivid / 100;
            AppStrutt:=TabellaStampa.FieldByName('AbbNoRispIncentivi').AsFloat * PesoStrutt / 100;
            if ValutStrutt <> 100 then
              AppStrutt:=AppStrutt * ValutStrutt / 100;
            AppInd:=AppInd + AppStrutt;
            if (selT774.RecordCount > 0) and (selT774.FieldByName('PESO').AsFloat > 0) then
            begin
              if TotMesiSaldoI <> 12 then
                AppInd:=AppInd * 12 / TotMesiSaldoI;
              AppInd:=AppInd * selT774.FieldByName('PESO').AsFloat;
            end;
            TabellaStampa.FieldByName('AbbNoRispIncentivi').AsFloat:=AppInd;
            TabellaStampa.Post;
          end;
        end;
      end;
    end;
  end;
end;

procedure TA167FRegistraIncentivi.ElaboraAssenzeGG(DataCorr,OldData,DataFine:TDateTime;OldCausale:String);
var QuotaAss,GGAss,Assenza,Q,HRese,TotAssenze,PercAbbattimento,PercAbbFranchigia,n,GGFranchigia:Real;
    G:TGiustificativo;
    UM,ContaFruitoOre,ForzaAbbGGInt,SoloGGInt,s:String;
    Inizio,Fine:TDateTime;
begin
  with A167FRegistraIncentiviDtM do
  begin
    //considerazione assenze
    ContaFruitoOre:=selT040.FieldByName('CONTA_FRUITO_ORE').AsString;
    ForzaAbbGGInt:=selT040.FieldByName('FORZA_ABB_GGINT').AsString;
    SoloGGInt:=selT040.FieldByName('CONTA_SOLO_GGINT').AsString;
    PercAbbattimento:=selT040.FieldByName('PERC_ABBATTIMENTO').AsFloat;
    PercAbbFranchigia:=selT040.FieldByName('PERC_ABB_FRANCHIGIA').AsFloat;
    //Cerco se la causale fa eccezione alle regole dell'accorpamento
    if selT769.SearchRecord('CAUSALE',selT040.FieldByname('CAUSALE').AsString,[srFromBeginning]) then
    begin
      ContaFruitoOre:=selT769.FieldByName('CONTA_FRUITO_ORE').AsString;
      ForzaAbbGGInt:=selT769.FieldByName('FORZA_ABB_GGINT').AsString;
      SoloGGInt:=selT769.FieldByName('CONTA_SOLO_GGINT').AsString;
      PercAbbattimento:=selT769.FieldByName('PERC_ABBATTIMENTO').AsFloat;
      PercAbbFranchigia:=selT769.FieldByName('PERC_ABB_FRANCHIGIA').AsFloat;
    end;
    //Proporzionamento dei gg. di franchigia sui giorni di servizio
    GGFranchigia:=selT040.FieldByName('FRANCHIGIA_ASSENZE').AsFloat;
    if selT040.FieldByName('PROPORZIONE_FRANCHIGIA').AsString = 'S' then
    begin
      if (selT040.FieldByName('GESTIONE_FRANCHIGIA').AsString = 'D')  or
         (selT040.FieldByName('GESTIONE_FRANCHIGIA').AsString = 'R') then
        Inizio:=Max(selT040.FieldByName('DECORRENZA').AsDateTime,StrToDate('01/01/' + IntToStr(R180Anno(DataCorr))))
      else
        Inizio:=StrToDate('01/01/' + IntToStr(R180Anno(DataCorr)));
      Fine:=Min(selT040.FieldByName('DECORRENZA_FINE').AsDateTime,StrToDate('31/12/' + IntToStr(R180Anno(DataCorr))));
      n:=Fine - Inizio + 1; //GG.totali di validità regola
      Inizio:=Max(Inizio,QSIncentivi.FieldByName('T430INIZIO').AsDateTime);
      if not QSIncentivi.FieldByName('T430FINE').IsNull then
        Fine:=Min(Fine,QSIncentivi.FieldByName('T430FINE').AsDateTime);
      if (Fine - Inizio + 1) <> n then
        GGFranchigia:=R180Arrotonda(GGFranchigia * (Fine - Inizio + 1) / n,1,'P');
    end;
    if (ContaFruitoOre = 'S') or
      ((ContaFruitoOre = 'N') and (selT040.FieldByName('TIPOGIUST').AsString = 'I')) then
    begin
      //Trovo la quota giornaliera guardando se ci sono quote individuali in quel giorno
      if ForzaAbbGGInt = 'S' then
        Assenza:=1
      else
      begin
        if selT040.FieldByName('TIPOGIUST').AsString = 'I' then
          Assenza:=1
        else if selT040.FieldByName('TIPOGIUST').AsString = 'M' then
          Assenza:=0.5
        else
        begin
          //R600
          G.Causale:=selT040.FieldByname('CAUSALE').AsString;
          G.Inserimento:=False;
          G.Modo:='I';
          R600DtM1.GetQuantitaAssenze(C700Progressivo,DataCorr,DataCorr,selT040.FieldByName('DATANAS').AsDateTime,G,UM,Q,HRese);
          if UM = '' then
          begin
            s:='Unità di misura non esistente per la causale ' + G.Causale;
            RegistraMsg.InserisciMessaggio('A',s,'',C700SelAnagrafe.FieldByName('PROGRESSIVO').AsInteger);
          end;
          if (UM = 'O') and (R600DtM1.ValenzaGiornaliera > 0) then
            Assenza:=Min(Q / R600DtM1.ValenzaGiornaliera,1)
          else
          begin
            if (R600DtM1.ValenzaGiornaliera > 0) and (HRese <> 0) and (R180Arrotonda(HRese / R600DtM1.ValenzaGiornaliera,0.1,'P') <> Q) then  //Lorena 02/02/2009
              Q:=HRese / R600DtM1.ValenzaGiornaliera;
            Assenza:=Min(Q,1);
          end;
        end;
        if (SoloGGInt = 'S') and (Assenza < 1) then
          Assenza:=0;
      end;
      if (DataCorr = OldData) and (selT040.FieldByName('CAUSALE').AsString = OldCausale) and (Assenza = 1) then
        Assenza:=0;
      if Assenza <> 0 then
      begin
        if TipoQuota = 'D' then
        begin
          GGAss:=Assenza * PercAbbattimento / 100;
          QuotaAss:=Assenza * PercAbbattimento / 100;
          GGAssenza:=GGAssenza + GGAss;
          QuotaAssenza:=QuotaAssenza + QuotaAss;
        end
        else if GGFranchigia = 0 then   //ass non toll
        begin
          GGAss:=Assenza * PercAbbattimento / 100 * GiorniMese[R180Giorno(DataCorr)].GG;
          QuotaAss:=Assenza * PercAbbattimento / 100 * GiorniMese[R180Giorno(DataCorr)].QuotaGG;
          GGAssenza:=GGAssenza + GGAss;
          QuotaAssenza:=QuotaAssenza + QuotaAss;
          if (Trim(selT040.FieldByName('TIPO_ABBATTIMENTO').AsString) <> '') and chkAggiorna.Checked  then //registro abbattimento assenze
          begin
            if TipoQuota = 'A' then
              RegistraMese(DataCorr,GGAss,QuotaAss,selT040.FieldByName('TIPO_ABBATTIMENTO').AsString)
            else if TipoQuota = 'I' then
              RegistraMese(DataFine,GGAss,QuotaAss,selT040.FieldByName('TIPO_ABBATTIMENTO').AsString);
          end;
          if (Trim(selT040.FieldByName('TIPO_ABBATTIMENTO').AsString) <> '') and Anteprima  then
          begin
            if TipoQuota = 'A' then
              CaricaTabellaStampa(DataCorr,GGAss,QuotaAss,selT040.FieldByName('TIPO_ABBATTIMENTO').AsString)
            else if TipoQuota = 'I' then
              CaricaTabellaStampa(DataFine,GGAss,QuotaAss,selT040.FieldByName('TIPO_ABBATTIMENTO').AsString);
          end;
          if (Trim(selT040.FieldByName('TIPO_ABBATTIMENTO').AsString) <> '') and (TipoQuota = 'V') then
            CaricaTabellaAcconti(GGAss,QuotaAss,selT040.FieldByName('TIPO_ABBATTIMENTO').AsString);
        end
        else  //Franchigia <> 0
        begin
          selT040A.Close;
          selT040A.SetVariable('PROG',selT040.FieldByName('PROGRESSIVO').AsInteger);
          if (selT040.FieldByName('GESTIONE_FRANCHIGIA').AsString = 'D') or
             (selT040.FieldByName('GESTIONE_FRANCHIGIA').AsString = 'R') then
            Inizio:=Max(QSIncentivi.FieldByName('T430INIZIO').AsDateTime,Max(selT040.FieldByName('DECORRENZA').AsDateTime,StrToDate('01/01/' + IntToStr(R180Anno(DataCorr)))))
          else
            Inizio:=Max(QSIncentivi.FieldByName('T430INIZIO').AsDateTime,StrToDate('01/01/' + IntToStr(R180Anno(DataCorr))));
          selT040A.SetVariable('DADATA',Inizio);
          if (selT040.FieldByName('GESTIONE_FRANCHIGIA').AsString = 'A') or
             (selT040.FieldByName('GESTIONE_FRANCHIGIA').AsString = 'D') then
            selT040A.SetVariable('ADATA',DataCorr)
          else //GESTIONE_FRANCHIGIA = 'R'
            selT040A.SetVariable('ADATA',R180FineMese(DataCorr));
          selT040A.SetVariable('TIPOACCORP',selT040.FieldByName('COD_TIPOACCORPCAUSALI').AsString);
          selT040A.SetVariable('CODACCORP',selT040.FieldByName('COD_CODICIACCORPCAUSALI').AsString);
          selT040A.SetVariable('ASSENZEAGG','''' + StringReplace(selT040.FieldByName('ASSENZE_AGGIUNTIVE').AsString,',',''',''',[rfReplaceAll]) + '''');
          selT040A.Open;
          TotAssenze:=0;
          //ciclo su tutte le assenze da inizio anno per vedere se rientro nella franchigia o meno
          while not selT040A.Eof do
          begin
            if (selT040A.FieldByname('CAUSALE').AsString <> selT040.FieldByname('CAUSALE').AsString) and
               (selT769.SearchRecord('CAUSALE',selT040A.FieldByname('CAUSALE').AsString,[srFromBeginning])) then
            //Cerco se la causale fa eccezione alle regole dell'accorpamento
            begin
              ContaFruitoOre:=selT769.FieldByName('CONTA_FRUITO_ORE').AsString;
              ForzaAbbGGInt:=selT769.FieldByName('FORZA_ABB_GGINT').AsString;
              SoloGGInt:=selT769.FieldByName('CONTA_SOLO_GGINT').AsString;
              PercAbbattimento:=selT769.FieldByName('PERC_ABBATTIMENTO').AsFloat;
              PercAbbFranchigia:=selT769.FieldByName('PERC_ABB_FRANCHIGIA').AsFloat;
            end;
            if (ForzaAbbGGInt = 'S') or (ContaFruitoOre = 'N') then
            begin
              A167FRegistraIncentiviMW.selSQL.SQL.Clear;
              A167FRegistraIncentiviMW.selSQL.SQL.Add('SELECT COUNT(DISTINCT DATA) FROM T040_GIUSTIFICATIVI');
              A167FRegistraIncentiviMW.selSQL.SQL.Add(' WHERE PROGRESSIVO = ' + IntToStr(C700Progressivo));
              A167FRegistraIncentiviMW.selSQL.SQL.Add('   AND CAUSALE = ''' + selT040A.FieldByname('CAUSALE').AsString + '''');
              if Trim(selT040A.FieldByname('DATANAS').AsString) <> '' then
                A167FRegistraIncentiviMW.selSQL.SQL.Add('   AND DATANAS = TO_DATE(''' + selT040A.FieldByname('DATANAS').AsString + ''',''DD/MM/YYYY HH24.MI.SS'')');
              A167FRegistraIncentiviMW.selSQL.SQL.Add('   AND DATA BETWEEN TO_DATE(''' + DateToStr(Inizio) + ''',''DD/MM/YYYY'')');
              A167FRegistraIncentiviMW.selSQL.SQL.Add('                AND TO_DATE(''' + DateToStr(DataCorr) + ''',''DD/MM/YYYY'')');
              if ContaFruitoOre = 'N' then
                A167FRegistraIncentiviMW.selSQL.SQL.Add('   AND TIPOGIUST = ''I''');
              A167FRegistraIncentiviMW.selSQL.Execute;
              TotAssenze:=TotAssenze + (StrToFloatDef(VarToStr(A167FRegistraIncentiviMW.selSQL.Field(0)),0) * PercAbbFranchigia / 100);
            end
            else
            begin
              G.Causale:=selT040A.FieldByname('CAUSALE').AsString;
              G.Inserimento:=False;
              G.Modo:='I';
              R600DtM1.GetQuantitaAssenze(C700Progressivo,StrToDateTime(VarToStr(selT040A.GetVariable('DADATA'))),
                StrToDateTime(VarToStr(selT040A.GetVariable('ADATA'))),selT040A.FieldByName('DATANAS').AsDateTime,G,UM,Q,HRese);
              if UM = '' then
              begin
                s:='Unità di misura non esistente per la causale ' + G.Causale;
                RegistraMsg.InserisciMessaggio('A',s,'',C700SelAnagrafe.FieldByName('PROGRESSIVO').AsInteger);
              end;
              if (UM = 'O') and (R600DtM1.ValenzaGiornaliera > 0) then
              begin
                if (SoloGGInt = 'N') or
                  ((SoloGGInt = 'S') and ((Q / R600DtM1.ValenzaGiornaliera) >= 1)) then
                  TotAssenze:=TotAssenze + ((Q / R600DtM1.ValenzaGiornaliera) * PercAbbFranchigia / 100)
              end
              else
              begin
                if (SoloGGInt = 'N') or
                  ((SoloGGInt = 'S') and (Q >= 1)) then
                  TotAssenze:=TotAssenze + (Q * PercAbbFranchigia / 100);
              end;
            end;
            selT040A.Next;
          end;

          if TotAssenze >= GGFranchigia then
          begin
            if ((selT040.FieldByName('GESTIONE_FRANCHIGIA').AsString = 'A') or
                (selT040.FieldByName('GESTIONE_FRANCHIGIA').AsString = 'D')) and
                (TotAssenze > GGFranchigia) then
            begin
              GGAss:=Assenza * PercAbbattimento / 100 * GiorniMese[R180Giorno(DataCorr)].GG;
              QuotaAss:=Assenza * PercAbbattimento / 100 * GiorniMese[R180Giorno(DataCorr)].QuotaGG;
              GGAssenza:=GGAssenza + GGAss;
              QuotaAssenza:=QuotaAssenza + QuotaAss;
              if (Trim(selT040.FieldByName('TIPO_ABBATTIMENTO').AsString) <> '') and chkAggiorna.Checked  then //registro abbattimento assenze
              begin
                if TipoQuota = 'A' then
                  RegistraMese(DataCorr,GGAss,QuotaAss,selT040.FieldByName('TIPO_ABBATTIMENTO').AsString)
                else if TipoQuota = 'I' then
                  RegistraMese(DataFine,GGAss,QuotaAss,selT040.FieldByName('TIPO_ABBATTIMENTO').AsString);
              end;
              if (Trim(selT040.FieldByName('TIPO_ABBATTIMENTO').AsString) <> '') and Anteprima  then
              begin
                if TipoQuota = 'A' then
                  CaricaTabellaStampa(DataCorr,GGAss,QuotaAss,selT040.FieldByName('TIPO_ABBATTIMENTO').AsString)
                else if TipoQuota = 'I' then
                  CaricaTabellaStampa(DataFine,GGAss,QuotaAss,selT040.FieldByName('TIPO_ABBATTIMENTO').AsString);
              end;
              if (Trim(selT040.FieldByName('TIPO_ABBATTIMENTO').AsString) <> '') and (TipoQuota = 'V') then
                CaricaTabellaAcconti(GGAss,QuotaAss,selT040.FieldByName('TIPO_ABBATTIMENTO').AsString);
            end
            else if selT040.FieldByName('GESTIONE_FRANCHIGIA').AsString = 'R' then
            begin
              if (TipoQuota = 'A') then
              begin
                n:=Trunc(TotAssenze/GGFranchigia);  //Calcolo le volte per le quali non dovrei dare incentivi
                A167FRegistraIncentiviMW.selSQL.SQL.Clear;  //Conto i mesi in cui non ho dato incentivi
                A167FRegistraIncentiviMW.selSQL.SQL.Add('SELECT COUNT(*) FROM T762_INCENTIVIMATURATI');
                A167FRegistraIncentiviMW.selSQL.SQL.Add(' WHERE PROGRESSIVO = ' + IntToStr(C700Progressivo));
                A167FRegistraIncentiviMW.selSQL.SQL.Add('   AND ANNO = ' + IntToStr(R180Anno(DataCorr)));
                A167FRegistraIncentiviMW.selSQL.SQL.Add('   AND MESE < ' + IntToStr(R180Mese(DataCorr)));
                A167FRegistraIncentiviMW.selSQL.SQL.Add('   AND MESE >= ' + IntToStr(R180Mese(Inizio)));
                A167FRegistraIncentiviMW.selSQL.SQL.Add('   AND TIPOIMPORTO = ''3'' AND IMPORTO = 0 AND CODTIPOQUOTA = ''' + CodQuota + '''');
                A167FRegistraIncentiviMW.selSQL.Execute;
                if n > StrToFloatDef(VarToStr(A167FRegistraIncentiviMW.selSQL.Field(0)),0) then
                begin
                  n:=n - StrToFloatDef(VarToStr(A167FRegistraIncentiviMW.selSQL.Field(0)),0);
                  A167FRegistraIncentiviMW.selSQL.SQL.Clear;  //Conto i mesi in cui ho decurtato
                  A167FRegistraIncentiviMW.selSQL.SQL.Add('SELECT COUNT(*) FROM T762_INCENTIVIMATURATI');
                  A167FRegistraIncentiviMW.selSQL.SQL.Add(' WHERE PROGRESSIVO = ' + IntToStr(C700Progressivo));
                  A167FRegistraIncentiviMW.selSQL.SQL.Add('   AND ANNO = ' + IntToStr(R180Anno(DataCorr)));
                  A167FRegistraIncentiviMW.selSQL.SQL.Add('   AND MESE < ' + IntToStr(R180Mese(DataCorr)));
                  A167FRegistraIncentiviMW.selSQL.SQL.Add('   AND MESE >= ' + IntToStr(R180Mese(Inizio)));
                  A167FRegistraIncentiviMW.selSQL.SQL.Add('   AND TIPOIMPORTO = ''3'' AND IMPORTO < 0 AND CODTIPOQUOTA = ''' + CodQuota + '''');
                  A167FRegistraIncentiviMW.selSQL.Execute;
                  if (n - (StrToFloatDef(VarToStr(A167FRegistraIncentiviMW.selSQL.Field(0)),0) * 2) > 0) then
                    MaturaIncentivi:=False;  //non dò incentivi
                  if (n - (StrToFloatDef(VarToStr(A167FRegistraIncentiviMW.selSQL.Field(0)),0) * 2) > 1) then
                    Decurta:=True;
                end;
              end
              else if (TipoQuota = 'I') or (TipoQuota = 'V') then
              begin
                A167FRegistraIncentiviMW.selSQL.SQL.Clear;  //Verifico se per quel mese ho dato l'acconto (importo > 0)
                A167FRegistraIncentiviMW.selSQL.SQL.Add('SELECT COUNT(*) FROM T762_INCENTIVIMATURATI T762, T765_TIPOQUOTE T765');
                A167FRegistraIncentiviMW.selSQL.SQL.Add(' WHERE T762.PROGRESSIVO = ' + IntToStr(C700Progressivo));
                A167FRegistraIncentiviMW.selSQL.SQL.Add('   AND T762.ANNO = ' + IntToStr(R180Anno(DataCorr)));
                A167FRegistraIncentiviMW.selSQL.SQL.Add('   AND T762.MESE = ' + IntToStr(R180Mese(DataCorr)));
                A167FRegistraIncentiviMW.selSQL.SQL.Add('   AND T762.TIPOIMPORTO = ''3'' AND T762.IMPORTO > 0 AND T762.CODTIPOQUOTA = T765.CODICE');
                A167FRegistraIncentiviMW.selSQL.SQL.Add('   AND T765.TIPOQUOTA = ''A'' AND T765.DECORRENZA = (');
                A167FRegistraIncentiviMW.selSQL.SQL.Add('       SELECT MAX(DECORRENZA) FROM T765_TIPOQUOTE');
                A167FRegistraIncentiviMW.selSQL.SQL.Add('        WHERE CODICE = T765.CODICE');
                A167FRegistraIncentiviMW.selSQL.SQL.Add('          AND DECORRENZA <= TO_DATE(''' + DateToStr(DataCorr) + ''',''DD/MM/YYYY''))');
                A167FRegistraIncentiviMW.selSQL.Execute;
                if StrToFloatDef(VarToStr(A167FRegistraIncentiviMW.selSQL.Field(0)),0) <= 0 then
                  MaturaIncentivi:=False;
                A167FRegistraIncentiviMW.selSQL.SQL.Clear;  //Verifico se per quel mese ho decurtato l'acconto (importo < 0)
                A167FRegistraIncentiviMW.selSQL.SQL.Add('SELECT COUNT(*) FROM T762_INCENTIVIMATURATI T762, T765_TIPOQUOTE T765');
                A167FRegistraIncentiviMW.selSQL.SQL.Add(' WHERE T762.PROGRESSIVO = ' + IntToStr(C700Progressivo));
                A167FRegistraIncentiviMW.selSQL.SQL.Add('   AND T762.ANNO = ' + IntToStr(R180Anno(DataCorr)));
                A167FRegistraIncentiviMW.selSQL.SQL.Add('   AND T762.MESE = ' + IntToStr(R180Mese(DataCorr)));
                A167FRegistraIncentiviMW.selSQL.SQL.Add('   AND T762.TIPOIMPORTO = ''3'' AND T762.IMPORTO < 0 AND T762.CODTIPOQUOTA = T765.CODICE');
                A167FRegistraIncentiviMW.selSQL.SQL.Add('   AND T765.TIPOQUOTA = ''A'' AND T765.DECORRENZA = (');
                A167FRegistraIncentiviMW.selSQL.SQL.Add('       SELECT MAX(DECORRENZA) FROM T765_TIPOQUOTE');
                A167FRegistraIncentiviMW.selSQL.SQL.Add('        WHERE CODICE = T765.CODICE');
                A167FRegistraIncentiviMW.selSQL.SQL.Add('          AND DECORRENZA <= TO_DATE(''' + DateToStr(DataCorr) + ''',''DD/MM/YYYY''))');
                A167FRegistraIncentiviMW.selSQL.Execute;
                if StrToFloatDef(VarToStr(A167FRegistraIncentiviMW.selSQL.Field(0)),0) > 0 then
                  Decurta:=True;
              end;
            end;
          end;
        end;
      end;
    end;
  end;
end;

procedure TA167FRegistraIncentivi.CancellaMese(Data:TDateTime);
begin
  with A167FRegistraIncentiviDtM do
  begin
    if selDatiBloccati.DatoBloccato(C700Progressivo,R180InizioMese(Data),'T762') then
      exit;
    selT762.SearchRecord('MESE;CODTIPOQUOTA',VarArrayOf([R180Mese(Data),CodQuota]),[srFromBeginning]);
    while (not selT762.Eof) and
      (selT762.FieldByName('MESE').AsInteger = R180Mese(Data)) and
      (selT762.FieldByName('CODTIPOQUOTA').AsString = CodQuota) do
    begin
      if (selT762.FieldByName('VARIAZIONI').AsFloat = 0) then
        selT762.Delete
      else
      begin
        selT762.Edit;
        selT762.FieldByName('Giorni_Ore').AsFloat:=0;
        selT762.FieldByName('Importo').AsFloat:=0;
        selT762.Post;
        RegistraMsg.InserisciMessaggio('A','Per il mese ' + DateToStr(Data) + ' sono presenti Variazioni manuali che NON sono state cancellate','',C700SelAnagrafe.FieldByName('PROGRESSIVO').AsInteger);
        selT762.Next;
      end;
    end;
    while selT763.SearchRecord('MESE;TIPOQUOTA',VarArrayOf([R180Mese(Data),CodQuota]),[srFromBeginning]) do
      selT763.Delete;
    if TipoQuota = 'Q' then
    begin
      //pulisco schede riepilogative
      selT070.Close;
      selT070.SetVariable('PROG',C700Progressivo);
      selT070.SetVariable('DATA',R180InizioMese(Data));
      selT070.Open;
      selT071.Close;
      selT071.SetVariable('PROG',C700Progressivo);
      selT071.SetVariable('DATA',R180InizioMese(Data));
      selT071.Open;
      if selT070.RecordCount > 0 then
      begin
        if selT070.FieldByName('CAUSALE1MINASS').AsString = VarToStr(A167FRegistraIncentiviMW.selT765.Lookup('CODICE',CodQuota,'CAUSALE_ASSESTAMENTO')) then
        begin
          selT070.Edit;
          selT070.FieldByName('CAUSALE1MINASS').AsString:='';
          RegistraLog.SettaProprieta('M','T070_SCHEDARIEPIL',CodForm,selT070,True);
          selT070.Post;
          RegistraLog.RegistraOperazione;
          selT071.Edit;
          selT071.FieldByName('ORE1ASSEST').AsString:='';
          RegistraLog.SettaProprieta('M','T071_SCHEDAFASCE',CodForm,selT071,True);
          selT071.Post;
          RegistraLog.RegistraOperazione;
        end;
        if selT070.FieldByName('CAUSALE2MINASS').AsString = VarToStr(A167FRegistraIncentiviMW.selT765.Lookup('CODICE',CodQuota,'CAUSALE_ASSESTAMENTO')) then
        begin
          selT070.Edit;
          selT070.FieldByName('CAUSALE2MINASS').AsString:='';
          RegistraLog.SettaProprieta('M','T070_SCHEDARIEPIL',CodForm,selT070,True);
          selT070.Post;
          RegistraLog.RegistraOperazione;
          selT071.Edit;
          selT071.FieldByName('ORE2ASSEST').AsString:='';
          RegistraLog.SettaProprieta('M','T071_SCHEDAFASCE',CodForm,selT071,True);
          selT071.Post;
          RegistraLog.RegistraOperazione;
        end;
      end;
    end;
    SessioneOracle.Commit;
  end;
end;

procedure TA167FRegistraIncentivi.RegistraMese(Data:TDateTime; Giorni,Quota:Real; TipoImporto:String);
var nGiorni,nQuota:Real;
begin
  with A167FRegistraIncentiviDtM do
  begin
    if selDatiBloccati.DatoBloccato(C700Progressivo,R180InizioMese(Data),'T762') then
      exit;
    nGiorni:=0;
    nQuota:=0;
    selT762.Refresh;  //Refresh prima di operare
    selT762Risp.Refresh;
    if selT762.SearchRecord('MESE;CODTIPOQUOTA;TIPOIMPORTO',VarArrayOf([R180Mese(Data),CodQuota,TipoImporto]),[srFromBeginning]) then
    begin
      nGiorni:=selT762.FieldByName('Giorni_Ore').AsFloat;
      nQuota:=selT762.FieldByName('Importo').AsFloat;
      selT762.Edit;
    end
    else
      selT762.Insert;
    selT762.FieldByName('Progressivo').AsInteger:=C700Progressivo;
    selT762.FieldByName('Anno').AsInteger:=R180Anno(Data);
    selT762.FieldByName('Mese').AsInteger:=R180Mese(Data);
    selT762.FieldByName('Giorni_Ore').AsFloat:=nGiorni + Giorni;
    selT762.FieldByName('Importo').AsFloat:=nQuota + Quota;
    selT762.FieldByName('TipoCalcolo').AsString:=TipoCalcolo;
    selT762.FieldByName('CodTipoQuota').AsString:=CodQuota;
    selT762.FieldByName('TipoImporto').AsString:=TipoImporto;
    selT762.Post;
    if (TipoImporto = '3') and (CodQuota <> '_') and (TipoQuota <> 'C') then
    begin
      nQuota:=selT762.FieldByName('Importo').AsFloat;
      nGiorni:=selT762.FieldByName('Giorni_Ore').AsFloat;
      if selT762.SearchRecord('ANNO;MESE;CODTIPOQUOTA;TIPOIMPORTO',VarArrayOf([R180Anno(Data),R180Mese(Data),CodQuota,'4']),[srFromBeginning]) then
        selT762.Edit
      else
        selT762.Insert;
      selT762.FieldByName('Progressivo').AsInteger:=C700Progressivo;
      selT762.FieldByName('Anno').AsInteger:=R180Anno(Data);
      selT762.FieldByName('Mese').AsInteger:=R180Mese(Data);
      selT762.FieldByName('TipoCalcolo').AsString:=TipoCalcolo;
      selT762.FieldByName('CodTipoQuota').AsString:=CodQuota;
      selT762.FieldByName('TipoImporto').AsString:='4';
(*      selT762Risp.Close;
      selT762Risp.SetVariable('PROG',C700Progressivo);
      selT762Risp.SetVariable('ANNO',R180Anno(Data));
      selT762Risp.SetVariable('MESE',R180Mese(Data));
      selT762Risp.SetVariable('QUOTA',CodQuota);
      selT762Risp.Open;
      if (selT762Risp.FieldByName('GIORNI_ORE').AsFloat > 0) or (selT762Risp.FieldByName('IMPORTO').AsFloat > 0) then*)
      if selT762Risp.SearchRecord('MESE;CODTIPOQUOTA',VarArrayOf([R180Mese(Data),CodQuota]),[srFromBeginning]) and
         ((selT762Risp.FieldByName('GIORNI_ORE').AsFloat > 0) or (selT762Risp.FieldByName('IMPORTO').AsFloat > 0)) then
      begin
        selT762.FieldByName('Giorni_Ore').AsFloat:=nGiorni + selT762Risp.FieldByName('GIORNI_ORE').AsFloat;
        selT762.FieldByName('Importo').AsFloat:=nQuota + selT762Risp.FieldByName('IMPORTO').AsFloat;
      end
      else
      begin
        selT762.FieldByName('Giorni_Ore').AsFloat:=nGiorni;
        selT762.FieldByName('Importo').AsFloat:=nQuota;
      end;
      selT762.Post;
    end;
    SessioneOracle.Commit;
  end;
end;

procedure TA167FRegistraIncentivi.CaricaTabellaAcconti(Giorni,Quota:Real; TipoImporto:String);
var nGiorni,nQuota:Real;
begin
  with A167FRegistraIncentiviDtM do
  begin
    nGiorni:=0;
    nQuota:=0;
    if TabellaAcconti.Locate('TIPOIMPORTO',VarArrayOf([TipoImporto]),[]) then
    begin
      nGiorni:=TabellaAcconti.FieldByName('Giorni_Ore').AsFloat;
      if AccontoValutativo then
        nQuota:=TabellaAcconti.FieldByName('ImpAssSaldo').AsFloat
      else
        nQuota:=TabellaAcconti.FieldByName('Importo').AsFloat;
      TabellaAcconti.Edit;
    end
    else
      TabellaAcconti.Insert;
    TabellaAcconti.FieldByName('Giorni_Ore').AsFloat:=nGiorni + Giorni;
    if AccontoValutativo then
      TabellaAcconti.FieldByName('ImpAssSaldo').AsFloat:=nQuota + Quota
    else
      TabellaAcconti.FieldByName('Importo').AsFloat:=nQuota + Quota;
    TabellaAcconti.FieldByName('TipoImporto').AsString:=TipoImporto;
    TabellaAcconti.Post;
    SessioneOracle.Commit;
  end;
end;

procedure TA167FRegistraIncentivi.Arrotondamento(Data:TDateTime);
begin  //Arrotondo tutte le quote registrate per ogni dip per ogni mese
  with A167FRegistraIncentiviDtM do
  begin
    if chkAggiorna.Checked then
    begin
      if selDatiBloccati.DatoBloccato(C700Progressivo,R180InizioMese(Data),'T762') then
        exit;
      selT762.SearchRecord('MESE',R180Mese(Data),[srFromBeginning]);
      while not selT762.Eof and
        (selT762.FieldByName('MESE').AsInteger = R180Mese(Data)) do
      begin
        selT762.Edit;
        selT762.FieldByName('Giorni_Ore').AsFloat:=R180Arrotonda(selT762.FieldByName('Giorni_Ore').AsFloat,0.01,'P');
        selT762.FieldByName('Importo').AsFloat:=R180Arrotonda(selT762.FieldByName('Importo').AsFloat,Decimali,'P');
        selT762.Post;
        selT762.Next;
      end;
    end;
    if Anteprima then
    begin
      TabellaStampa.First;
      while not TabellaStampa.Eof do
      begin
        TabellaStampa.Edit;
        TabellaStampa.FieldByName('QuotaIntera').AsFloat:=R180Arrotonda(TabellaStampa.FieldByName('QuotaIntera').AsFloat,Decimali,'P');
        TabellaStampa.FieldByName('QuotaProporzionata').AsFloat:=R180Arrotonda(TabellaStampa.FieldByName('QuotaProporzionata').AsFloat,Decimali,'P');
        TabellaStampa.FieldByName('QuotaNetta').AsFloat:=R180Arrotonda(TabellaStampa.FieldByName('QuotaNetta').AsFloat,Decimali,'P');
        TabellaStampa.FieldByName('QuotaNettaRisp').AsFloat:=R180Arrotonda(TabellaStampa.FieldByName('QuotaNettaRisp').AsFloat,Decimali,'P');
        TabellaStampa.FieldByName('AbbRispIncentivi').AsFloat:=R180Arrotonda(TabellaStampa.FieldByName('AbbRispIncentivi').AsFloat,Decimali,'P');
        TabellaStampa.FieldByName('AbbNoRispIncentivi').AsFloat:=R180Arrotonda(TabellaStampa.FieldByName('AbbNoRispIncentivi').AsFloat,Decimali,'P');
        TabellaStampa.Post;
        TabellaStampa.Next;
      end;
    end;
  end;
end;

procedure TA167FRegistraIncentivi.RegistraAbbattimenti(Data:TDateTime; Quota:Real; TipoAbb:String);
begin
  with A167FRegistraIncentiviDtM do
  begin
    if selDatiBloccati.DatoBloccato(C700Progressivo,R180InizioMese(Data),'T762') then
      exit;
    selT763.Insert;
    selT763.FieldByName('progressivo').AsInteger:=C700Progressivo;
    selT763.FieldByName('anno').AsInteger:=R180Anno(Data);
    selT763.FieldByName('mese').AsInteger:=R180Mese(Data);
    selT763.FieldByName('tipoquota').AsString:=CodQuota;
    selT763.FieldByName('tipoabbattimento').AsString:=TipoAbb;
    selT763.FieldByName('meseapplicazioneabbattimento').AsDateTime:=R180InizioMese(StrToDate('01/' + edtAData.Text));
    selT763.FieldByName('quotaabbattimento').AsFloat:=Quota;
    selT763.Post;
    SessioneOracle.Commit;
  end;
end;

procedure TA167FRegistraIncentivi.btnAnomalieClick(Sender: TObject);
begin
  frmSelAnagrafe.SalvaC00SelAnagrafe;
  C700Distruzione;
  OpenA083MsgElaborazioni(Parametri.Azienda,Parametri.Operatore,CodForm,'');
  C700DatiSelezionati:=C700CampiBase;
  C700Creazione(SessioneOracle);
  frmSelAnagrafe.RipristinaC00SelAnagrafe;
end;

procedure TA167FRegistraIncentivi.BtnAnteprimaClick(Sender: TObject);
begin
  CreaTabellaStampa(A167FRegistraIncentiviDtM.TabellaStampa);
  with A167FRegistraIncentiviDtM do
  begin
    A167FRegistraIncentiviMW.selSQL.SQL.Clear;
    A167FRegistraIncentiviMW.selSQL.SQL.Add('SELECT MAX(LENGTH(CODICE)) FROM T765_TIPOQUOTE');
    A167FRegistraIncentiviMW.selSQL.Execute;
    Lung:=A167FRegistraIncentiviMW.selSQL.FieldAsInteger(0);
  end;
  btnAggiornamentoClick(Sender);
  if not chkDettaglio.Checked then
  begin
    CreaTabellaStampa(A167FRegistraIncentiviDtM.TabellaStampaTotali);
    TotalizzaTabellaStampa;
  end;
  A167FStampaIncentivi:=TA167FStampaIncentivi.Create(nil);
  C001SettaQuickReport(A167FStampaIncentivi.QRep);
  A167FStampaIncentivi.QRep.Page.Orientation:=poLandScape;
  A167FStampaIncentivi.qrlblPartTime.Enabled:=TipoQuota <> 'C';
  if (TipoCalcolo = 'C') and (rgpTipoDati.ItemIndex = 0) then
    A167FStampaIncentivi.Valuta:=A167FRegistraIncentiviDtM.selP030.FieldByName('ABBREVIAZIONE').AsString
  else
    A167FStampaIncentivi.Valuta:='GG';
  if chkDettaglio.Checked then
    A167FStampaIncentivi.QRep.Dataset:=A167FRegistraIncentiviDtM.TabellaStampa
  else
    A167FStampaIncentivi.QRep.Dataset:=A167FRegistraIncentiviDtM.TabellaStampaTotali;

  if (TipoModulo = 'COM') and (Trim(DocumentoPDF) <> '') and (Trim(DocumentoPDF) <> '<VUOTO>') then
  begin
    A167FStampaIncentivi.QRep.ShowProgress:=False;
    A167FStampaIncentivi.QRep.ExportToFilter(TQRPDFDocumentFilter.Create(DocumentoPDF));
  end
  else
  begin
    if Sender = btnAnteprima then
      A167FStampaIncentivi.QRep.Preview
    else
      A167FStampaIncentivi.QRep.Print;
  end;
  FreeAndNil(A167FStampaIncentivi);
end;

procedure TA167FRegistraIncentivi.CreaTabellaStampa(DataSet:TClientDataset);
begin
  with A167FRegistraIncentiviDtM do
  begin
    DataSet.Close;
    DataSet.FieldDefs.Clear;
    DataSet.FieldDefs.Add('Raggruppamento',ftString,100,False);
    DataSet.FieldDefs.Add('Progressivo',ftInteger,0,False);
    DataSet.FieldDefs.Add('Matricola',ftString,8,False);
    DataSet.FieldDefs.Add('Badge',ftInteger,0,False);
    DataSet.FieldDefs.Add('Nome',ftString,60,False);
    DataSet.FieldDefs.Add('PartTime',ftString,30,False);
    DataSet.FieldDefs.Add('Anno',ftInteger,0,False);
    DataSet.FieldDefs.Add('Mese',ftInteger,0,False);
    DataSet.FieldDefs.Add('CodTipoQuota',ftString,5,False);
    DataSet.FieldDefs.Add('DescTipoQuota',ftString,50,False);
    DataSet.FieldDefs.Add('QuotaIntera',ftFloat,0,False);
    DataSet.FieldDefs.Add('VarQuotaIntera',ftString,1,False);
    DataSet.FieldDefs.Add('QuotaProporzionata',ftFloat,0,False);
    DataSet.FieldDefs.Add('VarQuotaProporzionata',ftString,1,False);
    DataSet.FieldDefs.Add('QuotaNetta',ftFloat,0,False);
    DataSet.FieldDefs.Add('VarQuotaNetta',ftString,1,False);
    DataSet.FieldDefs.Add('QuotaNettaRisp',ftFloat,0,False);
    DataSet.FieldDefs.Add('VarQuotaNettaRisp',ftString,1,False);
    DataSet.FieldDefs.Add('AbbRispIncentivi',ftFloat,0,False);
    DataSet.FieldDefs.Add('VarAbbRispIncentivi',ftString,1,False);
    DataSet.FieldDefs.Add('AbbNoRispIncentivi',ftFloat,0,False);
    DataSet.FieldDefs.Add('VarAbbNoRispIncentivi',ftString,1,False);
    DataSet.IndexDefs.Clear;
    DataSet.IndexDefs.Add('Primario',('Raggruppamento;Nome;Badge;Progressivo;Anno;Mese;CodTipoQuota'),[ixUnique]);
    DataSet.IndexName:='Primario';
    DataSet.CreateDataSet;
    DataSet.LogChanges:=False;
    DataSet.Filter:='';
    DataSet.Filtered:=False;
  end;
end;

procedure TA167FRegistraIncentivi.CreaTabellaAcconti;
begin
  with A167FRegistraIncentiviDtM do
  begin
    TabellaAcconti.Close;
    TabellaAcconti.FieldDefs.Clear;
    TabellaAcconti.FieldDefs.Add('TipoImporto',ftString,5,False);
    TabellaAcconti.FieldDefs.Add('Importo',ftFloat,0,False);
    TabellaAcconti.FieldDefs.Add('ImpAssSaldo',ftFloat,0,False);
    TabellaAcconti.FieldDefs.Add('Giorni_Ore',ftFloat,0,False);
    TabellaAcconti.IndexDefs.Clear;
    TabellaAcconti.IndexDefs.Add('Primario',('TipoImporto'),[ixUnique]);
    TabellaAcconti.IndexName:='Primario';
    TabellaAcconti.CreateDataSet;
    TabellaAcconti.LogChanges:=False;
  end;
end;

procedure TA167FRegistraIncentivi.CreaTabellaTipoD;
begin
  with A167FRegistraIncentiviDtM do
  begin
    TabellaTipoD.Close;
    TabellaTipoD.FieldDefs.Clear;
    TabellaTipoD.FieldDefs.Add('Progressivo',ftInteger,0,False);
    TabellaTipoD.FieldDefs.Add('CodTipoQuota',ftString,5,False);
    TabellaTipoD.FieldDefs.Add('Quota_Ind',ftFloat,0,False);
    TabellaTipoD.FieldDefs.Add('Dal_Scheda',ftDateTime,0,False);
    TabellaTipoD.FieldDefs.Add('Al_Scheda',ftDateTime,0,False);
    TabellaTipoD.FieldDefs.Add('Giorni_Scheda_Teorici',ftFloat,0,False);
    TabellaTipoD.FieldDefs.Add('Giorni_Senza_Rapporto',ftFloat,0,False);
    TabellaTipoD.FieldDefs.Add('Giorni_Scheda_Effettivi',ftFloat,0,False);
    TabellaTipoD.FieldDefs.Add('Perc_Giorni_Scheda',ftFloat,0,False);
    TabellaTipoD.FieldDefs.Add('Giorni_Assenza',ftFloat,0,False);
    TabellaTipoD.FieldDefs.Add('Giorni_Presenza',ftFloat,0,False);
    TabellaTipoD.FieldDefs.Add('Perc_Giorni_Presenza',ftFloat,0,False);
    TabellaTipoD.FieldDefs.Add('Fascia_Giorni_Presenza',ftFloat,0,False);
    TabellaTipoD.FieldDefs.Add('Inizio',ftDateTime,0,False);
    TabellaTipoD.FieldDefs.Add('Fine',ftDateTime,0,False);
    TabellaTipoD.FieldDefs.Add('Giorni_Lavorati',ftInteger,0,False);
    TabellaTipoD.FieldDefs.Add('Perc_Giorni_Lavorati',ftFloat,0,False);
    TabellaTipoD.FieldDefs.Add('Dal_Dettaglio',ftDateTime,0,False);
    TabellaTipoD.FieldDefs.Add('Al_Dettaglio',ftDateTime,0,False);
    TabellaTipoD.FieldDefs.Add('Giorni_Dettaglio',ftInteger,0,False);
    TabellaTipoD.FieldDefs.Add('Perc_Giorni_Dettaglio',ftFloat,0,False);
    TabellaTipoD.FieldDefs.Add('PartTime',ftString,5,False);
    TabellaTipoD.FieldDefs.Add('Perc_PartTime',ftFloat,0,False);
    TabellaTipoD.FieldDefs.Add('Fascia_PartTime',ftFloat,0,False);
    TabellaTipoD.FieldDefs.Add('Dato1_Anagrafe',ftString,20,False);
    TabellaTipoD.FieldDefs.Add('Dato2_Anagrafe',ftString,20,False);
    TabellaTipoD.FieldDefs.Add('Dato3_Anagrafe',ftString,20,False);
    TabellaTipoD.FieldDefs.Add('Dato1_QuotaSaldo',ftString,20,False);
    TabellaTipoD.FieldDefs.Add('Dato2_QuotaSaldo',ftString,20,False);
    TabellaTipoD.FieldDefs.Add('Dato3_QuotaSaldo',ftString,20,False);
    TabellaTipoD.FieldDefs.Add('Fondo_QuotaSaldo',ftFloat,0,False);
    TabellaTipoD.FieldDefs.Add('Solo_QuotaSaldo',ftString,1,False);
    TabellaTipoD.FieldDefs.Add('Quota_Acconti',ftFloat,0,False);
    TabellaTipoD.FieldDefs.Add('Numeri_Dettaglio',ftFloat,0,False);
    TabellaTipoD.FieldDefs.Add('Numeri_TotFondo',ftFloat,0,False);
    TabellaTipoD.FieldDefs.Add('Peso_Dettaglio',ftFloat,0,False);
    TabellaTipoD.FieldDefs.Add('Saldo',ftFloat,0,False);
    TabellaTipoD.FieldDefs.Add('Data_Registrazione',ftDateTime,0,False);
    TabellaTipoD.IndexDefs.Clear;
    TabellaTipoD.IndexDefs.Add('Primario',('Progressivo;CodTipoQuota;Dal_Scheda;Inizio;Dal_Dettaglio'),[ixUnique]);
    TabellaTipoD.IndexDefs.Add('QuotaSaldo',('CodTipoQuota;Dato1_QuotaSaldo;Dato2_QuotaSaldo;Dato3_QuotaSaldo'),[]);
    TabellaTipoD.IndexName:='Primario';
    TabellaTipoD.CreateDataSet;
    TabellaTipoD.LogChanges:=False;
  end;
end;

procedure TA167FRegistraIncentivi.CaricaTabellaTipoD(DataReg:TDateTime);
var i,GiorniAnno:Integer;
    DApp,Dal_Scheda,Al_Scheda:TDateTime;
    PT:Real;
    lstAcconti:TStringList;
    Esiste:Boolean;
    PTold,Dato1old,Dato2old,Dato3old:String;
begin
  GiorniAnno:=DaysBetween(DataF,R180InizioMese(DataI)) + 1;
  with A167FRegistraIncentiviDtM do
  begin
    //Cerco e scorro le quote relative alle schede di valutazione
    R180SetVariable(selT775,'PROGRESSIVO',C700Progressivo);
    R180SetVariable(selT775,'DINI',R180InizioMese(DataI));
    R180SetVariable(selT775,'DFIN',DataF);
    selT775.Open;
    selT775.First;
    if selT775.SearchRecord('CODTIPOQUOTA',CodQuota,[srFromBeginning]) then
      while (not selT775.Eof) and (selT775.FieldByName('CODTIPOQUOTA').AsString = CodQuota) do
      begin
        Dal_Scheda:=Max(selT775.FieldByName('DECORRENZA').AsDateTime,R180InizioMese(DataI));
        Al_Scheda:=Min(selT775.FieldByName('SCADENZA').AsDateTime,DataF);
        Azzeramento;
        GGIntera:=selT775.FieldByName('GIORNI').AsInteger;//serve in ElaboraAcconto
        QSIncentivi.LocDatoStorico(Al_Scheda); //Leggo i dati storici a fine mese
        if Parametri.CampiRiferimento.C7_Dato1 <> '' then
          Dato1:=QSIncentivi.FieldByName('T430' + Parametri.CampiRiferimento.C7_Dato1).AsString;
        if Parametri.CampiRiferimento.C7_Dato2 <> '' then
          Dato2:=QSIncentivi.FieldByName('T430' + Parametri.CampiRiferimento.C7_Dato2).AsString;
        if Parametri.CampiRiferimento.C7_Dato3 <> '' then
          Dato3:=QSIncentivi.FieldByName('T430' + Parametri.CampiRiferimento.C7_Dato3).AsString;
        //Leggo le regole di calcolo a fine scheda
        R180SetVariable(selT760,'LIVELLO',Dato1);
        R180SetVariable(selT760,'DECORRENZA',Al_Scheda);
        selT760.Open;
        TipoCalcolo:=selT760.FieldByName('TIPO').AsString;
        TipoQuoteQuant:=selT760.FieldByName('TIPO_QUOTEQUANT').AsString;
        MaxPenalizzazione:=selT760.FieldByName('ABBATTIMENTO_MAX').AsFloat;
        ProporzioneIncentivi:=selT760.FieldByName('PROPORZIONE_INCENTIVI').AsString;
        ProporzionePT:=selT760.FieldByName('PROPORZIONE_PARTTIME').AsString;
        ScaglioniGgEff:=selT760.FieldByName('SCAGLIONI_GGEFF').AsString;
        //Cerco e scorro i periodi di rapporto lavorativo
        selT430Lav.Close;
        selT430Lav.SetVariable('PROGRESSIVO',C700Progressivo);
        selT430Lav.SetVariable('DAL',Dal_Scheda);
        selT430Lav.SetVariable('AL',Al_Scheda);
        selT430Lav.Open;
        GGSenzaRegole:=0;//serve in ElaboraAcconto
        DApp:=Dal_Scheda;
        while not selT430Lav.Eof do
        begin
          GGSenzaRegole:=GGSenzaRegole + DaysBetween(selT430Lav.FieldByName('INI').AsDateTime,DApp);
          DApp:=selT430Lav.FieldByName('FIN').AsDateTime + 1;
          selT430Lav.Next;
        end;
        GGSenzaRegole:=GGSenzaRegole + DaysBetween(Al_Scheda,DApp - 1);//Totale giorni senza periodo di rapporto nel periodo della scheda
        ElaboraAcconto(DataF,Dal_Scheda,Al_Scheda);
        selT430Lav.First;
        while not selT430Lav.Eof do
        begin
          //Cerco i periodi dettagliati
          selT430Dati.Close;
          selT430Dati.SetVariable('PROGRESSIVO',C700Progressivo);
          selT430Dati.SetVariable('DAL',selT430Lav.FieldByName('INI').AsDateTime);
          selT430Dati.SetVariable('AL',selT430Lav.FieldByName('FIN').AsDateTime);
          selT430Dati.SetVariable('DATI_select',IfThen(ProporzionePT = 'S','PARTTIME','NULL') + ' PARTTIME,' +
                                                IfThen(Parametri.CampiRiferimento.C7_Dato1 <> '',Parametri.CampiRiferimento.C7_Dato1,'NULL') + ' DATO1,' +
                                                IfThen(Parametri.CampiRiferimento.C7_Dato2 <> '',Parametri.CampiRiferimento.C7_Dato2,'NULL') + ' DATO2,' +
                                                IfThen(Parametri.CampiRiferimento.C7_Dato3 <> '',Parametri.CampiRiferimento.C7_Dato3,'NULL') + ' DATO3');
          (*selT430Dati.SetVariable('DATI_group_by',IfThen(ProporzionePT = 'S','PARTTIME','NULL') + ',' +
                                                  IfThen(Parametri.CampiRiferimento.C7_Dato1 <> '',Parametri.CampiRiferimento.C7_Dato1,'NULL') + ',' +
                                                  IfThen(Parametri.CampiRiferimento.C7_Dato2 <> '',Parametri.CampiRiferimento.C7_Dato2,'NULL') + ',' +
                                                  IfThen(Parametri.CampiRiferimento.C7_Dato3 <> '',Parametri.CampiRiferimento.C7_Dato3,'NULL'));*)
          //Raggruppo i periodi dettagliati
          cdsT430Dati.EmptyDataSet;
          PTold:='#VALORE#INIZIALE#FITTIZIO#';
          Dato1old:=PTold;
          Dato2old:=PTold;
          Dato3old:=PTold;
          selT430Dati.Open;
          while not selT430Dati.Eof do
          begin
            if (selT430Dati.FieldByName('PARTTIME').AsString <> PTold)
            or (selT430Dati.FieldByName('DATO1').AsString <> Dato1old)
            or (selT430Dati.FieldByName('DATO2').AsString <> Dato2old)
            or (selT430Dati.FieldByName('DATO3').AsString <> Dato3old) then
            begin
              cdsT430Dati.Append;
              cdsT430Dati.FieldByName('INI').AsDateTime:=selT430Dati.FieldByName('INI').AsDateTime;
              cdsT430Dati.FieldByName('FIN').AsDateTime:=selT430Dati.FieldByName('FIN').AsDateTime;
              cdsT430Dati.FieldByName('PARTTIME').AsString:=selT430Dati.FieldByName('PARTTIME').AsString;
              cdsT430Dati.FieldByName('DATO1').AsString:=selT430Dati.FieldByName('DATO1').AsString;
              cdsT430Dati.FieldByName('DATO2').AsString:=selT430Dati.FieldByName('DATO2').AsString;
              cdsT430Dati.FieldByName('DATO3').AsString:=selT430Dati.FieldByName('DATO3').AsString;
              cdsT430Dati.Post;
              PTold:=selT430Dati.FieldByName('PARTTIME').AsString;
              Dato1old:=selT430Dati.FieldByName('DATO1').AsString;
              Dato2old:=selT430Dati.FieldByName('DATO2').AsString;
              Dato3old:=selT430Dati.FieldByName('DATO3').AsString;
            end
            else
            begin
              cdsT430Dati.Edit;
              cdsT430Dati.FieldByName('FIN').AsDateTime:=selT430Dati.FieldByName('FIN').AsDateTime;
              cdsT430Dati.Post;
            end;
            selT430Dati.Next;
          end;
          //Scorro i periodi dettagliati
          cdsT430Dati.First;
          while not cdsT430Dati.Eof do
          begin
            TabellaTipoD.Append;
            TabellaTipoD.FieldByName('Progressivo').AsInteger:=C700Progressivo;
            TabellaTipoD.FieldByName('CodTipoQuota').AsString:=CodQuota;
            TabellaTipoD.FieldByName('Quota_Ind').AsFloat:=selT775.FieldByName('PERC_INDIVIDUALE').AsFloat;
            //Giorni scheda di valutazione
            TabellaTipoD.FieldByName('Dal_Scheda').AsDateTime:=Dal_Scheda;
            TabellaTipoD.FieldByName('Al_Scheda').AsDateTime:=Al_Scheda;
            TabellaTipoD.FieldByName('Giorni_Scheda_Teorici').AsFloat:=selT775.FieldByName('GIORNI').AsFloat;
            TabellaTipoD.FieldByName('Giorni_Senza_Rapporto').AsFloat:=GGSenzaRegole;
            TabellaTipoD.FieldByName('Giorni_Scheda_Effettivi').AsFloat:=TabellaTipoD.FieldByName('Giorni_Scheda_Teorici').AsFloat - TabellaTipoD.FieldByName('Giorni_Senza_Rapporto').AsFloat;
            TabellaTipoD.FieldByName('Perc_Giorni_Scheda').AsFloat:=TabellaTipoD.FieldByName('Giorni_Scheda_Effettivi').AsFloat * 100 / GiorniAnno;
            //Giorni di assenza/presenza
            TabellaTipoD.FieldByName('Giorni_Assenza').AsFloat:=GGAssenza;
            TabellaTipoD.FieldByName('Giorni_Presenza').AsFloat:=TabellaTipoD.FieldByName('Giorni_Scheda_Effettivi').AsFloat - TabellaTipoD.FieldByName('Giorni_Assenza').AsFloat;
            TabellaTipoD.FieldByName('Perc_Giorni_Presenza').AsFloat:=TabellaTipoD.FieldByName('Giorni_Presenza').AsFloat * 100 / TabellaTipoD.FieldByName('Giorni_Scheda_Effettivi').AsFloat;
            if (ProporzioneIncentivi = '1') and (ScaglioniGgEff = 'S') then
              TabellaTipoD.FieldByName('Fascia_Giorni_Presenza').AsFloat:=PercGGEff
            else
              TabellaTipoD.FieldByName('Fascia_Giorni_Presenza').AsFloat:=TabellaTipoD.FieldByName('Perc_Giorni_Presenza').AsFloat;
            //Giorni del rapporto lavorativo
            TabellaTipoD.FieldByName('Inizio').AsDateTime:=selT430Lav.FieldByName('INI').AsDateTime;
            TabellaTipoD.FieldByName('Fine').AsDateTime:=selT430Lav.FieldByName('FIN').AsDateTime;
            TabellaTipoD.FieldByName('Giorni_Lavorati').AsInteger:=DaysBetween(TabellaTipoD.FieldByName('Fine').AsDateTime,TabellaTipoD.FieldByName('Inizio').AsDateTime) + 1;
            //In caso di più periodi di rapporto proporziono i periodi rispetto alla somma effettiva degli stessi, escludendo i giorni senza rapporto nel periodo della scheda per non ripetere l'abbattimento delle assenze
            TabellaTipoD.FieldByName('Perc_Giorni_Lavorati').AsFloat:=TabellaTipoD.FieldByName('Giorni_Lavorati').AsInteger * 100 / TabellaTipoD.FieldByName('Giorni_Scheda_Effettivi').AsFloat;
            //Giorni del dettaglio rispetto al rapporto lavorativo
            TabellaTipoD.FieldByName('Dal_Dettaglio').AsDateTime:=cdsT430Dati.FieldByName('INI').AsDateTime;
            TabellaTipoD.FieldByName('Al_Dettaglio').AsDateTime:=cdsT430Dati.FieldByName('FIN').AsDateTime;
            TabellaTipoD.FieldByName('Giorni_Dettaglio').AsInteger:=DaysBetween(TabellaTipoD.FieldByName('Dal_Dettaglio').AsDateTime,TabellaTipoD.FieldByName('Al_Dettaglio').AsDateTime) + 1;
            TabellaTipoD.FieldByName('Perc_Giorni_Dettaglio').AsFloat:=TabellaTipoD.FieldByName('Giorni_Dettaglio').AsInteger * 100 / TabellaTipoD.FieldByName('Giorni_Lavorati').AsInteger;
            //Part-time
            TabellaTipoD.FieldByName('PartTime').AsString:=cdsT430Dati.FieldByName('PARTTIME').AsString;
            TabellaTipoD.FieldByName('Perc_PartTime').AsFloat:=100;
            PT:=TabellaTipoD.FieldByName('Perc_PartTime').AsFloat;
            if (ProporzionePT = 'S')
            and (selT460.SearchRecord('CODICE',TabellaTipoD.FieldByName('PartTime').AsString,[srFromBeginning])) then
            begin
              PT:=selT460.FieldByName('INCENTIVI').AsFloat;
              TabellaTipoD.FieldByName('Perc_PartTime').AsFloat:=PT;
              R180SetVariable(selSG735,'TIPOLOGIA','I');
              R180SetVariable(selSG735,'QUOTA',CodQuota);
              R180SetVariable(selSG735,'FLEX','*');
              R180SetVariable(selSG735,'DATARIF',DataF);
              R180SetVariable(selSG735,'PERCRIF',PT);
              selSG735.Open;
              if selSG735.RecordCount > 0 then
                PT:=selSG735.FieldByName('PERC').AsFloat;
            end;
            TabellaTipoD.FieldByName('Fascia_PartTime').AsFloat:=PT;
            //Dati anagrafici
            TabellaTipoD.FieldByName('Dato1_Anagrafe').AsString:=cdsT430Dati.FieldByName('DATO1').AsString;
            TabellaTipoD.FieldByName('Dato2_Anagrafe').AsString:=cdsT430Dati.FieldByName('DATO2').AsString;
            TabellaTipoD.FieldByName('Dato3_Anagrafe').AsString:=cdsT430Dati.FieldByName('DATO3').AsString;
            //Dati quote
            R180SetVariable(selT770,'DATO1',TabellaTipoD.FieldByName('Dato1_Anagrafe').AsString);
            R180SetVariable(selT770,'DATO2',TabellaTipoD.FieldByName('Dato2_Anagrafe').AsString);
            R180SetVariable(selT770,'DATO3',TabellaTipoD.FieldByName('Dato3_Anagrafe').AsString);
            R180SetVariable(selT770,'DATA',MeseCorr);
            selT770.Open;
            if selT770.SearchRecord('CODTIPOQUOTA',CodQuota,[srFromBeginning]) then
            begin
              QuotaIntera:=selT770.FieldByName('IMPORTO').AsFloat;
              RegDato1:=selT770.FieldByName('DATO1').AsString;
              RegDato2:=selT770.FieldByName('DATO2').AsString;
              RegDato3:=selT770.FieldByName('DATO3').AsString;
              TabellaTipoD.FieldByName('Dato1_QuotaSaldo').AsString:=RegDato1;
              TabellaTipoD.FieldByName('Dato2_QuotaSaldo').AsString:=RegDato2;
              TabellaTipoD.FieldByName('Dato3_QuotaSaldo').AsString:=RegDato3;
              TabellaTipoD.FieldByName('Fondo_QuotaSaldo').AsFloat:=QuotaIntera;
            end;
            TabellaTipoD.FieldByName('Solo_QuotaSaldo').AsString:=IfThen(VarToStr(A167FRegistraIncentiviMW.selT765.Lookup('CODICE',CodQuota,'ACCONTI')) = '','S','N');
            TabellaTipoD.FieldByName('Quota_Acconti').AsFloat:=0;
            if TabellaTipoD.FieldByName('Solo_QuotaSaldo').AsString = 'S' then
              TabellaTipoD.FieldByName('Numeri_Dettaglio').AsFloat:=TabellaTipoD.FieldByName('Fondo_QuotaSaldo').AsFloat
            else
            begin
              //sommo le quote degli acconti di riferimento
              lstAcconti:=TStringList.Create;
              lstAcconti.Clear;
              lstAcconti.CommaText:=VarToStr(A167FRegistraIncentiviMW.selT765.Lookup('CODICE',CodQuota,'ACCONTI'));
              for i:=0 to lstAcconti.Count - 1 do
                if selT770.SearchRecord('CODTIPOQUOTA',lstAcconti.Strings[i],[srFromBeginning]) then
                  TabellaTipoD.FieldByName('Quota_Acconti').AsFloat:=TabellaTipoD.FieldByName('Quota_Acconti').AsFloat + selT770.FieldByName('IMPORTO').AsFloat;
              FreeAndNil(lstAcconti);
              TabellaTipoD.FieldByName('Numeri_Dettaglio').AsFloat:=TabellaTipoD.FieldByName('Quota_Acconti').AsFloat;
            end;
            //Calcolo i numeri di riferimento
            TabellaTipoD.FieldByName('Numeri_Dettaglio').AsFloat:=TabellaTipoD.FieldByName('Numeri_Dettaglio').AsFloat *              //peso quota acconto oppure fondo quota saldo
                                                                 (TabellaTipoD.FieldByName('Quota_Ind').AsFloat / 100) *              //punteggio valutazione
                                                                 (TabellaTipoD.FieldByName('Perc_Giorni_Scheda').AsFloat / 100) *     //percentuale giorni scheda nell'anno
                                                                 (TabellaTipoD.FieldByName('Fascia_Giorni_Presenza').AsFloat / 100) * //percentuale giorni di presenza nel periodo della scheda
                                                                 (TabellaTipoD.FieldByName('Perc_Giorni_Lavorati').AsFloat / 100) *   //percentuale giorni del periodo di rapporto rispetto alla somma degli stessi nel periodo della scheda
                                                                 (TabellaTipoD.FieldByName('Perc_Giorni_Dettaglio').AsFloat / 100) *  //percentuale giorni dei dati dettagliati nel periodo di rapporto interno al periodo della scheda
                                                                 (TabellaTipoD.FieldByName('Fascia_PartTime').AsFloat / 100);         //percentuale part-time del dettaglio
            TabellaTipoD.FieldByName('Data_Registrazione').AsDateTime:=DataReg;
            if TabellaTipoD.FieldByName('Solo_QuotaSaldo').AsString = 'N' then
            begin
              //Sommo i Numeri a livello di fondo
              Esiste:=False;
              for i:=0 to High(Fondi) do
                if (Fondi[i].CodTipoQuota = TabellaTipoD.FieldByName('CodTipoQuota').AsString)
                and (Fondi[i].Dato1 = TabellaTipoD.FieldByName('Dato1_QuotaSaldo').AsString)
                and (Fondi[i].Dato2 = TabellaTipoD.FieldByName('Dato2_QuotaSaldo').AsString)
                and (Fondi[i].Dato3 = TabellaTipoD.FieldByName('Dato3_QuotaSaldo').AsString)
                then
                begin
                  Esiste:=True;
                  Break;
                end;
              if not Esiste then
              begin
                i:=High(Fondi) + 1;
                SetLength(Fondi,i + 1);
                Fondi[i].CodTipoQuota:=TabellaTipoD.FieldByName('CodTipoQuota').AsString;
                Fondi[i].Dato1:=TabellaTipoD.FieldByName('Dato1_QuotaSaldo').AsString;
                Fondi[i].Dato2:=TabellaTipoD.FieldByName('Dato2_QuotaSaldo').AsString;
                Fondi[i].Dato3:=TabellaTipoD.FieldByName('Dato3_QuotaSaldo').AsString;
                Fondi[i].Numeri:=0;
                Fondi[i].FondoQuotaSaldo:=TabellaTipoD.FieldByName('Fondo_QuotaSaldo').AsFloat;
                Fondi[i].SommaSaldiDett:=0;
              end;
              Fondi[i].Numeri:=Fondi[i].Numeri + TabellaTipoD.FieldByName('Numeri_Dettaglio').AsFloat;
            end;
            TabellaTipoD.Post;
            cdsT430Dati.Next;
          end;
          selT430Lav.Next;
        end;
        selT775.Next;
      end;
  end;
end;

procedure TA167FRegistraIncentivi.ElaboraTabellaTipoD;
var i:Integer;
    Esiste:Boolean;
    Variazione:Real;
begin
  with A167FRegistraIncentiviDtM.TabellaTipoD do
    if RecordCount > 0 then
    begin
      IndexName:='QuotaSaldo';
      //Calcolo il saldo
      First;
      while not Eof do
      begin
        CodQuota:=FieldByName('CodTipoQuota').AsString;
        Edit;
        if FieldByName('Solo_QuotaSaldo').AsString = 'S' then
          FieldByName('Saldo').AsFloat:=R180Arrotonda(FieldByName('Numeri_Dettaglio').AsFloat,Decimali,'P')
        else
        begin
          FieldByName('Numeri_TotFondo').AsFloat:=0;
          Esiste:=False;
          for i:=0 to High(Fondi) do
            if (Fondi[i].CodTipoQuota = FieldByName('CODTIPOQUOTA').AsString)
            and (Fondi[i].Dato1 = FieldByName('DATO1_QUOTASALDO').AsString)
            and (Fondi[i].Dato2 = FieldByName('DATO2_QUOTASALDO').AsString)
            and (Fondi[i].Dato3 = FieldByName('DATO3_QUOTASALDO').AsString)
            then
            begin
              FieldByName('Numeri_TotFondo').AsFloat:=Fondi[i].Numeri;
              Esiste:=True;
              Break;
            end;
          if FieldByName('Numeri_TotFondo').AsFloat = 0 then
            FieldByName('Peso_Dettaglio').AsFloat:=0
          else
            FieldByName('Peso_Dettaglio').AsFloat:=FieldByName('Numeri_Dettaglio').AsFloat * 100 / FieldByName('Numeri_TotFondo').AsFloat;
          FieldByName('Saldo').AsFloat:=R180Arrotonda(FieldByName('Fondo_QuotaSaldo').AsFloat * FieldByName('Peso_Dettaglio').AsFloat / 100,Decimali,'P');
          if Esiste then
            Fondi[i].SommaSaldiDett:=Fondi[i].SommaSaldiDett + FieldByName('Saldo').AsFloat;
        end;
        Post;
        C700SelAnagrafe.SearchRecord('PROGRESSIVO',FieldByName('PROGRESSIVO').AsInteger,[srFromBeginning]);
        with A167FRegistraIncentiviDtM do
        begin
          R180SetVariable(selT762,'PROG',C700Progressivo);
          selT762.Open;
          R180SetVariable(selT762Risp,'PROG',C700Progressivo);
          selT762Risp.Open;
        end;
        if chkAggiorna.Checked then
        begin
          RegistraMese(FieldByName('Data_Registrazione').AsDateTime,FieldByName('Giorni_Dettaglio').AsInteger,FieldByName('Saldo').AsFloat,'1');
          RegistraMese(FieldByName('Data_Registrazione').AsDateTime,FieldByName('Giorni_Dettaglio').AsInteger,FieldByName('Saldo').AsFloat,'2');
          RegistraMese(FieldByName('Data_Registrazione').AsDateTime,FieldByName('Giorni_Dettaglio').AsInteger,FieldByName('Saldo').AsFloat,'3');
        end;
        if Anteprima then
        begin
          CaricaTabellaStampa(FieldByName('Data_Registrazione').AsDateTime,FieldByName('Giorni_Dettaglio').AsInteger,FieldByName('Saldo').AsFloat,'1');
          CaricaTabellaStampa(FieldByName('Data_Registrazione').AsDateTime,FieldByName('Giorni_Dettaglio').AsInteger,FieldByName('Saldo').AsFloat,'2');
          CaricaTabellaStampa(FieldByName('Data_Registrazione').AsDateTime,FieldByName('Giorni_Dettaglio').AsInteger,FieldByName('Saldo').AsFloat,'3');
        end;
        Next;
      end;
      //Intervengo sui saldi dettagliati per non discostarmi dal fondo
      for i:=0 to High(Fondi) do
        while Fondi[i].SommaSaldiDett <> Fondi[i].FondoQuotaSaldo do
        begin
          Variazione:=Decimali * IfThen(Fondi[i].SommaSaldiDett > Fondi[i].FondoQuotaSaldo,-1,1);
          First;
          while (not Eof) and (Fondi[i].SommaSaldiDett <> Fondi[i].FondoQuotaSaldo) do
          begin
            if (Fondi[i].CodTipoQuota = FieldByName('CODTIPOQUOTA').AsString)
            and (Fondi[i].Dato1 = FieldByName('DATO1_QUOTASALDO').AsString)
            and (Fondi[i].Dato2 = FieldByName('DATO2_QUOTASALDO').AsString)
            and (Fondi[i].Dato3 = FieldByName('DATO3_QUOTASALDO').AsString)
            and ((Variazione > 0) or (FieldByName('Saldo').AsFloat > 0)) //aumento sempre, riduco solo se posso
            then
            begin
              CodQuota:=FieldByName('CodTipoQuota').AsString;
              Edit;
              FieldByName('Saldo').AsFloat:=FieldByName('Saldo').AsFloat + Variazione;
              Post;
              C700SelAnagrafe.SearchRecord('PROGRESSIVO',FieldByName('PROGRESSIVO').AsInteger,[srFromBeginning]);
              with A167FRegistraIncentiviDtM do
              begin
                R180SetVariable(selT762,'PROG',C700Progressivo);
                selT762.Open;
                R180SetVariable(selT762Risp,'PROG',C700Progressivo);
                selT762Risp.Open;
              end;
              if chkAggiorna.Checked then
              begin
                RegistraMese(FieldByName('Data_Registrazione').AsDateTime,0,Variazione,'1');
                RegistraMese(FieldByName('Data_Registrazione').AsDateTime,0,Variazione,'2');
                RegistraMese(FieldByName('Data_Registrazione').AsDateTime,0,Variazione,'3');
              end;
              if Anteprima then
              begin
                CaricaTabellaStampa(FieldByName('Data_Registrazione').AsDateTime,0,Variazione,'1');
                CaricaTabellaStampa(FieldByName('Data_Registrazione').AsDateTime,0,Variazione,'2');
                CaricaTabellaStampa(FieldByName('Data_Registrazione').AsDateTime,0,Variazione,'3');
              end;
              Fondi[i].SommaSaldiDett:=Fondi[i].SommaSaldiDett + Variazione;
            end;
            Next;
          end;
        end;
      C700SelAnagrafe.Last;
    end;
end;

procedure TA167FRegistraIncentivi.CaricaTabellaStampa(Data:TDateTime; Giorni,Quota:Real; TipoImporto:String);
var RispIncentivi,NoRispIncentivi,Quota1,Quota2,Quota3,Quota4:Real;
begin
  with A167FRegistraIncentiviDtM do
  begin
    if selDatiBloccati.DatoBloccato(C700Progressivo,R180InizioMese(Data),'T762') then
      exit;
    selT762.Refresh;  //Refresh prima di operare
    RispIncentivi:=0;
    NoRispIncentivi:=0;
    Quota1:=0;
    Quota2:=0;
    Quota3:=0;
    Quota4:=0;
    if TabellaStampa.Locate('PROGRESSIVO;ANNO;MESE;CODTIPOQUOTA',VarArrayOf([C700Progressivo,R180Anno(Data),R180Mese(Data),CodQuota]),[]) then
    begin
      RispIncentivi:=TabellaStampa.FieldByName('AbbRispIncentivi').AsFloat;
      NoRispIncentivi:=TabellaStampa.FieldByName('AbbNoRispIncentivi').AsFloat;
      Quota1:=TabellaStampa.FieldByName('QuotaIntera').AsFloat;
      Quota2:=TabellaStampa.FieldByName('QuotaProporzionata').AsFloat;
      Quota3:=TabellaStampa.FieldByName('QuotaNetta').AsFloat;
      Quota4:=TabellaStampa.FieldByName('QuotaNettaRisp').AsFloat;
      TabellaStampa.Edit;
    end
    else
    begin
      TabellaStampa.Insert;
      if Trim(dcmbCampoAnag.Text) <> '' then
        TabellaStampa.FieldByName('Raggruppamento').AsString:=
          VarToStr(dcmbCampoAnag.KeyValue) + ' ' + C700SelAnagrafe.FieldByName(VarToStr(dcmbCampoAnag.KeyValue)).AsString
      else
        TabellaStampa.FieldByName('Raggruppamento').AsString:='';
      TabellaStampa.FieldByName('Progressivo').AsInteger:=C700Progressivo;
      TabellaStampa.FieldByName('Badge').AsInteger:=C700SelAnagrafe.FieldByName('T430Badge').AsInteger;
      TabellaStampa.FieldByName('Matricola').AsString:=C700SelAnagrafe.FieldByName('Matricola').AsString;
      TabellaStampa.FieldByName('Nome').AsString:=C700SelAnagrafe.FieldByName('Cognome').AsString + ' ' + C700SelAnagrafe.FieldByName('Nome').AsString;
      TabellaStampa.FieldByName('PartTime').AsString:=ElencoPT.Text;
      TabellaStampa.FieldByName('Anno').AsInteger:=R180Anno(Data);
      TabellaStampa.FieldByName('Mese').AsInteger:=R180Mese(Data);
      TabellaStampa.FieldByName('CodTipoQuota').AsString:=CodQuota;
      if CodQuota = '_' then
        TabellaStampa.FieldByName('DescTipoQuota').AsString:=Format('%-' + IntToStr(Lung) + 's',[CodQuota]) + ' Rateizzazione'
      else
        TabellaStampa.FieldByName('DescTipoQuota').AsString:=Format('%-' + IntToStr(Lung) + 's',[CodQuota]) + ' ' + VarToStr(A167FRegistraIncentiviMW.selT765.Lookup('CODICE',CodQuota,'DESCRIZIONE'));
    end;
    if TipoImporto = '1' then
    begin
      //----Quota intera
      if rgpTipoDati.ItemIndex = 0 then
      begin
        TabellaStampa.FieldByName('QuotaIntera').AsFloat:=Quota1 + Quota;
        if selT762.SearchRecord('MESE;CODTIPOQUOTA;TIPOIMPORTO',VarArrayOf([R180Mese(Data),CodQuota,'1']),[srFromBeginning]) then
        begin
          if selT762.FieldByName('Variazioni').AsFloat <> 0 then
          begin
            TabellaStampa.FieldByName('VarQuotaIntera').AsString:='S';
            TabellaStampa.FieldByName('QuotaIntera').AsFloat:=TabellaStampa.FieldByName('QuotaIntera').AsFloat +
                                                              selT762.FieldByName('Variazioni').AsFloat;
          end;
        end;
      end
      else
        TabellaStampa.FieldByName('QuotaIntera').AsFloat:=Quota1 + Giorni;
    end
    else if TipoImporto = '2' then
    begin
      //----Quota proporzionata
      if rgpTipoDati.ItemIndex = 0 then
      begin
        TabellaStampa.FieldByName('QuotaProporzionata').AsFloat:=Quota2 + Quota;
        if selT762.SearchRecord('MESE;CODTIPOQUOTA;TIPOIMPORTO',VarArrayOf([R180Mese(Data),CodQuota,'2']),[srFromBeginning]) then
        begin
          if selT762.FieldByName('Variazioni').AsFloat <> 0 then
          begin
            TabellaStampa.FieldByName('VarQuotaProporzionata').AsString:='S';
            TabellaStampa.FieldByName('QuotaProporzionata').AsFloat:=TabellaStampa.FieldByName('QuotaProporzionata').AsFloat +
                                                                     selT762.FieldByName('Variazioni').AsFloat;
          end;
        end;
      end
      else
        TabellaStampa.FieldByName('QuotaProporzionata').AsFloat:=Quota2 + Giorni;
    end
    else if (TipoImporto = '3') or (TipoImporto = '-') then
    begin
      //----Quota netta
      if (rgpTipoDati.ItemIndex = 0) then
      begin
        TabellaStampa.FieldByName('QuotaNetta').AsFloat:=Quota3 + Quota;
        if selT762.SearchRecord('MESE;CODTIPOQUOTA;TIPOIMPORTO',VarArrayOf([R180Mese(Data),CodQuota,'3']),[srFromBeginning]) then
        begin
          if selT762.FieldByName('Variazioni').AsFloat <> 0 then
          begin
            TabellaStampa.FieldByName('VarQuotaNetta').AsString:='S';
            TabellaStampa.FieldByName('QuotaNetta').AsFloat:=TabellaStampa.FieldByName('QuotaNetta').AsFloat +
                                                             selT762.FieldByName('Variazioni').AsFloat;
          end;
        end;
        if (TipoImporto = '3') and (CodQuota <> '_') and (TipoQuota <> 'C') then
        begin
          TabellaStampa.FieldByName('QuotaNettaRisp').AsFloat:=
            R180Arrotonda(Quota4,Decimali,'P') + R180Arrotonda(Quota,Decimali,'P');
          if selT762.SearchRecord('MESE;CODTIPOQUOTA;TIPOIMPORTO',VarArrayOf([R180Mese(Data),CodQuota,'4']),[srFromBeginning]) then
          begin
            if selT762.FieldByName('Variazioni').AsFloat <> 0 then
            begin
              TabellaStampa.FieldByName('VarQuotaNettaRisp').AsString:='S';
              TabellaStampa.FieldByName('QuotaNettaRisp').AsFloat:=TabellaStampa.FieldByName('QuotaNettaRisp').AsFloat +
                                                                   selT762.FieldByName('Variazioni').AsFloat;
            end;
          end;
        end;
      end
      else
      begin
        TabellaStampa.FieldByName('QuotaNetta').AsFloat:=Quota3 + Giorni;
        if (TipoImporto = '3') and (CodQuota <> '_') then
          TabellaStampa.FieldByName('QuotaNettaRisp').AsFloat:=Quota4 + Giorni;
      end;
    end
    else if (TipoImporto = '4') and (TipoQuota = 'C') and (rgpTipoDati.ItemIndex = 0) then  //Quota collettiva
    begin
      TabellaStampa.FieldByName('QuotaNettaRisp').AsFloat:=Quota4 + Quota;
      if selT762.SearchRecord('MESE;CODTIPOQUOTA;TIPOIMPORTO',VarArrayOf([R180Mese(Data),CodQuota,'4']),[srFromBeginning]) then
      begin
        if selT762.FieldByName('Variazioni').AsFloat <> 0 then
        begin
          TabellaStampa.FieldByName('VarQuotaNettaRisp').AsString:='S';
          TabellaStampa.FieldByName('QuotaNettaRisp').AsFloat:=TabellaStampa.FieldByName('QuotaNettaRisp').AsFloat +
                                                               selT762.FieldByName('Variazioni').AsFloat;
        end;
      end;
    end
    else if TipoImporto = '5' then  //Quota quantitativa
    begin
      TabellaStampa.FieldByName('QuotaIntera').AsFloat:=Giorni;
      TabellaStampa.FieldByName('QuotaProporzionata').AsFloat:=Quota;
      if selT762.SearchRecord('MESE;CODTIPOQUOTA;TIPOIMPORTO',VarArrayOf([R180Mese(Data),CodQuota,'5']),[srFromBeginning]) then
      begin
        if selT762.FieldByName('Variazioni').AsFloat <> 0 then
        begin
          TabellaStampa.FieldByName('VarQuotaProporzionata').AsString:='S';
          TabellaStampa.FieldByName('QuotaProporzionata').AsFloat:=TabellaStampa.FieldByName('QuotaProporzionata').AsFloat +
                                                                   selT762.FieldByName('Variazioni').AsFloat;
        end;
      end;
    end
    else //Abbattimento
    begin
      if selT766.SearchRecord('CODICE',TipoImporto,[srFromBeginning]) then
      begin
        if selT766.FieldByName('RISPARMIO_BILANCIO').AsString = 'S' then
        begin
          if rgpTipoDati.ItemIndex = 0 then
          begin
            TabellaStampa.FieldByName('AbbRispIncentivi').AsFloat:=RispIncentivi + Quota;
            if TipoQuota <> 'C' then
              TabellaStampa.FieldByName('QuotaNettaRisp').AsFloat:=TabellaStampa.FieldByName('QuotaNettaRisp').AsFloat + Quota;
          end
          else
          begin
            TabellaStampa.FieldByName('AbbRispIncentivi').AsFloat:=RispIncentivi + Giorni;
            if TipoQuota <> 'C' then
              TabellaStampa.FieldByName('QuotaNettaRisp').AsFloat:=TabellaStampa.FieldByName('QuotaNettaRisp').AsFloat + Giorni;
          end;
        end
        else
        begin
          if rgpTipoDati.ItemIndex = 0 then
            TabellaStampa.FieldByName('AbbNoRispIncentivi').AsFloat:=NoRispIncentivi + Quota
          else
            TabellaStampa.FieldByName('AbbNoRispIncentivi').AsFloat:=NoRispIncentivi + Giorni;
        end;
      end;
    end;
    TabellaStampa.Post;
  end;
end;

procedure TA167FRegistraIncentivi.TotalizzaTabellaStampa;
begin
  with A167FRegistraIncentiviDtM do
  begin
    TabellaStampa.First;
    while not TabellaStampa.Eof do
    begin
      if TabellaStampaTotali.Locate('Raggruppamento;PROGRESSIVO;CODTIPOQUOTA',
           VarArrayOf([TabellaStampa.FieldByName('Raggruppamento').AsString,TabellaStampa.FieldByName('PROGRESSIVO').AsInteger,TabellaStampa.FieldByName('CodTipoQuota').AsString]),[]) then
      begin
        TabellaStampaTotali.Edit;
      end
      else
      begin
        TabellaStampaTotali.Insert;
        if Trim(dcmbCampoAnag.Text) <> '' then
          TabellaStampaTotali.FieldByName('Raggruppamento').AsString:=TabellaStampa.FieldByName('Raggruppamento').AsString
        else
          TabellaStampaTotali.FieldByName('Raggruppamento').AsString:='';
        TabellaStampaTotali.FieldByName('PROGRESSIVO').AsInteger:=TabellaStampa.FieldByName('PROGRESSIVO').AsInteger;
        TabellaStampaTotali.FieldByName('Badge').AsInteger:=TabellaStampa.FieldByName('Badge').AsInteger;
        TabellaStampaTotali.FieldByName('Matricola').AsString:=TabellaStampa.FieldByName('Matricola').AsString;
        TabellaStampaTotali.FieldByName('Nome').AsString:=TabellaStampa.FieldByName('Nome').AsString;
        TabellaStampaTotali.FieldByName('PartTime').AsString:=TabellaStampa.FieldByName('PartTime').AsString;
        TabellaStampaTotali.FieldByName('CodTipoQuota').AsString:=TabellaStampa.FieldByName('CodTipoQuota').AsString;
        if TabellaStampa.FieldByName('CodTipoQuota').AsString = '_' then
          TabellaStampaTotali.FieldByName('DescTipoQuota').AsString:=Format('%-' + IntToStr(Lung) + 's',[CodQuota]) + ' Rateizzazione'
        else
          TabellaStampaTotali.FieldByName('DescTipoQuota').AsString:=Format('%-' + IntToStr(Lung) + 's',[TabellaStampa.FieldByName('CodTipoQuota').AsString]) + ' ' +
                                                                   VarToStr(A167FRegistraIncentiviMW.selT765.Lookup('CODICE',TabellaStampa.FieldByName('CodTipoQuota').AsString,'DESCRIZIONE'));
      end;
      TabellaStampaTotali.FieldByName('QuotaIntera').AsFloat:=
        StrToFloatDef(IfThen(TabellaStampaTotali.FieldByName('QuotaIntera').IsNull,'0',TabellaStampaTotali.FieldByName('QuotaIntera').AsString),0) +
        TabellaStampa.FieldByName('QuotaIntera').AsFloat;
      TabellaStampaTotali.FieldByName('QuotaProporzionata').AsFloat:=
        StrToFloatDef(IfThen(TabellaStampaTotali.FieldByName('QuotaProporzionata').IsNull,'0',TabellaStampaTotali.FieldByName('QuotaProporzionata').AsString),0) +
        TabellaStampa.FieldByName('QuotaProporzionata').AsFloat;
      TabellaStampaTotali.FieldByName('QuotaNetta').AsFloat:=
        StrToFloatDef(IfThen(TabellaStampaTotali.FieldByName('QuotaNetta').IsNull,'0',TabellaStampaTotali.FieldByName('QuotaNetta').AsString),0) +
        TabellaStampa.FieldByName('QuotaNetta').AsFloat;
      TabellaStampaTotali.FieldByName('QuotaNettaRisp').AsFloat:=
        StrToFloatDef(IfThen(TabellaStampaTotali.FieldByName('QuotaNettaRisp').IsNull,'0',TabellaStampaTotali.FieldByName('QuotaNettaRisp').AsString),0) +
        TabellaStampa.FieldByName('QuotaNettaRisp').AsFloat;
      TabellaStampaTotali.FieldByName('AbbRispIncentivi').AsFloat:=
        StrToFloatDef(IfThen(TabellaStampaTotali.FieldByName('AbbRispIncentivi').IsNull,'0',TabellaStampaTotali.FieldByName('AbbRispIncentivi').AsString),0) +
        TabellaStampa.FieldByName('AbbRispIncentivi').AsFloat;
      TabellaStampaTotali.FieldByName('AbbNoRispIncentivi').AsFloat:=
        StrToFloatDef(IfThen(TabellaStampaTotali.FieldByName('AbbNoRispIncentivi').IsNull,'0',TabellaStampaTotali.FieldByName('AbbNoRispIncentivi').AsString),0) +
        TabellaStampa.FieldByName('AbbNoRispIncentivi').AsFloat;
      TabellaStampaTotali.Post;
      TabellaStampa.Next;
    end;
  end;
end;

procedure TA167FRegistraIncentivi.BtnPrinterSetUpClick(Sender: TObject);
begin
  if PrinterSetUpDialog1.Execute and (A167FStampaIncentivi <> nil) then
    C001SettaQuickReport(A167FStampaIncentivi.QRep);
end;

procedure TA167FRegistraIncentivi.btnQuoteClick(Sender: TObject);
var
  lstQuote: TList<TQuota>;
  Quota: TQuota;
begin
  C013FCheckList:=TC013FCheckList.Create(nil);
  try
    lstQuote:=A167FRegistraIncentiviDtM.A167FRegistraIncentiviMW.getElencoQuote(TipoQuota);
    try
      for Quota in lstQuote do
        C013FCheckList.clbListaDati.Items.Add(Quota.Descrizione);
    finally
      FreeAndNil(lstQuote);
    end;
    R180PutCheckList(edtQuote.Text,5,C013FCheckList.clbListaDati);
    if C013FCheckList.ShowModal = mrOK then
      edtQuote.Text:=R180GetCheckList(5,C013FCheckList.clbListaDati);
  finally
    C013FCheckList.Release;
  end;
end;

procedure TA167FRegistraIncentivi.CambiaCalcolo;
var i:Integer;
  OldTipoQuota:String;
begin
  edtQuote.Visible:=RegoleC and (Copy(cmbTipoCalcolo.Text,1,1) <> 'R');
  lblQuote.Visible:=RegoleC and (Copy(cmbTipoCalcolo.Text,1,1) <> 'R');
  btnQuote.Visible:=RegoleC and (Copy(cmbTipoCalcolo.Text,1,1) <> 'R');
  OldTipoQuota:=TipoQuota;
  TipoQuota:=Copy(cmbTipoCalcolo.Text,1,1);
  if OldTipoQuota <> TipoQuota then
    edtQuote.Text:='';
  if TipoQuota = 'C' then
    rgpTipoDati.ItemIndex:=0;
  if TipoQuota = 'Q' then
  begin
    for i:=0 to chkColonne.Count - 1 do
      chkColonne.Checked[i]:=False;
    chkColonne.Checked[6]:=True;
    rgpTipoDati.ItemIndex:=0;
  end
  else
    chkColonne.Checked[6]:=False;
  chkColonneClickCheck(nil);
  chkColonne.Enabled:=TipoQuota <> 'Q';
  rgpTipoDati.Enabled:=(TipoQuota <> 'Q') and (TipoQuota <> 'C');
end;

procedure TA167FRegistraIncentivi.cmbTipoCalcoloChange(Sender: TObject);
begin
   CambiaCalcolo;
end;

procedure TA167FRegistraIncentivi.chkAggiornaClick(Sender: TObject);
begin
  btnAggiornamento.Enabled:=chkAggiorna.Checked or chkAnnulla.Checked;
  chkAnnulla.Enabled:=not chkAggiorna.Checked;
  if not chkAnnulla.Enabled then
    chkAnnulla.Checked:=False;
end;

procedure TA167FRegistraIncentivi.chkAnnullaClick(Sender: TObject);
begin
  btnPrinterSetUp.Enabled:=not chkAnnulla.Checked;
  btnStampa.Enabled:=not chkAnnulla.Checked;
  btnAnteprima.Enabled:=not chkAnnulla.Checked;
  btnAggiornamento.Enabled:=chkAggiorna.Checked or chkAnnulla.Checked;
  if chkAnnulla.Checked then
    btnAggiornamento.Caption:='Cancellazione'
  else
    btnAggiornamento.Caption:='Solo aggiornamento';
  chkAggiorna.Enabled:=not chkAnnulla.Checked;
  if not chkAggiorna.Enabled then
    chkAggiorna.Checked:=False;
end;

procedure TA167FRegistraIncentivi.chkColonneClickCheck(Sender: TObject);
var i:Integer;
begin
  lstColonne.Clear;
  for i:=0 to chkColonne.Items.Count - 1 do
  begin
    if chkColonne.Checked[i] then
      lstColonne.Add(IntToStr(i));
  end;
end;

procedure TA167FRegistraIncentivi.dcmbCampoAnagCloseUp(Sender: TObject);
begin
  chkSaltoPagina.Enabled:=Trim(dcmbCampoAnag.Text) <> '';
  if not chkSaltoPagina.Enabled then
    chkSaltoPagina.Checked:=False;
end;

procedure TA167FRegistraIncentivi.dcmbCampoAnagKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if Key = vk_Delete then
  begin
    (Sender as TDBLookupComboBox).KeyValue:=null;
    if (Sender as TDBLookupComboBox).Field <> nil then
      if (Sender as TDBLookupComboBox).DataSource.State in [dsEdit,dsInsert] then
        (Sender as TDBLookupComboBox).Field.Clear;
  end;
end;

procedure TA167FRegistraIncentivi.dcmbCampoAnagKeyUp(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  dcmbCampoAnagCloseUp(nil);
end;

procedure TA167FRegistraIncentivi.edtADataDblClick(Sender: TObject);
begin
  edtAData.Text:=edtDaData.Text;
end;

procedure TA167FRegistraIncentivi.CaricaComboTipoCalcolo;
var
  elencoTipoCalcolo: TList<TTipoCalcolo>;
  TipoCalcolo: TTipoCalcolo;
begin
  with A167FRegistraIncentiviDtM.A167FRegistraIncentiviMW do
  begin
    try
      elencoTipoCalcolo:=getElencoTipoCalcolo(StrToDate('01/' + edtAData.Text));
      cmbTipoCalcolo.Items.Clear;
      for TipoCalcolo in elencoTipoCalcolo do
        cmbTipoCalcolo.Items.Add(TipoCalcolo.Descrizione);
    finally
      FreeAndNil(elencoTipoCalcolo);
    end;
  end;
end;

procedure TA167FRegistraIncentivi.edtADataExit(Sender: TObject);
begin
  ImpostaDataQuote;
  with A167FRegistraIncentiviDtM.A167FRegistraIncentiviMW do
  begin
    CaricaComboTipoCalcolo;
  end;
end;

procedure TA167FRegistraIncentivi.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  PutParametriFunzione;
  C004FParamForm.Free;
  frmSelAnagrafe.DistruggiSelAnagrafe;
  if R450DtM1 <> nil then
    FreeAndNil(R450DtM1);
  FreeAndNil(R600DtM1);
  FreeAndNil(lstColonne);
end;

procedure TA167FRegistraIncentivi.FormCreate(Sender: TObject);
begin
  TipoModulo:='CS';
end;

procedure TA167FRegistraIncentivi.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #27 then
  begin
    if TipoModulo = 'CS' then
      if R180MessageBox('Si desidera interrompere l''operazione?','DOMANDA') = mrYes then
        InterrompiElaborazione:=True;
  end;
end;

procedure TA167FRegistraIncentivi.FormShow(Sender: TObject);
begin
  lstColonne:=TStringList.Create;
  with A167FRegistraIncentiviDtM do
  begin
    RegoleC:=A167FRegistraIncentiviMW.isRegoleC;
    cmbTipoCalcolo.Enabled:=RegoleC;
    if not cmbTipoCalcolo.Enabled then
      cmbTipoCalcolo.ItemIndex:=0;
    CodForm:=IfThen(TipoModulo = 'CS','A167','WA167');
  end;
  chkAggiornaClick(nil);
  CreaC004(SessioneOracle,CodForm,Parametri.ProgOper);
  GetParametriFunzione;
  C700DatiVisualizzati:='MATRICOLA,T430BADGE,COGNOME,NOME';
  C700DatiSelezionati:=C700CampiBase;
  C700DataLavoro:=Parametri.DataLavoro;
  C700DataDal:=Parametri.DataLavoro;
  frmSelAnagrafe.CreaSelAnagrafe(A167FRegistraIncentiviDtM.A167FRegistraIncentiviMW,SessioneOracle,StatusBar,0,False);
  frmSelAnagrafe.SelezionePeriodica:=True;
  btnAnomalie.Enabled:=False;
  InterrompiElaborazione:=False;
  R600DtM1:=TR600DtM1.Create(self);
end;

procedure TA167FRegistraIncentivi.frmSelAnagrafebtnSelezioneClick(Sender: TObject);
begin
  C700DataDal:=StrToDate('01/' + edtDaData.Text);
  C700DataLavoro:=R180FineMese(StrToDate('01/' + edtAData.Text));
  frmSelAnagrafe.btnSelezioneClick(Sender);
end;

procedure TA167FRegistraIncentivi.GetParametriFunzione;
var s:String;
  i:Integer;
begin
  edtDaData.Text:=C004FParamForm.GetParametro('DATADA',Copy(DateToStr(Parametri.DataLavoro),4,7));
  edtAData.Text:=C004FParamForm.GetParametro('DATAA',Copy(DateToStr(Parametri.DataLavoro),4,7));
  edtADataExit(nil);
  try
    cmbTipoCalcolo.ItemIndex:=StrToIntDef(C004FParamForm.GetParametro('CALCOLO','0'),0);
    if cmbTipoCalcolo.ItemIndex = -1 then
      cmbTipoCalcolo.ItemIndex:=0;
  except
    cmbTipoCalcolo.ItemIndex:=0;
  end;
  TipoQuota:='';
  cmbTipoCalcoloChange(nil);
  edtQuote.Text:=C004FParamForm.GetParametro('QUOTE','');
  chkSaltoPagina.Checked:=C004FParamForm.GetParametro('SALTOPAGINA','N') = 'S';
  dcmbCampoAnag.KeyValue:=C004FParamForm.GetParametro('RAGGRUPPAMENTO','');
  rgpTipoDati.ItemIndex:=StrToIntDef(C004FParamForm.GetParametro('TIPODATI','0'),0);
  chkDettaglio.Checked:=C004FParamForm.GetParametro('DETTAGLIO','N') = 'S';
  s:=C004FParamForm.GetParametro('COLONNE','2');
  for i:=0 to chkColonne.Items.Count -1 do
    if Pos(IntToStr(i),s) > 0 then
      chkColonne.Checked[i]:=True;
  chkColonneClickCheck(nil);
end;

procedure TA167FRegistraIncentivi.ImpostaDataQuote;
begin
  A167FRegistraIncentiviDtM.A167FRegistraIncentiviMW.SettaDataQuote(StrToDate('01/' + edtAData.Text));
end;

procedure TA167FRegistraIncentivi.PutParametriFunzione;
begin
  C004FParamForm.Cancella001;
  C004FParamForm.PutParametro('DATADA',edtDaData.Text);
  C004FParamForm.PutParametro('DATAA',edtAData.Text);
  C004FParamForm.PutParametro('QUOTE',edtQuote.Text);
  C004FParamForm.PutParametro('SALTOPAGINA',IfThen(chkSaltoPagina.Checked,'S','N'));
  C004FParamForm.PutParametro('RAGGRUPPAMENTO',VarToStr(dcmbCampoAnag.KeyValue));
  C004FParamForm.PutParametro('CALCOLO',IntToStr(cmbTipoCalcolo.ItemIndex));
  C004FParamForm.PutParametro('TIPODATI',IntToStr(rgpTipoDati.ItemIndex));
  C004FParamForm.PutParametro('DETTAGLIO',IfThen(chkDettaglio.Checked,'S','N'));
  C004FParamForm.PutParametro('COLONNE',lstColonne.CommaText);
  try SessioneOracle.Commit; except end;
end;

procedure TA167FRegistraIncentivi.sbtADataClick(Sender: TObject);
begin
  edtAData.Text:=Copy(DateToStr(DataOut(StrToDate('01/' + edtAData.Text),'Mese fine elaborazione','M')),4,7);
end;

procedure TA167FRegistraIncentivi.sbtDaDataClick(Sender: TObject);
begin
  edtDaData.Text:=Copy(DateToStr(DataOut(StrToDate('01/' + edtDaData.Text),'Mese inizio elaborazione','M')),4,7);
end;

end.
