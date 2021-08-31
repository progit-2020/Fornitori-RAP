unit A170UGestioneGruppiMW;

interface

uses
  System.SysUtils, System.Classes, R005UDataModuleMW, Data.DB, OracleData,
  A000UCostanti, Oracle, C180FunzioniGenerali, StrUtils, A000UInterfaccia, A169UCalcoloDTM,
  Generics.Collections;

type
  TPagamenti = record
    max: String;
    perc: Real;
  end;

  TA170FGestioneGruppiMW = class(TR005FDataModuleMW)
    selT773: TOracleDataSet;
    selT773Quote: TOracleDataSet;
    selT767Quote: TOracleDataSet;
    selT767: TOracleDataSet;
    updT773: TOracleQuery;
    selT774: TOracleDataSet;
    selV430: TOracleDataSet;
    ControlloT774: TOracleDataSet;
    updT767: TOracleQuery;
    selT768: TOracleDataSet;
    selV430ScInd: TOracleDataSet;
    selT770: TOracleDataSet;
    ControlloT768: TOracleDataSet;
    ControlloT040: TOracleDataSet;
    selSG735: TOracleDataSet;
    updT767Tot: TOracleQuery;
    selT767New: TOracleDataSet;
    delT767: TOracleQuery;
    procedure DataModuleCreate(Sender: TObject);
  private
    A169FCalcoloDTM: TA169FCalcoloDTM;
  public
    procedure AperturaChiusuraPesature(Anno: Integer; Quota, Gruppi: String;Chiusura: Boolean);
    procedure InizioElaborazioneGruppiPesature;
    function VerificheElaborazioneGruppoPesature(Anno: Integer; Quota, Gruppo: String): Boolean;
    procedure ElaboraGruppoPesature;
    procedure FineElaborazioneGruppiPesature;
    procedure AperturaChiusuraSchede(Anno: Integer; Quota, Gruppi: String;Chiusura: Boolean);
    function VerificheElaborazioneGruppoSchede(Anno: Integer; Quota,Gruppo: String): Boolean;
    procedure ElaboraGruppoSchede(var Tot:Real; var TotOre: Integer);
    procedure ImpostaTotaleGruppoSchede(Tot: Real; TotOre: Integer);
    function VerificaGruppiApertiSchede(Anno: Integer; Quota: String): Integer;
    procedure InizioElaborazionePassaggioAnno(Anno: Integer; Quota: String;DataRif: TDateTime; lstPagamenti: TList<TPagamenti>; var lstGruppi: TStringList);
    procedure FineElaborazionePassaggioAnno(Anno: Integer; Quota: String);
    function ListGruppiSchede(Anno: Integer; Quota: String): TElencoValoriChecklist;
    function ListGruppiPesature(Anno: Integer;Quota: String): TElencoValoriChecklist;
  end;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure TA170FGestioneGruppiMW.DataModuleCreate(Sender: TObject);
begin
  inherited;
  selT767Quote.Open;
end;

function TA170FGestioneGruppiMW.ListGruppiSchede(Anno:Integer; Quota:String): TElencoValoriChecklist;
var
  codice: String;
begin
  Result:=TElencoValoriChecklist.Create;

  with selT767 do
  begin
    Close;
    SetVariable('ANNO',Anno);
    SetVariable('CODQUOTA',Quota);
    SetVariable('FILTRO','');
    Open;
    First;
    while not Eof do
    begin
      codice:=FieldByName('CodGruppo').AsString;
      Result.lstCodice.Add(codice);
      Result.lstDescrizione.Add(Format('%-10s %s',[codice, FieldByName('Descrizione').AsString]));
      Next;
    end;
  end;
end;

function TA170FGestioneGruppiMW.ListGruppiPesature(Anno:Integer; Quota:String): TElencoValoriChecklist;
var
  codice: String;
begin
  Result:=TElencoValoriChecklist.Create;

  with selT773 do
  begin
    Close;
    SetVariable('ANNO',Anno);
    SetVariable('CODQUOTA',Quota);
    SetVariable('FILTRO','');
    Open;
    First;
    while not Eof do
    begin
      codice:=FieldByName('CodGruppo').AsString;
      Result.lstCodice.Add(codice);
      Result.lstDescrizione.Add(Format('%-10s %s',[codice, FieldByName('Descrizione').AsString]));
      Next;
    end;
  end;
end;

procedure TA170FGestioneGruppiMW.AperturaChiusuraSchede(Anno:Integer; Quota: String; Gruppi: String; Chiusura: Boolean);
begin
  updT767.SetVariable('ANNO',Anno);
  updT767.SetVariable('CODQUOTA',Quota);
  updT767.SetVariable('GRUPPI','''' + StringReplace(Gruppi,',',''',''',[rfReplaceAll]) + '''');
  if Chiusura then
    updT767.SetVariable('STATO','C')
  else
    updT767.SetVariable('STATO','A');
  updT767.Execute;
  SessioneOracle.Commit;
end;

procedure TA170FGestioneGruppiMW.AperturaChiusuraPesature(Anno:Integer; Quota: String; Gruppi: String; Chiusura: Boolean);
begin
  updT773.SetVariable('ANNO',Anno);
  updT773.SetVariable('CODQUOTA',Quota);
  updT773.SetVariable('GRUPPI','''' + StringReplace(Gruppi,',',''',''',[rfReplaceAll]) + '''');
  if Chiusura then
    updT773.SetVariable('STATO','S')
  else
    updT773.SetVariable('STATO','N');
  updT773.Execute;
  SessioneOracle.Commit;
end;

procedure TA170FGestioneGruppiMW.InizioElaborazioneGruppiPesature;
begin
  A169FCalcoloDTM:=TA169FCalcoloDTM.Create(Self)
end;

function TA170FGestioneGruppiMW.VerificheElaborazioneGruppoPesature(Anno: Integer;Quota: String; Gruppo: String): Boolean;
var
  s: String;
begin
  Result:=True;

  selT773.Close;
  selT773.SetVariable('ANNO',Anno);
  selT773.SetVariable('CODQUOTA',Quota);
  selT773.SetVariable('FILTRO',' AND CODGRUPPO = ''' + Gruppo + '''');
  selT773.Open;
  if (selT773.RecordCount <= 0) or (selT773.FieldByName('CHIUSO').AsString = 'S') then
  begin
    if selT773.RecordCount <= 0 then
      s:='Il gruppo ''' + Gruppo + ''' non esiste'
    else
      s:='Il gruppo ''' + Gruppo + ''' non è stato elaborato perchè è chiuso';
    RegistraMsg.InserisciMessaggio('A',s,'',0);
    Result:=False;
    Exit;
  end;

  selT774.Close;
  selT774.SetVariable('ANNO',Anno);
  selT774.SetVariable('CODICE',Gruppo);
  selT774.SetVariable('CODQUOTA',Quota);
  selT774.Open;
  //Carico tutti i dip. che verificano il filtro anagrafe del gruppo e sono in servizio dal 1/1/Anno a DataRif
  selV430.Close;
  selV430.SetVariable('DATAINIZIO',StrToDate('01/01/' + Anno.ToString()));
  selV430.SetVariable('DATAFINE',selT773.FieldByName('DATARIF').AsDateTime);
  selV430.SetVariable('FILTRO',selT773.FieldByName('FILTRO_ANAGRAFE').AsString);
  selV430.Open;
  //Cancello tutti i dip. che sono in selT774 ma non in selV430
  selT774.First;
  while not selT774.Eof do
  begin
    if selV430.SearchRecord('PROGRESSIVO',selT774.FieldByName('PROGRESSIVO').AsInteger,[srFromBeginning]) then
      selT774.Next
    else
      selT774.Delete;
  end;
  SessioneOracle.Commit;
  selT774.Refresh;
end;

function TA170FGestioneGruppiMW.VerificheElaborazioneGruppoSchede(Anno: Integer;Quota: String; Gruppo: String): Boolean;
var s: String;
begin
  Result:=True;
  selT767.Close;
  selT767.SetVariable('ANNO',Anno);
  selT767.SetVariable('CODQUOTA',Quota);
  selT767.SetVariable('FILTRO',' AND CODGRUPPO = ''' + Gruppo + '''');
  selT767.Open;
  if (selT767.RecordCount <= 0) or (selT767.FieldByName('STATO').AsString <> 'A') then
  begin
    if selT767.RecordCount <= 0 then
      s:='Il gruppo ''' + Gruppo + ''' non esiste'
    else
      s:='Il gruppo ''' + Gruppo + ''' non è stato elaborato perchè è ' +
      IfThen(selT767.FieldByName('STATO').AsString = 'C','chiuso','in modifica');
    RegistraMsg.InserisciMessaggio('A',s,'',0);
    Result:=False;
    Exit;
  end;

  selT768.Close;
  selT768.SetVariable('ANNO',Anno);
  selT768.SetVariable('CODICE',Gruppo);
  selT768.SetVariable('CODQUOTA',Quota);
  selT768.Open;
  //Carico tutti i dip. che verificano il filtro anagrafe del gruppo e sono in servizio a DataRif
  selV430ScInd.Close;
  s:='T430' + Parametri.CampiRiferimento.C7_Dato1;
  if Parametri.CampiRiferimento.C7_Dato2 <> '' then
    s:=s + ', T430' + Parametri.CampiRiferimento.C7_Dato2;
  if Parametri.CampiRiferimento.C7_Dato3 <> '' then
    s:=s + ', T430' + Parametri.CampiRiferimento.C7_Dato3;
  selV430ScInd.SetVariable('PROFILO',s);
  selV430ScInd.SetVariable('DATARIF',selT767.FieldByName('DATARIF').AsDateTime);
  selV430ScInd.SetVariable('FILTRO',selT767.FieldByName('FILTRO_ANAGRAFE').AsString);
  selV430ScInd.Open;
  //Cancello tutti i dip. che sono in selT768 ma non in selV430
  selT768.First;
  while not selT768.Eof do
  begin
    if selV430ScInd.SearchRecord('PROGRESSIVO',selT768.FieldByName('PROGRESSIVO').AsInteger,[srFromBeginning]) then
      selT768.Next
    else
      selT768.Delete;
  end;
  SessioneOracle.Commit;
  selT768.Refresh;
end;

procedure TA170FGestioneGruppiMW.ElaboraGruppoPesature;
var
  Anomalia: Boolean;
  s: String;
begin
  Anomalia:=False;
  if not selT774.SearchRecord('PROGRESSIVO',selV430.FieldByName('PROGRESSIVO').AsInteger,[srFromBeginning]) then
  begin
    //Controllare che il dip. non verifichi altri filtri, non faccia parte di altri gruppi else anomalia
    ControlloT774.Close;
    ControlloT774.SetVariable('ANNO',selT773.FieldByName('ANNO').AsInteger);
    ControlloT774.SetVariable('GRUPPO',selT773.FieldByName('CODGRUPPO').AsString);
    ControlloT774.SetVariable('PROG',selV430.FieldByName('PROGRESSIVO').AsInteger);
    ControlloT774.SetVariable('INIZIO',selV430.FieldByName('DATAINIZIO').AsDateTime);
    ControlloT774.SetVariable('FINE',selV430.FieldByName('DATAFINE').AsDateTime);
    ControlloT774.Open;
    if ControlloT774.RecordCount > 0 then
    begin
      //Anomalia
      s:='Il dipendente non è stato inserito perchè fa già parte del gruppo ' + ControlloT774.FieldByName('CODGRUPPO').AsString;
      RegistraMsg.InserisciMessaggio('A',s,'',selV430.FieldByName('PROGRESSIVO').AsInteger);
      Anomalia:=True;
    end
    else
    begin
      selT774.Insert;
      selT774.FieldByName('ANNO').AsInteger:=selT773.FieldByName('ANNO').AsInteger;
      selT774.FieldByName('CODGRUPPO').AsString:=selT773.FieldByName('CODGRUPPO').AsString;
      selT774.FieldByName('CODTIPOQUOTA').AsString:=selT773.FieldByName('CODTIPOQUOTA').AsString;
      selT774.FieldByName('PROGRESSIVO').AsInteger:=selV430.FieldByName('PROGRESSIVO').AsInteger;
      selT774.FieldByName('PESO_INDIVIDUALE').AsFloat:=0;
    end;
  end
  else
    selT774.Edit;
  if not Anomalia then
  begin
    selT774.FieldByName('GG_SERVIZIO').AsInteger:=selV430.FieldByName('GGSERVIZIO').AsInteger;
    selT774.FieldByName('DATAINIZIO').AsDateTime:=selV430.FieldByName('DATAINIZIO').AsDateTime;
    selT774.FieldByName('DATAFINE').AsDateTime:=selV430.FieldByName('DATAFINE').AsDateTime;
    A169FCalcoloDTM.CalcolaQuota('C',selT774.FieldByName('CODTIPOQUOTA').AsString,selT774.FieldByName('PROGRESSIVO').AsInteger,selT774.FieldByName('ANNO').AsInteger,
    selT774.FieldByName('GG_SERVIZIO').AsFloat,selT774.FieldByName('PESO_INDIVIDUALE').AsFloat);
    selT774.FieldByName('QUOTA_INDIVIDUALE').AsFloat:=A169FCalcoloDTM.QuotaIndividuale;
    if selT774.FieldByName('QUOTA_INDIVIDUALE').AsFloat = 0 then
      selT774.FieldByName('PESO_INDIVIDUALE').AsFloat:=0;
    selT774.FieldByName('QUOTA_ASSEGNATA').AsFloat:=R180Arrotonda(selT774.FieldByName('QUOTA_INDIVIDUALE').AsFloat * selT774.FieldByName('PESO_INDIVIDUALE').AsFloat,0.01,'P');
    selT774.FieldByName('PESO_CALCOLATO').AsFloat:=A169FCalcoloDTM.PesoCalcolato;
    selT774.FieldByName('QUOTA_CALCOLATA').AsFloat:=A169FCalcoloDTM.QuotaCalcolata;
    if selT774.State = dsEdit then
      selT774.FieldByName('OBIETTIVI_ASSEGNATI').AsString:='S'
    else
      selT774.FieldByName('OBIETTIVI_ASSEGNATI').AsString:='N';
    selT774.Post;
    SessioneOracle.Commit;
  end;
end;

procedure TA170FGestioneGruppiMW.ElaboraGruppoSchede(var Tot:Real; var TotOre: Integer);
var
  PT: Real;
  Anomalia: Boolean;
  s,Dato1,Dato2,Dato3: string;
begin
  Anomalia:=False;
  Dato1:=selV430ScInd.FieldByName('T430' + Parametri.CampiRiferimento.C7_Dato1).AsString;
  Dato2:='';
  if Parametri.CampiRiferimento.C7_Dato2 <> '' then
    Dato2:=selV430ScInd.FieldByName('T430' + Parametri.CampiRiferimento.C7_Dato2).AsString;
    Dato3:='';
  if Parametri.CampiRiferimento.C7_Dato3 <> '' then
    Dato3:=selV430ScInd.FieldByName('T430' + Parametri.CampiRiferimento.C7_Dato3).AsString;
  R180SetVariable(selT770,'DATO1',Dato1);
  R180SetVariable(selT770,'DATO2',Dato2);
  R180SetVariable(selT770,'DATO3',Dato3);
  R180SetVariable(selT770,'QUOTA',selT767.FieldByName('CODTIPOQUOTA').AsString);
  R180SetVariable(selT770,'DATA',selT767.FieldByName('DATARIF').AsDateTime);
  selT770.Open;
  if not selT768.SearchRecord('PROGRESSIVO',selV430ScInd.FieldByName('PROGRESSIVO').AsInteger,[srFromBeginning]) then
  begin
    if (selT770.RecordCount > 0) and (R180OreMinutiExt(selT770.FieldByName('NUM_ORE').AsString) <> 0) and
       (Dato1 <> '') and
       ((Parametri.CampiRiferimento.C7_Dato2 = '') or
       ((Parametri.CampiRiferimento.C7_Dato2 <> '') and (Dato2 <> ''))) and
       ((Parametri.CampiRiferimento.C7_Dato3 = '') or
       ((Parametri.CampiRiferimento.C7_Dato3 <> '') and (Dato3 <> ''))) then
    begin
      //Controllare che il dip. non verifichi altri filtri, non faccia parte di altri gruppi else anomalia
      ControlloT768.Close;
      ControlloT768.SetVariable('ANNO',selT767.FieldByName('ANNO').AsInteger);
      ControlloT768.SetVariable('QUOTA',selT767.FieldByName('CODTIPOQUOTA').AsString);
      ControlloT768.SetVariable('GRUPPO',selT767.FieldByName('CODGRUPPO').AsString);
      ControlloT768.SetVariable('PROG',selV430ScInd.FieldByName('PROGRESSIVO').AsInteger);
      ControlloT768.Open;
      if ControlloT768.RecordCount > 0 then
      begin
        //Anomalia
        s:='Il dipendente non è stato inserito perchè fa già parte del gruppo ' + ControlloT768.FieldByName('CODGRUPPO').AsString;
        RegistraMsg.InserisciMessaggio('A',s,'',selV430ScInd.FieldByName('PROGRESSIVO').AsInteger);
        Anomalia:=True;
      end
      else
      begin
        //Controllare che il dip. non ha lunghe assenze nel giorno Datarif
        ControlloT040.Close;
        ControlloT040.SetVariable('DATA',selT767.FieldByName('DATARIF').AsDateTime);
        ControlloT040.SetVariable('PROG',selV430ScInd.FieldByName('PROGRESSIVO').AsInteger);
        ControlloT040.Open;
        if ControlloT040.RecordCount > 0 then
        begin
          //Anomalia
          s:='Il dipendente non è stato inserito perchè ha una lunga assenza ' + ControlloT040.FieldByName('CAUSALE').AsString;
          RegistraMsg.InserisciMessaggio('A',s,'',selV430ScInd.FieldByName('PROGRESSIVO').AsInteger);
          Anomalia:=True;
        end
        else
        begin
          selT768.Insert;
          selT768.FieldByName('ANNO').AsInteger:=selT767.FieldByName('ANNO').AsInteger;
          selT768.FieldByName('CODGRUPPO').AsString:=selT767.FieldByName('CODGRUPPO').AsString;
          selT768.FieldByName('CODTIPOQUOTA').AsString:=selT767.FieldByName('CODTIPOQUOTA').AsString;
          selT768.FieldByName('PROGRESSIVO').AsInteger:=selV430ScInd.FieldByName('PROGRESSIVO').AsInteger;
        end;
      end;
    end
    else
      Anomalia:=True;
  end
  else
    selT768.Edit;
  if not Anomalia then
  begin
    selT768.FieldByName('DATO1').AsString:=Dato1;
    selT768.FieldByName('DATO2').AsString:=Dato2;
    selT768.FieldByName('DATO3').AsString:=Dato3;
    selT768.FieldByName('PARTTIME').AsFloat:=selV430ScInd.FieldByName('PARTTIME').AsFloat;
    selT768.FieldByName('IMPORTO_ORARIO').AsFloat:=selT770.FieldByName('IMPORTO').AsFloat;
    selT768.FieldByName('NUMORE_ASSEGNATE').AsString:=selT770.FieldByName('NUM_ORE').AsString;
    if selT768.FieldByName('PARTTIME').AsFloat <> 100 then
    begin
      PT:=selT768.FieldByName('PARTTIME').AsFloat;
      selSG735.Close;
      selSG735.SetVariable('QUOTA',selT767.FieldByName('CODTIPOQUOTA').AsString);
      selSG735.SetVariable('DATARIF',selT767.FieldByName('DATARIF').AsDateTime);
      selSG735.SetVariable('PARTTIME',PT);
      selSG735.Open;
      if selSG735.RecordCount > 0 then
        PT:=selSG735.FieldByName('PERC').AsFloat;
      selT768.FieldByName('NUMORE_ASSEGNATE').AsString:=R180MinutiOre(
                          Trunc(R180OreMinutiExt(selT768.FieldByName('NUMORE_ASSEGNATE').AsString) * PT / 100));
    end;
    selT768.FieldByName('TOTALE_ASSEGNATO').AsFloat:=R180Arrotonda(selT768.FieldByName('IMPORTO_ORARIO').AsFloat *
    StrToFloatDef(StringReplace(R180Centesimi(R180OreMinutiExt(selT768.FieldByName('NUMORE_ASSEGNATE').AsString)),'.',',',[rfReplaceAll]),0),0.01,'P');
    selT768.FieldByName('NUMORE_ACCETTATE').AsString:=selT768.FieldByName('NUMORE_ASSEGNATE').AsString;
    selT768.FieldByName('TOTALE_ACCETTATO').AsFloat:=selT768.FieldByName('TOTALE_ASSEGNATO').AsFloat;
    TotOre:=TotOre + R180OreMinutiExt(selT768.FieldByName('NUMORE_ASSEGNATE').AsString);
    Tot:=Tot + selT768.FieldByName('TOTALE_ASSEGNATO').AsFloat;
    selT768.FieldByName('CONFERMATO').AsString:='N';
    selT768.Post;
    SessioneOracle.Commit;
  end;
end;

procedure TA170FGestioneGruppiMW.ImpostaTotaleGruppoSchede(Tot:Real; TotOre: Integer);
begin
  updT767Tot.SetVariable('IMP',Tot);
  updT767Tot.SetVariable('ORE',R180MinutiOre(TotOre));
  updT767Tot.SetVariable('ANNO',selT767.FieldByName('ANNO').AsInteger);
  updT767Tot.SetVariable('GRUPPO',selT767.FieldByName('CODGRUPPO').AsString);
  updT767Tot.SetVariable('QUOTA',selT767.FieldByName('CODTIPOQUOTA').AsString);
  updT767Tot.Execute;
  SessioneOracle.Commit;
end;

function TA170FGestioneGruppiMW.VerificaGruppiApertiSchede(Anno: Integer; Quota: String): Integer;
var
  lstGruppi: TStringList;
begin
  lstGruppi:=TStringList.Create;
  try
    //Considero i gruppi dell'anno precedente
    selT767.Close;
    selT767.SetVariable('ANNO',Anno - 1);
    selT767.SetVariable('CODQUOTA', Quota);
    selT767.SetVariable('FILTRO',' ');
    selT767.Open;
    selT767New.Close;
    selT767New.SetVariable('ANNO',Anno);
    selT767New.SetVariable('CODQUOTA',Quota);
    selT767New.Open;
    //Controllo se sul nuovo anno ci sono dei gruppi aperti già presenti nell'anno precedente
    selT767New.Filter:='STATO = ''A''';
    selT767New.Filtered:=True;
    while not selT767New.Eof do
    begin
      if selT767.SearchRecord('CODGRUPPO',selT767New.FieldByName('CODGRUPPO').AsString,[srFromBeginning]) then
        lstGruppi.Add(selT767New.FieldByName('CODGRUPPO').AsString);
      selT767New.Next;
    end;
    selT767New.Filter:='';
    selT767New.Filtered:=False;
    Result:=lstGruppi.count;
  finally
    FreeAndNil(lstGruppi);
  end;
end;

procedure TA170FGestioneGruppiMW.InizioElaborazionePassaggioAnno(Anno:Integer; Quota: String; DataRif: TDateTime;lstPagamenti:TList<TPagamenti>; var lstGruppi: TStringList);
var i:Integer;
  pagamenti: TPagamenti;
begin
  selT767.First;
  while not selT767.Eof do
  begin
    //Cerco se il gruppo esiste già sul nuovo anno
    if selT767New.SearchRecord('CODGRUPPO',selT767.FieldByName('CODGRUPPO').AsString,[srFromBeginning]) then
    begin
      //Se esiste già ed è chiso lo salto
      if selT767New.FieldByName('STATO').AsString = 'C' then
        RegistraMsg.InserisciMessaggio('A','Il gruppo ' + selT767.FieldByName('CODGRUPPO').AsString + ' non è stato ribaltato perchè esiste già sul nuovo anno ' + IntToStr(Anno) + ' ed è chiuso','',0)
      else
      begin
        //Se esiste già e non è chiso lo sovrascrivo
        lstGruppi.Add(selT767.FieldByName('CODGRUPPO').AsString);
        selT767New.Edit;
      end;
    end
    else
    begin
      //Se non esiste ancora lo inserisco
      lstGruppi.Add(selT767.FieldByName('CODGRUPPO').AsString);
      selT767New.Insert;
    end;
    if selT767New.State in [dsEdit,dsInsert] then
    begin
      selT767New.FieldByName('ANNO').AsInteger:=Anno;
      selT767New.FieldByName('CODTIPOQUOTA').AsString:=Quota;
      selT767New.FieldByName('CODGRUPPO').AsString:=selT767.FieldByName('CODGRUPPO').AsString;
      selT767New.FieldByName('DESCRIZIONE').AsString:=selT767.FieldByName('DESCRIZIONE').AsString;
      selT767New.FieldByName('FILTRO_ANAGRAFE').AsString:=selT767.FieldByName('FILTRO_ANAGRAFE').AsString;
      selT767New.FieldByName('TOLLERANZA').AsString:='';
      selT767New.FieldByName('DATARIF').AsDateTime:=DataRif;
      selT767New.FieldByName('STATO').AsString:='A';
      selT767New.FieldByName('SUPERVISIONE').AsString:=selT767.FieldByName('SUPERVISIONE').AsString;
      selT767New.FieldByName('PROG_SUPERVISORE').AsInteger:=selT767.FieldByName('PROG_SUPERVISORE').AsInteger;
      i:=1;
      for pagamenti in lstPagamenti do
      begin
        selT767New.FieldByName('PAG' + IntToStr(i) +'_MAX').AsString:=pagamenti.max;
        selT767New.FieldByName('PAG' + IntToStr(i) + '_PERC').AsFloat:=pagamenti.perc;
        inc(i);
      end;
      selT767New.Post;
    end;
    selT767.Next;
  end;
  SessioneOracle.Commit;
end;

procedure TA170FGestioneGruppiMW.FineElaborazionePassaggioAnno(Anno:Integer; Quota: String);
begin
  // Cancellare i gruppi vuoti
  delt767.SetVariable('ANNO',Anno);
  delt767.SetVariable('CODQUOTA',Quota);
  delt767.Execute;
  SessioneOracle.Commit;
end;

procedure TA170FGestioneGruppiMW.FineElaborazioneGruppiPesature;
begin
  FreeAndNil(A169FCalcoloDTM)
end;

end.
