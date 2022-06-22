unit A041UInsRiposiMW;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, R005UDataModuleMW, OracleData,DatiBloccati, QueryStorico, A000UInterfaccia,
  R400UCartellinoDtM, RP502Pro,R600, DB, C180FunzioniGenerali, Math, Oracle;

type
  TA041FInsRiposiMW = class(TR005FDataModuleMW)
    selT267: TOracleDataSet;
    delT040: TOracleQuery;
    QTimbrature: TOracleDataSet;
    QTimbratureVERSO: TStringField;
    QTimbratureCAUSALE: TStringField;
    QTimbratureDATA: TDateTimeField;
    QGiustificativi: TOracleDataSet;
    Q265: TOracleDataSet;
    GetCalendario: TOracleQuery;
    QCausale1: TOracleDataSet;
    QCausale1T265CODICE: TStringField;
    QCausale1T265DESCRIZIONE: TStringField;
    QCausale1T265CODRAGGR: TStringField;
    QCausale1T260CODICE: TStringField;
    QCausale1T260CODINTERNO: TStringField;
    Q275: TOracleDataSet;
    Q275CODICE: TStringField;
    Q275DESCRIZIONE: TStringField;
    Q275ORENORMALI: TStringField;
    selT380: TOracleQuery;
    QInsGiustificativi: TOracleQuery;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    FDataInizio,
    FDataFine: TDateTime;
    QSRiposo: TQueryStorico;
    selDatiBloccati: TDatiBloccati;
    SalvaRiposi: TStringList;
    InserimentoRiposo,Esegui: Boolean;
    UltimaCausaleConteggiata: String;
    GestioneTurnista: String;
    Giustif: TGiustificativo;
    CompRip,FruitoRip,Recupero: Real;
    R502ProDtM1: TR502ProDtM1;
    R600DtM1: TR600DtM1;
    R400:TR400FCartellinoDtM;
    function PreparaInserimento(Tipo: String; DataMese: TDateTime): Boolean;
    procedure ChiusuraInserimento(FineMese: TDateTime;InserimentoRiposo: Boolean;SalvaRiposi: TStringList);
    procedure Inserimento(Tipo: String; DataCorr: TDateTime);
    procedure PulRiposi(Prog: Integer; DataI, DataF: TDateTime);
    function RiposoNonTurnista(Data: TDateTime): Boolean;
    function GiustificativiOK(Data: TDateTime): Boolean;
    function ReperibilitaOK(Data: TDateTime): Boolean;
    function TimbratureOK(Data: TDateTime): Boolean;
    function AddGiornoRiposo(Prog: Integer; Data: TDateTime;
      Causale: String): Boolean;
    function CausaleDisabilitata(Codice: String): Boolean;
    function GiornoFestivo(Data: TDateTime): Boolean;
    function CausalePresenzaAbilitata(Codice: String): Boolean;
    function ControlloSmontoNotte(Data: TDateTime; Causale: String): Boolean;
    procedure InserimentoFestInfrasett(Tipo: String; DataCorr: TDateTime);
  public
    procedure InizializzaSelDatiBloccati;
    procedure InizializzaComponentiElaborazione;
    procedure ElaboraDipendente;
    procedure DistruggiComponentiElaborazione;
    property DataInizio: TDateTime read FDataInizio write FDataInizio;
    property DataFine: TDateTime read FDataFine write FDataFine;
  end;

implementation

{$R *.dfm}

procedure TA041FInsRiposiMW.DataModuleCreate(Sender: TObject);
begin
  inherited;
  selDatiBloccati:=TDatiBloccati.Create(Self);
  R600DtM1:=TR600Dtm1.Create(Self);
  R502ProDtM1:=nil;
  R400:=nil;
  Q265.Open;
  Q275.Open;
  QCausale1.Open;
end;

procedure TA041FInsRiposiMW.InizializzaComponentiElaborazione;
begin
  QSRiposo:=TQueryStorico.Create(nil);
  QSRiposo.Session:=SessioneOracle;

  R400:=TR400FCartellinoDtM.Create(nil);  //Alberto 19/06/2006
  R400.A027SelAnagrafe:=SelAnagrafe;
  R400.SoloAggiornamento:=True;
  SalvaRiposi:=TStringList.Create;
  Esegui:=True;
end;

procedure TA041FInsRiposiMW.InizializzaSelDatiBloccati;
begin
  selDatiBloccati.Close;
  selDatiBloccati.TipoLog:='';
end;

procedure TA041FInsRiposiMW.ChiusuraInserimento(FineMese:TDateTime;InserimentoRiposo: Boolean;SalvaRiposi: TStringList);
var
  DataCorr:TDateTime;
  NRipDaEliminare,i:Integer;
  Riga:String;
begin
  if InserimentoRiposo and (selT267.FieldByName('LIMITE_SALDO').AsString = 'S') then
  begin
    DataCorr:=DataInizio;
    while (R180Anno(DataCorr) <= R180Anno(DataFine)) and (R180Mese(DataCorr) <= R180Mese(DataFine)) do  //Lorena 10/02/2006
    begin
      R400.NumGiorniCartolina:=0;
      try
        R400.CartolinaDipendente(SelAnagrafe.FieldByName('PROGRESSIVO').AsInteger,R180Anno(DataCorr),R180Mese(DataCorr),1,R180GiorniMese(DataCorr));
      except
        on E: Exception do
        begin
          Riga:=SelAnagrafe.FieldByName('MATRICOLA').AsString + ' - ' + SelAnagrafe.FieldByName('COGNOME').AsString + ' ' +
                SelAnagrafe.FieldByName('NOME').AsString + ': ATTENZIONE Inserimento riposi fallito - cartolina dipendente non elaborabile - ';
          //R180AppendFile(NomeFile,Riga);
          //R180AppendFile(NomeFile,'  ' + E.Message);
          RegistraMsg.InserisciMessaggio('A',Riga,'',SelAnagrafe.FieldByName('PROGRESSIVO').AsInteger);
          RegistraMsg.InserisciMessaggio('A','  ' + E.Message,'',SelAnagrafe.FieldByName('PROGRESSIVO').AsInteger);
        end;
      end;
      if (R400.R502ProDtM1.giornlav = 0) or (R400.R502ProDtM1.minmonteore = 0) then
        NRipDaEliminare:=0
      else
        NRipDaEliminare:=-Trunc(Min(0,R400.R450DtM1.salannoatt)/(R400.R502ProDtM1.minmonteore/R400.R502ProDtM1.giornlav));
      for i:=1 to SalvaRiposi.Count do
        if (NRipDaEliminare > 0) and (R180Mese(StrToDateTime(SalvaRiposi[SalvaRiposi.Count-i])) = R180Mese(DataCorr)) then
        begin
          PulRiposi(SelAnagrafe.FieldByName('PROGRESSIVO').AsInteger,StrToDateTime(SalvaRiposi[SalvaRiposi.Count-i]),StrToDateTime(SalvaRiposi[SalvaRiposi.Count-i]));
          NRipDaEliminare:=NRipDaEliminare-1;
        end;
      DataCorr:=R180FineMese(DataCorr)+1;
    end;
    //FreeAndNil(R400);
  end;

  (*if selT267.FieldByName('SMONTO_NOTTE').AsString = 'E'  then
    FreeAndNil(R502ProDtM1);*)
  if InserimentoRiposo then
  begin
    RegistraLog.SettaProprieta('I','T040_GIUSTIFICATIVI',NomeOwner,nil,True);
    RegistraLog.InserisciDato('PROGRESSIVO','',IntToStr(SelAnagrafe.FieldByName('PROGRESSIVO').AsInteger));
    RegistraLog.InserisciDato('DAL - AL','',Format('%s - %s',[DateToStr(R180InizioMese(FineMese)),DateToStr(FineMese)]));
    RegistraLog.InserisciDato('CAUSALE','',Format('%s/%s',[selT267.FieldByName('RIPOSO_ORDINARIO').AsString,selT267.FieldByName('RIPOSO_COMPENSATIVO').AsString]));
    RegistraLog.RegistraOperazione;
  end;
end;

function TA041FInsRiposiMW.PreparaInserimento(Tipo:String;(*InizioMese*)DataMese:TDateTime): Boolean;
var Riga,CodInt:String;
begin
  //Recupero:=0;
  Result:=True;
  if R180InizioMese(DataMese) = DataMese then
    Esegui:=True;

  //Verifica che il periodo non sia bloccato alle modifiche
  if selDatiBloccati.DatoBloccato(SelAnagrafe.FieldByName('PROGRESSIVO').AsInteger,R180InizioMese(DataMese),'T040') then
  begin
    Result:=False;
    Riga:=SelAnagrafe.FieldByName('MATRICOLA').AsString + ' - ' + SelAnagrafe.FieldByName('COGNOME').AsString + ' ' +
          SelAnagrafe.FieldByName('NOME').AsString + ': ATTENZIONE Inserimento riposi fallito ';
    //R180AppendFile(NomeFile,Riga);
    //R180AppendFile(NomeFile,'  ' + selDatiBloccati.MessaggioLog);
    RegistraMsg.InserisciMessaggio('A',Riga,'',SelAnagrafe.FieldByName('PROGRESSIVO').AsInteger);
    RegistraMsg.InserisciMessaggio('A','  ' + selDatiBloccati.MessaggioLog,'',SelAnagrafe.FieldByName('PROGRESSIVO').AsInteger);
    Exit;
  end;
  //Leggo il dato anagrafico ad ogni fine mese
  if Trim(Parametri.CampiRiferimento.C16_INSRIPOSI) = '' then
    QSRiposo.GetDatiStorici('T430TGESTIONE,T430INIZIO,T430FINE',SelAnagrafe.FieldByName('PROGRESSIVO').AsInteger,R180InizioMese(DataMese),R180FineMese(DataMese))
  else
    QSRiposo.GetDatiStorici('T430TGESTIONE,T430INIZIO,T430FINE,T430' + Parametri.CampiRiferimento.C16_INSRIPOSI,SelAnagrafe.FieldByName('PROGRESSIVO').AsInteger,R180InizioMese(DataMese),R180FineMese(DataMese));
  if not QSRiposo.LocDatoStorico(DataMese) then
  begin
    Result:=False;
    Exit;
  end;
  //GestioneTurnista:=QSRiposo.FieldByName('T430TGESTIONE').AsString;
  //Cerco le regole in base al dato anagrafico trovato
  if Trim(Parametri.CampiRiferimento.C16_INSRIPOSI) = '' then
    CodInt:='<UNICA>'
  else
    CodInt:=QSRiposo.FieldByName('T430' + Parametri.CampiRiferimento.C16_INSRIPOSI).AsString;
  if (VarToStr(selT267.Getvariable('CODICE')) <> CodInt) or (VarToStr(selT267.Getvariable('TIPO')) <> Tipo) then
  begin
    selT267.Close;
    selT267.SetVariable('CODICE',CodInt);
    selT267.SetVariable('TIPO',Tipo);
  end;
  try
    selT267.Open;
  except
    Result:=False;
    Exit;
  end;
  if selT267.RecordCount = 0 then
  begin
    (* Alberto 03/05/2010: non si scrive più il messaggio di regole non trovate
    if Tipo = 'R' then
    begin
      Riga:=C700SelAnagrafe.FieldByName('MATRICOLA').AsString + ' - ' + C700SelAnagrafe.FieldByName('COGNOME').AsString + ' ' +
            C700SelAnagrafe.FieldByName('NOME').AsString + ': ATTENZIONE Inserimento riposi fallito ';
      //R180AppendFile(NomeFile,Riga);
      //R180AppendFile(NomeFile,'  Regole non trovate per il dipendente corrente!');
      RegistraMsg.InserisciMessaggio('A',Riga,'',C700Progressivo);
      RegistraMsg.InserisciMessaggio('A','  Regole non trovate per il dipendente corrente!','',C700Progressivo);
      Anomalie:=True;
    end;
    *)
    Result:=False;
    Exit;
  end;
  if Esegui then
  begin
    Esegui:=False;
    if selT267.FieldByName('LIMITE_SALDO').AsString = 'S' then
      SalvaRiposi.Clear;
    if selT267.FieldByName('SMONTO_NOTTE').AsString = 'E' then
    begin
      if R502ProDtM1 = nil then
      begin
        R502ProDtM1:=TR502ProDtM1.Create(nil);
        R502ProDtM1.PeriodoConteggi(DataInizio - 1,DataFine + 1);
      end;
    end;
    //Pulizia riposi esistenti
    if selT267.FieldByName('CANCELLAZIONE_CAUSALE').AsString = 'S' then
      PulRiposi(SelAnagrafe.FieldByName('PROGRESSIVO').AsInteger,R180InizioMese(DataMese),R180FineMese(DataMese));
    //Alberto 14/09/2006: Lettura timbature e giustificativi del mese
    QTimbrature.SetVariable('PROGRESSIVO',SelAnagrafe.FieldByName('PROGRESSIVO').AsInteger);
    QTimbrature.SetVariable('DATA1',R180InizioMese(DataMese));
    QTimbrature.SetVariable('DATA2',R180FineMese(DataMese));
    QTimbrature.Close;
    QTimbrature.Open;
    QGiustificativi.SetVariable('PROGRESSIVO',SelAnagrafe.FieldByName('PROGRESSIVO').AsInteger);
    QGiustificativi.SetVariable('DATA1',R180InizioMese(DataMese));
    QGiustificativi.SetVariable('DATA2',R180FineMese(DataMese));
    QGiustificativi.Close;
    QGiustificativi.Open;
    //Alberto 14/09/2006: Inizializzazione per resettare SettaConteggi nel mese successivo
    UltimaCausaleConteggiata:='';
  end;
end;

procedure TA041FInsRiposiMW.PulRiposi(Prog:Integer;DataI,DataF:TDateTime);
{Elimino i giorni di riposo esistenti sulla T040Giustificativi.}
begin
  delT040.SetVariable('Progressivo',Prog);
  delT040.SetVariable('Data1',DataI);
  delT040.SetVariable('Data2',DataF);
  delT040.SetVariable('Causale1',selT267.FieldByName('RIPOSO_ORDINARIO').AsString);
  delT040.SetVariable('Causale2',selT267.FieldByName('RIPOSO_COMPENSATIVO').AsString);
  delT040.SetVariable('Causale3',selT267.FieldByName('RIPOSO_MESEPREC').AsString);
  delT040.SetVariable('Causale4',selT267.FieldByName('RIPOSO_LAVORATO').AsString);
  try
    delT040.Execute;
    SessioneOracle.Commit;
  except
  end;
end;

procedure TA041FInsRiposiMW.Inserimento(Tipo:String;DataCorr:TDateTime);
var InserisciGiornoRiposo,ControllaTimbrature,ContGen,TimbGiusOK:Boolean;
    Causale,Riga:String;
    i:Integer;
    Residuo,CompTot:Real;
begin
  Residuo:=0;
  InserisciGiornoRiposo:=False;
  Giustif.Inserimento:=True;
  Giustif.Modo:='I';
  Giustif.DaOre:='.';
  Giustif.AOre:='.';
  if QSRiposo.LocDatoStorico(DataCorr) then
  begin
    GestioneTurnista:=Trim(QSRiposo.FieldByName('T430TGESTIONE').AsString);
    //Test se dipendente in servizio
    if (QSRiposo.FieldByName('T430INIZIO').AsDateTime > DataCorr) or
       (QSRiposo.FieldByName('T430INIZIO').AsDateTime <= DataCorr) and (not QSRiposo.FieldByName('T430FINE').IsNull) and (QSRiposo.FieldByName('T430FINE').AsDateTime < DataCorr) then
      Exit;
  end
  else
    Exit;
  //Controllo inserimento per dip.non turnisti
  if GestioneTurnista <> '1' then  //DIP. NON TURNISTA
    if (selT267.FieldByName('PERSONALE_NON_TURNISTA').AsString = 'N') and
       (selT267.FieldByName('LIMITE_SALDO').AsString = 'N') and
       (Tipo = 'R') then
    begin
      Exit;
    end
    else if (selT267.FieldByName('PERSONALE_NON_TURNISTA').AsString = 'S') and (Tipo = 'R') then
    begin
      if not RiposoNonTurnista(DataCorr) then
      begin
        Exit;
      end;
    end;
  //Alberto 14/09/2006: filtro timbrature/giustificativi sul giorno corrente
  QGiustificativi.Filtered:=False;
  QGiustificativi.Filter:='(VALSETIMB = ''N'') AND (DATA = ' + FloatToStr(DataCorr) + ')';
  QGiustificativi.Filtered:=True;
  QGiustificativi.First;
  QTimbrature.Filtered:=False;
  QTimbrature.Filter:='DATA = ' + FloatToStr(DataCorr);
  QTimbrature.Filtered:=True;
  QTimbrature.First;
  //Controlli vari
  if QGiustificativi.RecordCount > 0 then  // controllo giustificativi
    ControllaTimbrature:=GiustificativiOK(DataCorr)
  else
    ControllaTimbrature:=True;
  if ControllaTimbrature then
  begin
    if QTimbrature.RecordCount > 0 then  // controllo timbrature
      InserisciGiornoRiposo:=TimbratureOK(DataCorr)
    else
      InserisciGiornoRiposo:=True;
  end;
  TimbGiusOK:=InserisciGiornoRiposo;
  if InserisciGiornoRiposo then //Lorena 20/03/2006: controllo pianif.reperibilità
    if selT267.FieldByName('SOLO_SE_NON_REPERIBILE').AsString = 'S' then
      InserisciGiornoRiposo:=ReperibilitaOK(DataCorr);
  if InserisciGiornoRiposo then
  begin
    Causale:='';
    //Controllo su 3° riposo - causale di Recupero
    if selT267.FieldByName('RIPOSO_MESEPREC').AsString <> '' then
    begin
      Giustif.Causale:=selT267.FieldByName('RIPOSO_ORDINARIO').AsString;
      R600DtM1.ListAnomalie.Clear;
      R600DtM1.GetAssenze(SelAnagrafe.FieldByName('PROGRESSIVO').AsInteger,R180InizioMese(DataCorr)-1,R180InizioMese(DataCorr)-1,0,Giustif);
      UltimaCausaleConteggiata:='';
      CompRip:=StrToFloatDef(R600DtM1.GetCompTot,0);
      FruitoRip:=StrToFloatDef(R600DtM1.GetFruitoTot,0);
      Residuo:=CompRip - FruitoRip - Recupero;
    end;
    if Residuo > 0 then
    begin
      Giustif.Causale:=selT267.FieldByName('RIPOSO_MESEPREC').AsString;
      R600DtM1.ListAnomalie.Clear;
      R600DtM1.SettaConteggi(SelAnagrafe.FieldByName('PROGRESSIVO').AsInteger,DataCorr,DataCorr,Giustif);
      UltimaCausaleConteggiata:='';
      R600DtM1.ListAnomalie.Clear;
      R600DtM1.VisualizzaAnomalie:=False;
      if R600DtM1.ControlliGenerali(DataCorr) = mrOk then
      begin
        Causale:=selT267.FieldByName('RIPOSO_MESEPREC').AsString;
        Recupero:=Recupero + 1;
      end;
    end;
    if (Residuo <= 0) or (Causale = '') then
    begin
      //Controllo su R600: Calcolo competenze e fruito su 1° Riposo
      Giustif.Causale:=selT267.FieldByName('RIPOSO_ORDINARIO').AsString;
      R600DtM1.ListAnomalie.Clear;
      if (Tipo = 'F') or (VarToStr(Q265.Lookup('CODICE',selT267.FieldByName('RIPOSO_ORDINARIO').AsString,'CQ_PROGRESSIVO')) = 'S') then
      begin  //Maturazione progressiva
        R600DtM1.GetAssenze(SelAnagrafe.FieldByName('PROGRESSIVO').AsInteger,DataCorr,DataCorr,0,Giustif);
        UltimaCausaleConteggiata:='';
        //Alberto 14/09/2006: le competenze si leggono dopo ControlliGenerali
        //CompRip:=StrToFloatDef(R600DtM1.GetCompTot,0);
        //FruitoRip:=StrToFloatDef(R600DtM1.GetFruitoTot,0);
      end
      else  //Maturazione non progressiva
      begin
         //Alberto 14/09/2006: GetAssenze solo se sono su una causale diversa o su un nuovo mese,
         //altrimenti si sfrutta ControlliGenerali che mantiene aggiornate le competenze
        if UltimaCausaleConteggiata <> Giustif.Causale then
        begin
          R600DtM1.GetAssenze(SelAnagrafe.FieldByName('PROGRESSIVO').AsInteger,DataCorr,R180FineMese(DataCorr),0,Giustif);
          UltimaCausaleConteggiata:=Giustif.Causale;
        end;
        //CompRip:=StrToFloatDef(R600DtM1.GetCompTot,0);
        //FruitoRip:=StrToFloatDef(R600DtM1.GetFruitoTot,0);
      end;
      R600DtM1.ListAnomalie.Clear;
      R600DtM1.VisualizzaAnomalie:=False;
      ContGen:=R600DtM1.ControlliGenerali(DataCorr) = mrOk;
      CompTot:=0;
      for i:=1 to High(R600DtM1.Competenze) do
        CompTot:=CompTot + R600DtM1.Competenze[i];
      //Alberto 14/09/2006: Si testa direttamente Competenze
      //if ContGen and (FruitoRip < CompRip) then
      if ContGen and (CompTot >= 0) then
        Causale:=selT267.FieldByName('RIPOSO_ORDINARIO').AsString
      //Alberto 14/09/2006: se la causale di riposo compensativo è la stessa, non si effettua alcun conteggio aggiuntivo
      else if ContGen and (selT267.FieldByName('RIPOSO_ORDINARIO').AsString = selT267.FieldByName('RIPOSO_COMPENSATIVO').AsString) then
        Causale:=selT267.FieldByName('RIPOSO_ORDINARIO').AsString
      else if selT267.FieldByName('RIPOSO_COMPENSATIVO').AsString <> '' then
      begin
        //Riposi compensativi
        Giustif.Causale:=selT267.FieldByName('RIPOSO_COMPENSATIVO').AsString;
        R600DtM1.ListAnomalie.Clear;
        //Alberto 14/09/2006: Settaconteggi solo se la causale è diversa, altrimenti basta ControlliGenerali
        if UltimaCausaleConteggiata <> Giustif.Causale then
        begin
          R600DtM1.SettaConteggi(SelAnagrafe.FieldByName('PROGRESSIVO').AsInteger,DataCorr,DataCorr,Giustif);
          UltimaCausaleConteggiata:=Giustif.Causale;
        end;
        R600DtM1.ListAnomalie.Clear;
        R600DtM1.VisualizzaAnomalie:=False;
        if R600DtM1.ControlliGenerali(DataCorr) = mrOk then
        begin
          Causale:=selT267.FieldByName('RIPOSO_COMPENSATIVO').AsString;
          if selT267.FieldByName('LIMITE_SALDO').AsString = 'S' then
            SalvaRiposi.Add(DateToStr(DataCorr));
        end;
      end;
    end;
  end
  else if (GestioneTurnista <> '1') and (Tipo = 'R') and (not TimbGiusOK) and
          (Trim(selT267.FieldByName('RIPOSO_LAVORATO').AsString) <> '') then
  begin
    //Alberto 17/02/2007: Giustificativo su domeniche/festivi lavorati per Vercelli
    {Il campo RIPOSO_LAVORATO può essere abilitato solo se:
      - la regola è di tipo 'R'
      - attivato Ins. su personale non turnista
      - disattivato Ins. su gg non lav con timbr....
    }
    Giustif.Causale:=Trim(selT267.FieldByName('RIPOSO_LAVORATO').AsString);
    R600DtM1.ListAnomalie.Clear;
    if VarToStr(Q265.Lookup('CODICE',Giustif.Causale,'CQ_PROGRESSIVO')) = 'S' then
      begin  //Maturazione progressiva
        R600DtM1.GetAssenze(SelAnagrafe.FieldByName('PROGRESSIVO').AsInteger,DataCorr,DataCorr,0,Giustif);
        UltimaCausaleConteggiata:='';
      end
      else  //Maturazione non progressiva
      begin
        if UltimaCausaleConteggiata <> Giustif.Causale then
        begin
          R600DtM1.GetAssenze(SelAnagrafe.FieldByName('PROGRESSIVO').AsInteger,DataCorr,R180FineMese(DataCorr),0,Giustif);
          UltimaCausaleConteggiata:=Giustif.Causale;
        end;
      end;
    R600DtM1.ListAnomalie.Clear;
    R600DtM1.VisualizzaAnomalie:=False;
    ContGen:=R600DtM1.ControlliGenerali(DataCorr) = mrOk;
    CompTot:=0;
    for i:=1 to High(R600DtM1.Competenze) do
      CompTot:=CompTot + R600DtM1.Competenze[i];
    InserisciGiornoRiposo:=True;
    if ContGen and (CompTot >= 0) then
      Causale:=Giustif.Causale
    else
      Causale:='';
  end;
  if InserisciGiornoRiposo then
  begin
    //Inserimento giornata di riposo
    if Trim(Causale) = '' then
    begin
      if Trim(R600DtM1.ListAnomalie.Text) <> '' then
      begin
        Riga:=SelAnagrafe.FieldByName('MATRICOLA').AsString + ' - ' + SelAnagrafe.FieldByName('COGNOME').AsString + ' ' +
              SelAnagrafe.FieldByName('NOME').AsString + ': ATTENZIONE Inserimento ' + Giustif.Causale + ' fallito sul giorno ' + DateToStr(DataCorr);
        //R180AppendFile(NomeFile,Riga);
        //R180AppendFile(NomeFile,'  ' + R600DtM1.ListAnomalie.Text);
        RegistraMsg.InserisciMessaggio('A',Riga,'',SelAnagrafe.FieldByName('PROGRESSIVO').AsInteger);
        RegistraMsg.InserisciMessaggio('A','  ' + R600DtM1.ListAnomalie.Text,'',SelAnagrafe.FieldByName('PROGRESSIVO').AsInteger);
      end;
    end;
    if (Trim(Causale) <> '') and AddGiornoRiposo(SelAnagrafe.FieldByName('PROGRESSIVO').AsInteger,DataCorr,Causale) then
      InserimentoRiposo:=True;
  end;
end;

function TA041FInsRiposiMW.RiposoNonTurnista(Data:TDateTime):Boolean;
{Restituisce True se il giorno passato come parametro è non lavorativo oppure
festivo: si basa sulla procedura GetCalendario già richiamata precedentemente}
begin
  with GetCalendario do
  begin
    SetVariable('PROG',SelAnagrafe.FieldByName('PROGRESSIVO').AsInteger);
    SetVariable('D',Data);
    Execute;
    Result:=(VarToStr(GetVariable('L')) = 'N') or (VarToStr(GetVariable('F')) = 'S');
  end;
end;

//------------------------------------------------------------------------------
// Scorro la query con i giustificativi per vedere se:
// - il giustificativo è di assenza e l'assenza è disabilitata
// - il giustificativo è di presenza e la presenza è abilitata
// - il giustificativo è su un giorno festivo-non lav.-domenica-gg.significativo
function TA041FInsRiposiMW.GiustificativiOK(Data:TDateTime):Boolean;
begin
  Result:=True;
  QGiustificativi.First;
  while not(QGiustificativi.EOF) do
  begin
    //Se la causale non accetta riposi (indipendentemente dal tipo di giorno) esco
    if QGiustificativi.FieldByName('TipoGiust').AsString = 'I' then
    begin
      if Q265.SearchRecord('CODICE',QGiustificativi.FieldByName('Causale').AsString,[srFromBeginning]) then //Giust.assenza
        if CausaleDisabilitata(QGiustificativi.FieldByName('Causale').AsString) then
        begin
          Result:=False;
          Break;
        end;
    end;
    if Q265.SearchRecord('CODICE',QGiustificativi.FieldByName('Causale').AsString,[srFromBeginning]) then //Giust.assenza
    begin
      Result:=GiornoFestivo(Data);
      if Result then
      begin
        //Causale il cui codice interno = 'H' (Riposo)
        if QCausale1.Locate('T265Codice',QGiustificativi.FieldByName('Causale').AsString,[]) then
        begin
          Result:=False;
          Break;
        end;
        //Causale significativa sui Giorni di Calendario
        if (selT267.FieldByName('GGCALEND_GIUSTIFICATO').AsString = 'S') and (VarToStr(Q265.Lookup('Codice',QGiustificativi.FieldByName('Causale').AsString,'GSignific')) <> 'GC') then
        begin
          Result:=False;
          Break;
        end;
      end
      else
        Break;
    end
    else if Q275.SearchRecord('CODICE',QGiustificativi.FieldByName('Causale').AsString,[srFromBeginning]) then
      if not CausalePresenzaAbilitata(QGiustificativi.FieldByName('Causale').AsString) then //Giust.presenza
      begin
        Result:=False;
        Break;
      end;
    QGiustificativi.Next;
  end;
end;

//------------------------------------------------------------------------------
//Scorro la query con le timbrature del giorno per vedere se:
//- ho uno smonto notte
//- ci sono timbrature non causalizzate
//- ci sono timbrature causalizzate con causali di presenza checked
function TA041FInsRiposiMW.TimbratureOK(Data:TDateTime):Boolean;
var PrimaTimb:Boolean;
begin
  Result:=True;
  PrimaTimb:=True;
  QTimbrature.First;
  while not(QTimbrature.EOF) do  //Ciclo su tutte le timbrature del giorno
  begin
    //Lorena 20/03/2006: controllo GGNONLAV_CON_TIMBRATURE
    if PrimaTimb and (QTimbratureVerso.AsString = 'U') then  //Prima timbratura = uscita
    begin
      Result:=ControlloSmontoNotte(Data,QTimbratureCausale.AsString);
      if not Result then
        Break;
    end
    else if QTimbratureCausale.IsNull then  //Entrata-Uscita non causalizzata
    begin
      if (selT267.FieldByName('GGNONLAV_CON_TIMBRATURE').AsString = 'N') or (GestioneTurnista = '1') or
       ((selT267.FieldByName('GGNONLAV_CON_TIMBRATURE').AsString = 'S') and (not RiposoNonTurnista(Data))) then
      begin
        Result:=False;
        Break;
      end;
    end
    else //Entrata caus. - Uscita caus.
    begin
      Result:=CausalePresenzaAbilitata(Trim(QTimbratureCausale.AsString));
      if not Result then Break;
    end;
    QTimbrature.Next;
    PrimaTimb:=False;
  end;
end;

function TA041FInsRiposiMW.ReperibilitaOK(Data:TDateTime):Boolean;
begin
  Result:=True;
  selT380.SetVariable('PROG',SelAnagrafe.FieldByName('PROGRESSIVO').AsInteger);
  selT380.SetVariable('DATA',Data);
  selT380.Execute;
  if selT380.Field(0) > 0 then
    Result:=False;
end;

function TA041FInsRiposiMW.AddGiornoRiposo(Prog:Integer;Data:TDateTime;Causale:String):Boolean;
{Inserisco un giorno di riposo sulla T040Giustificativi.}
var Riga:String;
begin
  Result:=False;
  QInsGiustificativi.SetVariable('Causale',Causale);
  QInsGiustificativi.SetVariable('Progressivo',Prog);
  QInsGiustificativi.SetVariable('Data',Data);
  QInsGiustificativi.SetVariable('ProgrCausale',0);
  QInsGiustificativi.SetVariable('TipoGiust','I');
  try
    QInsGiustificativi.Execute;
    SessioneOracle.Commit;
    Result:=True;
  except
    on E: Exception do
    begin
      Riga:=SelAnagrafe.FieldByName('MATRICOLA').AsString + ' - ' + SelAnagrafe.FieldByName('COGNOME').AsString + ' ' +
            SelAnagrafe.FieldByName('NOME').AsString + ': ATTENZIONE Inserimento ' + Causale + ' fallito sul giorno ' + DateToStr(Data);
      //R180AppendFile(NomeFile,Riga);
      //R180AppendFile(NomeFile,'  ' + E.Message);
      RegistraMsg.InserisciMessaggio('A',Riga,'',SelAnagrafe.FieldByName('PROGRESSIVO').AsInteger);
      RegistraMsg.InserisciMessaggio('A','  ' + E.Message,'',SelAnagrafe.FieldByName('PROGRESSIVO').AsInteger);
    end;
  end;
end;

function TA041FInsRiposiMW.CausaleDisabilitata(Codice:String):Boolean;
{Restituisce True se il codice della causale è selezionata nella lista delle causali da non considerare}
var i:Integer;
  lstAssenze:TStringList;
begin
  Result:=False;
  lstAssenze:=TStringList.Create;
  lstAssenze.Clear;
  lstAssenze.CommaText:=selT267.FieldByName('CAUS_ASSENZA_NONTOLLERATE').AsString;
  for i:=0 to lstAssenze.Count - 1 do
    if (Trim(Copy(lstAssenze[i],1,5)) = Codice) then
    begin
      Result:=True;
      Break;
    end;
  FreeAndNil(lstAssenze);
end;

function TA041FInsRiposiMW.GiornoFestivo(Data:TDateTime):Boolean;
begin
  with GetCalendario do
  begin
    if (StrToIntDef(VarToStr(GetVariable('PROG')),0) <> SelAnagrafe.FieldByName('PROGRESSIVO').AsInteger) or (R180VarToDateTime(GetVariable('D')) <> Data) then
    begin
      SetVariable('PROG',SelAnagrafe.FieldByName('PROGRESSIVO').AsInteger);
      SetVariable('D',Data);
      Execute;
    end;
    Result:=(DayOfWeek(Data) = 1) and (selT267.FieldByName('DOMENICA_GIUSTIFICATA').AsString = 'S');  //Domenica
    if Result then exit;
    Result:=(VarToStr(GetVariable('L')) = 'N') and (selT267.FieldByName('GGNONLAV_GIUSTIFICATO').AsString = 'S');  //Non lav.
    if Result then exit;
    Result:=(VarToStr(GetVariable('F')) = 'S') and (selT267.FieldByName('GGFEST_GIUSTIFICATO').AsString = 'S'); //Festivo
  end;
end;

function TA041FInsRiposiMW.CausalePresenzaAbilitata(Codice:String):Boolean;
{Restituisce True se il codice della causale è selezionata nella lista delle causali di presenza da considerare}
var i:Integer;
  lstPresenze:TStringList;
begin
  Result:=False;
  lstPresenze:=TStringList.Create;
  lstPresenze.Clear;
  lstPresenze.CommaText:=selT267.FieldByName('CAUS_PRESENZA_TOLLERATE').AsString;
  for i:=0 to lstPresenze.Count - 1 do
    if (Trim(Copy(lstPresenze[i],1,5)) = Codice) then
    begin
      Result:=True;
      Break;
    end;
  FreeAndNil(lstPresenze);
end;

function TA041FInsRiposiMW.ControlloSmontoNotte(Data:TDateTime;Causale:String):Boolean;
var i:Integer;
begin
  Result:=(selT267.FieldByName('SMONTO_NOTTE').AsString = 'S') or
          (selT267.FieldByName('SMONTO_NOTTE').AsString = 'E');
  if selT267.FieldByName('SMONTO_NOTTE').AsString = 'E' then  //Vercelli
    with R502ProDtM1 do
    begin
      Conteggi('Cartolina',SelAnagrafe.FieldByName('PROGRESSIVO').AsInteger,Data - 1);
      for i:=1 to n_timbrdip do
      begin
        if ttimbraturedip[i].tpuntnomin <> 0 then  //Timb.non causalizz.
        begin
          if (ttimbraturenom[ttimbraturedip[i].tpuntnomin].tpuntre <> 0) and
             (ttimbraturenom[ttimbraturedip[i].tpuntnomin].tpuntru <> 0) and
             (ttimbraturenom[ttimbraturedip[i].tpuntnomin].tminutin_e < ttimbraturenom[ttimbraturedip[i].tpuntnomin].tminutin_u) then
          begin
            Result:=False;
            Break;
          end;
        end
        else if ttimbraturedip[i].tcausale_e.tcaus <> '' then  //Timb.causalizz.
        begin
          if (ttimbraturedip[i].tminutid_e <> 0) and (ttimbraturedip[i].tminutid_u <> 1440) then
          begin
            Result:=CausalePresenzaAbilitata(Trim(ttimbraturedip[i].tcausale_e.tcaus));
            if not Result then Break;
          end;
        end;
      end;
    end;
  if (selT267.FieldByName('SMONTO_NOTTE').AsString <> 'E') and (Trim(Causale) <> '') then  //Smonto notte causalizzato
    Result:=(Result) or (CausalePresenzaAbilitata(Trim(Causale)));
end;

procedure TA041FInsRiposiMW.ElaboraDipendente;
var
  DataCorr,OldInizio,OldFine: TDateTime;
begin
  //Elaborazione ciclo Festivi infrasettimanali
  DataCorr:=DataInizio;
  OldFine:=R180FineMese(DataInizio);
  InserimentoRiposo:=False;
  while DataCorr <= DataFine do
  begin
    if PreparaInserimento('I',DataCorr) then
      InserimentoFestInfrasett('I',DataCorr);
    DataCorr:=DataCorr+1;
    if R180FineMese(DataCorr) <> OldFine then  //Cambio mese
    begin
      ChiusuraInserimento(OldFine,InserimentoRiposo,SalvaRiposi);
      InserimentoRiposo:=False;
      OldFine:=R180FineMese(DataCorr);
    end;
  end;
  //Elaborazione ciclo Riposi
  DataCorr:=DataInizio;
  OldInizio:=0;
  OldFine:=R180FineMese(DataInizio);
  InserimentoRiposo:=False;
  while DataCorr <= DataFine do
  begin
    if R180InizioMese(DataCorr) <> OldInizio then  //Cambio mese
    begin
      //PreparaInserimento('R',R180InizioMese(DataCorr));
      Recupero:=0;
      OldInizio:=R180InizioMese(DataCorr);
    end;
    if PreparaInserimento('R',DataCorr) then
      Inserimento('R',DataCorr);
    DataCorr:=DataCorr+1;
    if R180FineMese(DataCorr) <> OldFine then  //Cambio mese
    begin
      ChiusuraInserimento(OldFine,InserimentoRiposo,SalvaRiposi);
      InserimentoRiposo:=False;
      OldFine:=R180FineMese(DataCorr);
    end;
  end;
  //Elaborazione ciclo Festività
  DataCorr:=DataInizio;
  OldInizio:=0;
  OldFine:=R180FineMese(DataInizio);
  InserimentoRiposo:=False;
  while DataCorr <= DataFine do
  begin
    if PreparaInserimento('F',DataCorr) then
      Inserimento('F',DataCorr);
    DataCorr:=DataCorr+1;
    if R180FineMese(DataCorr) <> OldFine then  //Cambio mese
    begin
      ChiusuraInserimento(OldFine,InserimentoRiposo,SalvaRiposi);
      InserimentoRiposo:=False;
      OldFine:=R180FineMese(DataCorr);
      UltimaCausaleConteggiata:='';
    end;
  end;
end;

procedure TA041FInsRiposiMW.InserimentoFestInfrasett(Tipo:String;DataCorr:TDateTime);
var InserisciGiornoRiposo:Boolean;
begin
  InserisciGiornoRiposo:=False;
  Giustif.Inserimento:=True;
  Giustif.Modo:='I';
  Giustif.DaOre:='.';
  Giustif.AOre:='.';

  Giustif.Causale:=selT267.FieldByName('RIPOSO_ORDINARIO').AsString;
  if QSRiposo.LocDatoStorico(DataCorr) then
  begin
    //Test se dipendente in servizio
    if (QSRiposo.FieldByName('T430INIZIO').AsDateTime > DataCorr) or
       (QSRiposo.FieldByName('T430INIZIO').AsDateTime <= DataCorr) and (not QSRiposo.FieldByName('T430FINE').IsNull) and (QSRiposo.FieldByName('T430FINE').AsDateTime < DataCorr) then
      Exit;
  end
  else
    Exit;
  //Recupero il calendario del dipendente
  GetCalendario.SetVariable('PROG',SelAnagrafe.FieldByName('PROGRESSIVO').AsInteger);
  GetCalendario.SetVariable('D',DataCorr);
  GetCalendario.Execute;
  //Se il giorno fosse lavorativo ma è festivo ed è infrasettimanale (da lunedì a sabato)...
  if (VarToStr(GetCalendario.GetVariable('L')) = 'S')
  and (VarToStr(GetCalendario.GetVariable('F')) = 'S')
  and (DayOfWeek(DataCorr) <> 1) then
  begin
    QGiustificativi.Filtered:=False;
    QGiustificativi.Filter:='(CAUSALE = ''' + Giustif.Causale + ''') AND (DATA = ' + FloatToStr(DataCorr) + ')';
    QGiustificativi.Filtered:=True;
    QGiustificativi.First;
    //Se non è già presente il giustificativo, lo inserisco...
    if (QGiustificativi.RecordCount = 0) and AddGiornoRiposo(SelAnagrafe.FieldByName('PROGRESSIVO').AsInteger,DataCorr,Giustif.Causale) then
      InserimentoRiposo:=True;
  end;
end;

procedure TA041FInsRiposiMW.DistruggiComponentiElaborazione;
begin
  FreeAndNil(QSRiposo);
  if R400 <> nil then
    FreeAndNil(R400);
  FreeAndNil(SalvaRiposi);
end;

procedure TA041FInsRiposiMW.DataModuleDestroy(Sender: TObject);
begin
  FreeAndNil(selDatiBloccati);
  if R502ProDtM1 <> nil then
    try FreeAndNil(R502ProDtM1); except end;
  FreeAndNil(R600DtM1);
  inherited;
end;

end.
