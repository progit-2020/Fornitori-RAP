unit A061UDettAssenzeMW;

interface

uses
  Windows, Messages, SysUtils, StrUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, R005UDataModuleMW, DB, OracleData, Oracle, DBClient,C180FunzioniGenerali,
  R600, Rp502Pro, USelI010, A000UCostanti, A000USessione, A000UInterfaccia,
  Generics.Collections, Math;

type
  TFamiliare = record  //Lorena 25/07/2005
    Codice:String;
    DataNas:TDateTime;
    GradoPar:String;
    TotGG:Real;
    TotMM:Integer;
    TotMMCont:Integer;
  end;

  TTotale = record
    Causale,Descrizione:String;
    Giorni:Real;
    Minuti:Integer;
    MinutiCont:Integer;
    Fam:array[1..50] of TFamiliare;  //Lorena 25/07/2005
  end;

  TRiduz = record
    UM:String;
    Percent:array[1..6] of Integer;
    Fruito:array[1..6] of Real;
  end;

  TRecCodDesc = record
    Codice, Descrizione:string;
  end;

  TA061FDettAssenzaMW = class(TR005FDataModuleMW)
    selT256: TOracleDataSet;
    GetCalendario: TOracleQuery;
    Q265: TOracleDataSet;
    D010: TDataSource;
    QGiustificativiAssenza: TOracleDataSet;
    TabellaStampa: TClientDataSet;
    selT255: TOracleDataSet;
    selT255COD_TIPOACCORPCAUSALI: TStringField;
    selT255DESCRIZIONE: TStringField;
    D255: TDataSource;
    selSG101DataFam: TOracleQuery;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
    procedure TabellaStampaBeforePost(DataSet: TDataSet);
  private
    R600DtM1:TR600DtM1;
    NumFamiliari:Word;
    CumuloFruito:array [1..6] of Real;
    FruitoInFasce:array [1..6] of Real;
    procedure LeggiRiduzioni(var Fruito:String);
    procedure DistribuzioneFasce(var Percent, UM: String);
    procedure CumulaPeriodi(var CumuloGiorni: Real; var CumuloMinuti, CumuloMinutiCont: Integer; var OldOper, OldCaus, Percent, TipoGiustOld, UM, InsDip, Coniuge, GGMinCont, CampoRagg: String; var DataDal, DataOld, DataNas, AData: TDateTime);
    procedure InserisciDipendenteDetGio(OldCausale, Coniuge, CampoRagg: String; DataNas, AData: TDateTime);
    procedure InserisciDipendente(CumuloGiorni: Real; CumuloMinuti, CumuloMinutiCont: Integer; DataDal, DataOld, DataNas: TDateTime; OldOper, OldCaus, Percent, TipoGiustOld, UM, Coniuge, CampoRagg: String);
    function SenzaRiduzioni: Boolean;
    function MinutiConteggiati(chkConteggiGGChecked: Boolean): Integer;
  public
    selI010:TselI010;
    R502ProDtM1:TR502ProDtM1;
    GGMinCont, CampoRagg: String;
    DocumentoPDF,TipoModulo:String; //CS=ClientServer, COM=COMServer
    PeriodoServizioChecked, SoloAssRegSuccChecked, DettGiornChecked,
    RiduzioniChecked, SoloRiduzioniChecked, ConteggiGGChecked,
    GiorniSignificativiChecked, CausaliCumulateChecked, ConiugeChecked: Boolean;
    AssenzeConsiderateItemIndex, ValidateItemIndex, OrdinamentoItemIndex, TipoDataFamItemIndex: Integer;
    DaRegStamp, ARegStamp: TDateTime;
    TotInd:array of TTotale;
    TotGrup:array of TTotale;
    TotGen:array of TTotale;
    TotRid:array of TRiduz;
    NumCausali:Integer;
    A061MW_LstCausali:TList<TRecCodDesc>;
    function GetCausali:String;
    procedure QuickSort(iLo, iHi: Integer);
    procedure ImpostaQueryGiustificativi(DaData, AData:TDateTime);
    procedure CreaTabellaStampa;
    procedure CreaSqlGiustificativi(ElencoCausali: String);
  end;

implementation

{$R *.dfm}

procedure TA061FDettAssenzaMW.DataModuleCreate(Sender: TObject);
begin
  if not SessioneOracle.Connected then
  begin
    Password(Application.Name);
    A000ParamDBOracle(SessioneOracle);
  end;
  inherited;
  selI010:=TselI010.Create(Self);
  selI010.Apri(SessioneOracle,Parametri.Layout,Parametri.Applicazione,'NOME_CAMPO,NOME_LOGICO,POSIZIONE','','NOME_LOGICO');
  D010.DataSet:=selI010;
  selT255.Open;
  Q265.SetVariable('COD_ACC','''''');
  Q265.Open;
  R600DtM1:=TR600DtM1.Create(Self);
  R502ProDtM1:=TR502ProDtM1.Create(nil);
  A061MW_LstCausali:=TList<TRecCodDesc>.create;
end;

procedure TA061FDettAssenzaMW.DataModuleDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(A061MW_LstCausali);
  FreeAndNil(selI010);
  FreeAndNil(R600DtM1);
  FreeAndNil(R502ProDtM1);
end;

{Implementazione Quick Sort per ordinamento timbrature}
procedure TA061FDettAssenzaMW.QuickSort(iLo, iHi: Integer);
var
  Lo, Hi: Integer;
  Mid:String;
  T:TTotale;
begin
  Lo:=iLo;
  Hi:=iHi;
  Mid:=TotInd[(Lo + Hi) div 2].Causale;
  repeat
    while TotInd[Lo].Causale < Mid do Inc(Lo);
    while TotInd[Hi].Causale > Mid do Dec(Hi);
    if Lo <= Hi then
    begin
      T:=TotInd[Lo];
      TotInd[Lo]:=TotInd[Hi];
      TotInd[Hi]:=T;
      Inc(Lo);
      Dec(Hi);
    end;
  until Lo > Hi;
  if Hi > iLo then QuickSort(iLo, Hi);
  if Lo < iHi then QuickSort(Lo, iHi);
end;

function TA061FDettAssenzaMW.GetCausali:String;
var
  i:Integer;
begin
  Result:='';
  NumCausali:=0;
  SetLength(TotInd,0);
  SetLength(TotGrup,0);
  SetLength(TotGen,0);
  SetLength(TotRid,0);
  for i:=0 to A061MW_LstCausali.Count - 1 do
  begin
    inc(NumCausali);
    SetLength(TotInd,NumCausali + 1);
    SetLength(TotGrup,NumCausali + 1);
    SetLength(TotGen,NumCausali + 1);
    SetLength(TotRid,NumCausali + 1);
    TotInd[NumCausali].Causale:=A061MW_LstCausali[i].Codice;
    TotInd[NumCausali].Descrizione:=A061MW_LstCausali[i].Descrizione;
    if Result <> '' then
      Result:=Result + ',';
    Result:=Result + '''' + A061MW_LstCausali[i].Codice + '''';
  end;
  if NumCausali > 0 then
    QuickSort(1,NumCausali);
  //Copio le causali sugli altri 2 vettori per totalizzazione
  for i:=1 to NumCausali do
  begin
    TotGrup[i]:=TotInd[i];
    TotGen[i]:=TotInd[i];
  end;
  //Ordinamento causali in base al codice
end;

procedure TA061FDettAssenzaMW.CreaTabellaStampa;
begin
  TabellaStampa.Close;
  TabellaStampa.FieldDefs.Clear;
  TabellaStampa.FieldDefs.Add('Gruppo',ftString,90,False);
  TabellaStampa.FieldDefs.Add('Cognome',ftString,60,False);
  TabellaStampa.FieldDefs.Add('Matricola',ftString,8,False);
  TabellaStampa.FieldDefs.Add('Data',ftDateTime,0,False);
  TabellaStampa.FieldDefs.Add('DataAl',ftDateTime,0,False);
  TabellaStampa.FieldDefs.Add('Causale',ftString,10,False);
  TabellaStampa.FieldDefs.Add('Descrizione',ftString,40,False);
  TabellaStampa.FieldDefs.Add('Operazione',ftString,4,False);
  TabellaStampa.FieldDefs.Add('Giorni',ftFloat,0,False);
  TabellaStampa.FieldDefs.Add('Minuti',ftInteger,0,False);
  TabellaStampa.FieldDefs.Add('Ore',ftString,7,False); //
  TabellaStampa.FieldDefs.Add('Familiare',ftString,10,False); //
  TabellaStampa.FieldDefs.Add('DataNas',ftDate);  //Lorena 26/07/2005
  TabellaStampa.FieldDefs.Add('GradoPar',ftString,2);  //Alberto 14/11/2010
  TabellaStampa.FieldDefs.Add('Inizio',ftDateTime,0,False);
  TabellaStampa.FieldDefs.Add('Fine',ftDateTime,0,False);
  TabellaStampa.FieldDefs.Add('Badge',ftString,8,False);
  TabellaStampa.FieldDefs.Add('Prog',ftAutoInc,0,False);
  TabellaStampa.FieldDefs.Add('Riduz',ftString,1,False);
  TabellaStampa.FieldDefs.Add('UM',ftString,1,False);
  TabellaStampa.FieldDefs.Add('Percent',ftString,30,False);
  TabellaStampa.FieldDefs.Add('Fruito',ftString,40,False);
  TabellaStampa.FieldDefs.Add('ValGio',ftInteger,0,False);
  TabellaStampa.FieldDefs.Add('MinutiCont',ftInteger,0,False); //Lorena 31/08/2011
  TabellaStampa.IndexDefs.Clear;
  TabellaStampa.IndexDefs.Add('Primario',('Gruppo;Cognome;Badge;Operazione;Data;Prog'),[ixUnique]);
  TabellaStampa.IndexDefs.Add('Secondario',('Gruppo;Cognome;Badge;Operazione;Causale;Data;Prog'),[ixUnique]);
  TabellaStampa.IndexName:=IfThen(OrdinamentoItemIndex = 1,'Secondario','Primario');
  TabellaStampa.CreateDataSet;
  TabellaStampa.FieldByName('COGNOME').DisplayLabel:='Nominativo';
  TabellaStampa.FieldByName('DATAAL').DisplayLabel:='Al';

  TabellaStampa.FieldByName('GRUPPO').DisplayLabel:='Raggruppamento';
  TabellaStampa.FieldByName('DATANAS').DisplayLabel:='Familiare';
  TabellaStampa.FieldByName('GRADOPAR').DisplayLabel:='Parentela';
  TabellaStampa.FieldByName('PERCENT').DisplayLabel:='Riduzione %';
  TabellaStampa.FieldByName('GRUPPO').DisplayWidth:=15;
  TabellaStampa.FieldByName('COGNOME').DisplayWidth:=35;
  TabellaStampa.FieldByName('DATA').DisplayWidth:=10;
  TabellaStampa.FieldByName('DATAAL').DisplayWidth:=10;
  TabellaStampa.FieldByName('INIZIO').DisplayWidth:=10;
  TabellaStampa.FieldByName('FINE').DisplayWidth:=10;
  TabellaStampa.FieldByName('GIORNI').DisplayWidth:=5;
  TabellaStampa.FieldByName('MINUTI').DisplayWidth:=5;
  TabellaStampa.FieldByName('PERCENT').DisplayWidth:=5;
  TabellaStampa.FieldByName('DATANAS').Visible:=False;
  //TabellaStampa.FieldByName('GRUPPO').Visible:=False;
  TabellaStampa.FieldByName('PROG').Visible:=False;
  TabellaStampa.FieldByName('BADGE').Visible:=False;
  TabellaStampa.FieldByName('RIDUZ').Visible:=False;
  TabellaStampa.FieldByName('UM').Visible:=False;
  TabellaStampa.FieldByName('PERCENT').Visible:=False;
  TabellaStampa.FieldByName('FRUITO').Visible:=False;
  TabellaStampa.FieldByName('VALGIO').Visible:=False;
  TabellaStampa.FieldByName('MINUTICONT').Visible:=False;
  TabellaStampa.LogChanges:=False;
end;

procedure TA061FDettAssenzaMW.InserisciDipendente(CumuloGiorni:Real;CumuloMinuti,CumuloMinutiCont: Integer;
  DataDal,DataOld,DataNas:TDateTime;OldOper,OldCaus,Percent,TipoGiustOld,UM,Coniuge,CampoRagg: String);
var S,Fruito:String;
begin
  S:=Format('%-5s',[OldCaus]);
  if NumFamiliari <> 0 then
  begin
    // TORINO_CSI - commessa 2015/142 SVILUPPO#7.ini
    // se l'utente ha scelto di visualizzare la data di nascita
    // del familiare, invece della data di riferimento,
    // allora il parametro DataNas è valorizzato con la data di nascita
    // ATTENZIONE!!!
    //   la suddetta affermazione sembra ridicola, ma nel caso normale
    //   DataNas è la data di riferimento, ovvero nvl(data_adozione,data_nascita)!!!
    //R600DtM1.RiferimentoDataNascita.Data:=DataNas;
    if TipoDataFamItemIndex = 0 then
    begin
      R600DtM1.RiferimentoDataNascita.Data:=DataNas;
    end
    else if TipoDataFamItemIndex = 1 then
    begin
      // in questo caso recupera la data di riferimento del familiare,
      // cercandolo per data di nascita
      try
        selSG101DataFam.SetVariable('PROGRESSIVO',SelAnagrafe.FieldByName('PROGRESSIVO').AsInteger);
        selSG101DataFam.SetVariable('DATANAS',DataNas);
        selSG101DataFam.Execute;
        R600DtM1.RiferimentoDataNascita.Data:=selSG101DataFam.FieldAsDate('DATA_FAM');
      except
        R600DtM1.RiferimentoDataNascita.Data:=DataNas;
      end;
    end;
    // TORINO_CSI - commessa 2015/142 SVILUPPO#7.fine
    R600DtM1.GetIDFamiliare(ProgressivoC700);
    S:=S + '#' + R600DtM1.RiferimentoDataNascita.IDFamiliare;
  end;
  if Coniuge <> '' then  //LORENA 15/07/2004
    S:=S + '^' + Coniuge;
  TabellaStampa.Insert;
  if CampoRagg <> '' then
    TabellaStampa.FieldByName('Gruppo').Value:=SelAnagrafe.FieldByName(CampoRagg).Value;
  TabellaStampa.FieldByName('Badge').Value:=SelAnagrafe.FieldByName('T430Badge').Value;
  TabellaStampa.FieldByName('Cognome').Value:=SelAnagrafe.FieldByName('Cognome').AsString + ' ' + SelAnagrafe.FieldByName('Nome').AsString;
  TabellaStampa.FieldByName('Matricola').Value:=SelAnagrafe.FieldByName('Matricola').Value;
  TabellaStampa.FieldByName('Inizio').Value:=SelAnagrafe.FieldByName('T430Inizio').Value;
  TabellaStampa.FieldByName('Fine').Value:=SelAnagrafe.FieldByName('T430Fine').Value;
  TabellaStampa.FieldByName('Data').Value:=DataDal;
  TabellaStampa.FieldByName('DataAl').Value:=DataOld;
  TabellaStampa.FieldByName('Causale').Value:=S;
  TabellaStampa.FieldByName('DataNas').Value:=DataNas;  //Lorena 26/07/2005
  if NumFamiliari <> 0 then
    TabellaStampa.FieldByName('GradoPar').Value:=R600DtM1.RiferimentoDataNascita.GradoPar;  //Alberto 14/11/2010
  TabellaStampa.FieldByName('Descrizione').Value:=VarToStr(Q265.Lookup('Codice',OldCaus,'Descrizione'));
  TabellaStampa.FieldByName('Riduz').AsString:='N';
  TabellaStampa.FieldByName('Giorni').AsFloat:=CumuloGiorni;
  TabellaStampa.FieldByName('Minuti').AsInteger:=CumuloMinuti;
  TabellaStampa.FieldByName('MinutiCont').AsInteger:=CumuloMinutiCont;  //Lorena 31/08/2011
  if RiduzioniChecked then
  begin
    TabellaStampa.FieldByName('Riduz').AsString:='S';
    TabellaStampa.FieldByName('UM').AsString:=UM;
    LeggiRiduzioni(Fruito);
    TabellaStampa.FieldByName('Percent').AsString:=Percent;
    TabellaStampa.FieldByName('Fruito').AsString:=Fruito;
  end;
  TabellaStampa.FieldByName('Operazione').AsString:=OldOper;
  TabellaStampa.Post;
end;

//Inserisci dipendente nel caso di dettaglio giornaliero
procedure TA061FDettAssenzaMW.InserisciDipendenteDetGio(OldCausale, Coniuge, CampoRagg: String; DataNas,AData: TDateTime);
var S,UM,CP,CC,CT,FP,FC,FT,R,Percent,Fruito:String;
    ValGio,Giorno:Integer;
    Giustif:TGiustificativo;
    i,xx:Integer;
    CausDiversa:Boolean;
    // TORINO_CSI - commessa 2015/142 SVILUPPO#7.ini
    LCampoDataFamRif: String;
    // TORINO_CSI - commessa 2015/142 SVILUPPO#7.fine
begin
  // TORINO_CSI - commessa 2015/142 SVILUPPO#7.ini
  if TipoDataFamItemIndex = 0 then
    LCampoDataFamRif:='DataNas'
  else
    LCampoDataFamRif:='FAM_DATANAS';
  // TORINO_CSI - commessa 2015/142 SVILUPPO#7.fine

  CausDiversa:=False;
  if OldCausale <> QGiustificativiAssenza.FieldByName('Causale').AsString then
  begin
    NumFamiliari:=0;
    Coniuge:='';  //LORENA 15/07/2004
    DataNas:=0;
    CausDiversa:=True;
    OldCausale:=QGiustificativiAssenza.FieldByName('Causale').AsString;
  end;
  // TORINO_CSI - commessa 2015/142 SVILUPPO#7.ini
  {
  if not QGiustificativiAssenza.FieldByName('DataNas').IsNull then
    if QGiustificativiAssenza.FieldByName('DataNas').AsDateTime <> DataNas then
  }
  if not QGiustificativiAssenza.FieldByName(LCampoDataFamRif).IsNull then
    if QGiustificativiAssenza.FieldByName(LCampoDataFamRif).AsDateTime <> DataNas then
  // TORINO_CSI - commessa 2015/142 SVILUPPO#7.fine
    begin
      inc(NumFamiliari);
      // TORINO_CSI - commessa 2015/142 SVILUPPO#7.ini
      //DataNas:=QGiustificativiAssenza.FieldByName('DataNas').AsDateTime;
      DataNas:=QGiustificativiAssenza.FieldByName(LCampoDataFamRif).AsDateTime;
      // TORINO_CSI - commessa 2015/142 SVILUPPO#7.fine
      CausDiversa:=True;
      R600DtM1.RiferimentoDataNascita.Data:=DataNas;
      R600DtM1.GetIDFamiliare(ProgressivoC700);
    end;
  if QGiustificativiAssenza.FieldByName('Coniuge').AsString <> '' then  //LORENA 15/07/2004
    Coniuge:=QGiustificativiAssenza.FieldByName('Causale').AsString;
  //Gestione assenze in riduzione
  if RiduzioniChecked then
  begin
    for xx:=Low(FruitoInFasce) to High(FruitoInFasce) do
    begin
      FruitoInFasce[xx]:=0;
      CumuloFruito[xx]:=0;
    end;
    Giustif.Inserimento:=False;
    Giustif.Modo:='I';
    Giustif.Causale:=QGiustificativiAssenza.FieldByName('Causale').AsString;
    R600DtM1.Progressivo:=0;
    R600DtM1.GetRiduzione(SelAnagrafe.FieldByName('PROGRESSIVO').AsInteger,QGiustificativiAssenza.FieldByName('Data').AsDateTime,AData,QGiustificativiAssenza.FieldByName('DataNas').AsDateTime,
                          Giustif,UM,CP,CC,CT,FP,FC,FT,R,ValGio,Giorno,CausDiversa);
    if not R600DtM1.EsisteRiduzione then
      exit;
    if R600DtM1.FasceDiRiduzione then
    begin
      if R600DtM1.ValCompTot = 0 then
        exit;
      if SoloRiduzioniChecked then
        if SenzaRiduzioni then
          exit;
      for i:=1 to 6 do
        CumuloFruito[i]:=(R600DtM1.CompetenzeOri[i] - R600DtM1.Competenze[i]);
    end
    else
    begin
      //Nel caso in cui c'e' solo 100% metto tutto il fruito in fascia 1
      if SoloRiduzioniChecked and (R600DtM1.Riduzioni[1] = 100) then
        exit;
      Percent:=IntToStr(R600DtM1.Riduzioni[1]) + ',0,0,0,0,0';
      if UM = 'G' then
        CumuloFruito[1]:=R600Dtm1.FruitoCorrGG
      else
        CumuloFruito[1]:=R600Dtm1.FruitoCorrHH;
    end;
    DistribuzioneFasce(Percent,UM);
  end;
  TabellaStampa.Insert;
  if CampoRagg <> '' then
    TabellaStampa.FieldByName('Gruppo').Value:=SelAnagrafe.FieldByName(CampoRagg).Value;
  TabellaStampa.FieldByName('Badge').Value:=SelAnagrafe.FieldByName('T430Badge').Value;
  TabellaStampa.FieldByName('Cognome').Value:=SelAnagrafe.FieldByName('Cognome').AsString + ' ' + SelAnagrafe.FieldByName('Nome').AsString;
  TabellaStampa.FieldByName('Matricola').Value:=SelAnagrafe.FieldByName('Matricola').Value;
  TabellaStampa.FieldByName('Inizio').Value:=SelAnagrafe.FieldByName('T430Inizio').Value;
  TabellaStampa.FieldByName('Fine').Value:=SelAnagrafe.FieldByName('T430Fine').Value;
  TabellaStampa.FieldByName('Data').Value:=QGiustificativiAssenza.FieldByName('Data').AsDateTime;
  TabellaStampa.FieldByName('Operazione').AsString:=QGiustificativiAssenza.FieldByName('Operazione').AsString;
  S:=Format('%-5s',[QGiustificativiAssenza.FieldByName('Causale').AsString]);
  TabellaStampa.FieldByName('Descrizione').Value:=VarToStr(Q265.Lookup('Codice',Trim(S),'Descrizione'));
  if NumFamiliari <> 0 then
    S:=S + '#' + R600DtM1.RiferimentoDataNascita.IDFamiliare;
  if QGiustificativiAssenza.FieldByName('Coniuge').AsString <> '' then  //LORENA 15/07/2004
    S:=S + '^' + QGiustificativiAssenza.FieldByName('Coniuge').AsString;
  TabellaStampa.FieldByName('Causale').Value:=S;
  TabellaStampa.FieldByName('DataNas').Value:=DataNas;  //Lorena 26/07/2005
  TabellaStampa.FieldByName('MinutiCont').AsInteger:=MinutiConteggiati(ConteggiGGChecked);  //Lorena 31/08/2011
  if RiduzioniChecked then
  begin
    TabellaStampa.FieldByName('Riduz').AsString:='S';
    TabellaStampa.FieldByName('UM').AsString:=UM;
    LeggiRiduzioni(Fruito);
    TabellaStampa.FieldByName('Percent').AsString:=Percent;
    TabellaStampa.FieldByName('Fruito').AsString:=Fruito;
    TabellaStampa.FieldByName('Giorni').AsFloat:=R600Dtm1.FruitoCorrGG;
    TabellaStampa.FieldByName('Minuti').AsInteger:=R600Dtm1.FruitoCorrHH;
  end
  else
  begin
    TabellaStampa.FieldByName('Riduz').AsString:='N';
    if QGiustificativiAssenza.FieldByName('TipoGiust').AsString = 'I' then
      TabellaStampa.FieldByName('Giorni').AsInteger:=1;
    if QGiustificativiAssenza.FieldByName('TipoGiust').AsString = 'M' then
      TabellaStampa.FieldByName('Giorni').AsFloat:=0.5;
    if QGiustificativiAssenza.FieldByName('TipoGiust').AsString = 'N' then
      TabellaStampa.FieldByName('Minuti').AsInteger:=QGiustificativiAssenza.FieldByName('DaOre').AsInteger;
    if QGiustificativiAssenza.FieldByName('TipoGiust').AsString = 'D' then
    begin
      if QGiustificativiAssenza.FieldByName('AOre').AsInteger > 0 then
        TabellaStampa.FieldByName('Minuti').AsInteger:=QGiustificativiAssenza.FieldByName('AOre').AsInteger - QGiustificativiAssenza.FieldByName('DaOre').AsInteger
      else
        TabellaStampa.FieldByName('Minuti').AsInteger:=1440 - QGiustificativiAssenza.FieldByName('DaOre').AsInteger;
    end;
  end;
  TabellaStampa.Post;
end;

procedure TA061FDettAssenzaMW.LeggiRiduzioni(var Fruito: String);
var i:Integer;
begin
  Fruito:='';
  for i:=1 to 6 do
  begin
    Fruito:=Fruito + '<' + FloatToStr(FruitoInFasce[i]) + '>';
  end;
end;

procedure TA061FDettAssenzaMW.DistribuzioneFasce(var Percent,UM:String);
var i:Integer;
    R,V:Real;
begin
  Percent:='';
  if UM = 'G' then
    V:=R600Dtm1.FruitoCorrGG
  else
    V:=R600Dtm1.FruitoCorrHH;
  for i:=6 downto 1 do
  begin
    if V = 0 then
      Break;
    R:=(R600DtM1.CompetenzeOri[i] - R600DtM1.Competenze[i]);
    if i >= 1 then
    begin
      if R > 0 then
      begin
        if R >= V then
        begin
          FruitoInFasce[i]:=FruitoInFasce[i] + V;
          V:=0;
        end
        else
        begin
          FruitoInFasce[i]:=FruitoInFasce[i] + R;
          V:=V - R;
        end;
      end
    end;
  end;
  for i:=1 to 6 do
  begin
    if Percent <> '' then
      Percent:=Percent + ',';
    Percent:=Percent + IntToStr(R600DtM1.Riduzioni[i]);
  end;
end;

//Legge assenza e cumula periodi
procedure TA061FDettAssenzaMW.CumulaPeriodi(var CumuloGiorni:Real; var CumuloMinuti,CumuloMinutiCont: Integer; var OldOper,OldCaus,Percent,TipoGiustOld,UM,InsDip,Coniuge,GGMinCont,CampoRagg: String; var DataDal,DataOld,DataNas,AData:TDateTime);
var
  CP,CC,CT,FP,FC,FT,R:String;
  ValGio,Giorno:Integer;
  Giustif:TGiustificativo;
  i,xx,GGVuoti,Num:integer;
  CausDiversa:Boolean;
  // TORINO_CSI - commessa 2015/142 SVILUPPO#7.ini
  LCampoDataFamRif: String;
  // TORINO_CSI - commessa 2015/142 SVILUPPO#7.fine
begin
  // TORINO_CSI - commessa 2015/142 SVILUPPO#7.ini
  if TipoDataFamItemIndex = 0 then
    LCampoDataFamRif:='DataNas'
  else
    LCampoDataFamRif:='FAM_DATANAS';
  // TORINO_CSI - commessa 2015/142 SVILUPPO#7.fine

  //Se prima causale del dipendente...
  if OldCaus = '' then
  begin
    CausDiversa:=True;
    InsDip:='S';
    CumuloGiorni:=0;
    CumuloMinuti:=0;
    CumuloMinutiCont:=0;  //Lorena 31/08/2011
    for xx:=Low(FruitoInFasce) to High(FruitoInFasce) do
    begin
      FruitoInFasce[xx]:=0;
      CumuloFruito[xx]:=0;
    end;
    DataDal:=QGiustificativiAssenza.FieldByName('Data').AsDateTime;
    OldCaus:=QGiustificativiAssenza.FieldByName('Causale').AsString;
    OldOper:=QGiustificativiAssenza.FieldByName('Operazione').AsString;
    DataOld:=QGiustificativiAssenza.FieldByName('Data').AsDateTime;
    TipoGiustOld:=QGiustificativiAssenza.FieldByName('TipoGiust').AsString;
    // TORINO_CSI - commessa 2015/142 SVILUPPO#7.ini
    //if not QGiustificativiAssenza.FieldByName('DataNas').IsNull then
    if not QGiustificativiAssenza.FieldByName(LCampoDataFamRif).IsNull then
    // TORINO_CSI - commessa 2015/142 SVILUPPO#7.fine
    begin
      // TORINO_CSI - commessa 2015/142 SVILUPPO#7.ini
      //DataNas:=QGiustificativiAssenza.FieldByName('DataNas').AsDateTime;
      DataNas:=QGiustificativiAssenza.FieldByName(LCampoDataFamRif).AsDateTime;
      // TORINO_CSI - commessa 2015/142 SVILUPPO#7.fine
      inc(NumFamiliari);
    end;
    if QGiustificativiAssenza.FieldByName('Coniuge').AsString <> '' then  //LORENA 15/07/2004
      Coniuge:=QGiustificativiAssenza.FieldByName('Coniuge').AsString;
  end
  else
  begin
    //Controllo continuità in base ai Giorni di significatività della causale   //LORENA 13/01/2006
    if (DataOld <> QGiustificativiAssenza.FieldByName('Data').AsDateTime) and
       (DataOld + 1 <> QGiustificativiAssenza.FieldByName('Data').AsDateTime) and
       (OldCaus = QGiustificativiAssenza.FieldByName('Causale').AsString) and
       (TipoGiustOld = QGiustificativiAssenza.FieldByName('TipoGiust').AsString) and
       // TORINO_CSI - commessa 2015/142 SVILUPPO#7.ini
       {
       ((QGiustificativiAssenza.FieldByName('DataNas').IsNull) or
       (DataNas = QGiustificativiAssenza.FieldByName('DataNas').AsDateTime)) and
       }
       ((QGiustificativiAssenza.FieldByName(LCampoDataFamRif).IsNull) or
       (DataNas = QGiustificativiAssenza.FieldByName(LCampoDataFamRif).AsDateTime)) and
       // TORINO_CSI - commessa 2015/142 SVILUPPO#7.fine
       (not(SoloAssRegSuccChecked) or
       (OldOper = QGiustificativiAssenza.FieldByName('Operazione').AsString)) and
       (Coniuge = QGiustificativiAssenza.FieldByName('Coniuge').AsString) then
    begin
      GGVuoti:=0;
      Num:=Trunc(QGiustificativiAssenza.FieldByName('Data').AsDateTime - (DataOld + 1));
      //Ciclo per tutti i giorni tra DataOld e Data
      for i:=1 to Num do
      begin
        if (VarToStr(Q265.Lookup('CODICE',OldCaus,'GSIGNIFIC')) = 'GC') or //GG.calendario
           (not GiorniSignificativiChecked) then  //Alberto 20/02/2007
          Break
        else
        begin
          if VarToStr(Q265.Lookup('CODICE',OldCaus,'GSIGNIFIC')) = 'G6' then  //Da lunedì a sabato
          begin
            if DayOfWeek(DataOld + i) = 1 then //Domenica
              GGVuoti:=GGVuoti+1
            else
            begin
              GGVuoti:=0;
              Break;
            end;
          end
          else  //GSIGNIFIC = 'EF' - 'GL' - 'GT'
          begin
            Giustif.Inserimento:=False;
            Giustif.Modo:='I';
            Giustif.Causale:=OldCaus;
            R600DtM1.Progressivo:=0;
            R600DtM1.SettaConteggi(SelAnagrafe.FieldByName('PROGRESSIVO').AsInteger,DataOld+i,DataOld+i,Giustif);
            if R600DtM1.GiornoSignificativo(DataOld+i) <> mrOk then
              GGVuoti:=GGVuoti+1
            else
            begin
              GGVuoti:=0;
              Break;
            end;
          end;
        end;
      end;
      DataOld:=DataOld+GGVuoti;
    end;
    //Se stessa assenza della precedente...
    if (OldCaus = QGiustificativiAssenza.FieldByName('Causale').AsString) and
       ((DataOld = QGiustificativiAssenza.FieldByName('Data').AsDateTime) or
        (DataOld + 1 = QGiustificativiAssenza.FieldByName('Data').AsDateTime)) and
       (TipoGiustOld = QGiustificativiAssenza.FieldByName('TipoGiust').AsString) and
       // TORINO_CSI - commessa 2015/142 SVILUPPO#7.ini
       {
       ((QGiustificativiAssenza.FieldByName('DataNas').IsNull) or
        (DataNas = QGiustificativiAssenza.FieldByName('DataNas').AsDateTime)) and
       }
       ((QGiustificativiAssenza.FieldByName(LCampoDataFamRif).IsNull) or
        (DataNas = QGiustificativiAssenza.FieldByName(LCampoDataFamRif).AsDateTime)) and
       // TORINO_CSI - commessa 2015/142 SVILUPPO#7.fine
       (not(SoloAssRegSuccChecked) or
        (OldOper = QGiustificativiAssenza.FieldByName('Operazione').AsString)) and
       (Coniuge = QGiustificativiAssenza.FieldByName('Coniuge').AsString) then //LORENA 15/07/2004
    begin
      DataOld:=QGiustificativiAssenza.FieldByName('Data').AsDateTime;
      InsDip:='S';
      CausDiversa:=False;
    end
    else
    //Cambia assenza: registro i dati per la stampa e memorizzo nuovi dati
    begin
      CausDiversa:=True;
      if InsDip = 'S' then
        if ((StrToIntDef(GGMinCont,0) > 0) and (CumuloGiorni >= StrToIntDef(GGMinCont,0))) or
           (StrToIntDef(GGMinCont,0) <= 0) then
          InserisciDipendente(CumuloGiorni,CumuloMinuti,CumuloMinutiCont,DataDal,DataOld,DataNas,OldOper,OldCaus,Percent,TipoGiustOld,UM,Coniuge, CampoRagg);
      InsDip:='S';
      CumuloGiorni:=0;
      CumuloMinuti:=0;
      CumuloMinutiCont:=0;  //Lorena 31/08/2011
      Coniuge:=''; //LORENA 15/07/2004
      for xx:=Low(FruitoInFasce) to High(FruitoInFasce) do
      begin
        FruitoInFasce[xx]:=0;
        CumuloFruito[xx]:=0;
      end;
      if OldCaus <> QGiustificativiAssenza.FieldByName('Causale').AsString then
      begin
        NumFamiliari:=0;
        DataNas:=0;
      end;
      // TORINO_CSI - commessa 2015/142 SVILUPPO#7.ini
      {
      if not QGiustificativiAssenza.FieldByName('DataNas').IsNull then
        if DataNas <> QGiustificativiAssenza.FieldByName('DataNas').AsDateTime then
      }
      if not QGiustificativiAssenza.FieldByName(LCampoDataFamRif).IsNull then
        if DataNas <> QGiustificativiAssenza.FieldByName(LCampoDataFamRif).AsDateTime then
      // TORINO_CSI - commessa 2015/142 SVILUPPO#7.fine
          inc(NumFamiliari);
      if QGiustificativiAssenza.FieldByName('Coniuge').AsString <> '' then  //LORENA 15/07/2004
        Coniuge:=QGiustificativiAssenza.FieldByName('Coniuge').AsString;
      DataDal:=QGiustificativiAssenza.FieldByName('Data').AsDateTime;
      OldCaus:=QGiustificativiAssenza.FieldByName('Causale').AsString;
      OldOper:=QGiustificativiAssenza.FieldByName('Operazione').AsString;
      DataOld:=QGiustificativiAssenza.FieldByName('Data').AsDateTime;
      TipoGiustOld:=QGiustificativiAssenza.FieldByName('TipoGiust').AsString;
      // TORINO_CSI - commessa 2015/142 SVILUPPO#7.ini
      //DataNas:=QGiustificativiAssenza.FieldByName('DataNas').AsDateTime;
      DataNas:=QGiustificativiAssenza.FieldByName(LCampoDataFamRif).AsDateTime;
      // TORINO_CSI - commessa 2015/142 SVILUPPO#7.fine
    end;
  end;

  CumuloMinutiCont:=CumuloMinutiCont+MinutiConteggiati(ConteggiGGChecked);  //Lorena 31/08/2011

  //Gestione assenze in riduzione
  if RiduzioniChecked then
  begin
    Giustif.Inserimento:=False;
    Giustif.Modo:='I';
    Giustif.Causale:=OldCaus;
    R600DtM1.Progressivo:=0;
    R600DtM1.GetRiduzione(SelAnagrafe.FieldByName('PROGRESSIVO').AsInteger,DataOld,AData,DataNas,
                          Giustif,UM,CP,CC,CT,FP,FC,FT,R,ValGio,Giorno,CausDiversa);
    if not R600DtM1.EsisteRiduzione then
    begin
      InsDip:='N';
      exit;
    end;
    if UM = 'G' then
      CumuloGiorni:=CumuloGiorni+R600Dtm1.FruitoCorrGG
    else
      CumuloMinuti:=CumuloMinuti+R600Dtm1.FruitoCorrHH;
    if R600DtM1.FasceDiRiduzione then
    begin
      if R600DtM1.ValCompTot = 0 then
        InsDip:='N';
      if SoloRiduzioniChecked then
        if SenzaRiduzioni then
          InsDip:='N';
      for i:=1 to 6 do
      begin
        CumuloFruito[i]:=(R600DtM1.CompetenzeOri[i] - R600DtM1.Competenze[i]);
      end;
    end
    else
    begin
      //Nel caso in cui c'e' solo 100% metto tutto il fruito in fascia 1
      if SoloRiduzioniChecked and (R600DtM1.Riduzioni[1] = 100) then
        InsDip:='N';
      Percent:=IntToStr(R600DtM1.Riduzioni[1]) + ',0,0,0,0,0';
      if UM = 'G' then
        CumuloFruito[1]:=CumuloGiorni
      else
        CumuloFruito[1]:=CumuloMinuti;
    end;
    DistribuzioneFasce(Percent,UM);
  end
  else
  begin
    //Cumulo i valori per tutte le assenze continuate
    if not SoloAssRegSuccChecked then
    begin
      if QGiustificativiAssenza.FieldByName('TipoGiust').AsString = 'I' then
        CumuloGiorni:=CumuloGiorni + 1;
      if QGiustificativiAssenza.FieldByName('TipoGiust').AsString = 'M' then
        CumuloGiorni:=CumuloGiorni + 0.5;
      if QGiustificativiAssenza.FieldByName('TipoGiust').AsString = 'N' then
        CumuloMinuti:=CumuloMinuti + QGiustificativiAssenza.FieldByName('DaOre').AsInteger;
      if QGiustificativiAssenza.FieldByName('TipoGiust').AsString = 'D' then
      begin
        if QGiustificativiAssenza.FieldByName('AOre').AsInteger > 0 then
          CumuloMinuti:=CumuloMinuti + QGiustificativiAssenza.FieldByName('AOre').AsInteger - QGiustificativiAssenza.FieldByName('DaOre').AsInteger
        else
          CumuloMinuti:=CumuloMinuti + 1440 - QGiustificativiAssenza.FieldByName('DaOre').AsInteger;
      end;
    end
    else
    begin
      //Nel caso di assenze filtrate dalla data di registrazione e quindi lette da T044, dato che possono essere
      //sommati record con stesse caratteristiche di inserimento per il cumulo di giorni e ore devo utilizzare
      //il campo TOT_QUANT che contiene già la quantità moltiplicata per il numero delle sue ripetizioni
      if QGiustificativiAssenza.FieldByName('TipoGiust').AsString = 'I' then
        CumuloGiorni:=CumuloGiorni+QGiustificativiAssenza.FieldByName('TOT_QUANT').AsInteger;
      if QGiustificativiAssenza.FieldByName('TipoGiust').AsString = 'M' then
        CumuloGiorni:=CumuloGiorni+(QGiustificativiAssenza.FieldByName('TOT_QUANT').AsInteger/2);
      if (QGiustificativiAssenza.FieldByName('TipoGiust').AsString = 'N') or
         (QGiustificativiAssenza.FieldByName('TipoGiust').AsString = 'D') then
        CumuloMinuti:=CumuloMinuti+QGiustificativiAssenza.FieldByName('TOT_QUANT').AsInteger;
    end;
  end;
end;

procedure TA061FDettAssenzaMW.CreaSqlGiustificativi(ElencoCausali:String);
var StrSQL: String;
begin
  with QGiustificativiAssenza do
  begin
    if Active then
      CloseAll;
    DeleteVariables;
    SQL.Clear;
    if not SoloAssRegSuccChecked then
    begin
      if ValidateItemIndex <> 2 then
      begin
        StrSQL:=' T265.VALIDAZIONE = ''S'' AND ';
        if ValidateItemIndex = 0 then
          StrSQL:=StrSQL + 'NVL(T040.SCHEDA,''*'') <> ''V'' AND '
        else if ValidateItemIndex = 1 then
          StrSQL:=StrSQL + ' T040.SCHEDA = ''V'' AND ';
      end;

      SQL.Add('SELECT /*+ INDEX(T040_GIUSTIFICATIVI T040_DATANAS)*/');
      if CausaliCumulateChecked then //LORENA 30/03/2005
        // TORINO_CSI - commessa 2015/142 SVILUPPO#7.ini
        //SQL.Add('''Ins.'' OPERAZIONE,DATA,''*'' CAUSALE,-1 PROGRCAUSALE,TO_DATE(''01011900'',''DDMMYYYY'') DATANAS,TIPOGIUST,TO_CHAR(DAORE,''SSSSS'')/60 DAORE,TO_CHAR(AORE,''SSSSS'')/60 AORE,'''' CONIUGE') //LORENA 30/03/2005
        // TORINO_CSI - commessa 2015/142 SVILUPPO#7.fine
        SQL.Add('''Ins.'' OPERAZIONE,DATA,''*'' CAUSALE,-1 PROGRCAUSALE,TO_DATE(''01011900'',''DDMMYYYY'') DATANAS,' +
                'TO_DATE(''01011900'',''DDMMYYYY'') FAM_DATANAS,TO_DATE(''01011900'',''DDMMYYYY'') FAM_DATAADOZ,TIPOGIUST,CSI_TIPO_MG,TO_CHAR(DAORE,''SSSSS'')/60 DAORE,TO_CHAR(AORE,''SSSSS'')/60 AORE,'''' CONIUGE') //LORENA 30/03/2005
      else
        // TORINO_CSI - commessa 2015/142 SVILUPPO#7.ini
        //SQL.Add('''Ins.'' OPERAZIONE,DATA,CAUSALE,PROGRCAUSALE,DATANAS,TIPOGIUST,TO_CHAR(DAORE,''SSSSS'')/60 DAORE,TO_CHAR(AORE,''SSSSS'')/60 AORE,'''' CONIUGE'); //LORENA 15/07/2004
        SQL.Add('''Ins.'' OPERAZIONE,DATA,CAUSALE,PROGRCAUSALE,DATANAS,USR_SG101_GETDATANASCITA(T040.PROGRESSIVO,T040.DATANAS) FAM_DATANAS,' +
                'USR_SG101_GETDATAADOZIONE(T040.PROGRESSIVO,T040.DATANAS) FAM_DATAADOZ,TIPOGIUST,CSI_TIPO_MG,TO_CHAR(DAORE,''SSSSS'')/60 DAORE,TO_CHAR(AORE,''SSSSS'')/60 AORE,'''' CONIUGE'); //LORENA 15/07/2004
        // TORINO_CSI - commessa 2015/142 SVILUPPO#7.fine
      SQL.Add('FROM T040_GIUSTIFICATIVI T040,T265_CAUASSENZE T265');
      SQL.Add('WHERE T040.PROGRESSIVO = :PROGRESSIVO AND');
      SQL.Add('T040.DATA BETWEEN :DATA1 AND :DATA2 AND');
      if PeriodoServizioChecked then
        SQL.Add('T040.DATA BETWEEN :INIZIO AND :FINE AND');
      SQL.Add(StrSQL);
      SQL.Add('T040.CAUSALE IN (' + ElencoCausali + ') AND');
      SQL.Add('T040.CAUSALE = T265.CODICE');
      if ConiugeChecked then  //LORENA 15/07/2004
      begin
        SQL.Add('UNION');
        SQL.Add('SELECT /*+ INDEX(T040_GIUSTIFICATIVI T040_DATANAS)*/');
        if CausaliCumulateChecked then //LORENA 30/03/2005
          // TORINO_CSI - commessa 2015/142 SVILUPPO#7.ini
          //SQL.Add('''Ins.'' OPERAZIONE,T040.DATA,''*'' CAUSALE,-1 PROGRCAUSALE,TO_DATE(''01011900'',''DDMMYYYY'') DATANAS,T040.TIPOGIUST,to_char(T040.DAORE,''SSSSS'')/60 DAORE,to_char(T040.AORE,''SSSSS'')/60 AORE, ''I'' CONIUGE')//LORENA 30/03/2005
          SQL.Add('''Ins.'' OPERAZIONE,T040.DATA,''*'' CAUSALE,-1 PROGRCAUSALE,TO_DATE(''01011900'',''DDMMYYYY'') DATANAS,' +
                  'TO_DATE(''01011900'',''DDMMYYYY'') FAM_DATANAS,TO_DATE(''01011900'',''DDMMYYYY'') FAM_DATAADOZ,T040.TIPOGIUST,T040.CSI_TIPO_MG,to_char(T040.DAORE,''SSSSS'')/60 DAORE,to_char(T040.AORE,''SSSSS'')/60 AORE, ''I'' CONIUGE')//LORENA 30/03/2005
          // TORINO_CSI - commessa 2015/142 SVILUPPO#7.fine
        else
          // TORINO_CSI - commessa 2015/142 SVILUPPO#7.ini
          //SQL.Add('''Ins.'' OPERAZIONE,T040.DATA,T040.CAUSALE,T040.PROGRCAUSALE,T040.DATANAS,T040.TIPOGIUST,to_char(T040.DAORE,''SSSSS'')/60 DAORE,to_char(T040.AORE,''SSSSS'')/60 AORE, ''I'' CONIUGE');
          SQL.Add('''Ins.'' OPERAZIONE,T040.DATA,T040.CAUSALE,T040.PROGRCAUSALE,T040.DATANAS,USR_SG101_GETDATANASCITA(T040.PROGRESSIVO,T040.DATANAS) FAM_DATANAS,' +
                  'USR_SG101_GETDATAADOZIONE(T040.PROGRESSIVO,T040.DATANAS) FAM_DATAADOZ,T040.TIPOGIUST,T040.CSI_TIPO_MG,to_char(T040.DAORE,''SSSSS'')/60 DAORE,to_char(T040.AORE,''SSSSS'')/60 AORE, ''I'' CONIUGE');
          // TORINO_CSI - commessa 2015/142 SVILUPPO#7.fine
        SQL.Add('FROM T040_GIUSTIFICATIVI T040,T265_CAUASSENZE T265, SG101_FAMILIARI SG101, T030_ANAGRAFICO T030');
        SQL.Add('WHERE SG101.PROGRESSIVO = :PROGRESSIVO AND');
        SQL.Add('SG101.GRADOPAR in (''CG'',''AL'') AND');
        SQL.Add('SG101.MATRICOLA = T030.MATRICOLA AND');
        SQL.Add('T040.PROGRESSIVO = T030.PROGRESSIVO AND');
        SQL.Add(StrSQL);
        SQL.Add('T040.DATA BETWEEN :DATA1 AND :DATA2 AND');
        SQL.Add('T040.DATANAS in (select /*+ unnest */ nvl(DATAADOZ,DATANAS) from SG101_FAMILIARI where PROGRESSIVO = :PROGRESSIVO and GRADOPAR = ''FG'') and');
        if PeriodoServizioChecked then
          SQL.Add('DATA BETWEEN :INIZIO AND :FINE AND');
        SQL.Add('T040.CAUSALE IN (' + ElencoCausali + ') AND');
        SQL.Add('T040.CAUSALE = T265.CODICE');
        SQL.Add('UNION');
        SQL.Add('SELECT /*+ INDEX(T040_GIUSTIFICATIVI T040_DATANAS)*/');
        if CausaliCumulateChecked then //LORENA 30/03/2005
          // TORINO_CSI - commessa 2015/142 SVILUPPO#7.ini
          //SQL.Add('''Ins.'' OPERAZIONE,T046.DATA,''*'' CAUSALE,-1 PROGRCAUSALE,TO_DATE(''01011900'',''DDMMYYYY'') DATANAS,T046.TIPOGIUST,OREMINUTI(T046.DAORE) DAORE,OREMINUTI(T046.AORE) AORE,''E'' CONIUGE')//LORENA 30/03/2005
          SQL.Add('''Ins.'' OPERAZIONE,T046.DATA,''*'' CAUSALE,-1 PROGRCAUSALE,TO_DATE(''01011900'',''DDMMYYYY'') DATANAS,' +
                  'TO_DATE(''01011900'',''DDMMYYYY'') FAM_DATANAS,TO_DATE(''01011900'',''DDMMYYYY'') FAM_DATAADOZ,T046.TIPOGIUST,null,OREMINUTI(T046.DAORE) DAORE,OREMINUTI(T046.AORE) AORE,''E'' CONIUGE')//LORENA 30/03/2005
          // TORINO_CSI - commessa 2015/142 SVILUPPO#7.fine
        else
          // TORINO_CSI - commessa 2015/142 SVILUPPO#7.ini
          //SQL.Add('''Ins.'' OPERAZIONE,T046.DATA,T046.CAUSALE,-1 PROGRCAUSALE,T046.DATANAS,T046.TIPOGIUST,OREMINUTI(T046.DAORE) DAORE,OREMINUTI(T046.AORE) AORE,''E'' CONIUGE');
          SQL.Add('''Ins.'' OPERAZIONE,T046.DATA,T046.CAUSALE,-1 PROGRCAUSALE,T046.DATANAS,USR_SG101_GETDATANASCITA(T046.PROGRESSIVO,T046.DATANAS) FAM_DATANAS,' +
                  'USR_SG101_GETDATAADOZIONE(T046.PROGRESSIVO,T046.DATANAS) FAM_DATAADOZ,T046.TIPOGIUST,null,OREMINUTI(T046.DAORE) DAORE,OREMINUTI(T046.AORE) AORE,''E'' CONIUGE');
          // TORINO_CSI - commessa 2015/142 SVILUPPO#7.fine
        SQL.Add('FROM T046_GIUSTIFICATIVIFAMILIARI T046,T265_CAUASSENZE T265, SG101_FAMILIARI SG101');
        SQL.Add('WHERE ');
        SQL.Add('T046.PROGRESSIVO = :PROGRESSIVO AND');
        SQL.Add('T046.DATA BETWEEN :DATA1 AND :DATA2 AND');
        if PeriodoServizioChecked then
          SQL.Add('DATA BETWEEN :INIZIO AND :FINE AND');
        SQL.Add('T046.CAUSALE IN (' + ElencoCausali + ') AND');
        SQL.Add('T046.CAUSALE = T265.CODICE');
      end;
      SQL.Add('ORDER BY CAUSALE,DATANAS,CONIUGE,DATA');
      DeclareVariable('DATA1',otDate);
      DeclareVariable('DATA2',otDate);
      if PeriodoServizioChecked then
      begin
        DeclareVariable('Inizio',otDate);
        DeclareVariable('Fine',otDate);
      end;
    end
    else
    begin
      // TORINO_CSI - commessa 2015/142 SVILUPPO#7.ini
      //SQL.Add('SELECT NREC, OPERAZIONE,CAUSALE,DATA,DATANAS,TIPOGIUST,TO_CHAR(DAORE,''SSSSS'')/60 DAORE,TO_CHAR(AORE,''SSSSS'')/60 AORE,QUANTITA,QUANTITA*NREC TOT_QUANT,'''' CONIUGE FROM ');
      SQL.Add('SELECT NREC, OPERAZIONE,CAUSALE,DATA,DATANAS,USR_SG101_GETDATANASCITA(:PROGRESSIVO,DATANAS) FAM_DATANAS,USR_SG101_GETDATAADOZIONE(:PROGRESSIVO,DATANAS) FAM_DATAADOZ,' +
              'TIPOGIUST,TO_CHAR(DAORE,''SSSSS'')/60 DAORE,TO_CHAR(AORE,''SSSSS'')/60 AORE,QUANTITA,QUANTITA*NREC TOT_QUANT,'''' CONIUGE FROM ');
      // TORINO_CSI - commessa 2015/142 SVILUPPO#7.fine
      SQL.Add('(SELECT ABS(SUM(NREC)) NREC,DECODE(SIGN(SUM(NREC)),1,''Ins.'',0,''Ins.'',-1,''Can.'') OPERAZIONE,CAUSALE,DATA,DATANAS, ');
      SQL.Add('       TIPOGIUST,DAORE,AORE, ');
      SQL.Add('       DECODE(TIPOGIUST,''D'',decode(OREMINUTI(TO_CHAR(AORE,''HH24.MI'')),0,1440,OREMINUTI(TO_CHAR(AORE,''HH24.MI''))) - OREMINUTI(TO_CHAR(DAORE,''HH24.MI'')), ');
      SQL.Add('              ''N'',OREMINUTI(TO_CHAR(DAORE,''HH24.MI'')),1) QUANTITA FROM ');
      SQL.Add('  (');
      SQL.Add('  SELECT COUNT(*) NREC,CAUSALE,DATA,DATANAS,TIPOGIUST,DAORE,AORE,''Ins.'' OPE FROM T044_STORICOGIUSTIFICATIVI T044 WHERE ');
      SQL.Add('    T044.PROGRESSIVO = :Progressivo ');
      SQL.Add('    AND TRUNC(DATA_AGG) BETWEEN :DaRegStamp AND :ARegStamp ');
      if PeriodoServizioChecked then
        SQL.Add('  AND DATA BETWEEN :INIZIO AND :FINE');
      SQL.Add('    AND EXISTS (SELECT ''X'' FROM T430_STORICO WHERE PROGRESSIVO = T044.PROGRESSIVO ');
      SQL.Add('                AND T044.DATA BETWEEN INIZIO AND NVL(FINE,TO_DATE(''31123999'',''DDMMYYYY'')))' );
      SQL.Add('    AND OPERAZIONE =''I''' );
      SQL.Add('    GROUP BY CAUSALE,DATA,DATANAS,TIPOGIUST,DAORE,AORE' );
      SQL.Add('  UNION ');
      SQL.Add('  SELECT (COUNT(*)*-1) NREC,CAUSALE,DATA,DATANAS,TIPOGIUST,DAORE,AORE,''Can.'' OPE FROM T044_STORICOGIUSTIFICATIVI T044 WHERE ');
      SQL.Add('    T044.PROGRESSIVO = :Progressivo ');
      SQL.Add('    AND TRUNC(DATA_AGG) BETWEEN :DaRegStamp AND :ARegStamp ');
      if PeriodoServizioChecked then
        SQL.Add('  AND DATA BETWEEN :INIZIO AND :FINE');
      SQL.Add('    AND EXISTS (SELECT ''X'' FROM T430_STORICO WHERE PROGRESSIVO = T044.PROGRESSIVO ');
      SQL.Add('                AND T044.DATA BETWEEN INIZIO AND NVL(FINE,TO_DATE(''31123999'',''DDMMYYYY''))) ');
      SQL.Add('    AND OPERAZIONE =''C''');
      SQL.Add('    GROUP BY CAUSALE,DATA,DATANAS,TIPOGIUST,DAORE,AORE ');
      SQL.Add('  )' );
      SQL.Add('  ,T265_CAUASSENZE WHERE CAUSALE IN (' + ElencoCausali + ') ');
      SQL.Add('  AND CAUSALE = CODICE ');
      SQL.Add('  GROUP BY CAUSALE,DATA,DATANAS,TIPOGIUST,DAORE,AORE ');
      SQL.Add('  HAVING ABS(SUM(NREC)) > 0 )');
      SQL.Add('  ORDER BY CAUSALE,DATANAS,DATA');
      DeclareVariable('DaRegStamp',otDate);
      DeclareVariable('ARegStamp',otDate);
      if PeriodoServizioChecked then
      begin
        DeclareVariable('Inizio',otDate);
        DeclareVariable('Fine',otDate);
      end;
    end;
    DeclareVariable('PROGRESSIVO',otInteger);
  end;
end;

procedure TA061FDettAssenzaMW.ImpostaQueryGiustificativi(DaData, AData:TDateTime);
var
  DataDal,DataOld,DataNas: TDateTime;
  OldOper,OldCaus,TipoGiustOld,OldCausale,UM,InsDip,Percent: String;
  Coniuge : String;
  SaltaAssenza: Boolean;
  CumuloMinuti,CumuloMinutiCont,i,NRec: Integer;
  CumuloGiorni: Real;
begin
  //Impostazione query dei giustificativi
  with QGiustificativiAssenza do
  begin
    Close;
    SetVariable('Progressivo',ProgressivoC700);
    if PeriodoServizioChecked then
    begin
      SetVariable('Inizio',SelAnagrafe.FieldByName('T430Inizio').AsDateTime);
      if SelAnagrafe.FieldByName('T430Fine').IsNull then
        SetVariable('Fine',StrToDate('31/12/3999'))
      else
        SetVariable('Fine',SelAnagrafe.FieldByName('T430Fine').AsDateTime);
    end;
    if SoloAssRegSuccChecked then
    begin
      SetVariable('DaRegStamp',DaRegStamp);
      SetVariable('ARegStamp',ARegStamp);
    end
    else
    begin
      SetVariable('Data1',DaData);
      SetVariable('Data2',AData);
    end;
    Open;
  end;
  //Impostazione query dei giustificativi (???)
  with QGiustificativiAssenza do
  begin
    //Azzero le variabili per identificare assenze uguali e i cumuli
    OldCaus:='';
    OldOper:='';
    DataOld:=0;
    DataDal:=0;
    TipoGiustOld:='';
    OldCausale:='';
    DataNas:=0;
    NumFamiliari:=0;
    Coniuge:='';  //LORENA 15/07/2004
    while not Eof do
    begin
      SaltaAssenza:=False;
      if SoloAssRegSuccChecked then
      begin
        if (AssenzeConsiderateItemIndex = 1) and (FieldByName('OPERAZIONE').AsString = 'Can.') then
          SaltaAssenza:=True;
        if (AssenzeConsiderateItemIndex = 2) and (FieldByName('OPERAZIONE').AsString = 'Ins.') then
          SaltaAssenza:=True;
      end;
      if not SaltaAssenza then
      begin
        //Se il dettaglio giornaliero e' a periodi li costruisco
        if DettGiornChecked then
          InserisciDipendenteDetGio(OldCausale, Coniuge, CampoRagg, DataNas, AData)
        else
          CumulaPeriodi(CumuloGiorni,CumuloMinuti,CumuloMinutiCont,OldOper,OldCaus,Percent,TipoGiustOld,UM,InsDip,Coniuge,GGMinCont,CampoRagg,DataDal,DataOld,DataNas,AData);
        //Nel caso di assenze filtrate dalla data di registrazione e quindi lette da T044, dato che possono essere
        //sommati record con stesse caratteristiche di inserimento devo ciclare tante volte quanto il numero di tali
        //record, prima di leggere il record successivo
        if SoloAssRegSuccChecked then
        begin
          NRec:=FieldByName('NREC').AsInteger;
          for i:=1 to Nrec - 1 do
          begin
            if DettGiornChecked then
              InserisciDipendenteDetGio(OldCausale, Coniuge, CampoRagg, DataNas, AData)
            else
              CumulaPeriodi(CumuloGiorni,CumuloMinuti,CumuloMinutiCont,OldOper,OldCaus,Percent,TipoGiustOld,UM,InsDip,Coniuge,GGMinCont,CampoRagg,DataDal,DataOld,DataNas,AData);
          end;
        end;
      end;
      Next;
    end;
    if not(DettGiornChecked) and (DataDal > 0) and (InsDip = 'S') then
      if ((StrToIntDef(GGMinCont,0) > 0) and (CumuloGiorni >= StrToIntDef(GGMinCont,0))) or
         (StrToIntDef(GGMinCont,0) <= 0) then
        InserisciDipendente(CumuloGiorni,CumuloMinuti,CumuloMinutiCont,DataDal,DataOld,DataNas,OldOper,OldCaus,Percent,TipoGiustOld,UM,Coniuge, CampoRagg);
  end;
end;

function TA061FDettAssenzaMW.MinutiConteggiati(chkConteggiGGChecked: Boolean):Integer; //Lorena 31/08/2011
var i,k:Integer;
begin
  Result:=0;
  if chkConteggiGGChecked and
    (QGiustificativiAssenza.FieldByName('CONIUGE').AsString = '') and
    (R180CarattereDef(QGiustificativiAssenza.FieldByName('TIPOGIUST').AsString) in ['D','N']) then
  begin
    with R502ProDtM1 do
    begin
      Blocca:=0;
      R502ProDtM1.ConteggiaGiustificativiR600:=True;
      R502ProDtM1.CaricaGiustificativiR600:=True;
      R502ProDtM1.Conteggi('Cartolina',ProgressivoC700,QGiustificativiAssenza.FieldByName('Data').AsDateTime);
      R502ProDtM1.CaricaGiustificativiR600:=False;
      R502ProDtM1.ConteggiaGiustificativiR600:=False;
      if R502ProDtM1.Blocca = 0 then  //se non ci sono anom.bloccanti
      begin
        //k:=x se QGiustificativiAssenza = GiustificativiR600 (causale,progrcausale)
        k:=0;
        for i:=0 to Length(R502ProDtM1.GiustificativiR600) - 1 do
          if (QGiustificativiAssenza.FieldByName('CAUSALE').AsString = R502ProDtM1.GiustificativiR600[i].causale) and
             (QGiustificativiAssenza.FieldByName('PROGRCAUSALE').AsInteger = R502ProDtM1.GiustificativiR600[i].progrcausale) then
            k:=i;
        if Length(R502ProDtM1.GiustificativiR600) > 0 then
          Result:=R502ProDtM1.GiustificativiR600[k].minvalasse;
      end;
    end;
  end;
end;

function TA061FDettAssenzaMW.SenzaRiduzioni:Boolean;
var i:Integer;
begin
  Result:=True;
  for i:=1 to 6 do
    if R600DtM1.Riduzioni[i] < 100 then
      if R600DtM1.CompetenzeOri[i] - R600DtM1.Competenze[i] > 0 then
      begin
        Result:=False;
        Break;
      end;
end;

procedure TA061FDettAssenzaMW.TabellaStampaBeforePost(DataSet: TDataSet);
begin
  inherited;
  TabellaStampa.FieldByName('ORE').AsString:=R180MinutiOre(TabellaStampa.FieldByName('MINUTI').AsInteger);
  TabellaStampa.FieldByName('FAMILIARE').AsString:=IfThen(TabellaStampa.FieldByName('DATANAS').AsDateTime = DATE_NULL,'',TabellaStampa.FieldByName('DATANAS').AsString);
end;

end.
