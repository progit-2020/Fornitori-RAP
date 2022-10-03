unit A077UCOMRemoteDtM;

{$WARN SYMBOL_PLATFORM OFF}

interface

uses
  Windows, Messages, SysUtils, StrUtils, Classes, ComServ, ComObj, VCLCom, DataBkr,
  DBClient, A077PCOMServer_TLB, StdVcl,
  OracleData, A000UCostanti, A000USessione, A000UInterfaccia, C180FunzioniGenerali, QueryStorico;

type
  TA077COMServer = class(TRemoteDataModule, IA077COMServer)
    procedure RemoteDataModuleCreate(Sender: TObject);
  private
    { Private declarations }
  protected
    class procedure UpdateRegistry(Register: Boolean; const ClassID, ProgID: string); override;
    procedure CreaStampa(const SelezioneAnagrafica, CodiceStampa, FilePDF, StandardPrinter,
          Operatore, Azienda, Applicazione, DBServer: WideString; Dal, Al: TDateTime;
          var DettaglioLog: OleVariant); safecall;
  public
    { Public declarations }
  end;

implementation

uses A001UPasswordDtM1,
     A077UGeneratoreStampe, A077UGeneratoreStampeDtM, A077UStampa,
     C700USelezioneAnagrafe;

{$R *.DFM}

procedure TA077COMServer.RemoteDataModuleCreate(Sender: TObject);
(*var OV:OleVariant;*)
begin
  (*//Per testare: mettere il create del datamodulo sulla form A077FComServer.Create
  CreaStampa('SELECT T030.*,T480.CITTA,T480.PROVINCIA,V430.T430BADGE,V430.T430INIZIO,V430.T430FINE,V430.T430DATADECORRENZA,V430.T430DATAFINE' + CRLF +
             'FROM T030_Anagrafico T030, V430_Storico V430, T480_Comuni T480' + CRLF +
             'WHERE T030.Progressivo = V430.T430Progressivo AND T030.ComuneNas = T480.Codice(+) AND :DataLavoro BETWEEN V430.T430DataDecorrenza AND V430.T430DataFine' + CRLF +
             //'AND :DATALAVORO BETWEEN NVL(P430DECORRENZA,:DATALAVORO) AND NVL(P430DECORRENZA_FINE,:DATALAVORO)' + CRLF +
             'AND :DATALAVORO BETWEEN T430INIZIO AND NVL(LAST_DAY(T430FINE),:DATALAVORO) AND (T030.MATRICOLA = ''60312'')' + CRLF +
             'ORDER BY T030.COGNOME,T030.NOME,T030.MATRICOLA',
             'WEB PRESENZE',
             'C:\temp\sondrio.pdf',
             'S',
             'MONDOEDP',
             'AZIN',
             'RILPRE',
             'SONDRIO_HVALTELLINA',
             Encodedate(2014,1,1),
             Encodedate(2014,12,31),
             OV);
  *)
end;

class procedure TA077COMServer.UpdateRegistry(Register: Boolean; const ClassID, ProgID: string);
begin
  if Register then
  begin
    inherited UpdateRegistry(Register, ClassID, ProgID);
    EnableSocketTransport(ClassID);
    EnableWebTransport(ClassID);
  end else
  begin
    DisableSocketTransport(ClassID);
    DisableWebTransport(ClassID);
    inherited UpdateRegistry(Register, ClassID, ProgID);
  end;
end;

procedure TA077COMServer.CreaStampa(const SelezioneAnagrafica, CodiceStampa, FilePDF,
          StandardPrinter, Operatore, Azienda, Applicazione, DBServer: WideString;
          Dal, Al: TDateTime; var DettaglioLog: OleVariant);
var
  S: String;
  pS,pF,pO: Integer;
begin
  try
    with TA001FPasswordDtM1.Create(nil) do
    try
      InizializzazioneSessione(DBServer);
      QI090.Close;
      QI090.SetVariable('Azienda',Azienda);
      QI090.Open;
      QI060.Close;
      QI060.SetVariable('Azienda',Azienda);
      QI060.SetVariable('Utente',Operatore);
      QI060.Open;
      QI070.Close;
      QI070.SetVariable('Azienda',Azienda);
      QI070.SetVariable('Utente',Operatore);
      QI070.Open;
      if (QI060.RecordCount > 0) or (QI070.RecordCount = 0) then
      begin
        QI070.Close;
        QI070.SetVariable('Azienda',Azienda);
        QI070.SetVariable('Utente','SYSMAN');
        QI070.Open;
      end;
      RegistraInibizioni;
      Parametri.Database:=DBServer;
    finally
      Free;
    end;
    SessioneOracle.LogonDataBase:=DBServer;
  //if (not SessioneIWB010.SessioneOracle.Connected) or (SessioneIWB010.SessioneOracle.LogonDataBase <> Alias) then
    try
      A000ParamDBOracle(SessioneOracle);
      RegistraMsg.IniziaMessaggio('A077COM');
    except
      on E:Exception do
        R180ScriviMsgLog('A077PCOMServer.log',E.Message);
    end;
    Parametri.Operatore:=Operatore;
    Parametri.Applicazione:=Applicazione;
    RegistraMsg.InserisciMessaggio('I', Format('Stampa: %s - dal %s al %s - Applicazione: %s - PDF: %s - Selezione: %s',[CodiceStampa,DateToStr(Dal),DateToStr(Al),Applicazione,FilePDF,SelezioneAnagrafica]),Azienda);
    A077FGeneratoreStampe:=TA077FGeneratoreStampe.Create(nil);
    try
      RegistraMsg.InserisciMessaggio('I','A077COM creato');
      A077FGeneratoreStampe.TipoModulo:='COM';
      A077FGeneratoreStampe.ComObj_UseStandardPrinter:=StandardPrinter = 'S';
      A077FGeneratoreStampeDtM:=TA077FGeneratoreStampeDtM.Create(nil);
      RegistraMsg.InserisciMessaggio('I','A077COMDtM creato');
      A077FGeneratoreStampe.FormShow(A077FGeneratoreStampe);
      A077FGeneratoreStampeDtM.Q910.SearchRecord('CODICE',CodiceStampa,[srFromBeginning]);
      A077FGeneratoreStampe.DropTabelleTemp:=True;
      A077FGeneratoreStampe.DataI:=Dal;
      A077FGeneratoreStampe.DataF:=Al;
      A077FGeneratoreStampe.DocumentoPDF:=IfThen(FilePDF <> '',FilePDF,'<VUOTO>');
      try A077FGeneratoreStampe.SelectLog:=DettaglioLog; except end;
      DettaglioLog:='';
      C700SelAnagrafe.Close;
      // aggiunge dati visualizzati C700.ini - 22.03.2011
      // (compatibilità con C700SelAnagrafe)
      //C700SelAnagrafe.SQL.Text:=SelezioneAnagrafica;
      S:=SelezioneAnagrafica;
      RegistraMsg.InserisciMessaggio('I','Selezione iniziale: ' + S);
      pF:=R180CercaParolaIntera('FROM',UpperCase(S),'.,;');
      pS:=R180CercaParolaIntera('SELECT',UpperCase(S),'.,;');
      if (pF > 0) and (pS > 0) then
      begin
        pS:=pS + 7; // 'SELECT '
        C700DatiSelezionati:=Copy(S,pS,pF - pS - 1);
        C700DatiSelezionati:=StringReplace(C700DatiSelezionati,',V430.',',',[rfReplaceAll,rfIgnoreCase]);
        Delete(S,pS,pF - pS);
        C700DatiSelezionati:=C700CompletaDatiSelezionati;
        Insert(C700DatiSelezionati + ' ',S,pS);
      end
      else
        RegistraMsg.InserisciMessaggio('A','Selezione anagrafica errata: ' + S);
      RegistraMsg.InserisciMessaggio('I','Selezione finale: ' + S);
      C700SelAnagrafe.SQL.Text:=S;
      pF:=R180CercaParolaIntera('FROM',UpperCase(S),'.,;');
      if pF > 0 then
        S:=Trim(Copy(S,pF + 4,Length(S)));
      pO:=R180CercaParolaIntera('ORDER BY',UpperCase(S),'.,;');
      if pO > 0 then
        S:=Trim(Copy(S,1,pO - 1));
      C700FSelezioneAnagrafe.CorpoSQL.Text:=S;

      // aggiunge dati visualizzati C700.fine
      if FilePDF <> '' then
        A077FGeneratoreStampe.btnAnteprimaClick(A077FGeneratoreStampe)
      else if A077FGeneratoreStampeDtM.Q910.FieldByName('TABELLA_GENERATA').AsString <> '' then
        A077FGeneratoreStampe.btnAnteprimaClick(A077FGeneratoreStampe.btnTabella);
      DettaglioLog:=StringReplace(A077FGeneratoreStampe.TestoLog,'<NUM_PAG>',IntToStr(A077FStampa.QRep.PageNumber),[rfReplaceAll]);
      RegistraMsg.InserisciMessaggio('I','Elaborazione terminata. ' + DettaglioLog);
    finally
      A077FGeneratoreStampeDtM.Free;
      A077FGeneratoreStampe.Free;
      RegistraMsg.InserisciMessaggio('I','A077COM Free');
    end;
  except
    on E:Exception do
      RegistraMsg.InserisciMessaggio('A',E.Message,Azienda);
  end;
  RegistraMsg.InserisciMessaggio('I','A077COM Exit');
end;

initialization
  TComponentFactory.Create(ComServer, TA077COMServer,
    Class_A077COMServer, ciSingleInstance, tmSingle);
end.
