unit W002UModificaDatiDM;

interface

uses
  A000UCostanti, A000UInterfaccia, A000USessione, C180FunzioniGenerali, OracleData,
  SysUtils, Classes, Oracle, DB, DBClient, Variants, StrUtils;

type
  TDati = record
    CampoV430: String;       // campo così come definito sulla V430_STORICO
    Dato: String;            // dato in forma leggibile (senza prefisso "T430")
    Valore: String;          // valore in stringa
    Modificabile: Boolean;   // indica se modificabile dall'utente
  end;

  TDatiAnag = record
    Modificato: Boolean;
    Progressivo: Integer;
    Decorrenza: TDateTime;
    Nominativo: String;
  end;

  TW002FModificaDatiDM = class(TDataModule)
    cdsDatiAnag: TClientDataSet;
    cdsDatiAnagCAMPO: TStringField;
    cdsDatiAnagDATA_TYPE: TStringField;
    cdsDatiAnagDATA_LENGTH: TIntegerField;
    cdsDatiAnagDATO: TStringField;
    cdsDatiAnagVALORE: TStringField;
    cdsDatiAnagVALORE_OLD: TStringField;
    selDecorrenza: TOracleQuery;
    updDatiAnag: TOracleQuery;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    ListeCaricate: Boolean;
    DatiVisArr: array of TDati;
    procedure CaricaListeDati;
  public
    LstDatiVis,
    LstDatiModif: TStringList;
    MainDataset: TOracleDataset;
    procedure IntegraCampiV430RepVis(var RCampi: String);
    function  GetDecorrenzaUpdate(const PProg: Integer): TDateTime;
  end;

implementation

{$R *.dfm}

procedure TW002FModificaDatiDM.DataModuleCreate(Sender: TObject);
var
  i: Integer;
begin
 try
  for i:=0 to Self.ComponentCount - 1 do
    if Components[i] is TOracleQuery then
      (Components[i] as TOracleQuery).Session:=SessioneOracle
    else if Components[i] is TOracleDataSet then
      (Components[i] as TOracleDataSet).Session:=SessioneOracle
    else if Components[i] is TOracleScript then
      (Components[i] as TOracleScript).Session:=SessioneOracle;

  // prepara clientdataset dati anagrafici
  with cdsDatiAnag do
  begin
    Close;
    IndexDefs.Add('Dato','DATO',[]);
    IndexName:='Dato';
    CreateDataSet;
    LogChanges:=False;
    Open;
  end;

  // crea stringlist di appoggio per i dati da visualizzare e modificare
  LstDatiVis:=TStringList.Create;
  LstDatiModif:=TStringList.Create;
  ListeCaricate:=False;

  // carica le stringlist con i dati da visualizzare e modificare
  CaricaListeDati;
 except
 end;
end;

procedure TW002FModificaDatiDM.DataModuleDestroy(Sender: TObject);
begin
 try
  cdsDatiAnag.Close;
  FreeAndNil(LstDatiVis);
  FreeAndNil(LstDatiModif);
 except
 end;
end;

procedure TW002FModificaDatiDM.CaricaListeDati;
var
  i: Integer;
  Campo, Tabella, Codice, Storico: String;
begin
  cdsDatiAnag.EmptyDataSet;

  if Parametri.CampiRiferimento.C29_ChiamateRepDatiVis <> '' then
  begin
    // dati da visualizzare (aggiunti a CampiV430)
    LstDatiVis.CommaText:=Parametri.CampiRiferimento.C29_ChiamateRepDatiVis;

    // dati da modificare
    if Parametri.CampiRiferimento.C29_ChiamateRepDatiModif <> '' then
    begin
      LstDatiModif.CommaText:=Parametri.CampiRiferimento.C29_ChiamateRepDatiModif;
      // se il dato non è tabellare ne consente la modifica
      for i:=LstDatiModif.Count - 1 downto 0 do
      begin
        A000GetTabella(LstDatiModif[i],Tabella,Codice,Storico);
        if (Tabella <> '') and (Tabella <> 'T430_STORICO') then
          LstDatiModif.Delete(i);
      end;
    end;

    // gestione dati parametrizzati da visualizzare e modificabili
    cdsDatiAnag.FieldByName('DATO').ReadOnly:=False;
    SetLength(DatiVisArr,LstDatiVis.Count);
    for i:=0 to LstDatiVis.Count - 1 do
    begin
      Campo:=Format('T430%s',[LstDatiVis[i]]);
      DatiVisArr[i].CampoV430:=Campo;
      DatiVisArr[i].Dato:=R180Capitalize(LstDatiVis[i]);
      if Parametri.CampiRiferimento.C29_ChiamateRepDatiModif = '' then
        DatiVisArr[i].Modificabile:=False
      else
        DatiVisArr[i].Modificabile:=LstDatiModif.IndexOf(LstDatiVis[i]) > -1;

      // se il dato è fra quelli modificabili
      // e il layout dell'utente ne consente l'accesso in scrittura
      // aggiunge il campo al clientdataset per la modifica
      if DatiVisArr[i].Modificabile then
      begin
        if WR000DM.cdsI010.Locate('NOME_CAMPO',DatiVisArr[i].CampoV430,[]) then
        begin
          if WR000DM.cdsI010.FieldByName('ACCESSO').AsString = 'S' then
          begin
            cdsDatiAnag.Append;
            cdsDatiAnag.FieldByName('CAMPO').AsString:=DatiVisArr[i].CampoV430;
            cdsDatiAnag.FieldByName('DATA_TYPE').AsString:=WR000DM.cdsI010.FieldByName('DATA_TYPE').AsString;
            cdsDatiAnag.FieldByName('DATA_LENGTH').AsInteger:=WR000DM.cdsI010.FieldByName('DATA_LENGTH').AsInteger;
            cdsDatiAnag.FieldByName('DATO').AsString:=DatiVisArr[i].Dato;
            cdsDatiAnag.FieldByName('VALORE').Value:=null;
            cdsDatiAnag.FieldByName('VALORE_OLD').Value:=null;
            cdsDatiAnag.Post;
          end;
        end;
      end;
    end;
    cdsDatiAnag.FieldByName('DATO').ReadOnly:=True;
  end;
  ListeCaricate:=True;
end;

procedure TW002FModificaDatiDM.IntegraCampiV430RepVis(var RCampi: String);
var
  i: Integer;
  Campo: String;
begin
  // carica le stringlist se necessario
  if not ListeCaricate then
    CaricaListeDati;

  // rimuove virgola finale
  if RightStr(RCampi,1) = ',' then
    RCampi:=Copy(RCampi,1,Length(RCampi) - 1);

  // integra i campi da estrarre dalla V430 con i dati aggiuntivi da visualizzare per la reperibilità
  for i:=0 to LstDatiVis.Count - 1 do
  begin
    Campo:=Format('V430.T430%s',[LstDatiVis[i]]);
    if R180CercaParolaIntera(Campo,RCampi,',') = 0 then
      RCampi:=RCampi + IfThen(RCampi <> '',',') + Campo;
  end;
end;

function TW002FModificaDatiDM.GetDecorrenzaUpdate(const PProg: Integer): TDateTime;
begin
  selDecorrenza.SetVariable('PROGRESSIVO',PProg);
  try
    selDecorrenza.Execute;
    Result:=selDecorrenza.FieldAsDate(0);
  except
    Result:=DATE_MAX;
  end;
end;

end.
