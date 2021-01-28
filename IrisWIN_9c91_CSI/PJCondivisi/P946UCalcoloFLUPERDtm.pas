unit P946UCalcoloFLUPERDtm;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, Math,
  R004UGESTSTORICODTM, Db, OracleData, C180FUNZIONIGENERALI, Oracle,
  P999UGenerale, A000UInterfaccia, A000UCostanti, A000USessione, (*Midaslib,*) Crtl, DBClient, Variants,
  Rp502Pro, R100UCreditiFormativiDtM, R600;

type
  TDatiOutP946 = record
    Blocca:String;
    NoBlocca:String;
  end;
  TDatiFlup946 = record
    Progressivo, ID_FLUPER:Integer;
    DataElaborazione:TDateTime;
    ElaboraDatiFLUSSOA: Boolean;
    ElaboraDatiFLUSSOB1_36: Boolean;
    ElaboraDatiFLUSSOB37: Boolean;
    StatoCedolini: String;    
  end;
  TP946FCalcoloFLUPERDtm = class(TR004FGestStoricoDtM)
    selP660: TOracleDataSet;
    delP663: TOracleQuery;
    T430A: TOracleDataSet;
    OperSql: TOracleDataSet;
    scrP663: TOracleQuery;
    TabellaTemporaneaB1_36: TClientDataSet;
    T430B1_36: TOracleDataSet;
    selP442: TOracleDataSet;
    selP430: TOracleDataSet;
    selP663: TOracleDataSet;
    selP050: TOracleDataSet;
    selP150: TOracleDataSet;
    selT430: TOracleDataSet;
    selP663b: TOracleDataSet;
    insP663: TOracleQuery;
    updP663: TOracleQuery;
    updP663a: TOracleQuery;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    { Private declarations }
    //Variabili di scambio con il calcolo
    DatiInpFLUPER:TDatiFlup946;
    //Stringa contenente i codici di anomalie non bloccanti
    sCodiciNoBlocca: String;
    bFinePeriodoLav: boolean;
    R600DtM1:TR600DtM1;
    R100FCreditiFormativiDtM:TR100FCreditiFormativiDtM;
    procedure MacroRoutine;
    procedure ImpostazioniIniziali;
//    procedure CancellaDatiIndividuali;
    procedure CalcoloDatiQuery(Parte: String; DataPeriodo: TDateTime; ProgrNum: Integer);
    procedure FormattaDato(sCodArrotondamento, sFormato, sParte, sNumero:String; var sDatoFLUPER:String);
    procedure InserimentoDati(Parte, Numero, Valore :String; ProgressivoNumero:Integer);
    procedure CreaTabellaTemporaneaB1_36;
    //Gestione passaggio tipo rapporto da determinato codici da 04 a 07 a indeterminato codice 01
    procedure PassaggioTipoRapp;
    //Duplico record di tipo B per dipendenti passati da tempo determinato a tempo indeterminato
    procedure DuplicoRecordParteB;
  public
    { Public declarations }
    DatiOut:TDatiOutP946;
    R502ProDtm1:TR502ProDtm1;
    //Date di passaggio da tempo determinato a tempo indeterminato
    dDataFineDet, dDataInizioIndet: TDateTime;
    procedure Calcolo(DatiFlup:TDatiFLUP946);
  end;

const
  //Codice Speciale Base
  CodVoceSpecialeBase = 'BASE';
  BloccaP946:array[1..16] of String =
  (*001*)  ('Mancano dei dati anagrafici del dipendente alla data di elaborazione',
  (*002*)   'Non esistono le regole di calcolo valide alla data di elaborazione',
  (*003*)   '',
  (*004*)   '',
  (*005*)   'Non esiste l'' arrotondamento previsto dalla regola del campo: ',
  (*006*)   '',
  (*007*)   '',
  (*008*)   '',
  (*009*)   '',
  (*010*)   'Non esiste la regola di calcolo per l''anno del quale e'' stato richiesto il FLUPER del numero dato: ',
  (*011*)   '',
  (*012*)   '',
  (*013*)   '',
  (*014*)   '',
  (*015*)   '',
  (*016*)   ''
  );
  NoBloccaP946:array[1..6] of String =
  (*001*)  ('Non esistono i dati relativi alla codifica INAIL (Posizione) ',
  (*002*)   'Non e'' stato assegnato in anagrafica il comune INAIL a fine anno di cui si richiede elaborazione',
  (*003*)   'Valore negativo per dato con formato positivo',
  (*004*)   'Non esistono per il dipendente i dati di inquadramento INPDAP al ',
  (*005*)   'Imponibile correlato a gestione assicurativa inesistente: ',
  (*006*)   'Importi senza periodi INPDAP nel mese. '
  );
  TipoRappLavIndet:array[1..14] of String =
  (*001*)  ('01',
  (*002*)   '02',
  (*003*)   '03',
  (*004*)   '18',
  (*005*)   '19',
  (*006*)   '20',
  (*007*)   '21',
  (*008*)   '22',
  (*009*)   '23',
  (*010*)   '24',
  (*011*)   '25',
  (*012*)   '51',
  (*013*)   '52',
  (*014*)   '59'
  );

  (*tempdario per modifica P656
var
  P946FCalcoloFLUPERDtm: TP946FCalcoloFLUPERDtm;
*)
implementation

uses R500Lin;

{$R *.DFM}

procedure TP946FCalcoloFLUPERDtm.Calcolo(DatiFlup:TDatiFLUP946);
begin
  DatiInpFLUPER:=DatiFlup;
  DatiOut.Blocca:='';
  DatiOut.NoBlocca:='';
  sCodiciNoBlocca:='';
  //Chiamata alle routine principali
  try
    MacroRoutine;
    if DatiOut.Blocca = '' then
      SessioneOracle.Commit
    else
      SessioneOracle.Rollback;
  except
    SessioneOracle.Rollback;
    raise;
  end;
end;

procedure TP946FCalcoloFLUPERDtm.MacroRoutine;
//Chiamata alle routine principali
begin
  ImpostazioniIniziali;
//  CancellaDatiIndividuali;
  //Gestione passaggio tipo rapporto da determinato codici da 04 a 07 a indeterminato codice 01
  PassaggioTipoRapp;
  delP663.ClearVariables;
  //Elabora dati anagrafici parte D0
  if DatiInpFLUPER.ElaboraDatiFLUSSOA then
  begin
    //Cancello i dati individuali
    delP663.SetVariable('IdFLUPER',DatiInpFLUPER.ID_FLUPER);
    delP663.SetVariable('Progressivo',DatiInpFLUPER.Progressivo);
    delP663.SetVariable('Parte','A');
    delP663.Execute;
    //Se c'è passaggio da tempo indeterminato esegue due volte il calcolo delle query per la parte 'A'
    if (dDataFineDet <> 0) and (dDataInizioIndet <> 0) then
    begin
      //Calcolo i dati derivanti da query impostate per il flusso 'A' del fluper
      //per il periodo a tempo determinato
      CalcoloDatiQuery('A',dDataFineDet,1);
      //Calcolo i dati derivanti da query impostate per il flusso 'A' del fluper
      //per il periodo a tempo indeterminato
      CalcoloDatiQuery('A',dDataInizioIndet,2);
    end
    else
      //Calcolo i dati derivanti da query impostate per il flusso 'A' del fluper
      CalcoloDatiQuery('A',DatiInpFLUPER.DataElaborazione,1);
    if DatiOut.Blocca <> '' then
      exit;
    if DatiOut.NoBlocca <> '' then
      exit;
  end;
  if DatiInpFLUPER.ElaboraDatiFLUSSOB1_36 then
  begin
    //Cancello i dati individuali
    delP663.SetVariable('IdFLUPER',DatiInpFLUPER.ID_FLUPER);
    delP663.SetVariable('Progressivo',DatiInpFLUPER.Progressivo);
    delP663.SetVariable('Parte','B');
    delP663.SetVariable('Numero','and Numero < ''037''');
    delP663.Execute;
    //Calcolo i dati derivanti da query impostate per il flusso 'B' 1-36 del fluper
    CalcoloDatiQuery('B1_36',DatiInpFLUPER.DataElaborazione,1);
    if DatiOut.Blocca <> '' then
      exit;
    if DatiOut.NoBlocca <> '' then
      exit;
  end;
  if DatiInpFLUPER.ElaboraDatiFLUSSOB37 then
  begin
    //Cancello i dati individuali
    delP663.SetVariable('IdFLUPER',DatiInpFLUPER.ID_FLUPER);
    delP663.SetVariable('Progressivo',DatiInpFLUPER.Progressivo);
    delP663.SetVariable('Parte','B');
    delP663.SetVariable('Numero','and Numero >= ''037''');
    delP663.Execute;
    //Calcolo i dati derivanti da query impostate per la parte 'B' a partire dal punto 037
    CalcoloDatiQuery('B1_37',DatiInpFLUPER.DataElaborazione,1);
    if DatiOut.Blocca <> '' then
      exit;
    if DatiOut.NoBlocca <> '' then
      exit;
  end;
  //Duplico record di tipo B per dipendenti passati da tempo determinato a tempo indeterminato
  DuplicoRecordParteB;
  //Imposto il dato Progressivo del Fluper per la parte A e la parte B uguale
  //a progressivo numero.
  updP663a.SetVariable('IdFLUPER',DatiInpFLUPER.ID_FLUPER);
  updP663a.SetVariable('Progressivo',DatiInpFLUPER.Progressivo);
  updP663a.SetVariable('Parte','A');
  updP663a.SetVariable('Numero','006');
  updP663a.Execute;
  updP663a.SetVariable('IdFLUPER',DatiInpFLUPER.ID_FLUPER);
  updP663a.SetVariable('Progressivo',DatiInpFLUPER.Progressivo);
  updP663a.SetVariable('Parte','B');
  updP663a.SetVariable('Numero','006');
  updP663a.Execute;
end;

procedure TP946FCalcoloFLUPERDtm.ImpostazioniIniziali;
//Impostazioni iniziali
begin
  //Lettura record di setup
  if selP150.GetVariable('DataElaborazione') <> DatiInpFLUPER.DataElaborazione then
  begin
    selP150.SetVariable('DataElaborazione',DatiInpFLUPER.DataElaborazione);
    selP150.Close;
    selP150.Open;
  end;
  //Apertura query per estrazione codice contratto voci
  if (selP430.GetVariable('DataElaborazione') <> DatiInpFLUPER.DataElaborazione)
    or (selP430.GetVariable('Progressivo') <> DatiInpFLUPER.Progressivo) then
  begin
    selP430.SetVariable('DataElaborazione',DatiInpFLUPER.DataElaborazione);
    selP430.SetVariable('Progressivo',DatiInpFLUPER.Progressivo);
    selP430.Close;
    selP430.Open;
  end;
  //Apertura query per estrazione importi delle voci raggruppati per accorpamento,competenza e origine
  selP442.Filtered:=False;
  selP442.Close;
  selP442.SetVariable('DataElaborazione',DatiInpFLUPER.DataElaborazione);
  selP442.SetVariable('Progressivo',DatiInpFLUPER.Progressivo);
  selP442.SetVariable('Contratto',selP430.FieldByName('COD_CONTRATTO').AsString);
  selP442.SetVariable('StatoCedolini',DatiInpFLUPER.StatoCedolini);
  selP442.Open;
end;

(*
procedure TP946FCalcoloFLUPERDtm.CancellaDatiIndividuali;
 //Cancellazione dei dati individuali FLUPER
begin
  delP663.ClearVariables;
  if DatiInpFLUPER.ElaboraDatiFLUSSOA then
  begin
    delP663.SetVariable('IdFLUPER',DatiInpFLUPER.ID_FLUPER);
    delP663.SetVariable('Progressivo',DatiInpFLUPER.Progressivo);
    delP663.SetVariable('Parte','A');
    delP663.Execute;
  end
  else if DatiInpFLUPER.ElaboraDatiFLUSSOB1_36 then
  begin
    delP663.SetVariable('IdFLUPER',DatiInpFLUPER.ID_FLUPER);
    delP663.SetVariable('Progressivo',DatiInpFLUPER.Progressivo);
    delP663.SetVariable('Parte','B');
    delP663.SetVariable('Numero','and Numero < ''037''');
    delP663.Execute;
  end
  else if DatiInpFLUPER.ElaboraDatiFLUSSOB37 then
  begin
    delP663.SetVariable('IdFLUPER',DatiInpFLUPER.ID_FLUPER);
    delP663.SetVariable('Progressivo',DatiInpFLUPER.Progressivo);
    delP663.SetVariable('Parte','B');
    delP663.SetVariable('Numero','and Numero > ''036''');
    delP663.Execute;
  end;
end;
*)

procedure TP946FCalcoloFLUPERDtm.CreaTabellaTemporaneaB1_36;
begin
  //Ricreo la tabella temporanea
  if TabellaTemporaneaB1_36.Active then
    TabellaTemporaneaB1_36.EmptyDataSet;
  TabellaTemporaneaB1_36.Close;
  TabellaTemporaneaB1_36.FieldDefs.Clear;
  selP660.First;
  while not selP660.Eof do
  begin
    if (SelP660.FieldByName('FORMATO_FILE').AsString='AN') or (SelP660.FieldByName('FORMATO_FILE').AsString='CF') then
      TabellaTemporaneaB1_36.FieldDefs.Add(SelP660.FieldByName('NUMERO').AsString, ftString, 100)
    else if Copy(SelP660.FieldByName('FORMATO_FILE').AsString,1,1)='D' then
      TabellaTemporaneaB1_36.FieldDefs.Add(SelP660.FieldByName('NUMERO').AsString, ftDate, 0)
    else if (Copy(SelP660.FieldByName('FORMATO_FILE').AsString,1,1)='N') or (Copy(SelP660.FieldByName('FORMATO_FILE').AsString,1,1)='V') then
      TabellaTemporaneaB1_36.FieldDefs.Add(SelP660.FieldByName('NUMERO').AsString, ftFloat, 0);
    SelP660.Next;
  end;
  if selP660.RecordCount > 0 then
  begin
    TabellaTemporaneaB1_36.CreateDataSet;
    TabellaTemporaneaB1_36.LogChanges:=False;
  end;
  selP660.First;
end;

procedure TP946FCalcoloFLUPERDtm.CalcoloDatiQuery(Parte: String; DataPeriodo: TDateTime; ProgrNum: Integer);
//Calcolo i dati derivanti da query impostate
var
  sDatoFLUPER,sParte,sNumero: String;
  sNomeDatoStruttura: String;
  bRegolaManuale:boolean;
  Tabella, Codice, Storico:String;
  sCodTipoAccorp, sCodCodiciAccorp, sNumApp: String;
  cImportoTredCorr, cImportoTredPrec, cImportoAnnoPrec, cImportoAnnoAtt, cImportoMeseAtt: Currency;
  function Minuti2Giorni(V,UM:String):String;
  begin
    if UM = 'G' then
      try Result:=FloatToStr(StrToFloat(V)); except Result:='0'; end
    else
      if R600Dtm1.ValenzaGiornaliera <> 0 then
        Result:=Format('%.2f',[StrToFloat(V)/R600Dtm1.ValenzaGiornaliera])
      else
        Result:=Format('%.2f',[0.0]);
  end;
  procedure EseguiConteggi(var sDatoFluper:string;sFieldNameUO:string;sFieldNameSTR:string);
  var
    dDataDa,dDataA:TDateTime;
  begin
    sDatoFLUPER:='0';
    OperSql.SQL.Clear;
    OperSql.SQL.Add('SELECT DATADECORRENZA, DATAFINE');
    OperSql.SQL.Add('  FROM T430_STORICO');
    OperSql.SQL.Add(' WHERE ' + selP660.FieldByName('NOME_DATO').AsString + ' = ''' + TabellaTemporaneaB1_36.FieldByName(sFieldNameUO).AsString + '''');
    OperSql.SQL.Add('   AND ' + sNomeDatoStruttura + ' = ''' + TabellaTemporaneaB1_36.FieldByName(sFieldNameSTR).AsString + '''');
    OperSql.SQL.Add('   AND DATAFINE>=TO_DATE(''' + FormatDateTime('ddmmyyyy',R180InizioMese(DataPeriodo)) + ''',''ddmmyyyy'')');
    OperSql.SQL.Add('   AND DATADECORRENZA<=TO_DATE(''' + FormatDateTime('ddmmyyyy',DataPeriodo) + ''',''ddmmyyyy'')');
    OperSql.SQL.Add('   AND PROGRESSIVO=' + IntTostr(DatiInpFLUPER.Progressivo));
    OperSql.DeleteVariables;
    OperSql.Close;
    OperSql.Open;
    while not OperSql.Eof do
    begin
      dDataDa:=OperSql.FieldByName('DATADECORRENZA').AsDateTime;
      if dDataDa < R180InizioMese(DataPeriodo) then
        dDataDa:=R180InizioMese(DatiInpFLUPER.DataElaborazione);
      dDataA:=OperSql.FieldByName('DATAFINE').AsDateTime;
      if dDataA > DatiInpFLUPER.DataElaborazione then
        dDataA:=DatiInpFLUPER.DataElaborazione;
      while dDataDa<=dDataA do
      begin
        R502ProDtM1.Conteggi('Cartolina',DatiInpFLUPER.Progressivo,dDataDa);
        sDatoFLUPER:=IntToStr(StrToInt(sDatoFLUPER) + (R502ProDtM1.totlav - R502ProDtM1.minassenze + R502ProDtM1.MinLavCau[selP660.FieldByName('CODICI_CAUSALI').AsString]));
        dDataDa:=dDataDa+1;
      end;
      OperSql.Next;
    end;
    if sDatoFLUPER<>'0' then
      sDatoFLUPER:=FloatToStr(StrToFloat(sDatoFLUPER)/60);
//    sDatoFLUPER:=FloatToStr((R180Arrotonda((StrToInt(sDatoFLUPER)/60),1,'P')));
  end;
  procedure ConteggiaFruitoCausali(var sDatoFLUPER:string; sCausali:string; sTipo:string);
  var
    dDataDa,dDataA:TDateTime;
    i:integer;
    sListaCausali:TStringList;
    G:TGiustificativo;
    QAss,HRese:Real;
    UM:string;
  begin
    sDatoFLUPER:='0';
    dDataDa:=R180InizioMese(DatiInpFLUPER.DataElaborazione);
    dDataA:=DatiInpFLUPER.DataElaborazione;
    if sTipo='O' then //CAUSALI IN ORE
    begin
      sCausali:='|' + StringReplace(sCausali,',','|',[rfReplaceAll]) + '|';
      while dDataDa<=dDataA do
      begin
        R502ProDtM1.Conteggi('Cartolina',DatiInpFLUPER.Progressivo,dDataDa);
        //Controllo la causale che trovo nel giorno è di presenza oppure di assenza oppure null...
        for i:=1 to R502ProDtM1.n_rieppres do
          if Pos('|' + R502ProDtM1.triepgiuspres[i].tcauspres + '|',sCausali) > 0 then
            sDatoFLUPER:=IntToStr(StrToInt(sDatoFLUPER) + R502ProDtM1.RiepPresTotale[i]);
        for i:=1 to R502ProDtM1.n_riepasse do
          if Pos('|' + R502ProDtM1.triepgiusasse[i].tcausasse + '|',sCausali) > 0 then
            sDatoFLUPER:=IntToStr(StrToInt(sDatoFLUPER) + R502ProDtM1.triepgiusasse[i].tminresasse); //Minuti rese sul cartellino
        dDataDa:=dDataDa+1;
      end;
      if sDatoFLUPER<>'0' then
        sDatoFLUPER:=FloatToStr(StrToFloat(sDatoFLUPER)/60);
    end
    else if sTipo='G' then //Causali in giorni R600
    begin
      sListaCausali:=TStringList.Create;
      sListaCausali.CommaText:=sCausali;
      for i:=0 to sListaCausali.Count-1 do
      begin
        G.Inserimento:=False;
        G.Modo:='I';
        G.Causale:=sListaCausali[i];
        R600DtM1.CalcolaCompetenzeDelPeriodo:=True;
        QAss:=0;
        UM:='';
        R600DtM1.GetQuantitaAssenze(DatiInpFLUPER.Progressivo,dDataDa,dDataA,Date,G,UM,QAss,HRese);
        UM:=R600DtM1.UMisura;
        //R600DtM1.GetAssenze(DatiInpFLUPER.Progressivo,R180InizioMese(DatiInpFLUPER.DataElaborazione),DatiInpFLUPER.DataElaborazione,0,G);
        sDatoFLUPER:=FloatToStr(StrToFloat(sDatoFLUPER) + StrToFloat(Minuti2Giorni(FloatToStr(QAss),UM)));
      end;
      sListaCausali.Free;
    end;
//    sDatoFLUPER:=FloatToStr((R180Arrotonda((StrToInt(sDatoFLUPER)/60),1,'P')));
  end;
  procedure ConteggiaMaturatoCausali(var sDatoFLUPER:string; sCausali:string);
  var
    G:TGiustificativo;
    QAss,HRese:Real;
    UM:string;
    sListaCausali:TStringList;
    i:integer;
  begin
    sDatoFLUPER:='0';
    if sCausali<>'' then
    begin
      //Riepilogo Competenze/Residui
      sListaCausali:=TStringList.Create;
      sListaCausali.CommaText:=sCausali;
      for i:=0 to sListaCausali.Count-1 do
      begin
        G.Inserimento:=False;
        G.Modo:='I';
        G.Causale:=sListaCausali[i];
        R600DtM1.CalcolaCompetenzeDelPeriodo:=True;
        QAss:=0;
        UM:='';
        R600DtM1.GetQuantitaAssenze(DatiInpFLUPER.Progressivo,R180InizioMese(DatiInpFLUPER.DataElaborazione),DatiInpFLUPER.DataElaborazione,Date,G,UM,QAss,HRese);
        UM:=R600DtM1.UMisura;
        R600DtM1.GetAssenze(DatiInpFLUPER.Progressivo,R180InizioMese(DatiInpFLUPER.DataElaborazione),DatiInpFLUPER.DataElaborazione,0,G);
        sDatoFLUPER:=FloatToStr(StrToFloat(sDatoFLUPER) + StrToFloat(Minuti2Giorni(FloatToStr(R600DtM1.CompetenzeDelPeriodo),UM)));
      end;
//      sDatoFLUPER:=FloatToStr(R180Arrotonda(StrToFloat(sDatoFLUPER),1,'P'));
      sListaCausali.Free;
    end;
  end;
  procedure GetCreditiFormativi(var sDatoFLUPER:string);
  begin
    //Riepilogo Competenze/Residui
    If Parametri.CampiRiferimento.C10_FormazioneProfiloCrediti <> '' then
    begin
      R100FCreditiFormativiDtM.ConteggioCrediti(DatiInpFLUPER.Progressivo,R180InizioMese(DatiInpFLUPER.DataElaborazione),DatiInpFLUPER.DataElaborazione,'ECM');
      sDatoFLUPER:=FloatToStr(R100FCreditiFormativiDtM.CompResCrediti.nFruitoPeriodo);
//      sDatoFLUPER:=FloatToStr(R180Arrotonda(S651FCreditiFormativiDtM.CompResCrediti.nFruitoPeriodo,1,'P'));
    end
    else
      sDatoFLUPER:='0';
  end;
  function LeggoValoreCampo:Currency;
  //Ricerca eventuale valore già inserito per il punto da valorizzare
  begin
    Result:=0;
    selP663.SetVariable('IdFLUPER',DatiInpFLUPER.ID_FLUPER);
    selP663.SetVariable('Progressivo',DatiInpFLUPER.Progressivo);
    selP663.SetVariable('Parte',sParte);
    selP663.SetVariable('Numero',sNumApp);
    selP663.SetVariable('ProgressivoNumero',1);
    selP663.Close;
    selP663.Open;
    if not selP663.Eof and not selP663.FieldByName('VALORE').IsNull then
      Result:=selP663.FieldByName('VALORE').AsCurrency;
  end;
begin
  selP660.Filter:='';
  selP660.Filtered:=False;
  if (selP660.GetVariable('DataElaborazione') <> DatiInpFLUPER.DataElaborazione) then
  begin
    selP660.SetVariable('DataElaborazione',DatiInpFLUPER.DataElaborazione);
    selP660.Close;
    selP660.Open;
  end;
  bFinePeriodoLav:=False;
  if Parte='A' then
  begin
    sParte:=Parte;
    selP660.Filter:='PARTE=''A''';
    selP660.Filtered:=True;
    T430A.SetVariable('DATAELABORAZIONE',DataPeriodo);
    T430A.SetVariable('PROGRESSIVO',DatiInpFLUPER.Progressivo);
    T430A.Close;
    T430A.Open;
    if T430A.RecordCount=0 then
    begin
      DatiOut.Blocca:=BloccaP946[1];
      exit;
    end;
    //Se il dipendente è cessato... nel mese successivo a quello di cessazione non devo procedere al calcolo
    if (not T430A.FieldByName('FINE').IsNull) and (T430A.FieldByName('FINE').AsDateTime < R180InizioMese(DatiInpFLUPER.DataElaborazione))
       and (selP442.RecordCount = 0) then
      exit;
  end
  else if Parte='B1_36' then
  begin
    sParte:='B';
    sNomeDatoStruttura:='';
    selP660.Filter:='(PARTE=''B'') AND (NUMERO < ''037'')';
    selP660.Filtered:=True;
    T430B1_36.ClearVariables;
    T430B1_36.SetVariable('DATAINIZIOELABORAZIONE',R180InizioMese(DatiInpFLUPER.DataElaborazione));
    T430B1_36.SetVariable('DATAFINEELABORAZIONE',DatiInpFLUPER.DataElaborazione);
    T430B1_36.SetVariable('PROGRESSIVO',DatiInpFLUPER.Progressivo);
    T430B1_36.Close;
    T430B1_36.Open;
    CreaTabellaTemporaneaB1_36;
    //Mi posiziono sull'ultimo periodo storico per leggere tutti i campi nel mese...
    T430B1_36.Last;
    if T430B1_36.RecordCount=0 then
    begin
      DatiOut.Blocca:=BloccaP946[1];
      exit;
    end;
    //Se il dipendente è cessato... nel mese successivo a quello di cessazione non devo procedere al calcolo
    if (not T430B1_36.FieldByName('FINE').IsNull) and (T430B1_36.FieldByName('FINE').AsDateTime < R180InizioMese(DatiInpFLUPER.DataElaborazione))
       and (selP442.RecordCount = 0) then
      exit;
  end
  else if Parte='B1_37' then
  begin
    sParte:='B';
    selP660.Filter:='(PARTE=''B'') AND (NUMERO >= ''037'')';
    selP660.Filtered:=True;
    //Se non è aperta, apro la query T430A per verificare se il dipendente è cessato oppure no...
    if (T430A.GetVariable('DATAELABORAZIONE') <> DatiInpFLUPER.DataElaborazione) or
       (T430A.GetVariable('PROGRESSIVO') <> DatiInpFLUPER.Progressivo) then
    begin
      T430A.SetVariable('DATAELABORAZIONE',DatiInpFLUPER.DataElaborazione);
      T430A.SetVariable('PROGRESSIVO',DatiInpFLUPER.Progressivo);
      T430A.Close;
      T430A.Open;
      if T430A.RecordCount=0 then
      begin
        DatiOut.Blocca:=BloccaP946[1];
        exit;
      end;
    end;
    //Se il dipendente è cessato... nel mese successivo a quello di cessazione non devo procedere al calcolo
    if (not T430A.FieldByName('FINE').IsNull) and (T430A.FieldByName('FINE').AsDateTime < R180InizioMese(DatiInpFLUPER.DataElaborazione))
       and (selP442.RecordCount = 0) then
      exit;
  end;
  //Scorro le regole e per ogni regola valorizzo l'opportuno campo nel FLUPER
  selP660.First;
  if not selP660.Eof then
  begin
    while not selP660.Eof do
    begin
      sDatoFLUPER:='';
      bRegolaManuale:=False;
      sNumero:=selP660.FieldByName('NUMERO').AsString;
      if not(selP660.FieldByName('REGOLA_CALCOLO_MANUALE').IsNull) then
      begin
        bRegolaManuale:=True;
        OperSql.SQL.Text:=selP660.FieldByName('REGOLA_CALCOLO_MANUALE').AsString;
        OperSql.DeleteVariables;
        OperSql.Close;
        if Pos(':IDFLUSSO',UpperCase(OperSql.SQL.Text)) > 0 then
        begin
          OperSql.DeclareVariable('IdFlusso',otInteger);
          OperSql.SetVariable('IdFlusso',DatiInpFLUPER.ID_FLUPER);
        end;
        if Pos(':PROGRESSIVO',UpperCase(OperSql.SQL.Text)) > 0 then
        begin
          OperSql.DeclareVariable('Progressivo',otInteger);
          OperSql.SetVariable('Progressivo',DatiInpFLUPER.Progressivo);
        end;
        if Pos(':DATAELABORAZIONE',UpperCase(OperSql.SQL.Text)) > 0 then
        begin
          OperSql.DeclareVariable('DataElaborazione',otDate);
          //In caso di passaggio da tempo determinato ad indeterminato nella query per
          //inizio rapporto la Data Elaborazione deve essere fine periodo a tempo determinato
          if selP660.FieldByName('NUMERO').AsString = '013' then
            OperSql.SetVariable('DataElaborazione',DataPeriodo)
          else
            OperSql.SetVariable('DataElaborazione',DatiInpFLUPER.DataElaborazione);
        end;
        if (Pos(':NOMEDATO',UpperCase(OperSql.SQL.Text)) > 0) and (selP660.FieldByName('NOME_DATO').AsString<>'') then
        begin
          OperSql.DeclareVariable('NomeDato',otSubst);
          OperSql.SetVariable('NomeDato',selP660.FieldByName('NOME_DATO').AsString);
        end;
        if (Pos(':NOMETABELLA',UpperCase(OperSql.SQL.Text)) > 0) and (selP660.FieldByName('NOME_DATO').AsString<>'') then
        begin
          OperSql.DeclareVariable('NomeTabella',otSubst);
          OperSql.SetVariable('NomeTabella','I501' + selP660.FieldByName('NOME_DATO').AsString);
        end;
        if (Pos(':VALOREDATO',UpperCase(OperSql.SQL.Text)) > 0) and (selP660.FieldByName('NOME_DATO').AsString<>'') then
        begin
          OperSql.DeclareVariable('ValoreDato',otString);
          if Parte='A' then
            OperSql.SetVariable('ValoreDato', T430A.FieldByName(selP660.FieldByName('NOME_DATO').AsString).AsString)
          else if Parte='B1_36' then
            OperSql.SetVariable('ValoreDato', T430B1_36.FieldByName(selP660.FieldByName('NOME_DATO').AsString).AsString);
        end;
        if Pos(':ELENCOCAUSALI',UpperCase(OperSql.SQL.Text)) > 0 then
        begin
          OperSql.DeclareVariable('ElencoCausali',otSubst);
          if selP660.FieldByName('CODICI_CAUSALI').AsString = '' then
            OperSql.SetVariable('ElencoCausali', selP660.FieldByName('CODICI_CAUSALI').AsString)
          else
            OperSql.SetVariable('ElencoCausali', '''' + StringReplace(selP660.FieldByName('CODICI_CAUSALI').AsString,',',''',''',[rfReplaceAll]) + '''');
        end;
        OperSql.Open;
        if not OperSql.Eof then
          sDatoFLUPER:=OperSql.FieldS[0].AsString;
      end;
      if not bRegolaManuale then
      begin
        //************************************************************************************************
        //                                            FLUSSO A
        //************************************************************************************************
        if Parte='A' then
        begin
          if selP660.FieldByName('NOME_DATO').AsString <> '' then
            sDatoFLUPER:=T430A.FieldByName(selP660.FieldByName('NOME_DATO').AsString).AsString;
          if selP660.FieldByName('NUMERO').AsString='013A' then
          begin
            //Leggo dalla tabella dei comuni la descrizione del comune
            OperSql.SQL.Text:='SELECT SUBSTR(CITTA,1,30) FROM T480_COMUNI WHERE CODICE=''' + sDatoFLUPER + '''';
            OperSql.DeleteVariables;
            OperSql.Close;
            OperSql.Open;
            if not OperSql.Eof then
              sDatoFLUPER:=OperSql.FieldS[0].AsString;
          end
          else if selP660.FieldByName('NUMERO').AsString='020' then
          begin
            //Leggo dalla tabella dei part-time la percentuale della pianta organica
            OperSql.SQL.Text:='SELECT PIANTA FROM T460_PARTTIME WHERE CODICE=''' + sDatoFLUPER + '''';
            OperSql.DeleteVariables;
            OperSql.Close;
            OperSql.Open;
            if not OperSql.Eof then
              if OperSql.FieldS[0].AsInteger=100 then
                sDatoFLUPER:='0'
              else
                sDatoFLUPER:=IntToStr(OperSql.FieldS[0].AsInteger);
          end;
        end
        //************************************************************************************************
        //                                            FLUSSO B - CAMPI 1..36
        //************************************************************************************************
        else if Parte='B1_36' then
        begin
          if (selP660.FieldByName('NUMERO').AsString='008') or   //CODICE STRUTTURA DI IMPIEGO 1 *********************************
             (selP660.FieldByName('NUMERO').AsString='009') then //CODICE STRUTTURA DI IMPIEGO 2 *********************************
          begin
            if selP660.FieldByName('NOME_DATO').AsString <> '' then
            begin
              sNomeDatoStruttura:=selP660.FieldByName('NOME_DATO').AsString;
              T430B1_36.First;
              while not T430B1_36.Eof do
              begin
                if T430B1_36.FieldByName(selP660.FieldByName('NOME_DATO').AsString).AsString<>'' then
                begin
                  sDatoFLUPER:=T430B1_36.FieldByName(selP660.FieldByName('NOME_DATO').AsString).AsString;
                  //Se sto leggendo il campo 009 e trovo un valore = a quello registrato in 008 lo devo ripulire...
                  //perchè in 009 devo registrare solo se trovo un valore <> da 008
                  if (selP660.FieldByName('NUMERO').AsString='009') then
                  begin
                    if TabellaTemporaneaB1_36.FieldByName('008').AsString='' then
                      sNumero:='008'
                    else if (sDatoFLUPER=TabellaTemporaneaB1_36.FieldByName('008').AsString) then
                      sDatoFLUPER:='';
                  end;
                  if sDatoFLUPER<>''then
                    break;
                end;
                T430B1_36.Next;
              end;
            end;
          end
          else if (selP660.FieldByName('NUMERO').AsString='010') or   //CODICE DIPARTIMENTO DI IMPIEGO 1  ********************************
                  (selP660.FieldByName('NUMERO').AsString='012') then //CODICE DIPARTIMENTO DI IMPIEGO 2 *********************************
          begin
            if selP660.FieldByName('NOME_DATO').AsString <> '' then
            begin
              T430B1_36.First;
              while not T430B1_36.Eof do
              begin
                if T430B1_36.FieldByName(selP660.FieldByName('NOME_DATO').AsString).AsString<>'' then
                begin
                  sDatoFLUPER:=T430B1_36.FieldByName(selP660.FieldByName('NOME_DATO').AsString).AsString;
                  //Se sto leggendo il campo 012 e trovo un valore = a quello registrato in 010 lo devo ripulire...
                  //perchè in 012 devo registrare solo se trovo un valore <> da 010
                  if (selP660.FieldByName('NUMERO').AsString='012') then
                  begin
                    if TabellaTemporaneaB1_36.FieldByName('010').AsString='' then
                      sNumero:='010'
                    else if (sDatoFLUPER=TabellaTemporaneaB1_36.FieldByName('010').AsString) then
                      sDatoFLUPER:='';
                  end;
                  if sDatoFLUPER<>''then
                    break;
                end;
                T430B1_36.Next;
              end;
            end;
          end
          else if (selP660.FieldByName('NUMERO').AsString='011') or
                  (selP660.FieldByName('NUMERO').AsString='013') then
          begin
            if selP660.FieldByName('NOME_DATO').AsString <> '' then
            begin
              //Devo controllare se il dato libero è storicizzato o meno
              A000GetTabella(selP660.FieldByName('NOME_DATO').AsString,Tabella,Codice,Storico);
              if Tabella <> '' then
              begin
                //Leggo la descrizione del dipartimento di impiego 1
                OperSql.Close;
                OperSql.SQL.Clear;
                OperSql.DeleteVariables;
                OperSql.SQL.Add('SELECT DESCRIZIONE FROM I501' + selP660.FieldByName('NOME_DATO').AsString);
                if selP660.FieldByName('NUMERO').AsString='011' then
                  OperSql.SQL.Add('WHERE CODICE=''' + TabellaTemporaneaB1_36.FieldByName('010').AsString + '''')
                else
                  OperSql.SQL.Add('WHERE CODICE=''' + TabellaTemporaneaB1_36.FieldByName('012').AsString + '''');
                if Storico = 'S' then
                begin
                  OperSql.SQL.Add(Format('AND DECORRENZA = (SELECT MAX(DECORRENZA) FROM %s WHERE %s = T1.%s AND DECORRENZA <= :DECORRENZA)',[Tabella,Codice,Codice]));
                  OperSql.DeclareVariable('DECORRENZA',otDate);
                end;
                OperSql.Open;
                if not OperSql.Eof then
                  sDatoFLUPER:=OperSql.FieldS[0].AsString;
              end;
            end;
          end
          else if (selP660.FieldByName('NUMERO').AsString='014') or   //CODICE UO1 - STRUTTURA DI IMPIEGO 1 *********************************
                  (selP660.FieldByName('NUMERO').AsString='016') or   //CODICE UO2 - STRUTTURA DI IMPIEGO 1 *********************************
                  (selP660.FieldByName('NUMERO').AsString='018') then //CODICE UO3 - STRUTTURA DI IMPIEGO 1 *********************************
          begin
            //Leggo il valore del dato relativo al primo periodo storico successivo in cui il dato è cambiato...
            if selP660.FieldByName('NOME_DATO').AsString <> '' then
            begin
              T430B1_36.Filtered:=False;
              T430B1_36.Filter:= sNomeDatoStruttura + '=''' + TabellaTemporaneaB1_36.FieldByName('008').AsString + '''';
              T430B1_36.Filtered:=True;
              T430B1_36.First;
              while not T430B1_36.Eof do
              begin
                if T430B1_36.FieldByName(selP660.FieldByName('NOME_DATO').AsString).AsString<>'' then
                begin
                  sDatoFLUPER:=T430B1_36.FieldByName(selP660.FieldByName('NOME_DATO').AsString).AsString;
                  if sDatoFLUPER <> '' then
                  begin
                    //Se sto leggendo il campo 012 e trovo un valore = a quello registrato in 010 lo devo ripulire...
                    //perchè in 012 devo registrare solo se trovo un valore <> da 010
                    if ((selP660.FieldByName('NUMERO').AsString='016') and ((TabellaTemporaneaB1_36.FieldByName('014').AsString='') or (sDatoFLUPER=TabellaTemporaneaB1_36.FieldByName('014').AsString))) or
                       ((selP660.FieldByName('NUMERO').AsString='018') and ((TabellaTemporaneaB1_36.FieldByName('016').AsString='') or (sDatoFLUPER=TabellaTemporaneaB1_36.FieldByName('016').AsString) or (sDatoFLUPER=TabellaTemporaneaB1_36.FieldByName('014').AsString))) then
                      sDatoFLUPER:=''
                  end;
                  if sDatoFLUPER<>''then
                    break;
                end;
                T430B1_36.Next;
              end;
              T430B1_36.Filtered:=False;
            end;
          end
          else if (selP660.FieldByName('NUMERO').AsString='020') or   //CODICE UO1 - STRUTTURA DI IMPIEGO 2 *********************************
                  (selP660.FieldByName('NUMERO').AsString='022') or   //CODICE UO2 - STRUTTURA DI IMPIEGO 2 *********************************
                  (selP660.FieldByName('NUMERO').AsString='024') then //CODICE UO3 - STRUTTURA DI IMPIEGO 2 *********************************
          begin
            //Leggo il valore del dato relativo al primo periodo storico successivo in cui il dato è cambiato...
            if selP660.FieldByName('NOME_DATO').AsString <> '' then
            begin
              T430B1_36.Filtered:=False;
              T430B1_36.Filter:=sNomeDatoStruttura + '=''' + TabellaTemporaneaB1_36.FieldByName('009').AsString + '''';
              T430B1_36.Filtered:=True;
              T430B1_36.First;
              while not T430B1_36.Eof do
              begin
                if T430B1_36.FieldByName(selP660.FieldByName('NOME_DATO').AsString).AsString<>'' then
                begin
                  sDatoFLUPER:=T430B1_36.FieldByName(selP660.FieldByName('NOME_DATO').AsString).AsString;
                  if sDatoFLUPER <> '' then
                  begin
                    //Se sto leggendo il campo 012 e trovo un valore = a quello registrato in 010 lo devo ripulire...
                    //perchè in 012 devo registrare solo se trovo un valore <> da 010
                    if ((selP660.FieldByName('NUMERO').AsString='022') and ((TabellaTemporaneaB1_36.FieldByName('020').AsString='') or (sDatoFLUPER=TabellaTemporaneaB1_36.FieldByName('020').AsString))) or
                       ((selP660.FieldByName('NUMERO').AsString='024') and ((TabellaTemporaneaB1_36.FieldByName('022').AsString='') or (sDatoFLUPER=TabellaTemporaneaB1_36.FieldByName('022').AsString) or (sDatoFLUPER=TabellaTemporaneaB1_36.FieldByName('020').AsString))) then
                      sDatoFLUPER:=''
                  end;
                  if sDatoFLUPER<>''then
                    break;
                end;
                T430B1_36.Next;
              end;
              T430B1_36.Filtered:=False;
            end;
          end
          else if (selP660.FieldByName('NUMERO').AsString='026') then //Tot.ore lav in UO1 - STRUTTURA DI IMPIEGO 1 *********************************
          begin
            if TabellaTemporaneaB1_36.FieldByName('014').AsString<>'' then
              EseguiConteggi(sDatoFluper,'014','008');
          end
          else if (selP660.FieldByName('NUMERO').AsString='027') then //Tot.ore lav in UO2 - STRUTTURA DI IMPIEGO 1 *********************************
          begin
            if TabellaTemporaneaB1_36.FieldByName('016').AsString<>'' then
              EseguiConteggi(sDatoFluper,'016','008');
          end
          else if (selP660.FieldByName('NUMERO').AsString='028') then //Tot.ore lav in UO3 - STRUTTURA DI IMPIEGO 1 *********************************
          begin
            if TabellaTemporaneaB1_36.FieldByName('018').AsString<>'' then
              EseguiConteggi(sDatoFluper,'018','008');
          end
          else if (selP660.FieldByName('NUMERO').AsString='029') then //Tot.ore lav in UO1 - STRUTTURA DI IMPIEGO 2 *********************************
          begin
            if TabellaTemporaneaB1_36.FieldByName('020').AsString<>'' then
              EseguiConteggi(sDatoFluper,'020','009');
          end
          else if (selP660.FieldByName('NUMERO').AsString='030') then //Tot.ore lav in UO2 - STRUTTURA DI IMPIEGO 2 *********************************
          begin
            if TabellaTemporaneaB1_36.FieldByName('022').AsString<>'' then
              EseguiConteggi(sDatoFluper,'022','009');
          end
          else if (selP660.FieldByName('NUMERO').AsString='031') then //Tot.ore lav in UO3 - STRUTTURA DI IMPIEGO 2 *********************************
          begin
            if TabellaTemporaneaB1_36.FieldByName('024').AsString<>'' then
              EseguiConteggi(sDatoFluper,'024','009');
          end
          else if (selP660.FieldByName('NUMERO').AsString='034') then //CREDITI FORMATIVI *********************************
          begin
            //LEGGO I CREDITI FORMATIVI MATURATI NEL MESE...
            GetCreditiFormativi(sDatoFLUPER);
          end
          //**************************************** DATI CON CALUSALI DI PRESENZA/ASSENZA  *********************************************
          //*************************************** RESTITUISCO LE ORE FATTE PER IL FRUITO  *********************************************
          //**************************************** RESTITUISCO I GIORNI PER IL MATURATO  **********************************************
          else if selP660.FieldByName('CODICI_CAUSALI').AsString <> '' then
          begin
            if (selP660.FieldByName('NUMERO').AsString='032') or //Ore di formazione aziendale
               (selP660.FieldByName('NUMERO').AsString='033') then //Ore di formazione esterna
              ConteggiaFruitoCausali(sDatoFLUPER,selP660.FieldByName('CODICI_CAUSALI').AsString,'O')
            else if (selP660.FieldByName('NUMERO').AsString='035') then  //Giorni di ferie maturate
              ConteggiaMaturatoCausali(sDatoFLUPER,selP660.FieldByName('CODICI_CAUSALI').AsString)
            else if (selP660.FieldByName('NUMERO').AsString='036') then //Giorni di ferie godute
              ConteggiaFruitoCausali(sDatoFLUPER,selP660.FieldByName('CODICI_CAUSALI').AsString,'G');
          end
          //**************************************** TUTTI GLI ALTRI DATI  **************************************
          else if selP660.FieldByName('NOME_DATO').AsString <> '' then
            sDatoFLUPER:=T430B1_36.FieldByName(selP660.FieldByName('NOME_DATO').AsString).AsString;
          //Mi sposto sempre sull'ultima ricorrenza storica...
          T430B1_36.Last;
        end
        //************************************************************************************************
        //                                            FLUSSO B - CAMPI 37..
        //************************************************************************************************
        else if Parte='B1_37' then
        begin
          if selP660.FieldByName('NUMERO').AsString = '037' then
          begin
            sDatoFLUPER:='0';
          end
          else if selP660.FieldByName('NUMERO').AsString >= '038' then
          begin
            cImportoTredCorr:=0;
            cImportoTredPrec:=0;
            cImportoMeseAtt:=0;
            cImportoAnnoAtt:=0;
            cImportoAnnoPrec:=0;
            sCodTipoAccorp:=Copy(selP660.FieldByName('NOME_DATO').AsString,1,Pos('.',selP660.FieldByName('NOME_DATO').AsString) - 1);
            sCodCodiciAccorp:=Copy(selP660.FieldByName('NOME_DATO').AsString,Pos('.',selP660.FieldByName('NOME_DATO').AsString) + 1,Length(selP660.FieldByName('NOME_DATO').AsString));
            selP442.Filtered:=False;
            selP442.Filter:='(COD_TIPOACCORPAMENTOVOCI = ''' + sCodTipoAccorp + ''') AND (COD_CODICIACCORPAMENTOVOCI = ''' + sCodCodiciAccorp + ''')';
            selP442.Filtered:=True;
            //Ciclo sulle voci accorpate per distribuire i valori sui punti (se definiti nella regola)
            //relativi alla tredicesima (in base ad origine = 'T' o COD_VOCE_SPECIALE = 'TRED') o ai mesi precedenti dello stesso anno
            //o all'anno precedente. Il valore restante viene assegnato sul punto stesso.
            while not selP442.Eof do
            begin
              if (selP442.FieldByName('ORIGINE').AsString = 'T') or (selP442.FieldByName('COD_VOCE_SPECIALE').AsString = 'TRED') then
              begin
                if R180Anno(selP442.FieldByName('COMPETENZA').AsDateTime) < R180Anno(DatiInpFLUPER.DataElaborazione) then
                  cImportoTredPrec:=cImportoTredPrec + selP442.FieldByName('IMPORTO').AsCurrency
                else
                  cImportoTredCorr:=cImportoTredCorr + selP442.FieldByName('IMPORTO').AsCurrency;
              end
              else if selP442.FieldByName('COMPETENZA').AsDateTime = DatiInpFLUPER.DataElaborazione then
                cImportoMeseAtt:=cImportoMeseAtt + selP442.FieldByName('IMPORTO').AsCurrency
              else if R180Anno(selP442.FieldByName('COMPETENZA').AsDateTime) = R180Anno(DatiInpFLUPER.DataElaborazione) then
                cImportoAnnoAtt:=cImportoAnnoAtt + selP442.FieldByName('IMPORTO').AsCurrency
              else if R180Anno(selP442.FieldByName('COMPETENZA').AsDateTime) < R180Anno(DatiInpFLUPER.DataElaborazione) then
                cImportoAnnoPrec:=cImportoAnnoPrec + selP442.FieldByName('IMPORTO').AsCurrency
              else
                cImportoMeseAtt:=cImportoMeseAtt + selP442.FieldByName('IMPORTO').AsCurrency;
              selP442.Next;
            end;
            //Dati relativi a tredicesima anno corrente
            if not selP660.FieldByName('FL_NUMERO_TREDICESIMA').IsNull then
            begin
              //Ricerca eventuale valore già inserito per il punto da valorizzare in seguito a distribuzione
              sNumApp:=selP660.FieldByName('FL_NUMERO_TREDICESIMA').AsString;
              cImportoTredCorr:=cImportoTredCorr + LeggoValoreCampo;
              sDatoFLUPER:=FloatToStr(cImportoTredCorr);
              InserimentoDati(sParte,sNumApp,sDatoFLUPER,ProgrNum);
            end
            else
              cImportoMeseAtt:=cImportoMeseAtt + cImportoTredCorr;
            //Dati relativi a tredicesima anno precedente
            if not selP660.FieldByName('FL_NUMERO_TREDPREC').IsNull then
            begin
              //Ricerca eventuale valore già inserito per il punto da valorizzare in seguito a distribuzione
              sNumApp:=selP660.FieldByName('FL_NUMERO_TREDPREC').AsString;
              cImportoTredPrec:=cImportoTredPrec + LeggoValoreCampo;
              sDatoFLUPER:=FloatToStr(cImportoTredPrec);
              InserimentoDati(sParte,sNumApp,sDatoFLUPER,ProgrNum);
            end
            else
              cImportoMeseAtt:=cImportoMeseAtt + cImportoTredPrec;
            //Dati relativi a mesi dell'anno corrente diversi da mese elaborazione
            if not selP660.FieldByName('FL_NUMERO_ARRCORR').IsNull then
            begin
              //Ricerca eventuale valore già inserito per il punto da valorizzare in seguito a distribuzione
              sNumApp:=selP660.FieldByName('FL_NUMERO_ARRCORR').AsString;
              cImportoAnnoAtt:=cImportoAnnoAtt + LeggoValoreCampo;
              sDatoFLUPER:=FloatToStr(cImportoAnnoAtt);
              InserimentoDati(sParte,sNumApp,sDatoFLUPER,ProgrNum);
            end
            else
              cImportoMeseAtt:=cImportoMeseAtt + cImportoAnnoAtt;
            //Dati relativi ad anni precedenti l'anno di elaborazione
            if not selP660.FieldByName('FL_NUMERO_ARRPREC').IsNull then
            begin
              //Ricerca eventuale valore già inserito per il punto da valorizzare in seguito a distribuzione
              sNumApp:=selP660.FieldByName('FL_NUMERO_ARRPREC').AsString;
              cImportoAnnoPrec:=cImportoAnnoPrec + LeggoValoreCampo;
              sDatoFLUPER:=FloatToStr(cImportoAnnoPrec);
              InserimentoDati(sParte,sNumApp,sDatoFLUPER,ProgrNum);
            end
            else
              cImportoMeseAtt:=cImportoMeseAtt + cImportoAnnoPrec;
            sNumApp:=selP660.FieldByName('NUMERO').AsString;
            cImportoMeseAtt:=cImportoMeseAtt + LeggoValoreCampo;
            sDatoFLUPER:=FloatToStr(cImportoMeseAtt);
          end;
        end;
      end;
      //Gestione inizio fine rapporto per cambio tipo rapporto da tempo determinato a
      //tempo indeterminato
      if Parte = 'A' then
      begin
        //Se c'è passaggio da tempo indeterminato a tempo determinato metto fine rapporto
        //su periodo a tempo determinato
        if (selP660.FieldByName('NUMERO').AsString = '023') and
           (dDataFineDet <> 0) and (dDataFineDet = DataPeriodo) then
          sDatoFLUPER:=FormatDateTime('dd/mm/yyyy',dDataFineDet);
        //Memorizzo se c'è fine periodo di lavoro per abblencare in caso contrario
        //il motivo di cesszione se è già stato valorizzato con assegnazione preventiva
        if (selP660.FieldByName('NUMERO').AsString = '023') and (sDatoFLUPER <> '') then
          bFinePeriodoLav:=True;
        //Se non c'è fine periodo di lavoro abblenco il campo motivo di fine rapporto anche
        //se risulta valorizzato
        if (selP660.FieldByName('NUMERO').AsString = '024') and not bFinePeriodoLav then
          sDatoFLUPER:='';
        //Se c'è passaggio da tempo indeterminato a tempo determinato metto inizio rapporto
        //su periodo a tempo indeterminato
        if (selP660.FieldByName('NUMERO').AsString = '013') and
           (dDataFineDet <> 0) and (dDataInizioIndet <> 0) and (dDataInizioIndet = DataPeriodo) then
          sDatoFLUPER:=FormatDateTime('dd/mm/yyyy',dDataInizioIndet);
      end;
      //Se la parte è 'B1_36' salvo i dati nella tabella temporanea...
      if Parte='B1_36' then
      begin
        if bRegolaManuale then
        begin
          //************************************************************************************************************************************
          //Nel caso in cui vengano gestiti i dip.EDPSC (SONDRIO_ASL) verrà prevista la regola manuale:
          //- se CATEGORIA_CONTR='3' (EDPSC) vengono lette le Quantità mensili per UO1 - STRUTTURA DI IMPIEGO 1, 0 per tutte le altre UO (perchè non cambiano mai UO)
          //- se CATEGORIA_CONTR<>'3' (EDP) vengono lette le Ore dalla scheda riep. ed eventualmente percentualizzate sui cdc per ogni UO - STRUTTURA DI IMPIEGO 1
          //************************************************************************************************************************************
          if (selP660.FieldByName('NUMERO').AsString='008') or //CODICE STRUTTURA DI IMPIEGO 1
             (selP660.FieldByName('NUMERO').AsString='009') or //CODICE STRUTTURA DI IMPIEGO 2
             (selP660.FieldByName('NUMERO').AsString='010') or //CODICE DIPARTIMENTO DI IMPIEGO 1
             (selP660.FieldByName('NUMERO').AsString='012') or //CODICE DIPARTIMENTO DI IMPIEGO 2
             (selP660.FieldByName('NUMERO').AsString='011') or //Descr. DIPARTIMENTO DI IMPIEGO 1
             (selP660.FieldByName('NUMERO').AsString='013') or //Descr. DIPARTIMENTO DI IMPIEGO 2
             (selP660.FieldByName('NUMERO').AsString='014') or //CODICE UO1 - STRUTTURA DI IMPIEGO 1
             (selP660.FieldByName('NUMERO').AsString='016') or //CODICE UO2 - STRUTTURA DI IMPIEGO 1
             (selP660.FieldByName('NUMERO').AsString='018') or //CODICE UO3 - STRUTTURA DI IMPIEGO 1
             (selP660.FieldByName('NUMERO').AsString='020') or //CODICE UO1 - STRUTTURA DI IMPIEGO 2
             (selP660.FieldByName('NUMERO').AsString='022') or //CODICE UO2 - STRUTTURA DI IMPIEGO 2
             (selP660.FieldByName('NUMERO').AsString='024') or //CODICE UO3 - STRUTTURA DI IMPIEGO 2
             (selP660.FieldByName('NUMERO').AsString='026') or //Tot.ore lav in UO1 - STRUTTURA DI IMPIEGO 1
             (selP660.FieldByName('NUMERO').AsString='027') or //Tot.ore lav in UO2 - STRUTTURA DI IMPIEGO 1
             (selP660.FieldByName('NUMERO').AsString='028') or //Tot.ore lav in UO3 - STRUTTURA DI IMPIEGO 1
             (selP660.FieldByName('NUMERO').AsString='029') or //Tot.ore lav in UO1 - STRUTTURA DI IMPIEGO 2
             (selP660.FieldByName('NUMERO').AsString='030') or //Tot.ore lav in UO2 - STRUTTURA DI IMPIEGO 2
             (selP660.FieldByName('NUMERO').AsString='031') then //Tot.ore lav in UO3 - STRUTTURA DI IMPIEGO 2
            sDatoFLUPER:=OperSql.FieldS[0].AsString;
        end;
        TabellaTemporaneaB1_36.Edit;
        TabellaTemporaneaB1_36.FieldByName(sNumero).AsString:=sDatoFLUPER;
        if TabellaTemporaneaB1_36.FieldByName(sNumero).DataType=ftString then
          sDatoFLUPER:=Copy(sDatoFLUPER,1,SelP660.FieldByName('LUNGHEZZA_FILE').AsInteger);
        //Se trovo il carattere "_" nei campi 14,16,18,20,22,24 tronco il codice al carattere che precede l'underscore...
        if ((sNumero = '014') or (sNumero = '016') or (sNumero = '018') or (sNumero = '020') or (sNumero = '022') or (sNumero = '024')) and
           (Pos('_',sDatoFLUPER)>0) then
          sDatoFLUPER:=Copy(sDatoFLUPER,1,Pos('_',sDatoFLUPER)-1);
        TabellaTemporaneaB1_36.Post;
      end;
      if SelP660.FieldByName('NUMERICO').AsString='S' then
        if sDatoFLUPER='' then
          sDatoFLUPER:='0'
        else
        begin
          try
            FormattaDato(SelP660.FieldByName('COD_ARROTONDAMENTO').AsString,SelP660.FieldByName('FORMATO').AsString, sParte, sNumero, sDatoFLUPER);
          except
            on e:exception do
            begin
              DatiOut.Blocca:='Regole Fluper: valore non numerico per dato numerico (Parte:' + sParte + ' - Numero:' + sNumero + ')';
              exit;
            end;
          end;
        end;
      InserimentoDati(sParte,sNumero,sDatoFLUPER,ProgrNum);
      selP660.Next;
    end;
  end
  else
    DatiOut.Blocca:=BloccaP946[2];
end;

procedure TP946FCalcoloFLUPERDtm.PassaggioTipoRapp;
//Verifico se sdoppiare record 'A' e record 'B' per passaggio TIPO_RAPP_LAV
//da determinato codici da 04 a 07 a indeterminato codice 01
var i:Integer;
  Det:Boolean;
begin
  selP660.Filter:='';
  selP660.Filtered:=False;
  if (selP660.GetVariable('DataElaborazione') <> DatiInpFLUPER.DataElaborazione) then
  begin
    selP660.SetVariable('DataElaborazione',DatiInpFLUPER.DataElaborazione);
    selP660.Close;
    selP660.Open;
  end;
  dDataFineDet:=0;
  dDataInizioIndet:=0;
  if selP660.SearchRecord('PARTE;NUMERO',VarArrayOf(['A','005']),[srFromBeginning]) then
  begin
    selT430.SetVariable('DataElaborazione',DatiInpFLUPER.DataElaborazione);
    selT430.SetVariable('Progressivo',DatiInpFLUPER.Progressivo);
    selT430.SetVariable('NomeDatoTipoRapp',selP660.FieldByName('NOME_DATO').AsString);
    selT430.Close;
    selT430.Open;
    if selT430.RecordCount > 1 then
    begin
      while not selT430.Eof do
      begin
        Det:=True;
        for i:=1 to High(TipoRappLavIndet) do
          if selT430.FieldByName('TIPO_RAPP_LAV').AsString = TipoRappLavIndet[i] then
          begin
            Det:=False;
            Break;
          end;
        if Det and (selT430.FieldByName('DATAFINE').AsDateTime <= DatiInpFLUPER.DataElaborazione) then
          dDataFineDet:=selT430.FieldByName('DATAFINE').AsDateTime
        else
        begin
          if (selT430.FieldByName('TIPO_RAPP_LAV').AsString = '01')
              and (selT430.FieldByName('DATADECORRENZA').AsDateTime >= R180InizioMese(DatiInpFLUPER.DataElaborazione))
              and (dDataInizioIndet = 0) and (dDataFineDet <> 0) then
          begin
            if selT430.FieldByName('DATADECORRENZA').AsDateTime <= DatiInpFLUPER.DataElaborazione then
              dDataInizioIndet:=selT430.FieldByName('DATADECORRENZA').AsDateTime;
          end
          else if dDataInizioIndet = 0 then
            dDataFineDet:=0;
        end;
        selt430.Next;
      end;
    end;
  end;
end;

procedure TP946FCalcoloFLUPERDtm.DuplicoRecordParteB;
//Duplico record di tipo B per dipendenti passati da tempo determinato a tempo indeterminato
begin
  //Se c'è passaggio da tempo indeterminato a tempo determinato sdoppio i record 'A' e 'B'
  if (dDataFineDet <> 0) and (dDataInizioIndet <> 0) then
  begin
    //Sposto i dati del flusso B su secondo periodo a tempo indeterminato
    //con progressivo_numero 2
    updP663.SetVariable('IdFLUPER',DatiInpFLUPER.ID_FLUPER);
    updP663.SetVariable('Progressivo',DatiInpFLUPER.Progressivo);
    updP663.SetVariable('Parte','B');
    updP663.Execute;
    selP663b.SetVariable('IdFLUPER',DatiInpFLUPER.ID_FLUPER);
    selP663b.SetVariable('Progressivo',DatiInpFLUPER.Progressivo);
    selP663b.SetVariable('DataElaborazione',DatiInpFLUPER.DataElaborazione);
    selP663b.Close;
    selP663b.Open;
    while not selP663b.Eof do
    begin
      //Inserisco record a zero per primo periodo
      insP663.SetVariable('IdFLUPER',selP663b.FieldByName('ID_FLUSSO').AsInteger);
      insP663.SetVariable('Progressivo',selP663b.FieldByName('PROGRESSIVO').AsInteger);
      insP663.SetVariable('Parte',selP663b.FieldByName('PARTE').AsString);
      insP663.SetVariable('Numero',selP663b.FieldByName('NUMERO').AsString);
      insP663.SetVariable('ProgressivoNumero',1);
      insP663.SetVariable('TipoRecord',selP663b.FieldByName('TIPO_RECORD').AsString);
      insP663.SetVariable('Valore',selP663b.FieldByName('VALORE').AsString);
      if selP663b.FieldByName('NUMERO').AsString >= '026' then
      begin
        if selP663b.FieldByName('NUMERICO').AsString = 'S' then
          insP663.SetVariable('Valore','0')
        else
          insP663.SetVariable('Valore','');
      end;
      insP663.Execute;
      selP663b.Next;
    end;
  end;
end;

procedure TP946FCalcoloFLUPERDtm.FormattaDato(sCodArrotondamento, sFormato, sParte, sNumero:String; var sDatoFLUPER:String);
//Formattazione del dato se numerico
begin
  if sCodArrotondamento <> '' then
  begin
    if (selP050.GetVariable('CodValuta') <> selP150.FieldByName('COD_VALUTA_BASE').AsString) or
       (selP050.GetVariable('CodArrotondamento') <> sCodArrotondamento) or
       (selP050.GetVariable('Decorrenza') <> DatiInpFLUPER.DataElaborazione) then
    begin
      selP050.SetVariable('CodValuta',selP150.FieldByName('COD_VALUTA_BASE').AsString);
      selP050.SetVariable('CodArrotondamento',sCodArrotondamento);
      selP050.SetVariable('Decorrenza',DatiInpFLUPER.DataElaborazione);
      selP050.Close;
      selP050.Open;
      if selP050.Eof then
      begin
        //Non esiste l'arrotondamento
        DatiOut.Blocca:=BloccaP946[5] + ' Parte=' + sParte;
        DatiOut.Blocca:=DatiOut.Blocca + ' Numero=' + sNumero;
        exit;
      end;
    end;
    //Arrotondamento
    if sDatoFLUPER <> '' then
      sDatoFLUPER:=FloatToStr(R180Arrotonda(StrToFloat(sDatoFLUPER),selP050.FieldByName('VALORE').AsFloat,selP050.FieldByName('TIPO').AsString));
  end;
  sDatoFLUPER:=R180FormattaNumero(sDatoFLUPER,sFormato);
end;

procedure TP946FCalcoloFLUPERDtm.InserimentoDati(Parte, Numero, Valore :String; ProgressivoNumero:Integer);
begin
  //Posizionamento sulle regole per determinare eventuale formattazione
  if selP660.FieldByName('NUMERICO').AsString = 'S' then
  begin
    FormattaDato(selP660.FieldByName('COD_ARROTONDAMENTO').AsString, selP660.FieldByName('FORMATO').AsString,
      selP660.FieldByName('PARTE').AsString, selP660.FieldByName('NUMERO').AsString, Valore);
    if DatiOut.Blocca <> '' then
      exit;
  end;
  //Record tipo automatico
  scrP663.SetVariable('IdFLUPER',DatiInpFLUPER.ID_FLUPER);
  scrP663.SetVariable('Progressivo',DatiInpFLUPER.Progressivo);
  scrP663.SetVariable('Parte',Parte);
  scrP663.SetVariable('Numero',Numero);
  scrP663.SetVariable('ProgressivoNumero',ProgressivoNumero);
  scrP663.SetVariable('Valore',Valore);
  scrP663.SetVariable('TipoRecord','A');
  scrP663.Execute;
  //Record tipo manuale
  scrP663.SetVariable('TipoRecord','M');
  scrP663.Execute;
end;

procedure TP946FCalcoloFLUPERDtm.DataModuleCreate(Sender: TObject);
begin
  inherited;
  R502ProDtM1:=TR502ProDtM1.Create(nil);
  R600DtM1:=TR600DtM1.Create(Self);
  R100FCreditiFormativiDtM:=TR100FCreditiFormativiDtM.Create(nil);
end;

procedure TP946FCalcoloFLUPERDtm.DataModuleDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(R502ProDtM1);
  FreeAndNil(R600DtM1);
  FreeAndNil(R100FCreditiFormativiDtM);
end;

end.

