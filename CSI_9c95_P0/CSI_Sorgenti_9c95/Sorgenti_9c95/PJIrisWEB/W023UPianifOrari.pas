unit W023UPianifOrari;

interface

uses
  R010UPaginaWeb, R012UWebAnagrafico, IWApplication, A000UCostanti,
  A000USessione,A000UInterfaccia,C180FunzioniGenerali,C190FunzioniGeneraliWeb,
  Classes,Graphics,Controls,SysUtils, IWTemplateProcessorHTML,IWCompLabel,
  IWControl,IWHTMLControls,IWCompEdit,IWCompButton,
  OracleData, IWCompListbox,Variants,IWBaseLayoutComponent,
  IWBaseContainerLayout,IWContainerLayout,IWVCLBaseControl,IWBaseControl,
  IWBaseHTMLControl,Forms,IWVCLComponent,
  Math, StrUtils, Oracle, DB,
  IWDBGrids,medpIWDBGrid,DBClient,
  meIWButton, meIWLabel, meIWEdit,
  meIWGrid, meIWImageFile, meIWLink,
  meIWComboBox, medpIWMultiColumnComboBox, IWCompGrids, IWCompExtCtrls;

  type
  TIndennita = record
    Codice:String;
    Descrizione:String;
    Text:String;
  end;

  TOrari = record
    Codice:String;
    Descrizione:String;
    TipoOra:String;
    PerLav:String;
    NumTurni:Integer;
    Text:String;
  end;

  TDatoLibero = record
    CodLen:Integer;
    Codice:String;
    Descrizione:String;
    Text:String;
  end;

  TRecordPianif = record
    Operazione:String;
    Data:TDateTime;
    Orario:String;
    Turno1:String;
    Turno1EU:String;
    Turno2:String;
    Turno2EU:String;
    IndPresenza:String;
    DatoLibero:String;
  end;

  TW023FPianifOrari = class(TR012FWebAnagrafico)
    dsrT080:TDataSource;
    cdsT080:TClientDataSet;
    grdPianif:TmedpIWDBGrid;
    edtDal: TmeIWEdit;
    lblPeriodoDal: TmeIWLabel;
    edtAl: TmeIWEdit;
    lblPeriodoAl: TmeIWLabel;
    btnEsegui: TmeIWButton;
    btnCancella: TmeIWButton;
    procedure IWAppFormCreate(Sender:TObject);
    procedure btnEseguiClick(Sender:TObject);
    procedure lnkDipendentiDisponibiliClick(Sender:TObject);
    procedure imgModificaClick(Sender:TObject);
    procedure imgEliminaClick(Sender:TObject);
    procedure imgConfermaClick(Sender:TObject);
    procedure imgAnnullaClick(Sender:TObject);
    procedure btnCancellaClick(Sender:TObject);
    procedure grdPianifRenderCell(ACell:TIWGridCell; const ARow,AColumn:Integer);
    procedure grdPianifAfterCaricaCDS(Sender: TObject; DBG_ROWID: string);
  private
    Dal,Al:TDateTime;
    RecordPianif:TRecordPianif;
    ArrOrari: array of TOrari;
    ArrDatoLibero: array of TDatoLibero;
    ArrIndPresenza: array of TIndennita;
    DatoLiberoCodLen:Integer;
    DatoLiberoHead:String;
    Progressivo:Integer;
    StileCella1,StileCella2: String;
    function ArrOrariGetIndex(const Codice:String; p,r:Integer):Integer;
    function ArrOrariGetDesc(const Codice:String; p,r:Integer):String;
    function ArrIndPresenzaGetIndex(const Codice:String; p,r:Integer):Integer;
    function ArrIndPresenzaGetDesc(const Codice:String; p,r:Integer):String;
    function ArrDatoLiberoGetIndex(const Codice:String; p,r:Integer):Integer;
    function ArrDatoLiberoGetDesc(const Codice:String; p,r:Integer):String;
    procedure GetPianificazione;
    procedure GetDatiTabellari;
    procedure TrasformaComponenti(FN:String);
    procedure imgInserisciClick(Sender:TObject);
    function ModificheRiga(FN:String):Boolean;
    function ImpostaPeriodo:Boolean;
    function ControlliOK(FN:String):Boolean;
    //function IndiceComboVal(Riga:integer;inVal:String):integer;
    procedure actInserimentoOK;
    procedure actVariazioneOK;
    procedure actCancellazioneOK(FN:String);
    procedure DBGridColumnClick(ASender:TObject; const AValue:string);
    procedure CreaComponentiRiga(R:Integer);
    procedure cmbOrariChange(Sender: TObject;Indice:integer);
  protected
    procedure VisualizzaDipendenteCorrente; override;
    procedure RefreshPage; override;
    procedure DistruggiOggetti; override;
  public
    function  InizializzaAccesso:Boolean; override;
  end;

implementation

uses W002UAnagrafeScheda,W001UIrisWebDtM;
{$R *.DFM}

function TW023FPianifOrari.InizializzaAccesso:Boolean;
begin
  Result:=True;
  if ParametriForm.Al = DATE_NULL then
  begin
    Dal:=R180InizioMese(Parametri.DataLavoro);
    Al:=R180FineMese(Parametri.DataLavoro);
  end
  else
  begin
    Dal:=ParametriForm.Dal;
    Al:=ParametriForm.Al;
  end;

  // visualizza periodo
  edtDal.Text:=DateToStr(Dal);
  edtAl.Text:=DateToStr(Al);

  // estrae dipendenti disponibili, quindi seleziona il progressivo indicato
  GetDipendentiDisponibili(Parametri.DataLavoro);
  selAnagrafeW.SearchRecord('PROGRESSIVO',ParametriForm.Progressivo,[srFromBeginning]);
  VisualizzaDipendenteCorrente;

  // se questa funzione è richiamata dal cartellino e non esiste una pianificazione
  // per il giorno indicato -> click sul pulsante inserisci
  if (not SolaLettura) and
     (ParametriForm.Chiamante = 'W005') and
     (ParametriForm.Al <> 0) and
     (WR000DM.selT080.RecordCount = 0) then
  begin
    imgInserisciClick(nil);
    try
      (grdPianif.medpCompCella(0,1,0) as TmeIWEdit).Text:=FormatDateTime('dd/mm/yyyy',ParametriForm.Al);
      grdPianif.medpCompCella(0,2,0).SetFocus;
    except
    end;
  end;
end;

procedure TW023FPianifOrari.IWAppFormCreate(Sender:TObject);
begin
  inherited;
  GetDipendentiDisponibili(Parametri.DataLavoro);
  GetDatiTabellari;
  btnCancella.Visible:=not SolaLettura;

  // MONDOEDP - commessa MAN/08 SVILUPPO#161.ini
  grdPianif.medpRighePagina:=GetRighePaginaTabella;
  // MONDOEDP - commessa MAN/08 SVILUPPO#161.fine
  grdPianif.medpDataSet:=WR000DM.selT080;
  grdPianif.medpTestoNoRecord:='Nessuna pianificazione';

  with WR000DM do
  begin
    selT020.Tag:=selT020.Tag + 1;
    selT080.Tag:=selT080.Tag + 1;
  end;
end;

procedure TW023FPianifOrari.RefreshPage;
begin
  VisualizzaDipendenteCorrente;
end;

function TW023FPianifOrari.ImpostaPeriodo:Boolean;
begin
  Result:=True;

  // data iniziale
  if not TryStrToDate(edtDal.Text,Dal) then
  begin
    Result:=False;
    GGetWebApplicationThreadVar.ShowMessage('La data di inizio periodo non è valida');
    ActiveControl:=edtDal;
    Exit;
  end;

  // data finale
  if not TryStrToDate(edtAl.Text,Al) then
  begin
    Result:=False;
    GGetWebApplicationThreadVar.ShowMessage('La data di fine periodo non è valida');
    ActiveControl:=edtAl;
    Exit;
  end;

  // controllo consecutività periodo
  if Dal > Al then
  begin
    Result:=False;
    GGetWebApplicationThreadVar.ShowMessage('Il periodo indicato non è valido');
    ActiveControl:=edtDal;
    Exit;
  end;

  ParametriForm.Dal:=Dal;
  ParametriForm.Al:=Al;
end;

procedure TW023FPianifOrari.btnEseguiClick(Sender:TObject);
// aggiorna la visualizzazione in base al periodo indicato
begin
  if not ImpostaPeriodo then
    Abort;

  // estrae dipendenti disponibili, quindi seleziona il progressivo indicato
  GetDipendentiDisponibili(Parametri.DataLavoro);
  selAnagrafeW.SearchRecord('PROGRESSIVO',Progressivo,[srFromBeginning]);

  grdPianif.medpResetOffset;
  VisualizzaDipendenteCorrente;
end;

procedure TW023FPianifOrari.btnCancellaClick(Sender:TObject);
begin
  // verifica il periodo
  if not ImpostaPeriodo then
    Abort;

  // esegue la cancellazione
  with TOracleQuery.Create(GGetWebApplicationThreadVar) do
  begin
    Session:=SessioneOracle;
    SQL.Add('delete from T080_PIANIFORARI');
    SQL.Add('where  PROGRESSIVO = ' + IntToStr(selAnagrafeW.FieldByName('PROGRESSIVO').AsInteger));
    SQL.Add('and    DATA between to_date(''' + DateToStr(Dal) + ''',''dd/mm/yyyy'') and ');
    SQL.Add('                    to_date(''' + DateToStr(Al) + ''',''dd/mm/yyyy'')');
    try
      RegistraLog.SettaProprieta('C','T080_PIANIFRORARI',medpCodiceForm,nil,True);
      RegistraLog.InserisciDato('PROGRESSIVO',IntToStr(selAnagrafeW.FieldByName('PROGRESSIVO').AsInteger),'');
      RegistraLog.InserisciDato('DAL - AL',Format('%s - %s',[DateToStr(Dal),DateToStr(Al)]),'');
      Execute;
      RegistraLog.RegistraOperazione;
      SessioneOracle.Commit;
    except
      on E:Exception do
        GGetWebApplicationThreadVar.ShowMessage('Cancellazione della pianificazione fallita!' + CRLF + 'Motivo: ' + E.Message);
    end;
    Close;
    Free;
  end;

  VisualizzaDipendenteCorrente;
end;

procedure TW023FPianifOrari.GetPianificazione;
// caricamento array della pianificazione giornaliera nel periodo indicato
begin
  with WR000DM.selT080 do
  begin
    SetVariable('PROGRESSIVO',selAnagrafeW.FieldByName('PROGRESSIVO').AsInteger);
    SetVariable('DATAINIZIO',Dal);
    SetVariable('DATAFINE',Al);
    Close;
    Open;
  end;

  grdPianif.medpCreaCDS;
  grdPianif.medpEliminaColonne;
  grdPianif.medpAggiungiColonna('DBG_COMANDI','','',nil);
  grdPianif.medpAggiungiColonna('DATA','Data','',nil);
  grdPianif.medpAggiungiColonna('ORARIO','Orario','',nil);
  grdPianif.medpAggiungiColonna('TURNO1','Turno 1','',nil);
  grdPianif.medpAggiungiColonna('TURNO1EU','E/U','',nil);
  grdPianif.medpAggiungiColonna('TURNO2','Turno 2','',nil);
  grdPianif.medpAggiungiColonna('TURNO2EU','E/U','',nil);
  grdPianif.medpAggiungiColonna('INDPRESENZA','Ind.Presenza','',nil);
  if Parametri.CampiRiferimento.C3_DatoPianificabile <> '' then
    grdPianif.medpAggiungiColonna('DATOLIBERO',DatoLiberoHead,'',nil);
  grdPianif.medpAggiungiRowClick('DBG_ROWID',DBGridColumnClick);
  grdPianif.medpInizializzaCompGriglia;
  if not SolaLettura then
  begin
    grdPianif.medpPreparaComponenteGenerico('R',0,0,DBG_IMG,'','CANCELLA','null','null','S');
    grdPianif.medpPreparaComponenteGenerico('R',0,1,DBG_IMG,'','MODIFICA','null','','D');
    grdPianif.medpPreparaComponenteGenerico('R',0,2,DBG_IMG,'','ANNULLA','null','','S');
    grdPianif.medpPreparaComponenteGenerico('R',0,3,DBG_IMG,'','CONFERMA','null','','D');
    //Riga di inserimento
    grdPianif.medpPreparaComponenteGenerico('I',0,0,DBG_IMG,'','INSERISCI','null','','S');
    grdPianif.medpPreparaComponenteGenerico('I',0,1,DBG_IMG,'','ANNULLA','null','','S');
    grdPianif.medpPreparaComponenteGenerico('I',0,2,DBG_IMG,'','CONFERMA','null','','D');
  end;
  grdPianif.medpCaricaCDS;
end;

procedure TW023FPianifOrari.GetDatiTabellari;
// Popolamento strutture dati di supporto per i dati tabellari
// utilizzati nella pianificazione (orari, dato libero)
var
  i:Integer;
begin
  // array per i modelli orari
  with WR000DM.selT020 do
  begin
    Close;
    Open;
    SetLength(ArrOrari,RecordCount{ + 1});
    i:=0{1};
    First;
    while not Eof do
    begin
      ArrOrari[i].Codice:=FieldByName('CODICE').AsString;
      ArrOrari[i].Descrizione:=FieldByName('DESCRIZIONE').AsString;
      ArrOrari[i].TipoOra:=FieldByName('TIPOORA').AsString;
      ArrOrari[i].PerLav:=FieldByName('PERLAV').AsString;
      ArrOrari[i].NumTurni:=FieldByName('TURNI').AsInteger;
      ArrOrari[i].Text:=Format('%-5s %s',[FieldByName('CODICE').AsString,FieldByName('DESCRIZIONE').AsString]);
      Next;
      i:=i + 1;
    end;
    Close;
  end;

  // array per i codici indennità
  with WR000DM.selT163 do
  begin
    Close;
    Open;
    SetLength(ArrIndPresenza,RecordCount{ + 1});
    i:=0{1};
    First;
    while not Eof do
    begin
      ArrIndPresenza[i].Codice:=FieldByName('CODICE').AsString;
      ArrIndPresenza[i].Descrizione:=FieldByName('DESCRIZIONE').AsString;
      ArrIndPresenza[i].Text:=Format('%-5s %s',[FieldByName('CODICE').AsString,FieldByName('DESCRIZIONE').AsString]);
      Next;
      i:=i + 1;
    end;
    Close;
  end;

  // strutture per il dato libero C3_DatoPianificabile
  if Parametri.CampiRiferimento.C3_DatoPianificabile <> '' then
  begin
    DatoLiberoHead:=R180Capitalize(Parametri.CampiRiferimento.C3_DatoPianificabile);

    // reperimento dato libero e popolamento array
    with WR000DM do
    begin
      if A000LookupTabella(Parametri.CampiRiferimento.C3_DatoPianificabile,selDatoLibero) then
      begin
        if Parametri.CampiRiferimento.C3_DatoPianificabile = 'COMUNE' then
          selT080.FieldByName('D_DATOLIBERO').Tag:=999;
        if selDatoLibero.VariableIndex('DECORRENZA') >= 0 then
          selDatoLibero.SetVariable('DECORRENZA',R180FineMese(Parametri.DataLavoro));

        // inizializzazione array
        with selDatoLibero do
        begin
          Open;
          SetLength(ArrDatoLibero,RecordCount + 1);
          i:=1;
          DatoLiberoCodLen:=0;
          First;
          while not Eof do
          begin
            ArrDatoLibero[i].CodLen:=Length(FieldByName('CODICE').AsString);
            ArrDatoLibero[i].Codice:=FieldByName('CODICE').AsString;
            ArrDatoLibero[i].Descrizione:=FieldByName('DESCRIZIONE').AsString;
            if ArrDatoLibero[i].CodLen > DatoLiberoCodLen then
              DatoLiberoCodLen:=ArrDatoLibero[i].CodLen;
            Next;
            i:=i + 1;
          end;

          // imposta il testo da visualizzare nella combo
          for i:=0 to Length(ArrDatoLibero) - 1 do
            ArrDatoLibero[i].Text:=Format('%-*s - %s',[DatoLiberoCodLen,ArrDatoLibero[i].Codice,ArrDatoLibero[i].Descrizione]);
          Close;
        end;
      end;
    end;
  end;
end;

procedure TW023FPianifOrari.VisualizzaDipendenteCorrente;
// aggiorna la visualizzazione della pianificazione per il dipendente selezionato
begin
  inherited;
  ParametriForm.Progressivo:=selAnagrafeW.FieldByName('PROGRESSIVO').AsInteger;
  RecordPianif.Operazione:='';
  grdPianif.medpBrowse:=True;
  GetPianificazione;
end;

function TW023FPianifOrari.ArrOrariGetIndex(const Codice:String; p,r:Integer):Integer;
var
  q,Res:Integer;
begin
  Res:=-1;

  if (p < r) then
  begin
    q:=(p + r) div 2;
    if (Codice < ArrOrari[q].Codice) then
      Res:=ArrOrariGetIndex(Codice,p,q - 1);
    if (Codice > ArrOrari[q].Codice) then
      Res:=ArrOrariGetIndex(Codice,q + 1,r);
    if (Codice = ArrOrari[q].Codice) then
      Res:=q;
  end
  else if p = r then
  begin
    if ArrOrari[p].Codice = Codice then
      Res:=p
  end
  else
    Res:=-1;

  Result:=Res;
end;

function TW023FPianifOrari.ArrOrariGetDesc(const Codice:String; p,r:Integer):String;
var x:Integer;
begin
  Result:='';
  x:=ArrOrariGetIndex(Codice,p,r);
  if x >= 0 then
    Result:=ArrOrari[x].Descrizione;
end;

function TW023FPianifOrari.ArrIndPresenzaGetIndex(const Codice:String; p,r:Integer):Integer;
var
  q,Res:Integer;
begin
  Res:=-1;

  if (p < r) then
  begin
    q:=(p + r) div 2;
    if (Codice < ArrIndPresenza[q].Codice) then
      Res:=ArrIndPresenzaGetIndex(Codice,p,q - 1);
    if (Codice > ArrIndPresenza[q].Codice) then
      Res:=ArrIndPresenzaGetIndex(Codice,q + 1,r);
    if (Codice = ArrIndPresenza[q].Codice) then
      Res:=q;
  end
  else if p = r then
  begin
    if ArrIndPresenza[p].Codice = Codice then
      Res:=p
  end
  else
    Res:=-1;

  Result:=Res;
end;

function TW023FPianifOrari.ArrIndPresenzaGetDesc(const Codice:String; p,r:Integer):String;
var x:Integer;
begin
  Result:='';
  x:=ArrIndPresenzaGetIndex(Codice,p,r);
  if x >= 0 then
    Result:=ArrIndPresenza[x].Descrizione;
end;

function TW023FPianifOrari.ArrDatoLiberoGetIndex(const Codice:String; p,r:Integer):Integer;
var
  q,Res:Integer;
begin
  Res:=-1;

  if (p < r) then
  begin
    q:=(p + r) div 2;
    if (Codice < ArrDatoLibero[q].Codice) then
      Res:=ArrDatoLiberoGetIndex(Codice,p,q - 1);
    if (Codice > ArrDatoLibero[q].Codice) then
      Res:=ArrDatoLiberoGetIndex(Codice,q + 1,r);
    if (Codice = ArrDatoLibero[q].Codice) then
      Res:=q;
  end
  else if p = r then
  begin
    if ArrDatoLibero[p].Codice = Codice then
      Res:=p
  end
  else
    Res:=-1;

  Result:=Res;
end;

function TW023FPianifOrari.ArrDatoLiberoGetDesc(const Codice:String; p,r:Integer):String;
var x:Integer;
begin
  Result:='';
  x:=ArrDatoLiberoGetIndex(Codice,p,r);
  if x >= 0 then
    Result:=ArrDatoLibero[x].Descrizione;
end;

{
function TW023FPianifOrari.IndiceComboVal(Riga:integer;inVal:String):integer;
var
  cmbVal:String;
begin
  Result:=0;
  with (grdPianif.medpCompCella(Riga,2,0) as TmedpIWMultiColumnComboBox) do
  begin
    cmbVal:=Trim(Items[Result].RowData[0]);
    while (cmbVal <> inVal) and (Result < Items.Count - 1) do
    begin
      inc(Result);
      cmbVal:=Trim(Items[Result].RowData[0]);
    end;
    if inVal <> cmbVal then
      Result:=0;
  end;
end;
}

procedure TW023FPianifOrari.TrasformaComponenti(FN:String);
// Trasforma i componenti della riga indicata da text a control e viceversa per la grid grdPianif
var
  DaTestoAControlli:Boolean;
  i,j,NumTurniIni:Integer;
begin
  // pre: not SolaLettura
  i:=grdPianif.medpRigaDiCompGriglia(FN);
  DaTestoAControlli:=grdPianif.medpCompGriglia[i].CompColonne[4] = nil;
  // immagine per cancellazione / annullamento operazione
  with (grdPianif.medpCompGriglia[i].CompColonne[0] as TmeIWGrid) do
  begin
    Cell[0,0].Css:=IfThen(DaTestoAControlli,'invisibile',StileCella1);
    Cell[0,1].Css:=IfThen(DaTestoAControlli,'invisibile',StileCella2);
    Cell[0,2].Css:=IfThen(DaTestoAControlli,StileCella1,'invisibile');
    Cell[0,3].Css:=IfThen(DaTestoAControlli,StileCella2,'invisibile');
  end;

  if DaTestoAControlli then
  begin
    CreaComponentiRiga(i);
    // data
    (grdPianif.medpCompCella(i,1,0) as TmeIWEdit).Text:=grdPianif.medpValoreColonna(i,'DATA');
    // orario
    with (grdPianif.medpCompCella(i,2,0) as TmedpIWMultiColumnComboBox) do
    begin
      {
      ItemIndex:=-1;
      NumTurniIni:=ArrOrari[IndiceComboVal(i,grdPianif.medpValoreColonna(i,'ORARIO'))].NumTurni;
      }
      Text:=grdPianif.medpValoreColonna(i,'ORARIO');
      if ItemIndex = -1 then
        NumTurniIni:=0
      else
        NumTurniIni:=ArrOrari[ItemIndex].NumTurni;
    end;
    // turno 1
    with (grdPianif.medpCompCella(i,3,0) as TmeIWComboBox) do
    begin
      Items.Clear;
      Items.Add('');
      for j:=0 to NumTurniIni do
        Items.Add(IntToStr(j));
      ItemIndex:=max(0,Items.IndexOf(grdPianif.medpValoreColonna(i,'TURNO1')));
    end;
    // E/U turno 1
    with (grdPianif.medpCompCella(i,4,0) as TmeIWComboBox) do
    begin
      ItemIndex:=Items.IndexOf(grdPianif.medpValoreColonna(i,'TURNO1EU'));
    end;
    // turno 2
    with (grdPianif.medpCompCella(i,5,0) as TmeIWComboBox) do
    begin
      Items.Assign((grdPianif.medpCompCella(i,3,0) as TmeIWComboBox).Items);
      ItemIndex:=max(0,Items.IndexOf(grdPianif.medpValoreColonna(i,'TURNO2')));
    end;
    // E/U turno 2
    with (grdPianif.medpCompCella(i,6,0) as TmeIWComboBox) do
    begin
      ItemIndex:=Items.IndexOf(grdPianif.medpValoreColonna(i,'TURNO2EU'));
    end;
    // indennità di presenza
    with (grdPianif.medpCompCella(i,7,0) as TmedpIWMultiColumnComboBox) do
    begin
      Text:=grdPianif.medpValoreColonna(i,'INDPRESENZA');
    end;
    // dato libero
    if Parametri.CampiRiferimento.C3_DatoPianificabile <> '' then
    begin
      with (grdPianif.medpCompCella(i,8,0) as TmeIWComboBox) do
      begin
        ItemIndex:=max(0,R180IndexOf(Items,grdPianif.medpValoreColonna(i,'DATOLIBERO'),DatoLiberoCodLen));
      end;
    end;
  end
  else
  begin
    // data
    FreeAndNil(grdPianif.medpCompGriglia[i].CompColonne[1]);
    // orario
    FreeAndNil(grdPianif.medpCompGriglia[i].CompColonne[2]);
    // turno 1
    FreeAndNil(grdPianif.medpCompGriglia[i].CompColonne[3]);
    // E/U turno 1
    FreeAndNil(grdPianif.medpCompGriglia[i].CompColonne[4]);
    // turno 2
    FreeAndNil(grdPianif.medpCompGriglia[i].CompColonne[5]);
    // E/U turno 2
    FreeAndNil(grdPianif.medpCompGriglia[i].CompColonne[6]);
    // indennità di presenza
    FreeAndNil(grdPianif.medpCompGriglia[i].CompColonne[7]);
    // dato libero
    if Parametri.CampiRiferimento.C3_DatoPianificabile <> '' then
      FreeAndNil(grdPianif.medpCompGriglia[i].CompColonne[8]);
  end;
end;

function TW023FPianifOrari.ControlliOK(FN:String):Boolean;
var
  i:Integer;
  edtData:TmeIWEdit;
begin
  Result:=False;

  // validazione date periodo
  if not ImpostaPeriodo then
    Exit;

  // imposta dataset per dati bloccati
  WR000DM.selDatiBloccati.Close;
  i:=grdPianif.medpRigaDiCompGriglia(FN);
  with grdPianif do
  begin
    // data pianificazione
    edtData:=(grdPianif.medpCompCella(i,1,0) as TmeIWEdit);
    if edtData.Text = '' then
    begin
      GGetWebApplicationThreadVar.ShowMessage('Indicare la data per la pianificazione!');
      ActiveControl:=edtData;
      Exit;
    end;
    if not TryStrToDate(edtData.Text,RecordPianif.Data) then
    begin
      GGetWebApplicationThreadVar.ShowMessage('La data specificata è errata!');
      ActiveControl:=edtData;
      Exit;
    end;
    if (RecordPianif.Data < Dal) or (RecordPianif.Data > Al) then
    begin
      GGetWebApplicationThreadVar.ShowMessage('La data è esterna al periodo di elaborazione!');
      ActiveControl:=edtData;
      Exit;
    end;

    // imposta variabili per inserimento / aggiornamento
    RecordPianif.Orario:=(grdPianif.medpCompCella(i,2,0) as TmedpIWMultiColumnComboBox).Text;
    RecordPianif.Turno1:=Trim((grdPianif.medpCompCella(i,3,0) as TmeIWComboBox).Text);
    RecordPianif.Turno1EU:=Trim((grdPianif.medpCompCella(i,4,0) as TmeIWComboBox).Text);
    RecordPianif.Turno2:=Trim((grdPianif.medpCompCella(i,5,0) as TmeIWComboBox).Text);
    RecordPianif.Turno2EU:=Trim((grdPianif.medpCompCella(i,6,0) as TmeIWComboBox).Text);
    RecordPianif.IndPresenza:=(grdPianif.medpCompCella(i,7,0) as TmedpIWMultiColumnComboBox).Text;
    if Parametri.CampiRiferimento.C3_DatoPianificabile <> '' then
      RecordPianif.DatoLibero:=Trim(Copy((grdPianif.medpCompCella(i,8,0) as TmeIWComboBox).Text,1,DatoLiberoCodLen))
    else
      RecordPianif.DatoLibero:='';

    // almeno un dato fra: orario / indennità presenza / dato libero
    if (RecordPianif.Orario = '') and (RecordPianif.IndPresenza = '') then
    begin
      if Parametri.CampiRiferimento.C3_DatoPianificabile = '' then
      begin
        GGetWebApplicationThreadVar.ShowMessage('Indicare almeno uno fra i seguenti dati:' + CRLF + '- codice orario' + CRLF + '- codice indennità di presenza.');
        Exit;
      end
      else if RecordPianif.DatoLibero = '' then
      begin
        GGetWebApplicationThreadVar.ShowMessage('Indicare almeno uno fra i seguenti dati:' + CRLF + '- codice orario' + CRLF + '- codice indennità di presenza' + CRLF + '- codice ' + DatoLiberoHead + '.');
        Exit;
      end;
    end;

    // orario non specificato, ma turni indicati
    if (RecordPianif.Orario = '') and ((RecordPianif.Turno1 <> '') or (RecordPianif.Turno1EU <> '') or (RecordPianif.Turno2 <> '') or (RecordPianif.Turno2EU <> '')) then
    begin
      GGetWebApplicationThreadVar.ShowMessage('Indicare l''orario da pianificare!');
      try
        grdPianif.medpCompCella(i,2,0).SetFocus;
      except
      end;
      Exit;
    end;

    // turno 2 indicato ma turno 1 vuoto
    if (RecordPianif.Turno1 = '') and (RecordPianif.Turno2 <> '') then
    begin
      GGetWebApplicationThreadVar.ShowMessage('Indicare il primo turno da pianificare!');
      try
        grdPianif.medpCompCella(i,3,0).SetFocus;
      except
      end;
      Exit;
    end;

    // turno 1 E/U indicato ma turno 1 vuoto oppure 0
    if (RecordPianif.Turno1EU <> '') and ((RecordPianif.Turno1 = '') or (RecordPianif.Turno1 = '0')) then
      RecordPianif.Turno1EU:='';

    // turno 2 E/U indicato ma turno 2 vuoto oppure 0
    if (RecordPianif.Turno2EU <> '') and ((RecordPianif.Turno2 = '') or (RecordPianif.Turno2 = '0')) then
      RecordPianif.Turno2EU:='';
  end;

  // verifiche sulla base dati
  with WR000DM do
  begin
    // verifica dato bloccato
    if selDatiBloccati.DatoBloccato(Progressivo,R180InizioMese(RecordPianif.Data),'T080') then
    begin
      MsgBox.MessageBox(IfThen(RecordPianif.Operazione = 'I','Inserimento non consentito!','Variazione non consentita!') + CRLF + 'Motivo: ' + selDatiBloccati.MessaggioLog,INFORMA,'Riepiloghi bloccati');
      Exit;
    end;

    // verifica pianificazione già esistente (in base a inserimento / variazione)
    if RecordPianif.Operazione = 'I' then
    begin
      if QueryPK1.EsisteChiave('T080_PIANIFORARI','',dsInsert,['PROGRESSIVO','DATA'],[IntToStr(selAnagrafeW.FieldByName('PROGRESSIVO').AsInteger),DateToStr(RecordPianif.Data)]) then
      begin
        MsgBox.MessageBox('Pianificazione già esistente!',INFORMA);
        Exit;
      end
    end
    else
    begin
      if QueryPK1.EsisteChiave('T080_PIANIFORARI',selT080.RowID,dsEdit,['PROGRESSIVO','DATA'],[IntToStr(selAnagrafeW.FieldByName('PROGRESSIVO').AsInteger),DateToStr(RecordPianif.Data)]) then
      begin
        MsgBox.MessageBox('Pianificazione già esistente!',INFORMA);
        Exit;
      end
    end;
  end;

  // controlli ok
  Result:=True;
end;

procedure TW023FPianifOrari.actInserimentoOK;
// controlli ok -> inserimento record di pianificazione
begin
  with WR000DM.selT080 do
  begin
    Append;
    FieldByName('PROGRESSIVO').AsInteger:=selAnagrafeW.FieldByName('PROGRESSIVO').AsInteger;
    FieldByName('DATA').AsDateTime:=RecordPianif.Data;
    FieldByName('ORARIO').AsString:=RecordPianif.Orario;
    FieldByName('TURNO1').AsString:=RecordPianif.Turno1;
    FieldByName('TURNO1EU').AsString:=RecordPianif.Turno1EU;
    FieldByName('TURNO2').AsString:=RecordPianif.Turno2;
    FieldByName('TURNO2EU').AsString:=RecordPianif.Turno2EU;
    FieldByName('INDPRESENZA').AsString:=RecordPianif.IndPresenza;
    if Parametri.CampiRiferimento.C3_DatoPianificabile <> '' then
      FieldByName('DATOLIBERO').AsString:=RecordPianif.DatoLibero;
    try
      RegistraLog.SettaProprieta('I','T080_PIANIFRORARI',medpCodiceForm,WR000DM.selT080,True);
      Post;
      RegistraLog.RegistraOperazione;
      SessioneOracle.Commit;
    except
      on E:Exception do
        GGetWebApplicationThreadVar.ShowMessage('Inserimento della pianificazione fallito!' + CRLF + 'Motivo: ' + E.Message);
    end;
  end;

  // rilegge i dati
  VisualizzaDipendenteCorrente;
end;

procedure TW023FPianifOrari.actVariazioneOK;
// controlli ok -> variazione record di pianificazione
begin
  with WR000DM.selT080 do
  begin
    Edit;
    FieldByName('DATA').AsDateTime:=RecordPianif.Data;
    FieldByName('ORARIO').AsString:=RecordPianif.Orario;
    FieldByName('TURNO1').AsString:=RecordPianif.Turno1;
    FieldByName('TURNO1EU').AsString:=RecordPianif.Turno1EU;
    FieldByName('TURNO2').AsString:=RecordPianif.Turno2;
    FieldByName('TURNO2EU').AsString:=RecordPianif.Turno2EU;
    FieldByName('INDPRESENZA').AsString:=RecordPianif.IndPresenza;
    if Parametri.CampiRiferimento.C3_DatoPianificabile <> '' then
      FieldByName('DATOLIBERO').AsString:=RecordPianif.DatoLibero;
    try
      RegistraLog.SettaProprieta('M','T080_PIANIFRORARI',medpCodiceForm,WR000DM.selT080,True);
      Post;
      RegistraLog.RegistraOperazione;
      SessioneOracle.Commit;
    except
      on E:Exception do
        GGetWebApplicationThreadVar.ShowMessage('Variazione della pianificazione fallita!' + CRLF + 'Motivo: ' + E.Message);
    end;
  end;

  // rilegge i dati
  VisualizzaDipendenteCorrente;
end;

procedure TW023FPianifOrari.actCancellazioneOK(FN:String);
begin
  // cancellazione record
  with WR000DM.selT080 do
  begin
    if SearchRecord('ROWID',FN,[srFromBeginning]) then
    begin
      // controllo dato bloccato
      WR000DM.selDatiBloccati.Close;
      if WR000DM.selDatiBloccati.DatoBloccato(FieldByName('PROGRESSIVO').AsInteger,R180InizioMese(FieldByName('DATA').AsDateTime),'T080') then
      begin
        GGetWebApplicationThreadVar.ShowMessage('Cancellazione non consentita!' + CRLF + 'Motivo: ' + WR000DM.selDatiBloccati.MessaggioLog);
        Exit;
      end;
      // cancella il record
      try
        RegistraLog.SettaProprieta('C','T080_PIANIFORARI',medpCodiceForm,WR000DM.selT080,True);
        Delete;
        RegistraLog.RegistraOperazione;
        SessioneOracle.Commit;
      except
        on E:Exception do
          GGetWebApplicationThreadVar.ShowMessage('Cancellazione della pianificazione fallita!' + CRLF + 'Motivo: ' + E.Message);
      end;
    end;
  end;
  VisualizzaDipendenteCorrente;
end;

procedure TW023FPianifOrari.cmbOrariChange(Sender: TObject;Indice:integer);
// Imposta gli item delle combo dei turni in base al num. di turni disponibili per l'orario selezionato
var
  i,r,NumTurni,idx:Integer;
begin
  // pre: Sender = combobox degli orari
  r:=grdPianif.medpRigaDiCompGriglia((Sender as TmedpIWMultiColumnComboBox).FriendlyName);

  // numero turni disponibili per l'orario
  idx:=(Sender as TmedpIWMultiColumnComboBox).ItemIndex;
  if idx = -1 then
    NumTurni:=0
  else
    NumTurni:=ArrOrari[idx].NumTurni;

  // imposta le combo dei turni in base al num. di turni disponibili per l'orario selezionato
  with (grdPianif.medpCompCella(r,3,0) as TmeIWComboBox) do
  begin
    Items.Clear;
    Items.Add('');
    for i:=0 to NumTurni do
      Items.Add(IntToStr(i));
    ItemIndex:=0;
  end;

  // imposta la combo del turno 2 uguale al turno 1
  with (grdPianif.medpCompCella(r,5,0) as TmeIWComboBox) do
  begin
    Items.Assign((grdPianif.medpCompCella(r,3,0) as TmeIWComboBox).Items);
    ItemIndex:=0;
  end;
end;

function TW023FPianifOrari.ModificheRiga(FN:String):Boolean;
// Restituisce True/False a seconda che il record sia stato modificato o meno
var
  i:Integer;
begin
  i:=grdPianif.medpRigaDiCompGriglia(FN);
  Result:=
    (VarToStr(cdsT080.Lookup('DBG_ROWID',FN,'DATA')) <> (grdPianif.medpCompCella(i,1,0) as TmeIWEdit).Text) or
    (VarToStr(cdsT080.Lookup('DBG_ROWID',FN,'ORARIO')) <> Trim((grdPianif.medpCompCella(i,2,0) as TmedpIWMultiColumnComboBox).Text)) or
    (VarToStr(cdsT080.Lookup('DBG_ROWID',FN,'TURNO1')) <> Trim((grdPianif.medpCompCella(i,3,0) as TmeIWComboBox).Text)) or
    (VarToStr(cdsT080.Lookup('DBG_ROWID',FN,'TURNO1EU')) <> Trim((grdPianif.medpCompCella(i,4,0) as TmeIWComboBox).Text)) or
    (VarToStr(cdsT080.Lookup('DBG_ROWID',FN,'TURNO2')) <> Trim((grdPianif.medpCompCella(i,5,0) as TmeIWComboBox).Text)) or
    (VarToStr(cdsT080.Lookup('DBG_ROWID',FN,'TURNO2EU')) <> Trim((grdPianif.medpCompCella(i,6,0) as TmeIWComboBox).Text)) or
    (VarToStr(cdsT080.Lookup('DBG_ROWID',FN,'INDPRESENZA')) <> Trim((grdPianif.medpCompCella(i,7,0) as TmedpIWMultiColumnComboBox).Text));
  if Parametri.CampiRiferimento.C3_DatoPianificabile <> '' then
    Result:=Result or (VarToStr(cdsT080.Lookup('DBG_ROWID',FN,'DATOLIBERO')) <> Trim(Copy((grdPianif.medpCompCella(i,8,0) as TmeIWComboBox).Text,1,DatoLiberoCodLen)));
end;

procedure TW023FPianifOrari.CreaComponentiRiga(R:Integer);
var
  i:Integer;
  FN:String;
begin
  FN:=grdPianif.medpValoreColonna(R,'DBG_ROWID');
  // data
  grdPianif.medpPreparaComponenteGenerico('C',0,0,DBG_EDT,'DATA','','','','S');
  grdPianif.medpCreaComponenteGenerico(R,1,grdPianif.Componenti);
  with (grdPianif.medpCompCella(R,1,0) as TmeIWEdit) do
  begin
    FriendlyName:=FN;
    Text:=FormatDateTime('dd/mm/yyyy',Parametri.DataLavoro);
  end;
  // orario
  grdPianif.medpPreparaComponenteGenerico('C',0,0,DBG_MECMB,'30','2','','','S');
  grdPianif.medpCreaComponenteGenerico(R,2,grdPianif.Componenti);
  with (grdPianif.medpCompCella(R,2,0) as TmedpIWMultiColumnComboBox) do
  begin
    LookupColumn:=1;
    PopUpHeight:=15;
    ShowHint:=True;
    ColCount:=2;
    for i:=Low(ArrOrari) to High(ArrOrari) do
      AddRow(ArrOrari[i].Codice + ';' + ArrOrari[i].Descrizione);
    Text:=grdPianif.medpValoreColonna(R,'ORARIO');
    OnChange:=cmbOrariChange;
  end;
  // turno 1
  grdPianif.medpPreparaComponenteGenerico('C',0,0,DBG_CMB_COUR,'10','','','','S');
  grdPianif.medpCreaComponenteGenerico(R,3,grdPianif.Componenti);
  with (grdPianif.medpCompCella(R,3,0) as TmeIWComboBox) do
  begin
    FriendlyName:=FN;
    Items.Add('');
    ItemIndex:=0;
  end;
  // E/U turno 1
  grdPianif.medpPreparaComponenteGenerico('C',0,0,DBG_CMB_COUR,'2','','','','S');
  grdPianif.medpCreaComponenteGenerico(R,4,grdPianif.Componenti);
  with (grdPianif.medpCompCella(R,4,0) as TmeIWComboBox) do
  begin
    FriendlyName:=FN;
    Items.CommaText:=',E,U';
    ItemIndex:=0;
  end;
  // turno 2
  grdPianif.medpPreparaComponenteGenerico('C',0,0,DBG_CMB_COUR,'10','','','','S');
  grdPianif.medpCreaComponenteGenerico(R,5,grdPianif.Componenti);
  with (grdPianif.medpCompCella(R,5,0) as TmeIWComboBox) do
  begin
    FriendlyName:=FN;
    Items.Add('');
    ItemIndex:=0;
  end;
  // E/U turno 2
  grdPianif.medpPreparaComponenteGenerico('C',0,0,DBG_CMB_COUR,'2','','','','S');
  grdPianif.medpCreaComponenteGenerico(R,6,grdPianif.Componenti);
  with (grdPianif.medpCompCella(R,6,0) as TmeIWComboBox) do
  begin
    FriendlyName:=FN;
    Items.CommaText:=',E,U';
    ItemIndex:=0;
  end;
  // indennità di presenza
  grdPianif.medpPreparaComponenteGenerico('C',0,0,DBG_MECMB,'5','2','','','S');
  grdPianif.medpCreaComponenteGenerico(R,7,grdPianif.Componenti);

  with (grdPianif.medpCompCella(R,7,0) as TmedpIWMultiColumnComboBox) do
  begin
    LookupColumn:=1;
    //PopUpWidth:=25;
    PopUpHeight:=15;
    ShowHint:=True;
    for i:=Low(ArrIndPresenza) to High(ArrIndPresenza) do
      AddRow(ArrIndPresenza[i].Codice + ';' + ArrIndPresenza[i].Descrizione);
    Text:=grdPianif.medpValoreColonna(R,'INDPRESENZA');
  end;

  // dato libero
  if Parametri.CampiRiferimento.C3_DatoPianificabile <> '' then
  begin
    grdPianif.medpPreparaComponenteGenerico('C',0,0,DBG_CMB_COUR,'20','','','','S');
    grdPianif.medpCreaComponenteGenerico(R,8,grdPianif.Componenti);

    with (grdPianif.medpCompCella(R,8,0) as TmeIWComboBox) do
    begin
      FriendlyName:=FN;
      ItemsHaveValues:=True;
      Items.NameValueSeparator:=NAME_VALUE_SEPARATOR;
      Items.Add('');
      for i:=1 to Length(ArrDatoLibero) - 1 do
        Items.Values[ArrDatoLibero[i].Text]:=ArrDatoLibero[i].Codice;
      ItemIndex:=0;
    end;
  end;
end;

procedure TW023FPianifOrari.imgInserisciClick(Sender:TObject);
var
  FN: String;
begin
  if (RecordPianif.Operazione <> '') then
  begin
    GGetWebApplicationThreadVar.ShowMessage('E'' necessario completare oppure annullare l''operazione'#13#10'di ' +
                               IfThen(RecordPianif.Operazione = 'I','inserimento','variazione') + ' in corso prima di procedere!');
    Exit;
  end;

  if Sender <> nil then
  begin
    FN:=(Sender as TmeIWImageFile).FriendlyName;
    DBGridColumnClick(Sender,FN);
  end;

  RecordPianif.Operazione:='I';
  grdPianif.medpBrowse:=False;

  with grdPianif do
  begin
    //Nascondo il pulsante inserisci e visualizzo annulla/conferma
    with (medpCompGriglia[0].CompColonne[0] as TmeIWGrid) do
    begin
      Cell[0,0].Css:='invisibile';
      Cell[0,1].Css:=StileCella1;
      Cell[0,2].Css:=StileCella2;
    end;
  end;
  CreaComponentiRiga(0);
end;

procedure TW023FPianifOrari.imgModificaClick(Sender:TObject);
var
  FN: String;
begin
  // modifica - applicazione modifiche
  if (RecordPianif.Operazione = 'I') or (RecordPianif.Operazione = 'M') then
  begin
    GGetWebApplicationThreadVar.ShowMessage('E'' necessario completare oppure annullare l''operazione' + CRLF + 'di ' + IfThen(RecordPianif.Operazione = 'I','inserimento','variazione') + ' in corso prima di procedere!');
    Exit;
  end;

  FN:=(Sender as TmeIWImageFile).FriendlyName;

  DBGridColumnClick(Sender,FN);

  // porta la riga in modifica: trasforma i componenti
  RecordPianif.Operazione:='M';
  TrasformaComponenti(FN);
  grdPianif.medpBrowse:=False;
end;

procedure TW023FPianifOrari.imgEliminaClick(Sender:TObject);
//  Elimina: elimina il record corrente
var
  FN: String;
begin
  if (RecordPianif.Operazione = 'I') or (RecordPianif.Operazione = 'M') then
  begin
    GGetWebApplicationThreadVar.ShowMessage('E'' necessario completare oppure annullare l''operazione' + CRLF + 'di ' + IfThen(RecordPianif.Operazione = 'I','inserimento','variazione') + ' in corso prima di procedere!');
    Exit;
  end;

  FN:=(Sender as TmeIWImageFile).FriendlyName;

  DBGridColumnClick(Sender,FN);

  // eliminazione record
  actCancellazioneOK(FN);
end;

procedure TW023FPianifOrari.imgConfermaClick(Sender:TObject);
var
  FN: String;
begin
  FN:=(Sender as TmeIWImageFile).FriendlyName;

  DBGridColumnClick(Sender,FN);

  // modifica - applicazione modifiche
  if (RecordPianif.Operazione = 'M') then
  begin
    // nessuna operazione da effettuare se non sono state apportate modifiche alla riga
    if not ModificheRiga(FN) then
    begin
      RecordPianif.Operazione:='';
      TrasformaComponenti(FN);
      grdPianif.medpBrowse:=True;
      Exit;
    end;

    // se il record non esiste -> errore
    if not WR000DM.selT080.SearchRecord('ROWID',FN,[srFromBeginning]) then
    begin
      RecordPianif.Operazione:='';
      TrasformaComponenti(FN);
      grdPianif.medpBrowse:=True;
      GGetWebApplicationThreadVar.ShowMessage('Errore durante la modifica della pianificazione:' + CRLF + 'il record non è più disponibile!');
      Exit;
    end;
  end;

  // effettua controlli bloccanti
  if not ControlliOK(FN) then
    Exit;

  // inserimento / aggiornamento
  if RecordPianif.Operazione = 'I' then
    actInserimentoOK
  else
    actVariazioneOK;
end;

procedure TW023FPianifOrari.imgAnnullaClick(Sender:TObject);
//  Annulla: annulla le modifiche apportate nei componenti editabili
begin
  RecordPianif.Operazione:='';
  grdPianif.medpBrowse:=True;
  btnEseguiClick(Sender);
end;

procedure TW023FPianifOrari.lnkDipendentiDisponibiliClick(Sender:TObject);
var
  W002:TW002FAnagrafeScheda;
begin
  W002:=TW002FAnagrafeScheda(WR000DM.History.FormByTag(412));
  if W002 = nil then
    W002:=TW002FAnagrafeScheda.Create(GGetWebApplicationThreadVar);
  W002.SetParam('MATRICOLA',cmbDipendentiDisponibili.Items.ValueFromIndex[cmbDipendentiDisponibili.ItemIndex]);
  W002.SetParam('CAPTION_INDIETRO','Reperibilità');
  W002.SetParam('COMPLETA',False);
  W002.OpenPage;
end;

procedure TW023FPianifOrari.grdPianifAfterCaricaCDS(Sender: TObject; DBG_ROWID: string);
var
  i: Integer;
begin
  if (not SolaLettura) then
  begin
    with grdPianif.medpCompGriglia[0].CompColonne[0] as TmeIWGrid do
    begin
      StileCella1:=Cell[0,0].Css;
      StileCella2:=Cell[0,2].Css;
    end;
    //Riga di inserimento
    (grdPianif.medpCompCella(0,0,0) as TmeIWImageFile).OnClick:=imgInserisciClick;
    (grdPianif.medpCompCella(0,0,1) as TmeIWImageFile).OnClick:=imgAnnullaClick;
    (grdPianif.medpCompCella(0,0,2) as TmeIWImageFile).OnClick:=imgConfermaClick;
    with grdPianif.medpCompGriglia[0].CompColonne[0] as TmeIWGrid do
    begin
      Cell[0,1].Css:='invisibile';
      Cell[0,2].Css:='invisibile';
    end;
    //Righe dati
    for i:=1 to High(grdPianif.medpCompGriglia) do
    begin
      // Associo l'evento OnClick alle Icone
      (grdPianif.medpCompCella(i,0,0) as TmeIWImageFile).OnClick:=imgEliminaClick;
      (grdPianif.medpCompCella(i,0,1) as TmeIWImageFile).OnClick:=imgModificaClick;
      (grdPianif.medpCompCella(i,0,2) as TmeIWImageFile).OnClick:=imgAnnullaClick;
      (grdPianif.medpCompCella(i,0,3) as TmeIWImageFile).OnClick:=imgConfermaClick;
      with grdPianif.medpCompGriglia[i].CompColonne[0] as TmeIWGrid do
      begin
        Cell[0,2].Css:='invisibile';
        Cell[0,3].Css:='invisibile';
      end;
    end;
  end;
end;

procedure TW023FPianifOrari.grdPianifRenderCell(ACell:TIWGridCell; const ARow,AColumn:Integer);
begin
  if not (ACell.Grid as TmedpIWDBGrid).medpRenderCell(ACell,ARow,AColumn,True,True) then
    Exit;

  // gestione degli Hint
  if grdPianif.medpColonna(AColumn).DataField = 'ORARIO' then
  begin
    ACell.Hint:=ArrOrariGetDesc(ACell.Text,0, High(ArrOrari));
    ACell.ShowHint:=ACell.Hint <> '';
  end
  else if grdPianif.medpColonna(AColumn).DataField = 'INDPRESENZA' then
  begin
    ACell.Hint:=ArrIndPresenzaGetDesc(ACell.Text,0, High(ArrIndPresenza));
    ACell.ShowHint:=ACell.Hint <> '';
  end
  else if grdPianif.medpColonna(AColumn).DataField = 'DATOLIBERO' then
  begin
    ACell.Hint:=ArrDatoLiberoGetDesc(ACell.Text,0, High(ArrDatoLibero));
    ACell.ShowHint:=ACell.Hint <> '';
  end;
  // assegnazione componenti
  if (ARow > 0) and (ARow <= High(grdPianif.medpCompGriglia) + 1) and (grdPianif.medpCompGriglia[ARow - 1].CompColonne[AColumn] <> nil) then
  begin
    ACell.Text:='';
    ACell.Control:=grdPianif.medpCompGriglia[ARow - 1].CompColonne[AColumn];
  end;
end;

procedure TW023FPianifOrari.DBGridColumnClick(ASender:TObject; const AValue:string);
begin
  cdsT080.Locate('DBG_ROWID',AValue,[]);
end;

procedure TW023FPianifOrari.DistruggiOggetti;
// distrugge componenti creati dinamicamente
begin
  grdPianif.medpClearCompGriglia;
  if GGetWebApplicationThreadVar.Data <> nil then
  begin
    R180CloseDataSetTag0(WR000DM.selT020);
    R180CloseDataSetTag0(WR000DM.selT080);
  end;
  SetLength(ArrOrari,0);
  SetLength(ArrDatoLibero,0);
  SetLength(ArrIndPresenza,0);
end;

end.
