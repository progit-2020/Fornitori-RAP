unit W018URiepilogoEccedenzeFM;

interface

uses
  SysUtils, Classes, Controls, Forms, IWAppForm,
  IWRegion,
  IWTemplateProcessorHTML,
  DB, DBClient,
  Oracle, OracleData, Math, StrUtils,
  C180FunzioniGenerali, C190FunzioniGeneraliWeb, R010UPaginaWeb, R450, Rp502Pro,
  W018URichiestaTimbratureDM, medpIWDBGrid, meIWButton,
  IWCompJQueryWidget, IWCompGrids, IWVCLComponent, IWBaseLayoutComponent,
  IWBaseContainerLayout, IWContainerLayout, IWDBGrids, IWVCLBaseControl,
  IWBaseControl, IWBaseHTMLControl, IWControl, IWCompButton, IWVCLBaseContainer,
  IWContainer, IWHTMLContainer, IWHTML40Container;

type
  TW018FRiepilogoEccedenzeFM = class(TFrame)
    IWFrameRegion: TIWRegion;
    btnChiudi: TmeIWButton;
    IWTemplateProcessorFrame: TIWTemplateProcessorHTML;
    jQVisFrame: TIWJQueryWidget;
    grdRiepilogoOre: TmedpIWDBGrid;
    dsrRiep: TDataSource;
    cdsRiep: TClientDataSet;
    procedure IWFrameRegionCreate(Sender: TObject);
    procedure btnChiudiClick(Sender: TObject);
    procedure grdRiepilogoOreRenderCell(ACell: TIWGridCell; const ARow, AColumn: Integer);
  private
    R502ProDtM1: TR502ProDtM1;
    R450DtM1: TR450DtM1;
    RiepOreInizioTot: Integer;
  public
    Progressivo: Integer;
    DataSelez,
    DataInizio,
    DataFine: TDateTime;
    W018DM: TW018FRichiestaTimbratureDM;
    function Visualizza: Boolean;
  end;

implementation

{$R *.dfm}

uses A000UInterfaccia;

procedure TW018FRiepilogoEccedenzeFM.IWFrameRegionCreate(Sender: TObject);
const
  FUNZIONE = 'W018Riepilogo.IWFrameRegionCreate';
begin
  Self.Parent:=(Self.Owner as TIWAppForm);
  (Self.Parent as TR010FPaginaWeb).Log('Traccia',FUNZIONE + ': fine');
end;

function TW018FRiepilogoEccedenzeFM.Visualizza: Boolean;
const
  FUNZIONE = 'W018Riepilogo.Visualizza';
var
  DataAttuale,D: TDateTime;
  Ore,OrePerSaldo,OreCausalizzabili,OreEsclNormRecup,OreEsclNormPagam,
  OreRicRecup1,OreRicRecup2,OreRicRecup,
  OreRicPagam1,OreRicPagam2,OreRicPagam,SaldoOre,
  SumOre,SumOreCaus,SumOreRicRecup,
  SumOreRicPagam,SumSaldoOre,i,j,Sumtminpres,
  SaldoUltRiep,SogliaOreCausalizzabili,
  UltOreRicRecup,UltOreRicPagam: Integer;
  Autorizzazione,Elaborato,ElencoCausRec,ElencoCausPag,
  TipoRichiestaWeb,OreNormali,CompName,Titolo,LogTesto: String;
  AddLine,EsistonoRichieste,ErrCont1,ErrCont2: Boolean;
  DataUltRiep: TDateTime;
begin
  (Self.Parent as TR010FPaginaWeb).Log('Traccia',FUNZIONE + ': inizio');
  inherited;
  grdRiepilogoOre.medpDataSet:=W018DM.cdsRiepOre;
  (Self.Parent as TR010FPaginaWeb).Log('Traccia',FUNZIONE + ': grdRiepilogoOre.medpDataSet impostato');

  // variabile per i conteggi
  R502ProDtM1:=TR502ProDtM1.Create(Self);
  (Self.Parent as TR010FPaginaWeb).Log('Traccia',FUNZIONE + ': Creazione R502ProDtM1 completata');
  R450DtM1:=TR450DtM1.Create(nil);
  (Self.Parent as TR010FPaginaWeb).Log('Traccia',FUNZIONE + ': Creazione R450DtM1 completata');

  // clientdataset per i conteggi
  with W018DM.cdsRiepOre do
  begin
    Close;
    CreateDataset;
    LogChanges:=False;
    Open;
    EmptyDataset;
  end;
  (Self.Parent as TR010FPaginaWeb).Log('Traccia',FUNZIONE + ': Impostazione clientdataset completata');

  // imposta periodo conteggi
  R502ProDtM1.PeriodoConteggi(DataInizio,DataFine);
  (Self.Parent as TR010FPaginaWeb).Log('Traccia',Format('%s: Impostazione periodo conteggi dal %s al %s completata',[FUNZIONE,DateToStr(DataInizio),DateToStr(DataFine)]));

  // prepara dataset per le esaminare richieste del giorno
  with W018DM.selT105RiepOre do
  begin
    Close;
    ClearVariables;
    SetVariable('PROGRESSIVO',Progressivo);
  end;

  // creazione client dataset
  with W018DM.cdsRiepOre do
  begin
    // azzeramento totali
    SumOre:=0;
    SumOreCaus:=0;
    SumOreRicRecup:=0;
    SumOreRicPagam:=0;
    SumSaldoOre:=0;

    // determina soglia per ore causalizzabili:
    // minimo dei minuti minimi di ogni causale con tipo_richiesta_web = 'P' o 'R'
    with TOracleQuery.Create(Self) do
    begin
      try
        Session:=SessioneOracle;
        SQL.Add('select min(MINMINUTI)');
        SQL.Add('from   T275_CAUPRESENZE');
        SQL.Add('where  TIPO_RICHIESTA_WEB in (''P'',''R'')');
        SQL.Add('and    MINMINUTI is not null');
        Execute;
        if FieldIsNull(0) then
          SogliaOreCausalizzabili:=0
        else
          SogliaOreCausalizzabili:=FieldAsInteger(0);
        Close;
      finally
        Free;
      end;
    end;

    // ciclo di conteggi e corrispondenti inserimenti nel client dataset
    (Self.Parent as TR010FPaginaWeb).Log('Traccia',FUNZIONE + ': Inizio ciclo di conteggi');
    D:=DataInizio;
    while D <= DataFine do
    begin
      LogTesto:=Format(FUNZIONE + ': %s - ',[DateToStr(D)]);

      // apre il dataset delle richieste per il giorno
      W018DM.selT105RiepOre.Close;
      W018DM.selT105RiepOre.Filter:='';
      W018DM.selT105RiepOre.Filtered:=False;
      W018DM.selT105RiepOre.SetVariable('DATA',D);
      W018DM.selT105RiepOre.Open;

      (Self.Parent as TR010FPaginaWeb).Log('Traccia',Format('%s: %s',[LogTesto,'W018DM.selT105RiepOre aperto']));

      // determina lo stato di autorizzazione complessivo delle richieste del giorno
      EsistonoRichieste:=(W018DM.selT105RiepOre.RecordCount > 0);
      if EsistonoRichieste then
      begin
        // autorizzazione (comportamento pessimistico)
        if W018DM.selT105RiepOre.SearchRecord('AUTORIZZAZIONE','',[srFromBeginning]) then
          Autorizzazione:=''
        else if W018DM.selT105RiepOre.SearchRecord('AUTORIZZAZIONE','N',[srFromBeginning]) then
          Autorizzazione:='N'
        else
          Autorizzazione:='S';

        // elaborazione
        if (Autorizzazione = 'S') and
           (not W018DM.selT105RiepOre.SearchRecord('ELABORATO','N',[srFromBeginning])) then
          Elaborato:='S'
        else
          Elaborato:='N';
      end
      else
      begin
        Autorizzazione:='';
        Elaborato:='';
      end;

      // --- passaggio 1: conteggi giornalieri standard
      (Self.Parent as TR010FPaginaWeb).Log('Traccia',Format('%s: %s',[LogTesto,'passaggio 1: conteggi giornalieri standard']));
      Ore:=0;
      OrePerSaldo:=0;
      OreCausalizzabili:=0;
      OreRicRecup1:=0;
      OreRicPagam1:=0;
      R502ProDtM1.ConsideraRichiesteWeb:=False;
      R502ProDtM1.Conteggi('Cartolina',Progressivo,D);
      ErrCont1:=(R502ProDtM1.Blocca <> 0);
      // se non ci sono errori nei conteggi determina le ore richieste
      if R502ProDtM1.Blocca = 0 then
      begin
        Ore:=R502ProDtM1.OreReseTotali - R502ProDtM1.debitogg;
        OrePerSaldo:=Ore;
        OreCausalizzabili:=R502ProDtM1.ProlungamentoNonCausalizzato[''];
        OreEsclNormRecup:=0;
        OreEsclNormPagam:=0;

        // filtra le richieste già elaborate
        W018DM.selT105RiepOre.Filtered:=False;
        W018DM.selT105RiepOre.Filter:='(ELABORATO = ''S'')';
        W018DM.selT105RiepOre.Filtered:=True;
        if W018DM.selT105RiepOre.RecordCount > 0 then
        begin
          // verifica sul riepilogo presenze
          for i:=1 to R502ProDtM1.n_rieppres do
          begin
            if W018DM.selT105RiepOre.SearchRecord('CAUSALE',R502ProDtM1.triepgiuspres[i].tcauspres,[srFromBeginning]) then
            begin
              TipoRichiestaWeb:=R502ProDtM1.ValStrT275[R502ProDtM1.triepgiuspres[i].tcauspres,'TIPO_RICHIESTA_WEB'];
              OreNormali:=R502ProDtM1.ValStrT275[R502ProDtM1.triepgiuspres[i].tcauspres,'ORENORMALI'];
              // somma le ore richieste a recupero / pagamento
              if TipoRichiestaWeb = 'R' then
              begin
                Sumtminpres:=R180SommaArray(R502ProDtM1.triepgiuspres[i].tminpres);
                OreRicRecup1:=OreRicRecup1 + Sumtminpres;
                if OreNormali = 'A' then
                  OreEsclNormRecup:=OreEsclNormRecup + Sumtminpres;
              end
              else if TipoRichiestaWeb = 'P' then
              begin
                Sumtminpres:=R180SommaArray(R502ProDtM1.triepgiuspres[i].tminpres);
                OreRicPagam1:=OreRicPagam1 + Sumtminpres;
                if OreNormali = 'A' then
                  OreEsclNormPagam:=OreEsclNormPagam + Sumtminpres;
              end;
            end;
          end;

          // incrementa il saldo giornaliero delle ore escluse dalle ore normali
          Ore:=Ore + OreEsclNormRecup + OreEsclNormPagam;
          OrePerSaldo:=OrePerSaldo + OreEsclNormRecup;
        end;
      end;

      // --- passaggio 2: conteggi giornalieri alterati (solo se esistono richieste)
      OreRicRecup2:=0;
      OreRicPagam2:=0;
      if EsistonoRichieste then
      begin
        (Self.Parent as TR010FPaginaWeb).Log('Traccia',Format('%s: %s',[LogTesto,'passaggio 2: conteggi giornalieri alterati']));
        R502ProDtM1.ConsideraRichiesteWeb:=True;
        R502ProDtM1.Conteggi('Cartolina',Progressivo,D);

        // se non ci sono errori nei conteggi determina le ore richieste
        if R502ProDtM1.Blocca = 0 then
        begin
          // filtra le richieste ancora da elaborare
          W018DM.selT105RiepOre.Filtered:=False;
          W018DM.selT105RiepOre.Filter:='(ELABORATO = ''N'')';
          W018DM.selT105RiepOre.Filtered:=True;
          if W018DM.selT105RiepOre.RecordCount > 0 then
          begin
            for i:=1 to R502ProDtM1.n_rieppres do
            begin
              if W018DM.selT105RiepOre.SearchRecord('CAUSALE',R502ProDtM1.triepgiuspres[i].tcauspres,[srFromBeginning]) then
              begin
                TipoRichiestaWeb:=R502ProDtM1.ValStrT275[R502ProDtM1.triepgiuspres[i].tcauspres,'TIPO_RICHIESTA_WEB'];
                // somma le ore richieste a recupero / pagamento
                if TipoRichiestaWeb = 'R' then
                  OreRicRecup2:=OreRicRecup2 + R180SommaArray(R502ProDtM1.triepgiuspres[i].tminpres)
                else if TipoRichiestaWeb = 'P' then
                  OreRicPagam2:=OreRicPagam2 + R180SommaArray(R502ProDtM1.triepgiuspres[i].tminpres);
              end;
            end;
          end;
        end;
      end;

      (Self.Parent as TR010FPaginaWeb).Log('Traccia',Format('%s: %s',[LogTesto,'somma ore recupero e pagamento']));

      // somma ore richieste a recupero e in pagamento
      OreRicRecup:=OreRicRecup1 + OreRicRecup2;
      OreRicPagam:=OreRicPagam1 + OreRicPagam2;

      // applica soglia ore causalizzabili
      if OreCausalizzabili < SogliaOreCausalizzabili then
        OreCausalizzabili:=0;

      // il giorno è considerato se il saldo orario non è 0, oppure ci sono ore
      // causalizzabili o almeno una richiesta nel giorno
      AddLine:=(Ore <> 0) or
               (OreCausalizzabili > 0) or
               (EsistonoRichieste);
      if AddLine then
      begin
        // inserisce il record sul clientdataset
        Append;
        FieldByName('DATA_CONTEGGI').AsString:=FormatDateTime('dd/mm',D);
        FieldByName('ORE').AsString:=IfThen(ErrCont1,'Anom.',R180MinutiOre(Ore));
        FieldByName('ORE_CAUS').AsString:=R180MinutiOre(OreCausalizzabili);
        FieldByName('ORE_RICH_REC').AsString:=R180MinutiOre(OreRicRecup);
        FieldByName('ORE_RICH_PAG').AsString:=R180MinutiOre(OreRicPagam);
        if Autorizzazione = 'S' then
          FieldByName('AUTORIZZAZIONE').AsString:='SI'
        else if Autorizzazione = 'N' then
          FieldByName('AUTORIZZAZIONE').AsString:='NO'
        else
          FieldByName('AUTORIZZAZIONE').AsString:='';
        if Elaborato = 'S' then
          FieldByName('AUTORIZZAZIONE').AsString:=FieldByName('AUTORIZZAZIONE').AsString + ' (elaborata)';
        // calcola il saldo ore
        if ErrCont1 then
        begin
          SaldoOre:=0;
          FieldByName('SALDO_ORE').AsString:='Anom.';
        end
        else
        begin
          SaldoOre:={Ore} OrePerSaldo; // ore per saldo = ore - ore escluse dalle normali per causali in pagamento
          if (Autorizzazione = 'S') and (Elaborato = 'N') then
            SaldoOre:=SaldoOre + OreRicRecup; {+ OreRicPagam;} // escludere ore in pagamento dal saldo
          FieldByName('SALDO_ORE').AsString:=R180MinutiOre(SaldoOre);
        end;
        Post;

        // gestione totali
        SumOre:=SumOre + Ore;
        SumOreCaus:=SumOreCaus + OreCausalizzabili;
        SumOreRicRecup:=SumOreRicRecup + OreRicRecup;
        SumOreRicPagam:=SumOreRicPagam + OreRicPagam;
        SumSaldoOre:=SumSaldoOre + SaldoOre;
      end;

      D:=D + 1;
    end;

    // righe dei totali
    (Self.Parent as TR010FPaginaWeb).Log('Traccia',FUNZIONE + ': totali: inserimento righe');
    if RecordCount > 0 then
    begin
      // riga iniziale dei totali
      RiepOreInizioTot:=RecordCount + 1;

      Append;
      FieldByName('DATA_CONTEGGI').AsString:='Totale ore mese';
      FieldByName('ORE').AsString:=R180MinutiOre(SumOre);
      FieldByName('ORE_CAUS').AsString:=R180MinutiOre(SumOreCaus);
      FieldByName('ORE_RICH_REC').AsString:=R180MinutiOre(SumOreRicRecup);
      FieldByName('ORE_RICH_PAG').AsString:=R180MinutiOre(SumOreRicPagam);
      FieldByName('AUTORIZZAZIONE').AsString:='';
      FieldByName('SALDO_ORE').AsString:=R180MinutiOre(SumSaldoOre);
      Post;

      (Self.Parent as TR010FPaginaWeb).Log('Traccia',FUNZIONE + ': totali: riga iniziale inserita');

      // estrae la data dell'ultima scheda riepilogativa elaborata
      with TOracleQuery.Create(Self) do
      begin
        try
          Session:=SessioneOracle;
          SQL.Add('select max(DATA)');
          SQL.Add('from   T070_SCHEDARIEPIL');
          SQL.Add('where  PROGRESSIVO = ' + IntToStr(Progressivo));
          SQL.Add('and    DATA < to_date(''' + DateToStr(R180InizioMese(DataSelez)) + ''',''dd/mm/yyyy'')');
          Execute;
          if FieldIsNull(0) then
            DataUltRiep:=0
          else
            DataUltRiep:=R180FineMese(FieldAsDate(0));
          Close;
        finally
          Free;
        end;
      end;
      (Self.Parent as TR010FPaginaWeb).Log('Traccia',FUNZIONE + ': totali: data ultima scheda riepilogativa: ' + DateToStr(DataUltRiep));

      // saldo ore complessivo dell'ultima scheda riepilogativa elaborata (se presente)
      Append;
      if DataUltRiep = 0 then
      begin
        // nessuna scheda elaborata
        FieldByName('DATA_CONTEGGI').AsString:='Saldo ore ultimo mese chiuso';
        SaldoUltRiep:=0;
        UltOreRicRecup:=0;
        UltOreRicPagam:=0;
        FieldByName('ORE').AsString:='-';
        FieldByName('ORE_RICH_REC').AsString:='-';
        FieldByName('ORE_RICH_PAG').AsString:='-';
      end
      else
      begin
        R450DtM1.ConteggiMese('Generico',R180Anno(DataUltRiep),R180Mese(DataUltRiep),Progressivo);
        FieldByName('DATA_CONTEGGI').AsString:='Saldo ore al ' + FormatDateTime('dd/mm/yyyy',DataUltRiep);
        SaldoUltRiep:=R450DtM1.salannoatt;
        FieldByName('ORE').AsString:=R180MinutiOre(SaldoUltRiep);
        // dati aggiunti.ini - 29.03.2011
        UltOreRicRecup:=0;
        UltOreRicPagam:=0;
        for i:=0 to High(R450DtM1.RiepPres) do
        begin
          TipoRichiestaWeb:=R502ProDtM1.ValStrT275[R450DtM1.RiepPres[i].Causale,'TIPO_RICHIESTA_WEB'];
          for j:=1 to R450DtM1.NFasceMese do
          begin
            if TipoRichiestaWeb = 'R' then
              UltOreRicRecup:=UltOreRicRecup + R450DtM1.RiepPres[i].Liquidabile[j] - R450DtM1.RiepPres[i].Liquidato[j]
            else if TipoRichiestaWeb = 'P' then
              UltOreRicPagam:=UltOreRicPagam + R450DtM1.RiepPres[i].Liquidato[j];
          end;
        end;
        FieldByName('ORE_RICH_REC').AsString:=R180MinutiOre(UltOreRicRecup);
        FieldByName('ORE_RICH_PAG').AsString:=R180MinutiOre(UltOreRicPagam);
        // dati aggiunti.fine - 29.03.2011
      end;
      FieldByName('ORE_CAUS').AsString:='';
      //FieldByName('ORE_RICH_REC').AsString:='';
      //FieldByName('ORE_RICH_PAG').AsString:='';
      FieldByName('AUTORIZZAZIONE').AsString:='';
      FieldByName('SALDO_ORE').AsString:='';
      Post;
      (Self.Parent as TR010FPaginaWeb).Log('Traccia',FUNZIONE + ': totali: riga saldo ore complessivo inserita');

      // totale complessivo
      Append;
      FieldByName('DATA_CONTEGGI').AsString:='Totale ore complessivo';
      FieldByName('ORE').AsString:=R180MinutiOre(SumOre + SaldoUltRiep);
      FieldByName('ORE_CAUS').AsString:=R180MinutiOre(SumOreCaus);
      FieldByName('ORE_RICH_REC').AsString:=R180MinutiOre(SumOreRicRecup + UltOreRicRecup);
      FieldByName('ORE_RICH_PAG').AsString:=R180MinutiOre(SumOreRicPagam + UltOreRicPagam);
      FieldByName('AUTORIZZAZIONE').AsString:='';
      FieldByName('SALDO_ORE').AsString:=R180MinutiOre(SumSaldoOre);
      Post;
      (Self.Parent as TR010FPaginaWeb).Log('Traccia',FUNZIONE + ': totali: riga totale complessivo inserita');
    end;
  end;

  W018DM.selT105RiepOre.Close;
  (Self.Parent as TR010FPaginaWeb).Log('Traccia',FUNZIONE + ': chiusura dataset W018DM.selT105RiepOre');

  // dealloca componenti creati
  FreeAndNil(R502ProDtM1);
  (Self.Parent as TR010FPaginaWeb).Log('Traccia',FUNZIONE + ': distruzione R502ProDtM1 completata');
  FreeAndNil(R450DtM1);
  (Self.Parent as TR010FPaginaWeb).Log('Traccia',FUNZIONE + ': distruzione R450DtM1 completata');

  // gestione messaggio modale
  (Self.Parent as TR010FPaginaWeb).Log('Traccia',FUNZIONE + ': preparazione tabella visualizzazione');
  Result:=W018DM.cdsRiepOre.RecordCount > 0;
  if Result then
  begin
    grdRiepilogoOre.medpCreaCDS;
    grdRiepilogoOre.medpEliminaColonne;
    grdRiepilogoOre.medpAggiungiColonna('DATA_CONTEGGI','Data','',nil);
    grdRiepilogoOre.medpAggiungiColonna('ORE','Ore<br>+/-','',nil);
    grdRiepilogoOre.medpAggiungiColonna('ORE_CAUS','Ore<br>causalizzabili','',nil);
    grdRiepilogoOre.medpAggiungiColonna('ORE_RICH_REC','Ore richieste a<br>recupero','',nil);
    grdRiepilogoOre.medpAggiungiColonna('ORE_RICH_PAG','Ore richieste a<br>pagamento','',nil);
    grdRiepilogoOre.medpAggiungiColonna('AUTORIZZAZIONE','Autorizzazione<br>SI/NO','',nil);
    grdRiepilogoOre.medpAggiungiColonna('SALDO_ORE','Saldo ore<br>+/-','',nil);
    grdRiepilogoOre.medpInizializzaCompGriglia;
    grdRiepilogoOre.medpPreparaComponenteGenerico('R',0,0,DBG_IMG,'','CANCELLA','null','null','S');
    grdRiepilogoOre.medpCaricaCDS;

    (Self.Parent as TR010FPaginaWeb).Log('Traccia',FUNZIONE + ': visualizzazione messaggio popup');
    Titolo:=Format('Riepilogo ore di %s %d',[R180NomeMese(R180Mese(DataInizio)),R180Anno(DataInizio)]);
    (Self.Parent as TR010FPaginaWeb).VisualizzajQMessaggio(jQVisFrame,750,-1,EM2PIXEL * (W018DM.cdsRiepOre.RecordCount + 11),Titolo,'#' + Name,True,True,-1,'','',btnChiudi.HTMLName);
    (Self.Parent as TR010FPaginaWeb).Log('Traccia',FUNZIONE + ': fine');
  end
  else
  begin
    (Self.Parent as TR010FPaginaWeb).Log('Traccia',FUNZIONE + ': richiamo btnChiudiClick');
    btnChiudiClick(nil);
  end;
end;

procedure TW018FRiepilogoEccedenzeFM.grdRiepilogoOreRenderCell(ACell: TIWGridCell; const ARow, AColumn: Integer);
const
  FUNZIONE = 'W018Riepilogo.grdRiepilogoOreRenderCell';
begin
  //(Self.Parent as TR010FPaginaWeb).Log('Traccia',FUNZIONE + ': inizio');
  inherited;
  if not (ACell.Grid as TmedpIWDBGrid).medpRenderCell(ACell,ARow,AColumn,True,True,False) then
    Exit;

  if ARow > 0 then
  begin
    // centratura testo
    ACell.Css:=ACell.Css + ' align_center';

    // segnalazione per anomalia
    if ACell.Text = 'Anom.' then
      ACell.Css:=ACell.Css + ' segnalazione';

    // totali
    if ARow >= RiepOreInizioTot then
    begin
      // bordo superiore per separare totali
      if ARow = RiepOreInizioTot then
        ACell.Css:=ACell.Css + ' bordo_top';

      // righe dei totali
      if AColumn = 0 then
        ACell.Css:=ACell.Css + ' font_grassetto';
    end;
  end;
  //(Self.Parent as TR010FPaginaWeb).Log('Traccia',FUNZIONE + ': fine');
end;

procedure TW018FRiepilogoEccedenzeFM.btnChiudiClick(Sender: TObject);
const
  FUNZIONE = 'W018Riepilogo.btnChiudiClick';
begin
  (Self.Parent as TR010FPaginaWeb).Log('Traccia',FUNZIONE + ': fine (prima della Free)');
  Free;
end;

end.
