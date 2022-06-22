unit Bc06UClassi;

interface

uses System.Generics.Collections, System.SysUtils, System.Classes, IniFiles;

type
  TConfIstanza = class
    public
      IDServizio: Integer;
      Servizio:String;
      DataBase:String;
      Monitor_Bc06srv:String;
      Password:String;
      QueryServizioConnesso:String;
      QueryMsg1:String;
      QueryMsg2:String;
      NoMonitorDalle: String;
      NoMonitorAlle:String;
      MsgElaborazioniGG:Integer;
      MsgElaborazioniRighe:Integer;
      EMailMittente:String;
      EMailDestinatari:String;
      EMailDestinatariCC:String;
  end;

  TConfServizio = class
    public
      ID:Integer;
      NomeServizio:String;
      Intervallo:String;
      IntervalloMS:Integer;
      SMTPHost:String;
      SMTPPort:Integer;
      SMTPUserName:String;
      SMTPPassword:String;
      SMTPAuthType:String;
      Istanze:TObjectList<TConfIstanza>;
      constructor Create;
      destructor Destroy; override;
  end;

  TConfGenerale = class
    public
      Servizi:TObjectDictionary<Integer,TConfServizio>;
      constructor Create;
      destructor Destroy; override;
  end;

  TEsitoControllo = class
    public
      Servizio:String;
      Database:String;
      Esito: Integer;   // vedi costanti ESITO_*
      DescrEsito: String;
      Msg1,Msg2:TStringList;
      LstAziende:TStringList;
      constructor Create;
      destructor Destroy; override;
  end;

  TMsgControlloIstanza = class  // messaggi del controllo
    public
      Servizio:String; // Servizio
      Database:String; // Istanza
//      MsgLog:TStringList; // log operazione
      Msg1:TStringList; // messaggi delle elaborazioni 1 (estratti tramite la query QueryMsg1)
      Msg2:TStringList; // messaggi delle elaborazioni 2 (estratti tramite la query QueryMsg2)
      constructor Create(Servizio,Database:String);
      destructor Destroy; override;
  end;

  TConfigIni = class
    Azienda:String;
    Database:String;
    public
      constructor Create;
      class function GetConfig(PathFileIni:String):TConfigIni;
  end;

const
  NOME_APPLICAZIONE = '<Bc06> Monitor B006';

  BC06_INI_SEZ_IMPOST_OPER = 'ImpostazioniOperative';
  BC06_INI_ID_DATABASE     = 'Database';
  BC06_INI_ID_AZIENDA      = 'Azienda';

  CONFIG_INI_FILE = 'Bc06.ini';

  //{
  CONFIG_DB = 'iriswin.aipoprod.csi.it';
  CONFIG_DB_TEST = 'iriswin.aipotest.csi.it';
  //}
  {
  CONFIG_DB = 'IRIS'; // TODO:  AIPOPROD
  CONFIG_DB_TEST = 'IRIS'; // TODO:  eventuale DB di test
  }
  SALT_CRIPTA = 20111972;
  DB_LOGON_USERNAME = 'OPPFYUMT'; // R180Cripta

  ESITO_OK = 0;
  ESITO_DB_IRRAGGIUNGIBILE = 1;
  ESITO_SERVIZIO_SCOLLEGATO = 2;
  ESITO_ERRORE_SQL_SERVIZIO = 3;
  ESITO_CONTROLLO_SALTATO = 4;
  ESITO_ERRORE_GENERICO = -1;
  ESITO_INDEFINITO = -99;

  ORARIO_VUOTO = '  .  ';

  NOME_VAR_MSG_ELABORAZIONI_GG = 'MSG_ELABORAZIONI_GG';
  NOME_VAR_MSG_ELABORAZIONI_RIGHE = 'MSG_ELABORAZIONI_RIGHE';
  NOME_VAR_MSG_FILTRO_UTENTE = 'FILTRO_UTENTE';

implementation

{ TConfServizio }

constructor TConfServizio.Create;
begin
  Self.Istanze:=TObjectList<TConfIstanza>.Create(True);
end;

destructor TConfServizio.Destroy;
begin
  Self.Istanze.Free;
  inherited;
end;

{ TConfGenerale }

constructor TConfGenerale.Create;
begin
  Servizi:=TObjectDictionary<Integer,TConfServizio>.Create([doOwnsValues]);
end;

destructor TConfGenerale.Destroy;
begin
  FreeAndNil(Servizi);
  inherited;
end;

{ TEsitoControllo }

constructor TEsitoControllo.Create;
begin
  DescrEsito:='';
  Msg1:=TStringList.Create;
  Msg2:=TStringList.Create;
  LstAziende:=TStringList.Create;
end;

destructor TEsitoControllo.Destroy;
begin
  FreeAndNil(Msg1);
  FreeAndNil(Msg2);
  FreeAndNil(LstAziende);
end;

{ TMsgControlloIstanza }

constructor TMsgControlloIstanza.Create(Servizio,Database:String);
begin
  Self.Servizio:=Servizio;
  Self.Database:=Database;
  Msg1:=TStringList.Create;
  Msg2:=TStringList.Create;
end;

destructor TMsgControlloIstanza.Destroy;
begin
  FreeAndNil(Msg1);
  FreeAndNil(Msg2);
  inherited;
end;

{ TConfigIni }

constructor TConfigIni.Create;
begin
  // Default
  Self.Azienda:='';
  Self.Database:='';
end;

class function TConfigIni.GetConfig(PathFileIni:String):TConfigIni;
var
  IniFile:TIniFile;
begin
  Result:=TConfigIni.Create;
  IniFile:=nil;
  try
    if not FileExists(PathFileIni) then
    begin
      Result.Azienda:='';
      Result.Database:=CONFIG_DB;
    end
    else
    begin
      IniFile:=TIniFile.Create(PathFileIni);
      try
        Result.Azienda:=IniFile.ReadString(BC06_INI_SEZ_IMPOST_OPER,BC06_INI_ID_AZIENDA,'');
        Result.Database:=IniFile.ReadString(BC06_INI_SEZ_IMPOST_OPER,BC06_INI_ID_DATABASE,CONFIG_DB);
      finally
        FreeAndNil(IniFile);
      end;
    end;
  except
    FreeAndNil(Result);
    Result:=TConfigIni.Create; // Ritorno la configurazione vuota
  end;
end;

end.

