unit UIntfWebT480;

interface

uses
  Windows, Messages, SysUtils, Classes, Controls, Db, OracleData, Oracle, Variants,
  meIWDBEdit, meIWEdit, meIWButton,
  A000UMessaggi, C180FunzioniGenerali, WC015USelEditGridFM;

type
  TCustomResultLookup = procedure of object;

  TIntfWebT480 = class(TComponent)
  private
    DataSet:TOracleDataSet;
    FbtnLookup: TmeIWButton;
    FDataSource: TDataSource;
    procedure SetDataSource(Val:TdataSource);
    procedure SetBtnLookup(Val:TmeIWButton);
    procedure btnLookupClick(Sender: TObject);
    procedure ResultLookup(Sender: TObject;Result: Boolean);
    procedure ImpostaSelT480(Descrizione,Codice,Cap,Provincia: String);
  public
    edtCitta: TmeIWEdit;
    edtProvincia: TmeIWEdit;
    edtCap: TmeIWEdit;
    dedtCodice: TmeIWDBEdit;
    dedtCap: TmeIWDBEdit;
    Titolo:String;
    Chiave:String;
    ValoreChiave:String;
    CustomResultLookup:TCustomResultLookup;
    constructor Create(AOwner:TComponent);
    destructor Destroy;
    property btnLookup: TmeIWButton read FbtnLookup write SetBtnLookup;
    property DataSource: TDataSource read FDataSource write SetDataSource;
  end;

implementation

constructor TIntfWebT480.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Titolo:='Scelta comune';
  Chiave:='CODICE';
end;

destructor TIntfWebT480.Destroy;
begin
  inherited Destroy;
end;

procedure TIntfWebT480.SetDataSource(Val:TDataSource);
begin
  FDataSource:=Val;
  DataSet:=TOracleDataSet(FDataSource.DataSet);
end;

procedure TIntfWebT480.SetBtnLookup(Val:TmeIWButton);
begin
  FbtnLookup:=Val;
  FbtnLookup.OnClick:=btnLookupClick;
  FbtnLookup.Hint:=A000MSG_MSG_RICERCACOMUNI;
end;

procedure TIntfWebT480.btnLookupClick(Sender: TObject);
var Descrizione, Codice, Provincia, Cap: String;
  WC015: TWC015FSelEditGridFM;
begin
  Codice:='';
  Provincia:='';
  Cap:='';
  ValoreChiave:='';
  Descrizione:=edtCitta.Text;
  if (dedtCodice <> nil) and (not dedtCodice.ReadOnly) then
    Codice:=dedtCodice.Text;
  if (edtProvincia <> nil) and (not edtProvincia.ReadOnly) then
    Provincia:=edtProvincia.Text;
  if (dedtCap <> nil) and (not dedtCap.ReadOnly) then
    Cap:=dedtCap.Text;
  if (edtCap <> nil) and (not edtCap.ReadOnly) then
    Cap:=edtCap.Text;
  ImpostaSelT480(Descrizione,Codice,Cap,Provincia);
  with DataSet do
  begin
    if RecordCount = 0 then
    begin
      ImpostaSelT480(Descrizione,'','','');//Ricerco solo per città
      if RecordCount = 0 then
        ImpostaSelT480('','','','');  //Ricerco senza filtri
    end;
    if RecordCount = 1 then
    begin
      if ((dedtCodice <> nil) and (Codice = '')) or
         (FieldByName(Chiave).AsString <> Codice) then
      begin
        ResultLookup(nil,True);
        Filtered:=False;
        exit;
      end
      else
        ImpostaSelT480('','','','');
    end;
    SearchRecord(Chiave,Codice,[srFromBeginning]);
  end;

  WC015:=TWC015FSelEditGridFM.Create(Self.Owner);
  WC015.ConfermaAutomatica:=True;
  WC015.ResultEvent:=ResultLookup;
  WC015.Visualizza(Titolo,DataSource.Dataset,False,False,True);
end;

procedure TIntfWebT480.ResultLookup(Sender: TObject;Result: Boolean);
begin
  //1 solo elemento selezionato
  if Result then
  begin
    ValoreChiave:=DataSet.FieldByName(Chiave).AsString;
    edtCitta.Text:=DataSet.FieldByName('CITTA').AsString;
    // per i campi data-aware devo assegnare il valore sia sul componente grafico che sul dataset
    if dedtCodice <> nil then
    begin
      dedtCodice.Text:=ValoreChiave;
      dedtCodice.DataSource.DataSet.FieldByName(dedtCodice.DataField).AsString:=ValoreChiave;
    end;
    if edtProvincia <> nil then
      edtProvincia.Text:=DataSet.FieldByName('PROVINCIA').AsString;
    if edtCap <> nil then
      edtCap.Text:=DataSet.FieldByName('CAP').AsString;
    if (dedtCap <> nil) then // and (not Assigned(dedtCap.OnAsyncDoubleClick)) then
    begin
      dedtCap.Text:=DataSet.FieldByName('CAP').AsString;
      dedtCap.DataSource.DataSet.FieldByName(dedtCap.DataField).AsString:=DataSet.FieldByName('CAP').AsString;
    end;
  end;
  DataSet.Filtered:=False;
  if Assigned(CustomResultLookup) then
    CustomResultLookup;
end;

procedure TIntfWebT480.ImpostaSelT480(Descrizione,Codice,Cap,Provincia: String);
var Filtro: String;
begin
  Filtro:='';
  if Trim(Descrizione) <> '' then
  begin
    if Filtro <> '' then
      Filtro:= Filtro + ' AND ';
    Filtro:= Filtro + ' (UPPER(CITTA) = ''' + AggiungiApice(UpperCase(Trim(Descrizione))) + '*'') ';
  end;
  if Trim(Codice) <> '' then
  begin
    if Filtro <> '' then
      Filtro:= Filtro + ' AND ';
    Filtro:= Filtro + ' (UPPER(' + Chiave + ') = ''' + UpperCase(Trim(Codice)) + '*'') ';
  end;
  if Trim(Cap) <>'' then
  begin
    if Filtro <> '' then
      Filtro:= Filtro + ' AND ';
    Filtro:= Filtro + ' (UPPER(CAP) = ''' + UpperCase(Trim(Cap)) + '*'') ';
  end;
  if Trim(Provincia) <>'' then
  begin
    if Filtro <> '' then
      Filtro:= Filtro + ' AND ';
    Filtro:= Filtro + ' (UPPER(PROVINCIA) = ''' + UpperCase(Trim(Provincia)) + '*'') ';
  end;
  with DataSet do
  begin
    FilterOptions:=[foCaseInsensitive];
    Filter:=Filtro;
    Filtered:=True;
    Open;
    First;
  end;
end;

end.
