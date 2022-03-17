unit S730UPunteggiValutazioniMW;

interface

uses
  System.SysUtils, System.Classes, R005UDataModuleMW,DB, OracleData, Oracle,
  A000UCostanti, A000USessione, A000UInterfaccia, A000UMessaggi, C180FunzioniGenerali,
  MedpBackupOldValue;

type
  TS730FPunteggiValutazioniMW = class(TR005FDataModuleMW)
    selSG730a: TOracleQuery;
    selDato1: TOracleDataSet;
    updSG730: TOracleQuery;
    dsrDato1: TDataSource;
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
  public
    selSG730: TOracleDataSet;
    selSG730OldValues: TmedpBackupOldValue;
    procedure AfterPost;
    function BeforePost: String;
    procedure ControlloDate;
    procedure OnNewRecord;
    procedure SetCampiLookup;
  end;

implementation
{%CLASSGROUP 'Vcl.Controls.TControl'}
{$R *.dfm}

procedure TS730FPunteggiValutazioniMW.AfterPost;
var BM:TBookMark;
begin
  inherited;
  updSG730.SetVariable('DATO1',selSG730.FieldByName('DATO1').AsString);
  updSG730.SetVariable('CALCOLO_PFP',selSG730.FieldByName('CALCOLO_PFP').AsString);
  updSG730.Execute;
  SessioneOracle.Commit;
  with selSG730 do
  begin
    DisableControls;
    BM:=GetBookMark;
    Refresh;
    try
      GotoBookMark(BM);
    except
    end;
    FreeBookMark(BM);
    EnableControls;
  end;
end;

function TS730FPunteggiValutazioniMW.BeforePost: String;
begin
  Result:='';
  if selSG730.FieldByName('DECORRENZA').AsDateTime > selSG730.FieldByName('DECORRENZA_FINE').AsDateTime then
    raise Exception.Create(A000MSG_ERR_DECORR_NON_SUCC_SCAD);
  if (selSG730OldValues.FieldByName('CALCOLO_PFP').Value = 'S') and (selSG730.FieldByName('CALCOLO_PFP').AsString = 'N') then
    Result:='Attenzione! ';
end;

procedure TS730FPunteggiValutazioniMW.ControlloDate;
begin
  with selSG730a do
  begin
    SetVariable('DATO1',selSG730.FieldByName('DATO1').AsString);
    SetVariable('CODICE',selSG730.FieldByName('CODICE').AsString);
    if selSG730.State in [dsEdit] then
      SetVariable('COND_ROWID',' and rowid <> ''' + selSG730.RowId + ''' ')
    else
      SetVariable('COND_ROWID','');
    SetVariable('DECORRENZA',selSG730.FieldByName('DECORRENZA').AsDateTime);
    SetVariable('SCADENZA',selSG730.FieldByName('DECORRENZA_FINE').AsDateTime);
    Execute;
    if Field(0) > 0 then
      raise Exception.Create(A000MSG_ERR_DATE_INTERS_PERIODI);
  end;
end;

procedure TS730FPunteggiValutazioniMW.DataModuleCreate(Sender: TObject);
begin
  inherited;
  selSG730OldValues:=TmedpBackupOldValue.Create(Self);
end;

procedure TS730FPunteggiValutazioniMW.OnNewRecord;
begin
  selSG730.FieldByName('DECORRENZA_FINE').AsDateTime:=EncodeDate(3999,12,31);
end;

procedure TS730FPunteggiValutazioniMW.SetCampiLookup;
var S:String;
begin
   //Inserisco i campi lookup della tabella
  if A000LookupTabella(Parametri.CampiRiferimento.C21_ValutazioniPnt1,selDato1) then
  begin
    if selDato1.VariableIndex('DECORRENZA') >= 0 then
      selDato1.SetVariable('DECORRENZA',EncodeDate(3999,12,31));
    selDato1.SQL.Insert(0,'SELECT ''*'' CODICE, ''TUTTI'' DESCRIZIONE FROM DUAL UNION ');
    selDato1.Open;
    selSG730.FieldByName('DESC_DATO1').LookupDataSet:=selDato1;
    S:=R180Capitalize(Parametri.CampiRiferimento.C21_ValutazioniPnt1);
    selSG730.FieldByName('DATO1').DisplayLabel:=S;
    selSG730.FieldByName('DESC_DATO1').DisplayLabel:='Descr. ' + S;
    selSG730.Open;
  end
  else
    raise exception.Create(A000MSG_S730_ERR_DIST_SCALE_PUNT);
end;

end.
