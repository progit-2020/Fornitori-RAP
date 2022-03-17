unit P656UElaborazioneFluperMW;

interface

uses
  System.SysUtils, System.Classes, R005UDataModuleMW, P946UCalcoloFLUPERDtm, A000UInterfaccia,
  Oracle, Data.DB, OracleData, A000UMessaggi, C180FUnzioniGenerali;

type
  TP656FElaborazioneFluperMW = class(TR005FDataModuleMW)
    delP663: TOracleQuery;
    selP662: TOracleDataSet;
    selP663_ID: TOracleDataSet;
    insP662: TOracleQuery;
    delP662: TOracleQuery;
    updP662a: TOracleQuery;
    selbP662: TOracleDataSet;
    selaP662: TOracleDataSet;
    selP663: TOracleDataSet;
    updP662: TOracleQuery;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  public
    P946FCalcoloFLUPERDtm: TP946FCalcoloFLUPERDtm;
    function VerificaEstrazione(DataInizio,DataFine: TDateTime): String;
    function VerificaIdFlusso(Id_FLUSSO_Aperto: Integer;DataElaborazione: TDateTime): String;
    function VerificaFornitureAnte(Data: TDateTime): String;
    function TestataFLUPER(DataElaborazione: TDateTime; bElaboraDatiFlusso: boolean): Integer;
    procedure InizializzaConteggi(DataInizio, DataFine: TDateTime);
    procedure ElaboraDipendente(DatiFLUP946: TDatiFlup946; bAnnulla: Boolean);
    procedure FineElabTestata(DatiFLUP946: TDatiFlup946);
    procedure ElaboraEstrazione(Data: TDateTime; bFlussoA: Boolean; var F: TextFile);
    procedure ChiudiFornitura(idFLusso: Integer; DataChiusura: TDateTime);
  end;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

{ TP656FElaborazioneFluperMW }
procedure TP656FElaborazioneFluperMW.DataModuleCreate(Sender: TObject);
begin
  inherited;
  P946FCalcoloFLUPERDtm:=TP946FCalcoloFLUPERDtm.Create(nil);
end;

function TP656FElaborazioneFluperMW.TestataFLUPER(DataElaborazione: TDateTime; bElaboraDatiFlusso:boolean):Integer;
//Creo testata della fornitura mensile FLUPER o ne estraggo ID se già esiste
begin
  Result:=0;
  //Lettura di eventuale FLUPER aperta
  selP662.SetVariable('DataElaborazione',DataElaborazione);
  selP662.Close;
  selP662.Open;

  if not selP662.Eof then
  begin
//      if selP662.RecordCount > 1 then
//        raise Exception.Create('Esiste più di una fornitura relativa al mese di elaborazione: rimuovere quelle non valide');
    if selP662.FieldByName('CHIUSO').AsString = 'N' then
      Result:=selP662.FieldByName('Id_FLUSSO').AsInteger
    else
      Result:=-1;
  end
  else
  begin
    //Nel caso di Elaborazione, se non esiste, si genera la testata
    if bElaboraDatiFlusso then
    begin
      // Generazione della sequenza Id_FLUSSO
      selP663_ID.Close;
      selP663_ID.Open;
      Result:=selP663_ID.FieldByName('NEXTVAL').AsInteger;
      insP662.SetVariable('DataElaborazione',DataElaborazione);
      insP662.SetVariable('IdFLUPER',Result);
      insP662.Execute;
    end;
  end;
end;

procedure TP656FElaborazioneFluperMW.InizializzaConteggi(DataInizio,DataFine: TDateTime);
begin
  //Inizializzo i conteggi cambiando il progressivo: necessario se i conteggi vengono prima chiamati dalle assenze
  P946FCalcoloFLUPERDtm.R502ProDtM1.QProgressivo:= -1;
  P946FCalcoloFLUPERDtm.R502ProDtM1.Chiamante:='Cartolina';
  P946FCalcoloFLUPERDtm.R502ProDtM1.PeriodoConteggi(DataInizio,DataFine);
end;

procedure TP656FElaborazioneFluperMW.ElaboraDipendente(DatiFLUP946:TDatiFlup946; bAnnulla: Boolean);
var
  MessaggioAnomalia: String;
begin
  P946FCalcoloFLUPERDtm.DatiOut.Blocca:='';
  P946FCalcoloFLUPERDtm.DatiOut.NoBlocca:='';
  //Se nessun tipo di elaborazione risulta selezionato, esco dal ciclo dipendenti

  DatiFLUP946.Progressivo:=SelAnagrafe.FieldByName('PROGRESSIVO').AsInteger;
  //Elaborazione FLUSSO A
  if DatiFLUP946.ElaboraDatiFLUSSOA or
     DatiFLUP946.ElaboraDatiFLUSSOB1_36 or
     DatiFLUP946.ElaboraDatiFLUSSOB37 then
  begin
    //Richiamo il calcolo per la registrazione dei dati e periodi FLUPER
    P946FCalcoloFLUPERDtm.Calcolo(DatiFLUP946);
    if (P946FCalcoloFLUPERDtm.DatiOut.Blocca <> '') or (P946FCalcoloFLUPERDtm.DatiOut.NoBlocca <> '') then
    begin
      //Segnalo anomalia bloccante
      MessaggioAnomalia:='';
      if P946FCalcoloFLUPERDtm.DatiOut.Blocca <> '' then
        MessaggioAnomalia:=MessaggioAnomalia + ' - ANOM.BLOCCANTE ' + P946FCalcoloFLUPERDtm.DatiOut.Blocca + chr(13);
      if P946FCalcoloFLUPERDtm.DatiOut.NoBlocca <> '' then
        MessaggioAnomalia:=MessaggioAnomalia + P946FCalcoloFLUPERDtm.DatiOut.NoBlocca;
      //Registra anomalie
      RegistraMsg.InserisciMessaggio('A',MessaggioAnomalia,'',SelAnagrafe.FieldByName('Progressivo').AsInteger);
    end;
  end;
  //Annulla dati registrati e non ancora chiusi per rielaborare
  //e anche i dipendenti senza periodi (in modo da escludere i dimessi nell'anno precedente).
  if bAnnulla then
  begin
    delP663.SetVariable('IdFLUPERAperto',DatiFLUP946.ID_FLUPER);
    delP663.SetVariable('Progressivo',SelAnagrafe.FieldByName('PROGRESSIVO').AsInteger);
    delP663.Execute;
  end;
  SessioneOracle.Commit;
end;

procedure TP656FElaborazioneFluperMW.FineElabTestata(DatiFLUP946:TDatiFlup946);
begin
  //Verifico se cancellare testate INPDAP che non hanno dati di dettaglio
  delP662.SetVariable('IdFLUPER',DatiFLUP946.ID_FLUPER);
  delP662.Execute;
  //Aggiorno la da di fine periodo elaborato
  updP662a.SetVariable('IdFLUPER',DatiFLUP946.ID_FLUPER);
  updP662a.SetVariable('DataElaborazione',DatiFLUP946.DataElaborazione);
  updP662a.Execute;
  SessioneOracle.Commit;
end;

function TP656FElaborazioneFluperMW.VerificaFornitureAnte(Data: TDateTime):String;
begin
  Result:='';
  //Leggo eventuale fornitura precedente non chiusa
  selbP662.SetVariable('DataElaborazione',Data);
  selbP662.Close;
  selbP662.Open;
  if not selbP662.Eof then
    Result:=Format(A000MSG_P656_DLG_FMT_FORNIT_ANTE,[DateToStr(Data)]);
  selbP662.Close;
end;

function TP656FElaborazioneFluperMW.VerificaIdFlusso(Id_FLUSSO_Aperto: Integer; DataElaborazione: TDateTime): String;
begin
  Result:='';
  if Id_FLUSSO_Aperto < 0 then
  begin
    Result:=Format(A000MSG_P656_ERR_FMT_FORNIT_GIA_ESISTENTE,[DateToStr(DataElaborazione)]);
  end
  else if Id_FLUSSO_Aperto = 0 then
  begin
    Result:=Format(A000MSG_P656_ERR_FMT_FORNIT_NON_ESISTENTE,[DateToStr(DataElaborazione)]);
  end;
end;

function TP656FElaborazioneFluperMW.VerificaEstrazione(DataInizio,DataFine: TDateTime):String;
var
  bFornituraNonTrovata: Boolean;
  dMyData: TDateTime;
begin
  Result:='';
  //Leggo ID dell'elaborato mensile INPDAP chiuso con ultima data di chiusura per il periodo di esportazione
  selaP662.SetVariable('DataInizioElaborazione', DataInizio);
  selaP662.SetVariable('DataFineElaborazione', DataFine);
  selaP662.Close;
  selaP662.Open;
  dMyData:=R180FineMese(DataInizio);
  bFornituraNonTrovata:=False;
  while dMyData <= DataFine do
  begin
    if not selaP662.SearchRecord('DATA_FINE_PERIODO',dMyData,[srFromBeginning]) then
    begin
      bFornituraNonTrovata:=True;
      break;
    end;
    dMyData:=R180FineMese(R180AddMesi(dMyData,1));
  end;
  if bFornituraNonTrovata then
  begin
    Result:=Format(A000MSG_P656_ERR_FMT_NO_FORNIT_ANTE,[FormatDateTime('mm/yyyy',dMyData)]);
  end;
end;

procedure TP656FElaborazioneFluperMW.ElaboraEstrazione(Data: TDateTime; bFlussoA:Boolean; var F:TextFile);
var
  sDep, sNumero: String;
begin
  selaP662.SearchRecord('DATA_FINE_PERIODO',Data,[srFromBeginning]);
  selP663.SetVariable('IdFLUPER',selaP662.FieldByName('ID_FLUSSO').AsInteger);
  selP663.SetVariable('DataElaborazione',Data);
  If bFlussoA then
    selP663.SetVariable('Parte','A')
  else
    selP663.SetVariable('Parte','B');

  selP663.Close;
  selP663.Open;
  while not selP663.Eof do
  begin
    sDep:='';
    sNumero:='';
    if selP663.FieldByName('NUMERO_FILE').IsNull then
      selP663.Next
    else
    begin
      while sNumero < selP663.FieldByName('NUMERO_FILE').AsString do
      begin
        sDep:=sDep + R180FormatiCodificati(selP663.FieldByName('VALORE').AsString, selP663.FieldByName('FORMATO_FILE').AsString, selP663.FieldByName('LUNGHEZZA_FILE').AsInteger);
        sNumero:=selP663.FieldByName('NUMERO_FILE').AsString;
        selP663.Next;
        if selP663.Eof then
          break;
      end;
    end;
    Writeln(F,sDep);
  end;
end;

procedure TP656FElaborazioneFluperMW.ChiudiFornitura(idFLusso:Integer; DataChiusura: TDateTime);
begin
  updP662.SetVariable('IdFLUPER',idFLusso);
  updP662.SetVariable('DataChiusura',DataChiusura);
  updP662.Execute;
end;

procedure TP656FElaborazioneFluperMW.DataModuleDestroy(Sender: TObject);
begin
  FreeAndNil(P946FCalcoloFLUPERDtm);
  inherited;
end;

end.
