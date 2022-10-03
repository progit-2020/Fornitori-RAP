unit A105UStoricoGiustificativiMW;

interface

uses
  System.SysUtils, System.Classes, Oracle, Data.DB, OracleData, Forms,
  R005UDataModuleMW, A000UInterfaccia, A000USessione, USelI010,
  Datasnap.DBClient, C180FunzioniGenerali, Variants;

type
  TA105FStoricoGiustificativiMW = class(TR005FDataModuleMW)
    selT044: TOracleDataSet;
    Q265: TOracleDataSet;
    insT044: TOracleQuery;
    delT044: TOracleQuery;
    D010: TDataSource;
    TabellaStampa: TClientDataSet;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    { Private declarations }
    OldCausale:String;
    NumFamiliari:Word;
    DataNas:TDateTime;
    procedure InserisciDipendenteDetGio;
    procedure InserisciDipendente(CumuloGiorni:Real;CumuloMinuti: Integer; DataDal,DataOld:TDateTime;OldOper,OldCaus,OldFlag,Percent,TipoGiustOld,UM: String);
    procedure CumulaPeriodi(var CumuloGiorni:Real; var CumuloMinuti: Integer; var OldOper,OldCaus,OldFlag,Percent,TipoGiustOld,UM,InsDip: String; var DataDal,DataOld:TDateTime);
  public
    { Public declarations }
    CampoRagg:String;
    NomeCampo:String;
    ElencoCausali:String;
    StatoPaghe:String;
    selI010:TselI010;
    ListaDati:TStringList;
    DocumentoPDF,CodForm,TipoModulo:String; //CS=ClientServer, COM=COMServer
    procedure CreaTabellaStampa;
    procedure ElaboraDipendente(Data1,Data2:TDateTime;RecordFisici:String;AssenzeInserite,AssenzeCancellate,DettaglioGiornaliero:Boolean);
    procedure Registrazione(Data1,Data2,DataReg:TDateTime;DefDataReg,RegIns,RegCanc,ImpostaAssElab,Causali:String);
    procedure Cancellazione(Data1,Data2:TDateTime);
  end;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure TA105FStoricoGiustificativiMW.DataModuleCreate(Sender: TObject);
begin
  if not(SessioneOracle.Connected) then
  begin
    Password(Application.Name);
    A000ParamDBOracle(SessioneOracle);
  end;
  inherited;
  selI010:=TselI010.Create(Self);
  selI010.Apri(SessioneOracle,Parametri.Layout,Parametri.Applicazione,'NOME_CAMPO,NOME_LOGICO,POSIZIONE','','NOME_LOGICO');
  D010.DataSet:=selI010;
  Q265.Open;
  ListaDati:=TStringList.Create;
  ListaDati.Add('Z Da elaborare');
  ListaDati.Add('P Elaborata dal precalcolo');
  ListaDati.Add('C Elaborata');
  ListaDati.Add('T Elaborata su tredicesima ma non su Dicembre');
  TipoModulo:='CS';
end;

procedure TA105FStoricoGiustificativiMW.DataModuleDestroy(Sender: TObject);
begin
  FreeAndNil(selI010);
  ListaDati.Free;
  inherited;
end;

procedure TA105FStoricoGiustificativiMW.CreaTabellaStampa;
begin
  TabellaStampa.Close;
  TabellaStampa.FieldDefs.Clear;
  TabellaStampa.FieldDefs.Add('Gruppo',ftString,40,False);
  TabellaStampa.FieldDefs.Add('Cognome',ftString,60,False);
  TabellaStampa.FieldDefs.Add('Badge',ftString,8,False);
  TabellaStampa.FieldDefs.Add('Data',ftDateTime,0,False);
  TabellaStampa.FieldDefs.Add('Prog',ftAutoInc,0,False);
  TabellaStampa.FieldDefs.Add('DataAl',ftDateTime,0,False);
  TabellaStampa.FieldDefs.Add('Operazione',ftString,4,False);
  TabellaStampa.FieldDefs.Add('Matricola',ftString,8,False);
  TabellaStampa.FieldDefs.Add('Causale',ftString,7,False);
  TabellaStampa.FieldDefs.Add('Flag',ftString,4,False);
  TabellaStampa.FieldDefs.Add('Descrizione',ftString,40,False);
  TabellaStampa.FieldDefs.Add('Giorni',ftFloat,0,False);
  TabellaStampa.FieldDefs.Add('Minuti',ftInteger,0,False);
  TabellaStampa.IndexDefs.Clear;
  TabellaStampa.IndexDefs.Add('Primario',('Gruppo;Cognome;Badge;Operazione;Data;Prog'),[ixUnique]);
  TabellaStampa.IndexName:='Primario';
  TabellaStampa.CreateDataSet;
  TabellaStampa.LogChanges:=False;
end;

procedure TA105FStoricoGiustificativiMW.ElaboraDipendente(Data1,Data2:TDateTime;RecordFisici:String;AssenzeInserite,AssenzeCancellate,DettaglioGiornaliero:Boolean);
var DataDal,DataOld: TDateTime;
    Percent,TipoGiustOld: String;
    CumuloGiorni: Real;
    CumuloMinuti: Integer;
    OldOper,OldCaus,OldFlag,UM,InsDip: String;
    i,NRec: Integer;
    SaltaAssenza: Boolean;
begin
  //Impostazione query dei giustificativi
  with selT044 do
  begin
    Close;
    SetVariable('Progressivo',selAnagrafe.FieldByName('Progressivo').AsInteger);
    SetVariable('Data1',Data1);
    SetVariable('Data2',Data2);
    SetVariable('ElencoCausali','' + ElencoCausali + '');
    if StatoPaghe = '' then
    begin
      SetVariable('FiltroVoci','N');
      SetVariable('StatoPaghe','''''');
    end
    else
    begin
      SetVariable('FiltroVoci','S');
      SetVariable('StatoPaghe','''' + StatoPaghe + '''');
    end;
    SetVariable('RecordFisici',RecordFisici);
    Open;
    //Azzero le variabili per identificare assenze uguali e i cumuli
    OldCaus:='';
    OldFlag:='';
    OldOper:='';
    DataOld:=0;
    DataDal:=0;
    TipoGiustOld:='';
    OldCausale:='';
    DataNas:=0;
    NumFamiliari:=0;
    while not Eof do
    begin
      SaltaAssenza:=True;
      if AssenzeInserite and (FieldByName('OPERAZIONE').AsString = 'Ins.') then
        SaltaAssenza:=False;
      if AssenzeCancellate and (FieldByName('OPERAZIONE').AsString = 'Can.') then
        SaltaAssenza:=False;
      if not SaltaAssenza then
      begin
        //Se il dettaglio giornaliero e' a periodi li costruisco
        if DettaglioGiornaliero then
          InserisciDipendenteDetGio
        else
          CumulaPeriodi(CumuloGiorni,CumuloMinuti,OldOper,OldCaus,OldFlag,Percent,TipoGiustOld,UM,InsDip,DataDal,DataOld);
        //Dato che in T044 possono essere sommati record con stesse caratteristiche di inserimento
        //devo ciclare tante volte quanto il numero di tali record, prima di leggere il record successivo
        NRec:=FieldByName('NREC').AsInteger;
        for i:=1 to Nrec - 1 do
        begin
          if DettaglioGiornaliero then
            InserisciDipendenteDetGio
          else
            CumulaPeriodi(CumuloGiorni,CumuloMinuti,OldOper,OldCaus,OldFlag,Percent,TipoGiustOld,UM,InsDip,DataDal,DataOld);
        end;
      end;
      Next;
    end;
    if not(DettaglioGiornaliero) and (DataDal > 0) and (InsDip = 'S') then
      InserisciDipendente(CumuloGiorni,CumuloMinuti,DataDal,DataOld,OldOper,OldCaus,OldFlag,Percent,TipoGiustOld,UM);
  end;
end;

//Inserisci dipendente nel caso di dettaglio giornaliero
procedure TA105FStoricoGiustificativiMW.InserisciDipendenteDetGio;
var S:String;
begin
  if OldCausale <> selT044.FieldByName('Causale').AsString then
  begin
    NumFamiliari:=0;
    DataNas:=0;
    OldCausale:=selT044.FieldByName('Causale').AsString;
  end;
  if not selT044.FieldByName('DataNas').IsNull then
    if selT044.FieldByName('DataNas').AsDateTime <> DataNas then
    begin
      inc(NumFamiliari);
      DataNas:=selT044.FieldByName('DataNas').AsDateTime;
    end;
  TabellaStampa.Insert;
  if CampoRagg <> '' then
    TabellaStampa.FieldByName('Gruppo').Value:=SelAnagrafe.FieldByName(CampoRagg).Value;
  TabellaStampa.FieldByName('Badge').Value:=SelAnagrafe.FieldByName('T430Badge').Value;
  TabellaStampa.FieldByName('Cognome').Value:=SelAnagrafe.FieldByName('Cognome').AsString + ' ' + SelAnagrafe.FieldByName('Nome').AsString;
  TabellaStampa.FieldByName('Matricola').Value:=SelAnagrafe.FieldByName('Matricola').Value;
  TabellaStampa.FieldByName('Data').Value:=selT044.FieldByName('Data').AsDateTime;
  TabellaStampa.FieldByName('Operazione').AsString:=selT044.FieldByName('Operazione').AsString;
  S:=selT044.FieldByName('Causale').AsString;
  if NumFamiliari <> 0 then
    S:=S + '*' + IntToStr(NumFamiliari);
  TabellaStampa.FieldByName('Causale').Value:=S;
  TabellaStampa.FieldByName('Flag').Value:=selT044.FieldByName('Flag').AsString;
  TabellaStampa.FieldByName('Descrizione').Value:=VarToStr(Q265.Lookup('Codice',S,'Descrizione'));
  if selT044.FieldByName('TipoGiust').AsString = 'I' then
    TabellaStampa.FieldByName('Giorni').AsInteger:=1;
  if selT044.FieldByName('TipoGiust').AsString = 'M' then
    TabellaStampa.FieldByName('Giorni').AsFloat:=0.5;
  if selT044.FieldByName('TipoGiust').AsString = 'N' then
    TabellaStampa.FieldByName('Minuti').AsInteger:=R180OreMinuti(selT044.FieldByName('DaOre').AsDateTime);
  if selT044.FieldByName('TipoGiust').AsString = 'D' then
    TabellaStampa.FieldByName('Minuti').AsInteger:=R180OreMinuti(selT044.FieldByName('AOre').AsDateTime) -
                                                   R180OreMinuti(selT044.FieldByName('DaOre').AsDateTime);
  TabellaStampa.Post;
end;

//Inserisci dipendente nel caso di dettaglio periodico
procedure TA105FStoricoGiustificativiMW.InserisciDipendente(CumuloGiorni:Real;CumuloMinuti: Integer; DataDal,DataOld:TDateTime;OldOper,OldCaus,OldFlag,Percent,TipoGiustOld,UM: String);
var S:String;
begin
  S:=OldCaus;
  if NumFamiliari <> 0 then
    S:=S + '*' + IntToStr(NumFamiliari);
  TabellaStampa.Insert;
  if CampoRagg <> '' then
    TabellaStampa.FieldByName('Gruppo').Value:=SelAnagrafe.FieldByName(CampoRagg).Value;
  TabellaStampa.FieldByName('Badge').Value:=SelAnagrafe.FieldByName('T430Badge').Value;
  TabellaStampa.FieldByName('Cognome').Value:=SelAnagrafe.FieldByName('Cognome').AsString + ' ' + SelAnagrafe.FieldByName('Nome').AsString;
  TabellaStampa.FieldByName('Matricola').Value:=SelAnagrafe.FieldByName('Matricola').Value;
  TabellaStampa.FieldByName('Data').Value:=DataDal;
  TabellaStampa.FieldByName('DataAl').Value:=DataOld;
  TabellaStampa.FieldByName('Causale').Value:=S;
  TabellaStampa.FieldByName('Flag').Value:=OldFlag;
  TabellaStampa.FieldByName('Descrizione').Value:=VarToStr(Q265.Lookup('Codice',OldCaus,'Descrizione'));
  TabellaStampa.FieldByName('Giorni').AsFloat:=CumuloGiorni;
  TabellaStampa.FieldByName('Minuti').AsInteger:=CumuloMinuti;
  TabellaStampa.FieldByName('Operazione').AsString:=OldOper;
  TabellaStampa.Post;
end;

//Legge assenza e cumula periodi
procedure TA105FStoricoGiustificativiMW.CumulaPeriodi(var CumuloGiorni:Real; var CumuloMinuti: Integer; var OldOper,OldCaus,OldFlag,Percent,TipoGiustOld,UM,InsDip: String; var DataDal,DataOld:TDateTime);
begin
  //Se prima causale del dipendente...
  if OldCaus = '' then
  begin
    InsDip:='S';
    CumuloGiorni:=0;
    CumuloMinuti:=0;
    DataDal:=selT044.FieldByName('Data').AsDateTime;
    OldCaus:=selT044.FieldByName('Causale').AsString;
    OldFlag:=selT044.FieldByName('Flag').AsString;
    OldOper:=selT044.FieldByName('Operazione').AsString;
    DataOld:=selT044.FieldByName('Data').AsDateTime;
    TipoGiustOld:=selT044.FieldByName('TipoGiust').AsString;
    if not selT044.FieldByName('DataNas').IsNull then
    begin
      DataNas:=selT044.FieldByName('DataNas').AsDateTime;
      inc(NumFamiliari);
    end;
  end
  else
  begin
    //Se stessa assenza della precedente...
    if (OldCaus = selT044.FieldByName('Causale').AsString) and
       ((DataOld = selT044.FieldByName('Data').AsDateTime) or
        (DataOld + 1 = selT044.FieldByName('Data').AsDateTime)) and
       (TipoGiustOld = selT044.FieldByName('TipoGiust').AsString) and
       ((selT044.FieldByName('DataNas').IsNull) or
        (DataNas = selT044.FieldByName('DataNas').AsDateTime)) and
         (OldOper = selT044.FieldByName('Operazione').AsString) then
    begin
      DataOld:=selT044.FieldByName('Data').AsDateTime;
      InsDip:='S';
    end
    else
    //Cambia assenza: registro i dati per la stampa e memorizzo nuovi dati
    begin
      if InsDip = 'S' then
        InserisciDipendente(CumuloGiorni,CumuloMinuti,DataDal,DataOld,OldOper,OldCaus,OldFlag,Percent,TipoGiustOld,UM);
      InsDip:='S';
      CumuloGiorni:=0;
      CumuloMinuti:=0;
      if OldCaus <> selT044.FieldByName('Causale').AsString then
        NumFamiliari:=0;
      if not selT044.FieldByName('DataNas').IsNull then
        if DataNas <> selT044.FieldByName('DataNas').AsDateTime then
          inc(NumFamiliari);
      DataDal:=selT044.FieldByName('Data').AsDateTime;
      OldCaus:=selT044.FieldByName('Causale').AsString;
      OldFlag:=selT044.FieldByName('Flag').AsString;
      OldOper:=selT044.FieldByName('Operazione').AsString;
      DataOld:=selT044.FieldByName('Data').AsDateTime;
      TipoGiustOld:=selT044.FieldByName('TipoGiust').AsString;
      DataNas:=selT044.FieldByName('DataNas').AsDateTime;
    end;
  end;
  //Cumulo i valori per tutte le assenze continuate lette da T044, dato che possono essere
  //sommati record con stesse caratteristiche di inserimento per il cumulo di giorni e ore devo utilizzare
  //il campo TOT_QUANT che contiene già la quantità moltiplicata per il numero delle sue ripetizioni
  if selT044.FieldByName('TipoGiust').AsString = 'I' then
    CumuloGiorni:=CumuloGiorni+selT044.FieldByName('TOT_QUANT').AsInteger;
  if selT044.FieldByName('TipoGiust').AsString = 'M' then
    CumuloGiorni:=CumuloGiorni+(selT044.FieldByName('TOT_QUANT').AsInteger/2);
  if (selT044.FieldByName('TipoGiust').AsString = 'N') or
     (selT044.FieldByName('TipoGiust').AsString = 'D') then
    CumuloMinuti:=CumuloMinuti+selT044.FieldByName('TOT_QUANT').AsInteger;
end;

procedure TA105FStoricoGiustificativiMW.Registrazione(Data1,Data2,DataReg:TDateTime;DefDataReg,RegIns,RegCanc,ImpostaAssElab,Causali:String);
begin
  insT044.SetVariable('Data1',Data1);
  insT044.SetVariable('Data2',Data2);
  insT044.SetVariable('DefDataRegistraz',DefDataReg);
  insT044.SetVariable('DataRegistrazione',DataReg);
  insT044.SetVariable('InsertRecord',RegIns);
  insT044.SetVariable('DeleteRecord',RegCanc);
  insT044.SetVariable('Prog',selAnagrafe.FieldByName('Progressivo').AsInteger);
  insT044.SetVariable('ImpAssenzaElab',ImpostaAssElab);
  insT044.SetVariable('ElencoCausali',Causali);
  insT044.Execute;
end;

procedure TA105FStoricoGiustificativiMW.Cancellazione(Data1,Data2:TDateTime);
begin
  delT044.SetVariable('Data1',Data1);
  delT044.SetVariable('Data2',Data2);
  delT044.SetVariable('Prog',selAnagrafe.FieldByName('Progressivo').AsInteger);
  delT044.Execute;
  delT044.Session.Commit;
end;

end.
