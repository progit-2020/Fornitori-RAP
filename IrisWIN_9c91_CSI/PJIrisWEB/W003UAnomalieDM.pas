unit W003UAnomalieDM;

interface

uses
  SysUtils, Classes, A000UInterfaccia, OracleData, Oracle, Variants,
  R500Lin, Rp502Pro, C180FunzioniGenerali, Math, StrUtils, Data.DB;

type

  TRecAnomalie = record
    Progressivo:String;
    Matricola:String;
    Nome:String;
    Livello:String;
    Data:String;
    Anomalia:String;
  end;

  TVettAnomalie = array of TRecAnomalie;

  TW003FAnomalieDM = class(TDataModule)
    selT101: TOracleDataSet;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
    procedure selT101FilterRecord(DataSet: TDataSet; var Accept: Boolean);
  private
    { Private declarations }
    R502ProDtM:TR502ProDtM1;
    LivelloAnomalie: array[1..3] of Boolean;
    FDataDal, FDataAl:TDateTime;
    procedure InizializzaConteggiT101;
    procedure AnomalieDip(Progr:integer; inDataCorr:TDateTime);
    procedure PutAnomalia(Progressivo: Integer; Data:TDateTime; Livello:String; N:integer; Anomalia:String);
  public
    { Public declarations }
    selAnagrafe:TOracleDataSet;
    VettAnomalie:TVettAnomalie;
    procedure Anomalie;
    procedure NotificaAutomaticaAnomalie;
    procedure SetLivelloAnomalie(Livello1,Livello2,Livello3:Boolean);
    procedure InizializzaConteggi(DataDal,DataAl:TDateTime);
    property  DataDal:TDateTime read FDataDal;
    property  DataAl:TDateTime read FDataAl;
  end;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure TW003FAnomalieDM.DataModuleCreate(Sender: TObject);
var
  i:integer;
begin
 try
  for i:=0 to Self.ComponentCount - 1 do
    if Components[i] is TOracleQuery then
      (Components[i] as TOracleQuery).Session:=SessioneOracle
    else if Components[i] is TOracleDataSet then
      (Components[i] as TOracleDataSet).Session:=SessioneOracle;

  selAnagrafe:=TOracleDataSet.Create(Self);
  selAnagrafe.Session:=WR000DM.selAnagrafe.Session;
  selAnagrafe.SQL.Assign(WR000DM.selAnagrafe.SQL);
  selAnagrafe.SQL[0]:='SELECT T030.*,T480.CITTA,T480.PROVINCIA,V430.T430BADGE FROM';
  selAnagrafe.Variables.Assign(WR000DM.selAnagrafe.Variables);
  selAnagrafe.Open;

  R502ProDtM:=TR502ProDtM1.Create(nil);
 except
 end;
end;

procedure TW003FAnomalieDM.DataModuleDestroy(Sender: TObject);
begin
 try
  if selAnagrafe <> nil then
    FreeAndNil(selAnagrafe);
  FreeAndNil(R502ProDtM);
 except
 end;
end;

procedure TW003FAnomalieDM.SetLivelloAnomalie(Livello1,Livello2,Livello3:Boolean);
begin
  LivelloAnomalie[1]:=Livello1;
  LivelloAnomalie[2]:=Livello2;
  LivelloAnomalie[3]:=Livello3;
end;

procedure TW003FAnomalieDM.InizializzaConteggiT101;
var DMin,DMax:TDateTime;
begin
  DMin:=EncodeDate(3999,12,31);
  DMax:=EncodeDate(1899,12,31);
  selT101.First;
  while not selT101.Eof do
  begin
    DMin:=Min(DMin,selT101.FieldByName('DATA').AsDateTime);
    DMax:=Max(DMax,selT101.FieldByName('DATA').AsDateTime);
    selT101.Next;
  end;

  InizializzaConteggi(DMin,DMax);
  R502ProDtM.ConsideraRichiesteWeb:=True;
end;

procedure TW003FAnomalieDM.InizializzaConteggi(DataDal,DataAl:TDateTime);
begin
  FDataDal:=DataDal;
  FDataAl:=DataAl;
  R502ProDtM.FiltroDizionarioAnomalie:=True;
  R502ProDtM.PeriodoConteggi(FDataDal,FDataAl);
  SetLength(VettAnomalie,0);
end;

procedure TW003FAnomalieDM.Anomalie;
var
  DataCorrente:TDateTime;
begin
  selT101.Close;
  selAnagrafe.First;
  while not selAnagrafe.Eof do
  begin
    DataCorrente:=FDataDal;
    while DataCorrente <= FDataAl do
    begin
      AnomalieDip(selAnagrafe.FieldByName('Progressivo').AsInteger,DataCorrente);
      DataCorrente:=DataCorrente + 1;
    end;
    selAnagrafe.Next;
  end;
end;

procedure TW003FAnomalieDM.NotificaAutomaticaAnomalie;
begin
  selT101.Filtered:=True;
  selT101.Open;
  if selT101.RecordCount > 0 then
  begin
    InizializzaConteggiT101;
    SetLivelloAnomalie(True,True,True);
    selT101.First;
    while not selT101.Eof do
    begin
      if selAnagrafe.SearchRecord('PROGRESSIVO',selT101.FieldByName('PROGRESSIVO').AsInteger,[srFromBeginning]) then
        AnomalieDip(selT101.FieldByName('PROGRESSIVO').AsInteger,
                    selT101.FieldByName('DATA').AsDateTime);
      selT101.Next;
    end;
  end;
end;

procedure TW003FAnomalieDM.AnomalieDip(Progr:integer; inDataCorr:TDateTime);
var
  s:string;
  na, j:integer;
begin
  R502ProDtM.Conteggi('Anomalie',Progr,inDataCorr);
  if (R502ProDtM.Blocca <> 0) and LivelloAnomalie[1] then
    PutAnomalia(Progr,inDataCorr,'1',R502ProDtM.Blocca,'Anom.bloccante! ' + tdescanom1[R502ProDtM.Blocca].D);
  if LivelloAnomalie[2] then
  begin
    for na:=0 to High(R502ProDtM.tanom2riscontrate) do
    begin
      if tdescanom2[R502ProDtM.tanom2riscontrate[na].ta2puntdesc].F = 1 then
        S:=R502ProDtM.tanom2riscontrate[na].ta2caus + ':' + tdescanom2[R502ProDtM.tanom2riscontrate[na].ta2puntdesc].D
      else
        S:=tdescanom2[R502ProDtM.tanom2riscontrate[na].ta2puntdesc].D;
      PutAnomalia(Progr,inDataCorr,'2',R502ProDtM.tanom2riscontrate[na].ta2puntdesc,S);
    end;
  end;
  if LivelloAnomalie[3] then
  begin
    for na:=0 to High(R502ProDtM.tanom3riscontrate) do
    begin
      S:=R180MinutiOre(R502ProDtM.tanom3riscontrate[na].ta3timb) + ':' + tdescanom3[R502ProDtM.tanom3riscontrate[na].ta3puntdesc].D;
      if R502ProDtM.tanom3riscontrate[na].ta3puntdesc in [4,6] then
      begin
        if not R502ProDtM.tanom3riscontrate[na].ta3desc.IsEmpty then
          S:=S + ' [' + StringReplace(R502ProDtM.tanom3riscontrate[na].ta3desc,#13#10,'] [',[rfReplaceAll]) + ']';
      end;
      PutAnomalia(Progr,inDataCorr,'3',R502ProDtM.tanom3riscontrate[na].ta3puntdesc,S);
    end;
  end;
end;

procedure TW003FAnomalieDM.PutAnomalia(Progressivo: Integer; Data:TDateTime; Livello:String; N:integer; Anomalia:String);
var
  i:Integer;
begin
  if selT101.Active then
  begin
    if selT101.Lookup('PROGRESSIVO;DATA;LIVELLO;NUM_ANOMALIA',VarArrayOf([Progressivo,Data,Livello,N]),'NUM_ANOMALIA') <> N then
      exit;
  end;
  i:=Length(VettAnomalie);
  SetLength(VettAnomalie,i + 1);
  VettAnomalie[i].Progressivo:=selAnagrafe.FieldByName('Progressivo').AsString;
  VettAnomalie[i].Matricola:=selAnagrafe.FieldByName('Matricola').AsString;
  VettAnomalie[i].Nome:=selAnagrafe.FieldByName('COGNOME').AsString + ' ' + selAnagrafe.FieldByName('NOME').AsString;
  VettAnomalie[i].Livello:=Livello;
  VettAnomalie[i].Data:=DateToStr(Data);
  VettAnomalie[i].Anomalia:=Anomalia;
end;

procedure TW003FAnomalieDM.selT101FilterRecord(DataSet: TDataSet;
  var Accept: Boolean);
begin
  Accept:=selAnagrafe.Lookup('PROGRESSIVO',selT101.FieldByName('PROGRESSIVO').AsInteger,'PROGRESSIVO') > 0;
end;

end.
