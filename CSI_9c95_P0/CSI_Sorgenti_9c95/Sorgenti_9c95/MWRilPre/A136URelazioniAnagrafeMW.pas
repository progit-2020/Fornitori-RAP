unit A136URelazioniAnagrafeMW;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, OracleData, R005UDataModuleMW, DB,A000UCostanti, A000USessione,A000UInterfaccia,
  Oracle, DBClient,A136UComposizioneRelazioneMW,C180FunzioniGenerali,StrUtils;

type
  TA136ImpostaMsgWarning = procedure(Tipo:String; Campo:String) of object;
  TA136CdsRelazioniScroll = procedure(DataSet: TDataSet) of object;

  TA136FRelazioniAnagrafeMW = class(TR005FDataModuleMW)
    selI035: TOracleDataSet;
    selCOLS: TOracleDataSet;
    selT033: TOracleDataSet;
    SQLAppoggio: TOracleQuery;
    delI035: TOracleQuery;
    insI035: TOracleQuery;
    selPilotato: TOracleDataSet;
    selPilota: TOracleDataSet;
    cdsCampiRelazioni: TClientDataSet;
    cdsCampiRelazioniVALOREPILOTATO: TStringField;
    cdsCampiRelazioniDESCRIZIONEPILOTATO: TStringField;
    cdsCampiRelazioniD_DESC_PILOTATO: TStringField;
    cdsCampiRelazioniVALOREPILOTA: TStringField;
    cdsCampiRelazioniDESCRIZIONEPILOTA: TStringField;
    cdsCampiRelazioniD_DESC_PILOTA: TStringField;
    DCampiRelazioni: TDataSource;
    procedure DataModuleCreate(Sender: TObject);
    procedure cdsCampiRelazioniCalcFields(DataSet: TDataSet);
    procedure cdsCampiRelazioniBeforeInsert(DataSet: TDataSet);
    procedure cdsCampiRelazioniBeforeDelete(DataSet: TDataSet);
    procedure cdsCampiRelazioniAfterScroll(DataSet: TDataSet);
    procedure cdsCampiRelazioniAfterPost(DataSet: TDataSet);
    procedure DataModuleDestroy(Sender: TObject);
  private
    FselI030_Funzioni: TOracleDataset;
    function CreaSQLRelazione(memRelazione: String): String;
  public
    A136FComposizioneRelazioneMW: TA136FComposizioneRelazioneMW;
    ListaValoriSQL,ListaPilota,ListaDettaglioRelazione,ListaSQLRelazione: TStringList;
    A136ImpostaMsgWarning: TA136ImpostaMsgWarning;
    A136CdsRelazioniScroll: TA136CdsRelazioniScroll;
    property selI030_Funzioni: TOracleDataset read FselI030_Funzioni write FselI030_Funzioni;
    procedure ImpostaDescTipo;
    procedure ImpostaColonnaOrigine;
    procedure SettaselI035;
    function DescrizioneTipo(Codice: String): String;
    function VerificaCampiAbilitati(var bSolaLettura:Boolean): Boolean;
    procedure CancellaI035;
    procedure InserisciI035(RelazioniDettaglio: TStrings);
    function LeggiI035:TStringList;
    function ImpostaQuerySelezione(NomeTabella,NomeColonna: String;var QuerySelezione: TOracleDataset):Boolean;
    function EstraiCampoPilota(SQLRelazione: String; var CampoPilota: String): Boolean;
    procedure CaricaValoriPilotati(ValoriAbbinati: String);
    function RecuperaValoriPilota(NomeTabella, NomeColonna: String): Boolean;
    function EstraiValoriDaSQLRelazione(var S: String; var ValorePilota: String; var ValorePilotato:String): Boolean;
    procedure CaricaAbbinaValori(var AbbinaValori: String; var ValorePilota:String; var ValorePilotato: String);
    function AbbinaValoriDuplicati(AbbinaValori:String): Boolean;
    function EstraiAbbinaValori(S: String): String;
    procedure ComponiSQLRelazione(var SqlRelazione: String ; ColonnaPilota: String);
    function VerificaSQLRelazione(memRelazione: String): String;
    //Stampa Relazioni
    procedure ElencoTabelleStampa(var listTabelle: TStringList);
    procedure ElencoColonne(TabPartenza:String; var listColonne: TStringList; var ColonnePilotate:String);
    procedure ElencoColonneArrivo(TabPartenza:String; ColPartenza: String; ColonnePilotate: String; var listColonneArrivo: TStringList);
    function CreaStrutturaStampa(TabellaPartenza,ColonnaPartenza,ColonnaArrivo:String):String;
    const TipiRelazione:array [0..2] of String =('S','F','L');
  end;

implementation

{$R *.dfm}

{ TA136FRelazioniAnagrafeMW }

procedure TA136FRelazioniAnagrafeMW.DataModuleCreate(Sender: TObject);
begin
  inherited;
  selT033.SetVariable('NOME',Parametri.Layout);
  selT033.Open;
  cdsCampiRelazioni.CreateDataSet;
  cdsCampiRelazioni.LogChanges:=False;
  ListaValoriSQL:=TStringList.Create;
  ListaPilota:=TStringList.Create;
  ListaDettaglioRelazione:=TStringList.Create;
  ListaSQLRelazione:=TStringList.Create;
  A136FComposizioneRelazioneMW:=TA136FComposizioneRelazioneMW.Create(nil);
end;

procedure TA136FRelazioniAnagrafeMW.DataModuleDestroy(Sender: TObject);
begin
  FreeAndNil(ListaValoriSQL);
  FreeAndNil(ListaPilota);
  FreeAndNil(ListaDettaglioRelazione);
  FreeAndNil(ListaSQLRelazione);
  FreeAndNil(A136FComposizioneRelazioneMW);
  inherited;
end;

procedure TA136FRelazioniAnagrafeMW.cdsCampiRelazioniAfterPost(
  DataSet: TDataSet);
begin
  inherited;
  if assigned(A136CdsRelazioniScroll) then
    A136CdsRelazioniScroll(DataSet);
end;

procedure TA136FRelazioniAnagrafeMW.cdsCampiRelazioniAfterScroll(
  DataSet: TDataSet);
begin
  inherited;
  if assigned(A136CdsRelazioniScroll) then
    A136CdsRelazioniScroll(DataSet);
end;

procedure TA136FRelazioniAnagrafeMW.cdsCampiRelazioniBeforeDelete(
  DataSet: TDataSet);
begin
  inherited;
  Abort;
end;

procedure TA136FRelazioniAnagrafeMW.cdsCampiRelazioniBeforeInsert(
  DataSet: TDataSet);
begin
  inherited;
  Abort;
end;

procedure TA136FRelazioniAnagrafeMW.cdsCampiRelazioniCalcFields(
  DataSet: TDataSet);
begin
  inherited;
  if FselI030_Funzioni.FieldByName('TIPO').AsString = 'F' then
  begin
    if (selPilota.Active) and (cdsCampiRelazioni.FieldByName('VALOREPILOTA').AsString <> '') then
      cdsCampiRelazioni.FieldByName('D_DESC_PILOTA').AsString:=VarToStr(selPilota.Lookup('CODICE',cdsCampiRelazioni.FieldByName('VALOREPILOTA').AsString,'DESCRIZIONE'));
    cdsCampiRelazioni.FieldByName('D_DESC_PILOTATO').AsString:=cdsCampiRelazioni.FieldByName('DESCRIZIONEPILOTATO').AsString;
  end
  else if (FselI030_Funzioni.FieldByName('TIPO').AsString = 'S') or (FselI030_Funzioni.FieldByName('TIPO').AsString = 'L') then
  begin
    cdsCampiRelazioni.FieldByName('D_DESC_PILOTA').AsString:=cdsCampiRelazioni.FieldByName('DESCRIZIONEPILOTA').AsString;
    if cdsCampiRelazioni.FieldByName('VALOREPILOTATO').AsString <> '' then
      cdsCampiRelazioni.FieldByName('D_DESC_PILOTATO').AsString:=VarToStr(selPilotato.Lookup('CODICE',cdsCampiRelazioni.FieldByName('VALOREPILOTATO').AsString,'DESCRIZIONE'));
  end;
end;

procedure TA136FRelazioniAnagrafeMW.ComponiSQLRelazione(var SqlRelazione: String ; ColonnaPilota: String);
begin
  cdsCampiRelazioni.DisableControls;
  cdsCampiRelazioni.First;
  A136FComposizioneRelazioneMW.cdsCampiRelazioni.EmptyDataSet;
  while not cdsCampiRelazioni.Eof do
  begin
    A136FComposizioneRelazioneMW.cdsCampiRelazioni.Insert;
    A136FComposizioneRelazioneMW.cdsCampiRelazioni.FieldByName('VALOREPILOTATO').AsString:=cdsCampiRelazioni.FieldByName('VALOREPILOTATO').AsString;
    A136FComposizioneRelazioneMW.cdsCampiRelazioni.FieldByName('VALOREPILOTA').AsString:=cdsCampiRelazioni.FieldByName('VALOREPILOTA').AsString;
    A136FComposizioneRelazioneMW.cdsCampiRelazioni.Post;
    cdsCampiRelazioni.Next;
  end;
  cdsCampiRelazioni.EnableControls;

  A136FComposizioneRelazioneMW.SQLRel:=SqlRelazione;
  A136FComposizioneRelazioneMW.ColPilota:=ColonnaPilota;
  A136FComposizioneRelazioneMW.selI030:=FselI030_Funzioni;
  A136FComposizioneRelazioneMW.ComponiRelazione;
  SqlRelazione:=A136FComposizioneRelazioneMW.SQLRel;

  ListaSQLRelazione.Assign(A136FComposizioneRelazioneMW.lstRelazione);

end;

function TA136FRelazioniAnagrafeMW.CreaSQLRelazione(memRelazione: String): String;
var
  NewCampo,OldCampo:String;
begin
  Result:=Trim(memRelazione);
  while Pos('<#>',Result) <> 0 do
  begin
    OldCampo:=Copy(Result,Pos('<#>',Result)+3,Pos('<#>',Copy(Result,Pos('<#>',Result)+3))-1);
    if OldCampo = 'DECORRENZA' then
      NewCampo:='DATADECORRENZA'
    else if OldCampo = 'DECORRENZA_FINE' then
      NewCampo:='DATAFINE'
    else if OldCampo = ';' then
      NewCampo:=' UNION SELECT '
    else if OldCampo = 'W' then
      NewCampo:=' FROM DUAL WHERE '
    else if OldCampo = 'D' then
      NewCampo:=' FROM DUAL '
    else
      NewCampo:=OldCampo;
    if (OldCampo <> ';') and (OldCampo <> 'W') and (OldCampo <> 'D') then
      //Se il valore tra <#> è un campo, per il test della sintassi lo sostituisco con un valore-stringa fisso ininfluente
      Result:=StringReplace(Result,'<#>'+OldCampo+'<#>',''''+'@ValoreTest@'+'''',[rfReplaceAll,rfIgnoreCase])
    else
      Result:=StringReplace(Result,'<#>'+OldCampo+'<#>',NewCampo,[rfReplaceAll,rfIgnoreCase]);
  end;
  if Copy(Result,Length(Result)-13,14) = ' UNION SELECT ' then
    Result:=Copy(Result,1,Length(Result)-14);
  if Length(Result) > 0 then
  begin
    if Copy(Result,1,6) <> 'SELECT' then
      Result:='SELECT '+Result;
    if Pos('FROM',Result) = 0 then
      Result:=Result+' FROM DUAL';
  end;
  Result:=Trim(Result);
end;

procedure TA136FRelazioniAnagrafeMW.CancellaI035;
begin
  delI035.SetVariable('TABELLA',FselI030_Funzioni.FieldByName('TABELLA').AsString);
  delI035.SetVariable('COLONNA',FselI030_Funzioni.FieldByName('COLONNA').AsString);
  delI035.SetVariable('DECORRENZA',FselI030_Funzioni.FieldByName('DECORRENZA').medpOldValue);
  delI035.Execute;
end;

function TA136FRelazioniAnagrafeMW.DescrizioneTipo(Codice: String): String;
begin
  Result:='';
  if Codice = 'S' then
    Result:='Ass. aut. vincolata'
  else if Codice = 'L' then
    Result:='Ass. aut. libera'
  else if Codice = 'F' then
    Result:='Ass. filtrata';
end;

function TA136FRelazioniAnagrafeMW.EstraiAbbinaValori(S: String): String;
var
  S1,S2: String;
begin
  S1:=S;
  Result:='';
  while (Pos('<#>D<#>',S1) > 0) and (Pos('<#>;<#>',S1) > 0) do
  begin
    S2:=Copy(S1,Pos('<#>',Copy(S1,Pos('<#>',S1)+3))+Pos('<#>',S1)+3+3);
    if Result <> '' then
      Result:=Result + ',';
    Result:=Result + Copy(S2,1,Pos(')',S2)-1);
    S1:=Copy(S1,Pos('<#>;<#>',S1)+7);
  end;
end;

function TA136FRelazioniAnagrafeMW.EstraiCampoPilota(SQLRelazione: String;var CampoPilota: String): Boolean;
var
  Tmp,Appoggio: String;
begin
  Result:=False;
  Tmp:=SQLRelazione;
  CampoPilota:='';
  Appoggio:='';
  while Pos('<#>',Tmp) > 0 do
  begin
    //Controllo se si fa riferimento sempre ad una sola colonna pilota
    Appoggio:=Copy(Tmp,Pos('<#>',Tmp)+3,Pos('<#>',Copy(Tmp,Pos('<#>',Tmp)+3))-1);
    if (Appoggio = ';') or (Appoggio = 'D') or (Appoggio = 'W') then
    begin
      Tmp:=Copy(Tmp,Pos(Appoggio,Tmp)+Length(Appoggio)+3);
      Continue;
    end;
    if (CampoPilota <> '') and (Appoggio <> CampoPilota) then
    begin
      Result:=False;
      Exit;
    end;
    CampoPilota:=Appoggio;
    Tmp:=Copy(Tmp,Pos(CampoPilota,Tmp)+Length(CampoPilota)+3);
  end;
  Result:=True;
end;


function TA136FRelazioniAnagrafeMW.EstraiValoriDaSQLRelazione(var S,
  ValorePilota, ValorePilotato: String): Boolean;
begin
  Result:=True;
  //Cerco il valore pilotato di riferimento (o è NULL o inizia con la parentesi)
  if ((Pos('(',S) > 0) and (Pos('NULL',S) > 0) and (Pos('(',S) < Pos('NULL',S))) or
     ((Pos('(',S) > 0) and (Pos('NULL',S) = 0)) then
  begin
    //...Il più vicino ha la parentesi
    ValorePilotato:=Copy(S,Pos('(',S)+1,Pos(')',S)-Pos('(',S)-1);
  end
  else if ((Pos('(',S) > 0) and (Pos('NULL',S) > 0) and (Pos('(',S) > Pos('NULL',S))) or
       ((Pos('(',S) = 0) and (Pos('NULL',S) > 0)) then
  begin
    //...Il più vicino ha il null
    ValorePilotato:='NULL';
  end;
  //ValorePilotato:=Copy(S,Pos('(',S)+1,Pos(')',S)-Pos('(',S)-1);
  S:=Copy(S,Pos(ValorePilotato,S)+Length(ValorePilotato));
  //Cerco il valore pilota di riferimento (o è NULL o inizia con l'apice)
  if ((Pos('''',S) > 0) and (Pos('NULL',S) > 0) and (Pos('''',S) < Pos('NULL',S))) or
     ((Pos('''',S) > 0) and (Pos('NULL',S) = 0)) then
  begin
    //...Il più vicino ha l'apice
    S:=Copy(S,Pos('''',S)+1);
    ValorePilota:=Copy(S,1,Pos('''',S)-1);
    S:=Copy(S,Pos(ValorePilota,S)+Length(ValorePilota)+1);
  end
  else if ((Pos('''',S) > 0) and (Pos('NULL',S) > 0) and (Pos('''',S) > Pos('NULL',S))) or
          ((Pos('''',S) = 0) and (Pos('NULL',S) > 0)) then
  begin
    //...Il più vicino ha il null
    S:=Copy(S,Pos('NULL',S));
    ValorePilota:=Copy(S,1,4);
    S:=Copy(S,5);
  end
  else
  begin
    Result:=False;
  end;

end;

procedure TA136FRelazioniAnagrafeMW.ImpostaColonnaOrigine;
var
  S,CampoPilota,Appoggio: String;
begin
  S:='';
  SettaselI035;
  while not selI035.Eof do
  begin
    S:=S + ' ' + selI035.FieldByName('RELAZIONE').AsString;
    selI035.Next;
  end;
  S:=Trim(S);
  CampoPilota:='';
  Appoggio:='';
  //Cerco tutte le colonne pilota specificate nella relazione
  while Pos('<#>',S) > 0 do
  begin
    //Controllo se si fa riferimento sempre ad una sola colonna pilota
    Appoggio:=Copy(S,Pos('<#>',S)+3,Pos('<#>',Copy(S,Pos('<#>',S)+3))-1);
    if (Appoggio = ';') or (Appoggio = 'D') or (Appoggio = 'W') then
    begin
      S:=Copy(S,Pos(Appoggio,S)+Length(Appoggio)+3);
      Continue;
    end;
    if (CampoPilota <> '') and (Appoggio <> CampoPilota) then
      Exit;
    CampoPilota:=Appoggio;
    S:=Copy(S,Pos(CampoPilota,S)+Length(CampoPilota)+3);
  end;
  FselI030_Funzioni.FieldByName('COL_ORIGINE').AsString:=CampoPilota;
end;

procedure TA136FRelazioniAnagrafeMW.impostaDescTipo;
begin
  //Carico la descrizione del tipo di relazione
  selI030_Funzioni.FieldByName('D_TIPO').AsString:= DescrizioneTipo(FselI030_Funzioni.FieldByName('TIPO').AsString);
end;

function TA136FRelazioniAnagrafeMW.ImpostaQuerySelezione(NomeTabella,NomeColonna: String;var QuerySelezione: TOracleDataset):Boolean;
var
  Tab,Col,Storico,Desc,sData: String;
begin
  Result:=False;
  if NomeTabella = 'T430_STORICO' then
    A000GetTabella(NomeColonna,Tab,Col,Storico)
  else if NomeTabella = 'P430_ANAGRAFICO' then
    A000GetTabellaP430(NomeColonna,Tab,Col,Storico);

  if (Tab <> '') and (Tab <> 'T030_ANAGRAFICO') then
  begin
    QuerySelezione.Close;
    QuerySelezione.SQL.Clear;
    //Imposto la colonna Descrizione in base alla tabella di provenienza
    if (Tab = 'T430_STORICO') or (Tab = 'P430_ANAGRAFICO') then
      Desc:='NULL DESCRIZIONE'
    else if Tab = 'T480_COMUNI' then
      Desc:='CITTA DESCRIZIONE'
    else
      Desc:='DESCRIZIONE';
    if Storico = 'S' then
    begin

      If FselI030_Funzioni.FieldByName('DECORRENZA_FINE').IsNull then
        sData:='31/12/3999'
      else
        sData:=FormatDateTime('dd/mm/yyyy',FselI030_Funzioni.FieldByName('DECORRENZA_FINE').AsDateTime);

      QuerySelezione.SQL.Add('SELECT DISTINCT ' + Col + ' CODICE, ' + Desc + ' FROM ' + Tab + ' T1 WHERE ');
      QuerySelezione.SQL.Add('T1.DECORRENZA = (SELECT MAX(T2.DECORRENZA) FROM ' + Tab + ' T2 WHERE T1.' + Col + ' = T2.' + Col);
      QuerySelezione.SQL.Add(' AND T2.DECORRENZA <= TO_DATE(''' + sData + ''',''dd/mm/yyyy'') AND T2.DECORRENZA_FINE >= TO_DATE(''' + FormatDateTime('dd/mm/yyyy',FselI030_Funzioni.FieldByName('DECORRENZA').AsDateTime) + ''',''dd/mm/yyyy'')) ORDER BY ' + Col);
    end
    else
      QuerySelezione.SQL.Add(Format('SELECT DISTINCT %s CODICE, %s FROM %s ORDER BY %s',[Col,Desc,Tab,Col]));
    Result:=True;
  end;

end;

procedure TA136FRelazioniAnagrafeMW.InserisciI035(RelazioniDettaglio: TStrings);
var
  i: Integer;
begin
  for i:=0 to RelazioniDettaglio.Count - 1 do
  begin
    insI035.SetVariable('TABELLA',FselI030_Funzioni.FieldByName('TABELLA').AsString);
    insI035.SetVariable('COLONNA',FselI030_Funzioni.FieldByName('COLONNA').AsString);
    insI035.SetVariable('DECORRENZA',FselI030_Funzioni.FieldByName('DECORRENZA').AsDateTime);
    insI035.SetVariable('NUM',i+1);
    insI035.SetVariable('RELAZIONE',RelazioniDettaglio[i]);
    insI035.Execute;
  end;
end;

function TA136FRelazioniAnagrafeMW.LeggiI035: TStringList;
begin
  ListaDettaglioRelazione.Clear;
  with selI035 do
  begin
    First;
    while not Eof do
    begin
      ListaDettaglioRelazione.Add(FieldByName('RELAZIONE').AsString);
      Next;
    end;
  end;
  Result:=ListaDettaglioRelazione;
end;

procedure TA136FRelazioniAnagrafeMW.SettaselI035;
begin
  with selI035 do
  begin
    Close;
    SetVariable('TABELLA',FselI030_Funzioni.FieldByName('TABELLA').AsString);
    SetVariable('COLONNA',FselI030_Funzioni.FieldByName('COLONNA').AsString);
    SetVariable('DECORRENZA',FselI030_Funzioni.FieldByName('DECORRENZA').AsDateTime);
    Open;
  end;
end;


function TA136FRelazioniAnagrafeMW.AbbinaValoriDuplicati(AbbinaValori: String) : Boolean;
var
  i,j: Integer;
begin
  ListaValoriSQL.Clear;
  ListaValoriSQL.QuoteChar:='''';
  ListaValoriSQL.Delimiter:=',';
  ListaValoriSQL.StrictDelimiter:=True;
  ListaValoriSQL.DelimitedText:=Copy(AbbinaValori,1,Length(AbbinaValori) - 1);
  Result:=False;
  for i := 0 to ListaValoriSQL.Count - 1 do
  begin
    if i mod 2 = 0 then
    begin
      for j := 0 to ListaValoriSQL.Count - 1 do
      begin
        if (j mod 2 = 0) and (i <> j) and (ListaValoriSQL[i] = ListaValoriSQL[j]) then
        begin
          Result:=True;
          Break;
        end;
      end;
      if Result then Break;
    end;
  end;
end;
//IRISWIN bSolaLettura è la variabile globale SolaLettura definita su A000USessione
//WEB bSolaLettura è la variabile SolaLettura definita su WR010FBase (Non deve usare quella di A000USessione perhè acceduta da tutte le sessioni)
function TA136FRelazioniAnagrafeMW.VerificaCampiAbilitati(var bSolaLettura:Boolean): Boolean;
var
  SolaLetturaApp: Boolean;
begin
  //reset lbl di warngin
  if Assigned(A136ImpostaMsgWarning) then
  begin
    A136ImpostaMsgWarning('TABELLA','');
    A136ImpostaMsgWarning('TAB_ORIGINE','');
  end;

  Result:=False;
  if bSolaLettura and (Parametri.I035_ModificaAbbinamenti = 'N') then
    Result:=False
  else
  begin
    if FselI030_Funzioni.FieldByName('TABELLA').AsString = 'T430_STORICO' then
    begin
      Result:=selT033.SearchRecord('CAMPODB',FselI030_Funzioni.FieldByName('COLONNA').AsString,[srFromBeginning]);
      if not Result then
        with SQLAppoggio do
        begin
          Close;
          SQL.Text:='SELECT COUNT(*) N_COL FROM COLS' +
                    ' WHERE TABLE_NAME = ''' + FselI030_Funzioni.FieldByName('TABELLA').AsString +
                    ''' AND COLUMN_NAME = ''' + FselI030_Funzioni.FieldByName('COLONNA').AsString + '''';
          Execute;
          Result:=FieldAsInteger(0) = 0;
          if Result then
            if Assigned(A136ImpostaMsgWarning) then
              A136ImpostaMsgWarning('TABELLA',FselI030_Funzioni.FieldByName('TABELLA').AsString + '.' + FselI030_Funzioni.FieldByName('COLONNA').AsString);
        end;
    end
    else if FselI030_Funzioni.FieldByName('TABELLA').AsString = 'P430_ANAGRAFICO' then
    begin
      SolaLetturaApp:=bSolaLettura;
      Result:=A000GetInibizioni('Funzione','OpenP430FAnagrafico') = 'S';
      //IRISWIN bSolaLettura è la variabile globale SolaLettura definita su A000USessione
      //WEB bSolaLettura è la variabile SolaLettura definita su WR010FBase (Non deve usare quella di A000USessione perhè acceduta da tutte le sessioni)
      bSolaLettura:=SolaLetturaApp;
    end;
    if Result and (FselI030_Funzioni.FieldByName('COL_ORIGINE').AsString <> '') then
    begin
      if FselI030_Funzioni.FieldByName('TAB_ORIGINE').AsString = 'T430_STORICO' then
      begin
        Result:=Result and (selT033.SearchRecord('CAMPODB',FselI030_Funzioni.FieldByName('COL_ORIGINE').AsString,[srFromBeginning]));
        if not Result then
          with SQLAppoggio do
          begin
            Close;
            SQL.Text:='SELECT COUNT(*) N_COL FROM COLS' +
                      ' WHERE TABLE_NAME = ''' + FselI030_Funzioni.FieldByName('TAB_ORIGINE').AsString +
                      ''' AND COLUMN_NAME = ''' + FselI030_Funzioni.FieldByName('COL_ORIGINE').AsString + '''';
            Execute;
            Result:=FieldAsInteger(0) = 0;
            if Result then
              if Assigned(A136ImpostaMsgWarning) then
                A136ImpostaMsgWarning('TAB_ORIGINE',FselI030_Funzioni.FieldByName('TAB_ORIGINE').AsString + '.' + FselI030_Funzioni.FieldByName('COL_ORIGINE').AsString);
          end;
      end
      else if FselI030_Funzioni.FieldByName('TAB_ORIGINE').AsString = 'P430_ANAGRAFICO' then
      begin
        SolaLetturaApp:=bSolaLettura;
        Result:=Result and (A000GetInibizioni('Funzione','OpenP430FAnagrafico') = 'S');
        //IRISWIN bSolaLettura è la variabile globale SolaLettura definita su A000USessione
        //WEB bSolaLettura è la variabile SolaLettura definita su WR010FBase (Non deve usare quella di A000USessione perhè acceduta da tutte le sessioni)
        bSolaLettura:=SolaLetturaApp;
      end;
    end;
  end;
end;

function TA136FRelazioniAnagrafeMW.VerificaSQLRelazione(memRelazione: String): String;
begin
  Result:='';
  with SQLAppoggio do
  try
    SQL.Text:=CreaSQLRelazione(memRelazione);
    Execute;
    Result:='SQL valido!';
  except
    on E:Exception do
      Result:='SQL NON valido!' + #13#10 + E.Message;
  end;
end;

procedure TA136FRelazioniAnagrafeMW.CaricaAbbinaValori(var AbbinaValori: String; var ValorePilota:String; var ValorePilotato: String);
begin
  //Gestisco il caricamento dei valori pilota/pilotato nella lista
  if ValorePilotato = 'NULL' then
    if ValorePilota = 'NULL' then
      AbbinaValori:=AbbinaValori + 'NULL,NULL,'
    else
      AbbinaValori:=AbbinaValori + 'NULL,''' + ValorePilota + ''','
  else
  begin
    if ValorePilota <> 'NULL' then
      ValorePilota:='''' + ValorePilota + '''';
    ValorePilotato:=ValorePilotato + ',';
    while Pos(',',ValorePilotato) > 0 do
    begin
      AbbinaValori:=AbbinaValori + Copy(ValorePilotato,1,Pos(',',ValorePilotato)) + ValorePilota + ',' ;
      ValorePilotato:=Copy(ValorePilotato,Pos(',',ValorePilotato)+1);
    end;
  end;
end;

procedure TA136FRelazioniAnagrafeMW.CaricaValoriPilotati(ValoriAbbinati: String);
var
  I:Integer;
begin
  ListaValoriSQL.Clear;
  //Carico la lista degli abbinamenti
  ListaValoriSQL.QuoteChar:='''';
  ListaValoriSQL.Delimiter:=',';
  ListaValoriSQL.StrictDelimiter:=True;
  ValoriAbbinati:=Copy(ValoriAbbinati,1,Length(ValoriAbbinati) - 1);
  ListaValoriSQL.DelimitedText:=ValoriAbbinati;
  //Carico i valori nel ClientDataSet
  cdsCampiRelazioni.IndexName:='IND_PILOTATO';
  cdsCampiRelazioni.BeforeInsert:=nil;
  //Scorro i valori pilotati
  selPilotato.First;
  while not selPilotato.Eof do
  begin
    cdsCampiRelazioni.Append;
    //I valori pilotati ce li ho sul DataSet
    cdsCampiRelazioni.FieldByName('VALOREPILOTATO').AsString:=selPilotato.FieldByName('CODICE').AsString;
    cdsCampiRelazioni.FieldByName('DESCRIZIONEPILOTATO').AsString:=selPilotato.FieldByName('DESCRIZIONE').AsString;
    //I valori pilota li cerco sulla lista degli abbinamenti
    for i := 0 to ListaValoriSQL.Count - 1 do
      if (i mod 2 = 0)
      and
         ((ListaValoriSQL[i] = selPilotato.FieldByName('CODICE').AsString) or
          ((ListaValoriSQL[i] = 'NULL') and
           (selPilotato.FieldByName('CODICE').AsString = ''))) then
      begin
        //Se il valore pilota abbinato è null...
        if ListaValoriSQL[i+1] = 'NULL' then
          cdsCampiRelazioni.FieldByName('VALOREPILOTA').AsString:=''
        else
          cdsCampiRelazioni.FieldByName('VALOREPILOTA').AsString:=ListaValoriSQL[i+1];
        Break;
      end;
    cdsCampiRelazioni.Post;
    selPilotato.Next;
  end;
  cdsCampiRelazioni.BeforeInsert:=cdsCampiRelazioniBeforeInsert;
end;

function TA136FRelazioniAnagrafeMW.RecuperaValoriPilota(NomeTabella,NomeColonna:String): Boolean;
var
  Ok: Boolean;
  i:Integer;
begin
  {$IFNDEF IRISWEB}
  Screen.Cursor:=crHourGlass;
  {$ENDIF}
  Result:=True;

  cdsCampiRelazioni.FieldByName('VALOREPILOTA').DisplayLabel:=NomeColonna;

  Ok:=ImpostaQuerySelezione(NomeTabella,NomeColonna,selPilota);
  if Ok then
  begin
    selPilota.Close;
    ListaPilota.Clear;
    try
      selPilota.Open;
      //Se la relazione è di tipo Filtro...
      if FselI030_Funzioni.FieldByName('TIPO').AsString = 'F' then
      begin
        while not selPilota.Eof do
        begin
          //Carico i valori pilota nella List della colonna pilota
          ListaPilota.Add(selPilota.FieldByName('CODICE').AsString);
          selPilota.Next;
        end
      end
      //Se la relazione è di tipo Vincolato o Libero...
      else if (FselI030_Funzioni.FieldByName('TIPO').AsString = 'S') or (FselI030_Funzioni.FieldByName('TIPO').AsString = 'L') then
      begin
        cdsCampiRelazioni.DisableControls;
        cdsCampiRelazioni.EmptyDataSet;
        cdsCampiRelazioni.BeforeInsert:=nil;
        while not selPilota.Eof do
        begin
          //I valori pilota ce li ho sul DataSet
          cdsCampiRelazioni.Append;
          cdsCampiRelazioni.FieldByName('VALOREPILOTA').AsString:=selPilota.FieldByName('CODICE').AsString;
          cdsCampiRelazioni.FieldByName('DESCRIZIONEPILOTA').AsString:=selPilota.FieldByName('DESCRIZIONE').AsString;
          //I valori pilotati li cerco sulla lista degli abbinamenti
          for i:=0 to ListaValoriSQL.Count - 1 do
            if (i mod 2 = 0) and
               ((ListaValoriSQL[i] = selPilota.FieldByName('CODICE').AsString) or
               ((ListaValoriSQL[i] = 'NULL') and
               (selPilota.FieldByName('CODICE').AsString = ''))) then
            begin
              //Se il valore pilotato abbinato è null...
              if ListaValoriSQL[i+1] = 'NULL' then
                cdsCampiRelazioni.FieldByName('VALOREPILOTATO').AsString:=''
              else
                cdsCampiRelazioni.FieldByName('VALOREPILOTATO').AsString:=ListaValoriSQL[i+1];
              Break;
            end;
          cdsCampiRelazioni.Post;
          selPilota.Next;
        end;
        cdsCampiRelazioni.BeforeInsert:=cdsCampiRelazioniBeforeInsert;
        cdsCampiRelazioni.EnableControls;
      end;
    except
      cdsCampiRelazioni.EmptyDataSet;
      Result:=False;
    end;
  end
  else
  begin
    //Se la relazione è di tipo Vincolato o Libero ma non posso caricare i valori pilota, allora svuoto tutto
    if (FselI030_Funzioni.FieldByName('TIPO').AsString = 'S') or (FselI030_Funzioni.FieldByName('TIPO').AsString = 'L') then
      cdsCampiRelazioni.EmptyDataSet;
  end;
  cdsCampiRelazioni.First;

  {$IFNDEF IRISWEB}
  Screen.Cursor:=crDefault;
  {$ENDIF}
end;
//STAMPA RELAZIONI
procedure TA136FRelazioniAnagrafeMW.ElencoTabelleStampa(var listTabelle: TStringList);
var
  BM:TBookMark;
begin
  with FselI030_Funzioni do
  begin
    BM:=GetBookMark;
	try { TODO : TEST IW 15 }
      First;
      while not Eof do
      begin
        if (FieldByName('TAB_ORIGINE').AsString <> '')
        and ((FieldByName('TIPO').AsString = 'S') or (FieldByName('TIPO').AsString = 'L'))
        and (listTabelle.IndexOf(FieldByName('TAB_ORIGINE').AsString) = -1) then
          listTabelle.Add(FieldByName('TAB_ORIGINE').AsString);
        Next;
      end;
      GoToBookMark(BM);
	finally
      FreeBookMark(BM);
	end;
  end;
end;

procedure TA136FRelazioniAnagrafeMW.ElencoColonne(TabPartenza:String; var listColonne: TStringList; var ColonnePilotate:String);
var
  BM:TBookMark;
begin
  with FselI030_Funzioni do
  begin
    BM:=GetBookMark;
	try { TODO : TEST IW 15 }
      First;
      while not Eof do
      begin
        if (FieldByName('TAB_ORIGINE').AsString = TabPartenza) and
           ((FieldByName('TIPO').AsString = 'S') or (FieldByName('TIPO').AsString = 'L')) and
           (FieldByName('COL_ORIGINE').AsString <> '') and
           (listColonne.IndexOf(FieldByName('COL_ORIGINE').AsString) = -1) then
          listColonne.Add(FieldByName('COL_ORIGINE').AsString);
        if (FieldByName('COL_ORIGINE').AsString <> '') and
           ((FieldByName('TIPO').AsString = 'S') or (FieldByName('TIPO').AsString = 'L')) and
           (Pos(',' + FieldByName('COLONNA').AsString + ',',',' + ColonnePilotate + ',') = 0) then
          ColonnePilotate:=ColonnePilotate + IfThen(ColonnePilotate <> '',',','') + FieldByName('COLONNA').AsString;
        Next;
      end;
      GoToBookMark(BM);
	finally
      FreeBookMark(BM);
	end;
  end;
end;

procedure TA136FRelazioniAnagrafeMW.ElencoColonneArrivo(TabPartenza:String; ColPartenza: String; ColonnePilotate: String; var listColonneArrivo: TStringList);
var
  ColPilotate:String;
  BM:TBookMark;
  CampoPilota,CampoPilotato,StrStampa:String;
begin
  ColPilotate:=ColonnePilotate + ',';
  while Pos(',',ColPilotate) > 0 do
  begin
    CampoPilotato:=Copy(ColPilotate,1,Pos(',',ColPilotate) - 1);
    with FSelI030_Funzioni do
    begin
      BM:=GetBookMark;
	  try { TODO : TEST IW 15 }
        CampoPilota:=CampoPilotato;
        StrStampa:=CampoPilotato + ',';
        while CampoPilota <> '' do
        begin
          CampoPilota:=VarToStr(Lookup('TABELLA;COLONNA',VarArrayOf([TabPartenza,CampoPilota]),'COL_ORIGINE'));
          if (CampoPilota <> '') and (CampoPilota <> ColPartenza) then
            StrStampa:=CampoPilota + ',' + StrStampa;
          if CampoPilota = ColPartenza then
          begin
            while Pos(',',StrStampa) > 0 do
            begin
              if listColonneArrivo.IndexOf(Copy(StrStampa,1,Pos(',',StrStampa) - 1)) = -1 then
                 listColonneArrivo.Add(Copy(StrStampa,1,Pos(',',StrStampa) - 1));
                StrStampa:=Copy(StrStampa,Pos(',',StrStampa) + 1);
            end;
            Break;
          end;
        end;
        GoToBookMark(BM);
	  finally
        FreeBookMark(BM);
	  end;
    end;
    ColPilotate:=Copy(ColPilotate,Pos(',',ColPilotate) + 1);
  end;
end;

function TA136FRelazioniAnagrafeMW.CreaStrutturaStampa(TabellaPartenza,ColonnaPartenza,ColonnaArrivo:String): String;
var
  BM:TBookMark;
  CampoPilota: String;
begin
  with FSelI030_Funzioni do
  begin
    BM:=GetBookMark;
	try { TODO : TEST IW 15 }
      CampoPilota:=ColonnaArrivo;
      Result:=ColonnaArrivo;
      while CampoPilota <> '' do
      begin
        CampoPilota:=VarToStr(Lookup('TABELLA;COLONNA',VarArrayOf([TabellaPartenza,CampoPilota]),'COL_ORIGINE'));
        if CampoPilota <> '' then
          Result:=CampoPilota + ',' + Result;
        if CampoPilota = ColonnaPartenza then
          break;
      end;
      GoToBookMark(BM);
	finally
      FreeBookMark(BM);
	end;
  end;
end;

end.
