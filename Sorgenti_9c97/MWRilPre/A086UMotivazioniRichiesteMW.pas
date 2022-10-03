unit A086UMotivazioniRichiesteMW;

interface

uses
  A000UInterfaccia, A000UMessaggi,
  C180FunzioniGenerali, Oracle, OracleData, Variants,
  System.SysUtils, System.Classes, R005UDataModuleMW, Data.DB, Datasnap.DBClient;

type
  TA086FMotivazioniRichiesteMW = class(TR005FDataModuleMW)
    cdsTipologie: TClientDataSet;
    cdsTipologieCODICE: TStringField;
    cdsTipologieDESCRIZIONE: TStringField;
    procedure DataModuleCreate(Sender: TObject);
  private
    FSelT106: TOracleDataSet;
  public
    procedure FiltraSelT106(const PTipo: String);
    procedure SelT106NewRecord(const PTipo: String);
    procedure SelT106BeforePost;
    procedure SelT106BeforeDelete;
    property SelT106_Funzioni: TOracleDataset read FSelT106 write FSelT106;
  end;

implementation

{$R *.dfm}

procedure TA086FMotivazioniRichiesteMW.DataModuleCreate(Sender: TObject);
begin
  inherited;

  // popola clientdataset tipologie (non sono presenti in tabella su db)
  cdsTipologie.EmptyDataSet;
  cdsTipologie.Append;
  cdsTipologie.FieldByName('CODICE').AsString:='T';
  cdsTipologie.FieldByName('DESCRIZIONE').AsString:='Motivazioni richieste timbrature';
  cdsTipologie.Post;
  cdsTipologie.Append;
  cdsTipologie.FieldByName('CODICE').AsString:='M140';
  cdsTipologie.FieldByName('DESCRIZIONE').AsString:='Motivazioni annullamento missioni';
  cdsTipologie.Post;
  cdsTipologie.Append;
  cdsTipologie.FieldByName('CODICE').AsString:='T325';
  cdsTipologie.FieldByName('DESCRIZIONE').AsString:='Motivazioni richieste eccedenze giornaliere';
  cdsTipologie.Post;
end;

procedure TA086FMotivazioniRichiesteMW.FiltraSelT106(const PTipo: String);
begin
  FSelT106.Filtered:=False;
  FSelT106.Filter:=Format('TIPO = ''%s''',[PTipo]);
  FSelT106.Filtered:=True;
end;

procedure TA086FMotivazioniRichiesteMW.SelT106BeforePost;
var
  Tipo: String;
begin
  // verifica che il tipo sia corretto (è automatico, quindi dovrebbe esserlo)
  Tipo:=FSelT106.FieldByName('TIPO').AsString;
  if Tipo <> VarToStr(cdsTipologie.Lookup('CODICE',Tipo,'CODICE')) then
    raise Exception.Create(Format(A000TraduzioneStringhe(A000MSG_A086_ERR_FMT_TIPO_VALORE),[Tipo]));

  // verifica valore di CODICE_DEFAULT
  if not R180In(FSelT106.FieldByName('CODICE_DEFAULT').AsString,['S','N']) then
    raise Exception.Create(A000TraduzioneStringhe(A000MSG_A086_ERR_CODICE_DEFAULT));


  // verifica che il default sia impostato su un solo record per tipo
  if FSelT106.FieldByName('CODICE_DEFAULT').AsString = 'S' then
  begin
    if QueryPK1.EsisteChiave('T106_MOTIVAZIONIRICHIESTE',FSelT106.RowID,FSelT106.State,['TIPO','CODICE_DEFAULT'],[FSelT106.FieldByName('TIPO').AsString,'S']) then
      raise Exception.Create(A000TraduzioneStringhe(A000MSG_A086_ERR_CODICE_DEFAULT_MULT));
  end;
end;

procedure TA086FMotivazioniRichiesteMW.SelT106NewRecord(const PTipo: String);
begin
  // impostazione valori per il nuovo record
  FSelT106.FieldByName('TIPO').AsString:=PTipo;
end;

procedure TA086FMotivazioniRichiesteMW.SelT106BeforeDelete;
var
  Q: TOracleQuery;
  Tipo, Codice, StrSql{, Descrizione}: String;
begin
  // variabili di supporto
  Tipo:=VarToStr(FSelT106.FieldByName('TIPO').medpOldValue);
  Codice:=VarToStr(FSelT106.FieldByName('CODICE').medpOldValue);
  //Descrizione:=VarToStr(FSelT106.FieldByName('DESCRIZIONE').medpOldValue);

  // imposta query per verificare che il codice non sia utilizzato
  Q:=TOracleQuery.Create(nil);
  try
    Q.Session:=SessioneOracle;
    // in base al tipo verifica se il codice è utilizzato
    if Tipo = 'T' then
    begin
      // 1. motivazioni richieste timbrature (W018)
      StrSql:=Format('select count(*) from T105_RICHIESTETIMBRATURE '#13#10 +
                     'where  MOTIVAZIONE = ''%s''',[Codice]);
      Q.SQL.Text:=StrSql;
      Q.Execute;
      if Q.FieldAsInteger(0) > 0 then
        raise Exception.Create('La motivazione è utilizzata nelle richieste di'#13#10 +
                               'modifica delle timbrature web.'#13#10 +
                               'Cancellazione impossibile!');
    end
    else if Tipo = 'M140' then
    begin
      // 2. motivazioni annullamento richieste missioni
      // in questo caso non si controlla nulla, perché le motivazioni vengono
      // utilizzate solo per quanto riguarda le descrizioni, come proposta
      // di diciture in fase di annullamento
      {
      StrSql:=Format('select count(*) from M140_RICHIESTE_MISSIONI '#13#10 +
                     'where  ANNULLAMENTO = ''%s''',[Descrizione]);
      Q.SQL.Text:=StrSql;
      Q.Execute;
      if Q.FieldAsInteger(0) > 0 then
        raise Exception.Create('La descrizione è utilizzata come motivazione di annullamento' + #13#10 +
                               'nelle richieste di trasferta web.'#13#10 +
                               'Cancellazione impossibile!');
      }
    end
    else if Tipo = 'T325' then
    begin
      // 3. motivazioni richieste eccedenze gg. (W026)
      StrSql:=Format('select count(*) from T326_RICHIESTESTR_SPEZ '#13#10 +
                     'where  MOTIVAZIONE = ''%s''',[Codice]);
      Q.SQL.Text:=StrSql;
      Q.Execute;
      if Q.FieldAsInteger(0) > 0 then
        raise Exception.Create('La motivazione è utilizzata nelle richieste di'#13#10 +
                               'eccedenze giornaliere web.'#13#10 +
                               'Cancellazione impossibile!');
    end;
  finally
    FreeAndNil(Q);
  end;
end;

end.
