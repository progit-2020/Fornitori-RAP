unit P554UElaborazioneContoAnnuale;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, DBCtrls, Buttons, ComCtrls, ExtCtrls, Grids, DBGrids, Mask, Oracle,
  OracleData, C001StampaLib, C004UParamForm, C005UDatiAnagrafici, C013UCheckList,
  C180FunzioniGenerali, C700USelezioneAnagrafe, A000UCostanti, A000USessione, A000UInterfaccia,
  P948UCalcoloContoAnnualeDtm, P999UGenerale, SelAnagrafe, Menus, Spin, Variants,
  CheckLst, Math, A083UMsgElaborazioni;

type
  TTabElab = record
    CodiceTabella:String;
    DescTabella:String;
  end;

  TP554FElaborazioneContoAnnuale = class(TForm)
    pnlPeriodoElab: TPanel;
    pnlImpostaDati: TPanel;
    pnlElaborazioni: TPanel;
    btnEsegui: TBitBtn;
    btnChiudi: TBitBtn;
    btnAnomalie: TBitBtn;
    frmSelAnagrafe: TfrmSelAnagrafe;
    SaveDialog1: TSaveDialog;
    lblMeseDa: TLabel;
    edtMeseDa: TMaskEdit;
    sbtMeseDa: TSpeedButton;
    chkAnnulla: TCheckBox;
    chkChiusura: TCheckBox;
    lblDataChiusura: TLabel;
    edtDataChiusura: TMaskEdit;
    sbtDataChiusura: TSpeedButton;
    btnVisualizzaFile: TBitBtn;
    rgpStatoCedolini: TRadioGroup;
    chkElaboraRiepiloghi: TCheckBox;
    lblAnno: TLabel;
    lblMeseA: TLabel;
    edtMeseA: TMaskEdit;
    sbtMeseA: TSpeedButton;
    edtAnno: TSpinEdit;
    chkElaboraDatiCONTANN: TCheckBox;
    pnlTabelle: TPanel;
    clbTabElab: TCheckListBox;
    pnlEtichettaTab: TPanel;
    lblTabelle: TLabel;
    chkElabRisorseResidue: TCheckBox;
    pnlBar: TPanel;
    StatusBar: TStatusBar;
    ProgressBar1: TProgressBar;
    chkEsportazione: TCheckBox;
    btnImpostazioni: TBitBtn;
    PopupMenu1: TPopupMenu;
    Selezionatutto1: TMenuItem;
    Deselezionatutto1: TMenuItem;
    Invertiselezione1: TMenuItem;
    procedure btnVisualizzaFileClick(Sender: TObject);
    procedure Selezionatutto1Click(Sender: TObject);
    procedure btnImpostazioniClick(Sender: TObject);
    procedure clbTabElabClick(Sender: TObject);
    procedure chkElaboraDatiCONTANNClick(Sender: TObject);

    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnEseguiClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnAnomalieClick(Sender: TObject);
    procedure frmSelAnagrafeR003DatianagraficiClick(Sender: TObject);
    procedure frmSelAnagrafebtnSelezioneClick(Sender: TObject);
    procedure sbtMeseDaClick(Sender: TObject);
    procedure sbtDataChiusuraClick(Sender: TObject);
    procedure edtAnnoChange(Sender: TObject);
    procedure sbtMeseAClick(Sender: TObject);
    procedure edtMeseADblClick(Sender: TObject);
    { Private declarations }
  private
    //Id della testata CONTANN Mensile aperta
    Id_FLUSSO_Aperto,AnnoRegole:Integer;
    //PercorsoFileAnomalie: String;
    PresenzaAnomalie,FileGenerato: Boolean;
    DatiDaElaborare,sMesFornManc: String;
    IdDaElaborare: TStringList;
    bCancellaId: boolean;
    //Variabili per calcolo
    DatiInpP948:TDatiInpP948;
    function GestioneAnomalie(sTipo:String):String;
    function FormattaDato(sCodArrotondamento :String; rDato :Real):Real;
    procedure CaricaIdFlusso(sStato:String);
    procedure GetParametriFunzione;
    procedure PutParametriFunzione;
    procedure ElaborazioneDipendenti;
    procedure DisabilitaComponenti;
    procedure AbilitaComponenti;
    procedure AbilitazioniIniziali;
    procedure ChiusuraFornitura;
    procedure CalcoloRiepiloghi;
    procedure RidistribuzioneRisorseResidue;
    procedure EsportazioneFile;
    procedure GeneraFile(Nome:String);
  public
    { Public declarations }
    sAnomalia: String;
    ListaDati:TStringList;
    vTabElab:array of TTabElab;
    Comparto,TipoOper,Regione,Azienda,DSM,Istituto,NomeFile:String;
    function TestataCONTANN(sCodTabella:String):Integer;
  end;

var
  P554FElaborazioneContoAnnuale: TP554FElaborazioneContoAnnuale;

procedure OpenP554FElaborazioneContoAnnuale(Prog:LongInt);

implementation

uses R004UGestStoricoDTM, P554UElaborazioneContoAnnualeDtm,
     C012UVisualizzaTesto, A003UDataLavoroBis, P554UImpostazioni;

{$R *.DFM}

procedure OpenP554FElaborazioneContoAnnuale(Prog:LongInt);
begin
  SolaLetturaOriginale:=SolaLettura;
  SolaLettura:=False;
  case A000GetInibizioni('Funzione','OpenP554FElaborazioneContoAnnuale') of
    'N':begin
        ShowMessage('Funzione non abilitata!');
        Exit;
        end;
    'R':SolaLettura:=True;
  end;
  Application.CreateForm(TP554FElaborazioneContoAnnualeDtm,P554FElaborazioneContoAnnualeDtm);
  Application.CreateForm(TP554FElaborazioneContoAnnuale,P554FElaborazioneContoAnnuale);
  C700Progressivo:=Prog;
  try
    P554FElaborazioneContoAnnuale.ShowModal;
  finally
    SolaLettura:=SolaLetturaOriginale;
    P554FElaborazioneContoAnnuale.Free;
    P554FElaborazioneContoAnnualeDtm.Free;
  end;
end;

procedure TP554FElaborazioneContoAnnuale.FormCreate(Sender: TObject);
begin
  P948FCalcoloContoAnnualeDtm:=TP948FCalcoloContoAnnualeDtm.Create(nil);
  //Inizializzo lista id
  ListaDati:=TStringList.Create;
  IdDaElaborare:=TStringList.Create;
  A000SettaVariabiliAmbiente;
end;

procedure TP554FElaborazioneContoAnnuale.FormShow(Sender: TObject);
begin
  if edtDataChiusura.Text = '  /  /    ' then
    edtDataChiusura.Text:=FormatDateTime('dd/mm/yyyy',Parametri.DataLavoro);
  CreaC004(SessioneOracle,'P554',Parametri.ProgOper);
  GetParametriFunzione;
  C700DatiVisualizzati:='MATRICOLA,T430BADGE,COGNOME,NOME';
  C700DatiSelezionati:=C700CampiBase;
  C700DatiSelezionati:=C700CampiBase + ',DATANAS';
  C700DataLavoro:=Parametri.DataLavoro;
  C700DataDal:=Parametri.DataLavoro;
  frmSelAnagrafe.SelezionePeriodica:=True;
  frmSelAnagrafe.CreaSelAnagrafe(SessioneOracle,StatusBar,0,False);
  //Disabilito anomalie
  btnAnomalie.Enabled:=False;
  btnVisualizzaFile.Enabled:=False;
  //Impostazione abilitazioni iniziali sui componenti
  AbilitazioniIniziali;
end;

procedure TP554FElaborazioneContoAnnuale.edtAnnoChange(Sender: TObject);
var
  i: integer;
begin
  i:=0;
  with P554FElaborazioneContoAnnualeDtm do
  begin
    selP552.SetVariable('AnnoElaborazione',edtAnno.Text);
    selP552.Close;
    selP552.Open;
    selP552a.SetVariable('AnnoElaborazione',edtAnno.Text);
    selP552a.Close;
    selP552a.Open;
    SetLength(vTabElab,0);
    clbTabElab.Items.Clear;
    while not selP552.Eof do
    begin
      SetLength(vTabElab,i + 1);
      vTabElab[i].CodiceTabella:=selP552.FieldByName('COD_TABELLA').AsString;
      vTabElab[i].DescTabella:=selP552.FieldByName('DESCRIZIONE').AsString;
      clbTabElab.Items.Add(selP552.FieldByName('COD_TABELLA').AsString + '  ' +
        selP552.FieldByName('DESCRIZIONE').AsString);
      selP552.Next;
      inc(i);
    end;
  end;
end;

procedure TP554FElaborazioneContoAnnuale.edtMeseADblClick(Sender: TObject);
begin
  edtMeseA.Text:=edtMeseDa.Text;
end;

procedure TP554FElaborazioneContoAnnuale.CaricaIdFlusso(sStato:String);
//Carico gli id conto annuale dell'anno delle tabelle selezionate
var
  i: Integer;
begin
  with P554FElaborazioneContoAnnualeDtm do
  begin
    DatiDaElaborare:='';
    seleP554.SetVariable('Anno',edtAnno.Text);
    if Trim(sStato) = '' then
      seleP554.SetVariable('Stato','''S'',''N''')
    else
      seleP554.SetVariable('Stato','''' + sStato + '''');
    seleP554.Close;
    seleP554.Open;
    sMesFornManc:='';
    while not seleP554.Eof do
    begin
      for i:=0 to High(vTabElab) do
      begin
        if vTabElab[i].CodiceTabella = seleP554.FieldByName('COD_TABELLA').AsString then
        begin
          if clbTabElab.Checked[i] then
          begin
            if DatiDaElaborare <> '' then
              DatiDaElaborare:=DatiDaElaborare + ',';
            DatiDaElaborare:=DatiDaElaborare + seleP554.FieldByName('ID_CONTOANN').AsString;
            sMesFornManc:=sMesFornManc + ' Anno: ' + edtAnno.Text + ' Tabella: ' + seleP554.FieldByName('COD_TABELLA').AsString + Chr(10);
          end;
          break;
        end;
      end;
      seleP554.Next;
    end;
  end;
end;

procedure TP554FElaborazioneContoAnnuale.FormDestroy(Sender: TObject);
begin
  P948FCalcoloContoAnnualeDtm.Free;
  frmSelAnagrafe.DistruggiSelAnagrafe;
end;

procedure TP554FElaborazioneContoAnnuale.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  if not btnChiudi.Enabled then
    Action:=caNone
  else
  begin
    PutParametriFunzione;
    C004FParamForm.Free;
  end;
  ListaDati.Free;
  IdDaElaborare.Free;
end;

procedure TP554FElaborazioneContoAnnuale.btnEseguiClick(Sender: TObject);
var i: integer;
  Selez:Boolean;
begin
  //Controllo che almeno una tabella sia selezionata
  Selez:=False;
  for i:=0 to clbTabElab.Count - 1 do
    if clbTabElab.Checked[i] then
      Selez:=True;
  if not Selez then
    raise exception.Create('Selezionare almeno una tabella da elaborare!');
  //Leggo parametri aziendali
  with P554FElaborazioneContoAnnualeDtm do
  begin
    if selP500.GetVariable('Anno') <> edtAnno.Text then
    begin
      selP500.SetVariable('Anno',edtAnno.Text);
      selP500.Close;
      selP500.Open;
    end;
  end;
  if chkElaboraDatiCONTANN.Checked then
  begin
    //Leggo eventualI forniture precedenti non chiuse
    CaricaIdFlusso('N');
    if sMesFornManc <> '' then
    begin
      if R180MessageBox(' Esistono già le seguenti elaborazioni precedenti riferite all''anno: ' + chr(13) +
         sMesFornManc + ' Proseguire comunque con l''elaborazione?', DOMANDA) = mrNo then
        exit;
    end;
  end;
  if not chkEsportazione.Checked then
  begin
    //Setto stato di non presenza di anomalie
    PresenzaAnomalie:=False;
    RegistraMsg.IniziaMessaggio('P554');
    with P554FElaborazioneContoAnnualeDtm do
    begin
      //Imposto variabile per cancellazione id delle tabelle selezionate per l'elaborazione
      bCancellaId:=True;
      Self.Enabled:=False;
      //Ciclo sulle regole elaborando le tabelle che sono state selezionate
      for i:=0 to High(vTabElab) do
      begin
        if clbTabElab.Checked[i]
        and selP552.SearchRecord('COD_TABELLA',VarArrayOf([vTabElab[i].CodiceTabella]),[srFromBeginning]) then
        begin
          StatusBar.Panels[1].Text:='Tabella in elaborazione ' + vTabElab[i].CodiceTabella;
          //Leggo la testata per impostare Id_FLUSSO_Aperto
          Id_FLUSSO_Aperto:=TestataCONTANN(vTabElab[i].CodiceTabella);
          //Configuro variabili per calcolo CONTANN
          DatiInpP948.ID_CONTANN:=Id_FLUSSO_Aperto;
          DatiInpP948.AnnoElaborazione:=edtAnno.Text;
          DatiInpP948.DataInizioElaborazione:=StrToDate('01/'+edtMeseDa.Text);
          DatiInpP948.DataFineElaborazione:=StrToDate('01/'+edtMeseA.Text);
          //edtAnno.Text;
          DatiInpP948.CodTabella:=vTabElab[i].CodiceTabella;
          DatiInpP948.DescTabella:=selP552.FieldByName('DESCRIZIONE').AsString;
          DatiInpP948.TipoTabellaRighe:=selP552.FieldByName('TIPO_TABELLA_RIGHE').AsString;
          if selP552.FieldByName('TIPO_TABELLA_RIGHE').AsString = '0' then
            //Se qualifica ministeriale prendo il nome del campo dai parametri aziendali
            DatiInpP948.ValoreCostante:='QUALIFICAMINIST'
          else
            //..altrimenti passo il dato libero o la funzione Oracle utilizzata
            DatiInpP948.ValoreCostante:=selP552.FieldByName('VALORE_COSTANTE').AsString;
          DatiInpP948.ElaboraDatiCONTANN:=chkElaboraDatiCONTANN.Checked;
          DatiInpP948.ElaboraRiepiloghi:=chkElaboraRiepiloghi.Checked;
          case rgpStatoCedolini.ItemIndex of
            0:DatiInpP948.StatoCedolini:='''S''';
            1:DatiInpP948.StatoCedolini:='''S'',''N''';
            2:DatiInpP948.StatoCedolini:='''N''';
          end;
          if chkElaboraDatiCONTANN.Checked then
          begin
            ElaborazioneDipendenti;
            //Imposto variabile per evitare cancellazione id delle tabelle selezionate per l'elaborazione, dopo
            //l'elaborazione della prima tabella
            bCancellaId:=False;
          end;
          //Calcolo riepiloghi quadro Z1
          if chkElaboraRiepiloghi.Checked then
            CalcoloRiepiloghi;
          //Ridistribuzione risorse residue
          if chkElabRisorseResidue.Checked then
            RidistribuzioneRisorseResidue;
        end;
      end;
      //Fase di annullamento fatta in unica passata per tutte le tabelle selezionate
      if chkAnnulla.Checked then
        ElaborazioneDipendenti;
      Self.Enabled:=True;
    end;
  end;
  //Chiusura della fornitura
  if chkChiusura.Checked then
    if (R180MessageBox('Confermi l''operazione di chiusura del Conto Annuale del periodo indicato?',DOMANDA) = mrYes) then
      ChiusuraFornitura;
  //Esportazione su file
  if chkEsportazione.Checked then
  begin
    PresenzaAnomalie:=False;
    btnVisualizzaFile.Enabled:=False;
    FileGenerato:=False;
    CaricaIdFlusso('');
    if Pos(',',DatiDaElaborare) > 0 then
      raise exception.Create('L''esportazione su file è possibile selezionando solo una tabella alla volta!');
    if (R180MessageBox('Confermi l''operazione di esportazione su file?',DOMANDA) = mrYes) then
      EsportazioneFile;
  end;
  if frmSelAnagrafe.ElaborazioneInterrotta then
  begin
    R180MessageBox('Elaborazione interrotta su richiesta dell''operatore.',INFORMA);
    frmSelAnagrafe.ElaborazioneInterrotta:=False;
  end
  else
  begin
    if chkChiusura.Checked then
    begin
      if sMesFornManc <> '' then
        R180MessageBox('Elaborazione terminata. Sono state chiuse le seguenti tabelle ' + Chr(10) +
          sMesFornManc,INFORMA)
      else
        R180MessageBox('Elaborazione terminata. Non è stata chiusa alcuna tabella ',INFORMA);
    end
    else if chkAnnulla.Checked then
    begin
      if sMesFornManc <> '' then
        R180MessageBox('Elaborazione terminata. Sono state annullate le seguenti tabelle ' + Chr(10) +
          sMesFornManc,INFORMA)
      else
        R180MessageBox('Elaborazione terminata. Nessuna tabella aperta da annullare ',INFORMA);
    end
    else if chkEsportazione.Checked then
    begin
      if FileGenerato then
      begin
        btnVisualizzaFile.Enabled:=True;
        R180MessageBox('Elaborazione terminata. E'' stato generato il file ' + NomeFile,INFORMA)
      end
      else
        R180MessageBox('Elaborazione terminata. Nessun file generato.',INFORMA);
    end
    else if PresenzaAnomalie then
    begin
      if R180MessageBox('Elaborazione terminata con anomalie. Si desidera visualizzarle?',DOMANDA) = mrYes then
        btnAnomalieClick(nil);
    end
    else
    begin
      R180MessageBox('Elaborazione terminata correttamente.',INFORMA);
      if chkElaboraDatiCONTANN.Checked and (R180MessageBox('Si desidera eseguire il calcolo dei dati riepilogativi?',DOMANDA) = mrYes) then
      begin
        chkElaboraDatiCONTANN.Checked:=False;
        chkElaboraRiepiloghi.Checked:=True;
        btnEseguiClick(nil);
      end;
    end;
  end;
  StatusBar.Panels[1].Text:='';
end;

procedure TP554FElaborazioneContoAnnuale.ElaborazioneDipendenti;
//Ciclo di scorrimento ed elaborazione dei dipendenti
begin
  //Ciclo sul range di dipendenti
  with P554FElaborazioneContoAnnualeDtm do
  begin
    try
      try
        if frmSelAnagrafe.SettaPeriodoSelAnagrafe(DatiInpP948.DataInizioElaborazione,R180FineMese(DatiInpP948.DataFineElaborazione)) then
          C700SelAnagrafe.Close;
        C700SelAnagrafe.Open;

        C700SelAnagrafe.First;
        ProgressBar1.Position:=0;
        ProgressBar1.Max:=C700SelAnagrafe.RecordCount;
        frmSelAnagrafe.ElaborazioneInterrompibile:=True;
        //Carico gli id conto annuale dell'anno delle tabelle selezionate
        CaricaIdFlusso('N');
        //Se non ci sono Id da annullare mi posiziono sull'ultimo dip. così termino subito l'elaborazione
        if chkAnnulla.Checked and (DatiDaElaborare = '') then
          C700SelAnagrafe.Last;

        while not C700SelAnagrafe.Eof do
        begin
          sAnomalia:='';
          P948FCalcoloContoAnnualeDtm.DatiOut.Blocca:='';
          P948FCalcoloContoAnnualeDtm.DatiOut.NoBlocca:='';
          frmSelAnagrafe.VisualizzaDipendente;
          //Se nessun tipo di elaborazione risulta selezionato, esco dal ciclo dipendenti
          if not(chkElaboraDatiCONTANN.Checked) and not(chkAnnulla.Checked) then
            Break;
          DisabilitaComponenti;
          DatiInpP948.Progressivo:=C700SelAnagrafe.FieldByName('PROGRESSIVO').AsInteger;
          //Elaborazione per calcolo periodi e dati CONTANN mensili
          if chkElaboraDatiCONTANN.Checked then
          begin
            if Id_FLUSSO_Aperto <= 0 then
            begin
              sAnomalia:='Per l''anno di elaborazione risulta già chiusa la tabella ' + DatiInpP948.CodTabella + Chr(10);
              GestioneAnomalie('I');
              AbilitaComponenti;
              Self.Enabled:=True;
              exit;
            end;
            //Se prima elaborazione cancello dati individuali di tutte le tabelle selezionate per l'elaborazione
            if bCancellaId and (DatiDaElaborare <> '') then
            begin
              delP555a.SetVariable('IdFlussi',DatiDaElaborare);
              delP555a.SetVariable('Progressivo',C700SelAnagrafe.FieldByName('PROGRESSIVO').AsInteger);
              delP555a.Execute;
            end;
            //Richiamo il calcolo per la registrazione dei dati e periodi CONTANN
            P948FCalcoloContoAnnualeDtm.Calcolo(DatiInpP948);
            if (P948FCalcoloContoAnnualeDtm.DatiOut.Blocca <> '') or (P948FCalcoloContoAnnualeDtm.DatiOut.NoBlocca <> '') then
            begin
              //Segnalo anomalia bloccante
              if GestioneAnomalie('I') = 'E' then
                //Nel caso di anomalia interrattiva, se non si prosegue esco dal ciclo dipendenti
                exit;
            end;
          end;
          //Annulla dati registrati e non ancora chiusi
          if chkAnnulla.Checked and (DatiDaElaborare <> '') then
          begin
            delP555.SetVariable('IdFlussi',DatiDaElaborare);
            delP555.SetVariable('Progressivo',C700SelAnagrafe.FieldByName('PROGRESSIVO').AsInteger);
            delP555.Execute;
          end;
          SessioneOracle.Commit;
          ProgressBar1.StepBy(1);
          C700SelAnagrafe.Next;
        end;
        //Verifico se cancellare testate Conto Annuale che non hanno dati di dettaglio
        if DatiDaElaborare <> '' then
        begin
          delP554.SetVariable('IdFlussi',DatiDaElaborare);
          delP554.Execute;
          SessioneOracle.Commit;
        end;
      except
        SessioneOracle.Rollback;
        raise;
      end;
    finally
      AbilitaComponenti;
      ProgressBar1.Position:=0;
      frmSelAnagrafe.ElaborazioneInterrompibile:=False;
      frmSelAnagrafe.VisualizzaDipendente;
    end;
  end;
end;

procedure TP554FElaborazioneContoAnnuale.CalcoloRiepiloghi;
//Calcolo riepiloghi
var
  sCodArrotondamento:String;
begin
  if Id_FLUSSO_Aperto <= 0 then
  begin
    sAnomalia:='Non esiste la tabella ' + DatiInpP948.CodTabella + ' dell''anno aperta di cui calcolare i riepiloghi ' + Chr(10);
    GestioneAnomalie('C');
    AbilitaComponenti;
    exit;
  end;
  screen.Cursor:=crHourglass;
  DisabilitaComponenti;
  with P554FElaborazioneContoAnnualeDtm do
  begin
    //Apertura query per estrarre i codici arrotondamento per tutte le tabelle dell'anno
    with P554FElaborazioneContoAnnualeDtm do
    begin
      if (selP552b.GetVariable('AnnoElaborazione') <> DatiInpP948.AnnoElaborazione) then
      begin
        selP552b.SetVariable('AnnoElaborazione',DatiInpP948.AnnoElaborazione);
        selP552b.Close;
        selP552b.Open;
      end;
    end;
    //Cancellazione eventuali riepiloghi già esistenti per la stessa dichiarazione
    delP555b.SetVariable('IdCONTANN',Id_FLUSSO_Aperto);
    delP555b.Execute;
    //Lettura e somma dei dati riepilogativi
    selP555.SetVariable('IdCONTANN',Id_FLUSSO_Aperto);
    selP555.Close;
    selP555.Open;
    while not selP555.Eof do
    begin
      sCodArrotondamento:='';
      if ((DatiInpP948.TipoTabellaRighe = '0') or (DatiInpP948.TipoTabellaRighe = '1')) and
         (selP552b.SearchRecord('COD_TABELLA;COLONNA',VarArrayOf([DatiInpP948.CodTabella,selP555.FieldByName('COLONNA').AsInteger]),[srFromBeginning])) then
        sCodArrotondamento:=selP552b.FieldByName('COD_ARROTONDAMENTO').AsString
      //Nel caso di tabelle con dati registrati su righe diverse verifico cambio righe
      else if (DatiInpP948.TipoTabellaRighe = '2') and
         (selP552b.SearchRecord('COD_TABELLA;RIGA',VarArrayOf([DatiInpP948.CodTabella,selP555.FieldByName('RIGA').AsInteger]),[srFromBeginning])) then
        sCodArrotondamento:=selP552b.FieldByName('COD_ARROTONDAMENTO').AsString;
      //Registrazione riepiloghi per la dichiarazione
      insP555.SetVariable('IdCONTANN',Id_FLUSSO_Aperto);
      insP555.SetVariable('Riga',selP555.FieldByName('RIGA').AsInteger);
      insP555.SetVariable('Colonna',selP555.FieldByName('COLONNA').AsInteger);
      insP555.SetVariable('Valore',FormattaDato(sCodArrotondamento, selP555.FieldByName('DATO').AsFloat));
      insP555.Execute;
      selP555.Next;
    end;
    SessioneOracle.Commit;
  end;
  AbilitaComponenti;
  screen.Cursor:=crDefault;
end;

procedure TP554FElaborazioneContoAnnuale.RidistribuzioneRisorseResidue;
//Ridistribuzione risorse residue su riepilogo
var
  sCodArrotondamento :String;
  IdFlussoQuote:Integer;
begin
  //Verifico esistenza id conto annuale aperto
  if Id_FLUSSO_Aperto <= 0 then
  begin
    sAnomalia:='Non esiste tabella dell''anno aperta su cui ridistribuire le risorse residue ' + Chr(10);
    GestioneAnomalie('C');
    AbilitaComponenti;
    exit;
  end;
  screen.Cursor:=crHourglass;
  DisabilitaComponenti;
  with P554FElaborazioneContoAnnualeDtm do
  begin
    //Apertura query per estrarre i codici arrotondamento per tutte le tabelle dell'anno
    with P554FElaborazioneContoAnnualeDtm do
    begin
      if (selP552b.GetVariable('AnnoElaborazione') <> DatiInpP948.AnnoElaborazione) then
      begin
        selP552b.SetVariable('AnnoElaborazione',DatiInpP948.AnnoElaborazione);
        selP552b.Close;
        selP552b.Open;
      end;
    end;
    //Lettura e somma dei dati riepilogativi
    selP553.SetVariable('AnnoElaborazione',DatiInpP948.AnnoElaborazione);
    selP553.SetVariable('CodTabella',DatiInpP948.CodTabella);
    selP553.Close;
    selP553.Open;
    while not selP553.Eof do
    begin
      sCodArrotondamento:='';
      //Nel caso di tabella tipo Accorpamento voci aggiorno direttamente l'importo sulla corrispondente riga
      if DatiInpP948.TipoTabellaRighe = '2' then
      begin
        if selP552b.SearchRecord('COD_TABELLA;RIGA',VarArrayOf([DatiInpP948.CodTabella,selP553.FieldByName('COLONNA_RIGA').AsInteger]),[srFromBeginning]) then
          sCodArrotondamento:=selP552b.FieldByName('COD_ARROTONDAMENTO').AsString;
        updP555.SetVariable('IdCONTANN',Id_FLUSSO_Aperto);
        updP555.SetVariable('Riga',selP553.FieldByName('COLONNA_RIGA').AsInteger);
        updP555.SetVariable('Colonna',1);
        updP555.SetVariable('ImportoResiduo',FormattaDato(sCodArrotondamento, selP553.FieldByName('IMPORTO_RESIDUO').AsFloat));
        updP555.Execute;
        if updP555.RowsProcessed = 0 then
        begin
          sAnomalia:='Non esiste il dato su cui ridistribuire il residuo Tabella: ' + DatiInpP948.CodTabella
          + ' Riga: ' + selP553.FieldByName('COLONNA_RIGA').AsString + Chr(10);
          GestioneAnomalie('C');
        end;
      end
      //Nel caso di tabella tipo Qualifiche ministeriali occorre gestire l'aggiornamento delle singole righe una per ogni
      //qualifica
      else if DatiInpP948.TipoTabellaRighe = '0' then
      begin
        if selP552b.SearchRecord('COD_TABELLA;COLONNA',VarArrayOf([DatiInpP948.CodTabella,selP553.FieldByName('COLONNA_RIGA').AsInteger]),[srFromBeginning]) then
          sCodArrotondamento:=selP552b.FieldByName('COD_ARROTONDAMENTO').AsString;
        IdFlussoQuote:=Id_FLUSSO_Aperto;
        if DatiInpP948.CodTabella <> selP553.FieldByName('COD_TABELLA_QUOTE').AsString then
        begin
          //Lettura ID tabella da cui leggere le quote
          selP554.SetVariable('Anno',edtAnno.Text);
          selP554.SetVariable('CodTabella',selP553.FieldByName('COD_TABELLA_QUOTE').AsString);
          selP554.Close;
          selP554.Open;
          if selP554.Eof then
          begin
            sAnomalia:='Non esiste il dato da cui leggere le quote per il calcolo della percentuale di ridistribuzione Tabella: ' + selP553.FieldByName('COD_TABELLA_QUOTE').AsString
            + ' Macro categoria: ' + selP553.FieldByName('MACRO_CATEG').AsString + Chr(10);
            GestioneAnomalie('C');
            IdFlussoQuote:=0;
          end
          else
            IdFlussoQuote:=selP554.FieldByName('ID_CONTOANN').AsInteger;
        end;
        if IdFlussoQuote > 0 then
        begin
          selP555a.SetVariable('IdCONTANN',IdFlussoQuote);
          selP555a.SetVariable('CodTabella',selP553.FieldByName('COD_TABELLA_QUOTE').AsString);
          selP555a.SetVariable('AnnoElaborazione',DatiInpP948.AnnoElaborazione);
          selP555a.SetVariable('Colonna',selP553.FieldByName('COLONNA_QUOTE').AsInteger);
          selP555a.SetVariable('MacroCateg',selP553.FieldByName('MACRO_CATEG').AsString);
          selP555a.Close;
          selP555a.Open;
          if selP555a.Eof then
          begin
            sAnomalia:='Non esiste il dato da cui leggere le quote per il calcolo della percentuale di ridistribuzione Tabella: ' + selP553.FieldByName('COD_TABELLA_QUOTE').AsString
            + ' Macro categoria: ' + selP553.FieldByName('MACRO_CATEG').AsString + Chr(10);
            GestioneAnomalie('C');
          end
          else
          begin
            //Calcolo percentuale di ridistribuzionje per tutta la Macro categoria
            selP555b.SetVariable('IdCONTANN',IdFlussoQuote);
            selP555b.SetVariable('CodTabella',selP553.FieldByName('COD_TABELLA_QUOTE').AsString);
            selP555b.SetVariable('AnnoElaborazione',DatiInpP948.AnnoElaborazione);
            selP555b.SetVariable('Colonna',selP553.FieldByName('COLONNA_QUOTE').AsInteger);
            selP555b.SetVariable('MacroCateg',selP553.FieldByName('MACRO_CATEG').AsString);
            selP555b.SetVariable('ImportoResiduo',selP553.FieldByName('IMPORTO_RESIDUO').AsFloat);
            selP555b.Close;
            selP555b.Open;
            if not selP555b.Eof then
            begin
              while not selP555a.Eof do
              begin
                updP555.SetVariable('IdCONTANN',Id_FLUSSO_Aperto);
                updP555.SetVariable('Riga',selP555a.FieldByName('RIGA').AsInteger);
                updP555.SetVariable('Colonna',selP553.FieldByName('COLONNA_RIGA').AsInteger);
                updP555.SetVariable('ImportoResiduo',FormattaDato(sCodArrotondamento,
                  selP555a.FieldByName('DATO').AsFloat*selP555b.FieldByName('PERC_RIDISTR').AsFloat));
                updP555.Execute;
                if (updP555.RowsProcessed = 0) and (selP555a.FieldByName('DATO').AsFloat*selP555b.FieldByName('PERC_RIDISTR').AsFloat > 0) then
                begin
                  //Registrazione riepiloghi per la dichiarazione
                  insP555.SetVariable('IdCONTANN',Id_FLUSSO_Aperto);
                  insP555.SetVariable('Riga',selP555a.FieldByName('RIGA').AsInteger);
                  insP555.SetVariable('Colonna',selP553.FieldByName('COLONNA_RIGA').AsInteger);
                  insP555.SetVariable('Valore',FormattaDato(sCodArrotondamento,
                  selP555a.FieldByName('DATO').AsFloat*selP555b.FieldByName('PERC_RIDISTR').AsFloat));
                  insP555.Execute;
                end;
                selP555a.Next;
              end;
            end;
          end;
        end;
      end;
      selP553.Next;
    end;
    SessioneOracle.Commit;
  end;
  AbilitaComponenti;
  screen.Cursor:=crDefault;
end;

procedure TP554FElaborazioneContoAnnuale.ChiusuraFornitura;
//Chiusura della fornitura del conto annuale per il periodo indicato
begin
  screen.Cursor:=crHourglass;
  DisabilitaComponenti;
  //Carico gli id conto annuale dell'anno delle tabelle selezionate
  CaricaIdFlusso('N');
  with P554FElaborazioneContoAnnualeDtm do
  begin
    //La chiusura viene fatta per tutti gli id flussi aperti dell'anno delle tabelle selezionate
    if DatiDaElaborare <> '' then
    begin
      updP554.SetVariable('IdFlussi',DatiDaElaborare);
      updP554.SetVariable('DataChiusura',StrToDate(edtDataChiusura.Text));
      updP554.Execute;
    end;
  end;
  SessioneOracle.Commit;
  AbilitaComponenti;
  screen.Cursor:=crDefault;
end;

procedure TP554FElaborazioneContoAnnuale.EsportazioneFile;
//Esportazione su file del conto annuale del periodo indicato
var i:Integer;
  lstTabelle:TStringList;
begin
  if (trim(Regione) = '') or (trim(Azienda) = '') then
    raise Exception.Create('Indicare codice regione e codice azienda utilizzando il pulsante Impostazioni!');
  screen.Cursor:=crHourglass;
  DisabilitaComponenti;
  //Carico gli id conto annuale dell'anno delle tabelle selezionate
  CaricaIdFlusso('');
  lstTabelle:=TStringList.Create;
  lstTabelle.Clear;
  lstTabelle.CommaText:=DatiDaElaborare;
  if Trim(NomeFile) = '' then
    NomeFile:=ExtractFilePath(Application.ExeName) + '\CONTOANNUALE.TXT';
  ProgressBar1.Position:=0;
  ProgressBar1.Max:=lstTabelle.Count;
  with P554FElaborazioneContoAnnualeDtm do
  begin
    AnnoRegole:=0;
    selQuery.Close;
    selQuery.SQL.Clear;
    selQuery.DeleteVariables;
    selQuery.SQL.Add('SELECT MAX(ANNO) ANNO FROM P552_CONTOANNREGOLE WHERE ANNO <= ' + edtAnno.Text);
    selQuery.Open;
    if selQuery.RecordCount > 0 then
      AnnoRegole:=selQuery.FieldByName('ANNO').AsInteger;
  end;
  for i:=0 to lstTabelle.Count - 1 do
    with P554FElaborazioneContoAnnualeDtm do
    begin
      ProgressBar1.StepBy(1);
      selP555Righe.Close;
      selP555Righe.SetVariable('ANNOREGOLE',AnnoRegole);
      selP555Righe.SetVariable('ID_CONTOANN',StrToIntDef(lstTabelle.Strings[i],0));
      selP555Righe.Open;
      selP555Esporta.Close;
      selP555Esporta.SetVariable('ANNOREGOLE',AnnoRegole);
      selP555Esporta.SetVariable('ID_CONTOANN',StrToIntDef(lstTabelle.Strings[i],0));
      selP555Esporta.Open;
      if selP555Esporta.RecordCount > 0 then  //se ci sono dati da elab. per la tabella corrente
      begin
        if (trim(Istituto) = '') and (selP555Esporta.FieldByName('COD_TABELLA').AsString = 'T01C') then
        begin
          screen.Cursor:=crDefault;
          ProgressBar1.Position:=0;
          raise Exception.Create('Indicare il codice istituto utilizzando il pulsante Impostazioni!');
        end;
        if (trim(DSM) = '') and (selP555Esporta.FieldByName('COD_TABELLA').AsString = 'T01D') then
        begin
          screen.Cursor:=crDefault;
          ProgressBar1.Position:=0;
          raise Exception.Create('Indicare il codice DSM utilizzando il pulsante Impostazioni!');
        end;
        selP551.Close;
        selP551.SetVariable('ANNO',AnnoRegole);
        selP551.SetVariable('TABELLA',selP555Esporta.FieldByName('COD_TABELLA').AsString);
        selP551.Open;
        if selP551.RecordCount > 0 then  //se esiste il tracciato record della tab.corrente
        begin
          StatusBar.Panels[1].Text:='Esportazione tabella ' + selP551.FieldByName('COD_TABELLA').AsString;
          if FileExists(NomeFile) then
          begin
            if R180MessageBox('File ' + NomeFile + ' già esistente. Sostituire il file?','DOMANDA') = mrYes then
            begin
              DeleteFile(NomeFile);
              GeneraFile(NomeFile);
            end;
          end
          else
            GeneraFile(NomeFile);
        end;
      end;
    end;
  FreeAndNil(lstTabelle);
  AbilitaComponenti;
  screen.Cursor:=crDefault;
  ProgressBar1.Position:=0;
  StatusBar.Panels[1].Text:='';
end;

procedure TP554FElaborazioneContoAnnuale.GeneraFile(Nome:String);
var F:TextFile;
  Riga,Valore,s:string;
  ValoreNum:Real;
  i,NumDec:Integer;
  App:TStringList;

  function ValoreArrot(Imp:Real;TipoCampo,Formato:String):Real;
  var F:String;
    j:Integer;
  begin
    Result:=Imp;
    F:=Formato;
    with P554FElaborazioneContoAnnualeDtm do
    begin
      if Imp <> 0  then
      begin
        if Trim(F) = '' then
        begin
          selP551Formato.Close;
          selP551Formato.SetVariable('TABELLA',selP551.FieldByName('COD_TABELLA').AsString);
          selP551Formato.SetVariable('ANNO',selP551.FieldByName('ANNO').AsInteger);
          selP551Formato.SetVariable('TIPOCAMPO',TipoCampo);
          selP551Formato.Open;
          F:=selP551Formato.FieldByName('FORMATO').AsString;
        end;
        if F = 'N' then
          Result:=R180Arrotonda(Imp,1,'P')
        else if Copy(F,1,2) = 'NV' then
        begin
          NumDec:=StrToIntDef(Copy(F,3,1),0);
          s:='';
          for j:=1 to NumDec-1 do
            s:=s + '0';
          s:='0,' + s + '1';
          Result:=R180Arrotonda(Imp,StrToFloatDef(s,1),'P');
        end;
      end;
    end;
  end;
begin
  FileGenerato:=True;
  AssignFile(F,Nome);
  Rewrite(F);
  with P554FElaborazioneContoAnnualeDtm do
  begin
    selP555Righe.First;
    while not selP555Righe.Eof do  //ciclo su tutte le righe della tabella
    begin
      selP551.First;
      Riga:='';
      //per ogni riga ciclo su tutti i campi del tracciato record e creo la riga da scrivere sul file
      while not selP551.Eof do
      begin
        ValoreNum:=0;
        if selP551.FieldByName('TIPO_CAMPO').AsString = 'ANNO' then
          Valore:=selP555Esporta.FieldByName('ANNO').AsString;
        if selP551.FieldByName('TIPO_CAMPO').AsString = 'AZIENDA' then
          Valore:=Azienda;
        if selP551.FieldByName('TIPO_CAMPO').AsString = 'FILLER' then
          Valore:='';
        if selP551.FieldByName('TIPO_CAMPO').AsString = 'IDCATEG' then
          Valore:=selP555Righe.FieldByName('VALORE_COSTANTE').AsString;
        if selP551.FieldByName('TIPO_CAMPO').AsString = 'IDCOMPARTO' then
          Valore:=Comparto;
        if selP551.FieldByName('TIPO_CAMPO').AsString = 'IDDSM' then
          Valore:=DSM;
        if selP551.FieldByName('TIPO_CAMPO').AsString = 'IDFIGURA' then
          Valore:=selP555Righe.FieldByName('VALORE_COSTANTE').AsString;
        if selP551.FieldByName('TIPO_CAMPO').AsString = 'IDISTITUTO' then
          Valore:=Istituto;
        if selP551.FieldByName('TIPO_CAMPO').AsString = 'REGIONE' then
          Valore:=Regione;
        if selP551.FieldByName('TIPO_CAMPO').AsString = 'TIPOOPERAZ' then
          Valore:=TipoOper;
        //Tipo campo COLONNA Cxxx
        if Copy(selP551.FieldByName('TIPO_CAMPO').AsString,1,1) = 'C' then
          if selP555Esporta.SearchRecord('RIGA;COLONNA',
            VarArrayOf([selP555Righe.FieldByName('RIGA').AsInteger,StrToIntDef(Copy(selP551.FieldByName('TIPO_CAMPO').AsString,2,3),0)]),[srFromBeginning]) then
          begin
            ValoreNum:=ValoreArrot(selP555Esporta.FieldByName('VALORE').AsFloat,'',selP551.FieldByName('FORMATO').AsString);
            Valore:=FloatToStr(ValoreNum);
          end
          else
            Valore:='';
        //Tipo campo FORMULA - somma
        if selP551.FieldByName('TIPO_CAMPO').AsString = 'FORMULA' then
        begin
          App:=TStringList.Create;
          App.Clear;
          App.CommaText:=StringReplace(StringReplace(selP551.FieldByName('FORMULA').AsString,'+',',+',[rfReplaceAll]),'-',',-',[rfReplaceAll]);
          if Length(App.Strings[0]) = 4 then
            App.Strings[0]:='+' + App.Strings[0];
          for i:=0 to App.Count -1 do
          begin
            if selP555Esporta.SearchRecord('RIGA;COLONNA',
               VarArrayOf([selP555Righe.FieldByName('RIGA').AsInteger,StrToIntDef(Copy(App.Strings[i],3,3),0)]),[srFromBeginning]) then
            begin
              begin
                if Copy(App.Strings[i],1,1) = '+' then
                  ValoreNum:=ValoreNum + ValoreArrot(selP555Esporta.FieldByName('VALORE').AsFloat,Copy(App.Strings[i],2,4),'')
                else if Copy(App.Strings[i],1,1) = '-' then
                  ValoreNum:=ValoreNum - ValoreArrot(selP555Esporta.FieldByName('VALORE').AsFloat,Copy(App.Strings[i],2,4),'');
              end;
            end;
          end;
          ValoreNum:=ValoreArrot(ValoreNum,'',selP551.FieldByName('FORMATO').AsString);
          if ValoreNum = 0 then
            Valore:=''
          else
            Valore:=FloatToStr(ValoreNum);
          FreeAndNil(App);
        end;

        if selP551.FieldByName('FORMATO').AsString = 'X' then
        begin
          Valore:=Copy(Valore,1,selP551.FieldByName('LUNGHEZZA').AsInteger);
          Riga:=Riga + Format('%-*s',[selP551.FieldByName('LUNGHEZZA').AsInteger,Valore])
        end
        else if selP551.FieldByName('FORMATO').AsString = 'N' then
        begin
          Valore:=FloatToStr(ValoreNum);
          Riga:=Riga + Format('%-*.*d',[selP551.FieldByName('LUNGHEZZA').AsInteger,selP551.FieldByName('LUNGHEZZA').AsInteger,StrToIntDef(Valore,0)]);
        end
        else if Copy(selP551.FieldByName('FORMATO').AsString,1,2) = 'NV' then
        begin
          Valore:=FloatToStr(ValoreNum);
          NumDec:=StrToIntDef(Copy(selP551.FieldByName('FORMATO').AsString,3,1),0);
          if Pos(',',Valore) > 0 then
          begin
            if Length(Valore)-Pos(',',Valore) = NumDec then
              Riga:=Riga + Format('%-*.*d',[selP551.FieldByName('LUNGHEZZA').AsInteger-NumDec-1,
                selP551.FieldByName('LUNGHEZZA').AsInteger-NumDec-1,
                StrToIntDef(Copy(Valore,1,Pos(',',Valore)-1),0)]) + ',' +
                Copy(Valore,Pos(',',Valore)+1,NumDec)
            else
              Riga:=Riga + Format('%-*.*d',[selP551.FieldByName('LUNGHEZZA').AsInteger-NumDec-1,
                selP551.FieldByName('LUNGHEZZA').AsInteger-NumDec-1,
                StrToIntDef(Copy(Valore,1,Pos(',',Valore)-1),0)]) + ',' +
                Copy(Valore,Pos(',',Valore)+1,Length(Valore)-Pos(',',Valore));
            for i:=1 to NumDec-(Length(Valore)-Pos(',',Valore)) do
              Riga:=Riga + '0';
          end
          else
          begin
            Riga:=Riga + Format('%-*.*d',[selP551.FieldByName('LUNGHEZZA').AsInteger-NumDec-1,
              selP551.FieldByName('LUNGHEZZA').AsInteger-NumDec-1,StrToIntDef(Valore,0)]) + ',';
            for i:=1 to NumDec do
              Riga:=Riga + '0';
          end;
        end;
        selP551.Next;
      end;
      Writeln(F,Riga);  //scrivo la riga sul file
      selP555Righe.Next;
    end;
  end;
  CloseFile(F);
end;

function TP554FElaborazioneContoAnnuale.TestataCONTANN(sCodTabella:String):Integer;
//Creo testata della fornitura mensile CONTANN o ne estraggo ID se già esiste
begin
  Result:=0;
  with P554FElaborazioneContoAnnualeDtm do
  begin
    //Lettura di eventuale CONTANN aperta
    selP554.SetVariable('Anno',edtAnno.Text);
    selP554.SetVariable('CodTabella',sCodTabella);
    selP554.Close;
    selP554.Open;
    if selP554.Eof then
    begin
      //Nel caso di Elaborazione, se non esiste, si genera la testata
      if chkElaboraDatiCONTANN.Checked then
      begin
        //Generazione della sequenza Id_FLUSSO
        selP555_ID.Close;
        selP555_ID.Open;
        Result:=selP555_ID.FieldByName('NEXTVAL').AsInteger;
        insP554.SetVariable('Anno',edtAnno.Text);
        insP554.SetVariable('CodTabella',sCodTabella);
        insP554.SetVariable('IdCONTANN',Result);
        insP554.Execute;
        SessioneOracle.Commit;
      end;
    end
    else
      if selP554.FieldByName('CHIUSO').AsString = 'N' then
        Result:=selP554.FieldByName('ID_CONTOANN').AsInteger;
  end;
end;

function TP554FElaborazioneContoAnnuale.GestioneAnomalie(sTipo:String):String;
//Registrazione e visualizzazione anomalie
var MessaggioAnomalia: String;
begin
  Result:='C';
  //Setto stato di presenza di anomalie
  PresenzaAnomalie:=True;
  if sTipo = 'I' then
  begin
    with C700SelAnagrafe do
    begin
      MessaggioAnomalia:=FieldByName('Matricola').AsString + ' ' +
        TrimRight(FieldByName('Nome').AsString) + ' ' +
        TrimRight(FieldByName('Cognome').AsString) + ' cod.tab. ' + DatiInpP948.CodTabella + ':' + chr(13);
    end;
  end;
  if P948FCalcoloContoAnnualeDtm.DatiOut.Blocca <> '' then
    MessaggioAnomalia:=MessaggioAnomalia + ' - ANOM.BLOCCANTE ' + P948FCalcoloContoAnnualeDtm.DatiOut.Blocca + chr(13);
  if P948FCalcoloContoAnnualeDtm.DatiOut.NoBlocca <> '' then
    MessaggioAnomalia:=MessaggioAnomalia + P948FCalcoloContoAnnualeDtm.DatiOut.NoBlocca;
  if sAnomalia <> '' then
    MessaggioAnomalia:=MessaggioAnomalia + sAnomalia;
  //Registra anomalie su file txt
  //R180AppendFile(PercorsoFileAnomalie,MessaggioAnomalia);
  RegistraMsg.InserisciMessaggio('A',MessaggioAnomalia,'',IfThen(sTipo = 'I',C700SelAnagrafe.FieldByName('Progressivo').AsInteger));
end;

procedure TP554FElaborazioneContoAnnuale.GetParametriFunzione;
{Leggo i parametri della form}
var
  Anno,Mese,Giorno: Word;
begin
  DecodeDate(Parametri.DataLavoro,Anno,Mese,Giorno);
  edtAnno.Value:=Anno - 1;
  if edtMeseDa.Text = '  /    ' then
    edtMeseDa.Text:='01/' + IntToStr(edtAnno.Value);
  if edtMeseA.Text = '  /    ' then
    edtMeseA.Text:=FormatDateTime('mm/yyyy',Parametri.DataLavoro);
  edtAnno.Text:=C004FParamForm.GetParametro('edtAnno',edtAnno.Text);
  edtAnnoChange(nil);
  edtMeseDa.Text:=C004FParamForm.GetParametro('edtMeseDa',edtMeseDa.Text);
  edtMeseA.Text:=C004FParamForm.GetParametro('edtMeseA',edtMeseA.Text);
  chkElaboraDatiCONTANN.Checked:=(C004FParamForm.GetParametro('chkElabDatiCONTANN','') = 'S');
  chkElaboraRiepiloghi.Checked:=(C004FParamForm.GetParametro('chkElaboraRiepiloghi','') = 'S');
  chkElabRisorseResidue.Checked:=(C004FParamForm.GetParametro('chkElabRisorseResid','') = 'S');
  chkAnnulla.Checked:=(C004FParamForm.GetParametro('chkAnnulla','') = 'S');
  chkChiusura.Checked:=(C004FParamForm.GetParametro('chkChiusura','') = 'S');
  chkEsportazione.Checked:=C004FParamForm.GetParametro('chkEsportazione','') = 'S';
  Azienda:=C004FParamForm.GetParametro('Exp_Azienda','');
  Comparto:=C004FParamForm.GetParametro('Exp_Comparto','01');
  DSM:=C004FParamForm.GetParametro('Exp_DSM','');
  Istituto:=C004FParamForm.GetParametro('Exp_Istituto','');
  Regione:=C004FParamForm.GetParametro('Exp_Regione','');
  TipoOper:=C004FParamForm.GetParametro('Exp_TipoOper','0');
  NomeFile:=C004FParamForm.GetParametro('Exp_NomeFile','');
end;

procedure TP554FElaborazioneContoAnnuale.PutParametriFunzione;
{Scrivo i parametri della forma}
begin
  C004FParamForm.Cancella001;
  C004FParamForm.PutParametro('edtAnno',edtAnno.Text);
  C004FParamForm.PutParametro('edtMeseDa',edtMeseDa.Text);
  C004FParamForm.PutParametro('edtMeseA',edtMeseA.Text);
  if chkElaboraDatiCONTANN.Checked then
    C004FParamForm.PutParametro('chkElabDatiCONTANN','S')
  else
    C004FParamForm.PutParametro('chkElabDatiCONTANN','N');
  if chkElaboraRiepiloghi.Checked then
    C004FParamForm.PutParametro('chkElaboraRiepiloghi','S')
  else
    C004FParamForm.PutParametro('chkElaboraRiepiloghi','N');
  if chkElabRisorseResidue.Checked then
    C004FParamForm.PutParametro('chkElabRisorseResid','S')
  else
    C004FParamForm.PutParametro('chkElabRisorseResid','N');
  if chkAnnulla.Checked then
    C004FParamForm.PutParametro('chkAnnulla','S')
  else
    C004FParamForm.PutParametro('chkAnnulla','N');
  if chkChiusura.Checked then
    C004FParamForm.PutParametro('chkChiusura','S')
  else
    C004FParamForm.PutParametro('chkChiusura','N');
  if chkEsportazione.Checked then
    C004FParamForm.PutParametro('chkEsportazione','S')
  else
    C004FParamForm.PutParametro('chkEsportazione','N');
  C004FParamForm.PutParametro('Exp_Azienda',Azienda);
  C004FParamForm.PutParametro('Exp_Comparto',Comparto);
  C004FParamForm.PutParametro('Exp_DSM',DSM);
  C004FParamForm.PutParametro('Exp_Istituto',Istituto);
  C004FParamForm.PutParametro('Exp_Regione',Regione);
  C004FParamForm.PutParametro('Exp_TipoOper',TipoOper);
  C004FParamForm.PutParametro('Exp_NomeFile',NomeFile);
  try SessioneOracle.Commit; except end;
end;

procedure TP554FElaborazioneContoAnnuale.DisabilitaComponenti;
//Disabilito i componenti sui quali non devono poter agire
begin
  btnAnomalie.Enabled:=False;
end;

procedure TP554FElaborazioneContoAnnuale.AbilitaComponenti;
//Riabilito i componenti disabilitati
begin
  if PresenzaAnomalie then
    btnAnomalie.Enabled:=True;
end;

procedure TP554FElaborazioneContoAnnuale.AbilitazioniIniziali;
//Imposto abilitazioni iniziali per i componenti
begin
  rgpStatoCedolini.Enabled:=chkElaboraDatiCONTANN.Checked;
  chkAnnulla.Enabled:=not(chkElaboraDatiCONTANN.Checked or chkElaboraRiepiloghi.Checked or chkEsportazione.Checked
    or chkElabRisorseResidue.Checked or chkChiusura.Checked);
  chkElaboraDatiCONTANN.Enabled:=not (chkAnnulla.Checked or chkEsportazione.Checked or
    chkElaboraRiepiloghi.Checked or chkElabRisorseResidue.Checked or chkChiusura.Checked);
  chkElaboraRiepiloghi.Enabled:=not (chkElaboraDatiCONTANN.Checked or chkEsportazione.Checked or
    chkAnnulla.Checked or chkElabRisorseResidue.Checked or chkChiusura.Checked);
  chkElabRisorseResidue.Enabled:=not (chkElaboraDatiCONTANN.Checked or chkEsportazione.Checked or
    chkAnnulla.Checked or chkElaboraRiepiloghi.Checked or chkChiusura.Checked);
  chkChiusura.Enabled:=not (chkAnnulla.Checked or chkEsportazione.Checked or
    chkElaboraRiepiloghi.Checked or chkElabRisorseResidue.Checked or chkElaboraDatiCONTANN.Checked);
  chkEsportazione.Enabled:=not (chkAnnulla.Checked or chkChiusura.Checked or
    chkElaboraRiepiloghi.Checked or chkElabRisorseResidue.Checked or chkElaboraDatiCONTANN.Checked);
  sbtDataChiusura.Enabled:=chkChiusura.Checked;
  edtDataChiusura.Enabled:=chkChiusura.Checked;
  if not chkElaboraDatiCONTANN.Enabled then
    chkElaboraDatiCONTANN.Checked:=False;
  if not chkElaboraRiepiloghi.Enabled then
    chkElaboraRiepiloghi.Checked:=False;
  if not chkElabRisorseResidue.Enabled then
    chkElabRisorseResidue.Checked:=False;
  if not chkAnnulla.Enabled then
    chkAnnulla.Checked:=False;
  if not chkChiusura.Enabled then
    chkChiusura.Checked:=False;
  if not chkEsportazione.Enabled then
    chkEsportazione.Checked:=False;
  btnImpostazioni.Enabled:=chkEsportazione.Checked;
  btnVisualizzaFile.Enabled:=chkEsportazione.Checked and FileGenerato;
  clbTabElab.Enabled:=chkElaboraDatiCONTANN.Checked or chkElaboraRiepiloghi.Checked or chkElabRisorseResidue.Checked
                      or chkAnnulla.Checked or chkChiusura.Checked or chkEsportazione.Checked;
  btnEsegui.Enabled:=((not SolaLettura) and (chkElaboraDatiCONTANN.Checked or chkElaboraRiepiloghi.Checked
                     or chkElabRisorseResidue.Checked or chkAnnulla.Checked or chkChiusura.Checked or chkEsportazione.Checked));
  lblMeseDa.Visible:=chkElaboraDatiCONTANN.Checked;
  edtMeseDa.Visible:=chkElaboraDatiCONTANN.Checked;
  sbtMeseDa.Visible:=chkElaboraDatiCONTANN.Checked;
  lblMeseA.Visible:=chkElaboraDatiCONTANN.Checked;
  edtMeseA.Visible:=chkElaboraDatiCONTANN.Checked;
  sbtMeseA.Visible:=chkElaboraDatiCONTANN.Checked;
  frmSelAnagrafe.pnlSelAnagrafe.Visible:=chkElaboraDatiCONTANN.Checked or chkAnnulla.Checked;
  pnlBar.Visible:=chkElaboraDatiCONTANN.Checked or chkAnnulla.Checked or chkEsportazione.Checked;
  pnlElaborazioni.Align:=alTop;
  pnlBar.Align:=alTop;
  pnlBar.Align:=alBottom;
  pnlElaborazioni.Align:=alBottom;
end;

procedure TP554FElaborazioneContoAnnuale.btnAnomalieClick(Sender: TObject);
begin
  frmSelAnagrafe.SalvaC00SelAnagrafe;
  C700Distruzione;
  OpenA083MsgElaborazioni(Parametri.Azienda,Parametri.Operatore,'P554','');
  C700DatiSelezionati:=C700CampiBase;
  C700Creazione(SessioneOracle);
  frmSelAnagrafe.RipristinaC00SelAnagrafe;
end;

procedure TP554FElaborazioneContoAnnuale.frmSelAnagrafeR003DatianagraficiClick(
  Sender: TObject);
begin
  try
    C005DataVisualizzazione:=R180FineMese(StrToDate('01/'+edtMeseDa.Text));
  except
    C005DataVisualizzazione:=Parametri.DataLavoro;
  end;
  if C005DataVisualizzazione = 0 then
    C005DataVisualizzazione:=Parametri.DataLavoro;
  frmSelAnagrafe.R003DatianagraficiClick(Sender);
end;

procedure TP554FElaborazioneContoAnnuale.frmSelAnagrafebtnSelezioneClick(
  Sender: TObject);
var MeseDal, MeseAl, AnnoAl:TDate;
begin
  try
    MeseDal:=R180InizioMese(StrToDate('01/' + edtMeseDa.Text));
  except
    MeseDal:=R180InizioMese(Parametri.DataLavoro);
  end;
  C700DataDal:=MeseDal;
  AnnoAl:=Encodedate(edtAnno.value,12,31);
  try
    MeseAl:=R180FineMese(StrToDate('01/' + edtMeseA.Text));
  except
    MeseAl:=R180FineMese(Parametri.DataLavoro);
  end;
  if AnnoAl < MeseAl then
    C700DataLavoro:=AnnoAl
  else
    C700DataLavoro:=MeseAl;

  if C700DataLavoro = 0 then
    C700DataLavoro:=Parametri.DataLavoro;
  frmSelAnagrafe.btnSelezioneClick(Sender);
end;

procedure TP554FElaborazioneContoAnnuale.sbtMeseDaClick(
  Sender: TObject);
//Richiesta data cedolino tramite calendario
begin
  edtMeseDa.Text:=FormatDateTime('mm/yyyy',DataOut(StrToDate('01/'+edtMeseDa.Text),'Mese elaborazione','M'));
end;

procedure TP554FElaborazioneContoAnnuale.sbtMeseAClick(Sender: TObject);
//Richiesta data cedolino tramite calendario
begin
  edtMeseA.Text:=FormatDateTime('mm/yyyy',DataOut(StrToDate('01/'+edtMeseA.Text),'Mese elaborazione','M'));
end;

procedure TP554FElaborazioneContoAnnuale.sbtDataChiusuraClick(Sender: TObject);
//Richiesta data chiusura tramite calendario
begin
  edtDataChiusura.Text:=FormatDateTime('dd/mm/yyyy',DataOut(StrToDate(edtDataChiusura.Text),'Data chiusura','G'));
end;

procedure TP554FElaborazioneContoAnnuale.chkElaboraDatiCONTANNClick(
  Sender: TObject);
begin
  AbilitazioniIniziali;
end;

procedure TP554FElaborazioneContoAnnuale.clbTabElabClick(Sender: TObject);
var
  i,j: integer;
begin
  if chkElaboraRiepiloghi.Checked or chkElabRisorseResidue.Checked or chkEsportazione.Checked then
    exit;
  with P554FElaborazioneContoAnnualeDtm do
  begin
    i:=clbTabElab.ItemIndex;
    selP552a.First;
    while not selP552a.Eof do
    begin
      if selP552a.FieldByName('COD_TABELLA').AsString = vTabElab[i].CodiceTabella then
      begin
        //P554FElaborazioneContoAnnuale.
        clbTabElab.OnClick:=nil;
        for j:=0 to High(vTabElab) do
        begin
          if vTabElab[j].CodiceTabella = selP552a.FieldByName('COD_TABELLA_CORRELATA').AsString then
          begin
            clbTabElab.Checked[j]:=clbTabElab.Checked[i];
            break;
          end;
        end;
        clbTabElab.OnClick:=clbTabElabClick;
      end;
      selP552a.Next;
    end;
    selP552a.First;
    while not selP552a.Eof do
    begin
      if selP552a.FieldByName('COD_TABELLA_CORRELATA').AsString = vTabElab[i].CodiceTabella then
      begin
        //P554FElaborazioneContoAnnuale.
        clbTabElab.OnClick:=nil;
        for j:=0 to High(vTabElab) do
        begin
          if vTabElab[j].CodiceTabella = selP552a.FieldByName('COD_TABELLA').AsString then
          begin
            clbTabElab.Checked[j]:=clbTabElab.Checked[i];
            break;
          end;
        end;
        clbTabElab.OnClick:=clbTabElabClick;
      end;
      selP552a.Next;
    end;
  end;
end;

function TP554FElaborazioneContoAnnuale.FormattaDato(sCodArrotondamento:String; rDato:Real):Real;
//Formattazione del dato se numerico
begin
  with P554FElaborazioneContoAnnualeDtm do
  begin
    Result:=rDato;
    if sCodArrotondamento <> '' then
    begin
      if (selP050.GetVariable('CodValuta') <> selP500.FieldByName('COD_VALUTA').AsString) or
         (selP050.GetVariable('CodArrotondamento') <> sCodArrotondamento) or
         (selP050.GetVariable('Decorrenza') <> DatiInpP948.DataInizioElaborazione) then
      begin
        selP050.SetVariable('CodValuta',selP500.FieldByName('COD_VALUTA').AsString);
        selP050.SetVariable('CodArrotondamento',sCodArrotondamento);
        selP050.SetVariable('Decorrenza',DatiInpP948.DataInizioElaborazione);
        selP050.Close;
        selP050.Open;
      end;
      if not selP050.Eof then
      begin
        //Arrotondamento
        if rDato <> 0 then
          rDato:=R180Arrotonda(rDato,selP050.FieldByName('VALORE').AsFloat,selP050.FieldByName('TIPO').AsString);
      end
      else
      begin
        //Non esiste l'arrotondamento
        //DatiOut.Blocca:=BloccaP948[5];
        exit;
      end;
    end;
    Result:=rDato;
  end;
end;

procedure TP554FElaborazioneContoAnnuale.btnImpostazioniClick(Sender: TObject);
begin
  OpenP554Impostazioni;
end;

procedure TP554FElaborazioneContoAnnuale.Selezionatutto1Click(Sender: TObject);
var i:Integer;
begin
  for i:=0 to clbTabElab.Items.Count - 1 do
    if Sender = SelezionaTutto1 then
      clbTabElab.Checked[i]:=True
    else if Sender = DeselezionaTutto1 then
      clbTabElab.Checked[i]:=False
    else if Sender = InvertiSelezione1 then
      clbTabElab.Checked[i]:=not clbTabElab.Checked[i];
end;

procedure TP554FElaborazioneContoAnnuale.btnVisualizzaFileClick(
  Sender: TObject);
begin
  try
    OpenC012VisualizzaTesto('<P554> Visualizzazione file di esportazione',NomeFile,nil,
                            'Visualizzazione file di esportazione della tabella ' + P554FElaborazioneContoAnnualeDtM.selP551.FieldByName('COD_TABELLA').AsString);
  except
    raise Exception.Create('Impossibile visualizzare il file. File inesistente.');
  end;
end;

end.
