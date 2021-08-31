unit C006UStoriaDati;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, Math,
  Db, OracleData, Oracle, A000UInterfaccia, A000UCostanti, A000USessione, Variants, USelI010, StrUtils;

type
  RecStoria = class
    DataDec,
    DataFine,
    TipoDato,
    NomeCampo,
    Valore,
    Descrizione:String;
    Decorrenza,
    Fine:TDateTime;
    Assunzione,
    Cessazione:TDateTime;
  end;

  TC006FStoriaDati = class(TDataModule)
    Q430: TOracleDataSet;
    QLookup: TOracleDataSet;
    selP430Storico: TOracleDataSet;
    procedure C006FStoriaDatiCreate(Sender: TObject);
    procedure C006FStoriaDatiDestroy(Sender: TObject);
  private
    { Private declarations }
    Anno:String;
    I010:TselI010;
    procedure PulisciLista;
    procedure CancellaDatiNonStoricizzati(Tipo:String);
  public
    { Public declarations }
    StoriaDipendente:TList;
    procedure GetStoriaDato(P:Integer; Dato:String; Data:TDateTime = 0);
    function DescrizioneDatoStorico(TipoDato,Codice:String):string;
    procedure GetStoriaDatoP430(P:Integer; Dato:String; Data:TDateTime = 0);
    function DescrizioneDatoStoricoP430(TipoDato:String; Codice:String):String;
    function CodTabAnnualeP430(TipoDato: String):String;
  end;

var
  C006FStoriaDati: TC006FStoriaDati;

implementation

{$R *.DFM}

procedure TC006FStoriaDati.C006FStoriaDatiCreate(Sender: TObject);
var i:Integer;
begin
  for i:=0 to Self.ComponentCount - 1 do
    begin
    if Components[i] is TOracleQuery then
      (Components[i] as TOracleQuery).Session:=SessioneOracle;
    if Components[i] is TOracleDataSet then
      (Components[i] as TOracleDataSet).Session:=SessioneOracle;
    end;
  I010:=TselI010.Create(Self);
  I010.Apri(SessioneOracle,Parametri.Layout,Parametri.Applicazione,'','','');
  if Parametri.CampiRiferimento.C19_StoriaInizioFine = '' then
    Parametri.CampiRiferimento.C19_StoriaInizioFine:='N';
end;

procedure TC006FStoriaDati.GetStoriaDato(P:Integer; Dato:String; Data:TDateTime = 0);
var i:Integer;
    DescrizioneStorico:String;
    Valore:String;
    ObjStoria:RecStoria;
    L:TStringList;
    Assunzione,Cessazione:TDateTime;
begin
  L:=TStringList.Create;
  L.CommaText:=Dato;
  PulisciLista;
  Q430.Close;
  Q430.ClearVariables;//Necessario per assegnare null alla variabile Data se il parametro vale 0
  Q430.SetVariable('Progressivo',P);
  if Data <> 0 then
    Q430.SetVariable('Data',Data);//Estraggo solo i dati di una decorrenza e del periodo precedente contiguo
  Q430.Open;
  StoriaDipendente:=TList.Create;
  for i:=0 to Q430.FieldCount - 1 do
    begin
    if (Q430.Fields[i].FieldName = 'PROGRESSIVO') or
       ((Copy(Q430.Fields[i].FieldName,1,9) = 'ABCAUSALE') and (Copy(Q430.Fields[i].FieldName,10,1) <> '1')) or
       ((Copy(Q430.Fields[i].FieldName,1,10) = 'ABPRESENZA') and (Copy(Q430.Fields[i].FieldName,11,1) <> '1')) then
      Continue;
    if Q430.Fields[i].FieldName = 'EDBADGE' then
      Continue;
    if (Dato <> '*') and (L.IndexOf(Q430.Fields[i].FieldName) = -1) then
      Continue;
    Q430.First;
    ObjStoria:=RecStoria.Create;
    StoriaDipendente.Add(ObjStoria);
    try
      DescrizioneStorico:=I010.Lookup('NOME_CAMPO','T430' + Q430.Fields[i].FieldName,'NOME_LOGICO');
    except
      DescrizioneStorico:=Q430.Fields[i].FieldName;
    end;
    if Parametri.CampiRiferimento.C19_StoriaInizioFine <> 'N' then
    begin
      ObjStoria.Assunzione:=Q430.FieldByName('Inizio').AsDateTime;
      ObjStoria.Cessazione:=Q430.FieldByName('Fine').AsDateTime;
      Assunzione:=ObjStoria.Assunzione;
      if Q430.FieldByName('Fine').IsNull then
        Cessazione:=EncodeDate(3999,12,31)
      else
        Cessazione:=Q430.FieldByName('Fine').AsDateTime;
    end
    else
    begin
      ObjStoria.Assunzione:=0;
      Assunzione:=ObjStoria.Assunzione;
      ObjStoria.Cessazione:=EncodeDate(3999,12,31);
      Cessazione:=ObjStoria.Cessazione;
    end;
    ObjStoria.DataDec:=FormatDateTime('dd/mm/yyyy',Max(Q430.FieldByName('DataDecorrenza').AsDateTime,Assunzione));
    ObjStoria.DataFine:=FormatDateTime('dd/mm/yyyy',Min(Q430.FieldByName('DataFine').AsDateTime,Cessazione));
    ObjStoria.Decorrenza:=Max(Q430.FieldByName('DataDecorrenza').AsDateTime,Assunzione);
    ObjStoria.Fine:=Min(Q430.FieldByName('DataFine').AsDateTime,Cessazione);
    ObjStoria.TipoDato:=DescrizioneStorico;
    ObjStoria.NomeCampo:=Q430.Fields[i].FieldName;
    Valore:=Q430.Fields[i].AsString;
    //Se è badge, considero anche l'edizione che separo con un punto
    if Q430.Fields[i].FieldName = 'BADGE' then
      Valore:=Valore + '.' + Q430.FieldByName('EDBADGE').AsString;
    ObjStoria.Valore:=Valore;
    if (Dato <> '*') and ((Q430.Fields[i].FieldName = 'INIZIO') or
       (Q430.Fields[i].FieldName = 'INIZIO_IND_MAT')) then
    begin
      if (Q430.Fields[i].FieldName = 'INIZIO') then
      begin
        if Q430.FieldByName('Fine').AsDateTime = 0 then
          ObjStoria.Descrizione:=''
        else
          ObjStoria.Descrizione:=FormatDateTime('dd/mm/yyyy',Q430.FieldByName('Fine').AsDateTime);
      end
      else if (Q430.Fields[i].FieldName = 'INIZIO_IND_MAT') then
      begin
        if Q430.FieldByName('FINE_IND_MAT').AsDateTime = 0 then
          ObjStoria.Descrizione:=''
        else
          ObjStoria.Descrizione:=FormatDateTime('dd/mm/yyyy',Q430.FieldByName('FINE_IND_MAT').AsDateTime);
      end;
    end
    else
      ObjStoria.Descrizione:=DescrizioneDatoStorico(Q430.Fields[i].FieldName,ObjStoria.Valore);
    while not Q430.Eof do
      begin
      if (Parametri.CampiRiferimento.C19_StoriaInizioFine = 'N') or (Q430.FieldByName('Fine').IsNull) then
        Cessazione:=EncodeDate(3999,12,31)
      else
        Cessazione:=Q430.FieldByName('Fine').AsDateTime;
      if ((ObjStoria.Assunzione <> Assunzione) and (Assunzione <> (ObjStoria.Cessazione + 1)))
         or
         (ObjStoria.Valore <> Valore)
         or
         ((Q430.Fields[i].FieldName <> 'INIZIO') and (Q430.Fields[i].FieldName <> 'INIZIO_IND_MAT') and
          (ObjStoria.Descrizione <> DescrizioneDatoStorico(Q430.Fields[i].FieldName,ObjStoria.Valore))) then
      begin
        ObjStoria:=RecStoria.Create;
        StoriaDipendente.Add(ObjStoria);
        ObjStoria.TipoDato:=DescrizioneStorico;
        ObjStoria.NomeCampo:=Q430.Fields[i].FieldName;
        if Parametri.CampiRiferimento.C19_StoriaInizioFine <> 'N' then
        begin
          ObjStoria.Assunzione:=Q430.FieldByName('Inizio').AsDateTime;
          ObjStoria.Cessazione:=Q430.FieldByName('Fine').AsDateTime;
        end
        else
        begin
          ObjStoria.Assunzione:=0;
          ObjStoria.Cessazione:=EncodeDate(3999,12,31);
        end;
        ObjStoria.DataDec:=FormatDateTime('dd/mm/yyyy',Max(Q430.FieldByName('DataDecorrenza').AsDateTime,Assunzione));
        ObjStoria.DataFine:=FormatDateTime('dd/mm/yyyy',Min(Q430.FieldByName('DataFine').AsDateTime,Cessazione));
        ObjStoria.Decorrenza:=Max(Q430.FieldByName('DataDecorrenza').AsDateTime,Assunzione);
        ObjStoria.Fine:=Min(Q430.FieldByName('DataFine').AsDateTime,Cessazione);
        try
          DescrizioneStorico:=I010.Lookup('NOME_CAMPO','T430' + Q430.Fields[i].FieldName,'NOME_LOGICO');
        except
          DescrizioneStorico:=Q430.Fields[i].FieldName;
        end;
        ObjStoria.Valore:=Valore;
        if (Dato <> '*') and ((Q430.Fields[i].FieldName = 'INIZIO') or
           (Q430.Fields[i].FieldName = 'INIZIO_IND_MAT')) then
        begin
          if Q430.Fields[i].FieldName = 'INIZIO' then
          begin
            if Q430.FieldByName('Fine').AsDateTime = 0 then
              ObjStoria.Descrizione:=''
            else
              ObjStoria.Descrizione:=FormatDateTime('dd/mm/yyyy',Q430.FieldByName('Fine').AsDateTime);
          end
          else if Q430.Fields[i].FieldName = 'INIZIO_IND_MAT' then
          begin
            if Q430.FieldByName('FINE_IND_MAT').AsDateTime = 0 then
              ObjStoria.Descrizione:=''
            else
              ObjStoria.Descrizione:=FormatDateTime('dd/mm/yyyy',Q430.FieldByName('FINE_IND_MAT').AsDateTime);
          end;
        end
        else
          ObjStoria.Descrizione:=DescrizioneDatoStorico(Q430.Fields[i].FieldName,ObjStoria.Valore);
        end
      else
      begin
        ObjStoria.DataFine:=FormatDateTime('dd/mm/yyyy',Min(Q430.FieldByName('DataFine').AsDateTime,Cessazione));
        ObjStoria.Fine:=Min(Q430.FieldByName('DataFine').AsDateTime,Cessazione);
      end;
      Q430.Next;
      Valore:=Q430.Fields[i].AsString;
      //Se è badge, considero anche l'edizione che separo con un punto
      if Q430.Fields[i].FieldName = 'BADGE' then
        Valore:=Valore + '.' + Q430.FieldByName('EDBADGE').AsString;
      if Parametri.CampiRiferimento.C19_StoriaInizioFine <> 'N' then
        Assunzione:=Q430.FieldByName('Inizio').AsDateTime
      else
        Assunzione:=0;
    end;
  end;
  for i:=StoriaDipendente.Count - 1 downto 0 do
    if RecStoria(StoriaDipendente[i]).Decorrenza > RecStoria(StoriaDipendente[i]).Fine then
      StoriaDipendente.Delete(i);
  if Data <> 0 then
    CancellaDatiNonStoricizzati('T430');
  L.Free;
end;

function TC006FStoriaDati.DescrizioneDatoStorico(TipoDato,Codice:String):string;
{Restituisce la descrizione del dato letta sulla tabella specifica}
var T,C,Storico:String;
begin
  Result:='';
  if TipoDato = 'CAUSSTRAORD' then
  begin
    if Codice = 'O' then Result:='Obbligatorio'
    else Result:='Facoltativo';
  end
  else if (TipoDato = 'STRAORDE') or (TipoDato = 'STRAORDU') or (TipoDato = 'STRAORDEU') or (TipoDato = 'STRAORDEU2') then
  begin
    if Codice = '0' then Result:='Inibito'
    else if Codice = '1' then Result:='Causalizzato'
    else Result:='Libero';
  end
  else if TipoDato = 'HTEORICHE' then
  begin
    if Codice = '0' then Result:='Giorn./mens. da gg.lavorativi'
    else if Codice = '1' then Result:='Giorn./mens. da tipo orario'
    else if Codice = '2' then Result:='Giorn. da orario, mens. da calendario'
    else if Codice = '3' then Result:='Giorn./mens. da calendario'
    else if Codice = '4' then Result:='Giorn. da orario, mens. da gg.lavorativi';  //LORENA 07/02/2005
  end
  else if TipoDato = 'TGESTIONE' then
  begin
    if Codice = '0' then Result:='Normale'
    else Result:='Turnista';
  end
  else if TipoDato = 'DOCENTE' then
  begin
    if Codice = 'S' then Result:='Docente'
    else Result:='';
  end
  else
  begin
    A000GetTabella(TipoDato,T,C,Storico);
    if (T <> '') and (T <> 'T430_STORICO') then
    begin
      QLookup.SQL.Clear;
      if T = 'T480_COMUNI' then
        QLookup.SQL.Add(Format('SELECT CITTA FROM %s WHERE %s = ''%s''',[T,C,Codice]))
      else if Storico = 'S' then
      begin
        QLookup.SQL.Add('SELECT DESCRIZIONE FROM ' + T + ' T1 WHERE ' + C + ' = ''' + Codice + '''');
        QLookup.SQL.Add(' AND DECORRENZA = (SELECT MAX(DECORRENZA) FROM ' + T + ' WHERE ' + C + ' = ''' + Codice + '''');
        QLookup.SQL.Add(' AND DECORRENZA <= TO_DATE(''' + FormatDateTime('dd/mm/yyyy',Q430.FieldByName('DATAFINE').AsDateTime));
        QLookup.SQL.Add(''',''dd/mm/yyyy''))');
      end
      else
        QLookup.SQL.Add(Format('SELECT DESCRIZIONE FROM %s WHERE %s = ''%s''',[T,C,Codice]));
      QLookup.Close;
      QLookup.Open;
      Result:=QLookup.Fields[0].AsString;
      QLookup.Close;
    end;
  end;
end;

procedure TC006FStoriaDati.PulisciLista;
var i:Integer;
begin
  if StoriaDipendente = nil then
    exit;
  for i:=StoriaDipendente.Count - 1 downto 0 do
  begin
    RecStoria(StoriaDipendente[i]).Free;
    StoriaDipendente.Delete(i);
  end;
  StoriaDipendente.Free;
end;

procedure TC006FStoriaDati.CancellaDatiNonStoricizzati(Tipo:String);
var NomeCampoCurr,NomeCampoPrev,NomeCampoNext,
    ValoreCurr,ValorePrev,ValoreNext,
    DescCurr,DescPrev,DescNext:String;
    i:Integer;
begin
  if StoriaDipendente = nil then
    exit;
  for i:=StoriaDipendente.Count - 1 downto 0 do
  begin
    NomeCampoCurr:=RecStoria(StoriaDipendente[i]).NomeCampo;
    ValoreCurr:=RecStoria(StoriaDipendente[i]).Valore;
    DescCurr:=RecStoria(StoriaDipendente[i]).Descrizione;
    if i = 0 then
    begin
      NomeCampoNext:='';
      ValoreNext:='';
      DescNext:='';
    end
    else
    begin
      NomeCampoNext:=RecStoria(StoriaDipendente[i - 1]).NomeCampo;
      ValoreNext:=RecStoria(StoriaDipendente[i - 1]).Valore;
      DescNext:=RecStoria(StoriaDipendente[i - 1]).Descrizione;
    end;
    //Cancello i record singoli...
    if (   ((NomeCampoCurr <> NomeCampoPrev) and (NomeCampoCurr <> NomeCampoNext))
    //...e i record con valori ripetuti...
        or ((NomeCampoCurr = NomeCampoPrev) and (ValoreCurr = ValorePrev) and (DescCurr = DescPrev))
        or ((NomeCampoCurr = NomeCampoNext) and (ValoreCurr = ValoreNext) and (DescCurr = DescNext)) )
    //...tranne quelli di decorrenza e scadenza,
    //per non lasciare vuoto StoriaDipendente nel caso anomalo in cui i periodi non siano contigui
    and (NomeCampoCurr <> IfThen(Tipo = 'T430','DATADECORRENZA','DECORRENZA'))
    and (NomeCampoCurr <> IfThen(Tipo = 'T430','DATAFINE','DECORRENZA_FINE')) then
      StoriaDipendente.Delete(i);
    NomeCampoPrev:=NomeCampoCurr;
    ValorePrev:=ValoreCurr;
    DescPrev:=DescCurr;
  end;
end;

procedure TC006FStoriaDati.C006FStoriaDatiDestroy(Sender: TObject);
begin
  PulisciLista;
  try FreeAndNil(I010); except end;
end;

procedure TC006FStoriaDati.GetStoriaDatoP430(P:Integer; Dato:String; Data:TDateTime = 0);
var i:Integer;
    DescrizioneStorico:String;
    Valore:String;
    ObjStoria:RecStoria;
    L:TStringList;
    Assunzione,Cessazione:TDateTime;
begin
  L:=TStringList.Create;
  L.CommaText:=Dato;
  selP430Storico.Close;
  selP430Storico.ClearVariables;//Necessario per assegnare null alla variabile Data se il parametro vale 0
  selP430Storico.SetVariable('Progressivo',P);
  if Data <> 0 then
    selP430Storico.SetVariable('Data',Data);//Estraggo solo i dati di una decorrenza e del periodo precedente contiguo
  selP430Storico.Open;
  I010.Open;
  PulisciLista;
  StoriaDipendente:=TList.Create;
  for i:=0 to selP430Storico.FieldCount - 1 do
  begin
    if (selP430Storico.Fields[i].FieldName = 'PROGRESSIVO') then
      Continue;
    if (Dato <> '*') and (L.IndexOf(selP430Storico.Fields[i].FieldName) = -1) then
      Continue;
    selP430Storico.First;
    ObjStoria:=RecStoria.Create;
    StoriaDipendente.Add(ObjStoria);
    try
      DescrizioneStorico:=I010.Lookup('NOME_CAMPO','P430' + selP430Storico.Fields[i].FieldName,'NOME_LOGICO');
    except
      DescrizioneStorico:=selP430Storico.Fields[i].FieldName;
    end;
    Anno:=FormatDateTime('yyyy',selP430Storico.FieldByName('Decorrenza').AsDateTime);
    if Parametri.CampiRiferimento.C19_StoriaInizioFine <> 'N' then
    begin
      ObjStoria.Assunzione:=selP430Storico.FieldByName('Inizio').AsDateTime;
      ObjStoria.Cessazione:=selP430Storico.FieldByName('Fine').AsDateTime;
      Assunzione:=ObjStoria.Assunzione;
      if selP430Storico.FieldByName('Fine').IsNull then
        Cessazione:=EncodeDate(3999,12,31)
      else
        Cessazione:=selP430Storico.FieldByName('Fine').AsDateTime;
    end
    else
    begin
      ObjStoria.Assunzione:=0;
      Assunzione:=ObjStoria.Assunzione;
      ObjStoria.Cessazione:=EncodeDate(3999,12,31);
      Cessazione:=ObjStoria.Cessazione;
    end;
    ObjStoria.DataDec:=FormatDateTime('dd/mm/yyyy',Max(selP430Storico.FieldByName('Decorrenza').AsDateTime,Assunzione));
    ObjStoria.DataFine:=FormatDateTime('dd/mm/yyyy',Min(selP430Storico.FieldByName('Decorrenza_Fine').AsDateTime,Cessazione));
    ObjStoria.Decorrenza:=Max(selP430Storico.FieldByName('Decorrenza').AsDateTime,Assunzione);
    ObjStoria.Fine:=Min(selP430Storico.FieldByName('Decorrenza_Fine').AsDateTime,Cessazione);
    ObjStoria.TipoDato:=DescrizioneStorico;
    ObjStoria.NomeCampo:=selP430Storico.Fields[i].FieldName;
    Valore:=selP430Storico.Fields[i].AsString;
    ObjStoria.Valore:=Valore;
    ObjStoria.Descrizione:=DescrizioneDatoStoricoP430(selP430Storico.Fields[i].FieldName,ObjStoria.Valore);
    while not selP430Storico.Eof do
    begin
      Anno:=FormatDateTime('yyyy',selP430Storico.FieldByName('Decorrenza').AsDateTime);  //Lorena 05/09/2011
      if (Parametri.CampiRiferimento.C19_StoriaInizioFine = 'N') or (selP430Storico.FieldByName('Fine').IsNull) then
        Cessazione:=EncodeDate(3999,12,31)
      else
        Cessazione:=selP430Storico.FieldByName('Fine').AsDateTime;
      if ((ObjStoria.Assunzione <> Assunzione) and (Assunzione <> (ObjStoria.Cessazione + 1))) or (ObjStoria.Valore <> Valore) or (ObjStoria.Descrizione <> DescrizioneDatoStoricoP430(selP430Storico.Fields[i].FieldName,ObjStoria.Valore)) then
      begin
        ObjStoria:=RecStoria.Create;
        StoriaDipendente.Add(ObjStoria);
        ObjStoria.TipoDato:=DescrizioneStorico;
        ObjStoria.NomeCampo:=selP430Storico.Fields[i].FieldName;
        if Parametri.CampiRiferimento.C19_StoriaInizioFine <> 'N' then
        begin
          ObjStoria.Assunzione:=selP430Storico.FieldByName('Inizio').AsDateTime;
          ObjStoria.Cessazione:=selP430Storico.FieldByName('Fine').AsDateTime;
        end
        else
        begin
          ObjStoria.Assunzione:=0;
          ObjStoria.Cessazione:=EncodeDate(3999,12,31);
        end;
        ObjStoria.DataDec:=FormatDateTime('dd/mm/yyyy',Max(selP430Storico.FieldByName('Decorrenza').AsDateTime,Assunzione));
        ObjStoria.DataFine:=FormatDateTime('dd/mm/yyyy',Min(selP430Storico.FieldByName('Decorrenza_Fine').AsDateTime,Cessazione));
        ObjStoria.Decorrenza:=Max(selP430Storico.FieldByName('Decorrenza').AsDateTime,Assunzione);
        ObjStoria.Fine:=Min(selP430Storico.FieldByName('Decorrenza_Fine').AsDateTime,Cessazione);
        try
          DescrizioneStorico:=I010.Lookup('NOME_CAMPO','P430' + selP430Storico.Fields[i].FieldName,'NOME_LOGICO');
        except
          DescrizioneStorico:=selP430Storico.Fields[i].FieldName;
        end;
        ObjStoria.Valore:=Valore;
        ObjStoria.Descrizione:=DescrizioneDatoStoricoP430(selP430Storico.Fields[i].FieldName,ObjStoria.Valore);
        end
      else
      begin
        ObjStoria.DataFine:=FormatDateTime('dd/mm/yyyy',Min(selP430Storico.FieldByName('Decorrenza_Fine').AsDateTime,Cessazione));
        ObjStoria.Fine:=Min(selP430Storico.FieldByName('Decorrenza_Fine').AsDateTime,Cessazione);
      end;
      selP430Storico.Next;
      Valore:=selP430Storico.Fields[i].AsString;
      if Parametri.CampiRiferimento.C19_StoriaInizioFine <> 'N' then
        Assunzione:=selP430Storico.FieldByName('Inizio').AsDateTime
      else
        Assunzione:=0;
    end;
  end;
  for I := StoriaDipendente.Count - 1 downto 0 do
    if RecStoria(StoriaDipendente[i]).Decorrenza > RecStoria(StoriaDipendente[i]).Fine then
      StoriaDipendente.Delete(i);
  //Se si vogliono estrarre solo i dati storicizzati...
  if Data <> 0 then
    CancellaDatiNonStoricizzati('P430');
  L.Free;
  //I010.Close;
end;

function TC006FStoriaDati.DescrizioneDatoStoricoP430(TipoDato:String; Codice:String):String;
{Restituisce la descrizione del dato letta sulla tabella specifica}
var T,C,Storico:String;
begin
  Result:='';
  if TipoDato = 'STATO_DIPENDENTE' then
  begin
    if Codice = '0' then Result:='Non dipendente'
    else if Codice = '1' then Result:='Dipendente retribuito'
    else Result:='Dipendente non retribuito';
  end
  else if TipoDato = 'NO_CEDOLINO_NORMALE' then
  begin
    if Codice = 'N' then Result:='Completa'
    else if Codice = 'S' then Result:='Voci variabili'
    else Result:='Non emissione';
  end
  else if (TipoDato = 'TREDICESIMA') or (TipoDato = 'CONGUAGLIO') then
  begin
    if Codice = 'C' then Result:='In base al contratto'
    else if Codice = 'T' then Result:='Tutti i mesi'
    else if Codice = 'S' then Result:='Si'
    else Result:='No';
  end
  else if TipoDato = 'TIPO_CALCOLO_IMPORTO13A' then
  begin
    if Codice = 'AC' then Result:='In base al contratto'
    else if Codice = 'UM' then Result:='Calcolo considerando solo la retribuzione dell''ultimo mese'
    else Result:='Calcolo considerando la retribuzione di tutti i mesi';
  end
  else if (TipoDato = 'PERC_IRPEF_MASSIMA_EXTRA27') then
  begin
    if Codice = 'S' then Result:='Massima percentuale anno'
    else Result:='Percentuale scaglionata';
  end
  else if (TipoDato = 'DETRAZ_LAVDIP') then
  begin
    if Codice = 'S' then Result:='Detrazioni per redditi di lavoro dipendente e assimilati'
    else if Codice = 'A' then Result:='Detrazioni per altri redditi'
    else if Codice = 'N' then Result:='Nessuna detrazione del tipo precedente';
  end
  else if (TipoDato = 'DETRAZ_REDDITI_MIN_INDET') then
  begin
    if Codice = 'S' then Result:='Minimo annuale garantito per contratto a tempo indeterminato'
    else Result:='Nessun minimo annuale garantito per contratto a tempo indeterminato';
  end
  else if (TipoDato = 'DETRAZ_REDDITI_MIN_DET') then
  begin
    if Codice = 'S' then Result:='Minimo annuale garantito per contratto a tempo determinato'
    else Result:='Nessun minimo annuale garantito per contratto a tempo determinato';
  end
  else if TipoDato = 'TIPO_DIPENDENTE' then
  begin
    if Codice = 'RU' then Result:='Tempo indeterminato'
    else if Codice = 'IN' then Result:='Tempo determinato'
    else if Codice = 'ER' then Result:='Erede'
    else if Codice = 'BO' then Result:='Borsista'
    else if Codice = 'CO' then Result:='Parasubordinato - Gestione separata INPS'
    else if Codice = 'AS' then Result:='Altro assimilato'
    else if Codice = 'LU' then Result:='L.S.U'
    else if Codice = 'LA' then Result:='Sanitario convenzionato - Lav. autonomo'
    else if Codice = 'SR' then Result:='Sanitario convenzionato tempo indeterminato'
    else if Codice = 'SI' then Result:='Sanitario convenzionato tempo determinato'
    else Result:='?';
  end
  else if TipoDato = 'PROFESSIONE_ONAOSI' then
  begin
    if Codice = 'M' then Result:='Medici'
    else if Codice = 'F' then Result:='Farmacisti'
    else if Codice = 'V' then Result:='Veterinari'
    else if Codice = 'O' then Result:='Odontoiatri';
  end
  else if TipoDato = 'TIPO_MASSIMALE_CONTR' then
  begin
    if Codice = 'N' then Result:='Nessuno'
    else if Codice = 'I' then Result:='Nuovo iscritto dal 1/1/96 a forme pensionistiche obbligatorie oppure optante per il sistema contributivo'
    else if Codice = 'D' then Result:='Direttore di azienda sanitaria locale o azienda ospedaliera';
  end
  else if TipoDato = 'ALTRA_AMM' then
  begin
    if Codice = 'N' then Result:='Nessuna'
    else if Codice = 'O' then Result:='Dipendente in servizio presso altra amministrazione'
    else if Codice = 'I' then Result:='Dipendente di altra amministrazione'
    else if Codice = 'D' then Result:='Direttore di azienda sanitaria locale o azienda ospedaliera proveniente da altro ente versante';
  end
  else if TipoDato = 'BONUS_RIDUZ_CUNEO_FISC' then
  begin
    if Codice = 'S' then Result:='Riconosciuto con conguaglio'
    else if Codice = 'Z' then Result:='Riconosciuto senza conguaglio'
    else if Codice = 'N' then Result:='Non riconosciuto';
  end
  else
  begin
    A000GetTabellaP430(TipoDato,T,C,Storico);
    if (T <> '') and (T <> 'P430_ANAGRAFICO') then
    begin
      QLookup.SQL.Clear;
      if T = 'T030_ANAGRAFICO' then
        QLookup.SQL.Add(Format('SELECT COGNOME || '' '' || NOME FROM %s WHERE %s = ''%s''',[T,C,Codice]))
      else if T = 'T480_COMUNI' then
        QLookup.SQL.Add(Format('SELECT CITTA FROM %s WHERE %s = ''%s''',[T,C,Codice]))
      else if T = 'P004_CODICITABANNUALI' then
        QLookup.SQL.Add(Format('SELECT DESCRIZIONE FROM P004_CODICITABANNUALI WHERE COD_TABANNUALE = ''%s'' AND COD_CODICITABANNUALI = ''%s'' AND ANNO = %s',[CodTabAnnualeP430(TipoDato),Codice,Anno]))
      else if Storico = 'S' then
      begin
        QLookup.SQL.Add('SELECT DESCRIZIONE FROM ' + T + ' T1 WHERE ' + C + ' = ''' + Codice + '''');
        QLookup.SQL.Add(' AND DECORRENZA = (SELECT MAX(DECORRENZA) FROM ' + T + ' WHERE ' + C + ' = ''' + Codice + '''');
        QLookup.SQL.Add(' AND DECORRENZA <= TO_DATE(''' + FormatDateTime('dd/mm/yyyy',selP430Storico.FieldByName('DECORRENZA_FINE').AsDateTime));
        QLookup.SQL.Add(''',''dd/mm/yyyy''))');
      end
      else
        QLookup.SQL.Add(Format('SELECT DESCRIZIONE FROM %s WHERE %s = ''%s''',[T,C,Codice]));
      QLookup.Close;
      QLookup.Open;
      Result:=QLookup.Fields[0].AsString;
      QLookup.Close;
    end;
  end;
end;

function TC006FStoriaDati.CodTabAnnualeP430(TipoDato: String):String;
begin
  if TipoDato = 'COD_CUDINPDAPCAUSACESS' then Result:='IPCAUSCESS'
  else if TipoDato = 'COD_INPDAPMOTIVOSOSP_FPC' then Result:='IPMSOSPFPC'
  else if TipoDato = 'COD_INPDAPTIPOCESS_FPC' then Result:='IPCCESSFPC'
  else if TipoDato = 'COD_CATEGPARTICOLARE' then Result:='770CATPART'
  else if TipoDato = 'COD_QUALIFICA_INAIL' then Result:='770QUAUCAT'
  else if TipoDato = 'COD_CAUSALELA' then Result:='770CAUSPAG'
  else if TipoDato = 'COD_TIPORAPP_COCOCO' then Result:='ISTIPRAPCO'
  else if TipoDato = 'COD_TIPOATT_COCOCO0' then Result:='ISTIPATTCO'
  else if TipoDato = 'COD_ALTRAASS_COCOCO' then Result:='ISALTASSCO'
  else if TipoDato = 'COD_EMENSTIPOASS' then Result:='ISTIPASSUN'
  else if TipoDato = 'COD_EMENSTIPOCESS' then Result:='ISTIPCESS'
  else if TipoDato = 'COD_ONAOSITIPOASS' then Result:='ONTIPASSUN'
  else if TipoDato = 'COD_ONAOSITIPOCESS' then Result:='ONTIPCESS'
  else if TipoDato = 'COD_ONAOSITIPOPAG' then Result:='ONTIPPAG'
  else if TipoDato = 'COD_CATEG_CONVENZ' then Result:='ENCATCONV'
  else if TipoDato = 'COD_INPDAPTIPOLS_ALTRA_AMM' then Result:='IPTIPOLSER';
end;

end.
