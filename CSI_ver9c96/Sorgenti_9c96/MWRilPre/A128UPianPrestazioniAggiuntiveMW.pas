unit A128UPianPrestazioniAggiuntiveMW;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, OracleData, DB, Oracle, DBClient, Math, R005UDataModuleMW,
  A000UInterfaccia, A000UMessaggi;

type
  T128Dlg = procedure(msg,Chiave:String) of object;
  T128ClearKeys = procedure of object;
  T128AvanzamentoAcq = procedure(Matr:String;Riga:Integer) of object;

  TElencoDate = record
    Data:TDateTime;
    Colorata:Boolean;
  end;

  TMappa = record
    Pos:Integer;
    Lun:Integer;
  end;

  TA128FPianPrestazioniAggiuntiveMW = class(TR005FDataModuleMW)
    selT030: TOracleDataSet;
    Q330: TOracleDataSet;
    Q330CODICE: TStringField;
    Q330DESCRIZIONE: TStringField;
    Q330ORAINIZIO: TDateTimeField;
    Q330ORAFINE: TDateTimeField;
    Q330CONTROLLO_PT: TStringField;
    D330: TDataSource;
    selaT332: TOracleDataSet;
    Q430Contratto: TOracleDataSet;
    insT332: TOracleQuery;
    updT332: TOracleQuery;
    delT332: TOracleQuery;
    cdsParametri: TClientDataSet;
    cdsParametriTurno1: TStringField;
    cdsParametriTurno2: TStringField;
    dsrParametri: TDataSource;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    GiornoGriglia: TDateTime;
  public
    selT332: TOracleDataSet;
    Filtro,Dipendente:string;
    //sConfermaInserimento:string;
    ProceduraChiamante,IMax:Integer;
    Turno1Value,Turno2Value:Variant;
    DataInizio,DataFine: TDateTime;
    ListaGiorniSel:TStringList;
    ElencoDate:array [1..31] of TElencoDate;
    Mappa:array [1..5] of TMappa;
    evtAvanzamentoAcq:T128AvanzamentoAcq;
    evtRichiesta:T128Dlg;
   //evtRichiestaInserimento:T128Dlg;
    evtClearKeys:T128ClearKeys;
    nNumRiga,nTotRighe:integer;
    FIn: TextFile;
    procedure AfterPost;
    procedure BeforeInsert;
    procedure BeforePost;
    procedure NewRecord;
    procedure ValidaData;
    procedure ImpostaTestoTurno(Sender: TField; const Text: String);
    procedure ValidaTurno(Sender: TField);
    procedure CercaContratto(Prog: Integer; DataRif: TDateTime);
    procedure RefreshSelT332;
    procedure CaricaElencoDate;
    procedure ImpostaFiltro(Testo: String);
    procedure ImpostaCampiLookup;
    function GetHint: String;
    procedure InserisciGestioneMensile;
    procedure CancellaGestioneMensile;
    procedure Controlli(Modo: String);
    procedure PulisciVariabili;
    procedure ControlloParametriFile;
    procedure ApriFile(NomeFile: String);
    procedure RecuperaTotaleRigheFile;
    procedure InserisciPrestAgg(DIniAcq,DFinAcq:TDateTime);
  end;

implementation

{$R *.dfm}

procedure TA128FPianPrestazioniAggiuntiveMW.DataModuleCreate(Sender: TObject);
begin
  inherited;
  selT030.Open;
  Q330.Open;
  cdsParametri.CreateDataSet;
  ListaGiorniSel:=TStringList.Create;
  PulisciVariabili;
end;

procedure TA128FPianPrestazioniAggiuntiveMW.DataModuleDestroy(Sender: TObject);
begin
  inherited;
  ListaGiorniSel.Free;
end;

procedure TA128FPianPrestazioniAggiuntiveMW.AfterPost;
var RowID:String;
begin
  RowID:=selT332.RowID;
  selT332.Refresh;
  selT332.SearchRecord('ROWID',RowID,[srFromBeginning]);
  CaricaElencoDate;
end;

procedure TA128FPianPrestazioniAggiuntiveMW.BeforeInsert;
begin
  if SelAnagrafe.RecordCount = 0 then
    raise exception.Create(A000MSG_ERR_NO_DIP)
  else
    GiornoGriglia:=selT332.FieldByName('DATA').AsDateTime;
end;

procedure TA128FPianPrestazioniAggiuntiveMW.BeforePost;
begin
  ProceduraChiamante:=0;//BeforePost
  selT332.FieldByName('TURNO1').AsString:=Trim(selT332.FieldByName('TURNO1').AsString);
  selT332.FieldByName('TURNO2').AsString:=Trim(selT332.FieldByName('TURNO2').AsString);
  if selT332.FieldByName('TURNO1').AsString = selT332.FieldByName('TURNO2').AsString then
    raise Exception.Create(A000MSG_A128_ERR_TURNO_RIPETUTO);
  if QueryPK1.EsisteChiave('T332_PIAN_ATT_AGGIUNTIVE',selT332.RowId,selT332.State,['PROGRESSIVO','DATA'],[selT332.FieldByName('Progressivo').AsString,selT332.FieldByName('Data').AsString]) then
    raise Exception.Create(A000MSG_A128_ERR_ESISTE_PIANIFICAZIONE);
  CercaContratto(SelAnagrafe.FieldByName('Progressivo').AsInteger,DataFine);
  if (Q430Contratto.FieldByName('PERCPT').AsFloat <> 100)
  and (   (VarToStr(Q330.Lookup('CODICE',selT332.FieldByName('TURNO1').AsString,'CONTROLLO_PT')) = 'S')
       or (VarToStr(Q330.Lookup('CODICE',selT332.FieldByName('TURNO2').AsString,'CONTROLLO_PT')) = 'S')) then
    if Assigned(evtRichiesta) then
      evtRichiesta(A000MSG_A128_DLG_TURNO_NO_PARTTIME,IntToStr(IMax) + 'ConfermaInserimento');
end;

procedure TA128FPianPrestazioniAggiuntiveMW.NewRecord;
begin
  selT332.FieldByName('DATA').AsDateTime:=Max(GiornoGriglia,DataInizio);
  selT332.FieldByName('PROGRESSIVO').AsInteger:=SelAnagrafe.FieldByName('Progressivo').AsInteger;
end;

procedure TA128FPianPrestazioniAggiuntiveMW.ValidaData;
begin
  if (selT332.FieldByName('DATA').AsDateTime < DataInizio) or
     (selT332.FieldByName('DATA').AsDateTime > DataFine) then
    raise Exception.Create(A000MSG_A128_ERR_DATA_ESTERNA_MESE);
end;

procedure TA128FPianPrestazioniAggiuntiveMW.ImpostaTestoTurno(Sender:TField;const Text:String);
begin
  Sender.AsString:=Trim(Copy(Text,1,5));
end;

procedure TA128FPianPrestazioniAggiuntiveMW.ValidaTurno(Sender: TField);
begin
  if Sender.AsString <> '' then
    if VarToStr(Q330.Lookup('CODICE',Sender.AsString,'CODICE')) = '' then
      raise Exception.Create(Format(A000MSG_A128_ERR_FMT_COD_NON_VALIDO,[Sender.DisplayLabel]));
end;

procedure TA128FPianPrestazioniAggiuntiveMW.CercaContratto(Prog:Integer;DataRif:TDateTime);
begin
  with Q430Contratto do
  begin
    Close;
    SetVariable('Progressivo',Prog);
    SetVariable('Data',DataRif);
    Open;
  end;
end;

procedure TA128FPianPrestazioniAggiuntiveMW.RefreshSelT332;
begin
  with selT332 do
  begin
    Close;
    SetVariable('DATADA',DataInizio);
    SetVariable('DATAA',DataFine);
    SetVariable('FILTRO',Filtro);
    Open;
  end;
  CaricaElencoDate;
end;

procedure TA128FPianPrestazioniAggiuntiveMW.CaricaElencoDate;
var i:integer;
    Puntatore:TBookmark;
begin
  for i:=1 to 31 do
  begin
    ElencoDate[i].Data:=StrToDateTime('01/01/1900');
    ElencoDate[i].Colorata:=False;
  end;
  i:=1;
  with selT332 do
  begin
    Puntatore:=GetBookmark;
	try { TODO : TEST IW 15 }
      First;
      ElencoDate[i].Data:=FieldByName('DATA').AsDateTime;
      inc(i);
      while not Eof do
      begin
        if ElencoDate[i - 1].Data <> FieldByName('DATA').AsDateTime then
        begin
          ElencoDate[i].Data:=FieldByName('DATA').AsDateTime;
          ElencoDate[i].Colorata:=not ElencoDate[i - 1].Colorata;
          inc(i);
        end;
        Next;
      end;
      GotoBookmark(Puntatore);
	finally
      FreeBookmark(Puntatore);
	end;
  end;
end;

procedure TA128FPianPrestazioniAggiuntiveMW.ImpostaFiltro(Testo:String);
begin
  Filtro:='';
  if (Testo <> '') and (Pos('ORDER BY',Testo) <> 1) then
    if Pos('ORDER BY',Testo) > 0 then
      Filtro:=' AND ' + StringReplace(Copy(Testo,Pos('WHERE ',Testo) + 6,Pos('ORDER BY', Testo) - (Pos('WHERE ',Testo) + 6)),':DataLavoro','T332.DATA',[rfIgnoreCase,rfReplaceAll])
    else
      Filtro:=' AND ' + StringReplace(Copy(Testo,Pos('WHERE ',Testo) + 6,Length(Testo) - (Pos('WHERE ',Testo) + 6)),':DataLavoro','T332.DATA',[rfIgnoreCase,rfReplaceAll]);
  if Filtro = ' AND ' then
    Filtro:='';
end;

procedure TA128FPianPrestazioniAggiuntiveMW.ImpostaCampiLookup;
begin
  selT332.FieldByName('D_MATRICOLA').FieldKind:=fkLookup;
  selT332.FieldByName('D_MATRICOLA').LookupDataSet:=SelAnagrafe;
  selT332.FieldByName('D_MATRICOLA').LookupKeyFields:='PROGRESSIVO';
  selT332.FieldByName('D_MATRICOLA').LookupResultField:='MATRICOLA';
  selT332.FieldByName('D_MATRICOLA').KeyFields:='PROGRESSIVO';
  selT332.FieldByName('D_BADGE').FieldKind:=fkLookup;
  selT332.FieldByName('D_BADGE').LookupDataSet:=SelAnagrafe;
  selT332.FieldByName('D_BADGE').LookupKeyFields:='PROGRESSIVO';
  selT332.FieldByName('D_BADGE').LookupResultField:='T430BADGE';
  selT332.FieldByName('D_BADGE').KeyFields:='PROGRESSIVO';
  selT332.FieldByName('D_NOMINATIVO').FieldKind:=fkLookup;
  selT332.FieldByName('D_NOMINATIVO').LookupDataSet:=SelAnagrafe;
  selT332.FieldByName('D_NOMINATIVO').LookupKeyFields:='PROGRESSIVO';
  selT332.FieldByName('D_NOMINATIVO').LookupResultField:='NOMINATIVO';
  selT332.FieldByName('D_NOMINATIVO').KeyFields:='PROGRESSIVO';
end;

function TA128FPianPrestazioniAggiuntiveMW.GetHint:String;
var DescT1,DescT2: String;
  function GetDescrizioneTurno(const CodTurno : String):String;
  begin
    Result:='';
    if Q330.Locate('CODICE',CodTurno,[loCaseInsensitive]) then
      Result:=Q330.FieldByName('DESCRIZIONE').AsString + ': ' +
        FormatDateTime('hh.mm',Q330.FieldByName('OraInizio').AsDateTime) + '-' +
        FormatDateTime('hh.mm',Q330.FieldByName('OraFine').AsDateTime);
  end;
begin
  Result:=selT332.FieldByName('D_NOMINATIVO').AsString;
  DescT1:=GetDescrizioneTurno(selT332.FieldByName('Turno1').AsString);
  if DescT1 <> '' then
    Result:=Result + #13#10 + selT332.FieldByName('Turno1').AsString + ': ' + DescT1;
  DescT2:=GetDescrizioneTurno(selT332.FieldByName('Turno2').AsString);
  if DescT2 <> '' then
    Result:=Result + #13#10 + selT332.FieldByName('Turno2').AsString + ': ' + DescT2;
end;

procedure TA128FPianPrestazioniAggiuntiveMW.InserisciGestioneMensile;
var C1,C2:String;
    i:Integer;
    DataRif:TDateTime;
  procedure SettaQuery(Data:TDateTime);
  begin
    (*Spostato nei controlli preliminari, dato che il part time viene estratto solo a fine mese
    if (Q430Contratto.FieldByName('PERCPT').AsFloat <> 100)
    and (   (VarToStr(Q330.Lookup('CODICE',Turno1Value,'CONTROLLO_PT')) = 'S')
         or (VarToStr(Q330.Lookup('CODICE',Turno2Value,'CONTROLLO_PT')) = 'S')) then
    begin
      if sConfermaInserimento = '' then
        if Assigned(evtRichiestaInserimento) then
          evtRichiestaInserimento('Confermi la pianificazione di un turno incompatibile con dipendente part-time?',IntToStr(IMax) + 'ConfermaInserimento');
      if sConfermaInserimento = 'N' then
        exit;
    end;*)
    insT332.SetVariable('Progressivo',SelAnagrafe.FieldByName('Progressivo').AsInteger);
    insT332.SetVariable('Data',Data);
    insT332.SetVariable('Turno1',C1);
    insT332.SetVariable('Turno2',C2);
    try
      insT332.Execute;
      RegistraLog.SettaProprieta('I','T332_PIAN_ATT_AGGIUNTIVE',NomeOwner,nil,True);
      RegistraLog.InserisciDato('PROGRESSIVO','',VarToStr(insT332.GetVariable('Progressivo')));
      RegistraLog.InserisciDato('DATA','',VarToStr(insT332.GetVariable('Data')));
      RegistraLog.InserisciDato('TURNO1','',VarToStr(insT332.GetVariable('Turno1')));
      if C2 <> '' then
        RegistraLog.InserisciDato('TURNO2','',VarToStr(insT332.GetVariable('Turno2')));
      RegistraLog.RegistraOperazione;
      SessioneOracle.Commit;
    except
    end;
  end;
begin
  ProceduraChiamante:=1;//InserisciGestioneMensile
  Controlli('I');
  if IMax = 0 then
    if (Q430Contratto.FieldByName('PERCPT').AsFloat <> 100)
    and (   (VarToStr(Q330.Lookup('CODICE',Turno1Value,'CONTROLLO_PT')) = 'S')
         or (VarToStr(Q330.Lookup('CODICE',Turno2Value,'CONTROLLO_PT')) = 'S')) then
      if Assigned(evtRichiesta) then
        evtRichiesta(A000MSG_A128_DLG_TURNO_NO_PARTTIME,IntToStr(IMax) + 'ConfermaInserimento');
  C1:=Turno1Value;
  if Turno2Value <> null then
    C2:=Turno2Value
  else
    C2:='';
  for i:=0 to ListaGiorniSel.Count - 1 do
  begin
    if i < IMax then
      Continue;
    IMax:=i;
    DataRif:=StrToDate(Copy(ListaGiorniSel[i],5,10));
    if QueryPK1.EsisteChiave('T332_PIAN_ATT_AGGIUNTIVE',selT332.RowId,selT332.State,['PROGRESSIVO','DATA'],[SelAnagrafe.FieldByName('Progressivo').AsString,DateToStr(DataRif)]) then
    begin
      PulisciVariabili;
      raise Exception.Create(A000MSG_A128_ERR_ESISTE_PIANIFICAZIONE);
    end;
    SettaQuery(DataRif);
    //sConfermaInserimento:='';
  end;
  PulisciVariabili;
end;

procedure TA128FPianPrestazioniAggiuntiveMW.CancellaGestioneMensile;
var i:Integer;
    Where:String;
    Aggiorna:Boolean;
begin
  ProceduraChiamante:=2;//CancellaGestioneMensile
  Controlli('E');
  if IMax = 0 then
    if Assigned(evtRichiesta) then
      evtRichiesta(A000MSG_DLG_CANCELLAZIONE_MASSIVA,IntToStr(IMax) + 'ConfermaCancellazione');
  Where:='';
  if VarToStr(Turno1Value) <> '' then
    Where:=' AND TURNO1 = ''' + VarToStr(Turno1Value) + '''';
  if VarToStr(Turno2Value) <> '' then
    Where:=Where + ' AND TURNO2 = ''' + VarToStr(Turno2Value)  + '''';
  Aggiorna:=False;
  for i:=0 to ListaGiorniSel.Count - 1 do
  begin
    if i < IMax then
      Continue;
    IMax:=i;
    delT332.SetVariable('PROGRESSIVO',SelAnagrafe.FieldByName('Progressivo').AsString);
    delT332.SetVariable('DATA',StrToDate(Copy(ListaGiorniSel[i],5,10)));
    delT332.SetVariable('WHERE',Where);
    delT332.Execute;
    if delT332.RowsProcessed > 0 then
    begin
      RegistraLog.SettaProprieta('C','T332_PIAN_ATT_AGGIUNTIVE',NomeOwner,nil,True);
      RegistraLog.InserisciDato('PROGRESSIVO','',VarToStr(delT332.GetVariable('Progressivo')));
      RegistraLog.InserisciDato('DATA','',VarToStr(delT332.GetVariable('Data')));
      if VarToStr(Turno1Value) <> '' then
        RegistraLog.InserisciDato('TURNO1','',VarToStr(Turno1Value));
      if VarToStr(Turno2Value) <> '' then
        RegistraLog.InserisciDato('TURNO2','',VarToStr(Turno2Value));
      RegistraLog.RegistraOperazione;
      Aggiorna:=True;
    end;
  end;
  if Aggiorna then
  begin
    SessioneOracle.Commit;
    RefreshSelT332;
  end;
  PulisciVariabili;
end;

procedure TA128FPianPrestazioniAggiuntiveMW.Controlli(Modo:String);
begin
  if Trim(Dipendente) = '' then
    raise Exception.Create(A000MSG_ERR_NO_DIP);
  if ListaGiorniSel.Count <= 0 then
    raise Exception.Create(A000MSG_ERR_NO_LISTA_GIORNI);
  if Modo = 'I' then
  begin
    if (Turno1Value = '') or (Turno1Value = null) then
      raise Exception.Create(A000MSG_A128_ERR_NO_TURNO_1)
    else if Turno1Value = Turno2Value then
      raise Exception.Create(A000MSG_A128_ERR_TURNO_RIPETUTO);
  end;
end;

procedure TA128FPianPrestazioniAggiuntiveMW.PulisciVariabili;
begin
  IMax:=0;
  if Assigned(evtClearKeys) then
    evtClearKeys;
end;

procedure TA128FPianPrestazioniAggiuntiveMW.ControlloParametriFile;
var c: Integer;
begin
  for c:=1 to 5 do
    if (Mappa[c].Pos = 0) or (Mappa[c].Lun = 0) then
      raise Exception.Create(Format(A000MSG_A128_ERR_FMT_DATO_ERRATO,[IntToStr(c)]));
  for c:=2 to 5 do
    if Mappa[c].Pos < (Mappa[c - 1].Pos + Mappa[c - 1].Lun) then
      raise Exception.Create(Format(A000MSG_A128_ERR_FMT_POSIZIONE_ERRATA,[IntToStr(c)]));
end;

procedure TA128FPianPrestazioniAggiuntiveMW.ApriFile(NomeFile:String);
begin
  try
    AssignFile(FIn, NomeFile);
    Reset(FIn);
  except
    raise Exception.Create(Format(A000MSG_ERR_FMT_APRI_FILE,[NomeFile]));
  end;
end;

procedure TA128FPianPrestazioniAggiuntiveMW.RecuperaTotaleRigheFile;
var sRigaIn: String;
begin
  nTotRighe:=0;
  while not Eof(FIn) do
  begin
    Readln(FIn,sRigaIn);
    nTotRighe:=nTotRighe + 1;
  end;
  CloseFile(FIn);
end;

procedure TA128FPianPrestazioniAggiuntiveMW.InserisciPrestAgg(DIniAcq,DFinAcq:TDateTime);
var
  sRigaIn, sMatricola, sGiorno, sMese, sAnno, sTurno, sTurno1, sTurno2: String;
  dDataTurno:TDateTime;
  nProgressivo:integer;
begin
  nNumRiga:=nNumRiga + 1;
  Readln(FIn,sRigaIn);
  if sRigaIn <> '' then
  begin
    //Matricola: testo che non sia nulla
    sMatricola:=Trim(Copy(sRigaIn, Mappa[1].Pos, Mappa[1].Lun));
    if sMatricola = '' then
    begin
      //Si tratta di anomalia e la aggiungo alle liste delle anomalie
      RegistraMsg.InserisciMessaggio('A',Format(A000MSG_A128_ERR_FMT_ACQ_NO_MATRICOLA,[inttostr(nNumRiga),sRigaIn]));
      exit;
    end;
    if Assigned(evtAvanzamentoAcq) then
      evtAvanzamentoAcq(sMatricola,nNumRiga);

    //Giorno
    sGiorno:=Trim(Copy(sRigaIn, Mappa[2].Pos, Mappa[2].Lun));
    //Mese
    sMese:=Trim(Copy(sRigaIn, Mappa[3].Pos, Mappa[3].Lun));
    //Anno
    sAnno:=Trim(Copy(sRigaIn, Mappa[4].Pos, Mappa[4].Lun));
    if Mappa[4].Lun = 2 then
      sAnno:='20'+sAnno;
    if (sGiorno <> '') and (sMese <> '') and (sAnno <> '') then
    begin
      try
        dDataTurno:=EncodeDate(strtoint(sAnno),strtoint(sMese),strtoint(sGiorno));
      except
        //Si tratta di anomalia e la aggiungo alle liste delle anomalie
        RegistraMsg.InserisciMessaggio('A',Format(A000MSG_A128_ERR_FMT_ACQ_NO_FMT_DATA,[inttostr(nNumRiga),sRigaIn]));
        exit;
      end;
    end
    else
    begin
      //Si tratta di anomalia e la aggiungo alle liste delle anomalie
      RegistraMsg.InserisciMessaggio('A',Format(A000MSG_A128_ERR_FMT_ACQ_DATA_INCOMPLETA,[inttostr(nNumRiga),sRigaIn]));
      exit;
    end;
    if (dDataTurno < DIniAcq) or (dDataTurno > DFinAcq) then
    begin
      //Si tratta di anomalia e la aggiungo alle liste delle anomalie
      RegistraMsg.InserisciMessaggio('A',Format(A000MSG_A128_ERR_FMT_ACQ_DATA_ESTERNA,[inttostr(nNumRiga),sRigaIn,FormatDateTime('dd/mm/yyyy',dDataTurno)]));
      exit;
    end;
    //Turno
    sTurno:=Trim(Copy(sRigaIn, Mappa[5].Pos, Mappa[5].Lun));
    if sTurno = '' then
    begin
      //Si tratta di un anomalia e la aggiungo alle liste delle anomalie
      RegistraMsg.InserisciMessaggio('A',Format(A000MSG_A128_ERR_FMT_ACQ_NO_TURNO,[inttostr(nNumRiga),sRigaIn]));
      exit;
    end
    else
    begin
      if not Q330.SearchRecord('CODICE',sTurno,[srFromBeginning]) then
      begin
        //Si tratta di un anomalia e la aggiungo alle liste delle anomalie
        RegistraMsg.InserisciMessaggio('A',Format(A000MSG_A128_ERR_FMT_ACQ_TURNO_INESISTENTE,[inttostr(nNumRiga),sRigaIn,sTurno]));
        exit;
      end;
    end;

    //Leggo il progressivo associato alla matricola
    if selT030.SearchRecord('MATRICOLA',sMatricola,[srFromBeginning]) then
    begin
      nProgressivo:=selT030.FieldByName('PROGRESSIVO').asInteger;
      //Verifico se controllare incompatibilità con part-time.
      if Q330.FieldByName('CONTROLLO_PT').AsString = 'S' then
      begin
        CercaContratto(nProgressivo,dDataTurno);
        if Q430Contratto.FieldByName('PERCPT').AsFloat <> 100 then
          //Si tratta di anomalia non bloccante la aggiungo alla lista delle anomalie, ma viene comunque inserito il turno
          RegistraMsg.InserisciMessaggio('A',Format(A000MSG_A128_ERR_FMT_ACQ_DIP_PARTTIME,[inttostr(nNumRiga),sRigaIn,sMatricola]),'',nProgressivo);
      end;
    end
    else
    begin
      //Si tratta di anomalia e la aggiungo alle liste delle anomalie
      RegistraMsg.InserisciMessaggio('A',Format(A000MSG_A128_ERR_FMT_ACQ_MATR_INESISTENTE,[inttostr(nNumRiga),sRigaIn,sMatricola]));
      exit;
    end;
    sTurno1:='';
    sTurno2:='';
    selaT332.Close;
    selaT332.SetVariable('DATA',dDataTurno);
    selaT332.SetVariable('PROGRESSIVO',nProgressivo);
    selaT332.Open;
    if selaT332.Eof then
      sTurno1:=sTurno
    else
    begin
      if (selaT332.FieldByName('TURNO1').AsString = sTurno) or (selaT332.FieldByName('TURNO2').AsString = sTurno) then
      begin
        //Si tratta di anomalia e la aggiungo alle liste delle anomalie
        RegistraMsg.InserisciMessaggio('A',Format(A000MSG_A128_ERR_FMT_ACQ_TURNO_PIANIFICATO,[inttostr(nNumRiga),sRigaIn,sMatricola,sTurno,FormatDateTime('dd/mm/yyyy',dDataTurno)]),'',nProgressivo);
        exit;
      end
      else if selaT332.FieldByName('TURNO1').AsString = '' then
        sTurno1:=sTurno
      else if selaT332.FieldByName('TURNO2').AsString = '' then
        sTurno2:=sTurno
      else
      begin
        //Si tratta di anomalia e la aggiungo alle liste delle anomalie
        RegistraMsg.InserisciMessaggio('A',Format(A000MSG_A128_ERR_FMT_ACQ_TROPPI_TURNI,[inttostr(nNumRiga),sRigaIn,sMatricola,FormatDateTime('dd/mm/yyyy',dDataTurno)]),'',nProgressivo);
        exit;
      end;
    end;
    if sTurno2 = '' then
    begin
      //Inserimento del record con turno1
      insT332.SetVariable('Progressivo',nProgressivo);
      insT332.SetVariable('Data',dDataTurno);
      insT332.SetVariable('Turno1',sTurno1);
      insT332.SetVariable('Turno2',sTurno2);
      try
        insT332.Execute;
        RegistraLog.SettaProprieta('I','T332_PIAN_ATT_AGGIUNTIVE',NomeOwner,nil,True);
        RegistraLog.InserisciDato('PROGRESSIVO','',VarToStr(insT332.GetVariable('Progressivo')));
        RegistraLog.InserisciDato('DATA','',VarToStr(insT332.GetVariable('Data')));
        RegistraLog.InserisciDato('TURNO1','',VarToStr(insT332.GetVariable('Turno1')));
        RegistraLog.RegistraOperazione;
        SessioneOracle.Commit;
      except
      end;
    end
    else
    begin
      //Aggiornamento del record con aggiunta del turno2
      updT332.SetVariable('Progressivo',nProgressivo);
      updT332.SetVariable('Data',dDataTurno);
      updT332.SetVariable('Turno2',sTurno2);
      try
        updT332.Execute;
        RegistraLog.SettaProprieta('M','T332_PIAN_ATT_AGGIUNTIVE',NomeOwner,nil,True);
        RegistraLog.InserisciDato('','PROGRESSIVO',VarToStr(insT332.GetVariable('Progressivo')));
        RegistraLog.InserisciDato('','DATA',VarToStr(insT332.GetVariable('Data')));
        RegistraLog.InserisciDato('TURNO2','',VarToStr(insT332.GetVariable('Turno2')));
        RegistraLog.RegistraOperazione;
        SessioneOracle.Commit;
      except
      end;
    end;
  end;
end;

end.
