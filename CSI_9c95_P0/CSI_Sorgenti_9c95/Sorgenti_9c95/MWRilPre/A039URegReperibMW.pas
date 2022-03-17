unit A039URegReperibMW;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,OracleData, Db,
  Dialogs, R005UDataModuleMW, Oracle, ControlloVociPaghe, A000UInterfaccia, A000USessione, A000UMessaggi,
  C180FunzioniGenerali;

type
  T039Msg = procedure (msg,VocePaghe: String) of object;

  TA039FRegReperibMW = class(TR005FDataModuleMW)
    selT350VP: TOracleDataSet;
    QCols: TOracleDataSet;
    DCols: TDataSource;
    updT340: TOracleQuery;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    Aggiorna:Boolean;
    procedure AllineaT350(VocePaghe: String);
    function DurataTurno(Ini,Fine : String) : Integer;
  public
    evtShowMessage, evtAggiornamentoTurni: T039Msg;
    SelT350: TOracleDataSet;
    TipoOreItemIndex: Integer;
    selControlloVociPaghe:TControlloVociPaghe;
    VoceOld,VoceNew,VpTurno,VpOre,VpMaggiorate,VpNonMaggiorate,GettoneChiamata,VocePagheAgg: String;
    procedure AfterCancel;
    procedure AfterDelete;
    procedure AfterPost;
    procedure NewRecord;
    procedure BeforePostStep1;
    procedure BeforePostStep2;
    procedure AggiornaVocePaghe;
    procedure ImpostaVocePaghe(NomeCampo: String);
    procedure selT350ValidaTurnoIntero(Sender: TField);
    procedure selT350ValidaOreMinutiIndennita(Sender: TField; OraInizio,OraFine: String);
    procedure selT350ValidaTollChiamata(Sender: TField);
    procedure selT350GetText(Sender: TField; var Text: string);
    procedure VerificaCampoOra(Sender: TField;const Text: String);
    procedure FiltroDizionario(DataSet: TDataSet;var Accept: Boolean);
  end;

implementation

{$R *.dfm}

procedure TA039FRegReperibMW.DataModuleCreate(Sender: TObject);
begin
  inherited;
  QCols.Open;
  selControlloVociPaghe:=TControlloVociPaghe.Create(Self,'');
end;

procedure TA039FRegReperibMW.DataModuleDestroy(Sender: TObject);
begin
  inherited;
  if selControlloVociPaghe <> nil then
    FreeAndNil(selControlloVociPaghe);
end;

procedure TA039FRegReperibMW.AfterCancel;
begin
  selT350.CancelUpdates;
end;

procedure TA039FRegReperibMW.AfterDelete;
begin
  SessioneOracle.ApplyUpdates([selT350],True);
end;

procedure TA039FRegReperibMW.AfterPost;
var S:String;
begin
  S:=selT350.FieldByName('Codice').AsString;
  SessioneOracle.ApplyUpdates([selT350],True);
  selT350.Close;
  selT350.Open;
  selT350.Locate('Codice',S,[]);
end;

procedure TA039FRegReperibMW.AggiornaVocePaghe;
begin
  Aggiorna:=True;
  selT350VP.First;
  while not selT350VP.Eof do
  begin
    selT350VP.Edit;
    selT350VP.FieldByName(VocePagheAgg).AsString:=selT350.FieldByName(VocePagheAgg).Value;
    selT350VP.Post;
    selT350VP.Next;
  end;
end;

procedure TA039FRegReperibMW.BeforePostStep1;
begin
  if QueryPK1.EsisteChiave('T350_REGREPERIB',selT350.RowId,selT350.State,['CODICE'],[selT350.FieldByName('Codice').AsString]) then
    raise Exception.Create(A000MSG_ERR_CODICE_ESISTENTE);
  case TipoOreItemIndex of
    0:selT350.FieldByName('OreNormali').Clear;
    1:selT350.FieldByName('OreNormali').Clear;
  end;
  if Trim(VpTurno) = '' then
    selT350.FieldByName('VP_TURNO').AsString:='<NO>';
  if Trim(VpOre) = '' then
    selT350.FieldByName('VP_ORE').AsString:='<NO>';
  if Trim(VpMaggiorate) = '' then
    selT350.FieldByName('VP_MAGGIORATE').AsString:='<NO>';
  if Trim(VpNonMaggiorate) = '' then
    selT350.FieldByName('VP_NONMAGGIORATE').AsString:='<NO>';
  if Trim(GettoneChiamata) = '' then
    selT350.FieldByName('VP_GETTONE_CHIAMATA').AsString:='<NO>';
  if Trim(GettoneChiamata) = '' then
    selT350.FieldByName('VP_TURNI_OLTREMAX').AsString:='<NO>';
  // controllo limite mensile
  if selT350.FieldByName('PIANIF_MAX_MESE').IsNull then
    selT350.FieldByName('PIANIF_MAX_MESE_TURNI_INTERI').Value:=null;
end;

procedure TA039FRegReperibMW.BeforePostStep2;
begin
  selT350VP.SetVariable('RIGAID',SelT350.Rowid);
  selT350VP.Close;
  selT350VP.Open;
  selT350VP.Filtered:=True;
  AllineaT350('VP_TURNO');
  AllineaT350('VP_ORE');
  AllineaT350('VP_MAGGIORATE');
  AllineaT350('VP_NONMAGGIORATE');
  AllineaT350('VP_GETTONE_CHIAMATA');
  AllineaT350('VP_TURNI_OLTREMAX');
end;

procedure TA039FRegReperibMW.AllineaT350(VocePaghe:String);
var
  Codici:String;
  ICod:integer;
begin
  if (selT350.FieldByName(VocePaghe).medpOldValue <> selT350.FieldByName(VocePaghe).Value) and
     (selT350.FieldByName(VocePaghe).medpOldValue <> '<SI>') and (selT350.FieldByName(VocePaghe).medpOldValue <> '<NO>') and
     (selT350.FieldByName(VocePaghe).Value <> '<SI>') and (selT350.FieldByName(VocePaghe).Value <> '<NO>') then
  begin
    Aggiorna:=True;
    selT350VP.Filter:=VocePaghe + ' = ''' + VarToStr(selT350.FieldByName(VocePaghe).medpOldValue) + '''';
    if selT350VP.RecordCount > 0 then
    begin
      Aggiorna:=False;
      Codici:='';
      selT350VP.First;
      ICod:=1;
      while not selT350VP.Eof do
      begin
        Codici:=Codici + selT350VP.FieldByName('CODICE').AsString;
        selT350VP.Next;
        if Not selT350VP.Eof then
          Codici:=Codici + ', ';
        if (ICod mod 10) = 0 then
          Codici:=Codici + #10#13;
        inc(ICod);
      end;
      VocePagheAgg:=VocePaghe;
      if Assigned(evtAggiornamentoTurni) then
        evtAggiornamentoTurni(Format(A000MSG_A039_DLG_FMT_AGGIORNAMENTO_TURNI,[selT350.FieldByName(VocePaghe).Value,Codici]),VocePaghe);
    end;
    if Aggiorna then
    begin
      with updT340 do
      begin
        SetVariable('NOMECAMPO',VocePaghe);
        SetVariable('VALOREOLD',selT350.FieldByName(VocePaghe).medpOldValue);
        SetVariable('VALORENEW',selT350.FieldByName(VocePaghe).Value);
        Execute;
      end;
      if Assigned(evtShowMessage) then
        evtShowMessage(A000MSG_A039_FMT_ALLINEAMENTO_ESEGUITO,selT350.FieldByName(VocePaghe).Value);
    end;
  end;
end;

procedure TA039FRegReperibMW.ImpostaVocePaghe(NomeCampo: String);
begin
  if (selT350.State = dsInsert) or (selT350.FieldByName(NomeCampo).medpOldValue = null) or (selT350.FieldByName(NomeCampo).medpOldValue = '<NO>') then
    VoceOld:=''
  else
    VoceOld:=selT350.FieldByName(NomeCampo).medpOldValue;
  if selT350.FieldByName(NomeCampo).AsString = '<NO>' then
    VoceNew:=''
  else
    VoceNew:=selT350.FieldByName(NomeCampo).AsString;
end;

procedure TA039FRegReperibMW.FiltroDizionario(DataSet: TDataSet; var Accept: Boolean);
begin
  Accept:=A000FiltroDizionario('TURNI REPERIBILITA',DataSet.FieldByName('CODICE').AsString);
end;

procedure TA039FRegReperibMW.selT350GetText(Sender: TField; var Text: string);
begin
  if Sender.IsNull then Text:='' else Text:=FormatDateTime('hh:nn',Sender.AsDateTime);
end;

procedure TA039FRegReperibMW.VerificaCampoOra(Sender: TField;const Text: String);
begin
  {$I CampoOra}
end;

procedure TA039FRegReperibMW.NewRecord;
begin
  selT350.FieldByName('TipoTurno').Value:='I';
  selT350.FieldByName('TipoOre').Value:='0';
  selT350.FieldByName('OreNonCaus').Value:='N';
end;

procedure TA039FRegReperibMW.selT350ValidaTollChiamata(Sender: TField);
begin
  if not Sender.IsNull then
    OreMinutiValidate(Sender.AsString);
end;

procedure TA039FRegReperibMW.selT350ValidaTurnoIntero(Sender: TField);
begin
  if not Sender.IsNull then
    OreMinutiValidate(selT350.FieldByName('TURNO_INTERO').AsString);
end;

procedure TA039FRegReperibMW.selT350ValidaOreMinutiIndennita(Sender: TField; OraInizio,OraFine: String);
begin
  if not Sender.IsNull then
  begin
    // 1. validità dato
    OreMinutiValidate(selT350.FieldByName('ORE_MIN_INDENNITA').AsString);
    // 2. dato <= durata turno.
    if R180OreMinutiExt(selT350.FieldByName('ORE_MIN_INDENNITA').AsString) >
       DurataTurno(OraInizio,OraFine) then
      raise Exception.Create(A000MSG_A039_ERR_DURATA_TURNI);
  end;
end;

function TA039FRegReperibMW.DurataTurno(Ini,Fine : String) : Integer;
var MinIni,MinFine:Longint;
begin
  MinIni:=R180OreMinutiExt(Ini);
  MinFine:=R180OreMinutiExt(Fine);
  if Fine > Ini then
    Result:=MinFine-MinIni
  else
    Result:=(1440-MinIni)+(MinFine); // 1440 : minuti corrispondenti alla mezzanotte
end;

end.
