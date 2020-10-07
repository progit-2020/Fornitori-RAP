unit A033UStampaAnomalieMW;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, R005UDataModuleMW, DB,Oracle,OracleData,
  USelI010,A000UCostanti, A000USessione,A000UInterfaccia, Rp502pro,R410UAutoGiustificazioneDtM,R500Lin,
  C180FunzioniGenerali, DBClient;

type
  TA033VerificaAnomaliaSelezionata = function(Livello: Integer; idx: Integer):Boolean of object;

  TA033FStampaAnomalieMW = class(TR005FDataModuleMW)
    dsrI010: TDataSource;
    QDelete: TOracleQuery;
    Q100: TOracleDataSet;
    QInsert: TOracleQuery;
    TStampa: TClientDataSet;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    R410FAutoGiustificazioneDtM:TR410FAutoGiustificazioneDtM;
    selI010:TselI010;
    FInizio,FFine:TDateTime;
    FAggiornaT101,
    FAnomalieLivello1,
    FAnomalieLivello2,
    FAnomalieLivello3,
    FTimbratureLivello1,
    FTimbratureLivello2,
    FTimbratureLivello3,
    FCausaliLivello1,
    FCausaliLivello2,
    FCausaliLivello3: Boolean;
    Lista,QRLista:TStringList;
    FCampoRaggruppamento: String;
    procedure SalvaAnomalia(Prog:Integer; Data:TDateTime; Livello:Integer;
      Anomalia:String; NAnom:integer);
    procedure RegistraDipendente(Data: TDateTime);
  public
    R502ProDtM1:TR502ProDtM1;
    A033VerificaAnomaliaSelezionata: TA033VerificaAnomaliaSelezionata;
    procedure CancellaAnomalie;
    procedure CreaR502Dtm;
    procedure DistruggiR502Dtm;
    procedure PeriodoConteggi;
    procedure Autogiustificazione;
    procedure ElaboraDipendente;
    procedure CreazioneTabellaStampa;
    property DataInizio: TDateTime read FInizio write FInizio;
    property DataFine: TDateTime read FFine write FFine;
    property AnomalieLivello1: Boolean read FAnomalieLivello1 write FAnomalieLivello1;
    property AnomalieLivello2: Boolean read FAnomalieLivello2 write FAnomalieLivello2;
    property AnomalieLivello3: Boolean read FAnomalieLivello3 write FAnomalieLivello3;
    property TimbratureLivello1: Boolean read FTimbratureLivello1 write FTimbratureLivello1;
    property TimbratureLivello2: Boolean read FTimbratureLivello2 write FTimbratureLivello2;
    property TimbratureLivello3: Boolean read FTimbratureLivello3 write FTimbratureLivello3;
    property CausaliLivello1: Boolean read FCausaliLivello1 write FCausaliLivello1;
    property CausaliLivello2: Boolean read FCausaliLivello2 write FCausaliLivello2;
    property CausaliLivello3: Boolean read FCausaliLivello3 write FCausaliLivello3;
    property CampoRaggruppamento: String read FCampoRaggruppamento write FCampoRaggruppamento;
    property AggiornaT101: Boolean read FAggiornaT101 write FAggiornaT101;
  end;

implementation

{$R *.dfm}

procedure TA033FStampaAnomalieMW.DataModuleCreate(Sender: TObject);
begin
  inherited;
  selI010:=TselI010.Create(Self);
  selI010.Apri(SessioneOracle,Parametri.Layout,Parametri.Applicazione,'NOME_CAMPO,NOME_LOGICO','','NOME_LOGICO');
  dsrI010.DataSet:=selI010;
  R410FAutoGiustificazioneDtM:=TR410FAutoGiustificazioneDtM.Create(Self);
  QRLista:=TStringList.Create;
  Lista:=TStringList.Create;
end;

procedure TA033FStampaAnomalieMW.Autogiustificazione;
begin
  R410FAutoGiustificazioneDtM.AutoGiustificazione(selAnagrafe.FieldByName('PROGRESSIVO').AsInteger,DataInizio,DataFine);
end;

procedure TA033FStampaAnomalieMW.CancellaAnomalie;
begin
 with QDelete do
  try
    SetVariable('Operatore',Parametri.ProgOper);
    Execute;  // svuoto la T101_Anomalie
  except
  end;
end;

procedure TA033FStampaAnomalieMW.CreaR502Dtm;
begin
  R502ProDtM1:=TR502ProDtM1.Create(nil);
end;

procedure TA033FStampaAnomalieMW.DistruggiR502Dtm;
begin
  FreeAndNil(R502ProDtM1);
end;

procedure TA033FStampaAnomalieMW.ElaboraDipendente;
const Spazio = '            ';
var S,S1,S2:String;
    A,M,Giorno,NR:Word;
    i,j:Integer;
    A1,A2,A3:Boolean;
    Corrente:TDateTime;
begin
  Corrente:=DataInizio;
  QRLista.Clear;
  NR:=0;
  while Corrente <= DataFine do
  begin
    DecodeDate(Corrente,A,M,Giorno);
    with R502ProDtm1 do
    begin
      with SelAnagrafe do
        Conteggi('Anomalie',FieldByName('Progressivo').AsInteger,Corrente);
      A1:=False;
      A2:=False;
      A3:=False;
      if (Blocca <> 0) and (FAnomalieLivello1) then
        if A033VerificaAnomaliaSelezionata(1,Blocca) then
        begin
          QRLista.Add(Spazio + 'Anom.bloccante! ' + tdescanom1[Blocca].D);
          A1:=True;
          if AggiornaT101 then
            SalvaAnomalia(SelAnagrafe.FieldByName('Progressivo').AsInteger,Corrente,1,tdescanom1[Blocca].D, tdescanom1[Blocca].N);
        end;
      //Anomalie di secondo livello
      if FAnomalieLivello2 then
      begin
          for i:=0 to High(tanom2riscontrate) do
          begin
            if A033VerificaAnomaliaSelezionata(2,tanom2riscontrate[i].ta2puntdesc) then
            begin
              if tdescanom2[tanom2riscontrate[i].ta2puntdesc].F = 1 then
                S:=tanom2riscontrate[i].ta2caus + ':'
              else
                S:='';
              QRLista.Add(Spazio + S + tdescanom2[tanom2riscontrate[i].ta2puntdesc].D);
              A2:=True;
              if AggiornaT101 then
                SalvaAnomalia(SelAnagrafe.FieldByName('Progressivo').AsInteger,Corrente,2,S + tdescanom2[tanom2riscontrate[i].ta2puntdesc].D,
                                                                                          tdescanom2[tanom2riscontrate[i].ta2puntdesc].N);
            end;
          end;
      end;
      //Anomalie di terzo livello
      if FAnomalieLivello3 then
      begin
        for i:=0 to High(tanom3riscontrate) do
        begin
          if A033VerificaAnomaliaSelezionata(3,tanom3riscontrate[i].ta3puntdesc)then
          begin
            QRLista.Add(Spazio + R180MinutiOre(tanom3riscontrate[i].ta3timb) + ':' + tdescanom3[tanom3riscontrate[i].ta3puntdesc].D);
            if tanom3riscontrate[i].ta3puntdesc in [4,6] then
            begin
              Lista.Clear;
              Lista.Text:=tanom3riscontrate[i].ta3desc;
              for j:=0 to Lista.Count - 1 do
                QRLista.Add(Spazio + Lista[j]);
            end;
            A3:=True;
            if AggiornaT101 then
            begin
              S:='';
              if tanom3riscontrate[i].ta3puntdesc in [4,6] then
                S:='[' + tanom3riscontrate[i].ta3desc + ']';
              SalvaAnomalia(SelAnagrafe.FieldByName('Progressivo').AsInteger,Corrente,3,R180MinutiOre(tanom3riscontrate[i].ta3timb) + S + ':' + tdescanom3[tanom3riscontrate[i].ta3puntdesc].D,
                                                                                        tdescanom3[tanom3riscontrate[i].ta3puntdesc].N);
            end;
          end;
        end;
      end;
    end;
   //Controllo se devo anche stampare le timbrature
    if (QRLista.Count <> NR) and
      ((FTimbratureLivello1 and A1) or (FTimbratureLivello2 and A2) or (FTimbratureLivello3 and A3)) then
       //Leggo e stampo le timbrature del giorno
      with Q100 do
      begin
        S:=Spazio;
        S1:=Spazio;
        S2:=Spazio;
        SetVariable('Progressivo',SelAnagrafe.FieldByName('Progressivo').AsInteger);
        SetVariable('Data',Corrente);
        Open;
        if RecordCount > 0 then
        begin
          while not Eof do
          begin
            S:=S + FieldByName('Verso').AsString + FormatDateTime('hhnn',FieldByName('Ora').AsDateTime);
            if FieldByName('Rilevatore').IsNull then
              S:=S + '    '
            else
              S:=S + Format('%-4s',['*' + FieldByName('Rilevatore').AsString]);
            S1:=S1 + Format('%-9s',[FieldByName('Causale').AsString]);
            S2:=S2 + '_____' + '    ';
            Next;
          end;
          QRLista.Add(S);
          //Controllo se devo stampare le causali di timbrature
          if (Trim(S1) <> '') and
             ((FCausaliLivello1 and A1) or (FCausaliLivello2 and A2) or (FCausaliLivello3 and A3)) then
            QRLista.Add(S1);
          QRLista.Add(S2);
        end
        else
          QRLista.Add(Spazio + 'Nessuna timbratura');
        Close;
      end;
    if QRLista.Count <> NR then
    begin
      S:=DateToStr(Corrente);
      S1:=QRLista[NR];
      Delete(S1,1,Length(S));
      Insert(S,S1,1);
      QRLista[NR]:=S1;
      QRLista.Add('');
      NR:=QRLista.Count;
      //PrintBand:=True;
    end;
    if QRLista.Count > 0 then
    begin
      RegistraDipendente(Corrente);
      QRLista.Clear;
      NR:=0;
    end;
    Corrente:=Corrente + 1;
  end;
end;

procedure TA033FStampaAnomalieMW.PeriodoConteggi;
begin
  R502ProDtM1.PeriodoConteggi(DataInizio,DataFine);
end;

procedure TA033FStampaAnomalieMW.SalvaAnomalia(Prog:Integer; Data:TDateTime; Livello:Integer; Anomalia:String; NAnom:integer);
begin
  if (Livello < 1)or(Livello > 3) then
    exit;     // se livello e' inesistente => esco.
  QInsert.SetVariable('Progressivo',Prog);
  QInsert.SetVariable('Data',Data);
  QInsert.SetVariable('Livello',Livello);
  QInsert.SetVariable('Anomalia',Anomalia);
  QInsert.SetVariable('Operatore',Parametri.ProgOper);
  QInsert.SetVariable('Utente',Parametri.Operatore);
  QInsert.SetVariable('Num_Anomalia',NAnom);
  try
    QInsert.Execute;
    SessioneOracle.Commit;
  except
  end;
end;

procedure TA033FStampaAnomalieMW.RegistraDipendente(Data:TDateTime);
var SS:TStringStream;
begin
  SS:=TStringStream.Create('');
  QRLista.SaveToStream(SS);
  TStampa.Insert;
  if CampoRaggruppamento <> '' then
    TStampa.FieldByName('Raggruppamento').AsString:=SelAnagrafe.FieldByName(CampoRaggruppamento).AsString;
  TStampa.FieldByName('Nome').AsString:=SelAnagrafe.FieldByName('COGNOME').AsString + ' ' + SelAnagrafe.FieldByName('NOME').AsString;
  TStampa.FieldByName('Progressivo').AsInteger:=SelAnagrafe.FieldByName('PROGRESSIVO').AsInteger;
  TStampa.FieldByName('Badge').AsInteger:=SelAnagrafe.FieldByName('T430BADGE').AsInteger;
  TStampa.FieldByName('Matricola').AsString:=SelAnagrafe.FieldByName('MATRICOLA').AsString;
  TStampa.FieldByName('Data').AsDateTime:=Data;
  TMemoField(TStampa.FieldByName('Anomalia')).LoadFromStream(SS);
  TStampa.Post;
  SS.Free;
end;

procedure TA033FStampaAnomalieMW.CreazioneTabellaStampa;
begin
  TStampa.Close;
  TStampa.CreateDataSet;
  TStampa.LogChanges:=False;
end;

procedure TA033FStampaAnomalieMW.DataModuleDestroy(Sender: TObject);
begin
  inherited;
  TStampa.Close;
  FreeAndNil(selI010);
  FreeAndNil(R410FAutoGiustificazioneDtM);
  FreeAndNil(QRLista);
  FreeAndNil(Lista);
end;

end.
