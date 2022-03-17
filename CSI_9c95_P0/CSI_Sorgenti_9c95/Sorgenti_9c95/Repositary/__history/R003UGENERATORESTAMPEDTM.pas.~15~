unit R003UGeneratoreStampeDtM;

interface

uses
  Windows, Messages, SysUtils, StrUtils, Classes, Graphics, Controls, Forms, Dialogs, Math,
  Extctrls, DB, StdCtrls, OracleData, Oracle, DBCtrls, Provider, (*Midaslib,*) Crtl, DBClient, Variants,
  A000UCostanti, A000USessione, A000UInterfaccia, C700USelezioneAnagrafe, C180FunzioniGenerali,
  R003USerbatoi, RegistrazioneLog, QueryPK, QueryStorico, P999UGenerale,
  R003UGeneratoreStampeMW, Generics.Collections,A000UMessaggi;

type

  TDipendenteCorrente = record
    Progressivo:Integer;
    Dal,Al:TDateTime;
    DettaglioPeriodicoDal,DettaglioPeriodicoAl:TDateTime;
    CDCPercCodice:String;
  end;

  TR003FGeneratoreStampeDtM = class(TDataModule)
    Q910: TOracleDataSet;
    CD920: TOracleQuery;
    Q275U305: TOracleDataSet;
    selT430: TOracleDataSet;
    cds920: TClientDataSet;
    selT920Stampa: TOracleDataSet;
    updT920DataDecorrenza: TOracleQuery;
    selTestoLog: TOracleDataSet;
    selT919: TOracleDataSet;
    updT920Stampa: TOracleQuery;
    selDropTabs: TOracleDataSet;
    exeDropTabs: TOracleScript;
    selDropUserTabs: TOracleDataSet;
    selChiave: TOracleDataSet;
    selI060: TOracleDataSet;
    selT002Riga: TOracleDataSet;
    procedure R003FGeneratoreStampeDtMCreate(Sender: TObject);
    procedure R003FGeneratoreStampeDtMDestroy(Sender: TObject);
    procedure Q910AfterPost(DataSet: TDataSet);
    procedure Q910AfterDelete(DataSet: TDataSet);
    procedure Q910NewRecord(DataSet: TDataSet);
    procedure Q910AfterOpen(DataSet: TDataSet);
    procedure Q910BeforePost(DataSet: TDataSet);
    procedure Q910BeforeDelete(DataSet: TDataSet);
    procedure Q910AfterInsert(DataSet: TDataSet);
    procedure Q910AfterCancel(DataSet: TDataSet);
    procedure Q910AfterEdit(DataSet: TDataSet);
    procedure cds920AfterPost(DataSet: TDataSet);
    procedure FiltroDizionario(DataSet: TDataSet; var Accept: Boolean);
  private
    { Private declarations }
    OldCodice:String;
    function TogliSuffisso(S:String):String;
    procedure CumulaValore(L:TList; Valore,Key,KeyTot:String; Valido:Boolean);
    procedure TabelleCollegateFilterRecord(DataSet: TDataSet; var Accept: Boolean);
    function CreaTabellaStampa:Boolean;
    function CheckDipendenteInServizio(Data1,Data2:TDateTime):Boolean;
    function NomeUtente2Matricola(NomeUtente:String):String;
    procedure selT909NomeValidate(Sender: TField);
    procedure selT909BeforePost(DataSet: TDataSet);
  protected
    DipendenteCorrente:TDipendenteCorrente;
    ParametriOperatore:String;
    procedure CreaSQLAnagrafico(Campi:String);
    procedure GetAnagrafico;
    function FiltraDipendentiInServizio:Boolean;
    procedure GetSerbatoioStd(R:Byte; selSerbatoio:TOracleDataSet);
    procedure GetDettaglioPeriodicoStd(R:Byte; selSerbatoio:TOracleDataSet);
    function PeriodoStoricoValido(R:Byte):Boolean;
    procedure GetKeyStd(var Key,KeyTot:String; R:Byte; selSerbatoio:TOracleDataSet);
    procedure PutValoreStd(Key,KeyTot:String; R:Byte; selSerbatoio:TOracleDataSet);
    procedure PutValoreListaDataSet(Key,KeyTot:String; R:Byte; selSerbatoi:array of TOracleDataSet);
    //function CheckDipendenteInServizio(Data1,Data2:TDateTime):Boolean;
    procedure AddDatoTabCollegata(OQIns:TOracleQuery; var CreateTable,InsertList,InsertVal:String; Colonna,Tipo:String; TipoVar:Integer);
  public
    { Public declarations }
    R003FGeneratoreStampeMW: TR003FGeneratoreStampeMW;  //istanza di A077MW o P077MW
    cds920ProgressivoPrec:Integer;
    procedure CaricaImpostazioni;
    procedure AttivaCodiciSerbatoi;
    procedure DropT920(Num:Byte);
    procedure CreateT920;
    procedure PutValore(DatiStampaID:Integer; L:TList; Valore,Key,KeyTot:String; Tipo:Byte; Valido:Boolean);
    procedure CreateT920_Assenze(OQIns:TOracleQuery);
    procedure CreateT920_xx(Ins920_xx:TOracleQuery; Tabella:String);
    procedure CaricaT920; virtual; abstract;
    procedure DatiStoriciT920;
    procedure CaricaT920Join;
    function ControllaSemaforo:Boolean;
    procedure BloccaSemaforo;
    function VerificaCreazioneTabellaGenerata(NomeTabella:String):Boolean;
    procedure CreaIndiceTabella(NTab:String);
    function GetTestoAggiuntivo(Nome:String):String;
    function getListCodiciSelezionati: TList<TCodiciTabCollegate>;
  end;

var
  R003FGeneratoreStampeDtM: TR003FGeneratoreStampeDtM;

implementation

uses R003UGeneratoreStampe, R003UDatiCalcolati;

{$R *.DFM}

procedure TR003FGeneratoreStampeDtM.R003FGeneratoreStampeDtMCreate(Sender: TObject);
{Preparo le query Mensili}
var i:Integer;
begin
  R003FGeneratoreStampeDtM:=Self;
  if not(SessioneOracle.Connected) then
  begin
    Password(Application.Name);
    A000ParamDBOracle(SessioneOracle);
  end;
  for i:=0 to Self.ComponentCount - 1 do
  begin
    if Components[i] is TOracleQuery then
      (Components[i] as TOracleQuery).Session:=SessioneOracle;
    if Components[i] is TOracleDataSet then
      (Components[i] as TOracleDataSet).Session:=SessioneOracle;
    if Components[i] is TOracleScript then
      (Components[i] as TOracleScript).Session:=SessioneOracle;
  end;

  R003FGeneratoreStampeMW.SelT910_Funzioni:=Q910;
  R003FGeneratoreStampeMW.selT909.FieldByName('NOME').OnValidate:=selT909NomeValidate;
  R003FGeneratoreStampeMW.selT909.BeforePost:=selT909BeforePost;

  Q910.SetVariable('APPLICAZIONE',Parametri.Applicazione);
  Q910.Open;
  Q275U305.Open;

  //Pulisco il nome dell'operatore in modo che sia un Identificatore valido. Se la richiesta arriva dal web, si usa la matricola concatenata al nome utente per una lunghezza massima di 20 caratteri
  ParametriOperatore:='';
  if R003FGeneratoreStampe.TipoModulo = 'COM' then
    ParametriOperatore:=NomeUtente2Matricola(Parametri.Operatore);
  if ParametriOperatore = '' then
    ParametriOperatore:=Identificatore(Parametri.Operatore)
  else
    ParametriOperatore:=StringReplace(R180DimLungR(ParametriOperatore,8),' ','_',[rfReplaceAll]) + '__' + Copy(Identificatore(Parametri.Operatore),1,10);
  ParametriOperatore:=ParametriOperatore.ToUpper;
end;

procedure TR003FGeneratoreStampeDtM.selT909BeforePost(DataSet: TDataSet);
var
  S: String;
begin
  R003FGeneratoreStampeMW.selT909.FieldByName('ESPRESSIONE').AsString:=EliminaRitornoACapo(R003FGeneratoreStampeMW.selT909.FieldByName('ESPRESSIONE').AsString);
  S:=R003FGeneratoreStampeMW.EsplodiEspressione(R003FDatiCalcolati.dcmbSerbatoi.ItemIndex,R003FGeneratoreStampeMW.selT909.FieldByName('ESPRESSIONE').AsString);
  R003FGeneratoreStampeMW.selT909VerificaNome(R003FGeneratoreStampeMW.selT909);
  case DataSet.State of
    dsEdit:RegistraLog.SettaProprieta('M',R180Query2NomeTabella(DataSet),Copy(Name,1,4),DataSet,True);
    dsInsert:RegistraLog.SettaProprieta('I',R180Query2NomeTabella(DataSet),Copy(Name,1,4),DataSet,True);
  end;
  if (R003FGeneratoreStampeMW.selT909.State = dsEdit) and
     (R003FGeneratoreStampeMW.selT909Nome.medpOldValue <> R003FGeneratoreStampeMW.selT909Nome.AsString) and
     (MessageDlg(A000MSG_R003_MSG_CONFERMA_SOSTITUISCI,mtConfirmation,[mbYes,mbNo],0) = mrYes) then
  begin
    R003FGeneratoreStampeMW.updNomeDatoCalcolato.SetVariable('APPLICAZIONE',Q910.FieldByName('APPLICAZIONE').AsString);
    R003FGeneratoreStampeMW.updNomeDatoCalcolato.SetVariable('VECCHIO_NOME',R003FGeneratoreStampeMW.selT909Nome.medpOldValue);
    R003FGeneratoreStampeMW.updNomeDatoCalcolato.SetVariable('NUOVO_NOME',R003FGeneratoreStampeMW.selT909Nome.AsString);
    R003FGeneratoreStampeMW.updNomeDatoCalcolato.Execute;
  end;
end;

function TR003FGeneratoreStampeDtM.NomeUtente2Matricola(NomeUtente:String):String;
begin
  Result:='';
  R180SetVariable(selI060,'NOME_UTENTE',NomeUtente);
  selI060.Open;
  Result:=selI060.FieldByName('MATRICOLA').AsString;
end;

procedure TR003FGeneratoreStampeDtM.selT909NomeValidate(Sender: TField);
var P: Integer;
begin
  P:=R003FGeneratoreStampeMW.GetDato(Identificatore(Sender.AsString),True);
  if P >= 0 then
    if not R003FGeneratoreStampeMW.Dati[P].Calcolato then
    begin
      raise Exception.Create(A000MSG_R003_ERR_DATO_ESISTENTE);
    end;
end;

procedure TR003FGeneratoreStampeDtM.Q910AfterPost(DataSet: TDataSet);
var Codice:String;
begin
  Codice:=DataSet.FieldByName('CODICE').AsString;
  RegistraLog.RegistraOperazione;
  SessioneOracle.Commit;
  A000AggiornaFiltroDizionario('GENERATORE DI STAMPE',OldCodice,Codice);
  OldCodice:='';
  Q910.Refresh;
  Q910.SearchRecord('CODICE',Codice,[srFromBeginning]);
  R003FGeneratoreStampe.ConfermaRegistrazione:=False;
  R003FGeneratoreStampe.DButton.OnDataChange(nil,nil);
end;

procedure TR003FGeneratoreStampeDtM.Q910AfterDelete(DataSet: TDataSet);
begin
  RegistraLog.RegistraOperazione;
  SessioneOracle.Commit;
  CaricaImpostazioni;
end;

procedure TR003FGeneratoreStampeDtM.Q910NewRecord(DataSet: TDataSet);
begin
  R003FGeneratoreStampeMW.SelT910NewRecord;
  R003FGeneratoreStampe.cmbOrientamentoPag.ItemIndex:=0;
  R003FGeneratoreStampe.cmbFormatoPag.ItemIndex:=0;
end;

procedure TR003FGeneratoreStampeDtM.Q910AfterOpen(DataSet: TDataSet);
begin
  Q910.FieldByName('CODICE').Required:=True;
end;

procedure TR003FGeneratoreStampeDtM.Q910AfterEdit(DataSet: TDataSet);
begin
  OldCodice:=Q910.FieldByName('CODICE').AsString;
end;

function TR003FGeneratoreStampeDtM.getListCodiciSelezionati:TList<TCodiciTabCollegate>;
var
  i,j: Integer;
  ListaCodici: TListaCodici;
  CodiciTabCollegate: TCodiciTabCollegate;
begin
  Result:=TList<TCodiciTabCollegate>.Create;

  for i:=0 to High(R003FGeneratoreStampeMW.TabelleCollegate) do
  begin
    ListaCodici:=R003FGeneratoreStampe.getCheckListBoxTabellaCollegata(R003FGeneratoreStampeMW.TabelleCollegate[i].M);
    if ListaCodici.chklst <> nil then
      for j:=0 to ListaCodici.chklst.Items.Count - 1 do
        if ListaCodici.chklst.Checked[j] then
        begin
          CodiciTabCollegate.IdSerbatoio:=R003FGeneratoreStampeMW.TabelleCollegate[i].M;
          CodiciTabCollegate.Codice:=Trim(Copy(ListaCodici.chklst.Items[j],1,ListaCodici.Lunghezza));
          Result.add(CodiciTabCollegate);
        end;
  end;
end;

procedure TR003FGeneratoreStampeDtM.Q910BeforePost(DataSet: TDataSet);
var
  lstLabelDati: TList<TLabelDati>;
  lstCodiciTabCollegate: TList<TCodiciTabCollegate>;
  lblDati:TLabelDati;
  i: Integer;
  Impostazioni: String;
begin
  with R003FGeneratoreStampe do
  begin
    Intestazione.HorzScrollBar.Position:=0;
    Intestazione.VertScrollBar.Position:=0;
    Dettaglio.HorzScrollBar.Position:=0;
    Dettaglio.VertScrollBar.Position:=0;

    Q910.FieldByName('ORIENTAMENTO_PAGINA').Clear;
    case cmbOrientamentoPag.ItemIndex of
      1:Q910.FieldByName('ORIENTAMENTO_PAGINA').AsString:='V';
      2:Q910.FieldByName('ORIENTAMENTO_PAGINA').AsString:='O';
    end;
    Q910.FieldByName('FORMATO_PAGINA').Clear;
    if cmbFormatoPag.ItemIndex > 0 then
      Q910.FieldByName('FORMATO_PAGINA').AsString:=IntToStr(cmbFormatoPag.ItemIndex);


    case DataSet.State of
      dsEdit:
        RegistraLog.SettaProprieta('M',R180Query2NomeTabella(DataSet),Copy(Name,1,4),DataSet,True);
      dsInsert:
        RegistraLog.SettaProprieta('I',R180Query2NomeTabella(DataSet),Copy(Name,1,4),DataSet,True);
    end;

    lstLabelDati:=TList<TLabelDati>.Create;
    try
      for i:=Intestazione.ComponentCount - 1 downto 0 do
      begin
        lblDati.Nome:=TLabel(Intestazione.Components[i]).Hint;
        lblDati.Capt:=TLabel(Intestazione.Components[i]).Caption;
        lblDati.Totale:=TLabel(Intestazione.Components[i]).Tag;
        lblDati.Y:=TLabel(Intestazione.Components[i]).Top;
        lblDati.X:=TLabel(Intestazione.Components[i]).Left;
        lblDati.W:=TLabel(Intestazione.Components[i]).Width;
        lblDati.H:=TLabel(Intestazione.Components[i]).Height;
        lblDati.Banda:='I';
        lstLabelDati.Add(lblDati);
      end;

      for i:=Dettaglio.ComponentCount - 1 downto 0 do
      begin
        lblDati.Nome:=TLabel(Dettaglio.Components[i]).Hint;
        lblDati.Capt:=TLabel(Dettaglio.Components[i]).Caption;
        lblDati.Totale:=TLabel(Dettaglio.Components[i]).Tag;
        lblDati.Y:=TLabel(Dettaglio.Components[i]).Top;
        lblDati.X:=TLabel(Dettaglio.Components[i]).Left;
        lblDati.W:=TLabel(Dettaglio.Components[i]).Width;
        lblDati.H:=TLabel(Dettaglio.Components[i]).Height;
        lblDati.Banda:='D';
        lstLabelDati.Add(lblDati);
      end;

      lstCodiciTabCollegate:=getListCodiciSelezionati;

      //Registrazione Opzioni Avanzate
      Impostazioni:='';
      for i:=0 to High(R003FGeneratoreStampeMW.OpzioniAvanzate) do
      begin
        if Impostazioni <> '' then Impostazioni:=Impostazioni + ',';
        Impostazioni:=Impostazioni +
                      R003FGeneratoreStampeMW.OpzioniAvanzate[i].Opzione + '=' +
                      getValoreOpzioneAvanzata(R003FGeneratoreStampeMW.OpzioniAvanzate[i].Opzione);
      end;

      R003FGeneratoreStampeMW.SelT910BeforePost(lstLabelDati,lstCodiciTabCollegate,Impostazioni);
    finally
      FreeAndNil(lstLabelDati);
      FreeAndNil(lstCodiciTabCollegate);
    end;

    ConfermaRegistrazione:=True;
  end;
end;

procedure TR003FGeneratoreStampeDtM.Q910BeforeDelete(DataSet: TDataSet);
var C:String;
begin
  if OldCodice = '' then
    C:=Q910.FieldByName('CODICE').AsString
  else
    C:=OldCodice;
  R003FGeneratoreStampeMW.DeleteTabelle(C);
  if DataSet.State = dsBrowse then
  begin
    A000AggiornaFiltroDizionario('GENERATORE DI STAMPE',DataSet.FieldByName('CODICE').AsString,'');
    RegistraLog.SettaProprieta('C',R180Query2NomeTabella(DataSet),Copy(Name,1,4),DataSet,True);
  end;
end;

procedure TR003FGeneratoreStampeDtM.CaricaImpostazioni;
{Leggo i dati dell'intestazione creando le Label appropriate}
var SB:TScrollBox;
    Valore,Opz:String;
    lstLabels: TList<TLabelDati>;
    lbl: TLabelDati;
    i: Integer;
begin
  R003FGeneratoreStampeMW.modOrdinamento:=False;
  R003FGeneratoreStampeMW.modAreaStampa:=False;
  R003FGeneratoreStampeMW.modFiltro:=False;
  R003FGeneratoreStampeMW.modDettaglioSerbatoio:=False;
  with R003FGeneratoreStampe do
  begin
    DistruggiIntestazione;
    DistruggiDettaglio;
    LSort.Items.Clear;
    R003FGeneratoreStampeMW.ResetOrdinamentoeCumulo;
    Memo1.Lines.Clear;
    Memo2.Lines.Clear;
    chkFiltroEsclusivo.Checked:=False;
    cmbDatoDalAl.ItemIndex:=-1;
    R003FGeneratoreStampeMW.ResetDati;
    cmbOrientamentoPag.ItemIndex:=0;
    if Q910.FieldByName('ORIENTAMENTO_PAGINA').AsString = 'V' then
      cmbOrientamentoPag.ItemIndex:=1
    else if Q910.FieldByName('ORIENTAMENTO_PAGINA').AsString = 'O' then
      cmbOrientamentoPag.ItemIndex:=2;
    cmbFormatoPag.ItemIndex:=StrToIntDef(Q910.FieldByName('FORMATO_PAGINA').AsString,0);

    try
      lstLabels:=R003FGeneratoreStampeMW.LetturaLabelDati;
      for lbl in lstLabels do
      begin
        if lbl.Banda = 'I' then
          SB:=Intestazione
        else
          SB:=Dettaglio;

        AddLabel(lbl.X,lbl.Y,lbl.H,lbl.W,lbl.Totale,lbl.Nome,lbl.Capt,SB,False,False);
      end;
    finally
      FreeAndNil(lstLabels);
    end;

    R003FGeneratoreStampeMW.LetturaOrdinamento;
    for i:=Low(R003FGeneratoreStampeMW.Ordinamento) to High(R003FGeneratoreStampeMW.Ordinamento)  do
    begin
      LSort.Items.Add(R003FGeneratoreStampeMW.Ordinamento[i].Nome);
    end;

    R003FGeneratoreStampeMW.LetturaChiaviCumulo;
    R003FGeneratoreStampeMW.LetturaFiltriSerbatoi;
    //Lettura codici selezionati dei serbatoi
    R003FGeneratoreStampeMW.AperturaCodiciSerbatoi;
    AttivaCodiciSerbatoi;
    (*for i:=0 to High(TabelleCollegate) do
      if TabelleCollegate[i].ListaCodici.chklst <> nil then
        for j:=0 to TabelleCollegate[i].ListaCodici.chklst.Items.Count - 1 do
          TabelleCollegate[i].ListaCodici.chklst.Checked[j]:=False;
    while not Q915.Eof do
    begin
      for i:=0 to High(TabelleCollegate) do
        if (Q915.FieldByName('ID_SERBATOIO').AsInteger = TabelleCollegate[i].M) and
           (TabelleCollegate[i].ListaCodici.chklst <> nil) then
          with TabelleCollegate[i].ListaCodici do
            for j:=0 to chklst.Items.Count - 1 do
              if Q915.FieldByName('DATO').AsString = Trim(Copy(chklst.Items[j],1,Lunghezza)) then
                chklst.Checked[j]:=True;
      Q915.Next;
    end;*)
    //Lettura Impostazioni (Opzioni Avanzate)
    with TStringList.Create do
    try
      CommaText:=Q910.FieldByName('IMPOSTAZIONI').AsString;
      for i:=0 to High(R003FGeneratoreStampeMW.OpzioniAvanzate) do
      begin
        Opz:=R003FGeneratoreStampeMW.OpzioniAvanzate[i].Opzione;
        Valore:=Values[Opz];
        R003FGeneratoreStampe.setValoreOpzioneAvanzata(Opz,Valore);
      end;
    finally
      //caratto 26/05/2014 c'era un memory leak....
      Free;
    end;
    RefreshLstKeyCumuloGlobale;
    cmbSerbatoiChange(nil); 
  end;
end;

procedure TR003FGeneratoreStampeDtM.AttivaCodiciSerbatoi;
var i,j:Integer;
    ListaCodici: TListaCodici;
begin
  with R003FGeneratoreStampeMW do
  begin
    for i:=0 to High(TabelleCollegate) do
    begin
      ListaCodici:=R003FGeneratoreStampe.getCheckListBoxTabellaCollegata(TabelleCollegate[i].M);

      if ListaCodici.chklst <> nil then
        for j:=0 to ListaCodici.chklst.Items.Count - 1 do
          //TabelleCollegate[i].ListaCodici.chklst.Checked[j]:=False;
          ListaCodici.chklst.Checked[j]:=IsCodiceSerbatoioChecked(TabelleCollegate[i].M,Trim(Copy(ListaCodici.chklst.Items[j],1,ListaCodici.Lunghezza)));
    end;
    (*Q915.First;
    while not Q915.Eof do
    begin
      for i:=0 to High(TabelleCollegate) do
        if (Q915.FieldByName('ID_SERBATOIO').AsInteger = TabelleCollegate[i].M) and
           (TabelleCollegate[i].ListaCodici.chklst <> nil) then
        begin
          with TabelleCollegate[i].ListaCodici do
            for j:=0 to chklst.Items.Count - 1 do
              if Q915.FieldByName('DATO').AsString = Trim(Copy(chklst.Items[j],1,Lunghezza)) then
              begin
                chklst.Checked[j]:=True;
                Break;
              end;
          Break;
        end;
      Q915.Next;
    end;*)
  end;
end;

procedure TR003FGeneratoreStampeDtM.Q910AfterInsert(DataSet: TDataSet);
var i,j:Integer;
  ListaCodici: TListaCodici;
begin
  with R003FGeneratoreStampe do
  begin
    DistruggiIntestazione;
    DistruggiDettaglio;
    LSort.Items.Clear;
    SetLength(R003FGeneratoreStampeMW.Ordinamento,0);
    Memo1.Lines.Clear;
    Memo2.Lines.Clear;
    chkFiltroEsclusivo.Checked:=False;
    cmbDatoDalAl.ItemIndex:=-1;
    lstKeyCumulo.Items.Clear;
    for i:=0 to High(R003FGeneratoreStampeMW.Serbatoi) do
    begin
      R003FGeneratoreStampeMW.Serbatoi[i].Esclusivo:=False;
      R003FGeneratoreStampeMW.Serbatoi[i].FiltroTxt:='';
      R003FGeneratoreStampeMW.Serbatoi[i].DatoDalAl:='';
      SetLength(R003FGeneratoreStampeMW.Serbatoi[i].KeyCumulo,0);
    end;
    for i:=1 to High(R003FGeneratoreStampeMW.Dati) do
    begin
      R003FGeneratoreStampeMW.Dati[i].Fmt:='';
      R003FGeneratoreStampeMW.Dati[i].CDCPerc:=False;
      R003FGeneratoreStampeMW.Dati[i].ConvValuta:=False;
      R003FGeneratoreStampeMW.Dati[i].Ripetuto:=False;
    end;
    cmbOrientamentoPag.ItemIndex:=0;
    //Inizializzazione Check List
    for i:=0 to High(R003FGeneratoreStampeMW.TabelleCollegate) do
    begin
      ListaCodici:=getCheckListBoxTabellaCollegata(R003FGeneratoreStampeMW.TabelleCollegate[i].M);
      if ListaCodici.chklst <> nil then
        for j:=0 to ListaCodici.chklst.Items.Count - 1 do
          ListaCodici.chklst.Checked[j]:=False;
    end;
    //Inizializzazione controlli legati alle Opzioni Avanzate
    for i:=0 to High(R003FGeneratoreStampeMW.OpzioniAvanzate) do
      setValoreOpzioneAvanzata(R003FGeneratoreStampeMW.OpzioniAvanzate[i].Opzione,'');
    dchkTotRiepilogoClick(nil);
  end;
  OldCodice:='';
end;

procedure TR003FGeneratoreStampeDtM.Q910AfterCancel(DataSet: TDataSet);
begin
  OldCodice:='';
  CaricaImpostazioni;
  R003FGeneratoreStampe.ConfermaRegistrazione:=False;
  R003FGeneratoreStampe.DButton.OnDataChange(nil,nil);
end;

procedure TR003FGeneratoreStampeDtM.DropT920(Num:Byte);
var S:String;
begin
  with CD920 do
  begin
    S:=ParametriOperatore;
    if Num > 0 then
      S:=S + IntToStr(Num);
    SQL.Clear;
    if Parametri.VersioneOracle >= 10 then
      SQL.Add('DROP TABLE T920_' + S + ' PURGE')
    else
      SQL.Add('DROP TABLE T920_' + S);
    try
      Execute;
    except
    end;
  end;
end;

function TR003FGeneratoreStampeDtM.ControllaSemaforo:Boolean;
begin
  Result:=False;
  try
    with selT919 do
    begin
      Close;
      SetVariable('OPERATORE',ParametriOperatore);
      Open;
      Result:=RecordCount > 0;
    end;
  except
  end;
end;

procedure TR003FGeneratoreStampeDtM.BloccaSemaforo;
begin
  if not selT919.Active then
    exit;
  //Ripulisco il semaforo dai blocchi precenti
  while not selT919.Eof do
    selT919.Delete;
  selT919.Append;
  selT919.FieldByName('OPERATORE').AsString:=ParametriOperatore;
  selT919.FieldByName('DATA').AsDateTime:=Now;
  try selT919.Post; except end;
end;

procedure TR003FGeneratoreStampeDtM.CreateT920;
var i,P:Integer;
    S,C,V,SSort,SSortOld,Join,DescSort,Colonne:String;
    ODS:TOracleDataSet;
begin
  //Creazione T920_<Operatore>
  R003FGeneratoreStampeMW.Ins920.DeleteVariables;
  with CD920,R003FGeneratoreStampeMW do
  begin
    SQL.Clear;
    //SQL.Add('CREATE TABLE T920_' + Parametri.Operatore + ' (');
    SQL.Add('CREATE TABLE T920_' + ParametriOperatore + ' (');
    C:='';
    V:='';
    for i:=0 to High(DatiStampa) do
    begin
      if Dati[DatiStampa[i].N].M <> 0 then Continue;
      if Dati[DatiStampa[i].N].Calcolato then Continue;
      if C <> '' then
        C:=C + ',';
      C:=C + DatiStampa[i].D;
      if V <> '' then
        V:=V + ',';
      V:=V + ':' + DatiStampa[i].D;
      S:=DatiStampa[i].D;
      if i > 0 then S:=',' + S;
      case DatiStampa[i].F of
        0,4:begin
          S:=S + ' VARCHAR2(' + IntToStr(DatiStampa[i].W) + ')';
          Ins920.DeclareVariable(DatiStampa[i].D,otString);
          end;
        1:begin
            S:=S + ' NUMBER';
            Ins920.DeclareVariable(DatiStampa[i].D,otString);
            end;
        2:begin
          S:=S + ' NUMBER(12)';
          Ins920.DeclareVariable(DatiStampa[i].D,otInteger);
          end;
        3:begin
          S:=S + ' DATE';
          Ins920.DeclareVariable(DatiStampa[i].D,otDate);
          end;
      end;
      SQL.Add(S);
    end;
    SQL.Add(') TABLESPACE ' + Parametri.TSAusiliario);
    SQL.Add('  PCTFREE 5 PCTUSED 80 /*STORAGE (PCTINCREASE 0 INITIAL 128K NEXT 512K)*/ NOPARALLEL');
    Execute;
  end;
  with R003FGeneratoreStampeMW.Ins920 do
  begin
    SQL.Clear;
    //SQL.Add('INSERT INTO T920_' + Parametri.Operatore);
    SQL.Add('INSERT INTO T920_' + ParametriOperatore);
    SQL.Add('(' + C + ')');
    SQL.Add('VALUES');
    SQL.Add('(' + V + ')');
  end;
  //Creazione del ClientDataSet basato sulla Join fra le tabelle
  ODS:=TOracleDataSet.Create(nil);
  with ODS do
  begin
    SQL.Clear;
    Session:=SessioneOracle;
    Join:='';
    Colonne:='T0.*';
    //SQL.Add('SELECT :COLONNE FROM T920_' + Parametri.Operatore + ' T0');
    SQL.Add('SELECT :COLONNE FROM T920_' + ParametriOperatore + ' T0');
    for i:=0 to High(R003FGeneratoreStampeMW.TabelleCollegate) do
      if R003FGeneratoreStampeMW.TabelleCollegate[i].Esiste then
      begin
        //SQL.Add(',T920_' + Parametri.Operatore + IntToStr(R003FGeneratoreStampe.TabelleCollegate[i].M) + ' T' + IntToStr(R003FGeneratoreStampe.TabelleCollegate[i].M));
        SQL.Add(',T920_' + ParametriOperatore + IntToStr(R003FGeneratoreStampeMW.TabelleCollegate[i].M) + ' T' + IntToStr(R003FGeneratoreStampeMW.TabelleCollegate[i].M));
        if Join <> '' then
          Join:=Join + ' AND ';
        Join:=Join + R003FGeneratoreStampeMW.TabelleCollegate[i].Join;
        Colonne:=Colonne + ',T' + IntToStr(R003FGeneratoreStampeMW.TabelleCollegate[i].M) + '.*';
      end;
    if Join <> '' then
      SQL.Add('WHERE ' + Join);
    //Dati calcolati
    with R003FGeneratoreStampeMW do
      for i:=0 to High(DatiStampa) do
        if Dati[DatiStampa[i].N].Calcolato then
          Colonne:=Colonne + ',' + VarToStr(selT909.Lookup('NOME',Dati[DatiStampa[i].N].D,'ESPRESSIONE')) + ' ' + Identificatore(Dati[DatiStampa[i].N].D);
    SQL[0]:=StringReplace(SQL[0],':COLONNE',Colonne,[]);
    if Pos(':DAL',UpperCase(SQL.Text)) > 0 then
      DeclareVariable('DAL',otDate);
    if Pos(':AL',UpperCase(SQL.Text)) > 0 then
      DeclareVariable('AL',otDate);
    Open;
  end;
  with TDataSetProvider.Create(nil) do
  try
    DataSet:=ODS;
    cds920.FieldDefs.Clear;
    cds920.IndexDefs.Clear;
    cds920.IndexName:='';
    cds920.Data:=Data;
    cds920.LogChanges:=False;
  finally
    Free;
  end;
  ODS.DeleteVariables;
  ODS.Free;
  //Definizione dell'indice del ClientDataSet
  //Includo sempre PROGRESSIVO e T430DATADECORRENZA per gestire la stampa giornaliera
  SSort:='';
  DescSort:='';
  for i:=0 to High(R003FGeneratoreStampeMW.Ordinamento) do
  begin
    if SSort <> '' then
      SSort:=SSort + ';';
    SSort:=SSort + Identificatore(R003FGeneratoreStampeMW.Ordinamento[i].Nome);
    if R003FGeneratoreStampeMW.Ordinamento[i].Discendente then
    begin
      if DescSort <> '' then
        DescSort:=DescSort + ';';
      DescSort:=DescSort + Identificatore(R003FGeneratoreStampeMW.Ordinamento[i].Nome);
    end;
  end;
  if R003FGeneratoreStampe.LSort.Items.IndexOf('PROGRESSIVO') = -1 then
  begin
    if SSort <> '' then
      SSort:=SSort + ';';
    SSort:=SSort + 'PROGRESSIVO';
  end;
  if R003FGeneratoreStampe.LSort.Items.IndexOf('T430DATADECORRENZA') = -1 then
  begin
    if SSort <> '' then
      SSort:=SSort + ';';
    SSort:=SSort + 'T430DATADECORRENZA';
  end;
  if (SSort = '') or (SSort = 'PROGRESSIVO;T430DATADECORRENZA') then
  begin
    P:=Pos('ORDER BY',C700SelAnagrafe.SQL.Text);
    if P > 0 then
    begin
      SSortOld:=SSort;
      SSort:=TogliSuffisso(Copy(C700SelAnagrafe.SQL.Text,P + 8,512));
      if SSort <> '' then
      begin
        if SSortOld <> '' then
          SSort:=SSort + ';' + SSortOld;
      end
      else
        SSort:=SSortOld;
    end;
  end;
  cds920.IndexDefs.Clear;
  cds920.IndexDefs.Add('Indice',(SSort),[]);
  cds920.IndexDefs[0].DescFields:=DescSort;
  cds920.IndexName:='Indice';
end;

procedure TR003FGeneratoreStampeDtM.CreateT920_Assenze(OQIns:TOracleQuery);
{Causali di assenza}
var i:Integer;
    CreateTable,InsertList,InsertVal,D:String;
begin
  with R003FGeneratoreStampe do
  begin
    CreateTable:='';
    InsertList:='';
    InsertVal:='';
    CD920.DeleteVariables;
    CD920.SQL.Clear;
    //CD920.SQL.Add('CREATE TABLE T920_' + Parametri.Operatore + '3 (');
    CD920.SQL.Add('CREATE TABLE T920_' + ParametriOperatore + '3 (');
    OQIns.DeleteVariables;
    OQIns.SQL.Clear;
    //OQIns.SQL.Add('INSERT INTO T920_' + Parametri.Operatore + '3');
    OQIns.SQL.Add('INSERT INTO T920_' + ParametriOperatore + '3');
    AddDatoTabCollegata(OQIns,CreateTable,InsertList,InsertVal,'PROGRESSIVO3','NUMBER(8)',otInteger);
    AddDatoTabCollegata(OQIns,CreateTable,InsertList,InsertVal,'T920_KEY3','VARCHAR2(20)',otString);
    AddDatoTabCollegata(OQIns,CreateTable,InsertList,InsertVal,'T920_KEYTOT3','VARCHAR2(20)',otString);
    for i:=0 to High(R003FGeneratoreStampeMW.DatiStampa) do
      if (R003FGeneratoreStampeMW.Dati[R003FGeneratoreStampeMW.DatiStampa[i].N].M = 3) and (not R003FGeneratoreStampeMW.Dati[R003FGeneratoreStampeMW.DatiStampa[i].N].Calcolato) then
      begin
        D:=UpperCase(R003FGeneratoreStampeMW.DatiStampa[i].D);
        if D = 'CODICEASSENZE' then AddDatoTabCollegata(OQIns,CreateTable,InsertList,InsertVal,D,'VARCHAR2(8)',otString) else
        if D = 'DESCRIZIONEASSENZE' then AddDatoTabCollegata(OQIns,CreateTable,InsertList,InsertVal,D,'VARCHAR2(43)',otString) else
        if D = 'DATARIEPILOGOASS' then AddDatoTabCollegata(OQIns,CreateTable,InsertList,InsertVal,D,'DATE',otDate) else
        if D = 'INIZIOPERIODOCUMULO' then AddDatoTabCollegata(OQIns,CreateTable,InsertList,InsertVal,D,'DATE',otDate) else
        if D = 'FINEPERIODOCUMULO' then AddDatoTabCollegata(OQIns,CreateTable,InsertList,InsertVal,D,'DATE',otDate) else
        if D = 'MISURAASSENZE' then AddDatoTabCollegata(OQIns,CreateTable,InsertList,InsertVal,D,'VARCHAR2(1)',otString) else
        if D = 'VALENZAGIORNALIERA' then AddDatoTabCollegata(OQIns,CreateTable,InsertList,InsertVal,D,'NUMBER',otString) else
        if D = 'ASSENZEDELMESE' then AddDatoTabCollegata(OQIns,CreateTable,InsertList,InsertVal,D,'NUMBER',otString) else
        if D = 'ASSENZEDAQUALMIN' then AddDatoTabCollegata(OQIns,CreateTable,InsertList,InsertVal,D,'NUMBER',otString) else
        if D = 'COMPASSANNOPREC' then AddDatoTabCollegata(OQIns,CreateTable,InsertList,InsertVal,D,'NUMBER',otString) else
        if D = 'COMPASSANNOCORR' then AddDatoTabCollegata(OQIns,CreateTable,InsertList,InsertVal,D,'NUMBER',otString) else
        if D = 'COMPASSTOTALI' then AddDatoTabCollegata(OQIns,CreateTable,InsertList,InsertVal,D,'NUMBER',otString) else
        if D = 'ASSFRUITEANNOPREC' then AddDatoTabCollegata(OQIns,CreateTable,InsertList,InsertVal,D,'NUMBER',otString) else
        if D = 'ASSFRUITEANNOCORR' then AddDatoTabCollegata(OQIns,CreateTable,InsertList,InsertVal,D,'NUMBER',otString) else
        if D = 'ASSENZEFRUITE' then AddDatoTabCollegata(OQIns,CreateTable,InsertList,InsertVal,D,'NUMBER',otString) else
        if D = 'ASSRESIDUEANNOPREC' then AddDatoTabCollegata(OQIns,CreateTable,InsertList,InsertVal,D,'NUMBER',otString) else
        if D = 'ASSRESIDUEANNOCORR' then AddDatoTabCollegata(OQIns,CreateTable,InsertList,InsertVal,D,'NUMBER',otString) else
        if D = 'ASSENZERESIDUE' then AddDatoTabCollegata(OQIns,CreateTable,InsertList,InsertVal,D,'NUMBER',otString) else
        if D = 'RESAORARIA' then AddDatoTabCollegata(OQIns,CreateTable,InsertList,InsertVal,D,'NUMBER',otString) else
        if D = 'COMPETENZEPARZIALI' then AddDatoTabCollegata(OQIns,CreateTable,InsertList,InsertVal,D,'NUMBER',otString) else
        if D = 'RESIDUOPARZIALE' then AddDatoTabCollegata(OQIns,CreateTable,InsertList,InsertVal,D,'NUMBER',otString) else
        if D = 'COMPETENZEDELPERIODO' then AddDatoTabCollegata(OQIns,CreateTable,InsertList,InsertVal,D,'NUMBER',otString) else
        if D = 'ASSENZEDELMESEINGG' then AddDatoTabCollegata(OQIns,CreateTable,InsertList,InsertVal,D,'NUMBER',otString) else
        if D = 'COMPINGG' then AddDatoTabCollegata(OQIns,CreateTable,InsertList,InsertVal,D,'NUMBER',otString) else
        if D = 'COMPASSANNOPRECINGG' then AddDatoTabCollegata(OQIns,CreateTable,InsertList,InsertVal,D,'NUMBER',otString) else
        if D = 'COMPASSANNOCORRINGG' then AddDatoTabCollegata(OQIns,CreateTable,InsertList,InsertVal,D,'NUMBER',otString) else
        if D = 'FRUITOINGG' then AddDatoTabCollegata(OQIns,CreateTable,InsertList,InsertVal,D,'NUMBER',otString) else
        if D = 'RESIDINGG' then AddDatoTabCollegata(OQIns,CreateTable,InsertList,InsertVal,D,'NUMBER',otString) else
        if D = 'COMPETENZEPARZIALIINGG' then AddDatoTabCollegata(OQIns,CreateTable,InsertList,InsertVal,D,'NUMBER',otString) else
        if D = 'COMPETENZEDELPERIODOINGG' then AddDatoTabCollegata(OQIns,CreateTable,InsertList,InsertVal,D,'NUMBER',otString) else
        if D = 'DATAFAMILIARE' then AddDatoTabCollegata(OQIns,CreateTable,InsertList,InsertVal,D,'DATE',otDate) else
        // TORINO_CSI - commessa 2015/142 SVILUPPO#7.ini
        if D = 'COMPASSINDIVID' then AddDatoTabCollegata(OQIns,CreateTable,InsertList,InsertVal,D,'NUMBER',otString) else
        if D = 'FRUITOINGGINDIVID' then AddDatoTabCollegata(OQIns,CreateTable,InsertList,InsertVal,D,'NUMBER',otString) else
        if D = 'RESIDINGGINDIVID' then AddDatoTabCollegata(OQIns,CreateTable,InsertList,InsertVal,D,'NUMBER',otString) else
        // TORINO_CSI - commessa 2015/142 SVILUPPO#7.fine
        // csi.ini
        if D = 'VARIAZFRUIZMESIINTERI' then AddDatoTabCollegata(OQIns,CreateTable,InsertList,InsertVal,D,'NUMBER',otString) else
        if D = 'VARIAZFRUIZMESIINTERIINDIVID' then AddDatoTabCollegata(OQIns,CreateTable,InsertList,InsertVal,D,'NUMBER',otString) else
        if D = 'VARIAZMAXINDIVID' then AddDatoTabCollegata(OQIns,CreateTable,InsertList,InsertVal,D,'NUMBER',otString);
          // csi.fine
        // csi.fine
      end;
    CD920.SQL.Add(CreateTable);
    CD920.SQL.Add(')TABLESPACE ' + Parametri.TSAusiliario);
    CD920.SQL.Add('PCTFREE 5 PCTUSED 80 /*STORAGE (PCTINCREASE 0 INITIAL 128K NEXT 512K)*/ NOPARALLEL');
    CD920.Execute;
    OQIns.SQL.Add(Format('(%s)',[InsertList]));
    OQIns.SQL.Add('VALUES');
    OQIns.SQL.Add(Format('(%s)',[InsertVal]));
  end;
end;

procedure TR003FGeneratoreStampeDtM.CreateT920_xx(Ins920_xx:TOracleQuery; Tabella:String);
var i:Integer;
    CreateTable,InsertList,InsertVal,D,NumTab:String;
    Ins920x:TOracleQuery;
begin
  Ins920x:=Ins920_xx;
  NumTab:=Copy(Ins920x.Name,Pos('_',Ins920x.Name) + 1,3);
  with R003FGeneratoreStampeMW do
  begin
    selCols.Close;
    selCols.SetVariable('TABELLA',Tabella);
    selCols.Open;
    CreateTable:='';
    InsertList:='';
    InsertVal:='';
    CD920.DeleteVariables;
    CD920.SQL.Clear;
    //CD920.SQL.Add('CREATE TABLE T920_' + Parametri.Operatore + NumTab + ' (');
    CD920.SQL.Add('CREATE TABLE T920_' + ParametriOperatore + NumTab + ' (');
    Ins920x.DeleteVariables;
    Ins920x.SQL.Clear;
    //Ins920x.SQL.Add('INSERT INTO T920_' + Parametri.Operatore + NumTab);
    Ins920x.SQL.Add('INSERT INTO T920_' + ParametriOperatore + NumTab);
    AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,'PROGRESSIVO' + NumTab,'NUMBER(8)',otInteger);
    AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,'T920_KEY' + NumTab,'VARCHAR2(1000)',otString);
    AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,'T920_KEYTOT' + NumTab,'VARCHAR2(1000)',otString);
    for i:=0 to High(DatiStampa) do
      if (Dati[DatiStampa[i].N].M = StrToInt(NumTab)) and (not Dati[DatiStampa[i].N].Calcolato) and (UpperCase(DatiStampa[i].D) <> 'PROGRESSIVO' + NumTab) then
      begin
        D:=UpperCase(DatiStampa[i].D);
        if DatiStampa[i].F in [1,2] then
          AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,D,'NUMBER(20)',otInteger)
        else if DatiStampa[i].F = 3 then
          AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,D,'DATE',otDate)
        else if selCols.SearchRecord('COLUMN_NAME',D,[srFromBeginning]) then
          AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,D,'VARCHAR2(' + R003FGeneratoreStampeMW.selCols.FieldByName('DATA_LENGTH').AsString + ')',otString);
      end;
    CD920.SQL.Add(CreateTable);
    CD920.SQL.Add(')TABLESPACE ' + Parametri.TSAusiliario);
    CD920.SQL.Add('PCTFREE 5 PCTUSED 80 /*STORAGE (PCTINCREASE 0 INITIAL 128K NEXT 256K)*/ NOPARALLEL');
    CD920.Execute;
    Ins920x.SQL.Add(Format('(%s)',[InsertList]));
    Ins920x.SQL.Add('VALUES');
    Ins920x.SQL.Add(Format('(%s)',[InsertVal]));
  end;
end;

procedure TR003FGeneratoreStampeDtM.AddDatoTabCollegata(OQIns:TOracleQuery; var CreateTable,InsertList,InsertVal:String; Colonna,Tipo:String; TipoVar:Integer);
begin
  if InsertList <> '' then
  begin
    CreateTable:=CreateTable + ',';
    InsertList:=InsertList + ',';
    InsertVal:=InsertVal + ',';
  end;
  CreateTable:=CreateTable + Format('%s %s',[Colonna,Tipo]);
  InsertList:=InsertList + Colonna;
  InsertVal:=InsertVal + ':' + Colonna;
  OQIns.DeclareVariable(Colonna,TipoVar);
  //Gestione CDC Percentualizzati: aggiungo il campo 'nascosto' del codice CDC per filtrare correttamente le T920 quando si crea il client dataset usato per la stampa
  if (R003FGeneratoreStampeMW.CDCPercentualizzati {PS}or R003FGeneratoreStampeMW.EsistonoDatiDaProporzionare{PS}) and
     (Copy(UpperCase(Colonna),1,11) = 'PROGRESSIVO') and
     (StrToIntDef(Copy(Colonna,12,Length(Colonna)),0) > 0) then
  begin
    CreateTable:=CreateTable + ',' + 'CDCPERC_CODICE VARCHAR2(80)';
    InsertList:=InsertList + ',CDCPERC_CODICE';
    InsertVal:=InsertVal + ',:CDCPERC_CODICE';
    OQIns.DeclareVariable('CDCPERC_CODICE',otString);
    if R003FGeneratoreStampeMW.PeriodiStorici then
    begin
      CreateTable:=CreateTable + ',' + 'CDCPERC_DECOR VARCHAR2(10)';
      InsertList:=InsertList + ',CDCPERC_DECOR';
      InsertVal:=InsertVal + ',:CDCPERC_DECOR';
      OQIns.DeclareVariable('CDCPERC_DECOR',otString);
    end;
  end;
end;

function TR003FGeneratoreStampeDtM.TogliSuffisso(S:String):String;
{Toglie il suffisso 'T030.' o 'V430.' dalla stringa di ordinamento di C700SelAnagrafe}
var i,j,P:Integer;
    L:TStringList;
    S1:String;
begin
  S:=StringReplace(S,'T030.','',[rfReplaceAll,rfIgnoreCase]);
  S:=StringReplace(S,'V430.','',[rfReplaceAll,rfIgnoreCase]);
  S:=StringReplace(S,';',',',[rfReplaceAll,rfIgnoreCase]);
  Result:='';
  L:=TStringList.Create;
  try
    L.CommaText:=S;
    for i:=0 to L.Count - 1 do
      begin
      S1:=L[i];
      P:=Pos('DESC',UpperCase(S1));
      if P > 0 then
        Delete(S1,P,4);
      if UpperCase(S1) = 'PROGRESSIVO' then
        Continue;
      with R003FGeneratoreStampeMW do
        for j:=0 to High(DatiStampa) do
        begin
          if UpperCase(DatiStampa[j].D) = UpperCase(S1) then
          begin
            if Result <> '' then
              Result:=Result + ';';
            Result:=Result + L[i];
            Break;
          end;
        end;
      end;
  finally
    L.Free;
  end;
end;

function TR003FGeneratoreStampeDtM.FiltraDipendentiInServizio:Boolean;
begin
  Result:=True;
  (*with R003FGeneratoreStampe do
    if rbnDipInServizioSI.Checked or rbnDipInServizioNO.Checked then
      if CheckDipendenteInServizio(DaData,AData) then
        Result:=rbnDipInServizioSI.Checked
      else
        Result:=rbnDipInServizioNO.Checked*)
  if Q910.FieldByName('FILTRO_INSERVIZIO').AsString <> 'T' then
    if CheckDipendenteInServizio(R003FGeneratoreStampeMW.DaData,R003FGeneratoreStampeMW.AData) then
      Result:=Q910.FieldByName('FILTRO_INSERVIZIO').AsString = '1'
    else
      Result:=Q910.FieldByName('FILTRO_INSERVIZIO').AsString = '0';
end;

function TR003FGeneratoreStampeDtM.CheckDipendenteInServizio(Data1,Data2:TDateTime):Boolean;
{Restituisce True se il dipendente risulta in servizio tra Data1 e Data2}
begin
  Result:=False;
  with selT430 do
  begin
    First;
    while not Eof do
    begin
      if (FieldByName('INIZIO').AsDateTime <= Data2) and (FieldByName('FINE').AsDateTime >= Data1) then
      begin
        Result:=True;
        Break;
      end;
      Next;
    end;
  end;
end;

procedure TR003FGeneratoreStampeDtM.GetSerbatoioStd(R:Byte; selSerbatoio:TOracleDataSet);
var Key,KeyTot:String;
begin
  with selSerbatoio do
  begin
    Open;
    First;
    while not Eof do
    begin
      //Se si gestiscono i periodi storici, considero i dati del periodo storico corrente
      GetDettaglioPeriodicoStd(R,selSerbatoio);
      if not PeriodoStoricoValido(R) then
      begin
        Next;
        Continue;
      end;
      //Costruzione della chiave di cumulo e di totalizzazione
      GetKeyStd(Key,KeyTot,R,selSerbatoio);
      PutValoreStd(Key,KeyTot,R,selSerbatoio);
      Next;
    end;
  end;
end;

procedure TR003FGeneratoreStampeDtM.GetDettaglioPeriodicoStd(R:Byte; selSerbatoio:TOracleDataSet);
begin
  with R003FGeneratoreStampe do
    if (GetIdxTabelleCollegate(R) >= 0) and (R003FGeneratoreStampeMW.TabelleCollegate[GetIdxTabelleCollegate(R)].Data[1] <> '') then
    begin
      DipendenteCorrente.DettaglioPeriodicoDal:=selSerbatoio.FieldByName(R003FGeneratoreStampeMW.TabelleCollegate[GetIdxTabelleCollegate(R)].Data[1]).AsDateTime;
      DipendenteCorrente.DettaglioPeriodicoAl:=selSerbatoio.FieldByName(R003FGeneratoreStampeMW.TabelleCollegate[GetIdxTabelleCollegate(R)].Data[2]).AsDateTime;
    end;
end;

function TR003FGeneratoreStampeDtM.PeriodoStoricoValido(R:Byte):Boolean;
var x:Integer;
    Dal,Al:TDateTime;
begin
  Result:=True;
  with R003FGeneratoreStampe do
  begin
    if not R003FGeneratoreStampeMW.PeriodiStorici then
      exit;
    x:=GetIdxTabelleCollegate(R);
    if x = -1 then
      exit;
    if (R003FGeneratoreStampeMW.TabelleCollegate[x].Data[1] = '') or (R003FGeneratoreStampeMW.TabelleCollegate[x].DettaglioPeriodico = '') then
      exit;
    if R003FGeneratoreStampeMW.CDCPercentualizzati or (R003FGeneratoreStampeMW.TabelleCollegate[x].DettaglioPeriodico = 'G') then
    begin
      Dal:=DipendenteCorrente.Dal;
      Al:=DipendenteCorrente.Al;
    end
    else
    begin
      //Arrotondo il periodo storico a inizio/fine mese: fine mese viene portato al mese precedente se la DecorrenzaFine(=DipendenteCorrente.Al) non è un fine mese
      Dal:=R180InizioMese(DipendenteCorrente.Dal);
      if DipendenteCorrente.Al < R180FineMese(DipendenteCorrente.Al) then
        Al:=R180InizioMese(DipendenteCorrente.Al) - 1
      else
        Al:=DipendenteCorrente.Al;
    end;
    if R003FGeneratoreStampeMW.TabelleCollegate[x].DettaglioPeriodico = 'M' then
    begin
      DipendenteCorrente.DettaglioPeriodicoDal:=R180InizioMese(DipendenteCorrente.DettaglioPeriodicoDal);
      DipendenteCorrente.DettaglioPeriodicoAl:=R180FineMese(DipendenteCorrente.DettaglioPeriodicoAl);
    end
    else if R003FGeneratoreStampeMW.TabelleCollegate[x].DettaglioPeriodico = 'A' then
    begin
      DipendenteCorrente.DettaglioPeriodicoDal:=EncodeDate(R180Anno(DipendenteCorrente.DettaglioPeriodicoDal),1,1);
      DipendenteCorrente.DettaglioPeriodicoAl:=EncodeDate(R180Anno(DipendenteCorrente.DettaglioPeriodicoAl),12,31);
    end;
    Result:=(DipendenteCorrente.DettaglioPeriodicoAl >= Dal) and (DipendenteCorrente.DettaglioPeriodicoDal <= Al);
  end;
end;

procedure TR003FGeneratoreStampeDtM.GetKeyStd(var Key,KeyTot:String; R:Byte; selSerbatoio:TOracleDataSet);
var kc:Integer;
    S,Dato:String;
begin
  Key:='';
  KeyTot:='';
  with R003FGeneratoreStampeMW.Serbatoi[R003FGeneratoreStampe.GetIdxSerbatoi(R)] do
    for kc:=0 to High(KeyCumulo) do
    begin
      Dato:=UpperCase(Identificatore(KeyCumulo[kc].Nome));
      if selSerbatoio.FindField(Dato) = nil then
        Continue;
      if selSerbatoio.FieldByName(Dato).DataType in [ftDate,ftDateTime] then
      begin
        if selSerbatoio.FieldByName(Dato).AsDateTime = Trunc(selSerbatoio.FieldByName(Dato).AsDateTime) then
          S:=FormatDateTime('yyyymmdd',selSerbatoio.FieldByName(Dato).AsDateTime)
        else
          S:=FormatDateTime('yyyymmddhhhhnnss',selSerbatoio.FieldByName(Dato).AsDateTime);
      end
      else
        S:=selSerbatoio.FieldByName(Dato).AsString;
      Key:=Key + S;
      if KeyCumulo[kc].Totale then
        KeyTot:=KeyTot + S;
    end;
end;

procedure TR003FGeneratoreStampeDtM.PutValoreStd(Key,KeyTot:String; R:Byte; selSerbatoio:TOracleDataSet);
var i:Integer;
    Dato:String;
begin
  with R003FGeneratoreStampeMW do
    for i:=0 to High(DatiStampa) do
      if Dati[DatiStampa[i].N].R = R then
      begin
        if DatiStampa[i].V = nil then
          DatiStampa[i].V:=TList.Create;
        Dato:=UpperCase(DatiStampa[i].D);
        try
          PutValore(i,DatiStampa[i].V,selSerbatoio.FieldByName(Dato).AsString,Key,KeyTot,DatiStampa[i].F,True);
        except
          PutValore(i,DatiStampa[i].V,'',Key,KeyTot,DatiStampa[i].F,True);
        end;
      end;
end;

procedure TR003FGeneratoreStampeDtM.PutValoreListaDataSet(Key,KeyTot:String; R:Byte; selSerbatoi:array of TOracleDataSet);
var i,ds:Integer;
    Dato:String;
begin
  with R003FGeneratoreStampeMW do
    for i:=0 to High(DatiStampa) do
    try
      if R003FGeneratoreStampeMW.Dati[DatiStampa[i].N].R = R then
      begin
        if DatiStampa[i].V = nil then
          DatiStampa[i].V:=TList.Create;
        Dato:=UpperCase(DatiStampa[i].D);
        ds:=0;
        while ds <= High(selSerbatoi) do
        begin
          if selSerbatoi[ds].FindField(Dato) = nil then
            inc(ds)
          else
            Break;
        end;
        if ds <= High(selSerbatoi) then
        try
          PutValore(i,DatiStampa[i].V,selSerbatoi[ds].FieldByName(Dato).AsString,Key,KeyTot,DatiStampa[i].F,True);
        except
          PutValore(i,DatiStampa[i].V,'',Key,KeyTot,DatiStampa[i].F,True);
        end
        else
          PutValore(i,DatiStampa[i].V,'',Key,KeyTot,DatiStampa[i].F,True);
      end;
    except
    end;
end;

procedure TR003FGeneratoreStampeDtM.CreaSQLAnagrafico(Campi:String);
begin
  with R003FGeneratoreStampeMW.DatiAnagrafici do
  begin
    DeleteVariables;
    SQL.Clear;
    SQL.Add('SELECT /*+ ORDERED */' + Campi);
    SQL.Add('FROM T030_ANAGRAFICO,V430_STORICO,T480_COMUNI T480');
    SQL.Add('WHERE PROGRESSIVO = T430PROGRESSIVO');
    SQL.Add('AND PROGRESSIVO = :PROGRESSIVO');
    SQL.Add('AND COMUNENAS = T480.CODICE(+)');
    SQL.Add('AND :DATA BETWEEN T430DATADECORRENZA AND T430DATAFINE');
    DeclareVariable('PROGRESSIVO',otInteger);
    DeclareVariable('DATA',otDate);
  end;
end;

procedure TR003FGeneratoreStampeDtM.GetAnagrafico;
{Lettura dati con R = 1}
begin
  with R003FGeneratoreStampeMW.DatiAnagrafici do
  begin
    Close;
    SetVariable('PROGRESSIVO',C700Progressivo);
    SetVariable('DATA',C700SelAnagrafe.FieldByName('T430DATADECORRENZA').AsDateTime);
    Open;
  end;
end;

procedure TR003FGeneratoreStampeDtM.DatiStoriciT920;
var i,P:Integer;
    S:String;
begin
  S:='';
  with R003FGeneratoreStampe do
  begin
    if not R003FGeneratoreStampeMW.PeriodiStorici then
      exit;
    for i:=0 to High(R003FGeneratoreStampeMW.Ordinamento) do
      if R003FGeneratoreStampeMW. Ordinamento[i].Rottura then
      begin
        P:=R003FGeneratoreStampeMW.GetDato(R003FGeneratoreStampeMW.Ordinamento[i].Nome,False);
        if P = -1 then
          Continue;
        if (R003FGeneratoreStampeMW.Dati[P].X = 0) and
           ((Copy(R003FGeneratoreStampeMW.Dati[P].D,1,4) = 'T430') or
           (Copy(R003FGeneratoreStampeMW.Dati[P].D,1,4) = 'P430') or
           (UpperCase(R003FGeneratoreStampeMW.Dati[P].D) = 'CDCPERC_CODICE') or
           (UpperCase(R003FGeneratoreStampeMW.Dati[P].D) = 'CDCPERC_PERCENTUALE') or     // daniloc. 21.04.2010
           (UpperCase(R003FGeneratoreStampeMW.Dati[P].D) = 'CDCPERC_DESCRIZIONE')) then
        begin
          if S <> '' then
            S:=S + '||';
          S:=S + R003FGeneratoreStampeMW.Dati[P].D;
        end;
      end;
  end;
  //Alberto 23/02/2005: vengono cancellati i record con datafine antecedente a quello finale, che contiene tutto il periodo di validità dei dati indicati
  if S <> '' then
  begin
    //if Pos('CDCPERC_CODICE',UpperCase(S)) > 0 then
    //  S:=StringReplace(S,'CDCPERC_CODICE','CDCPERC_CODICE||T430DATADECORRENZA',[rfIgnoreCase]);
    updT920DataDecorrenza.SetVariable('TABELLA','T920_' + ParametriOperatore);
    updT920DataDecorrenza.SetVariable('TABELLASTR','T920_' + ParametriOperatore);
    updT920DataDecorrenza.SetVariable('CAMPI',S);
    if (R003FGeneratoreStampeMW.PeriodiStorici and R003FGeneratoreStampeMW.CDCPercentualizzati) {PS}or R003FGeneratoreStampeMW.EsistonoDatiDaProporzionare{PS} then
      updT920DataDecorrenza.SetVariable('CDCPERC_CODICE','CDCPERC_CODICE')
    else
      updT920DataDecorrenza.SetVariable('CDCPERC_CODICE','NULL');
    updT920DataDecorrenza.Execute;
  end;
end;

procedure TR003FGeneratoreStampeDtM.CaricaT920Join;
var i,j,TM,MainQuery:Integer;
    DatiCollegati,DatiCollegatiScritti,DipEscluso,DipStampato,EsistonoSerbatoi:Boolean;
    RegistraTabellaStampa:Boolean;
    Colonne,Distinct:String;
  procedure ScriviQuery(Q:TOracleDataSet);
  var x:Integer;
  begin
    with R003FGeneratoreStampe do
      for x:=0 to Q.FieldCount - 1 do
        cds920.FieldByName(Q.Fields[x].FieldName).AsString:=Q.Fields[x].AsString;
  end;
begin
  //R003FGeneratoreStampe.PeriodiStorici:=R003FGeneratoreStampe.dchkPeriodoStorico.Checked;
  MainQuery:=0;
  EsistonoSerbatoi:=False;
  //Inizializzazione delle query
  for i:=0 to High(R003FGeneratoreStampeMW.Serbatoi) do
    if R003FGeneratoreStampeMW.Serbatoi[i].ODS <> nil then
    begin
      try
        R003FGeneratoreStampeMW.Serbatoi[i].ODS.DeleteVariables;
        R003FGeneratoreStampeMW.Serbatoi[i].ODS.Free;
      except
      end;
      R003FGeneratoreStampeMW.Serbatoi[i].ODS:=nil;
    end;
  //Costruzione delle query
  for i:=0 to High(R003FGeneratoreStampeMW.Serbatoi) do
    with R003FGeneratoreStampeMW.Serbatoi[i] do
      if M = 0 then
      begin
        //Tabella principale (Anagrafico)
        MainQuery:=i;
        Colonne:='T.*';
        with R003FGeneratoreStampe do
          for j:=0 to High(R003FGeneratoreStampeMW.DatiStampa) do
            if (R003FGeneratoreStampeMW.Dati[R003FGeneratoreStampeMW.DatiStampa[j].N].X = R003FGeneratoreStampeMW.Serbatoi[i].X) and R003FGeneratoreStampeMW.Dati[R003FGeneratoreStampeMW.DatiStampa[j].N].Calcolato then
              Colonne:=Colonne + ',' + VarToStr(R003FGeneratoreStampeMW.selT909.Lookup('NOME',R003FGeneratoreStampeMW.Dati[R003FGeneratoreStampeMW.DatiStampa[j].N].D,'ESPRESSIONE')) + ' ' + Identificatore(R003FGeneratoreStampeMW.Dati[R003FGeneratoreStampeMW.DatiStampa[j].N].D);
        ODS:=TOracleDataSet.Create(nil);
        //ODS.SQL.Add('SELECT ' + Colonne + ' FROM T920_' + Parametri.Operatore + ' T');
        ODS.SQL.Add('SELECT ' +
                    //IfThen(R003FGeneratoreStampe.PeriodiStorici and R003FGeneratoreStampe.CDCPercentualizzati,'DISTINCT ','') +
                    IfThen(R003FGeneratoreStampeMW.PeriodiStorici,'DISTINCT ','') +
                    Colonne + ' FROM T920_' + ParametriOperatore + ' T');
        if Filtro <> '' then
          ODS.SQL.Add('WHERE ' + Filtro);
        if Pos(':DAL',UpperCase(ODS.SQL.Text)) > 0 then
        begin
          ODS.DeclareVariable('DAL',otDate);
          ODS.SetVariable('DAL', R003FGeneratoreStampe.DataI);
        end;
        if Pos(':AL',UpperCase(ODS.SQL.Text)) > 0 then
        begin
          ODS.DeclareVariable('AL',otDate);
          ODS.SetVariable('AL', R003FGeneratoreStampe.DataF);
        end;
        ODS.Session:=SessioneOracle;
        ODS.ReadBuffer:=1000;
        ODS.Open;
      end
      else
      begin
        TM:=R003FGeneratoreStampe.Molteplice(M);
        if TM >= 0 then
        begin
          //Tabelle collegate
          EsistonoSerbatoi:=True;
          Colonne:='T.*';
          with R003FGeneratoreStampe do
            for j:=0 to High(R003FGeneratoreStampeMW.DatiStampa) do
              if (R003FGeneratoreStampeMW.Dati[R003FGeneratoreStampeMW.DatiStampa[j].N].X = R003FGeneratoreStampeMW.Serbatoi[i].X) and R003FGeneratoreStampeMW.Dati[R003FGeneratoreStampeMW.DatiStampa[j].N].Calcolato then
                Colonne:=Colonne + ',' + VarToStr(R003FGeneratoreStampeMW.selT909.Lookup('NOME',R003FGeneratoreStampeMW.Dati[R003FGeneratoreStampeMW.DatiStampa[j].N].D,'ESPRESSIONE')) + ' ' + Identificatore(R003FGeneratoreStampeMW.Dati[R003FGeneratoreStampeMW.DatiStampa[j].N].D);
          ODS:=TOracleDataSet.Create(nil);
          Distinct:='';
          (*
          if R003FGeneratoreStampe.PeriodiStorici then
            if R003FGeneratoreStampe.CDCPercentualizzati then
              Distinct:='DISTINCT '
            else if R003FGeneratoreStampe.TabelleCollegate[TM].DettaglioPeriodico <> 'G' then
              Distinct:='DISTINCT ';
          *)
          if R003FGeneratoreStampeMW.PeriodiStorici and (R003FGeneratoreStampeMW.TabelleCollegate[TM].DettaglioPeriodico <> 'G') then
            Distinct:='DISTINCT ';
          ODS.SQL.Add('SELECT ' +
                      //IfThen(R003FGeneratoreStampe.PeriodiStorici and R003FGeneratoreStampe.CDCPercentualizzati,'DISTINCT ','') +
                      //IfThen(R003FGeneratoreStampe.PeriodiStorici,'DISTINCT ','') +
                      Distinct +
                      Colonne + ' FROM T920_' + ParametriOperatore + IntToStr(M) + ' T');
          if Filtro <> '' then
            ODS.SQL.Add('WHERE ' + Filtro);
          ODS.SQL.Add('ORDER BY ' + R003FGeneratoreStampeMW.TabelleCollegate[TM].Progressivo);
          if Pos(':DAL',UpperCase(ODS.SQL.Text)) > 0 then
          begin
            ODS.DeclareVariable('DAL',otDate);
            ODS.SetVariable('DAL', R003FGeneratoreStampe.DataI);
          end;
          if Pos(':AL',UpperCase(ODS.SQL.Text)) > 0 then
          begin
            ODS.DeclareVariable('AL',otDate);
            ODS.SetVariable('AL', R003FGeneratoreStampe.DataF);
          end;
          ODS.Session:=SessioneOracle;
          ODS.ReadBuffer:=2000;
          ODS.Tag:=TM;
          ODS.OnFilterRecord:=TabelleCollegateFilterRecord;
          ODS.Open;
        end
      end;
  //Costruzione della tabella Oracle opzionale
  RegistraTabellaStampa:=False;
  cds920.AfterPost:=nil;
  if Trim(R003FGeneratoreStampe.TabellaStampa) <> '' then
    RegistraTabellaStampa:=CreaTabellaStampa;
  //Scorrimento della query principale
  with R003FGeneratoreStampe do
  begin
    ProgressBar1.Position:=0;
    ProgressBar1.Max:=R003FGeneratoreStampeMW.Serbatoi[MainQuery].ODS.RecordCount;
    while not R003FGeneratoreStampeMW.Serbatoi[MainQuery].ODS.Eof do
    begin
      ProgressBar1.StepBy(1);
      Application.ProcessMessages;
      DipendenteCorrente.Progressivo:=R003FGeneratoreStampeMW.Serbatoi[MainQuery].ODS.FieldByName('PROGRESSIVO').AsInteger;
      DipendenteCorrente.Dal:=R003FGeneratoreStampeMW.Serbatoi[MainQuery].ODS.FieldByName('T430DATADECORRENZA').AsDateTime;
      DipendenteCorrente.Al:=R003FGeneratoreStampeMW.Serbatoi[MainQuery].ODS.FieldByName('T430DATAFINE').AsDateTime;
      if R003FGeneratoreStampeMW.CDCPercentualizzati {PS}or R003FGeneratoreStampeMW.EsistonoDatiDaProporzionare{PS} then
        DipendenteCorrente.CDCPercCodice:=R003FGeneratoreStampeMW.Serbatoi[MainQuery].ODS.FieldByName('CDCPERC_CODICE').AsString;
      DipEscluso:=False;
      DipStampato:=False;
      //Scorrimento delle query secondarie
      for i:=0 to High(R003FGeneratoreStampeMW.Serbatoi) do
        if (i <> MainQuery) and (R003FGeneratoreStampeMW.Serbatoi[i].ODS <> nil) then
        begin
          R003FGeneratoreStampeMW.Serbatoi[i].ODS.Filtered:=False;
          R003FGeneratoreStampeMW.Serbatoi[i].ODS.Filtered:=True;
          R003FGeneratoreStampeMW.Serbatoi[i].ODS.First;
          R003FGeneratoreStampeMW.Serbatoi[i].ODSValido:=not R003FGeneratoreStampeMW.Serbatoi[i].ODS.Eof;
          if (not R003FGeneratoreStampeMW.Serbatoi[i].ODSValido) and (R003FGeneratoreStampeMW.Serbatoi[i].Esclusivo) then
          begin
            DipEscluso:=True;
            Break;
          end;
        end;
      if not DipEscluso then
      begin
        DatiCollegatiScritti:=False;
        repeat
          DatiCollegati:=False;
          cds920.Append;
          ScriviQuery(R003FGeneratoreStampeMW.Serbatoi[MainQuery].ODS);
          for i:=0 to High(R003FGeneratoreStampeMW.Serbatoi) do
            if (i <> MainQuery) and (R003FGeneratoreStampeMW.Serbatoi[i].ODS <> nil) then
              if R003FGeneratoreStampeMW.Serbatoi[i].ODSValido then
              begin
                ScriviQuery(R003FGeneratoreStampeMW.Serbatoi[i].ODS);
                DatiCollegatiScritti:=True;
                R003FGeneratoreStampeMW.Serbatoi[i].ODS.Next;
                if not R003FGeneratoreStampeMW.Serbatoi[i].ODS.Eof then
                  DatiCollegati:=True
                else
                  R003FGeneratoreStampeMW.Serbatoi[i].ODSValido:=False;
              end;
          if DatiCollegatiScritti or (not dchkFiltriEsclusivi.Checked) or (not EsistonoSerbatoi) then
          begin
            DipStampato:=True;
            if RegistraTabellaStampa and NoStampa then
            begin
              cds920AfterPost(cds920);
              cds920.Cancel;
            end
            else
              cds920.Post;
          end
          else
            cds920.Cancel;
        until not DatiCollegati;
        if DipStampato and (SelectLog <> '') then
        try
          selTestoLog.Close;
          selTestoLog.SetVariable('PROGRESSIVO',DipendenteCorrente.Progressivo);
          selTestoLog.SetVariable('AL', R003FGeneratoreStampe.DataF);
          selTestoLog.SetVariable('RIGA',SelectLog);
          selTestoLog.Open;
          if Trim(selTestoLog.Fields[0].AsString) <> '' then
            TestoLog:=TestoLog + IfThen(TestoLog = '','',#13#10) + selTestoLog.Fields[0].AsString;
          selTestoLog.Close;
        except
        end;
      end;
      R003FGeneratoreStampeMW.Serbatoi[MainQuery].ODS.Next;
    end;
    ProgressBar1.Position:=0;
  end;
  //Rilascio delle query
  for i:=0 to High(R003FGeneratoreStampeMW.Serbatoi) do
    if R003FGeneratoreStampeMW.Serbatoi[i].ODS <> nil then
    begin
      R003FGeneratoreStampeMW.Serbatoi[i].ODS.DeleteVariables;
      R003FGeneratoreStampeMW.Serbatoi[i].ODS.Free;
      R003FGeneratoreStampeMW.Serbatoi[i].ODS:=nil;
    end;
  //Salvataggio della cache di salvataggio su tabella Oracle
  if RegistraTabellaStampa then
  begin
    SessioneOracle.ApplyUpdates([selT920Stampa],False);
    SessioneOracle.Commit;
    selT920Stampa.CancelUpdates;
    selT920Stampa.Refresh;
  end;
end;

procedure TR003FGeneratoreStampeDtM.TabelleCollegateFilterRecord(DataSet: TDataSet;
  var Accept: Boolean);
var Dal,Al,D1,D2:TDateTime;
begin
  {Filtro delle tabelle collegate basato sul Progressivo e, se è attiva la gestione
   dei peridi storici, sul campo Data specificato}
  with R003FGeneratoreStampe do
  begin
    Accept:=DataSet.FieldByName(R003FGeneratoreStampeMW.TabelleCollegate[DataSet.Tag].Progressivo).AsInteger = DipendenteCorrente.Progressivo;
    if R003FGeneratoreStampeMW.CDCPercentualizzati then
    begin
      Accept:=Accept and (DataSet.FieldByName('CDCPERC_CODICE').AsString = DipendenteCorrente.CDCPercCodice);
      if R003FGeneratoreStampeMW.PeriodiStorici then
        Accept:=Accept and (DataSet.FieldByName('CDCPERC_DECOR').AsString = DateToStr(DipendenteCorrente.Dal));
    end
    {PS}else if R003FGeneratoreStampeMW.EsistonoDatiDaProporzionare then
      Accept:=Accept and (DataSet.FieldByName('CDCPERC_DECOR').AsString = DateToStr(DipendenteCorrente.Dal)){PS}
    else if R003FGeneratoreStampeMW.PeriodiStorici and (R003FGeneratoreStampeMW.TabelleCollegate[DataSet.Tag].Data[1] <> '') then
    begin
      Dal:=DipendenteCorrente.Dal;
      Al:=DipendenteCorrente.Al;
      D1:=DataSet.FieldByName(R003FGeneratoreStampeMW.TabelleCollegate[DataSet.Tag].Data[1]).AsDateTime;
      D2:=DataSet.FieldByName(R003FGeneratoreStampeMW.TabelleCollegate[DataSet.Tag].Data[2]).AsDateTime;
      //Se la tabella contiene dati mensili, considero Dal e Al 'arrotondati' al mese
      if R003FGeneratoreStampeMW.TabelleCollegate[DataSet.Tag].DettaglioPeriodico = 'M' then
      begin
        Dal:=R180InizioMese(Dal);
        //Non considero il mese di fine decorrenza, a meno che non coincida con la fine del mese stesso
        if Al <> R180FineMese(Al) then
          Al:=R180InizioMese(Al) - 1;
        D1:=R180InizioMese(D1);
        D2:=R180FineMese(D2);
      end
      else if R003FGeneratoreStampeMW.TabelleCollegate[DataSet.Tag].DettaglioPeriodico = 'A' then
      begin
        Dal:=R180InizioMese(Dal);
        //Non considero il mese di fine decorrenza, a meno che non coincida con la fine del mese stesso
        if Al <> R180FineMese(Al) then
          Al:=R180InizioMese(Al) - 1;
        D1:=EncodeDate(R180Anno(D1),1,1);
        D2:=EncodeDate(R180Anno(D2),12,31);
      end;
      Accept:=Accept and (D2 >= Dal) and (D1 <= Al);
    end;
  end;
end;

procedure TR003FGeneratoreStampeDtM.CreaIndiceTabella(NTab:String);
var Drop,Create:Boolean;
    NomeTab:String;
    CampiChiave:TStringList;
    I:integer;
begin
  Drop:=False;
  Create:=False;
  NomeTab:='T920' + R003FGeneratoreStampe.TabellaStampa;
  selChiave.Close;
  selChiave.SetVariable('TNAME',NomeTab);
  selChiave.SetVariable('INAME',NomeTab + '_UI');
  selChiave.Open;
  CampiChiave:=TStringList.Create;
  CampiChiave.CommaText:=UpperCase(Q910.FieldByName('TABELLA_GENERATA_KEY').AsString);
  if Not Q910.FieldByName('TABELLA_GENERATA_KEY').isNull and (selChiave.RecordCount > 0) then
  begin
    for i:=0 to CampiChiave.Count - 1 do
      if VarToStr(selChiave.Lookup('COLUMN_NAME',CampiChiave[i],'COLUMN_NAME')) = '' then
      begin
        Drop:=True;
        Create:=True;
      end;
    if CampiChiave.Count <> selChiave.RecordCount then
    begin
      Drop:=True;
      Create:=True;
    end;
  end;
  FreeAndNil(CampiChiave);

  if Q910.FieldByName('TABELLA_GENERATA_KEY').isNull and (selChiave.RecordCount > 0) then
    Drop:=True;
  if (Not Q910.FieldByName('TABELLA_GENERATA_KEY').isNull) and (selChiave.RecordCount = 0) then
    Create:=True;

  if Drop then
  begin
    R003FGeneratoreStampeMW.OperSql.SQL.Clear;
    R003FGeneratoreStampeMW.OperSql.SQL.Add('DROP INDEX ' + NomeTab + '_UI');
    R003FGeneratoreStampeMW.OperSql.Close;
    R003FGeneratoreStampeMW.OperSql.Execute;
  end;
  if Create then
  begin
    R003FGeneratoreStampeMW.OperSql.SQL.Clear;
    R003FGeneratoreStampeMW.OperSql.SQL.Add(Format('create unique index %s on %s (%s) tablespace %s',[NomeTab + '_UI', NomeTab, Q910.FieldByName('TABELLA_GENERATA_KEY').AsString,IfThen(Parametri.TSAusiliario = '',Parametri.TSIndici,Parametri.TSAusiliario)]));
    R003FGeneratoreStampeMW.OperSql.Close;
    try
      R003FGeneratoreStampeMW.OperSql.Execute;
    except
      on E:EOracleError do
        R180MessageBox(Format('Impossibile creare la chiave (%s)!' + #13#10 + E.Message,[Q910.FieldByName('TABELLA_GENERATA_KEY').AsString]),ESCLAMA);
    end;
  end;
end;

function TR003FGeneratoreStampeDtM.VerificaCreazioneTabellaGenerata(NomeTabella:String):Boolean;
var i:Integer;
    Campo:String;
begin
  //Verifico se è richiesta esplicitamente la ricreazione della tabella
  Result:=Q910.FieldByName('TABELLA_GENERATA_DROP').AsString = 'S';
  Campo:='';
  //CreaIndiceTabella(NomeTabella);
  if Result then
    exit;
  //Verifico se la tabella esiste
  R003FGeneratoreStampeMW.selCols.SetVariable('TABELLA',NomeTabella);
  R003FGeneratoreStampeMW.selCols.Close;
  R003FGeneratoreStampeMW.selCols.Open;
  Result:=R003FGeneratoreStampeMW.selCols.RecordCount = 0;
  if Result then
    exit;
  //Verifico se le colonne corrispondono con quelle chieste in stampa
  for i:=0 to High(R003FGeneratoreStampeMW.DatiStampa) do
    if not R003FGeneratoreStampeMW.selCols.SearchRecord('COLUMN_NAME',R003FGeneratoreStampeMW.DatiStampa[i].D,[srFromBeginning,srIgnoreCase]) then
    begin
      Result:=True;
      Campo:=R003FGeneratoreStampeMW.DatiStampa[i].D;
      Break;
    end;
  if Result then
  begin
    R003FGeneratoreStampeMW.OperSQL.SQL.Text:='select count(*) from ' + NomeTabella;
    R003FGeneratoreStampeMW.OperSQL.Execute;
    if R003FGeneratoreStampeMW.OperSQL.FieldAsInteger(0) > 0 then
    begin
      if R003FGeneratoreStampe.TipoModulo = 'CS' then
      begin
        if MessageDlg(Format('Tabella %s non compatibile con la nuova struttura: campo ''%s'' non esistente.' + #13#10 +
                             'Sono presenti %d records. E''necessario ricreare la tabella perdendo tutti i dati adesso contenuti.' + #13#10 +
                             'Si vuole confermare la ricreazione della tabella?',
                             [NomeTabella,Campo,R003FGeneratoreStampeMW.OperSQL.FieldAsInteger(0)]), mtConfirmation,[mbYes, mbNo],0) = mrNo then
          Abort;
      end
      else
        raise Exception.Create(Format('Tabella %s non compatibile con la nuova struttura: campo %s non esistente.',[NomeTabella,Campo]));
    end;
  end;
end;

function TR003FGeneratoreStampeDtM.CreaTabellaStampa:Boolean;
{Creazione tabella Oracle per salvare il contenuto di cds920}
var S,Nome,Filtro,SQLWhere:String;
    i:Integer;
begin
  Result:=True;
  Nome:='T920' + R003FGeneratoreStampe.TabellaStampa;
  if R003FGeneratoreStampe.CreaTabellaGenerata then
    with TOracleQuery.Create(nil) do
    try
      Session:=SessioneOracle;
      if Parametri.VersioneOracle >= 10 then
        SQL.Add('DROP TABLE ' + Nome + ' PURGE')
      else
        SQL.Add('DROP TABLE ' + Nome);
      try
        Execute;
      except
      end;
      SQL.Clear;
      SQL.Add('CREATE TABLE ' + Nome + ' (');
      for i:=0 to cds920.FieldDefs.Count - 1 do
      begin
        S:='';
        case cds920.FieldDefs[i].DataType of
          ftString:
            S:=' VARCHAR2(' + IntToStr(cds920.FieldDefs[i].Size) + ')';
          ftDate,ftDateTime,ftTime:
            S:=' DATE';
          ftInteger,ftFloat:
            S:=' NUMBER';
        end;
        if S  = '' then
        begin
          Result:=False;
          Abort;
        end;
        if i < cds920.FieldDefs.Count - 1 then
          S:=S + ',';
        S:=cds920.FieldDefs[i].Name + S;
        SQL.Add(S);
      end;
      SQL.Add(') TABLESPACE ' + Parametri.TSAusiliario + ' PCTFREE 5 PCTUSED 80 /*STORAGE (PCTINCREASE 0 INITIAL 32K NEXT 256K)*/ NOPARALLEL');
      try
        Execute;
      except
        Result:=False;
      end;
      //Creazione dell'indice unico se specifiata la chiave di modifica
      if Result and (Q910.FieldByName('TABELLA_GENERATA_KEY').AsString <> '') then
      begin
        SQL.Text:=Format('create unique index %s on %s (%s) tablespace %s',[Nome + '_UI', Nome, Q910.FieldByName('TABELLA_GENERATA_KEY').AsString,IfThen(Parametri.TSAusiliario = '',Parametri.TSIndici,Parametri.TSAusiliario)]);
        try
          Execute;
        except
          on E:Exception do
            if R003FGeneratoreStampe.TipoModulo = 'CS' then
               ShowMessage(Format('Impossibile creare la chiave (%s)!' + #13#10 + E.Message,[Q910.FieldByName('TABELLA_GENERATA_KEY').AsString]));
        end;
      end;
    finally
      Free;
    end
  else
  begin
    if Trim(Q910.FieldByName('TABELLA_GENERATA_DELETE').AsString) <> '' then
    begin
      Filtro:=Trim(Q910.FieldByName('TABELLA_GENERATA_DELETE').AsString);
      Filtro:=StringReplace(Filtro,':DAL','''' + R003FGeneratoreStampe.frmInputPeriodo.edtInizio.Text + '''',[rfIgnoreCase,rfReplaceAll]);
      Filtro:=StringReplace(Filtro,':AL','''' + R003FGeneratoreStampe.frmInputPeriodo.edtFine.Text + '''',[rfIgnoreCase,rfReplaceAll]);
      Filtro:=StringReplace(Filtro,'PROGRESSIVO IN :T920','PROGRESSIVO IN (SELECT PROGRESSIVO FROM T920_' + ParametriOperatore + ')',[rfIgnoreCase,rfReplaceAll]);
      R003FGeneratoreStampeMW.OperSQL.SQL.Text:=Format('delete from %s where %s',[Nome,Filtro]);
      try
        R003FGeneratoreStampeMW.OperSQL.Execute;
      except
        on E:Exception do
          if R003FGeneratoreStampe.TipoModulo = 'CS' then
            ShowMessage('Cancellazione non avvenuta:' + #13#10 + E.Message);
      end;
    end;
    CreaIndiceTabella(Nome);
  end;
  cds920.AfterPost:=nil;
  if Result then
  begin
    cds920.AfterPost:=cds920AfterPost;
    selT920Stampa.CloseAll;
    selT920Stampa.SQL.Clear;
    selT920Stampa.SQL.Add('SELECT /*+ ordered */ T920.*,ROWID FROM ' + Nome + ' T920 WHERE PROGRESSIVO = 0');
    selT920Stampa.Open;
  end;
  updT920Stampa.DeleteVariables;
  updT920Stampa.Tag:=0;
  if Q910.FieldByName('TABELLA_GENERATA_KEY').AsString <> '' then
  begin
    updT920Stampa.SQL.Clear;
    with TStringList.Create do
    try
      CommaText:=UpperCase(Q910.FieldByName('TABELLA_GENERATA_KEY').AsString);
      SQLWhere:='';
      for i:=0 to Count - 1 do
        if selT920Stampa.FindField(Strings[i]) <> nil then
        begin
          if R180In(UpperCase(Strings[i]),['PROGRESSIVO','DATACONTEGGIO']) then
            SQLWhere:=SQLWhere + IfThen(SQLWhere = '','where ',' and ') + Format('%s = :%s',[Strings[i],Strings[i]])
          else if selT920Stampa.FieldByName(Strings[i]) is TStringField then
            SQLWhere:=SQLWhere + IfThen(SQLWhere = '','where ',' and ') + Format('nvl(%s,''null'') = nvl(:%s,''null'')',[Strings[i],Strings[i]])
          else if selT920Stampa.FieldByName(Strings[i]) is TDateTimeField then
            SQLWhere:=SQLWhere + IfThen(SQLWhere = '','where ',' and ') + Format('nvl(%s,''01/01/1900'') = nvl(:%s,''01/01/1900'')',[Strings[i],Strings[i]])
          else
            SQLWhere:=SQLWhere + IfThen(SQLWhere = '','where ',' and ') + Format('nvl(%s,-99999) = nvl(:%s,-99999)',[Strings[i],Strings[i]]);
          if selT920Stampa.FindField(Strings[i]) is TDateTimeField then
            updT920Stampa.DeclareVariable(Strings[i],otDate)
          else
            updT920Stampa.DeclareVariable(Strings[i],otString);
        end;
      updT920Stampa.SQL.Add('update ' + Nome + ' set');
      for i:=0 to selT920Stampa.FieldCount - 1  do
        if IndexOf(UpperCase(selT920Stampa.Fields[i].FieldName)) = -1 then
        begin
          updT920Stampa.SQL.Add(IfThen(updT920Stampa.SQl.Count > 1,',','') + Format('%s = :%s',[selT920Stampa.Fields[i].FieldName,selT920Stampa.Fields[i].FieldName]));
          if selT920Stampa.Fields[i] is TDateTimeField then
            updT920Stampa.DeclareVariable(selT920Stampa.Fields[i].FieldName,otDate)
          else
            updT920Stampa.DeclareVariable(selT920Stampa.Fields[i].FieldName,otString);
        end;
      updT920Stampa.SQL.Add(SQLWhere);
    finally
      Free;
    end;
  end;
end;

procedure TR003FGeneratoreStampeDtM.PutValore(DatiStampaID:Integer; L:TList; Valore,Key,KeyTot:String; Tipo:Byte; Valido:Boolean);
var App:TValore;
    Intervallo,i:Integer;
    D1,D2:TDateTime;
begin
  if DatiStampaID < 0 then
    exit;
  if R003FGeneratoreStampeMW.CDCPercentualizzati and
     R003FGeneratoreStampe.DatiDaPercentualizzare and
     (Valore <> '') and
     (Tipo in [1,2]) and
     (R003FGeneratoreStampeMW.Dati[R003FGeneratoreStampeMW.DatiStampa[DatiStampaID].N].CDCPerc) then
  try
    Valore:=FloatToStr(StrToFloat(Valore) * (C700SelAnagrafe.FieldByName('T433Percentuale').AsFloat / 100));
  except
  end;
  try
    if R003FGeneratoreStampeMW.PeriodiStorici and
       R003FGeneratoreStampe.DatiDaPercentualizzare and
       (Valore <> '') and
       (Tipo in [1,2]) and
       (R003FGeneratoreStampeMW.Dati[R003FGeneratoreStampeMW.DatiStampa[DatiStampaID].N].CDCPerc) then
    begin
      //D1:=R180InizioMese(DipendenteCorrente.DettaglioPeriodicoDal);
      //D2:=R180FineMese(DipendenteCorrente.DettaglioPeriodicoAl);
      D1:=DipendenteCorrente.DettaglioPeriodicoDal;
      D2:=DipendenteCorrente.DettaglioPeriodicoAl;
      Intervallo:=Trunc(Min(D2(*Min(D2,AData)*),C700SelAnagrafe.FieldByName('T430DATAFINE').AsDateTime) -
                        Max(D1(*Max(D1,DaData)*),C700SelAnagrafe.FieldByName('T430DATADECORRENZA').AsDateTime)) + 1;
      Valore:=FloatToStr(StrToFloat(Valore) * Max(0,Intervallo) / (Max(0,D2 - D1) + 1));
    end;
  except
  end;
  if Tipo = 4 then
  begin
    CumulaValore(L,Valore,Key,KeyTot,Valido);
    exit;
  end;
  App:=nil;
  if not Valido then
    if Tipo in [1,2] then
      Valore:='0'
    else
    begin
      Tipo:=0;
      Valore:=R003FGeneratoreStampe.ValoreNullo;
    end;
  for i:=0 to L.Count - 1 do
    if TValore(L[i]).Key = Key then
    begin
      App:=TValore(L[i]);
      case Tipo of
        0,3:begin
              TValore(L[i]).Val:=Valore;
              if (Tipo = 0) and (Valore <> '') then
                inc(App.NumOrd);
            end;
        1,2:try
              TValore(L[i]).Val:=FloatToStr(StrToFloat(TValore(L[i]).Val) + StrToFloat(Valore));
              if StrToFloat(Valore) <> 0 then
                inc(App.NumOrd);
            except
              if Valore <> '' then
                TValore(L[i]).Val:=Valore;
            end;
      end;
      Break;
    end;
  if App = nil then
  begin
    App:=TValore.Create;
    L.Add(App);
    App.Key:=Key;
    App.KeyTot:=KeyTot;
    App.Val:=Valore;
    App.NumOrd:=0;
    if (Tipo in [1,2]) and (Valore <> '') and (StrToFloat(Valore) <> 0) then
      App.NumOrd:=1;
    if (Tipo = 0) and (Valore <> '') then
      App.NumOrd:=1;
  end;
end;

procedure TR003FGeneratoreStampeDtM.CumulaValore(L:TList; Valore,Key,KeyTot:String; Valido:Boolean);
{Usato per cumulare i dati RiepilogoOreCausalizzate e RiepilogoOreAssenza}
var App:TValore;
    i,x,y,Px,Py:Integer;
    Lx,Ly:TStringList;
begin
  App:=nil;
  if not Valido then
    Valore:='';
  for i:=0 to L.Count - 1 do
    if TValore(L[i]).Key = Key then
    begin
      App:=TValore(L[i]);
      Lx:=TStringList.Create;
      Ly:=TStringLIst.Create;
      Lx.CommaText:=TValore(L[i]).Val;
      Ly.CommaText:=Valore;
      for y:=0 to Ly.Count - 1 do
      begin
        Py:=Pos(':',Ly[y]) - 1;
        for x:=0 to Lx.Count - 1 do
        begin
          Px:=Pos(':',Lx[x]) - 1;
          if Copy(Lx[x],1,Px) = Copy(Ly[y],1,Py) then
          begin
            Lx[x]:=Copy(Lx[x],1,Px) + ':' + R180MinutiOre(R180OreMinutiExt(Copy(Lx[x],Px + 2,6)) + R180OreMinutiExt(Copy(Ly[y],Py + 2,6)));
            Ly[y]:='';
            Break;
          end;
        end;
      end;
      for y:=0 to Ly.Count - 1 do
        if Ly[y] <> '' then
          Lx.Add(Ly[y]);
      Lx.Sort;
      App.Val:='';
      for x:=0 to Lx.Count - 1 do
      begin
        if App.Val <> '' then
          App.Val:=App.Val + ' ';
        App.Val:=App.Val + Lx[x];
      end;
      Lx.Free;
      Ly.Free;
      Break;
    end;
  if App = nil then
  begin
    App:=TValore.Create;
    L.Add(App);
    App.Key:=Key;
    App.KeyTot:=KeyTot;
    App.Val:=Valore;
  end;
end;

procedure TR003FGeneratoreStampeDtM.cds920AfterPost(DataSet: TDataSet);
{Copia del contenuto di cds920 sulla tabella Oracle di salvataggio della stampa}
var i:Integer;
begin
  //Gestisco la chiave per modificare i records già
  if Q910.FieldByName('TABELLA_GENERATA_KEY').AsString <> '' then
    with updT920Stampa do
    begin
      for i:=0 to cds920.FieldCount - 1 do
        SetVariable(cds920.Fields[i].FieldName,cds920.Fields[i].Value);
      Execute;
      if RowsProcessed > 0 then
      begin
        Tag:=Tag + 1;
        if Tag >= selT920Stampa.ReadBuffer then
        begin
          SessioneOracle.Commit;
          selT920Stampa.Refresh;
          Tag:=0;
        end;
        exit;
      end;
    end;
  selT920Stampa.Append;
  selT920Stampa.ClearFields; //Alberto 03/09/2014: in rari casi se non si inizializzano i campi dà access violation
  for i:=0 to cds920.FieldCount - 1 do
    selT920Stampa.FieldByName(cds920.Fields[i].FieldName).Value:=cds920.Fields[i].Value;
  selT920Stampa.Post;
  if selT920Stampa.RecordCount >= selT920Stampa.ReadBuffer then
  begin
    SessioneOracle.ApplyUpdates([selT920Stampa],True);
    selT920Stampa.CancelUpdates;
    selT920Stampa.Refresh;
    updT920Stampa.Tag:=0;
  end
  else if Q910.FieldByName('TABELLA_GENERATA_KEY').AsString <> '' then
  begin
    SessioneOracle.ApplyUpdates([selT920Stampa],False);
    selT920Stampa.CancelUpdates;
  end;
end;

function TR003FGeneratoreStampeDtM.GetTestoAggiuntivo(Nome:String):String;
var ODS:TOracleDataSet;
begin
  Result:='';
  ODS:=TOracleDataSet.Create(nil);
  try
    ODS.Session:=SessioneOracle;
    //Nome:='A077' + Q910.FieldByName('CODICE').AsString + '_' + Sezione;
    selT002Riga.Close;
    selT002Riga.SetVariable('NOME',Nome);
    selT002Riga.SetVariable('APPLICAZIONE',Parametri.Applicazione);
    selT002Riga.Open;
    while not selT002Riga.Eof do
    begin
      ODS.SQL.Add(selT002Riga.FieldByName('RIGA').AsString);
      selT002Riga.Next;
    end;
    (*
      ODS.SQL.Text:=
        'select ''--Legenda--'' colonna from dual union' + CRLF +
        'select distinct rpad(T380.TURNO,5,'' '')||'': ''||T350.DESCRIZIONE from (' + CRLF +
        'select PROGRESSIVO,DATA,TURNO1 TURNO' + CRLF +
        'from T380_PIANIFREPERIB T380' + CRLF +
        'where T380.DATA between :DAL and :AL' + CRLF +
        'and TURNO1 is not null' + CRLF +
        'union' + CRLF +
        'select PROGRESSIVO,DATA,TURNO2' + CRLF +
        'from T380_PIANIFREPERIB T380' + CRLF +
        'where T380.DATA between :DAL and :AL' + CRLF +
        'and TURNO2 is not null' + CRLF +
        'union' + CRLF +
        'select PROGRESSIVO,DATA,TURNO3' + CRLF +
        'from T380_PIANIFREPERIB T380' + CRLF +
        'where T380.DATA between :DAL and :AL' + CRLF +
        'and TURNO3 is not null) T380, T350_REGREPERIB T350,' + CRLF +
        ':C700SelAnagrafe' + CRLF +
        'and T380.PROGRESSIVO = T030.PROGRESSIVO' + CRLF +
        'and T350.CODICE = T380.TURNO' + CRLF +
        '';//'order by 1';
    *)
    if Pos(':C700SELANAGRAFE',UpperCase(ODS.SQL.Text)) > 0 then
    begin
      ODS.DeclareVariable('C700SelAnagrafe',otSubst);
      C700MergeSelAnagrafe(ODS,True);
    end;
    if Pos(':DAL',UpperCase(ODS.SQL.Text)) > 0 then
      ODS.DeclareAndSet('DAL',otDate, R003FGeneratoreStampe.DataI);
    if Pos(':AL',UpperCase(ODS.SQL.Text)) > 0 then
      ODS.DeclareAndSet('AL',otDate, R003FGeneratoreStampe.DataF);
    with ODS do
    begin
      Close;
      try
        Open;
        while not Eof do
        begin
          Result:=Result + Format('%s',[Fields[0].AsString]) + CRLF;
          Next;
        end;
      except
        on E:Exception do
          Result:=E.Message;
      end;
    end;
  finally
    ODS.Free;
  end;
end;

procedure TR003FGeneratoreStampeDtM.R003FGeneratoreStampeDtMDestroy(Sender: TObject);
var i:Integer;
begin
  for i:=0 to Self.ComponentCount - 1 do
    if Self.Components[i] is TOracleDataSet then
      (Self.Components[i] as TOracleDataSet).Close;
end;

procedure TR003FGeneratoreStampeDtM.FiltroDizionario(DataSet: TDataSet;
  var Accept: Boolean);
begin
  Accept:=A000FiltroDizionario('GENERATORE DI STAMPE',DataSet.FieldByName('CODICE').AsString);
end;

end.
