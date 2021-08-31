unit A042UDialogStampa;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Buttons, DBCtrls, StdCtrls, Spin ,C001StampaLib, C180FunzioniGenerali,A000UCostanti, A000USessione,A000UInterfaccia,
  Grids, DBGrids, ExtCtrls,DB,ComCtrls, OracleData,
  C004UParamForm, QueryStorico, SelAnagrafe, Menus, Chart, TeeProcs,
  C005UDatiAnagrafici, C020UVisualizzaDataSet, C700USelezioneAnagrafe,
  A003UDataLavoroBis, QRExport, Variants, CheckLst, Mask, StrUtils,
  R500Lin;

type
  TA042FDialogStampa = class(TForm)
    PrinterSetupDialog1: TPrinterSetupDialog;
    StatusBar: TStatusBar;
    ProgressBar: TProgressBar;
    frmSelAnagrafe: TfrmSelAnagrafe;
    QRExcelFilter1: TQRExcelFilter;
    QRRTFFilter1: TQRRTFFilter;
    QRTextFilter1: TQRTextFilter;
    Panel1: TPanel;
    BtnClose: TBitBtn;
    BtnStampa: TBitBtn;
    BtnPrinterSetUp: TBitBtn;
    btnAnteprima: TBitBtn;
    Panel2: TPanel;
    edtDaOra: TMaskEdit;
    Label4: TLabel;
    edtAOra: TMaskEdit;
    Label5: TLabel;
    Panel3: TPanel;
    gpbIntestazione: TGroupBox;
    gpbDettaglio: TGroupBox;
    chkLIntestazione: TCheckListBox;
    chkLDettaglio: TCheckListBox;
    Panel4: TPanel;
    chkSaltoPagina: TCheckBox;
    chkTabellare: TCheckBox;
    chkTurnista: TCheckBox;
    Panel5: TPanel;
    rgpTipoStampa: TRadioGroup;
    BtnAvanzati: TBitBtn;
    chkRaggData: TCheckBox;
    chkTotali: TCheckBox;
    chkTotaliGruppo: TCheckBox;
    PopupMenu1: TPopupMenu;
    Selezionatutto1: TMenuItem;
    Annullatutto1: TMenuItem;
    chkTotaliData: TCheckBox;
    chkSaltoPaginaData: TCheckBox;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    edtDaData: TMaskEdit;
    edtAData: TMaskEdit;
    btnDaData: TBitBtn;
    btnAData: TBitBtn;
    chkGiornoCorrente: TCheckBox;
    chkDescrizioneAssenze: TCheckBox;
    btnTabella: TBitBtn;
    procedure edtADataDblClick(Sender: TObject);
    procedure edtDaOraExit(Sender: TObject);
    procedure chkTabellareClick(Sender: TObject);
    procedure chkLDettaglioMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure chkLDettaglioMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure chkLIntestazioneMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure chkLIntestazioneMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure chkRaggDataClick(Sender: TObject);
    procedure Selezionatutto1Click(Sender: TObject);
    procedure chkLDettaglioClick(Sender: TObject);
    procedure chkLIntestazioneClick(Sender: TObject);
    procedure rgpTipoStampaClick(Sender: TObject);
    procedure BtnPrinterSetUpClick(Sender: TObject);
    procedure BtnStampaClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure BtnDaDataClick(Sender: TObject);
    procedure BtnADataClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure frmSelAnagrafeR003DatianagraficiClick(Sender: TObject);
    procedure frmSelAnagrafebtnSelezioneClick(Sender: TObject);
    procedure BtnAvanzatiClick(Sender: TObject);
    procedure chkGiornoCorrenteClick(Sender: TObject);
  private
    { Private declarations }
    ContatoreDipendente,ItemCB:integer;
    DaData,AData:TDateTime;
    procedure Abilitazioni;
    procedure Controlli;
    procedure ScorriQueryAnagrafica;
    procedure ScorriQueryAnagraficaTab;
    procedure ScorriQueryAnagraficaGrafico;
    procedure ScorriQueryAnagraficaProspetto;
    procedure ScorriQueryAnagraficaEUCausalizzate;
    function AssenteSenzaGiustificativo:Boolean;
    //procedure InserisciDipendente(Progr:Integer;Data:TDateTime);
    procedure InserisciRecord(StrPres: String);
    procedure InserisciDipendenteGrafico(Progr:Integer;Data:TDateTime);
    //procedure InserisciDipendenteProspetto(Progr:Integer;Data:TDateTime);
    //procedure AssegnaGiustificativi(var Giu1,Giu2,Giu3:String);
    procedure GetParametriFunzione;
    procedure PutParametriFunzione;
 public
    { Public declarations }
    Anteprima:boolean;
    Progressivo:LongInt;
    //InterruzioneElaborazione:Boolean;
    DocumentoPDF,TipoModulo: string;
    VisualizzaVLine, VisualizzaHLine: Boolean;
    TitoloGrafico: String;
    procedure DisegnaGrafico;
  end;

var
  A042FDialogStampa: TA042FDialogStampa;
const cPb_CodiceOreNonCausalizzate:string ='**NC**';

procedure OpenA042StampaPreAsse(Prog:LongInt);

implementation

uses
  A042UStampa, UInputTime, A042UStampaPreAssDtM1, A042UStampaTab,
  A042UImpostazioniGrafico, A042UGrafico, A042UStampaGrafico,
  A042UImpostazioniProspetto, A042UStampaProspetto,
  A042UImpostazioniEUCausalizzate, A042UStampaEUCausalizzate;

{$R *.DFM}

procedure OpenA042StampaPreAsse(Prog:LongInt);
{Stampa presenti/Assenti}
begin
  SolaLetturaOriginale:=SolaLettura;
  SolaLettura:=False;
  case A000GetInibizioni('Funzione','OpenA042StampaPreAsse') of
    'N':
        begin
        ShowMessage('Funzione non abilitata!');
        Exit;
        end;
  end;
  A042FDialogStampa:=TA042FDialogStampa.Create(nil);
  with A042FDialogStampa do
    try
      C700Progressivo:=Prog;
      A042FStampaPreAssDtM1:=TA042FStampaPreAssDtM1.Create(nil);
      //A042FStampaGrafico:=TA042FStampaGrafico.Create(nil);
      ShowModal;
    finally
      SolaLettura:=SolaLetturaOriginale;
      A042FStampaPreAssDtM1.Free;
      Free;
    end;
end;

procedure TA042FDialogStampa.FormCreate(Sender: TObject);
begin
  TipoModulo:='CS';
  A042FStampa:=TA042FStampa.Create(nil);
  A042FStampaTab:=TA042FStampaTab.Create(nil);
  A042FStampaGrafico:=TA042FStampaGrafico.Create(nil);
  A042FStampaProspetto:=TA042FStampaProspetto.Create(nil);
  A042FStampaEUCausalizzate:=TA042FStampaEUCausalizzate.Create(nil);
end;

procedure TA042FDialogStampa.FormShow(Sender: TObject);
begin
  C700DatiVisualizzati:='MATRICOLA,T430BADGE,COGNOME,NOME';
  C700DatiSelezionati:=C700CampiBase;
  C700DataLavoro:=Parametri.DataLavoro;
  C700DataDal:=Parametri.DataLavoro;
  frmSelAnagrafe.CreaSelAnagrafe(SessioneOracle,StatusBar,0,False);
  frmSelAnagrafe.SelezionePeriodica:=True;
  with A042FStampaPreAssDtM1.A042MW do
  begin
    SelAnagrafe:=C700SelAnagrafe;
    while not selI010.Eof do
    begin
      A042FDialogStampa.chkLIntestazione.Items.Add(selI010.FieldByName('NOME_LOGICO').AsString);
      A042FDialogStampa.chkLDettaglio.Items.Add(selI010.FieldByName('NOME_LOGICO').AsString);
      selI010.Next;
    end;
  end;
  CreaC004(SessioneOracle,IfThen((TipoModulo = 'COM'),'WA042','A042') ,Parametri.ProgOper);
  GetParametriFunzione;
  Abilitazioni;
end;

procedure TA042FDialogStampa.BtnPrinterSetUpClick(Sender: TObject);
begin
  if PrinterSetUpDialog1.Execute then
  begin
    C001SettaQuickReport(A042FStampa.RepR);
    C001SettaQuickReport(A042FStampaTab.RepR);
    C001SettaQuickReport(A042FStampaGrafico);
    C001SettaQuickReport(A042FStampaProspetto);
  end;
end;

function TA042FDialogStampa.AssenteSenzaGiustificativo:Boolean;
begin
  Result:=A042FStampaPreAssDtM1.A042MW.R502ProDtM1.n_riepasse = 0;
end;

procedure TA042FDialogStampa.InserisciDipendenteGrafico(Progr:Integer;Data:TDateTime);
var
  i,nDep,nMinuti,j:Integer;
  sOraDa,sOraA:string;
  dDataDa,dDataA:TDateTime;
  sDep,sCausale:string;
begin
  with A042FGrafico do
  begin
    with A042FStampaPreAssDtM1.A042MW.R502ProDtM1 do
    begin
      if Blocca = 0 then //Significa che uscendo dai conteggi non ci sono anomalie
      begin
        ContatoreDipendente:=ContatoreDipendente+1;
        //Incremento di un valore gli array dei dipendenti...
        setlength(A042FStampaPreAssDtM1.A042MW.aPb_DatiDipendentiTimbGiusH, ContatoreDipendente + 1);
        setlength(A042FStampaPreAssDtM1.A042MW.aPb_DatiDipendentiGiustI, ContatoreDipendente + 1);
        setlength(A042FStampaPreAssDtM1.A042MW.aPb_DatiDipendentiGiustM, ContatoreDipendente + 1);

        //Se il dipendente era in servizio in DataCorr
        //if (R502ProDtM1.DipInser = 'si') then // stampa presenze
        // troncamento nominativo.ini - daniloc 10.05.2010
        //sDep:=trim(C700SelAnagrafe.FieldByName('Cognome').asString + ' ' + C700SelAnagrafe.FieldByName('Nome').asString + ' (' + C700SelAnagrafe.FieldByName('Matricola').asString + ')');
        sDep:=trim(C700SelAnagrafe.FieldByName('Cognome').AsString + ' ' +
                   Copy(C700SelAnagrafe.FieldByName('Nome').AsString,1,1) +
                   '. (' + C700SelAnagrafe.FieldByName('Matricola').AsString + ')');
        // troncamento nominativo.fine - daniloc 10.05.2010
        A042FStampaPreAssDtM1.A042MW.aPb_DatiDipendentiTimbGiusH[ContatoreDipendente].sDescrizione:=sDep;
        setlength(A042FStampaPreAssDtM1.A042MW.aPb_DatiDipendentiTimbGiusH[ContatoreDipendente].aDatiDipendente,0);
        setlength(A042FStampaPreAssDtM1.A042MW.aPb_DatiDipendentiTimbGiusH[ContatoreDipendente].aDatiDipendente,1);
        A042FStampaPreAssDtM1.A042MW.aPb_DatiDipendentiGiustI[ContatoreDipendente].sDescrizione:=sDep;
        setlength(A042FStampaPreAssDtM1.A042MW.aPb_DatiDipendentiGiustI[ContatoreDipendente].aDatiDipendente,0);
        setlength(A042FStampaPreAssDtM1.A042MW.aPb_DatiDipendentiGiustI[ContatoreDipendente].aDatiDipendente,1);
        A042FStampaPreAssDtM1.A042MW.aPb_DatiDipendentiGiustM[ContatoreDipendente].sDescrizione:=sDep;
        setlength(A042FStampaPreAssDtM1.A042MW.aPb_DatiDipendentiGiustM[ContatoreDipendente].aDatiDipendente,0);
        setlength(A042FStampaPreAssDtM1.A042MW.aPb_DatiDipendentiGiustM[ContatoreDipendente].aDatiDipendente,1);

        //GIUSTIFICATIVI DALLE... ALLE...
        if n_giusdaa > 0 then
        begin
          for i:=1 to n_giusdaa do
          begin
            sOraDa:=R180MinutiOre(tgius_dallealle[i].tminutida) + '.00';
            if tgius_dallealle[i].tminutia >=1440 then
              sOraA:='23.59.59'
            else
              sOraA:=R180MinutiOre(tgius_dallealle[i].tminutia) + '.00';
            dDataDa:=strtoDateTime(A042FStampaPreAssDtM1.A042MW.sDaData + ' ' + sOraDa);
            dDataA:=strtoDateTime(A042FStampaPreAssDtM1.A042MW.sDaData + ' ' + sOraA);
            sCausale:=tgius_dallealle[i].tcausdaa;
            A042FStampaPreAssDtM1.A042MW.AggiungiCausale(A042FStampaPreAssDtM1.A042MW.aPb_DatiDipendentiTimbGiusH, sCausale, dDataDa, dDataA, 'D', ContatoreDipendente);
          end;
        end;

        //CausPres Dalle Alle(Tipi A E)
        with A042FStampaPreAssDtM1.A042MW do
        begin
          if n_rieppres > 0 then
            for i:=1 to n_rieppres do
              if (ValStrT275[R502ProDtM1.triepgiuspres[i].tcauspres,'TIPOCONTEGGIO'] = 'A') or
                 (ValStrT275[R502ProDtM1.triepgiuspres[i].tcauspres,'TIPOCONTEGGIO'] = 'E') then
                for j:=0 to High(R502ProDtM1.triepgiuspres[i].CoppiaEU) do
                begin
                  if triepgiuspres[i].CoppiaEU[j].e >= 1440 then
                    sOraDa:='23.59.59'
                  else
                    sOraDa:=R180MinutiOre(triepgiuspres[i].CoppiaEU[j].e) + '.00';
                  if triepgiuspres[i].CoppiaEU[j].u >= 1440 then
                    sOraA:='23.59.59'
                  else
                    sOraA:=R180MinutiOre(triepgiuspres[i].CoppiaEU[j].u) + '.00';
                  if (R502ProDtM1.triepgiuspres[i].tcauspres <> '') then
                    sCausale:=triepgiuspres[i].tcauspres
                  else
                    sCausale:=cPb_CodiceOreNonCausalizzate;
                  A042FStampaPreAssDtM1.A042MW.AggiungiCausale(A042FStampaPreAssDtM1.A042MW.aPb_DatiDipendentiTimbGiusH, sCausale, strtoDateTime(sDaData + ' ' + sOraDa), strtoDateTime(sAData + ' ' + sOraA),ValStrT275[R502ProDtM1.triepgiuspres[i].tcauspres,'TIPOCONTEGGIO'], ContatoreDipendente);
                end;
        end;

        //TIMBRATURE...
        if n_timbrcon > 0 then
        begin
          for i:=1 to n_timbrcon do
          begin
            //sOraDa:=R180MinutiOreExt(ttimbraturecon[i].tminutic_e) + '.00';
            if ttimbraturecon[i].tminutic_e >= 1440 then
              sOraDa:='23.59.59'
            else
              sOraDa:=R180MinutiOre(ttimbraturecon[i].tminutic_e) + '.00';
            if ttimbraturecon[i].tminutic_u >= 1440 then
              sOraA:='23.59.59'
            else
              sOraA:=R180MinutiOre(ttimbraturecon[i].tminutic_u) + '.00';
            if (ttimbraturecon[i].tcaus <> '') and (ttimbraturecon[i].tcaus = ttimbraturecon[i].tcaus)then
              sCausale:=ttimbraturecon[i].tcaus
            else
              sCausale:=cPb_CodiceOreNonCausalizzate;
            A042FStampaPreAssDtM1.A042MW.AggiungiCausale(A042FStampaPreAssDtM1.A042MW.aPb_DatiDipendentiTimbGiusH, sCausale, strtoDateTime(A042FStampaPreAssDtM1.A042MW.sDaData + ' ' + sOraDa), strtoDateTime(A042FStampaPreAssDtM1.A042MW.sAData + ' ' + sOraA), 'T', ContatoreDipendente);
          end;
        end;

        //GIUSTIFICATIVI A GIORNATE...
        //Proporziono la barra orizzontale tra i giustif. a giornata che trovo...
        if n_giusgga > 0 then
        begin
          nDep:=trunc(1439/n_giusgga);
          for i:=1 to n_giusgga do
          begin
            if i=1 then
              dDataDa:=strtoDateTime(A042FStampaPreAssDtM1.A042MW.sDaData +  ' 00.00.00')
            else
              dDataDa:=dDataA + strtotime('00.00.01');
            dDataA:=dDataDa + strtoTime(R180MinutiOre(nDep) + '.59');
            sCausale:=tgius_ggass[i].tcausggass;  //Prendo in considerazione la prima causale di assenza giornaliera
            //Aggiungo la causale all'array
            A042FStampaPreAssDtM1.A042MW.AggiungiCausale(A042FStampaPreAssDtM1.A042MW.aPb_DatiDipendentiGiustI, sCausale, dDataDa, dDataA,'I', ContatoreDipendente);
          end;
        end;

        //GIUSTIFICATIVI A MEZZE GIORNATE E GIUSTIFICATIVI AD ORE...
        nMinuti:=0;
        nDep:=n_giusmga + n_giusore;
        if nDep > 0 then
        begin
          if n_giusmga > 0 then
          begin
            nMinuti:=trunc(((n_giusmga/nDep) * 24) * 60);  //Ottengo i minuti proporzionati delle causali a mezza giornata...
            if nMinuti = 1440 then
              nMinuti:=1439;
            nDep:=trunc(nMinuti/n_giusmga);
            for i:=1 to n_giusmga do
            begin
              if i=1 then
                dDataDa:=strtoDateTime(A042FStampaPreAssDtM1.A042MW.sDaData +  ' 00.00.00')
              else
                dDataDa:=dDataA + strtotime('00.00.01');
              dDataA:=dDataDa + strtoTime(R180MinutiOre(nDep) + '.59');
              sCausale:=tgius_mgass[i].tcausmgass;  //Prendo in considerazione la prima causale di assenza giornaliera
              //Aggiungo la causale all'array
              A042FStampaPreAssDtM1.A042MW.AggiungiCausale(A042FStampaPreAssDtM1.A042MW.aPb_DatiDipendentiGiustM, sCausale, dDataDa, dDataA,'M', ContatoreDipendente);
            end;
          end;
          if n_giusore > 0 then
          begin
            if nMinuti > 0 then
            begin
              nMinuti:=1439-nMinuti;
              nDep:=trunc(nMinuti/n_giusore);
              for i:=1 to n_giusore do
              begin
                dDataDa:=dDataA + strtotime('00.00.01');
                dDataA:=dDataDa + strtoTime(R180MinutiOre(nDep) + '.59');
//                dDataA:=strtoDateTime(sDaData + ' ' + R180MinutiOre(nDep) + '.59');
                sCausale:=tgius_min[i].tcausore;  //Prendo in considerazione la prima causale di assenza giornaliera
                //Aggiungo la causale all'array
                A042FStampaPreAssDtM1.A042MW.AggiungiCausale(A042FStampaPreAssDtM1.A042MW.aPb_DatiDipendentiGiustM, sCausale, dDataDa, dDataA,'H', ContatoreDipendente);
              end;
            end
            else
            begin
              nMinuti:=trunc(((n_giusore/nDep) * 24) * 60);  //Ottengo i minuti proporzionati delle causali a mezza giornata...
              if nMinuti = 1440 then
                nMinuti:=1439;
              nDep:=trunc(nMinuti/n_giusore);
              for i:=1 to n_giusore do
              begin
                if i=1 then
                  dDataDa:=strtoDateTime(A042FStampaPreAssDtM1.A042MW.sDaData +  ' 00.00.00')
                else
                  dDataDa:=dDataA + strtotime('00.00.01');
                  dDataA:=dDataDa + strtoTime(R180MinutiOre(nDep) + '.59');
//                dDataA:=strtoDateTime(sDaData + ' ' + R180MinutiOre(nDep) + '.59');
                sCausale:=tgius_min[i].tcausore;  //Prendo in considerazione la prima causale di assenza giornaliera
                //Aggiungo la causale all'array
                A042FStampaPreAssDtM1.A042MW.AggiungiCausale(A042FStampaPreAssDtM1.A042MW.aPb_DatiDipendentiGiustM, sCausale, dDataDa, dDataA,'H', ContatoreDipendente);
              end;
            end;
          end;
        end;
      end;
    end;
  end;
end;

procedure TA042FDialogStampa.InserisciRecord(StrPres: String);
var S:String;
  j:Integer;
begin
  //Stampa assenti senza giustif - Tabellare
  with A042FStampaPreAssDtM1 do
  begin
    A042MW.TabellaStampa.Insert;
    S:='';
    for j:=0 to A042MW.ListaIntestazione.Count -1 do
    begin
      if Trim(S) <> '' then
        S:=S + ' - ';
      S:=S + VarToStr(A042MW.selI010.Lookup('NOME_CAMPO',A042MW.ListaIntestazione.Strings[j],'NOME_LOGICO')) + ' ' +
         C700SelAnagrafe.FieldByName(A042MW.ListaIntestazione.Strings[j]).AsString;
    end;
    A042MW.TabellaStampa.FieldByName('Gruppo').Value:=S;
    A042MW.TabellaStampa.FieldByName('Badge').Value:=C700SelAnagrafe.FieldByName('T430Badge').Value;
    A042MW.TabellaStampa.FieldByName('Progressivo').Value:=C700Progressivo;
    A042MW.TabellaStampa.FieldByName('Cognome').Value:=C700SelAnagrafe.FieldByName('Cognome').Value;
    A042MW.TabellaStampa.FieldByName('Nome').Value:=C700SelAnagrafe.FieldByName('Nome').Value;
    A042MW.TabellaStampa.FieldByName('Presenze').Value:=StrPres;
    A042MW.TabellaStampa.Post;
  end;
end;

procedure TA042FDialogStampa.ScorriQueryAnagrafica;
var DataCorr:TDateTime;
    StampaDipendente,DipPresente:Boolean;
begin
  frmSelAnagrafe.ElaborazioneInterrompibile:=True;
  Self.Enabled:=False;
  try
  with A042FStampaPreAssDtM1 do
  begin
    A042MW.R502ProDtM1.Conteggi('APERTURA',0,Date);
    A042MW.R502ProDtM1.PeriodoConteggi(DaData,AData);
    ProgressBar.Position:=0;
    ProgressBar.Max:=C700SelAnagrafe.RecordCount * Trunc(AData - DaData + 1);
    C700SelAnagrafe.First;
    while not C700SelAnagrafe.EOF do
    begin
      frmSelAnagrafe.VisualizzaDipendente;
      DataCorr:=DaData;
      while DataCorr <= AData do
      begin
        ProgressBar.StepBy(1);
        A042MW.TimbraturaMezzanotte:=False;
        //Eseguo i conteggi
        A042MW.R502ProDtM1.Conteggi('Cartolina',C700Progressivo,DataCorr);
        //Se c'è stata un'anomalia bloccante...
        if A042MW.R502ProDtM1.Blocca = 2 then
        begin
          // gestione anomalia bloccante.......
          A042MW.GestisciAnomaliaBloccante(C700Progressivo,DataCorr);
          A042MW.R502ProDtM1.Conteggi('Cartellino',C700Progressivo,DataCorr);
        end;
        //Se invece è andato tutto bene...
        if (A042MW.R502ProDtM1.Blocca = 0) or ((A042MW.R502ProDtM1.Blocca = 2) and (rgpTipoStampa.ItemIndex = 2)) then
        begin
          //Se l'ultima timbratura è un'entrata
          if A042MW.R502ProDtM1.ultimt_e = 'si' then
            A042MW.TimbraturaMezzanotte:=True;
          //Se il dipendente era in servizio in DataCorr
          if (A042MW.R502ProDtM1.DipInser = 'si') then // stampa presenze
          begin
            //Verifico se il dipendente è presente...
            DipPresente:=A042MW.DipendentePresente(C700Progressivo,DataCorr);
            if (rgpTipoStampa.ItemIndex = 0) then
            begin
              if DipPresente then
                A042MW.InserisciDipendente(C700Progressivo,DataCorr);
                // inserire il dipendente in tabella.....
            end
            else
            begin
              //il tipo stampa non è il tipo stampa 1...
              A042MW.R502ProDtM1.Q430.Filtered:=True; // filtra lo storico per la data corrente
              if (A042MW.R502ProDtM1.Q430.FieldByName('TGestione').AsString = '1') and (chkTurnista.Checked) then  //il dipendente è un turnista ed io ho checcato la checkbox per la gestione dei turnisti...
                A042MW.R502ProDtM1.gglav:='si';
              if (not(DipPresente)) and (A042MW.R502ProDtM1.gglav <> 'no') then  //se il dipendente non è presente e si tratta di un gg lavotarivo...
              begin
                if rgpTipoStampa.ItemIndex = 1 then // stampa assenze.
                begin
                  A042MW.AggiornaQGiustificativiAssenza(C700Progressivo,DataCorr);
                  A042MW.InserisciDipendente(C700Progressivo,DataCorr);  //Inserisco il dipendente nella tabella...
                end
                else if rgpTipoStampa.ItemIndex = 2 then // stampa assenze senza giustificazione
                begin
                  StampaDipendente:=AssenteSenzaGiustificativo;
                  if StampaDipendente then
                    A042MW.InserisciDipendente(C700Progressivo,DataCorr);
                end;
              end;
            end;
          end
        end
        else
        begin
          A042MW.AggiornaQGiustificativi(C700Progressivo,DataCorr);   //Lorena 26/09/2006
          A042MW.AggiornaQTimbrature(C700Progressivo,DataCorr);
          A042MW.InserisciDipendente(C700Progressivo,DataCorr);
        end;
        //Application.ProcessMessages;
        //if InterruzioneElaborazione then Break;
        DataCorr:=DataCorr + 1;
      end;
      //if InterruzioneElaborazione then Break;
      C700SelAnagrafe.Next;
    end;
  end;
  finally
    //KeyPreview:=False;
    frmSelAnagrafe.ElaborazioneInterrompibile:=False;
    Self.Enabled:=True;
    frmSelAnagrafe.VisualizzaDipendente;
    ProgressBar.Position:=0;
    //StatusBar.Panels[1].Text:='';
  end;
end;

procedure TA042FDialogStampa.ScorriQueryAnagraficaTab;
var
  DataCorr:TDateTime;
  StampaDipendente,DipPresente:Boolean;
  Presenze:String;
begin
  with A042FStampaPreAssDtM1 do
  begin
    if AData - DaData > 144 then
      AData:=DaData + 144;

    A042MW.R502ProDtM1.Conteggi('APERTURA',0,Date);
    A042MW.R502ProDtM1.PeriodoConteggi(DaData,AData);
    ProgressBar.Position:=0;
    ProgressBar.Max:=C700SelAnagrafe.RecordCount * Trunc(AData - DaData + 1);
    C700SelAnagrafe.First;
    while not C700SelAnagrafe.EOF do
    begin  // inizio while esterno sui dipendenti
      frmSelAnagrafe.VisualizzaDipendente;
      Presenze:=StringOfChar('0',Trunc(AData-DaData+1)); // inizializzazione stringa per le Presenze/Assenze
      DataCorr:=DaData;
      while DataCorr <= AData do
      begin  // inizio while interno sulle date
        ProgressBar.StepBy(1);
        A042MW.TimbraturaMezzanotte:=False;
        A042MW.R502ProDtM1.Conteggi('Cartolina',C700Progressivo,DataCorr);
        if A042MW.R502ProDtM1.Blocca = 2 then
        begin
          // gestione anomalia bloccante.......
          A042MW.GestisciAnomaliaBloccante(C700Progressivo,DataCorr);
          A042MW.R502ProDtM1.Conteggi('Cartellino',C700Progressivo,DataCorr);
        end;
        if A042MW.R502ProDtM1.Blocca = 0 then
        begin
          if (A042MW.R502ProDtM1.DipInser = 'si') then // stampa presenze
          begin
            DipPresente:=A042MW.DipendentePresente(C700Progressivo,DataCorr);
            A042MW.R502ProDtM1.Q430.Filtered:=True; // filtra lo storico per la data corrente
            if (A042MW.R502ProDtM1.Q430.FieldByName('TGestione').AsString = '1') and (chkTurnista.Checked) then
              A042MW.R502ProDtM1.gglav:='si';
            if (not(DipPresente)) and (A042MW.R502ProDtM1.gglav <> 'no') then
            begin
              StampaDipendente:=AssenteSenzaGiustificativo;
              if StampaDipendente then
                Presenze[Trunc(Datacorr-DaData+1)]:='1';
            end;
          end;
        end;
        DataCorr:=DataCorr + 1;
      end; // fine while interno sulle date
        // scrivi record assenza non giustificata
        if Presenze<>StringOfChar('0',Trunc(AData-DaData+1)) then
           InserisciRecord(Presenze);
        C700SelAnagrafe.Next
    end; // fine while esterno sui dipendenti
  end;
  ProgressBar.Position:=0;
end;

procedure TA042FDialogStampa.ScorriQueryAnagraficaGrafico;
begin
  //Creo la form che conterrà il grafico...
  Application.CreateForm(TA042FGrafico,A042FGrafico);
  ContatoreDipendente:=0;
  setlength(A042FStampaPreAssDtM1.A042MW.aPb_DatiDipendentiTimbGiusH,0);
  setlength(A042FStampaPreAssDtM1.A042MW.aPb_DatiDipendentiTimbGiusH,1);  //Lunghezza 1 = elemento[0]
  setlength(A042FStampaPreAssDtM1.A042MW.aPb_DatiDipendentiGiustI,0);
  setlength(A042FStampaPreAssDtM1.A042MW.aPb_DatiDipendentiGiustI,1);  //Lunghezza 1 = elemento[0]
  setlength(A042FStampaPreAssDtM1.A042MW.aPb_DatiDipendentiGiustM,0);
  setlength(A042FStampaPreAssDtM1.A042MW.aPb_DatiDipendentiGiustM,1);  //Lunghezza 1 = elemento[0]
  setlength(A042FStampaPreAssDtM1.A042MW.aPb_LegendaCausali,0);  //Lunghezza 0
  with A042FGrafico do
  begin
    A042FStampaPreAssDtM1.A042MW.sDaData:=DateToStr(DaData);
    A042FStampaPreAssDtM1.A042MW.sAData:=DateToStr(DaData);
//    DaData:=StrtoDateTime(sDaData + ' 00.00.00');
//    AData:=StrtoDateTime(sAData + ' 23.59.59');
    Chart1.BottomAxis.Minimum:=0;
    Chart1.BottomAxis.Maximum:=0;
    ChartLegenda.BottomAxis.Minimum:=0;
    ChartLegenda.BottomAxis.Maximum:=0;
    Chart1.BottomAxis.Maximum:=StrtoDateTime(A042FStampaPreAssDtM1.A042MW.sAData + ' 23.59.59');
    Chart1.BottomAxis.Minimum:=StrtoDateTime(A042FStampaPreAssDtM1.A042MW.sDaData + ' 00.00.00');
    ChartLegenda.BottomAxis.Maximum:=StrtoDateTime(A042FStampaPreAssDtM1.A042MW.sAData + ' 23.59.59');
    ChartLegenda.BottomAxis.Minimum:=StrtoDateTime(A042FStampaPreAssDtM1.A042MW.sDaData + ' 00.00.00');
    Chart1.BottomAxis.Title.Caption:='DATA: ' + FormatDateTime('dd mmmm yyyy',DaData);
  end;
  //InterruzioneElaborazione:=False;
  //StatusBar.Panels[1].Text:='Premere ESC per interrompere';
  //KeyPreview:=True;
  frmSelAnagrafe.ElaborazioneInterrompibile:=True;
  Self.Enabled:=False;
  try
    with A042FStampaPreAssDtM1 do
    begin
      A042MW.R502ProDtM1.Conteggi('APERTURA',0,Date);
      A042MW.R502ProDtM1.PeriodoConteggi(DaData,AData);
      ProgressBar.Position:=0;
      ProgressBar.Max:=C700SelAnagrafe.RecordCount * Trunc(AData - DaData + 1);
      C700SelAnagrafe.First;
      while not C700SelAnagrafe.EOF do
      begin
        frmSelAnagrafe.VisualizzaDipendente;
        ProgressBar.StepBy(1);
        A042MW.TimbraturaMezzanotte:=False;
        //Eseguo i conteggi
        A042MW.R502ProDtM1.Conteggi('Cartolina',C700Progressivo,DaData);
        //ed inserisco i dati nell'array...
        InserisciDipendenteGrafico(C700Progressivo,DaData);
        //Application.ProcessMessages;
        //if InterruzioneElaborazione then Break;
        C700SelAnagrafe.Next;
      end;
    end;
  finally
    frmSelAnagrafe.ElaborazioneInterrompibile:=False;
    Self.Enabled:=True;
    frmSelAnagrafe.VisualizzaDipendente;
  end;
  //Ordino l'array delle causali
  A042FStampaPreAssDtM1.A042MW.OrdinaArrayCausali(cPb_CodiceOreNonCausalizzate);
  //Disegno il grafico
  DisegnaGrafico;
  try
    if (Trim(A042FDialogStampa.DocumentoPDF) <> '') and (Trim(A042FDialogStampa.DocumentoPDF) <> '<VUOTO>') and (Trim(A042FDialogStampa.TipoModulo) = 'COM')then
      A042FGrafico.BtnStampaClick(nil)
    else
      A042FGrafico.ShowModal;
  finally
    A042FGrafico.Free;
  end;
  //KeyPreview:=False;
  ProgressBar.Position:=0;
  //StatusBar.Panels[1].Text:='';
end;

procedure TA042FDialogStampa.ScorriQueryAnagraficaProspetto;
var
  i:integer;
begin
  //InterruzioneElaborazione:=False;
  //StatusBar.Panels[1].Text:='Premere ESC per interrompere';
  //KeyPreview:=True;
  frmSelAnagrafe.ElaborazioneInterrompibile:=True;
  Self.Enabled:=False;
  try
  with A042FStampaPreAssDtM1 do
  begin
    A042MW.R502ProDtM1.Conteggi('APERTURA',0,Date);
    A042MW.R502ProDtM1.PeriodoConteggi(DaData,AData);
    ProgressBar.Position:=0;
    ProgressBar.Max:=C700SelAnagrafe.RecordCount;
    C700SelAnagrafe.First;
    while not C700SelAnagrafe.EOF do
    begin
      frmSelAnagrafe.VisualizzaDipendente;
      ProgressBar.StepBy(1);
      i:=trunc(DaData);
      //for i:=trunc(DaData) to trunc(AData) do
      begin
        A042MW.TimbraturaMezzanotte:=False;
        //Eseguo i conteggi
        A042MW.R502ProDtM1.Conteggi('Cartolina',C700Progressivo,i);
        //ed inserisco i dati nell'array...
        A042MW.InserisciDipendenteProspetto(C700Progressivo,i);
        //Application.ProcessMessages;
        //if InterruzioneElaborazione then Break;
      end;
      C700SelAnagrafe.Next;
    end;
  end;
  finally
    frmSelAnagrafe.ElaborazioneInterrompibile:=False;
    Self.Enabled:=True;
    frmSelAnagrafe.VisualizzaDipendente;
    //KeyPreview:=False;
    ProgressBar.Position:=0;
    //StatusBar.Panels[1].Text:='';
  end;
end;

procedure TA042FDialogStampa.ScorriQueryAnagraficaEUCausalizzate;
var
  i:integer;
  nNumGiorni: integer;
begin
  //InterruzioneElaborazione:=False;
  //StatusBar.Panels[1].Text:='Premere ESC per interrompere';
  //KeyPreview:=True;
  frmSelAnagrafe.ElaborazioneInterrompibile:=True;
  Self.Enabled:=False;
  try
    with A042FStampaPreAssDtM1 do
    begin
      nNumGiorni:=trunc(AData - DaData) + 1;
      A042MW.R502ProDtM1.Conteggi('APERTURA',0,Date);
      A042MW.R502ProDtM1.PeriodoConteggi(DaData,AData);
      ProgressBar.Position:=0;
      ProgressBar.Max:=C700SelAnagrafe.RecordCount * nNumGiorni;
      A042MW.SelAnagrafe:=C700SelAnagrafe;
      C700SelAnagrafe.First;
      while not C700SelAnagrafe.EOF do
      begin
        frmSelAnagrafe.VisualizzaDipendente;
        for i:= 0 to nNumGiorni - 1 do
        begin
          ProgressBar.StepBy(1);
          A042MW.TimbraturaMezzanotte:=False;
          //Eseguo i conteggi
          A042MW.R502ProDtM1.Conteggi('Cartolina',C700Progressivo, DaData + i);
          //ed inserisco i dati nella tabella...
          A042MW.InserisciDipendenteTabellaEUCausalizzate(C700Progressivo, DaData + i);
          //Application.ProcessMessages;
          //if InterruzioneElaborazione then Break;
        end;
        C700SelAnagrafe.Next;
      end;
    end;
  finally
    frmSelAnagrafe.ElaborazioneInterrompibile:=False;
    Self.Enabled:=True;
    frmSelAnagrafe.VisualizzaDipendente;
    //KeyPreview:=False;
    ProgressBar.Position:=0;
    //StatusBar.Panels[1].Text:='';
  end;
end;

procedure TA042FDialogStampa.DisegnaGrafico;
var
  i,n:integer;
begin
  A042FGrafico.Chart1.Series[0].Clear;
  A042FGrafico.Chart1.Series[1].Clear;
  A042FGrafico.Chart1.Series[2].Clear;
  A042FGrafico.ChartLegenda.Series[0].Clear;
  //Inizio a piazzare nella serie1 i giustificativi di assenza a giornata intera...
  with A042FStampaPreAssDtM1.A042MW do
  begin
    for i:=1 to length(aPb_DatiDipendentiGiustI)-1 do
    begin
      //Inserisco il dipendente in ogni caso...
      A042FGrafico.Series1.AddGanttColor(0, 0, i, aPb_DatiDipendentiGiustI[i].sDescrizione, clwhite);
      //Inserisco i dati del dipendente...
      for n:=1 to length(aPb_DatiDipendentiGiustI[i].aDatiDipendente)-1 do
        if not bPb_MostraCausaliNonAbbinate then
        begin
          if aPb_DatiDipendentiGiustI[i].aDatiDipendente[n].xColore <> clWhite then  //mostro la causale soltanto se non è bianca...
            A042FGrafico.Series1.AddGanttColor(aPb_DatiDipendentiGiustI[i].aDatiDipendente[n].dDataDa, aPb_DatiDipendentiGiustI[i].aDatiDipendente[n].dDataA, i, aPb_DatiDipendentiGiustI[i].sDescrizione, aPb_DatiDipendentiGiustI[i].aDatiDipendente[n].xColore);
        end
        else  //altrimenti la mostro comunque
          A042FGrafico.Series1.AddGanttColor(aPb_DatiDipendentiGiustI[i].aDatiDipendente[n].dDataDa, aPb_DatiDipendentiGiustI[i].aDatiDipendente[n].dDataA, i, aPb_DatiDipendentiGiustI[i].sDescrizione, aPb_DatiDipendentiGiustI[i].aDatiDipendente[n].xColore);
    end;

    //Piazzo nella serie2 i giustificativi di assenza a mezza giornata o ad ore...
    for i:=1 to length(aPb_DatiDipendentiGiustM)-1 do
    begin
      //Inserisco il dipendente in ogni caso...
      A042FGrafico.Series1.AddGanttColor(0, 0, i, aPb_DatiDipendentiGiustM[i].sDescrizione, clwhite);
      //Inserisco i dati del dipendente...
      for n:=1 to length(aPb_DatiDipendentiGiustM[i].aDatiDipendente)-1 do
        if not bPb_MostraCausaliNonAbbinate then
        begin
          if aPb_DatiDipendentiGiustM[i].aDatiDipendente[n].xColore <> clWhite then  //mostro la causale soltanto se non è bianca...
            A042FGrafico.Series2.AddGanttColor(aPb_DatiDipendentiGiustM[i].aDatiDipendente[n].dDataDa, aPb_DatiDipendentiGiustM[i].aDatiDipendente[n].dDataA, i, aPb_DatiDipendentiGiustM[i].sDescrizione, aPb_DatiDipendentiGiustM[i].aDatiDipendente[n].xColore);
        end
        else  //altrimenti la mostro comunque
          A042FGrafico.Series2.AddGanttColor(aPb_DatiDipendentiGiustM[i].aDatiDipendente[n].dDataDa, aPb_DatiDipendentiGiustM[i].aDatiDipendente[n].dDataA, i, aPb_DatiDipendentiGiustM[i].sDescrizione, aPb_DatiDipendentiGiustM[i].aDatiDipendente[n].xColore);
    end;

    //Piazzo infine nella serie3 le timbrature ed i giustificativi di assenza da ora ad ora
    for i:=1 to length(aPb_DatiDipendentiTimbGiusH)-1 do
    begin
      //Inserisco il dipendente in ogni caso...
      A042FGrafico.Series1.AddGanttColor(0, 0, i, aPb_DatiDipendentiTimbGiusH[i].sDescrizione, clwhite);
      //Inserisco i dati del dipendente...
      for n:=1 to length(aPb_DatiDipendentiTimbGiusH[i].aDatiDipendente)-1 do
        if not bPb_MostraCausaliNonAbbinate then
        begin
          if aPb_DatiDipendentiTimbGiusH[i].aDatiDipendente[n].xColore <> clWhite then  //mostro la causale soltanto se non è bianca...
            A042FGrafico.Series3.AddGanttColor(aPb_DatiDipendentiTimbGiusH[i].aDatiDipendente[n].dDataDa, aPb_DatiDipendentiTimbGiusH[i].aDatiDipendente[n].dDataA, i, aPb_DatiDipendentiTimbGiusH[i].sDescrizione, aPb_DatiDipendentiTimbGiusH[i].aDatiDipendente[n].xColore);
        end
        else  //altrimenti la mostro comunque
          A042FGrafico.Series3.AddGanttColor(aPb_DatiDipendentiTimbGiusH[i].aDatiDipendente[n].dDataDa, aPb_DatiDipendentiTimbGiusH[i].aDatiDipendente[n].dDataA, i, aPb_DatiDipendentiTimbGiusH[i].sDescrizione, aPb_DatiDipendentiTimbGiusH[i].aDatiDipendente[n].xColore);
    end;

    A042FGrafico.Series4.AddGanttColor(0, 0, 0, ' ',clWhite);
    //Compilo infine la legenda delle causali...
    n:=0;
    for i:=0 to length(aPb_LegendaCausali)-1 do
      if not bPb_MostraCausaliNonAbbinate then
      begin
        if aPb_LegendaCausali[i].xColore <> clWhite then  //mostro la causale soltanto se non è bianca...
        begin
          n:=n+1;
          if aPb_LegendaCausali[i].sCodice =cPb_CodiceOreNonCausalizzate then
            A042FGrafico.Series4.AddGanttColor(strtodatetime(sDaData + ' 08.00.00'), strtodatetime(sDaData + ' 16.00.00'), n, 'Ore n.c' ,aPb_LegendaCausali[i].xColore)
          else
            A042FGrafico.Series4.AddGanttColor(strtodatetime(sDaData + ' 08.00.00'), strtodatetime(sDaData + ' 16.00.00'), n, aPb_LegendaCausali[i].sCodice,aPb_LegendaCausali[i].xColore);
        end;
      end
      else  //altrimenti la mostro comunque
      begin
        if aPb_LegendaCausali[i].sCodice =cPb_CodiceOreNonCausalizzate then
          A042FGrafico.Series4.AddGanttColor(strtodatetime(sDaData + ' 08.00.00'), strtodatetime(sDaData + ' 16.00.00'), i+1, 'Ore n.c' ,aPb_LegendaCausali[i].xColore)
        else
          A042FGrafico.Series4.AddGanttColor(strtodatetime(sDaData + ' 08.00.00'), strtodatetime(sDaData + ' 16.00.00'), i+1, aPb_LegendaCausali[i].sCodice,aPb_LegendaCausali[i].xColore);
      end;
  end;
end;

procedure TA042FDialogStampa.BtnStampaClick(Sender: TObject);
var
  S:String;
  sDep:string;
  i:Integer;
begin
  Screen.Cursor:=crHourGlass;
  try
    Anteprima:=Sender = btnAnteprima;

    with A042FStampaPreAssDtM1 do
    begin
      DaData:=StrToDate(edtDaData.Text);
      AData:=StrToDate(edtAData.Text);
      A042MW.DaOra:=edtDaOra.Text;
      A042MW.AOra:=edtAOra.Text;

      A042MW.ChkDescrizioneAssenzeMW:=chkDescrizioneAssenze.Checked;
      A042MW.RgpTipoStampaMW:=rgpTipoStampa.ItemIndex;

      if rgpTipoStampa.ItemIndex = 3 then
        AData:=DaData;

      if frmSelAnagrafe.SettaPeriodoSelAnagrafe(DaData,AData) then
        C700SelAnagrafe.CloseAll;

      if (A042FStampaPreAssDtM1.A042MW.ListaIntestazione.Count > 0) or (A042MW.ListaDettaglio.Count > 0) then
      begin
        S:=C700SelAnagrafe.SQL.Text;
        for i:=0 to A042FStampaPreAssDtM1.A042MW.ListaIntestazione.Count - 1 do
          R180InserisciColonna(S,AliasTabella(A042FStampaPreAssDtM1.A042MW.ListaIntestazione.Strings[i]) + '.' + A042FStampaPreAssDtM1.A042MW.ListaIntestazione.Strings[i]);
        for i:=0 to A042MW.ListaDettaglio.Count - 1 do
          if Pos(A042MW.ListaDettaglio.Strings[i],Copy(S,1,Pos('FROM',S))) <= 0 then
            R180InserisciColonna(S,AliasTabella(A042MW.ListaDettaglio.Strings[i])+'.'+A042MW.ListaDettaglio.Strings[i]);
        C700SelAnagrafe.CloseAll;
        C700SelAnagrafe.SQL.Text:=S;
      end;
    end;
    C700SelAnagrafe.Open;
    if C700SelAnagrafe.RecordCount = 0 then
      raise exception.Create('Attenzione: nessun dipendente selezionato!');
    Controlli;

    if rgpTipoStampa.ItemIndex = 3 then  //Grafico presenze/assenze
      ScorriQueryAnagraficaGrafico
    else if rgpTipoStampa.ItemIndex = 4 then  //Prospetto ore mensile
    begin
      A042FStampaPreAssDtM1.A042Mw.CreaTabellaStampaProspetto;
      ScorriQueryAnagraficaProspetto;
      A042FStampaProspetto.sDaData:=FormatDateTime('dd/mm/yyyy',DaData);
      A042FStampaProspetto.sDaOra:=A042FStampaPreAssDtM1.A042MW.DaOra;
      A042FStampaProspetto.sAOra:=A042FStampaPreAssDtM1.A042MW.AOra;
      A042FStampaProspetto.sOraDaLimite1:=FormatDateTime('hh.nn',A042FStampaPreAssDtM1.A042MW.tOraDaLimite1);
      A042FStampaProspetto.sOraALimite1:=FormatDateTime('hh.nn',A042FStampaPreAssDtM1.A042MW.tOraALimite1);
      A042FStampaProspetto.sOraDaLimite2:=FormatDateTime('hh.nn',A042FStampaPreAssDtM1.A042MW.tOraDaLimite2);
      A042FStampaProspetto.sOraALimite2:=FormatDateTime('hh.nn',A042FStampaPreAssDtM1.A042MW.tOraALimite2);
      A042FStampaProspetto.sLimite1:= FormatDateTime('hh.nn', A042FStampaPreAssDtM1.A042MW.tPb_Limite1);
      A042FStampaProspetto.sLimite2:=FormatDateTime('hh.nn', A042FStampaPreAssDtM1.A042MW.tPb_Limite2);
      A042FStampaProspetto.bSaltoPagina:=chkSaltoPagina.Checked;
      A042FStampaProspetto.CreaReport;
      A042FStampaPreAssDtM1.A042MW.TabellaStampa.Close;
    end
    else if rgpTipoStampa.ItemIndex = 5 then  //E-U causalizzate
    begin
      A042FStampaPreAssDtM1.A042MW.CreaTabellaStampaEUCausalizzate;

      Self.Enabled:=False;
      frmSelAnagrafe.ElaborazioneInterrompibile:=True;
      ScorriQueryAnagraficaEUCausalizzate;

      if Sender = btnTabella then
      begin
        A042FStampaPreAssDtM1.A042MW.TabellaStampa.FieldByName('GRUPPO').Visible:=A042FStampaPreAssDtM1.A042MW.ListaIntestazione.Count > 0;
        OpenC020VisualizzaDataSet('<A042> Entrate/Uscite causalizzate',A042FStampaPreAssDtM1.A042MW.TabellaStampa,800,400)
      end
      else
      begin
        A042FStampaEUCausalizzate.DataSet:=A042FStampaPreAssDtM1.A042MW.TabellaStampa;
        A042FStampaEUCausalizzate.Periodo:='PERIODO: dal ' + DateToStr(DaData) + ' al ' + DateToStr(AData);
        if A042FStampaPreAssDtM1.A042MW.selT275.SearchRecord('CODICE', A042FStampaPreAssDtM1.A042MW.sPb_CausaleEU, [srFromBeginning]) then
          sDep:= ' - ' + A042FStampaPreAssDtM1.A042MW.selT275.fieldbyname('DESCRIZIONE').asString
        else
          sDep:='';
        A042FStampaEUCausalizzate.Titolo:= 'PROSPETTO DELLE ENTRATE/USCITE CAUSALIZZATE (' + A042FStampaPreAssDtM1.A042MW.sPb_CausaleEU + sDep + ')';
        A042FStampaEUCausalizzate.CreaReport;
        A042FStampaPreAssDtM1.A042MW.TabellaStampa.Close;
      end;
    end
    else
    begin
      A042FStampaPreAssDtM1.A042MW.CreaTabellaStampa(chkTabellare.Checked);
      if rgpTipoStampa.ItemIndex in [1,2] then
      begin
        A042FStampaPreAssDtM1.A042MW.DaOra:='00.00';
        A042FStampaPreAssDtM1.A042MW.AOra:='23.59';
      end;
      if (rgpTipoStampa.ItemIndex = 2) and (chkTabellare.Checked) then // Stampa tabellare
      begin
        ScorriQueryAnagraficaTab;
        A042FStampaTab.DaData:=DaData;
        A042FStampaTab.AData:=AData;
        A042FStampaTab.DaOra:=A042FStampaPreAssDtM1.A042MW.DaOra;
        A042FStampaTab.AOra:=A042FStampaPreAssDtM1.A042MW.AOra;
        A042FStampaTab.CreaReport;
      end
      else
      begin
        A042FStampaPreAssDtM1.A042MW.ChkDescrizioneAssenzeMW:=chkDescrizioneAssenze.Checked;
        ScorriQueryAnagrafica;
        A042FStampa.DaData:=DaData;
        A042FStampa.AData:=AData;
        A042FStampa.DaOra:=A042FStampaPreAssDtM1.A042MW.DaOra;
        A042FStampa.AOra:=A042FStampaPreAssDtM1.A042MW.AOra;
        A042FStampa.CreaReport;
      end;
      A042FStampaPreAssDtM1.A042MW.TabellaStampa.Close;
    end;
  finally
    C700SelAnagrafe.First;
    frmSelAnagrafe.VisualizzaDipendente;
    Screen.Cursor:=crDefault;
  end;
end;

procedure TA042FDialogStampa.Controlli;
begin
  if (rgpTipoStampa.ItemIndex = 0) or (rgpTipoStampa.ItemIndex = 1) or (rgpTipoStampa.ItemIndex = 2) then  //stampa Presenti o Prospetto
    if DaData > AData then
      raise Exception.Create('La data iniziale non può essere superiore a quella finale!');
  if (rgpTipoStampa.ItemIndex = 0) or (rgpTipoStampa.ItemIndex = 4) then  //stampa Presenti o Prospetto
    if R180OreMinutiExt(A042FStampaPreAssDtM1.A042MW.DaOra) > R180OreMinutiExt(A042FStampaPreAssDtM1.A042MW.AOra) then
      raise exception.Create('L''ora iniziale non può essere superiore a quella finale!');
  if rgpTipoStampa.ItemIndex = 5 then  //Prospetto ore mensile
    if A042FStampaPreAssDtM1.A042MW.sPb_CausaleEU = '' then
      raise exception.Create('Selezionare una causale di presenza cliccando sul bottone ''Impostazioni avanzate''.');
end;

procedure TA042FDialogStampa.BtnDaDataClick(Sender: TObject);
begin
  edtDaData.Text:=FormatDateTime('dd/mm/yyyy',(DataOut(StrToDate(edtDaData.Text),'Dalla data:','G')));
end;

procedure TA042FDialogStampa.BtnADataClick(Sender: TObject);
begin
  edtAData.Text:=FormatDateTime('dd/mm/yyyy',(DataOut(StrToDate(edtAData.Text),'Alla data:','G')));
end;

procedure TA042FDialogStampa.FormDestroy(Sender: TObject);
begin
  A042FStampa.Release;
  A042FStampaTab.Release;
  A042FStampaGrafico.Free;
  A042FStampaProspetto.Free;
  frmSelAnagrafe.DistruggiSelAnagrafe;
end;

procedure TA042FDialogStampa.GetParametriFunzione;
{Leggo i parametri della form}
var S:String;
  i:Integer;
begin
  (*S:=C004FParamForm.GetParametro('DADATA', DateToStr(R180InizioMese(Parametri.DataLavoro)));
  try
    //SE LA PRECEDENTE DATA NON E' STATA SALVATA O E' NULLA
    //VALORIZZO IL TEXT CON LA DATA DI LAVORO
    edtDaData.Text:=DateToStr(StrToDate(S));
  except
    edtDaData.Text:=DateToStr(Parametri.DataLavoro);
  end;*)
  (*S:=C004FParamForm.GetParametro('ADATA', DateToStr(R180FineMese(Parametri.DataLavoro)));
  try
    //SE LA PRECEDENTE DATA NON E' STATA SALVATA O E' NULLA
    //VALORIZZO IL TEXT CON IL FINE MESE DELLA DATA DI LAVORO
    edtAData.Text:=DateToStr(StrToDate(S));
  except
    edtAData.Text:=DateToStr(R180FineMese(Parametri.DataLavoro));
  end;*)
  edtDaData.Text:=DateToStr(R180InizioMese(Parametri.DataLavoro));
  edtAData.Text:=DateToStr(R180FineMese(Parametri.DataLavoro));
  chkGiornoCorrente.Checked:=C004FParamForm.GetParametro('GIORNO_CORRENTE','N') = 'S';
  chkGiornoCorrenteClick(nil);
  edtDaOra.Text:=C004FParamForm.GetParametro('DAORA', '00.00');
  edtAOra.Text:=C004FParamForm.GetParametro('AORA', '23.59');
  rgpTipoStampa.ItemIndex:=StrToInt(C004FParamForm.GetParametro('TIPOSTAMPA','0'));
  chkDescrizioneAssenze.Checked:=C004FParamForm.GetParametro('DESCRIZIONE_ASSENZE','N') = 'S';
  chkSaltoPagina.Checked:=C004FParamForm.GetParametro('SALTOPAGINA','N') = 'S';
  chkTurnista.Checked:=C004FParamForm.GetParametro('TURNISTA','N') = 'S';
  chkTabellare.Checked:=C004FParamForm.GetParametro('STAMPATABELLARE','N') = 'S';
  chkRaggData.Checked:=C004FParamForm.GetParametro('RAGGRUPPADATA','N') = 'S';
  chkTotaliData.Checked:=C004FParamForm.GetParametro('TOTALIDATA','N') = 'S';
  chkSaltoPaginaData.Checked:=C004FParamForm.GetParametro('SALTOPAGDATA','N') = 'S';
  chkTotaliGruppo.Checked:=C004FParamForm.GetParametro('TOTALIGRUPPO','N') = 'S';
  chkTotali.Checked:=C004FParamForm.GetParametro('TOTALIGEN','N') = 'S';
  S:=C004FParamForm.GetParametro('CAMPORAGGRUPPA','');
  if Trim(S) <> '' then
  begin
    for i:=0 to chkLIntestazione.Items.Count - 1 do
      if Pos(VarToStr(A042FStampaPreAssDtM1.A042MW.selI010.Lookup('NOME_LOGICO',chkLIntestazione.Items[i],'NOME_CAMPO')),S) > 0 then
        chkLIntestazione.Checked[i]:=True;
  end;
  chkLIntestazioneClick(nil);
  S:=C004FParamForm.GetParametro('CAMPODETTAGLIO','');
  if Trim(S) <> '' then
  begin
    for i:=0 to chkLDettaglio.Items.Count - 1 do
      if Pos(VarToStr(A042FStampaPreAssDtM1.A042MW.selI010.Lookup('NOME_LOGICO',chkLDettaglio.Items[i],'NOME_CAMPO')),S) > 0 then
        chkLDettaglio.Checked[i]:=True;
  end;
  chkLDettaglioClick(nil);

  A042FStampaPreAssDtM1.A042MW.bPb_MostraCausaliNonAbbinate:=C004FParamForm.GetParametro('CAUSALI_NON_ABBINATE','S') = 'S';
  //Carico l'array delle causali/colori...
  A042FStampaPreAssDtM1.A042MW.PopolaArrayCausali;
  //Carico la causale da utilizzare per la stampaEUCausalizzate
  A042FStampaPreAssDtM1.A042MW.sPb_CausaleEU:=C004FParamForm.GetParametro('CAUSEU','');
  //Carico i parametri per il prospetto delle ore...
  A042FStampaPreAssDtM1.A042MW.tPb_Limite1:=strtotime(C004FParamForm.GetParametro('ORELIM1','5.00'));
  A042FStampaPreAssDtM1.A042MW.bPb_Intervallo1:=C004FParamForm.GetParametro('INT1','S') = 'S';
  A042FStampaPreAssDtM1.A042MW.bPb_Giornata1:=C004FParamForm.GetParametro('GIO1','N') = 'S';
  A042FStampaPreAssDtM1.A042MW.tPb_Limite2:=strtotime(C004FParamForm.GetParametro('ORELIM2','12.00'));
  A042FStampaPreAssDtM1.A042MW.bPb_Intervallo2:=C004FParamForm.GetParametro('INT2','N') = 'S';
  A042FStampaPreAssDtM1.A042MW.bPb_Giornata2:=C004FParamForm.GetParametro('GIO2','S') = 'S';
end;

procedure TA042FDialogStampa.PutParametriFunzione;
{Scrivo i parametri della forma}
var
  i:integer;
begin
  C004FParamForm.Cancella001;
  //C004FParamForm.PutParametro('DADATA', edtDaData.Text);
  //C004FParamForm.PutParametro('ADATA', edtAData.Text);
  C004FParamForm.PutParametro('GIORNO_CORRENTE', IfThen(chkGiornoCorrente.Checked,'S','N'));
  C004FParamForm.PutParametro('DAORA', edtDaOra.Text);
  C004FParamForm.PutParametro('AORA', edtAOra.Text);
  C004FParamForm.PutParametro('TIPOSTAMPA',IntToStr(rgpTipoStampa.ItemIndex));
  C004FParamForm.PutParametro('DESCRIZIONE_ASSENZE', IfThen(chkDescrizioneAssenze.Checked,'S','N'));
  if chkSaltoPagina.Checked then
    C004FParamForm.PutParametro('SALTOPAGINA','S')
  else
    C004FParamForm.PutParametro('SALTOPAGINA','N');
  if chkTurnista.Checked then
    C004FParamForm.PutParametro('TURNISTA','S')
  else
    C004FParamForm.PutParametro('TURNISTA','N');
  if chkTabellare.Checked then
    C004FParamForm.PutParametro('STAMPATABELLARE','S')
  else
    C004FParamForm.PutParametro('STAMPATABELLARE','N');
  C004FParamForm.PutParametro('CAMPORAGGRUPPA',A042FStampaPreAssDtM1.A042MW.ListaIntestazione.Text);
  C004FParamForm.PutParametro('CAMPODETTAGLIO',A042FStampaPreAssDtM1.A042MW.ListaDettaglio.Text);
  if chkRaggData.Checked then
    C004FParamForm.PutParametro('RAGGRUPPADATA','S')
  else
    C004FParamForm.PutParametro('RAGGRUPPADATA','N');
  if chkTotaliData.Checked then
    C004FParamForm.PutParametro('TOTALIDATA','S')
  else
    C004FParamForm.PutParametro('TOTALIDATA','N');
  if chkSaltoPaginaData.Checked then
    C004FParamForm.PutParametro('SALTOPAGDATA','S')
  else
    C004FParamForm.PutParametro('SALTOPAGDATA','N');
  if chkTotaliGruppo.Checked then
    C004FParamForm.PutParametro('TOTALIGRUPPO','S')
  else
    C004FParamForm.PutParametro('TOTALIGRUPPO','N');
  if chkTotali.Checked then
    C004FParamForm.PutParametro('TOTALIGEN','S')
  else
    C004FParamForm.PutParametro('TOTALIGEN','N');


    if A042FStampaPreAssDtM1.A042MW.bPb_MostraCausaliNonAbbinate then
      C004FParamForm.PutParametro('CAUSALI_NON_ABBINATE','S')
    else
      C004FParamForm.PutParametro('CAUSALI_NON_ABBINATE','N');
  //Adesso salvo i dati della mappa dei colori...
  //Memorizzo le causali di presenza...
  for i:=0 to length(A042FStampaPreAssDtM1.A042MW.aPb_CausaliPresenzaDb)-1 do
    C004FParamForm.PutParametro('COLOREP_' + A042FStampaPreAssDtM1.A042MW.aPb_CausaliPresenzaDb[i].sCodice, IntToStr(A042FStampaPreAssDtM1.A042MW.aPb_CausaliPresenzaDb[i].xColore));
  //Memorizzo le causali di assenza...
  for i:=0 to length(A042FStampaPreAssDtM1.A042MW.aPb_CausaliAssenzaDb)-1 do
    C004FParamForm.PutParametro('COLOREA_' + A042FStampaPreAssDtM1.A042MW.aPb_CausaliAssenzaDb[i].sCodice, IntToStr(A042FStampaPreAssDtM1.A042MW.aPb_CausaliAssenzaDb[i].xColore));

  with A042FStampaPreAssDtM1.A042MW do
  begin
    //Salvo la causale da utilizzare per la stampaEUCausalizzate
    C004FParamForm.PutParametro('CAUSEU', sPb_CausaleEU);

    //Salvo i parametri per il prospetto delle ore...
    C004FParamForm.PutParametro('ORELIM1',FormatDateTime('hh.nn', tPb_Limite1));
    if bPb_Intervallo1 then
      C004FParamForm.PutParametro('INT1','S')
    else
      C004FParamForm.PutParametro('INT1','N');
    if bPb_Giornata1 then
      C004FParamForm.PutParametro('GIO1','S')
    else
      C004FParamForm.PutParametro('GIO1','N');
    C004FParamForm.PutParametro('ORELIM2',FormatDateTime('hh.nn',tPb_Limite2));
    if bPb_Intervallo2 then
      C004FParamForm.PutParametro('INT2','S')
    else
      C004FParamForm.PutParametro('INT2','N');
    if bPb_Giornata2 then
      C004FParamForm.PutParametro('GIO2','S')
    else
      C004FParamForm.PutParametro('GIO2','N');
  end;

  try SessioneOracle.Commit; except end;
end;

procedure TA042FDialogStampa.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  PutParametriFunzione;
  C004FParamForm.Free;
  FreeAndNil(A042FStampaPreAssDtM1.A042MW.ListaIntestazione);
  FreeAndNil(A042FStampaPreAssDtM1.A042MW.ListaDettaglio);
end;

procedure TA042FDialogStampa.frmSelAnagrafeR003DatianagraficiClick(
  Sender: TObject);
begin
  C005DataVisualizzazione:=AData;
  frmSelAnagrafe.R003DatianagraficiClick(Sender);
end;

procedure TA042FDialogStampa.frmSelAnagrafebtnSelezioneClick(
  Sender: TObject);
begin
  C700DataDal:=StrToDate(edtDaData.Text);
  C700DataLavoro:=StrToDate(edtAData.Text);
  frmSelAnagrafe.btnSelezioneClick(Sender);
end;

procedure TA042FDialogStampa.BtnAvanzatiClick(Sender: TObject);
begin
  If rgpTipoStampa.ItemIndex = 3 then
    OpenA042ImpostazioniGrafico
  else if rgpTipoStampa.ItemIndex = 4 then
    OpenA042ImpostazioniProspetto
  else if rgpTipoStampa.ItemIndex = 5 then
    OpenA042ImpostazioniEUCausalizzate;
end;

procedure TA042FDialogStampa.rgpTipoStampaClick(Sender: TObject);
begin
  Abilitazioni;
end;

procedure TA042FDialogStampa.chkLIntestazioneClick(Sender: TObject);
var
  i:Integer;
begin
  A042FStampaPreAssDtM1.A042MW.ListaIntestazione.Clear;
//  ListaIntestazione.CommaText:=R180GetCheckList(50,chkLIntestazione,',');  //Lorena 06/12/2006
  for i:=0 to chkLIntestazione.Items.Count - 1 do
    if chkLIntestazione.Checked[i] then
      A042FStampaPreAssDtM1.A042MW.ListaIntestazione.Add(VarToStr(A042FStampaPreAssDtM1.A042MW.selI010.Lookup('NOME_LOGICO',chkLIntestazione.Items[i],'NOME_CAMPO')));
  Abilitazioni;
end;

procedure TA042FDialogStampa.chkGiornoCorrenteClick(Sender: TObject);
begin
  if chkGiornoCorrente.Checked then
  begin
    edtDaData.Text:=DateToStr(Date);
    edtAData.Text:=DateToStr(Date);
  end;
  edtDaData.Enabled:=not chkGiornoCorrente.Checked;
  edtAData.Enabled:=not chkGiornoCorrente.Checked;
  btnDaData.Enabled:=not chkGiornoCorrente.Checked;
  btnAData.Enabled:=not chkGiornoCorrente.Checked;
  Label1.Enabled:=not chkGiornoCorrente.Checked;
  Label2.Enabled:=not chkGiornoCorrente.Checked;
end;

procedure TA042FDialogStampa.chkLDettaglioClick(Sender: TObject);
var
  i:Integer;
begin
  A042FStampaPreAssDtM1.A042MW.ListaDettaglio.Clear;
//  ListaDettaglio.CommaText:=R180GetCheckList(50,chkLDettaglio,',');  //Lorena 06/12/2006
  for i:=0 to chkLDettaglio.Items.Count - 1 do
    if chkLDettaglio.Checked[i] then
      A042FStampaPreAssDtM1.A042MW.ListaDettaglio.Add(VarToStr(A042FStampaPreAssDtM1.A042MW.selI010.Lookup('NOME_LOGICO',chkLDettaglio.Items[i],'NOME_CAMPO')));
  Abilitazioni;
end;

procedure TA042FDialogStampa.Selezionatutto1Click(Sender: TObject);
var i:Integer;
begin
  with (PopupMenu1.PopupComponent as TCheckListBox) do
  begin
    for i:=0 to Items.Count - 1 do
      Checked[i]:=Sender = SelezionaTutto1;
    if Name = 'chkLIntestazione' then
      chkLIntestazioneClick(nil)
    else
      chkLDettaglioClick(nil);
  end;
end;

procedure TA042FDialogStampa.chkRaggDataClick(Sender: TObject);
begin
  Abilitazioni;
end;

procedure TA042FDialogStampa.chkLIntestazioneMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
//var C1,C2:Boolean;
begin
  if (ItemCB <> -1) and
     (chkLIntestazione.ItemIndex <> -1) and
     (ItemCB <> chkLIntestazione.ItemIndex) then
  begin
    //C1:=chkLIntestazione.Checked[ItemCB];
    //C2:=chkLIntestazione.Checked[chkLIntestazione.ItemIndex];
    chkLIntestazione.Items.Exchange(ItemCB,chkLIntestazione.ItemIndex);
    //chkLIntestazione.Checked[ItemCB]:=C2;
    //chkLIntestazione.Checked[chkLIntestazione.ItemIndex]:=C1;
  end;
  ItemCB:= - 1;
end;

procedure TA042FDialogStampa.chkLIntestazioneMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  ItemCB:=chkLIntestazione.ItemIndex;
end;

procedure TA042FDialogStampa.chkLDettaglioMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  ItemCB:=chkLDettaglio.ItemIndex;
end;

procedure TA042FDialogStampa.chkLDettaglioMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
//var C1,C2:Boolean;
begin
  if (ItemCB <> -1) and
     (chkLDettaglio.ItemIndex <> -1) and
     (ItemCB <> chkLDettaglio.ItemIndex) then
  begin
    //C1:=chkLDettaglio.Checked[ItemCB];
    //C2:=chkLDettaglio.Checked[chkLDettaglio.ItemIndex];
    chkLDettaglio.Items.Exchange(ItemCB,chkLDettaglio.ItemIndex);
    //chkLDettaglio.Checked[ItemCB]:=C2;
    //chkLDettaglio.Checked[chkLDettaglio.ItemIndex]:=C1;
  end;
  ItemCB:= - 1;
end;

procedure TA042FDialogStampa.chkTabellareClick(Sender: TObject);
begin
  Abilitazioni;
end;

procedure TA042FDialogStampa.Abilitazioni;
begin
  BtnAvanzati.Enabled:=rgpTipoStampa.ItemIndex in [3,4,5];
  BtnAData.Enabled:=(rgpTipoStampa.ItemIndex in [0,1,2,5]) and (not chkGiornoCorrente.Checked);
  edtAData.Enabled:=(rgpTipoStampa.ItemIndex in [0,1,2,5]) and (not chkGiornoCorrente.Checked);;
  edtDaOra.Enabled:=rgpTipoStampa.ItemIndex in [0,4];
  edtAOra.Enabled:=rgpTipoStampa.ItemIndex in [0,4];
  btnTabella.Enabled:=rgpTipoStampa.ItemIndex in [5];
  chkTurnista.Enabled:=rgpTipoStampa.ItemIndex in [0,1,2];
  if not chkTurnista.Enabled then
    chkTurnista.Checked:=False;
  chkTabellare.Enabled:=rgpTipoStampa.ItemIndex in [2];
  if not chkTabellare.Enabled then
    chkTabellare.Checked:=False;

  chkLIntestazione.Enabled:=rgpTipoStampa.ItemIndex in [0,1,2,4,5];
  chkSaltoPagina.Enabled:=(rgpTipoStampa.ItemIndex in [0,1,2,4]) and (A042FStampaPreAssDtM1.A042MW.ListaIntestazione.Count > 0);
  if not chkSaltoPagina.Enabled then
    chkSaltoPagina.Checked:=False;
  chkTotaliGruppo.Enabled:=(rgpTipoStampa.ItemIndex in [0,1,2]) and (A042FStampaPreAssDtM1.A042MW.ListaIntestazione.Count > 0) and
                           (not chkTabellare.Checked);
  if not chkTotaliGruppo.Enabled then
    chkTotaliGruppo.Checked:=False;
  chkTotali.Enabled:=(rgpTipoStampa.ItemIndex in [0,1,2]) and (not chkTabellare.Checked);
  if not chkTotali.Enabled then
    chkTotali.Checked:=False;

  chkRaggData.Enabled:=(rgpTipoStampa.ItemIndex in [0,1,2]) and (not chkTabellare.Checked);
  if not chkRaggData.Enabled then
    chkRaggData.Checked:=False;
  chkSaltoPaginaData.Enabled:=(chkRaggData.Checked) and (not chkSaltoPagina.Enabled);
  if not chkSaltoPaginaData.Enabled then
    chkSaltoPaginaData.Checked:=False;
  chkTotaliData.Enabled:=chkRaggData.Checked;
  if not chkTotaliData.Enabled then
    chkTotaliData.Checked:=False;

  chkLDettaglio.Enabled:=(rgpTipoStampa.ItemIndex in [0,1,2]) and (not chkTabellare.Checked);
  chkDescrizioneAssenze.Enabled:=(rgpTipoStampa.ItemIndex = 1) and (not chkTabellare.Checked);
end;

procedure TA042FDialogStampa.edtDaOraExit(Sender: TObject);
begin
  try
    OreMinutiValidate(TMaskEdit(Sender).Text);
  except
    TWinControl(Sender).SetFocus;
    raise;
  end;
end;

procedure TA042FDialogStampa.edtADataDblClick(Sender: TObject);
begin
  try
    edtAData.Text:=DateToStr(R180FineMese(StrToDate(edtDaData.Text)));
  except
  end;
end;

end.
