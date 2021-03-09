unit A111UParMessaggiMW;

interface

uses
  System.SysUtils, System.Classes, R005UDataModuleMW, USelI010, OracleData,
  Oracle, Data.DB, Datasnap.DBClient, C180FunzioniGenerali, A000UCostanti, A000UInterfaccia, A000UMessaggi;

type
  TAssegnaPickList = procedure(Tipo:String) of object;

  TControlliGriglia = record
    VNumRec:Integer;
    VInizio:Integer;
    VFine:Integer;
    VLunghezza:Integer;
    VTipoRec:String;
    VTipo:String;
    VNome:String;
    VDefault:String;
    VFormato:String;
  end;

  TA111FParMessaggiMW = class(TR005FDataModuleMW)
    delT292: TOracleQuery;
    updT292: TOracleQuery;
    SelDual: TOracleDataSet;
    selT265T275: TOracleDataSet;
    selC292: TClientDataSet;
    dsrC292: TDataSource;
    selT002: TOracleDataSet;
    dsrT002: TDataSource;
    selT003: TOracleDataSet;
    dsrT003: TDataSource;
    selT292: TOracleDataSet;
    selT292CODICE: TStringField;
    selT292TIPO_RECORD: TStringField;
    selT292NUMERO_RECORD: TFloatField;
    selT292TIPO: TStringField;
    selT292POSIZIONE: TFloatField;
    selT292LUNGHEZZA: TFloatField;
    selT292NOME_COLONNA: TStringField;
    selT292FORMATO: TStringField;
    selT292VALORE_DEFAULT: TStringField;
    selT292CODICE_DATO: TStringField;
    selT292CHIAVE: TStringField;
    dsrT292: TDataSource;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
    procedure AfterScroll;
    procedure AfterPostStep1;
    procedure AfterPostStep2;
    procedure AfterEdit(Codice:String);
    procedure AfterInsert(Codice:String);
    procedure OnNewRecord;
    procedure BeforeDelete;
    procedure AfterCancel;
    procedure BeforePost;
    procedure BeforeCancel;
    procedure AfterDelete;
    procedure CodiceChange;
    procedure selT292AfterScroll(DataSet: TDataSet);
    procedure selT292BeforePost(DataSet: TDataSet);
    procedure selT292NewRecord(DataSet: TDataSet);
    procedure selT292TIPO_RECORDValidate(Sender: TField);
    procedure selT292TIPOValidate(Sender: TField);
    procedure selT292POSIZIONEValidate(Sender: TField);
    procedure selT292LUNGHEZZAValidate(Sender: TField);
    procedure selT292NOME_COLONNAValidate(Sender: TField);
    procedure selT292VALORE_DEFAULTValidate(Sender: TField);
    procedure selT292FORMATOValidate(Sender: TField);
  private
    { Private declarations }
    CodiceVecchio:string;
    DF,DV:Boolean;
    ListaMessaggi:TStringList;
    procedure CaricaPickList;
    function ControllaParametriGriglia:Boolean;
    procedure ControllaFiltroAnagr;
    procedure CaricaTabellaTemp;
    procedure Controlli(var MaxFineDF,NumRecDF,NumRecIN,NumRecDV:Integer; var ControlliGriglia:array of TControlliGriglia;
                        var ListaNomiColonneDF,ListaNomiColonneDV:TStringList);
    procedure ControllaDettaglio;
  public
    { Public declarations }
    selT291:TOracleDataSet;
    selI010:TselI010;
    PLTipoRecord,PLTipo,PLChiave,PLFormatoData,PLFormatoVal,PLFormatoDesc,
    PLDefaultFill,PLDefaultVal,PLDefaultDesc,PLDefaultAnag,PLCodDato:TStringList;
    AssegnaPickList: TAssegnaPickList;
  end;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure TA111FParMessaggiMW.DataModuleCreate(Sender: TObject);
begin
  inherited;
  ListaMessaggi:=TStringList.Create;
  selI010:=TselI010.Create(Self);
  selI010.Apri(SessioneOracle,'',Parametri.Applicazione,'NOME_CAMPO','','TABLE_NAME,COLUMN_ID');
  selT265T275.Open;
  CaricaPickList;
  selT002.Open;
  selT003.Open;
end;

procedure TA111FParMessaggiMW.DataModuleDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(selI010);
  FreeAndNil(ListaMessaggi);
  FreeAndNil(PLTipoRecord);
  FreeAndNil(PLTipo);
  FreeAndNil(PLChiave);
  FreeAndNil(PLDefaultFill);
  FreeAndNil(PLDefaultVal);
  FreeAndNil(PLDefaultDesc);
  FreeAndNil(PLDefaultAnag);
  FreeAndNil(PLFormatoData);
  FreeAndNil(PLFormatoVal);
  FreeAndNil(PLFormatoDesc);
  FreeAndNil(PLCodDato);
end;

procedure TA111FParMessaggiMW.CaricaPickList;
begin
  inherited;
  //Tipo Record
  PLTipoRecord:=TStringList.Create;
  PLTipoRecord.Add('IN');
  PLTipoRecord.Add('DF');
  PLTipoRecord.Add('DV');
  //Tipo
  PLTipo:=TStringList.Create;
  PLTipo.Add('AN DATO ANAGRAFICO');
  PLTipo.Add('BA BADGE');
  PLTipo.Add('DE DESCRIZIONE');
  PLTipo.Add('DC DATA CONSUNTIVO');
  PLTipo.Add('DT DATA MESSAGGIO');
  PLTipo.Add('DS DATA SCADENZA');
  PLTipo.Add('FI FILLER');
  PLTipo.Add('IN INDIRIZZO OROLOGIO');
  PLTipo.Add('NR NUMERO RIPETIZIONI');
  PLTipo.Add('PT POSTAZIONE OROLOGIO');
  PLTipo.Add('VL VALORE');
  //Chiave
  PLChiave:=TStringList.Create;
  PLChiave.Add('S');
  PLChiave.Add('N');
  //Default filler
  PLDefaultFill:=TStringList.Create;
  PLDefaultFill.Add('AGGMESSBAD');
  PLDefaultFill.Add('CANCMSGBAD');
  PLDefaultFill.Add('CANCTABMSG');
  //Default valore: da tenere allineata sul A112MW
  PLDefaultVal:=TStringList.Create;
  PLDefaultVal.Add('ASS_COMPPREC');
  PLDefaultVal.Add('ASS_COMPCORR');
  PLDefaultVal.Add('ASS_COMPTOT');
  PLDefaultVal.Add('ASS_FRUITOPREC');
  PLDefaultVal.Add('ASS_FRUITOCORR');
  PLDefaultVal.Add('ASS_FRUITOTOT');
  PLDefaultVal.Add('ASS_RESIDUOPREC');
  PLDefaultVal.Add('ASS_RESIDUOCORR');
  PLDefaultVal.Add('ASS_RESIDUOTOT');
  PLDefaultVal.Add('ASS_GG_RESIDUOPREC');
  PLDefaultVal.Add('ASS_GG_RESIDUOCORR');
  PLDefaultVal.Add('ASS_GG_RESIDUOTOT');
  PLDefaultVal.Add('PRES_RESO_MESE');
  PLDefaultVal.Add('PRES_RESIDUO');
  PLDefaultVal.Add('SALDOMMCOR');
  PLDefaultVal.Add('SALDOAACORR');
  PLDefaultVal.Add('SALDOAAPREC');
  PLDefaultVal.Add('SALDOTOT');
  PLDefaultVal.Add('SALDOTOTNEG');
  PLDefaultVal.Add('RECUPERO_MOBILE');
  PLDefaultVal.Add('BANCAORE_RESIDUA');
  PLDefaultVal.Add('DEBITO_CREDITO');
  PLDefaultVal.Add('DATI_GG_ORARIO');
  PLDefaultVal.Add('DATI_GG_ANOMALIA1');
  PLDefaultVal.Add('DATI_GG_DEBITO');
  PLDefaultVal.Add('DATI_GG_HHPRESENZA');
  PLDefaultVal.Add('DATI_GG_HHASSENZA');
  PLDefaultVal.Add('DATI_GG_SCOST');
  PLDefaultVal.Add('DATI_GG_SCOSTNEG');
  PLDefaultVal.Add('DATI_GG_RIEPASS');
  PLDefaultVal.Add('DATI_GG_RIEPPRES');
  //Default descrizione
  PLDefaultDesc:=TStringList.Create;
  PLDefaultDesc.Add('COMP.ASS.PREC');
  PLDefaultDesc.Add('COMP.ASS.CORR');
  PLDefaultDesc.Add('COMP.ASS.TOTALI');
  PLDefaultDesc.Add('ASS.RESIDUE');
  PLDefaultDesc.Add('ASS.FRUITE PREC');
  PLDefaultDesc.Add('ASS.FRUITE CORR');
  PLDefaultDesc.Add('ASS.FRUITE TOTALI');
  PLDefaultDesc.Add('SALDO MESE CORR');
  PLDefaultDesc.Add('SALDO ANNO CORRENTE');
  PLDefaultDesc.Add('SALDO ANNO PRECEDENTE');
  PLDefaultDesc.Add('SALDO TOT. COMPLESSIVO');
  PLDefaultDesc.Add('SALDO TOTALE NEGATIVO');
  //Default dato anagrafico
  PLDefaultAnag:=TStringList.Create;
  selI010.First;
  while not selI010.Eof do
  begin
    PLDefaultAnag.Add(selI010.FieldByName('NOME_CAMPO').AsString);
    selI010.Next;
  end;
  //Formato data
  PLFormatoData:=TStringList.Create;
  PLFormatoData.Add('ddmmyy');
  PLFormatoData.Add('yymmdd');
  PLFormatoData.Add('mmyy');
  PLFormatoData.Add('yymm');
  PLFormatoData.Add('ddmm');
  PLFormatoData.Add('mmdd');
  PLFormatoData.Add('mmyyyy');
  PLFormatoData.Add('yyyymm');
  PLFormatoData.Add('01mmyy');
  PLFormatoData.Add('31mmyy');
  PLFormatoData.Add('yymm01');
  PLFormatoData.Add('yymm31');
  PLFormatoData.Add('yy');
  PLFormatoData.Add('yyyy');
  PLFormatoData.Add('mm');
  PLFormatoData.Add('mmm');
  PLFormatoData.Add('mmmm');
  PLFormatoData.Add('dd');
  PLFormatoData.Add('ddd dd');
  PLFormatoData.Add('dddd dd');
  PLFormatoData.Add('ddd,dd');
  PLFormatoData.Add('dddd,dd');
  PLFormatoData.Add('hhmm');
  PLFormatoData.Add('hh');
  //Formato valore
  PLFormatoVal:=TStringList.Create;
  PLFormatoVal.Add('SX,S=-#,A=C,D=2,M=S');
  PLFormatoVal.Add('XS,S=10,A=D,D=0,M=N');
  //Formato descrizione
  PLFormatoDesc:=TStringList.Create;
  PLFormatoDesc.Add('A=C');
  PLFormatoDesc.Add('A=D');
  //Cod. dato
  PLCodDato:=TStringList.Create;
  selT265T275.First;
  while not selT265T275.Eof do
  begin
    PLCodDato.Add(selT265T275.FieldByName('CAUSALE').AsString);
    selT265T275.Next;
  end;
end;

function TA111FParMessaggiMW.ControllaParametriGriglia:Boolean;
var MaxFineDF,NumRecDF,NumRecIN,NumRecOld,NumRecDV:integer;
    TipoRecOld:string;
    ControlliGriglia:array of TControlliGriglia;
    ListaNomiColonneDF,ListaNomiColonneDV:TStringList;
begin
// Inizializzazione variabili per controlli
  Result:=True;
  MaxFineDF:=0;
  NumRecDF:=0;
  NumRecIn:=0;
  NumRecDV:=0;
  selT292.DisableControls;
  selT292.AfterScroll:=nil;
  ListaMessaggi.Clear;
  if selT291.FieldByName('TIPO_FILE').AsString = 'O' then
  begin
    ListaNomiColonneDF:=TStringList.Create;
    ListaNomiColonneDV:=TStringList.Create;
    ListaNomiColonneDF.Clear;
    ListaNomiColonneDV.Clear;
  end;
// Controlli su tabella temporanea
  CaricaTabellaTemp;
  try
    selC292.First;
    while (not selC292.Eof) and (Result) do
    begin
      SetLength(ControlliGriglia,0);
      NumRecOld:=selC292.FieldByName('NUMERO_RECORD').AsInteger;
      TipoRecOld:=selC292.FieldByName('TIPO_RECORD').AsString;
      while (NumRecOld = selC292.FieldByName('NUMERO_RECORD').AsInteger) and
            (TipoRecOld = selC292.FieldByName('TIPO_RECORD').AsString) and
             not selC292.Eof do
      begin
      // caricamento array con valori tabella
        SetLength(ControlliGriglia,Length(ControlliGriglia) + 1);
        with ControlliGriglia[High(ControlliGriglia)] do
        begin
          VTipoRec:=selC292.FieldByName('TIPO_RECORD').AsString;
          VNumRec:=selC292.FieldByName('NUMERO_RECORD').AsInteger;
          VTipo:=selC292.FieldByName('TIPO').AsString;
          VNome:=selC292.FieldByName('NOME_COLONNA').AsString;
          VInizio:=selC292.FieldByName('POSIZIONE').AsInteger;
          VFine:=VInizio + selC292.FieldByName('LUNGHEZZA').AsInteger - 1;
          VLunghezza:=selC292.FieldByName('LUNGHEZZA').AsInteger;
          VDefault:=selC292.FieldByName('VALORE_DEFAULT').AsString;
          VFormato:=selC292.FieldByName('FORMATO').AsString;
        end;
        selC292.Next;
      end;
      Controlli(MaxFineDF,NumRecDF,NumRecIN,NumRecDV,ControlliGriglia,ListaNomiColonneDF,ListaNomiColonneDV);
    end;
// Chiusura controlli
    if ListaMessaggi.Count > 0 then
       Result:=False;
    selC292.Close;
    selT292.First;
  finally
    if (DF) and (not DV) then
      ListaMessaggi.Add(A000MSG_A111_ERR_NO_DV);
    selT292.EnableControls;
    selT292.AfterScroll:=selT292AfterScroll;
    if selT291.FieldByName('TIPO_FILE').AsString = 'O' then
    begin
      FreeAndNil(ListaNomiColonneDF);
      FreeAndNil(ListaNomiColonneDV);
    end;
  end;
end;

procedure TA111FParMessaggiMW.ControllaFiltroAnagr;
begin
  if selT291.FieldByName('FILTRO_ANAGR').AsString <> '' then
    if not selT003.SearchRecord('NOME',selT291.FieldByName('FILTRO_ANAGR').AsString,[srFromBeginning]) then
      raise Exception.Create(A000MSG_A111_ERR_FILTRO_ANAGRAFICO);
end;

procedure TA111FParMessaggiMW.CaricaTabellaTemp;
begin
  selC292.Close;
  selC292.CreateDataSet;
  selC292.Open;
  selC292.LogChanges:=False;
  selT292.First;
  while not selT292.Eof do
  begin
    selC292.Append;
    selC292.FieldByName('TIPO_RECORD').AsString:=selT292.FieldByName('TIPO_RECORD').AsString;
    selC292.FieldByName('NUMERO_RECORD').Value:=selT292.FieldByName('NUMERO_RECORD').AsString;
    selC292.FieldByName('TIPO').AsString:=selT292.FieldByName('TIPO').AsString;
    selC292.FieldByName('NOME_COLONNA').AsString:=selT292.FieldByName('NOME_COLONNA').AsString;
    selC292.FieldByName('POSIZIONE').AsString:=selT292.FieldByName('POSIZIONE').AsString;
    selC292.FieldByName('LUNGHEZZA').AsString:=selT292.FieldByName('LUNGHEZZA').AsString;
    selC292.FieldByName('VALORE_DEFAULT').AsString:=selT292.FieldByName('VALORE_DEFAULT').AsString;
    selC292.FieldByName('FORMATO').AsString:=selT292.FieldByName('FORMATO').AsString;
    selT292.Next;
    selC292.Post;
  end;
end;

procedure TA111FParMessaggiMW.Controlli(var MaxFineDF,NumRecDF,NumRecIN,NumRecDV:Integer; var ControlliGriglia:array of TControlliGriglia;
                                          var ListaNomiColonneDF,ListaNomiColonneDV:TStringList);
var i,j,Ind:Integer;
    RiferimentiMessaggio,Mess:String;
    FlagTrovato:Boolean;
  procedure ScriviMessaggio(S:String);
  begin
    RiferimentiMessaggio:=ControlliGriglia[i].VTipoRec + '-' + IntToStr(ControlliGriglia[i].VNumRec) + '-' + ControlliGriglia[i].VTipo + ': ';
    ListaMessaggi.Add(RiferimentiMessaggio + S + CRLF);
  end;
begin
  for i:=0 to High(ControlliGriglia) do
  begin
    FlagTrovato:=False;
    with ControlliGriglia[i] do
    begin
      if VTipoRec = 'DF' then
       DF:=True;
      if VTipoRec = 'DV' then
       DV:=True;
      // controllo incrociato su posizioni record DV-DF
      if (VTipoRec = 'DF') and (NumRecDF <> 0) and (VNumRec <> NumRecDF) then
      begin
        Mess:=A000MSG_A111_ERR_CAMBIO_NUM_RECORD_DF;
        ScriviMessaggio(Mess);
      end;
      if VTipoRec = 'DF' then
      begin
        MaxFineDF:= VFine;
        NumRecDF:=VNumRec;
      end;
      if VTipoRec = 'IN' then
        NumRecIN:=VNumRec;
      if ((VTipoRec = 'DV') and (VNumRec <= NumRecDF)) or
         ((VTipoRec = 'DF') and (VNumRec <= NumRecIN)) then
      begin
        Mess:=A000MSG_A111_ERR_NUM_RECORD;
        ScriviMessaggio(Mess);
      end;
      if (selT291.FieldByName('TIPO_FILE').AsString = 'A') and (VTipoRec = 'DV') and
        ((VInizio <= MaxFineDF) or (VFine <= MaxFineDF)) then
      begin
        Mess:=A000MSG_A111_ERR_RECORD_ACCAVALLATI;
        ScriviMessaggio(Mess);
      end;
      // Controlli su nomi colonne in caso di tabella oracle
      if selT291.FieldByName('TIPO_FILE').AsString = 'O' then
      begin
        if VTipoRec = 'DF' then
          ListaNomiColonneDF.Add(VNome)
        else
        begin
          if ListaNomiColonneDF.Count > 0 then
            for Ind:=0 to (ListaNomiColonneDF.Count - 1) do
              if VNome = ListaNomiColonneDF[Ind] then
              begin
                Mess:=A000MSG_A111_ERR_NOME_COLONNA_DUPLICATO;
                ScriviMessaggio(Mess);
              end;
          if VNumRec <> NumRecDV then
            if ListaNomiColonneDV.Count > 0 then
            begin
              for Ind:=0 to (ListaNomiColonneDV.Count - 1) do
                if (VNome+IntToStr(VLunghezza)(*+VFormato*)) = ListaNomiColonneDV[Ind] then
                  FlagTrovato:=True;
              if not FlagTrovato then
              begin
                Mess:=A000MSG_A111_ERR_INCONGRUENZA_DV_DF;
                ScriviMessaggio(Mess);
              end;
            end
            else
            begin
              NumRecDV:=VNumRec;
              ListaNomiColonneDV.Add(VNome+IntToStr(VLunghezza)(*+VFormato*));
            end
          else
            ListaNomiColonneDV.Add(VNome+IntToStr(VLunghezza)(*+VFormato*));
        end;
      end;
      for j:=0 to High(ControlliGriglia) do
      begin
      // CONTROLLI INCROCIATI
        if i = j then Continue;
        if (selT291.FieldByName('TIPO_FILE').AsString = 'O') and (VNome = ControlliGriglia[j].VNome) then
        begin
        // 2 campi di nome uguale
          Mess:=A000MSG_A111_ERR_NOME_CAMPO_DUPLICATO;
          ScriviMessaggio(Mess);
        end;
        if (selT291.FieldByName('TIPO_FILE').AsString = 'A') then
          if (((ControlliGriglia[j].VInizio >= VInizio) and (ControlliGriglia[j].VInizio <= VFine)) or
              ((ControlliGriglia[j].VFine >= VInizio) and (ControlliGriglia[j].VFine <= VFine))) then
          begin
          // 2 campi che si accavallano
            Mess:=A000MSG_A111_ERR_CAMPI_ACCAVALLATI;
            ScriviMessaggio(Mess);
          end
          else
            if (j = (i - 1)) and (VInizio <> (ControlliGriglia[j].VFine + 1)) then
            begin
            // campi non contigui
              Mess:=A000MSG_A111_ERR_CAMPI_NON_CONTIGUI;
              ScriviMessaggio(Mess);
            end;
      end;
    end;
  end;
end;

procedure TA111FParMessaggiMW.AfterScroll;
begin
  selT292.Close;
  selT292.SetVariable('CODICE_PARM',selT291.FieldByName('CODICE').AsString);
  selT292.Open;
end;

procedure TA111FParMessaggiMW.AfterPostStep1;
begin
  try
    SessioneOracle.ApplyUpdates([selT291,selT292],True);
  except
    //ShowMessage('Modifiche fallite: Inserire i dati ordinati per posizione');
    on E:Exception do
     raise exception(E.Message);
  end;
end;

procedure TA111FParMessaggiMW.AfterPostStep2;
begin
  SessioneOracle.Commit;
  AfterScroll;
end;

procedure TA111FParMessaggiMW.AfterEdit(Codice:String);
begin
  CodiceVecchio:=Codice;
end;

procedure TA111FParMessaggiMW.AfterInsert(Codice:String);
begin
  CodiceVecchio:=Codice;
end;

procedure TA111FParMessaggiMW.OnNewRecord;
begin
  selT291.FieldByName('TIPO_FILE').AsString:='A';
  selT291.FieldByName('DEFAULT_FILE').AsString:='S';
end;

procedure TA111FParMessaggiMW.BeforeDelete;
begin
  delT292.SetVariable('CODICE',selT291.FieldByName('CODICE').AsString);
  delT292.Execute;
  SessioneOracle.Commit;
end;

procedure TA111FParMessaggiMW.AfterCancel;
begin
  selT291.CancelUpdates;
  if selT292.CachedUpdates then
    selT292.CancelUpdates;
  AfterScroll;
end;

procedure TA111FParMessaggiMW.BeforePost;
begin
  if QueryPK1.EsisteChiave('T291_PARMESSAGGI',selT291.RowId,selT291.State,['CODICE'],[selT291.FieldByName('Codice').AsString]) then
    raise Exception.Create(A000MSG_ERR_CODICE_ESISTENTE);
  ControllaDettaglio;
  if selT291.FieldByName('TIPO_FILTRO').AsString = '0' then
    ControllaFiltroAnagr;
end;

procedure TA111FParMessaggiMW.BeforeCancel;
begin
  if selT291.FieldByName('TIPO_FILTRO').AsString = '0' then
    ControllaFiltroAnagr;
end;

procedure TA111FParMessaggiMW.AfterDelete;
begin
  SessioneOracle.ApplyUpdates([selT291],True);
end;

procedure TA111FParMessaggiMW.CodiceChange;
begin
  updT292.SetVariable('CODICE_OLD', CodiceVecchio);
  updT292.SetVariable('CODICE_NEW', selT291.FieldByName('Codice').AsString);
  try
    updT292.Execute;
  except
    raise Exception.Create(A000MSG_A111_ERR_AGG_CODICE);
  end;
end;

procedure TA111FParMessaggiMW.selT292AfterScroll(DataSet: TDataSet);
begin
  if Assigned(AssegnaPickList) then
    AssegnaPickList(selT292.FieldByName('TIPO').AsString);
end;

procedure TA111FParMessaggiMW.selT292BeforePost(DataSet: TDataSet);
begin
  selT292.FieldByName('TIPO_RECORD').AsString:=UpperCase(selT292.FieldByName('TIPO_RECORD').AsString);
  selT292.FieldByName('TIPO').OnValidate:=nil;
  selT292.FieldByName('TIPO').AsString:=UpperCase(selT292.FieldByName('TIPO').AsString);
  selT292.FieldByName('TIPO').OnValidate:=selT292TIPOValidate;
  selT292.FieldByName('FORMATO').AsString:=UpperCase(selT292.FieldByName('FORMATO').AsString);
  selT292.FieldByName('NOME_COLONNA').AsString:=UpperCase(selT292.FieldByName('NOME_COLONNA').AsString);
  if (selT292.FieldByName('TIPO').AsString = 'VL') or (selT292.FieldByName('TIPO').AsString = 'DE') then
    selT292.FieldByName('VALORE_DEFAULT').AsString:=UpperCase(selT292.FieldByName('VALORE_DEFAULT').AsString);
  // controllo sul tipo campo all'interno di un determinato tipo record
  if (selT292.FieldByName('TIPO_RECORD').AsString = 'IN') and ((selT292.FieldByName('TIPO').AsString = 'BA') or
     (selT292.FieldByName('TIPO').AsString = 'DE') or (selT292.FieldByName('TIPO').AsString = 'VL')) then
    raise Exception.Create(A000MSG_A111_ERR_TIPO_COLONNA_RECORD);
  if (selT292.FieldByName('TIPO_RECORD').AsString = 'DF') and
     ((selT292.FieldByName('TIPO').AsString = 'DE') or (selT292.FieldByName('TIPO').AsString = 'VL')) then
    raise Exception.Create(A000MSG_A111_ERR_TIPO_COLONNA_RECORD);
  // Controlla se la lunghezza è valida
  if (selT292.FieldByName('TIPO').AsString <> 'AN') and (selT292.FieldByName('TIPO').AsString <> 'VL') and (selT292.FieldByName('TIPO').AsString <> 'DE') and (selT292.FieldByName('FORMATO').AsString <> '') and
     (selT292.FieldByName('LUNGHEZZA').AsInteger < Length(selT292.FieldByName('FORMATO').AsString)) then
    raise Exception.Create(A000MSG_A111_ERR_LUNGHEZZA_DIVERSA);
  if (selT292.FieldByName('TIPO').AsString <> 'AN') and (selT292.FieldByName('TIPO').AsString <> 'VL') and (selT292.FieldByName('VALORE_DEFAULT').AsString <> '') and
     (selT292.FieldByName('LUNGHEZZA').AsInteger < Length(selT292.FieldByName('VALORE_DEFAULT').AsString)) then
    raise Exception.Create(A000MSG_A111_ERR_LUNGHEZZA_MINORE);
  if (selT292.FieldByName('TIPO').AsString <> 'VL') and (selT292.FieldByName('TIPO').AsString <> 'DT') and (selT292.FieldByName('TIPO').AsString <> 'DC') then
    selT292.FieldByName('CODICE_DATO').Clear;
  selT292VALORE_DEFAULTValidate(nil);
  selT292FORMATOValidate(nil);
end;

procedure TA111FParMessaggiMW.selT292NewRecord(DataSet: TDataSet);
begin
  selT292.FieldByName('CODICE').AsString:=selT291.FieldByName('CODICE').AsString;
  if selT291.FieldByName('TIPO_FILE').AsString = 'A' then
    selT292.FieldByName('NOME_COLONNA').AsString:='*'
  else
    selT292.FieldByName('POSIZIONE').AsInteger:=0;
end;

procedure TA111FParMessaggiMW.selT292TIPO_RECORDValidate(Sender: TField);
begin
  if (selT291.FieldByName('TIPO_FILE').AsString = 'O') and (selT292.FieldByName('TIPO_RECORD').AsString = 'IN') then
    raise Exception.Create(A000MSG_A111_ERR_TIPO_RECORD_FILE);
  if R180IndexOf(PLTipoRecord,UpperCase(selT292.FieldByName('TIPO_RECORD').AsString),2) = -1 then
    raise Exception.Create(A000MSG_A111_ERR_TIPO_RECORD);
end;

procedure TA111FParMessaggiMW.selT292TIPOValidate(Sender: TField);
begin
  if R180IndexOf(PLTipo,UpperCase(selT292.FieldByName('TIPO').AsString),2) = -1 then
    raise Exception.Create(A000MSG_A111_ERR_TIPO_COLONNA)
  else
  begin
    selT292.FieldByName('VALORE_DEFAULT').OnValidate:=nil;
    selT292.FieldByName('VALORE_DEFAULT').Clear;
    selT292.FieldByName('VALORE_DEFAULT').OnValidate:=selT292VALORE_DEFAULTValidate;
    selT292.FieldByName('FORMATO').OnValidate:=nil;
    selT292.FieldByName('FORMATO').Clear;
    selT292.FieldByName('FORMATO').OnValidate:=selT292FORMATOValidate;
    selT292AfterScroll(selT292);
  end;
end;

procedure TA111FParMessaggiMW.selT292POSIZIONEValidate(Sender: TField);
begin
  if selT291.FieldByName('TIPO_FILE').AsString = 'A' then
    if selT292.FieldByName('POSIZIONE').AsInteger = 0 then
      raise Exception.Create(A000MSG_A111_ERR_POSIZIONE);
end;

procedure TA111FParMessaggiMW.selT292LUNGHEZZAValidate(Sender: TField);
begin
  if selT292.FieldByName('LUNGHEZZA').AsInteger = 0 then
    raise Exception.Create(A000MSG_A111_ERR_LUNGHEZZA);
end;

procedure TA111FParMessaggiMW.selT292NOME_COLONNAValidate(Sender: TField);
begin
  if Trim(selT292.FieldByName('NOME_COLONNA').AsString) = '' then
    raise Exception.Create(A000MSG_A111_ERR_NOME_COLONNA);
end;

procedure TA111FParMessaggiMW.selT292FORMATOValidate(Sender: TField);
begin
// controllo sul formato
  if (selT292.FieldByName('TIPO').AsString = 'DE')
  and (R180IndexOf(PLFormatoDesc,UpperCase(selT292.FieldByName('FORMATO').AsString),Length(selT292.FieldByName('FORMATO').AsString)) = -1) then
    raise Exception.Create(A000MSG_A111_ERR_FORMATO);
  if (selT292.FieldByName('FORMATO').AsString = '') and ((selT292.FieldByName('TIPO').AsString = 'VL') or
     (selT292.FieldByName('TIPO').AsString = 'DC') or (selT292.FieldByName('TIPO').AsString = 'DT') or (selT292.FieldByName('TIPO').AsString = 'DS')) then
    raise Exception.Create(A000MSG_A111_ERR_NO_FORMATO);
  if (selT292.FieldByName('FORMATO').AsString <> '') and ((selT292.FieldByName('TIPO').AsString = 'FI') or
     (selT292.FieldByName('TIPO').AsString = 'BA') or (selT292.FieldByName('TIPO').AsString = 'PT') or (selT292.FieldByName('TIPO').AsString = 'IN') or
     (selT292.FieldByName('TIPO').AsString = 'NR')) then
    raise Exception.Create(A000MSG_A111_ERR_SVUOTA_FORMATO);
end;

procedure TA111FParMessaggiMW.selT292VALORE_DEFAULTValidate(Sender: TField);
begin
// controllo sul valore di default
  if (selT291.FieldByName('DEFAULT_FILE').AsString = 'S') and
    ((selT292.FieldByName('TIPO').AsString = 'VL') or (selT292.FieldByName('TIPO').AsString = 'DE')) and
     (selT292.FieldByName('VALORE_DEFAULT').asString = '') then
    raise Exception.Create(A000MSG_A111_ERR_NO_DEFAULT);
  if (selT292.FieldByName('TIPO').AsString = 'VL') and (selT292.FieldByName('VALORE_DEFAULT').asString <> '')
  and (R180IndexOf(PLDefaultVal,UpperCase(selT292.FieldByName('VALORE_DEFAULT').AsString),80) = -1) then
      raise Exception.Create(A000MSG_A111_ERR_DEFAULT);
  if (selT292.FieldByName('VALORE_DEFAULT').AsString <> '') and
     ((selT292.FieldByName('TIPO').AsString = 'BA') or (selT292.FieldByName('TIPO').AsString = 'IN') or
      (selT292.FieldByName('TIPO').AsString = 'PT') or (selT292.FieldByName('TIPO').AsString = 'NR')) then
    raise Exception.Create(A000MSG_A111_ERR_SVUOTA_DEFAULT);
end;

procedure TA111FParMessaggiMW.ControllaDettaglio;
var Messaggio:string;
    Ind:integer;
begin
  if not ControllaParametriGriglia then
  begin
    for Ind:=0 to ListaMessaggi.Count - 1 do
      Messaggio:=Messaggio + ListaMessaggi[Ind] + #13;
    raise Exception.Create(Messaggio);
  end;
end;

end.
