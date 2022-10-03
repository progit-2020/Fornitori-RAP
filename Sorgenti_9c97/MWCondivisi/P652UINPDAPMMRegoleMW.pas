unit P652UINPDAPMMRegoleMW;

interface

uses
  System.SysUtils, System.Classes, R005UDataModuleMW, Data.DB, OracleData,
  A000UCostanti, C180FunzioniGenerali, A000UInterfaccia;

type
  TP652FINPDAPMMRegoleMW = class(TR005FDataModuleMW)
    V430: TOracleDataSet;
    V430COLUMN_NAME: TStringField;
    dsrV430: TDataSource;
    Q265: TOracleDataSet;
    selT275: TOracleDataSet;
    P660B: TOracleDataSet;
    P660BPARTE: TStringField;
    P660BNUMERO: TStringField;
    P660BDESCRIZIONE: TStringField;
    sel200: TOracleDataSet;
    sel200COD_CONTRATTO: TStringField;
    sel200COD_VOCE: TStringField;
    sel200COD_VOCE_SPECIALE: TStringField;
    sel200DESCRIZIONE: TStringField;
    procedure DataModuleCreate(Sender: TObject);
  private
    FselP660_Funzioni: TOracleDataSet;
    PosInizioVoci, PosFineVoci: Integer;
    function RicercaVociNellaQuery(TipoRicercaContVoci: String; DeltaContr,SelStart: Integer): String;
  public
    VociSelezionate,VociSelezionateIn: String;
    procedure ImpostaP660B(Data: TDateTime; Flusso: String; Parte: String);
    function getListAssenze: TElencoValoriChecklist;
    function getListPresenze: TElencoValoriChecklist;
    function CanRipristinaAutomatica: Boolean;
    function CanFiltroVoci: Boolean;
    function FiltroVoci(SelStart: Integer; var lstVoci: TStringList): String;
    procedure ImpostaVociFiltro(lstVociSelezionate: TStringList);
    property selP660_Funzioni: TOracleDataSet read FselP660_Funzioni write FselP660_Funzioni;
  end;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure TP652FINPDAPMMRegoleMW.DataModuleCreate(Sender: TObject);
begin
  inherited;
  v430.Open;
end;

function TP652FINPDAPMMRegoleMW.getListPresenze:TElencoValoriChecklist;
var
  Codice: String;
begin
  Result:=TElencoValoriChecklist.Create;

  with selT275 do
  begin
    Open;
    while not Eof do
    begin
      Codice:=FieldByName('CODICE').AsString;
      Result.lstCodice.add(Codice);
      Result.lstDescrizione.Add(Format('%-5s %s',[Codice,FieldByName('DESCRIZIONE').AsString]));
      Next;
    end;
    Close;
  end;
end;

procedure TP652FINPDAPMMRegoleMW.ImpostaP660B(Data: TDateTime; Flusso: String; Parte: String);
var
  bOpen: Boolean;
begin
  bOpen:=False;
  if R180setVariable(P660B,'NOMEFLUSSO',Flusso) then
    bOpen:=True;
  if R180setVariable(P660B,'DECORRENZA',Data) then
    bOpen:=True;
  if R180setVariable(P660B,'PARTE',Parte) then
    bOpen:=True;

  if bOpen then
    P660B.Open;
end;

function TP652FINPDAPMMRegoleMW.getListAssenze:TElencoValoriChecklist;
var
  Codice: String;
begin
  Result:=TElencoValoriChecklist.Create;

  with Q265 do
  begin
    Open;
    while not Eof do
    begin
      Codice:=FieldByName('CODICE').AsString;
      Result.lstCodice.add(Codice);
      Result.lstDescrizione.Add(Format('%-5s %s',[Codice,FieldByName('DESCRIZIONE').AsString]));
      Next;
    end;
    Close;
  end;
end;

function TP652FINPDAPMMRegoleMW.CanRipristinaAutomatica: Boolean;
begin
  Result:=selP660_Funzioni.FieldByName('REGOLA_CALCOLO_AUTOMATICA').AsString<>'';
end;

function TP652FINPDAPMMRegoleMW.CanFiltroVoci: Boolean;
begin
 Result:=Pos('COD_VOCE_SPECIALE IN (', selP660_Funzioni.FieldByName('REGOLA_CALCOLO_MANUALE').AsString) > 0;
end;

function TP652FINPDAPMMRegoleMW.RicercaVociNellaQuery(TipoRicercaContVoci: String; DeltaContr: Integer; SelStart:Integer): String;
//Ricerco i codici voci già filtratti nella query
var
  iv, fv, iInizioSelez: integer;
  StringaVoci: String;
begin
  StringaVoci:='';
  iInizioSelez:=SelStart;
  if iInizioSelez = 0 then
    iInizioSelez:=1;
  PosInizioVoci:=Pos(TipoRicercaContVoci, Copy(FselP660_Funzioni.FieldByName('REGOLA_CALCOLO_MANUALE').AsString,
     iInizioSelez,Length(FselP660_Funzioni.FieldByName('REGOLA_CALCOLO_MANUALE').AsString)));
  if PosInizioVoci > 0 then
  begin
     PosInizioVoci:=PosInizioVoci + iInizioSelez - 1 + DeltaContr;
    PosFineVoci:=Pos(')',Copy(FselP660_Funzioni.FieldByName('REGOLA_CALCOLO_MANUALE').AsString,
                 PosInizioVoci,Length(FselP660_Funzioni.FieldByName('REGOLA_CALCOLO_MANUALE').AsString)-PosInizioVoci));
    StringaVoci:=Copy(FselP660_Funzioni.FieldByName('REGOLA_CALCOLO_MANUALE').AsString,PosInizioVoci,PosFineVoci);
    while Pos('''',StringaVoci) <> 0 do
    begin
      iv:=Pos('''',StringaVoci);
      fv:=Pos('''',Copy(StringaVoci,iv + 1,Length(StringaVoci)));
      if Result <> '' then
        Result:=Result + ',';
      Result:=Result + Copy(StringaVoci,iv+1,fv-1);
      if (iv+fv) < Length(StringaVoci) then
        StringaVoci:=Copy(StringaVoci,iv+fv+2,Length(StringaVoci));
    end;
  end;
end;

function TP652FINPDAPMMRegoleMW.FiltroVoci(SelStart:Integer; var lstVoci:TStringList): String ;
var
  iInizioSelez: Integer;
  sEsisteContratto: String;
  bRieseguiQuery: Boolean;
  CodVoce, CodVoceSpeciale, CodContratto: String;
begin
  PosInizioVoci:=0;
  iInizioSelez:=SelStart;
  if Pos('COD_CONTRATTO,6,'' '')||RPAD(COD_VOCE,6,'' '')||COD_VOCE_SPECIALE IN (',
     Copy(FselP660_Funzioni.FieldByName('REGOLA_CALCOLO_MANUALE').AsString,
     iInizioSelez,Length(FselP660_Funzioni.FieldByName('REGOLA_CALCOLO_MANUALE').AsString))) > 0 then
  begin
    VociSelezionate:=RicercaVociNellaQuery('COD_CONTRATTO,6,'' '')||RPAD(COD_VOCE,6,'' '')||COD_VOCE_SPECIALE IN (',66,SelStart);
    sEsisteContratto:='XX';
  end
  else
  begin
    VociSelezionate:=RicercaVociNellaQuery('COD_VOCE_SPECIALE IN (',22,SelStart);
    sEsisteContratto:='';
  end;
  if VociSelezionate = '' then exit;
  bRieseguiQuery:=False;
  if FselP660_Funzioni.FieldByName('DECORRENZA').IsNull then
  begin
    if (sel200.GetVariable('DataCassa') <> Parametri.DataLavoro) or
       (sel200.GetVariable('DataCompetenza') <> Parametri.DataLavoro) or
       (sel200.GetVariable('CodContratto') <> sEsisteContratto) then
      bRieseguiQuery:=True;
    sel200.SetVariable('DataCassa', Parametri.DataLavoro);
    sel200.SetVariable('DataCompetenza', Parametri.DataLavoro);
    sel200.SetVariable('CodContratto',sEsisteContratto);
  end
  else
  begin
    if (sel200.GetVariable('DataCassa') <> FselP660_Funzioni.FieldByName('DECORRENZA').AsDateTime) or
       (sel200.GetVariable('DataCompetenza') <> FselP660_Funzioni.FieldByName('DECORRENZA').AsDateTime)
       or (sel200.GetVariable('CodContratto') <> sEsisteContratto) then
      bRieseguiQuery:=True;
    sel200.SetVariable('DataCassa', FselP660_Funzioni.FieldByName('DECORRENZA').AsDateTime);
    sel200.SetVariable('DataCompetenza', FselP660_Funzioni.FieldByName('DECORRENZA').AsDateTime);
    sel200.SetVariable('CodContratto',sEsisteContratto);
  end;
  if bRieseguiQuery then
  begin
    sel200.Close;
    sel200.Open;
  end
  else
    sel200.First;
  lstVoci.Clear;
  //Individuo il tipo di lista di voci da selezionare
  if sEsisteContratto = 'XX' then
  //Voci con il codice contratto davanti
  begin
    while not sel200.Eof do
    begin
      CodContratto:=Format('%-5s',[sel200.FieldByName('COD_CONTRATTO').AsString]);
      CodVoce:=Format('%-5s',[sel200.FieldByName('COD_VOCE').AsString]);
      CodVoceSpeciale:=Format('%-5s',[sel200.FieldByName('COD_VOCE_SPECIALE').AsString]);
      lstVoci.Add(CodContratto+' '+CodVoce+' '+CodVoceSpeciale+' '+Format('%s',[sel200.FieldByName('DESCRIZIONE').AsString]));
      sel200.Next;
    end;
  end
  else
  begin
    while not sel200.Eof do
    begin
      CodVoce:=Format('%-5s',[sel200.FieldByName('COD_VOCE').AsString]);
      CodVoceSpeciale:=Format('%-5s',[sel200.FieldByName('COD_VOCE_SPECIALE').AsString]);
      lstVoci.Add(CodVoce+' '+CodVoceSpeciale+' '+Format('%s',[sel200.FieldByName('DESCRIZIONE').AsString]));
      sel200.Next;
    end;
  end;
  Result:=sEsisteContratto;
end;

procedure TP652FINPDAPMMRegoleMW.ImpostaVociFiltro(lstVociSelezionate: TStringList);
var
  sTmp: String;
begin
  VociSelezionate:='';
  VociSelezionateIn:='';
  for sTmp in lstVociSelezionate do
  begin
    if VociSelezionate <> '' then
    begin
      VociSelezionate:=VociSelezionate + ',';
      VociSelezionateIn:=VociSelezionateIn + ',';
    end;
    VociSelezionate:=VociSelezionate + sTmp;
    VociSelezionateIn:=VociSelezionateIn + '''' + Trim(sTmp) + '''';
  end;
  if VociSelezionateIn = '' then
    VociSelezionateIn:='''''';
  selP660_Funzioni.FieldByName('REGOLA_CALCOLO_MANUALE').AsString:=Copy(selP660_Funzioni.FieldByName('REGOLA_CALCOLO_MANUALE').AsString,1,PosInizioVoci - 1)
      + VociSelezionateIn + Copy(selP660_Funzioni.FieldByName('REGOLA_CALCOLO_MANUALE').AsString,PosInizioVoci+PosFineVoci-1,Length(selP660_Funzioni.FieldByName('REGOLA_CALCOLO_MANUALE').AsString) - PosFineVoci);
end;

end.
