unit A147URepVincoliIndividualiMW;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, OracleData, DB, Oracle, StrUtils,
  A000UCostanti, A000UInterfaccia, A000USessione, A000UMessaggi, R005UDataModuleMW;

type
  TAzioneT385 = (taInserisci, taCancella);

  TRecT385 = record
    Decorrenza:TDateTime;
    DecorrenzaFine:TDateTime;
    Tipologia:String;
    Giorno:String;
    Turni:String;
    Disponibile:String;
    BloccaPianif:String;
  end;

  TA147FRepVincoliIndividualiMW = class(TR005FDataModuleMW)
    insT385: TOracleQuery;
    selT385b: TOracleDataSet;
    selT350: TOracleDataSet;
    delT385: TOracleQuery;
    procedure DataModuleCreate(Sender: TObject);
    procedure selT350FilterRecord(DataSet: TDataSet; var Accept: Boolean);
  private
    { Private declarations }
  public
    CodTipologia,Giorno: String;
    RecT385:TRecT385;
    selT385: TOracleDataSet;
    procedure SettaProgressivo;
    procedure AgisciTuttiDipSel(Azione:TAzioneT385);
    procedure BeforePost;
    procedure CalcFields;
    procedure NewRecord;
    procedure DividiPeriodo(DataRif: TDateTime);
    const
      D_Giorno:array[0..9] of TItemsValues = (
        (Item:'*';   Value:'*  - Tutti'),
        (Item:'FS';  Value:'FS - Festivo'),
        (Item:'PF';  Value:'PF - Prefestivo'),
        (Item:'1';   Value:'1  - Lunedì'),
        (Item:'2';   Value:'2  - Martedì'),
        (Item:'3';   Value:'3  - Mercoledì'),
        (Item:'4';   Value:'4  - Giovedì'),
        (Item:'5';   Value:'5  - Venerdì'),
        (Item:'6';   Value:'6  - Sabato'),
        (Item:'7';   Value:'7  - Domenica')
        );
  end;

implementation

{$R *.dfm}

procedure TA147FRepVincoliIndividualiMW.DataModuleCreate(Sender: TObject);
begin
  inherited;
  CodTipologia:='R';
  RegistraMsg.IniziaMessaggio(NomeOwner);
end;

procedure TA147FRepVincoliIndividualiMW.SettaProgressivo;
begin
  selT385.Close;
  selT385.SetVariable('Tipo',CodTipologia);
  selT385.SetVariable('Progressivo',ProgressivoC700);
  selT385.Open;
end;

procedure TA147FRepVincoliIndividualiMW.selT350FilterRecord(DataSet: TDataSet; var Accept: Boolean);
begin
  inherited;
  Accept:=A000FiltroDizionario('TURNI REPERIBILITA',DataSet.FieldByName('CODICE').AsString);
end;

procedure TA147FRepVincoliIndividualiMW.BeforePost;
begin
  if selT385.FieldByName('DECORRENZA_FINE').IsNull then
    selT385.FieldByName('DECORRENZA_FINE').AsDateTime:=StrToDate('31/12/3999');
  if (selT385.FieldByName('DECORRENZA').AsDateTime > selT385.FieldByName('DECORRENZA_FINE').AsDateTime) then
    raise Exception.Create(A000MSG_ERR_DECOR_SUP_SCAD);
  if Trim(selT385.FieldByName('TURNI').AsString) = '' then
    raise Exception.Create(A000MSG_A147_ERR_NO_TURNI);
  selT385.FieldByName('GIORNO').AsString:=Giorno;

  selT385b.Close;
  selT385b.SetVariable('PROG',selT385.FieldByName('PROGRESSIVO').AsInteger);
  selT385b.SetVariable('DEC',selT385.FieldByName('DECORRENZA').AsDateTime);
  selT385b.SetVariable('SCAD',selT385.FieldByName('DECORRENZA_FINE').AsDateTime);
  selT385b.SetVariable('TIPO',selT385.FieldByName('TIPOLOGIA').AsString);
  selT385b.SetVariable('GIORNO',selT385.FieldByName('GIORNO').AsString);
  selT385b.SetVariable('RIGA',IfThen(selT385.State in [dsInsert],'',selT385.RowId));
  selT385b.Open;
  if selT385b.RecordCount > 0  then
    raise exception.Create(A000MSG_ERR_PERIODI_INTERSECANTI);
end;

procedure TA147FRepVincoliIndividualiMW.AgisciTuttiDipSel(Azione:TAzioneT385);
var Progressivo:Integer;
begin
  RegistraMsg.IniziaMessaggio(NomeOwner);

  //Salvataggio dati attuali da copiare o cancellare su tutta la selezione
  RecT385.Decorrenza:=selT385.FieldByName('DECORRENZA').AsDateTime;
  RecT385.DecorrenzaFine:=selT385.FieldByName('DECORRENZA_FINE').AsDateTime;
  RecT385.Tipologia:=selT385.FieldByName('TIPOLOGIA').AsString;
  RecT385.Giorno:=selT385.FieldByName('GIORNO').AsString;
  RecT385.Turni:=selT385.FieldByName('TURNI').AsString;
  RecT385.Disponibile:=selT385.FieldByName('DISPONIBILE').AsString;
  RecT385.BloccaPianif:=selT385.FieldByName('BLOCCA_PIANIF').AsString;

  //Salvo progressivo attuale per successivo riposizionamento
  Progressivo:=selAnagrafe.FieldByName('PROGRESSIVO').AsInteger;
  with selAnagrafe do
  begin
    First;
    while not Eof do
    begin
      if (Azione = taInserisci) and (FieldByName('PROGRESSIVO').AsInteger = Progressivo) then
      begin
        Next;
        Continue;
      end;
      SettaProgressivo;
      if Azione = taInserisci then
      begin
        selT385.Append;
        selT385.FieldByName('PROGRESSIVO').AsInteger:=selAnagrafe.FieldByName('PROGRESSIVO').AsInteger;
        selT385.FieldByName('DECORRENZA').AsDateTime:=RecT385.Decorrenza;
        selT385.FieldByName('DECORRENZA_FINE').AsDateTime:=RecT385.DecorrenzaFine;
        selT385.FieldByName('TIPOLOGIA').AsString:=RecT385.Tipologia;
        selT385.FieldByName('GIORNO').AsString:=RecT385.Giorno;
        selT385.FieldByName('TURNI').AsString:=RecT385.Turni;
        selT385.FieldByName('DISPONIBILE').AsString:=RecT385.Disponibile;
        selT385.FieldByName('BLOCCA_PIANIF').AsString:=RecT385.BloccaPianif;
        try
          selT385.Post;
        except
          on E:Exception do
          begin
            selT385.Cancel;
            RegistraMsg.InserisciMessaggio('A',Format('Inserimento vincoli di reperibilità dal %s al %s fallito: %s',[DateToStr(RecT385.Decorrenza),DateToStr(RecT385.DecorrenzaFine),E.Message]),'',selAnagrafe.FieldByName('PROGRESSIVO').AsInteger);
          end;
        end;
      end
      else if Azione = taCancella then
      begin
        if selT385.SearchRecord('DECORRENZA;DECORRENZA_FINE;TIPOLOGIA;GIORNO',VarArrayOf([RecT385.Decorrenza,RecT385.DecorrenzaFine,RecT385.Tipologia,RecT385.Giorno]),[srFromBeginning]) then
          selT385.Delete;
      end;
      Next;
    end;
    //Ritorno sul record di partenza
    SearchRecord('PROGRESSIVO',Progressivo,[srFromBeginning]);
    SettaProgressivo;
    if Azione = taInserisci then
      selT385.SearchRecord('DECORRENZA;DECORRENZA_FINE;TIPOLOGIA;GIORNO',VarArrayOf([RecT385.Decorrenza,RecT385.DecorrenzaFine,RecT385.Tipologia,RecT385.Giorno]),[srFromBeginning]);
  end;
end;

procedure TA147FRepVincoliIndividualiMW.CalcFields;
var i: Integer;
begin
  inherited;
  for i:=0 to High(D_Giorno) do
    if D_Giorno[i].Item = selT385.FieldByName('GIORNO').AsString then
    begin
      selT385.FieldByName('DescGIORNO').AsString:=Copy(D_Giorno[i].Value,6);
      Break;
    end;
end;

procedure TA147FRepVincoliIndividualiMW.NewRecord;
begin
  inherited;
  selT385.FieldByName('PROGRESSIVO').AsInteger:=selAnagrafe.FieldByName('PROGRESSIVO').AsInteger;
  selT385.FieldByName('TIPOLOGIA').AsString:=CodTipologia;
  selT385.FieldByName('DISPONIBILE').AsString:='N';
  selT385.FieldByName('BLOCCA_PIANIF').AsString:='N';
  selT385.FieldByName('GIORNO').AsString:='*';
end;

procedure TA147FRepVincoliIndividualiMW.DividiPeriodo(DataRif: TDateTime);
var Riga:String;
begin
  if (DataRif <> 0) and (DataRif <> selT385.FieldByName('DECORRENZA').AsDateTime) then
  begin
    if (DataRif > selT385.FieldByName('DECORRENZA_FINE').AsDateTime) or
      (DataRif < selT385.FieldByName('DECORRENZA').AsDateTime) then
      raise Exception.Create(A000MSG_A147_DATA_COMPRESA);
    insT385.SetVariable('PROGRESSIVO',selT385.FieldByName('PROGRESSIVO').AsInteger);
    insT385.SetVariable('DECORRENZA',DataRif);
    insT385.SetVariable('DECORRENZA_FINE',selT385.FieldByName('DECORRENZA_FINE').AsDateTime);
    insT385.SetVariable('TIPOLOGIA',selT385.FieldByName('TIPOLOGIA').AsString);
    insT385.SetVariable('GIORNO',selT385.FieldByName('GIORNO').AsString);
    insT385.SetVariable('TURNI',selT385.FieldByName('TURNI').AsString);
    insT385.SetVariable('DISPONIBILE',selT385.FieldByName('DISPONIBILE').AsString);
    insT385.SetVariable('BLOCCA_PIANIF',selT385.FieldByName('BLOCCA_PIANIF').AsString);
    insT385.Execute;
    selT385.Edit;
    selT385.FieldByName('DECORRENZA_FINE').AsDateTime:=DataRif - 1;
    selT385.Post;
    SessioneOracle.Commit;
    Riga:=selT385.RowId;
    selT385.Refresh;
    selT385.SearchRecord('ROWID',Riga,[srFromBeginning]);
  end;
end;

end.
