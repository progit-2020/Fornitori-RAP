unit A023UAllTimbMW;

interface

uses
  A000UCostanti, R005UDataModuleMW, C180FunzioniGenerali,
  DateUtils, Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, OracleData, Oracle, Variants, Datasnap.DBClient,
  Generics.Collections;

type
  TDatiAnag = record
    Progressivo: Integer;
    Cognome: String;
    Nome: String;
    Matricola: String;
  end;

  TTimbratura = record
    DatiAnag: TDatiAnag;
    Data: TDateTime;
    Ora: TDateTime;
    Verso: String;
    Flag: String;
    Causale: String;
    Rowid: String;
  end;

  TRowIdSwap = record
    RowId1: String;
    RowId2: String;
  end;

  TA023FAllTimbMW = class(TR005FDataModuleMW)
    Q100: TOracleDataSet;
    Q100Upd: TOracleQuery;
    dsrT100: TDataSource;
    cdsT100: TClientDataSet;
    cdsT100DATA: TDateTimeField;
    cdsT100AUTOMATICO: TStringField;
    cdsT100ORA1: TDateTimeField;
    cdsT100VERSO1: TStringField;
    cdsT100FLAG1: TStringField;
    cdsT100ROWID1: TStringField;
    cdsT100ORA2: TDateTimeField;
    cdsT100VERSO2: TStringField;
    cdsT100FLAG2: TStringField;
    cdsT100ROWID2: TStringField;
    cdsT100D_ORA1: TStringField;
    cdsT100D_ORA2: TStringField;
    cdsT100CAUSALE1: TStringField;
    cdsT100CAUSALE2: TStringField;
    cdsT100PROGRESSIVO: TIntegerField;
    cdsT100COGNOME: TStringField;
    cdsT100NOME: TStringField;
    cdsT100MATRICOLA: TStringField;
    cdsT100D_NOMINATIVO: TStringField;
    procedure cdsT100CalcFields(DataSet: TDataSet);
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
    procedure Q100FilterRecord(DataSet: TDataSet; var Accept: Boolean);
  private
    LstRowIdSwapAuto: TList<TRowIdSwap>;
    FilterTimb1, FilterTimb2: TTimbratura;
  public
    class function GetDatiAnag: TDatiAnag; overload; static;
    class function GetDatiAnag(const PProgressivo: Integer; const PCognome, PNome,
      PMatricola: String): TDatiAnag; overload; static;
    function Timbratura(const PData: TDateTime; const POra: TDateTime; const PVerso: String;
      const PFlag: String; const PCausale: String; const PRowid: String): TTimbratura;
    procedure LeggiTimbratureUguali(const PDatiAnag: TDatiAnag;
      const PDataInizio, PDataFine: TDateTime; const PSvuotaClientDataset: Boolean);
    procedure Allinea(Prog:LongInt; Inizio,Fine:TDateTime; SoloVerifica:Boolean = False);
    function ScambiaTimbrature(PTimb1, PTimb2: TTimbratura; SoloVerifica:Boolean): TDateTime;
  end;

{$IFNDEF IRISWEB}
var
  A023FAllTimbMW: TA023FAllTimbMW;
{$ENDIF}

implementation

uses
  System.StrUtils;

{$R *.DFM}

procedure TA023FAllTimbMW.DataModuleCreate(Sender: TObject);
begin
  inherited;
  LstRowIdSwapAuto:=TList<TRowIdSwap>.Create;
end;

procedure TA023FAllTimbMW.DataModuleDestroy(Sender: TObject);
begin
  FreeAndNil(LstRowIdSwapAuto);
  inherited;
end;

procedure TA023FAllTimbMW.cdsT100CalcFields(DataSet: TDataSet);
var
  i: Integer;
  V, C, TimbFmt: String;
  H: TDateTime;
  function FormattaTimb(const PVerso: String; const POra: TDateTime; const PCausale: String): String;
  begin
    Result:=Format('%s %s%s',[PVerso,FormatDateTime('hh.mm',POra),IfThen(PCausale <> '',' (' + PCausale + ')')]);
  end;
begin
  DataSet.FieldByName('D_NOMINATIVO').AsString:=Format('%s %s',[DataSet.FieldByName('COGNOME').AsString,DataSet.FieldByName('NOME').AsString]);
  for i:=1 to 2 do
  begin
    V:=DataSet.FieldByName('VERSO' + i.ToString).AsString;
    H:=DataSet.FieldByName('ORA' + i.ToString).AsDateTime;
    C:=DataSet.FieldByName('CAUSALE' + i.ToString).AsString;
    TimbFmt:=FormattaTimb(V,H,C);
    DataSet.FieldByName('D_ORA' + i.ToString).AsString:=TimbFmt;
  end;
end;

class function TA023FAllTimbMW.GetDatiAnag: TDatiAnag;
begin
  Result.Progressivo:=0;
  Result.Cognome:='';
  Result.Nome:='';
  Result.Matricola:='';
end;

class function TA023FAllTimbMW.GetDatiAnag(const PProgressivo: Integer; const PCognome, PNome, PMatricola: String): TDatiAnag;
begin
  Result.Progressivo:=PProgressivo;
  Result.Cognome:=PCognome;
  Result.Nome:=PNome;
  Result.Matricola:=PMatricola;
end;

// MONDOEDP - MAN/02 SVILUPPO 106.ini
procedure TA023FAllTimbMW.LeggiTimbratureUguali(const PDatiAnag: TDatiAnag;
  const PDataInizio, PDataFine: TDateTime; const PSvuotaClientDataset: Boolean);
var
  TimbCorr, TimbPrec: TTimbratura;
  Scambia, Anomal: Boolean;
  RowIdTemp: TRowIdSwap;
begin
  // gestione clientdataset per allineamento manuale
  // se richiesto svuota il dataset client
  if PSvuotaClientDataset then
    cdsT100.EmptyDataSet;

  // esce se progressivo non valido
  if PDatiAnag.Progressivo <= 0 then
    Exit;

  // disabilita disegno interfaccia
  cdsT100.DisableControls;

  // apertura dataset timbrature dipendente nel periodo
  Q100.Close;
  Q100.SetVariable('Progressivo',PDatiAnag.Progressivo);
  Q100.SetVariable('Data1',PDataInizio);
  Q100.SetVariable('Data2',PDataFine);
  Q100.Open;

  // inizializzazione variabili
  Anomal:=False;
  TimbPrec.DatiAnag:=GetDatiAnag;
  TimbPrec.Data:=DATE_NULL;
  TimbPrec.Ora:=DATE_NULL;
  TimbPrec.Verso:='';
  TimbPrec.Flag:='';
  TimbPrec.Rowid:='';

  // ciclo su timbrature
  while not Q100.Eof do
  begin
    // imposta dati timbratura corrente
    TimbCorr.DatiAnag:=PDatiAnag;
    TimbCorr.Data:=Q100.FieldByName('Data').AsDateTime;
    TimbCorr.Ora:=Q100.FieldByName('Ora').AsDateTime;
    TimbCorr.Verso:=Q100.FieldByName('Verso').AsString;
    TimbCorr.Flag:=Q100.FieldByName('Flag').AsString;
    TimbCorr.Causale:=Q100.FieldByName('Causale').AsString;
    TimbCorr.Rowid:=Q100.RowID;

    if (TimbPrec.Data = TimbCorr.Data) and
       (R180OreMinuti(TimbPrec.Ora) = R180OreMinuti(TimbCorr.Ora)) then
    begin
      if (TimbPrec.Verso <> TimbCorr.Verso) then
      begin
        // inserimento riga sul clientdataset di appoggio
        cdsT100.Append;
        // dati dipendente
        cdsT100.FieldByName('PROGRESSIVO').AsInteger:=TimbCorr.DatiAnag.Progressivo;
        cdsT100.FieldByName('COGNOME').AsString:=TimbCorr.DatiAnag.Cognome;
        cdsT100.FieldByName('NOME').AsString:=TimbCorr.DatiAnag.Nome;
        cdsT100.FieldByName('MATRICOLA').AsString:=TimbCorr.DatiAnag.Matricola;
        // dati su swap
        cdsT100.FieldByName('AUTOMATICO').AsString:='N';
        cdsT100.FieldByName('DATA').AsDateTime:=TimbCorr.Data;
        // dati timbratura old
        cdsT100.FieldByName('ORA1').AsDateTime:=TimbPrec.Ora;
        cdsT100.FieldByName('VERSO1').AsString:=TimbPrec.Verso;
        cdsT100.FieldByName('FLAG1').AsString:=TimbPrec.Flag;
        cdsT100.FieldByName('CAUSALE1').AsString:=TimbPrec.Causale;
        cdsT100.FieldByName('ROWID1').AsString:=TimbPrec.Rowid;
        // dati timbratura new
        cdsT100.FieldByName('ORA2').AsDateTime:=TimbCorr.Ora;
        cdsT100.FieldByName('VERSO2').AsString:=TimbCorr.Verso;
        cdsT100.FieldByName('FLAG2').AsString:=TimbCorr.Flag;
        cdsT100.FieldByName('CAUSALE2').AsString:=TimbCorr.Causale;
        cdsT100.FieldByName('ROWID2').AsString:=TimbCorr.Rowid;
        cdsT100.Post;

        Anomal:=False;
      end
      else
      begin
        // anomalia: il verso della timbratura è uguale a quello precedente
        Anomal:=True;
      end;
    end;

    // salva i dati della timbratura precedente
    TimbPrec.DatiAnag:=TimbCorr.DatiAnag;
    TimbPrec.Data:=TimbCorr.Data;
    TimbPrec.Ora:=TimbCorr.Ora;
    TimbPrec.Verso:=TimbCorr.Verso;
    TimbPrec.Flag:=TimbCorr.Flag;
    TimbPrec.Causale:=TimbCorr.Causale;
    TimbPrec.Rowid:=TimbCorr.Rowid;

    Q100.Next;
  end;

  // richiama metodo di allineamento per determinare le righe che sarebbero scambiate automaticamente
  Allinea(PDatiAnag.Progressivo,PDataInizio,PdataFine,True);

  // imposta il flag automatico = S sulle righe che sarebbero scambiate automaticamente
  for RowIdTemp in LstRowIdSwapAuto do
  begin
    if cdsT100.Locate('ROWID1;ROWID2',VarArrayOf([RowIdTemp.RowId1,RowIdTemp.RowId2]),[]) then
    begin
      cdsT100.Edit;
      cdsT100.FieldByName('AUTOMATICO').AsString:='S';
      cdsT100.Post;
    end;
  end;

  // posizionamento sul primo record
  cdsT100.First;
  cdsT100.EnableControls;
end;
// MONDOEDP - MAN/02 SVILUPPO 106.fine

// MONDOEDP - MAN/02 SVILUPPO 106.ini
// filtro per controlli su function ScambiaTimbrature
procedure TA023FAllTimbMW.Q100FilterRecord(DataSet: TDataSet;
  var Accept: Boolean);
var
  Data, Ora: TDateTime;
  Verso, RI: String;
begin
  with (DataSet as TOracleDataSet) do
  begin
    Data:=FieldByName('DATA').AsDateTime;
    RI:=RowId;
    Ora:=FieldByName('ORA').AsDateTime;
    Verso:=FieldByName('VERSO').AsString;
  end;

  Accept:=(Data = FilterTimb1.Data) and
          (RI <> FilterTimb1.Rowid) and
          (RI <> FilterTimb2.Rowid) and
          (((Ora = FilterTimb1.Ora) and
            (Verso = FilterTimb2.Verso)) or
           ((Ora = FilterTimb2.Ora) and
            (Verso = FilterTimb1.Verso)));
end;
// MONDOEDP - MAN/02 SVILUPPO 106.fine

procedure TA023FAllTimbMW.Allinea(Prog:LongInt; Inizio,Fine:TDateTime; SoloVerifica:Boolean = False);
{Scorrimento delle timbrature da Inizio - 2 a Fine + 2
 Se ci sono due timbrature consecutive con stesso verso (anomalia), si considera la
 terza timbratura successiva: se queste ultime 2 hanno la stessa ora e verso diverso,
 si scambiano di posto aggiungendo 1 secondo alla prima delle 2 timbrature}
var VersoOld,FlagOld,VersoNew,FlagNew,T100RowIDOld,T100RowIDNew:String;
    DataOld,OraOld,DataNew,OraNew:TDateTime;
    Anomal:Boolean;
    RowIdTemp: TRowIdSwap;
begin
  // pulisce la lista di timbrature da scambiare, usata esternamente
  LstRowIdSwapAuto.Clear;

  // apertura dataset per progressivo e periodo
  Q100.Close;
  Q100.SetVariable('Progressivo',Prog);
  Q100.SetVariable('Data1',Inizio - 2);
  Q100.SetVariable('Data2',Fine + 2);
  Q100.Open;

  // inizializzazione variabili
  VersoOld:='';
  T100RowIDOld:='';
  DataOld:=0;
  OraOld:=0;
  Anomal:=False;

  // ciclo su dataset
  while not Q100.Eof do
  begin
    //Inizializzo la timbratura corrente
    VersoNew:=Q100.FieldByName('Verso').AsString;
    DataNew:=Q100.FieldByName('Data').AsDateTime;
    OraNew:=Q100.FieldByName('Ora').AsDateTime;
    FlagNew:=Q100.FieldByName('Flag').AsString;
    T100RowIDNew:=Q100.RowID;
    if Anomal then
    begin
      if (DataOld = Q100.FieldByName('Data').AsDateTime) and
         (R180OreMinuti(OraOld) = R180OreMinuti(Q100.FieldByName('Ora').AsDateTime)) and
         (VersoOld <> Q100.FieldByName('Verso').AsString) then
      begin
        //Scambio le due timbrature
        // MONDOEDP - MAN/02 SVILUPPO 106.ini

        // lo scambio timbrature avviene ora con nuova funzione
        //OraNew:=ScambiaTimbrature(T100RowIDOld,OraNew);//Passo OraNew invece che OraOld in modo che i secondi vengano incrementati partendo da OraNew, che è quella più avanti
        OraNew:=ScambiaTimbrature(Timbratura(DataOld,OraOld,VersoOld,FlagOld,'',T100RowIDOld),
                                  Timbratura(DataNew,OraNew,VersoNew,FlagNew,'',T100RowIDNew),
                                  SoloVerifica);

        // aggiunge i rowid scambiati ad una lista utilizzata esternamente
        RowIdTemp.RowId1:=T100RowIDOld;
        RowIdTemp.RowId2:=T100RowIDNew;
        LstRowIdSwapAuto.Add(RowIdTemp);
        // MONDOEDP - MAN/02 SVILUPPO 106.fine

        //Aggiorno la timbratura corrente che in questo caso è quella modificata
        VersoNew:=VersoOld;
        VersoOld:=Q100.FieldByName('Verso').AsString;
        DataNew:=DataOld;
        FlagNew:=FlagOld;
      end;
      Anomal:=False;
    end;
    if VersoOld = VersoNew then
    begin
      Anomal:=True;
      DataOld:=DataNew;
      OraOld:=OraNew;
      FlagOld:=FlagNew;
      T100RowIDOld:=T100RowIDNew;
    end;
    VersoOld:=VersoNew;
    Q100.Next;
  end;
end;

// MONDOEDP - MAN/02 SVILUPPO 106.ini
function TA023FAllTimbMW.ScambiaTimbrature(PTimb1, PTimb2: TTimbratura; SoloVerifica:Boolean): TDateTime;
// effettua scambio timbrature 1 e 2
var
  Sec1, Sec2: Word;
  EffettuaScambio: Boolean;
  Filtro: string;
  BM: TBookMark;
begin
  Result:=DATE_NULL;

  // PRE
  //   1. Ora1 e Ora2 sono uguali a meno dei secondi
  //   2. Ora1 <= Ora2
  Sec1:=SecondOf(PTimb1.Ora);
  Sec2:=SecondOf(PTimb2.Ora);

  // verifica se Ora1 = Ora2
  if Sec1 = Sec2 then
  begin
    // se i secondi sono uguali significa che Ora1 = Ora2
    // in questo caso modifica una delle due timbrature
    // in modo da forzare Ora1 < Ora2 per il successivo scambio
    if Sec1 = 59 then
    begin
      // decrementa ora1 di 1 secondo
      PTimb1.Ora:=IncSecond(PTimb1.Ora,-1);
    end
    else
    begin
      // incrementa ora2 di 1 secondo
      PTimb2.Ora:=IncSecond(PTimb2.Ora,1);
    end;
  end;

  if SoloVerifica then
  begin
    Result:=PTimb2.Ora;
  end
  else
  begin
    // *** blocco di codice per evitare rollback.ini
    //Alberto: per evitare update (che potrebbe essere soggetta a rollback) verificare prima che:
    //non esiste nessuna timbratura in Q100 con DATA = DATA_CORR and Ora = Ora1 , Verso = Verso2 e Rowid <> (T100RowID1,T100RowID2)
    //non esiste nessuna timbratura in Q100 con DATA = DATA_CORR and Ora = Ora2 , Verso = Verso1 e Rowid <> (T100RowID1,T100RowID2)
    //utilizzare il dataset esistente per le verifiche, senza effettuare ulteriore accesso al db

    // variabile che determina se è necessario eseguire l'update
    EffettuaScambio:=False;

    // imposta variabili per gestione di onfilterrecord
    FilterTimb1:=PTimb1;
    FilterTimb2:=PTimb2;

    BM:=Q100.GetBookmark;
    try
      // filtra il dataset con le regole sopra descritte (evento onfilterrecord)
      try
        Q100.Filtered:=True;
        if Q100.RecordCount = 0 then
          EffettuaScambio:=True;
      except
      end;
      Q100.Filtered:=False;
      if Q100.BookmarkValid(BM) then
        Q100.GotoBookmark(BM);
    except
    end;
    Q100.FreeBookmark(BM);
    // *** blocco di codice per evitare rollback.fine

    if EffettuaScambio then
    begin
      // effettua lo scambio delle due timbrature in 3 passaggi
      try
        // passaggio 1/3: aggiorna timbratura 1 (temporanea per swap)
        // utilizza correzione di 1 millisecondo per evitare dup key
        Q100Upd.SetVariable('ROW_ID',PTimb1.Rowid);
        Q100Upd.SetVariable('ORANEW',IncMillisecond(PTimb2.Ora,1));
        Q100Upd.Execute;

        // passaggio 2/3:aggiorna timbratura 2
        Q100Upd.SetVariable('ROW_ID',PTimb2.Rowid);
        Q100Upd.SetVariable('ORANEW',PTimb1.Ora);
        Q100Upd.Execute;

        // passaggio 3/3: reimposta timbratura 1
        Q100Upd.SetVariable('ROW_ID',PTimb1.Rowid);
        Q100Upd.SetVariable('ORANEW',PTimb2.Ora);
        Q100Upd.Execute;

        // committa operazione
        Q100Upd.Session.Commit;
        Result:=PTimb2.Ora;
      except
        // in caso di errore ripristina situazione precedente
        //Q100Upd.Session.RollBack; //Alberto: da non fare perchè utilizzato anche in IrisWEB
      end;
    end;
  end;
end;
// MONDOEDP - MAN/02 SVILUPPO 106.fine

function TA023FAllTimbMW.Timbratura(const PData, POra: TDateTime; const PVerso,
  PFlag, PCausale, PRowid: String): TTimbratura;
begin
  Result.Data:=PData;
  Result.Ora:=POra;
  Result.Verso:=PVerso;
  Result.Flag:=PFlag;
  Result.Causale:=PCausale;
  Result.Rowid:=PRowid;
end;

end.

