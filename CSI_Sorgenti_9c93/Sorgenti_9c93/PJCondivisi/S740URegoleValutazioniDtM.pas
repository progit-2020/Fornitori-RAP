unit S740URegoleValutazioniDtM;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, R004UGESTSTORICODTM, DB, OracleData, USelI010, A000UCostanti, A000USessione, Math,
  A000UInterfaccia, C180FunzioniGenerali, StrUtils, Oracle, MedpBackupOldValue;

type
  TCampi = record
    Ord:Word;
    Nome,
    Desc,
    Default:String;
  end;

  TS740FRegoleValutazioniDtM = class(TR004FGestStoricoDtM)
    SG741: TOracleDataSet;
    D010: TDataSource;
    SG741DATO_STAMPA_1: TStringField;
    SG741DATO_STAMPA_2: TStringField;
    SG741DATO_STAMPA_3: TStringField;
    SG741DATO_STAMPA_4: TStringField;
    SG741DATO_STAMPA_5: TStringField;
    SG741DECORRENZA: TDateTimeField;
    SG741DECORRENZA_FINE: TDateTimeField;
    SG741GIORNI_MINIMI: TIntegerField;
    SG741LOGO_LARGHEZZA: TIntegerField;
    SG741LOGO_ALTEZZA: TIntegerField;
    SG741DATO_STAMPA_6: TStringField;
    SG741DESC_LUNGA_1: TStringField;
    SG741DESC_LUNGA_3: TStringField;
    SG741DESC_LUNGA_5: TStringField;
    SG741PATH_ISTRUZIONI: TStringField;
    SG741DATO_VARIAZIONE_VALUTATORE: TStringField;
    SG741TESTO_VALUTAZIONI_COMPLESSIVE: TStringField;
    SG741ABILITA_COMMENTI_VALUTATO: TStringField;
    SG741AREA_FORMATIVA_OBBLIGATORIA: TStringField;
    SG741AGGIORNA_DATA_COMPILAZIONE: TStringField;
    SG741ABILITA_AREE_FORMATIVE: TStringField;
    SG741ABILITA_ACCETTAZIONE_VALUTATO: TStringField;
    SG741STAMPA_VARIAZIONI_5: TStringField;
    SG741DATA_DA_OBIETTIVI: TDateTimeField;
    SG741DATA_A_OBIETTIVI: TDateTimeField;
    SG741CODICE: TStringField;
    SG741DESCRIZIONE: TStringField;
    SG741FILTRO_ANAGRAFE: TStringField;
    SG741PAGINE_ABILITATE: TStringField;
    SG741ASSEGN_PREVENTIVA_OBIETTIVI: TStringField;
    selT450: TOracleDataSet;
    SG741COD_TIPI_RAPPORTO: TStringField;
    selColOpzionali: TOracleDataSet;
    SG741CAMPI_OPZIONALI_STAMPA: TStringField;
    SG741CAMPI_OPZIONALI_COMPILAZIONE: TStringField;
    SG741STAMPA_PERIODO_VALUTAZIONE: TStringField;
    SG742: TOracleDataSet;
    D742: TDataSource;
    SG742CODREGOLA: TStringField;
    SG742NOME_CAMPO: TStringField;
    SG742ETICHETTA: TStringField;
    SG742ORDINE: TFloatField;
    SG742DECORRENZA: TDateTimeField;
    delSG742: TOracleQuery;
    insaSG742: TOracleQuery;
    insSG742: TOracleQuery;
    updSG742: TOracleQuery;
    SG741MODIFICA_NOTE_SUPERVISOREVALUT: TStringField;
    SG741VALUTA_CESSATI_RUOLO: TStringField;
    SG741PATH_FILEPDF: TStringField;
    selSG750: TOracleDataSet;
    D750: TDataSource;
    SG741D_PARPROTOCOLLO: TStringField;
    SG741COD_PARPROTOCOLLO: TStringField;
    SG741PATH_INFORMAZIONI: TStringField;
    SG742DESCRIZIONE: TStringField;
    SG741INVIO_EMAIL: TStringField;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
    procedure BeforePost(DataSet: TDataSet); override;
    procedure SG741AfterScroll(DataSet: TDataSet);
    procedure SG742BeforeInsert(DataSet: TDataSet);
    procedure SG742BeforeDelete(DataSet: TDataSet);
    procedure SG742BeforeEdit(DataSet: TDataSet);
    procedure BeforeDelete(DataSet: TDataSet); override;
    procedure AfterPost(DataSet: TDataSet); override;
    procedure SG742CalcFields(DataSet: TDataSet);
    procedure SG741CalcFields(DataSet: TDataSet);
    procedure SG741AfterOpen(DataSet: TDataSet);
  private
    { Private declarations }
    Storicizzato:Boolean;
    SG741OldValues: TmedpBackupOldValue;
  public
    { Public declarations }
    selI010:TselI010;
    ListaCodiciTipoRapporto: TStringList;
  end;

var
  S740FRegoleValutazioniDtM: TS740FRegoleValutazioniDtM;

const
  OpzioneFirma6: String = '#FIRMA_6#';
  Campi:array [1..58] of TCampi = (
    (Ord:1;  Nome:'ANNO_VALUTAZIONE_C';        Desc:'Anno di valutazione (compilazione)';        Default:'Anno valutazione'),
    (Ord:2;  Nome:'ANNO_VALUTAZIONE_S';        Desc:'Anno di valutazione (stampa)';              Default:'Anno valutazione'),
    (Ord:3;  Nome:'PERIODO_VALUTAZIONE_S';     Desc:'Periodo di valutazione (stampa)';           Default:'dal #DALdd/mm# al #ALdd/mm#'),
    (Ord:4;  Nome:'VALUTATO_C';                Desc:'Dipendente valutato (compilazione)';        Default:'Valutato'),
    (Ord:5;  Nome:'VALUTATO_S';                Desc:'Dipendente valutato (stampa)';              Default:'Valutato'),
    (Ord:6;  Nome:'VALUTATORE_C';              Desc:'Valutatore (compilazione)';                 Default:'Valutatore'),
    (Ord:7;  Nome:'VALUTATORE_S';              Desc:'Valutatore (stampa)';                       Default:'Valutatore'),
    (Ord:8;  Nome:'PUNTEGGIO_FINALE_SCHEDA_C'; Desc:'Punteggio finale scheda (compilazione)';    Default:'Punteggio finale pesato'),
    (Ord:9;  Nome:'PUNTEGGIO_FINALE_SCHEDA_S'; Desc:'Punteggio finale scheda (stampa)';          Default:'Punteggio finale pesato'),
    (Ord:10; Nome:'DATO_STAMPA_1_S';           Desc:'Dato anagrafico 1 (stampa)';                Default:''),
    (Ord:11; Nome:'DATO_STAMPA_2_S';           Desc:'Dato anagrafico 2 (stampa)';                Default:''),
    (Ord:12; Nome:'DATO_STAMPA_3_S';           Desc:'Dato anagrafico 3 (stampa)';                Default:''),
    (Ord:13; Nome:'DATO_STAMPA_4_S';           Desc:'Dato anagrafico 4 (stampa)';                Default:''),
    (Ord:14; Nome:'DATO_STAMPA_5_S';           Desc:'Dato anagrafico 5 (stampa)';                Default:''),
    (Ord:15; Nome:'DATO_STAMPA_6_S';           Desc:'Dato anagrafico 6 (stampa)';                Default:''),
    (Ord:16; Nome:'CODICE_AREA_C';             Desc:'Codice area (compilazione)';                Default:'Cod. area'),
    (Ord:17; Nome:'CODICE_AREA_S';             Desc:'Codice area (stampa)';                      Default:'Codice area'),
    (Ord:18; Nome:'DESCRIZIONE_AREA_C';        Desc:'Descrizione area (compilazione)';           Default:'Descrizione area'),
    (Ord:19; Nome:'DESCRIZIONE_AREA_S';        Desc:'Descrizione area (stampa)';                 Default:'Descrizione area'),
    (Ord:20; Nome:'PESO_AREA_C';               Desc:'Peso % area (compilazione)';                Default:'Peso % area'),
    (Ord:21; Nome:'PESO_AREA_S';               Desc:'Peso % area (stampa)';                      Default:'Peso %'),
    (Ord:22; Nome:'PUNTEGGIO_AREA_C';          Desc:'Punteggio area (compilazione)';             Default:'Punt. area'),
    (Ord:23; Nome:'PUNTEGGIO_AREA_S';          Desc:'Punteggio area (stampa)';                   Default:'Punteggio'),
    (Ord:24; Nome:'CODICE_ITEM_C';             Desc:'Codice elemento (compilazione)';            Default:'Cod. elem.'),
    (Ord:25; Nome:'CODICE_ITEM_S';             Desc:'Codice elemento (stampa)';                  Default:'Codice elem.'),
    (Ord:26; Nome:'DESCRIZIONE_ITEM_C';        Desc:'Descrizione elemento (compilazione)';       Default:'Descrizione elem.'),
    (Ord:27; Nome:'DESCRIZIONE_ITEM_S';        Desc:'Descrizione elemento (stampa)';             Default:'Descrizione elemento'),
    (Ord:28; Nome:'ITEM_VALUTABILE_C';         Desc:'Elemento valutabile (compilazione)';        Default:'Valutabile'),
    (Ord:29; Nome:'ITEM_VALUTABILE_S';         Desc:'Elemento valutabile (stampa)';              Default:'Valutab.'),
    (Ord:30; Nome:'PESO_ITEM_C';               Desc:'Peso % elemento (compilazione)';            Default:'Peso % elem.'),
    (Ord:31; Nome:'PESO_ITEM_S';               Desc:'Peso % elemento (stampa)';                  Default:'Peso %'),
    (Ord:32; Nome:'SOGLIA_PUNTEGGIO_ITEM_C';   Desc:'Soglia raggiung. elemento (compilazione)';  Default:'Soglia'),
    (Ord:33; Nome:'SOGLIA_PUNTEGGIO_ITEM_S';   Desc:'Soglia raggiung. elemento (stampa)';        Default:'Soglia'),
    (Ord:34; Nome:'PUNTEGGIO_ITEM_C';          Desc:'Punteggio elemento (compilazione)';         Default:'Punt. elem.'),
    (Ord:35; Nome:'PUNTEGGIO_ITEM_S';          Desc:'Punteggio elemento (stampa)';               Default:'Punteggio'),
    (Ord:36; Nome:'NOTE_PUNTEGGIO_C';          Desc:'Note punteggio elemento (compilazione)';    Default:'Note punt.'),
    (Ord:37; Nome:'NOTE_PUNTEGGIO_S';          Desc:'Note punteggio elemento (stampa)';          Default:'Note punteggio'),
    (Ord:38; Nome:'PUNTEGGIO_PESATO_ITEM_C';   Desc:'Punteggio pesato elemento (compilazione)';  Default:'Punt. pesato elem.'),
    (Ord:39; Nome:'PUNTEGGIO_PESATO_ITEM_S';   Desc:'Punteggio pesato elemento (stampa)';        Default:'Punt. pes.'),
    (Ord:40; Nome:'VALUTAZIONE_INTERMEDIA_C';  Desc:'Valutazione intermedia (compilazione)';     Default:'Valutazione intermedia'),
    (Ord:41; Nome:'VALUTAZIONE_INTERMEDIA_S';  Desc:'Valutazione intermedia (stampa)';           Default:'Valutazione intermedia'),
    (Ord:42; Nome:'VALUTAZIONI_COMPLESSIVE_C'; Desc:'Valutazioni complessive (compilazione)';    Default:'Valutazioni complessive'),
    (Ord:43; Nome:'VALUTAZIONI_COMPLESSIVE_S'; Desc:'Valutazioni complessive (stampa)';          Default:'Valutazioni complessive'),
    (Ord:44; Nome:'OBIETTIVI_PIANIFICATI_C';   Desc:'Obiettivi pianificati (compilazione)';      Default:'Obiettivi pianificati'),
    (Ord:45; Nome:'OBIETTIVI_PIANIFICATI_S';   Desc:'Obiettivi pianificati (stampa)';            Default:'Obiettivi pianificati'),
    (Ord:46; Nome:'PROPOSTE_FORMATIVE_C';      Desc:'Proposte formative (compilazione)';         Default:'Proposte formative'),
    (Ord:47; Nome:'PROPOSTE_FORMATIVE_S';      Desc:'Proposte formative (stampa)';               Default:'Proposte formative'),
    (Ord:48; Nome:'COMMENTI_VALUTATO_C';       Desc:'Commenti del valutato (compilazione)';      Default:'Commenti valutato'),
    (Ord:49; Nome:'COMMENTI_VALUTATO_S';       Desc:'Commenti del valutato (stampa)';            Default:'Commenti valutato'),
    (Ord:50; Nome:'NOTE_C';                    Desc:'Note (compilazione)';                       Default:'Note'),
    (Ord:51; Nome:'NOTE_S';                    Desc:'Note (stampa)';                             Default:'Note'),
    (Ord:52; Nome:'ITEM_PERSONALIZZATO_S';     Desc:'Presenza elemento personalizzato (stampa)'; Default:'Elemento personalizzato'),
    (Ord:53; Nome:'FIRMA_1_S';                 Desc:'Firma 1 (stampa)';                          Default:'VALUTATORE'),
    (Ord:54; Nome:'FIRMA_2_S';                 Desc:'Firma 2 (stampa)';                          Default:'VALUTATO per presa visione'),
    (Ord:55; Nome:'FIRMA_3_S';                 Desc:'Firma 3 (stampa)';                          Default:'DIRETTORE SC/DIP per presa visione'),
    (Ord:56; Nome:'FIRMA_4_S';                 Desc:'Firma 4 (stampa)';                          Default:''),
    (Ord:57; Nome:'FIRMA_5_S';                 Desc:'Firma 5 (stampa)';                          Default:''),
    (Ord:58; Nome:'FIRMA_6_S';                 Desc:'Firma 6 (stampa)';                          Default:'')
    );

implementation

{$R *.dfm}
uses
  S740URegoleValutazioni;

procedure TS740FRegoleValutazioniDtM.DataModuleCreate(Sender: TObject);
begin
  inherited;
  InterfacciaR004:=S740FRegoleValutazioni.InterfacciaR004;
  InizializzaDataSet(SG741,[evBeforeEdit,
                            evBeforeInsert,
                            evBeforePost,
                            evBeforeDelete,
                            evAfterDelete,
                            evAfterPost,
                            evOnNewRecord,
                            evOnTranslateMessage]);
  selSG750.Open;
  S740FRegoleValutazioni.DButton.DataSet:=SG741;
  SG741OldValues:=TmedpBackupOldValue.Create(Self,SG741);
  SG741.Open;
  selI010:=TselI010.Create(Self);
  selI010.Apri(SessioneOracle,Parametri.Layout,Parametri.Applicazione,'NOME_CAMPO,NOME_LOGICO,POSIZIONE','TABLE_NAME NOT IN (''T030_ANAGRAFICO'',''T480_COMUNI'')','NOME_LOGICO');
  selI010.Close;
  selI010.SQL.Insert(0,'SELECT ''' + OpzioneFirma6 + ''' NOME_CAMPO, ''' + OpzioneFirma6 + ''' NOME_LOGICO, 9999 POSIZIONE FROM DUAL UNION ');
  selI010.Open;
  D010.DataSet:=selI010;
  selT450.Open;
  selColOpzionali.Open;
  while not selColOpzionali.Eof do
  begin
    if selColOpzionali.FieldByName('ORDINE').AsInteger <> 5 then
      S740FRegoleValutazioni.clbCampiOpzionaliStampa.Items.Add(selColOpzionali.FieldByName('DESCRIZIONE').AsString);
    S740FRegoleValutazioni.clbCampiOpzionaliCompilazione.Items.Add(selColOpzionali.FieldByName('DESCRIZIONE').AsString);
    selColOpzionali.Next;
  end;
  ListaCodiciTipoRapporto:=TStringList.Create;
  with selT450 do
    while not Eof do
    begin
      ListaCodiciTipoRapporto.Add(Format('%-5s %s',[FieldByName('Codice').AsString,FieldByName('Descrizione').AsString]));
      Next;
    end;
end;

procedure TS740FRegoleValutazioniDtM.DataModuleDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(ListaCodiciTipoRapporto);
  FreeAndNil(selI010);
end;

procedure TS740FRegoleValutazioniDtM.SG741AfterOpen(DataSet: TDataSet);
begin
  SG741OldValues.CreaStruttura;
end;

procedure TS740FRegoleValutazioniDtM.SG741AfterScroll(DataSet: TDataSet);
begin
  inherited;
  SG741OldValues.Aggiorna;
  SG742.Close;
  SG742.SetVariable('DECORRENZA',SG741.FieldByName('DECORRENZA').AsDateTime);
  SG742.SetVariable('CODREGOLA',SG741.FieldByName('CODICE').AsString);
  SG742.Open;
end;

procedure TS740FRegoleValutazioniDtM.SG741CalcFields(DataSet: TDataSet);
begin
  inherited;
  SG741.FieldByName('D_PARPROTOCOLLO').AsString:=VarToStr(selSG750.Lookup('CODICE',SG741.FieldByName('COD_PARPROTOCOLLO').AsString,'DESCRIZIONE'));
end;

procedure TS740FRegoleValutazioniDtM.SG742BeforeDelete(DataSet: TDataSet);
begin
  inherited;
  abort;
end;

procedure TS740FRegoleValutazioniDtM.SG742BeforeEdit(DataSet: TDataSet);
begin
  inherited;
  if not (SG741.State in [dsInsert,dsEdit]) then
    abort;
end;

procedure TS740FRegoleValutazioniDtM.SG742BeforeInsert(DataSet: TDataSet);
begin
  inherited;
  abort;
end;

procedure TS740FRegoleValutazioniDtM.SG742CalcFields(DataSet: TDataSet);
var i:Integer;
begin
  inherited;
  for i:=1 to High(Campi) do
    if Campi[i].Nome = SG742.FieldByName('NOME_CAMPO').AsString then
    begin
      SG742.FieldByName('DESCRIZIONE').AsString:=Campi[i].Desc;
      Break;
    end;
end;

procedure TS740FRegoleValutazioniDtM.AfterPost(DataSet: TDataSet);
var i:Integer;
    Trovato:Boolean;
    svDecorrenza:TDateTime;
    svCodice:String;
begin
  svDecorrenza:=SG741.FieldByName('DECORRENZA').AsDateTime;
  svCodice:=SG741.FieldByName('CODICE').AsString;
  inherited;
  //Copio i dati dal record precedente, dopo l'automatismo dell'appiattimento dei record uguali
  if Storicizzato
  and (svDecorrenza = SG741.FieldByName('DECORRENZA').AsDateTime)
  and (svCodice = SG741.FieldByName('CODICE').AsString) then
  begin
    insaSG742.SetVariable('DECORRENZA_OLD',svDecorrenza);
    insaSG742.SetVariable('DECORRENZA_NEW',SG741.FieldByName('DECORRENZA').AsDateTime);
    insaSG742.SetVariable('CODREGOLA',SG741.FieldByName('CODICE').AsString);
    insaSG742.Execute;
    SessioneOracle.Commit;
  end;
  if SG741.RecordCount > 0 then
  begin
    SG742.Close;
    SG742.SetVariable('DECORRENZA',SG741.FieldByName('DECORRENZA').AsDateTime);
    SG742.SetVariable('CODREGOLA',SG741.FieldByName('CODICE').AsString);
    SG742.Open;
    //Inserisco i record mancanti
    for i:=1 to High(Campi) do
      if not SG742.SearchRecord('NOME_CAMPO',Campi[i].Nome,[srFromBeginning]) then
      begin
        insSG742.SetVariable('DECORRENZA',SG741.FieldByName('DECORRENZA').AsDateTime);
        insSG742.SetVariable('CODREGOLA',SG741.FieldByName('CODICE').AsString);
        insSG742.SetVariable('NOME_CAMPO',Campi[i].Nome);
        insSG742.SetVariable('ETICHETTA',Campi[i].Default);
        insSG742.SetVariable('ORDINE',Campi[i].Ord);
        insSG742.Execute;
      end;
    SessioneOracle.Commit;
    //Aggiorno quelli esistenti e cancello quelli obsoleti
    with SG742 do
    begin
      Refresh;
      First;
      while not Eof do
      begin
        Trovato:=False;
        for i:=1 to High(Campi) do
          if Campi[i].Nome = FieldByName('NOME_CAMPO').AsString then
          begin
            Trovato:=True;
            Break;
          end;
        if Trovato then
        begin
          updSG742.SetVariable('DECORRENZA',FieldByName('DECORRENZA').AsDateTime);
          updSG742.SetVariable('CODREGOLA',FieldByName('CODREGOLA').AsString);
          updSG742.SetVariable('NOME_CAMPO',FieldByName('NOME_CAMPO').AsString);
          updSG742.SetVariable('ORDINE',Campi[i].Ord);
          updSG742.Execute;
        end
        else
        begin
          delSG742.SetVariable('DECORRENZA',FieldByName('DECORRENZA').AsDateTime);
          delSG742.SetVariable('CODREGOLA',FieldByName('CODREGOLA').AsString);
          delSG742.SetVariable('NOME_CAMPO',FieldByName('NOME_CAMPO').AsString);
          delSG742.Execute;
        end;
        Next;
      end;
      SessioneOracle.Commit;
      Refresh;
    end;
  end;
end;

procedure TS740FRegoleValutazioniDtM.BeforeDelete(DataSet: TDataSet);
begin
  Storicizzato:=False;
  delSG742.SetVariable('DECORRENZA',SG741.FieldByName('DECORRENZA').AsDateTime);
  delSG742.SetVariable('CODREGOLA',SG741.FieldByName('CODICE').AsString);
  delSG742.SetVariable('NOME_CAMPO',null);
  delSG742.Execute;
  inherited;
end;

procedure TS740FRegoleValutazioniDtM.BeforePost(DataSet: TDataSet);
var i:Integer;
    s:String;
begin
  with S740FRegoleValutazioni.clbCampiOpzionaliStampa do
    for i:=1 to Items.Count do
      if Checked[i - 1] then
        s:=s + IfThen(s <> '',',') + IntToStr(i);
  SG741.FieldByName('CAMPI_OPZIONALI_STAMPA').AsString:=s;
  s:='';
  with S740FRegoleValutazioni.clbCampiOpzionaliCompilazione do
    for i:=1 to Items.Count do
      if Checked[i - 1] then
        s:=s + IfThen(s <> '',',') + IntToStr(i);
  SG741.FieldByName('CAMPI_OPZIONALI_COMPILAZIONE').AsString:=s;
  //Periodo di assegn. preventiva obiettivi
  if (   (SG741.FieldByName('DATA_DA_OBIETTIVI').AsString = '')
      or (SG741.FieldByName('DATA_A_OBIETTIVI').AsString = ''))
  and (SG741.FieldByName('ASSEGN_PREVENTIVA_OBIETTIVI').AsString = 'S') then
  begin
    S740FRegoleValutazioni.pgcRegole.ActivePage:=S740FRegoleValutazioni.tshP2;
    raise exception.Create('Le date di inizio e fine periodo per l''assegnazione preventiva degli obiettivi devono essere entrambe valorizzate!');
  end;
  if SG741.FieldByName('DATA_DA_OBIETTIVI').AsDateTime > SG741.FieldByName('DATA_A_OBIETTIVI').AsDateTime then
  begin
    S740FRegoleValutazioni.pgcRegole.ActivePage:=S740FRegoleValutazioni.tshP2;
    raise exception.Create('Le date di inizio e fine periodo per l''assegnazione preventiva degli obiettivi devono essere in ordine cronologico!');
  end;
  //Altri controlli
  if (SG741.FieldByName('ABILITA_ACCETTAZIONE_VALUTATO').AsString = 'N')
  and not R180In(SG741.FieldByName('ABILITA_COMMENTI_VALUTATO').AsString,['1','2']) then
  begin
    S740FRegoleValutazioni.pgcRegole.ActivePage:=S740FRegoleValutazioni.tshP4;
    raise Exception.Create('Impostare correttamente il campo "' + S740FRegoleValutazioni.drgpAbilitaCommentiValutato.Caption + '"!');
  end;
  (*SG741.FieldByName('FIRMA_1').AsString:=Trim(SG741.FieldByName('FIRMA_1').AsString);
  SG741.FieldByName('FIRMA_2').AsString:=Trim(SG741.FieldByName('FIRMA_2').AsString);
  SG741.FieldByName('FIRMA_3').AsString:=Trim(SG741.FieldByName('FIRMA_3').AsString);
  SG741.FieldByName('FIRMA_4').AsString:=Trim(SG741.FieldByName('FIRMA_4').AsString);
  SG741.FieldByName('FIRMA_5').AsString:=Trim(SG741.FieldByName('FIRMA_5').AsString);
  SG741.FieldByName('FIRMA_6').AsString:=Trim(SG741.FieldByName('FIRMA_6').AsString);*)
  if (   (SG741.FieldByName('DATO_STAMPA_1').AsString = OpzioneFirma6)
      or (SG741.FieldByName('DATO_STAMPA_2').AsString = OpzioneFirma6)
      or (SG741.FieldByName('DATO_STAMPA_3').AsString = OpzioneFirma6)
      or (SG741.FieldByName('DATO_STAMPA_4').AsString = OpzioneFirma6)
      or (SG741.FieldByName('DATO_STAMPA_5').AsString = OpzioneFirma6)
      or (SG741.FieldByName('DATO_STAMPA_6').AsString = OpzioneFirma6))
  //and (SG741.FieldByName('FIRMA_6').AsString = '') then
  and (   (SG742.RecordCount = 0)
       or (Trim(VarToStr(SG742.Lookup('NOME_CAMPO','FIRMA_6_S','ETICHETTA'))) = '')) then
  begin
    S740FRegoleValutazioni.pgcRegole.ActivePage:=S740FRegoleValutazioni.tshStampa;
    S740FRegoleValutazioni.pgcStampa.ActivePage:=S740FRegoleValutazioni.tshEtichette;
    raise Exception.Create('E'' necessario indicare la sesta firma in quanto è stata scelta in "' + S740FRegoleValutazioni.gbxDatiStampa.Caption + '"!');
  end;
  if SG741.FieldByName('DATO_VARIAZIONE_VALUTATORE').AsString = OpzioneFirma6 then
  begin
    S740FRegoleValutazioni.pgcRegole.ActivePage:=S740FRegoleValutazioni.tshStampa;
    S740FRegoleValutazioni.pgcStampa.ActivePage:=S740FRegoleValutazioni.tshVarie;
    raise Exception.Create('"' + S740FRegoleValutazioni.lblDatoVariazioneValutatore.Caption + '" non può contenere ' + OpzioneFirma6 + '!');
  end;
  SessioneOracle.ApplyUpdates([SG742],True);
  //inherited;
  if SG741.FieldByName('ABILITA_AREE_FORMATIVE').AsString = 'N' then
    SG741.FieldByName('AREA_FORMATIVA_OBBLIGATORIA').AsString:='N';
  if SG741.FieldByName('STAMPA_VARIAZIONI_5').AsString = 'S' then
    SG741.FieldByName('DESC_LUNGA_5').AsString:='S';
  Storicizzato:=InterfacciaR004.StoricizzazioneInCorso;
  if (   ((SG741.FieldByName('DATA_DA_OBIETTIVI').AsString <> '') and (R180Anno(SG741.FieldByName('DATA_DA_OBIETTIVI').AsDateTime) <> R180Anno(SG741.FieldByName('DECORRENZA').AsDateTime)))
      or ((SG741.FieldByName('DATA_A_OBIETTIVI').AsString <> '') and (R180Anno(SG741.FieldByName('DATA_A_OBIETTIVI').AsDateTime) <> R180Anno(SG741.FieldByName('DECORRENZA').AsDateTime))))
  and (   (SG741.FieldByName('DATA_DA_OBIETTIVI').AsDateTime <> SG741OldValues.FieldByName('DATA_DA_OBIETTIVI').Value)
       or (SG741.FieldByName('DATA_A_OBIETTIVI').AsDateTime <> SG741OldValues.FieldByName('DATA_A_OBIETTIVI').Value)) then
    ShowMessage('Attenzione! Il periodo per l''assegnazione preventiva degli obiettivi non è interno all''anno ' + IntToStr(R180Anno(SG741.FieldByName('DECORRENZA').AsDateTime)) + '!');
  inherited;
end;

end.
