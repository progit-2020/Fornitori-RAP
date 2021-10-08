unit A022UContrattiDtM1;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  DB, A000UCostanti, A000USessione,A000UInterfaccia, RegistrazioneLog, OracleData, Oracle,
  C180FunzioniGenerali, Variants, ControlloVociPaghe,
  A000UMessaggi;

type
  TA022FContrattiDtM1 = class(TDataModule)
    D201: TDataSource;
    D210: TDataSource;
    T200: TOracleDataSet;
    T200Codice: TStringField;
    T200Descrizione: TStringField;
    T200Tipo: TStringField;
    T200IndTurno: TStringField;
    T200Reperibilita: TStringField;
    T200MaxStraord: TStringField;
    T200IndNotteDa: TDateTimeField;
    T200IndNotteA: TDateTimeField;
    T200TOLINDNOT: TFloatField;
    T200ARRINDNOT: TFloatField;
    T200DATADECORRENZA: TDateTimeField;
    T201: TOracleDataSet;
    T201Codice: TStringField;
    T201Giorno: TStringField;
    T201D_Giorno: TStringField;
    T201FasciaDa1: TDateTimeField;
    T201FasciaA1: TDateTimeField;
    T201Maggior1: TStringField;
    T201FasciaDa2: TDateTimeField;
    T201FasciaA2: TDateTimeField;
    T201Maggior2: TStringField;
    T201FasciaDa3: TDateTimeField;
    T201FasciaA3: TDateTimeField;
    T201Maggior3: TStringField;
    T201FasciaDa4: TDateTimeField;
    T201FasciaA4: TDateTimeField;
    T201Maggior4: TStringField;
    T210: TOracleDataSet;
    T210Codice: TStringField;
    T210Descrizione: TStringField;
    T210Maggiorazione: TFloatField;
    T210PORE_LAV: TStringField;
    T210PSTR_NEL_MESE: TStringField;
    Q201ModificaContr: TOracleQuery;
    T210PIND_TUR: TStringField;
    T210PORE_COMP: TStringField;
    T200MAXRESIDUABILE: TStringField;
    T200ARR_INDTURNO_PAL: TStringField;
    T200ORE_LAVFASCE_CONASS: TStringField;
    procedure T201FasciaDa1GetText(Sender: TField; var Text: string;
      DisplayText: Boolean);
    procedure T200IndNotteDaGetText(Sender: TField; var Text: string;
      DisplayText: Boolean);
    procedure T201CalcFields(DataSet: TDataSet);
    procedure T201BeforeInsert(DataSet: TDataSet);
    procedure A022FContrattiDtM1Create(Sender: TObject);
    procedure T200AfterPost(DataSet: TDataSet);
    procedure T200BeforePost(DataSet: TDataSet);
    procedure T201BeforeDelete(DataSet: TDataSet);
    procedure T200BeforeDelete(DataSet: TDataSet);
    procedure T200NewRecord(DataSet: TDataSet);
    procedure BDET200ReperibilitaValidate(Sender: TField);
    procedure BDET201FasciaDa1Validate(Sender: TField);
    procedure BDET201FasciaA1Validate(Sender: TField);
    procedure BDET200IndNotteDaSetText(Sender: TField; const Text: string);
    procedure T201FasciaValidate(Sender: TField);
    procedure BDET200ARRINDNOTValidate(Sender: TField);
    procedure T200AfterEdit(DataSet: TDataSet);
    procedure A022FContrattiDtM1Destroy(Sender: TObject);
    procedure T200AfterDelete(DataSet: TDataSet);
    procedure BDET210BeforePost(DataSet: TDataSet);
    procedure BDET210BeforeDelete(DataSet: TDataSet);
    procedure BDET210AfterPost(DataSet: TDataSet);
    procedure T200AfterScroll(DataSet: TDataSet);
    procedure T201BeforePost(DataSet: TDataSet);
    procedure T201AfterPost(DataSet: TDataSet);
    procedure T210BeforePost(DataSet: TDataSet);
    procedure T210BeforeDelete(DataSet: TDataSet);
    procedure T210AfterDelete(DataSet: TDataSet);
    procedure T200ARR_INDTURNO_PALValidate(Sender: TField);
  private
    { Private declarations }
    Inserimento,Cancellazione:boolean;
    CodiceOld:String;
    selControlloVociPaghe:TControlloVociPaghe;
  public
    { Public declarations }
  end;

var
  A022FContrattiDtM1: TA022FContrattiDtM1;

implementation

uses A022UContratti;

{$R *.DFM}

procedure TA022FContrattiDtM1.A022FContrattiDtM1Create(Sender: TObject);
{Inizializzo le variabili per disabilitare T201}
var i:Integer;
begin
  if not(SessioneOracle.Connected) then
  begin
    Password(Application.Name);
    A000ParamDBOracle(SessioneOracle);
  end;
  for i:=0 to Self.ComponentCount - 1 do
    begin
    if Components[i] is TOracleQuery then
      (Components[i] as TOracleQuery).Session:=SessioneOracle;
    if Components[i] is TOracleDataSet then
      (Components[i] as TOracleDataSet).Session:=SessioneOracle;
    end;
  T201.ReadOnly:=SolaLettura;
  T210.ReadOnly:=SolaLettura;
  T200.Open;
  T201.Open;
  T210.Open;
  Inserimento:=False;
  Cancellazione:=False;
  selControlloVociPaghe:=TControlloVociPaghe.Create(Self,'');
end;

procedure TA022FContrattiDtM1.T200NewRecord(DataSet: TDataSet);
{Inizializzazione nuovo record}
begin
  with T200 do
    begin
    FieldByName('Tipo').AsString:='USL';
    FieldByName('IndTurno').AsString:='A';
    end;
  A022FContratti.EIndTurno.Enabled:=False;
end;

procedure TA022FContrattiDtM1.T200AfterEdit(DataSet: TDataSet);
begin
  CodiceOld:=T200Codice.AsString;
end;

procedure TA022FContrattiDtM1.T200BeforePost(DataSet: TDataSet);
{Abilito l'inserimento della fasce di maggiorazione}
begin
  if QueryPK1.EsisteChiave('T200_CONTRATTI',T200.RowId,T200.State,['CODICE'],[T200Codice.AsString]) then
    raise Exception.Create('Codice già esistente!');
  with T200 do
    begin
    if (FieldByName('ArrIndNot').AsInteger <= FieldByName('TolIndNot').AsInteger) and
       ((FieldByName('ArrIndNot').AsInteger > 0) or (FieldByName('TolIndNot').AsInteger > 0)) then
      raise Exception.Create(A000MSG_A022_ERR_IND_NOTTURNA_ARROT);
    end;
  if T200.State = dsInsert then Inserimento:=True;
  //Aggiorno il codice contratto sulle fasce di maggiorazione
  if T200.State = dsEdit then
    if CodiceOld <> T200Codice.AsString then
      with Q201ModificaContr do
        begin
        SetVariable('Codice',T200Codice.AsString);
        SetVariable('Codice_Old',CodiceOld);
        try
          Execute;
          SessioneOracle.Commit;
        except
          SessioneOracle.Rollback;
          raise;
        end;
        end;
  case DataSet.State of
    dsInsert:RegistraLog.SettaProprieta('I',R180Query2NomeTabella(DataSet),Copy(Name,1,4),DataSet,True);
    dsEdit:RegistraLog.SettaProprieta('M',R180Query2NomeTabella(DataSet),Copy(Name,1,4),DataSet,True);
  end;
end;

procedure TA022FContrattiDtM1.T201BeforeInsert(DataSet: TDataSet);
{Non permetto l'inserimento manuale delle fasce di maggiorazione}
begin
  if not Inserimento then Abort;
end;

procedure TA022FContrattiDtM1.T200AfterPost(DataSet: TDataSet);
{Inserisco le fasce di maggiorazione dopo l'inserimento del contratto}
var i:Byte;
begin
  RegistraLog.RegistraOperazione;
  if Inserimento then
    begin
    for i:= 1 to 9 do
      begin
      T201.Append;
      T201.FieldByName('Codice').AsString:=T200.FieldByName('Codice').AsString;
      T201.FieldByName('Giorno').AsString:=IntToStr(i);
      T201.Post;
      end;
    Inserimento:=False;
    end;
end;

procedure TA022FContrattiDtM1.T201CalcFields(DataSet: TDataSet);
{Calcolo della descrizione del campo Giorno}
begin
  with T201.FieldByName('Giorno'),T201 do
    begin
    if AsString = '1' then FieldByName('D_Giorno').AsString:='Lunedì';
    if AsString = '2' then FieldByName('D_Giorno').AsString:='Martedì';
    if AsString = '3' then FieldByName('D_Giorno').AsString:='Mercoledì';
    if AsString = '4' then FieldByName('D_Giorno').AsString:='Giovedì';
    if AsString = '5' then FieldByName('D_Giorno').AsString:='Venerdì';
    if AsString = '6' then FieldByName('D_Giorno').AsString:='Sabato';
    if AsString = '7' then FieldByName('D_Giorno').AsString:='Domenica';
    if AsString = '8' then FieldByName('D_Giorno').AsString:='Non lav.';
    if AsString = '9' then FieldByName('D_Giorno').AsString:='Festivo';
    end;
end;

procedure TA022FContrattiDtM1.T200BeforeDelete(DataSet: TDataSet);
{Se cancello un contratto, elimino anche le maggiorazioni}
begin
  Cancellazione:=True;
  T201.First;
  while not T201.Eof do
    T201.Delete;
  Cancellazione:=False;
  RegistraLog.SettaProprieta('C',R180Query2NomeTabella(DataSet),Copy(Name,1,4),DataSet,True);  
end;

procedure TA022FContrattiDtM1.T201BeforeDelete(DataSet: TDataSet);
{Non permetto la cancellazione manuale delle fasce di maggiorazione}
begin
  if not Cancellazione then Abort;
end;

procedure TA022FContrattiDtM1.BDET200ReperibilitaValidate(Sender: TField);
{Controllo minuti dei campi ora.minuti}
begin
  if Sender.IsNull then Exit;
  OreMinutiValidate(Sender.AsString);
end;

procedure TA022FContrattiDtM1.BDET201FasciaDa1Validate(Sender: TField);
{Controllo cronologia fasce DA}
var i:Byte;
begin
  i:=Sender.index;
  if (Sender.IsNull) or (T201.Fields[i+1].IsNull) then exit;
  if Sender.AsDateTime > T201.Fields[i+1].AsDateTime then
    Raise Exception.Create('L''ora iniziale della fascia deve essere minore di quella finale!');
end;

procedure TA022FContrattiDtM1.BDET201FasciaA1Validate(Sender: TField);
{Controllo cronologia fasce A}
var i:Byte;
begin
  i:=Sender.index;
  if (Sender.IsNull) or (T201.Fields[i-1].IsNull) then exit;
  if Sender.AsDateTime < T201.Fields[i-1].AsDateTime then
    Raise Exception.Create('L''ora finale della fascia deve essere maggiore di quella iniziale!');
end;

procedure TA022FContrattiDtM1.BDET200IndNotteDaSetText(Sender: TField;
  const Text: string);
begin
  {$I CampoOra}
end;

procedure TA022FContrattiDtM1.T201FasciaValidate(Sender: TField);
{Controllo che la fascia oraria sia esistente}
begin
  if Sender.IsNull then exit;
  if not T210.Locate('Codice',Sender.AsString,[]) then
    raise Exception.Create('Fascia inesistente!');
end;

procedure TA022FContrattiDtM1.BDET200ARRINDNOTValidate(Sender: TField);
{Arrotondamento divisori di 60}
begin
  if Sender.AsInteger = 0 then exit;
  if 60 mod Sender.AsInteger <> 0 then
    raise Exception.Create('I minuti devono essere divisori di 60!');
end;

procedure TA022FContrattiDtM1.A022FContrattiDtM1Destroy(Sender: TObject);
var i:Integer;
begin
  FreeAndNil(selControlloVociPaghe);
  for i:=0 to Self.ComponentCount - 1 do
    if Self.Components[i] is TDataSet then
      (Self.Components[i] as TDataSet).Close;
end;

procedure TA022FContrattiDtM1.T200AfterDelete(DataSet: TDataSet);
begin
  RegistraLog.RegistraOperazione;
end;

procedure TA022FContrattiDtM1.BDET210BeforePost(DataSet: TDataSet);
begin
  case DataSet.State of
    dsInsert:RegistraLog.SettaProprieta('I',R180Query2NomeTabella(DataSet),Copy(Name,1,4),DataSet,True);
    dsEdit:RegistraLog.SettaProprieta('M',R180Query2NomeTabella(DataSet),Copy(Name,1,4),DataSet,True);
  end;
end;

procedure TA022FContrattiDtM1.BDET210BeforeDelete(DataSet: TDataSet);
begin
  RegistraLog.SettaProprieta('C',R180Query2NomeTabella(DataSet),Copy(Name,1,4),DataSet,True);
end;

procedure TA022FContrattiDtM1.BDET210AfterPost(DataSet: TDataSet);
begin
  RegistraLog.RegistraOperazione;
end;

procedure TA022FContrattiDtM1.T200AfterScroll(DataSet: TDataSet);
begin
  with T201 do
    begin
    Close;
    SetVariable('Codice',T200.FieldByname('Codice').AsString);
    Open;
    if (T200.State = dsBrowse) and (RecordCount = 0) then
      begin
      Inserimento:=True;
      T200AfterPost(T200);
      Inserimento:=False;
      end;
    end;
end;

procedure TA022FContrattiDtM1.T201BeforePost(DataSet: TDataSet);
begin
  if DataSet.State = dsEdit then
    RegistraLog.SettaProprieta('M',R180Query2NomeTabella(DataSet),Copy(Name,1,4),DataSet,True);
end;

procedure TA022FContrattiDtM1.T201AfterPost(DataSet: TDataSet);
begin
  if not Inserimento then
    RegistraLog.RegistraOperazione;
end;

procedure TA022FContrattiDtM1.T210BeforePost(DataSet: TDataSet);
var VoceOld:String;
begin
  //Controllo voci paghe
  if (DataSet.State = dsInsert) or (T210.FieldByName('PORE_LAV').medpOldValue = null) then
    VoceOld:=''
  else
    VoceOld:=T210.FieldByName('PORE_LAV').medpOldValue;
  if not selControlloVociPaghe.ControlloVociPaghe(VoceOld,T210.FieldByName('PORE_LAV').AsString) then
    if R180MessageBox(selControlloVociPaghe.MessaggioLog,'DOMANDA') = mrNo then
      Abort
    else
      selControlloVociPaghe.ValutaInserimentoVocePaghe(T210.FieldByName('PORE_LAV').AsString);
  if (DataSet.State = dsInsert) or (T210.FieldByName('PSTR_NEL_MESE').medpOldValue = null) then
    VoceOld:=''
  else
    VoceOld:=T210.FieldByName('PSTR_NEL_MESE').medpOldValue;
  if not selControlloVociPaghe.ControlloVociPaghe(VoceOld,T210.FieldByName('PSTR_NEL_MESE').AsString) then
    if R180MessageBox(selControlloVociPaghe.MessaggioLog,'DOMANDA') = mrNo then
      Abort
    else
      selControlloVociPaghe.ValutaInserimentoVocePaghe(T210.FieldByName('PSTR_NEL_MESE').AsString);
  if (DataSet.State = dsInsert) or (T210.FieldByName('PIND_TUR').medpOldValue = null) then
    VoceOld:=''
  else
    VoceOld:=T210.FieldByName('PIND_TUR').medpOldValue;
  if not selControlloVociPaghe.ControlloVociPaghe(VoceOld,T210.FieldByName('PIND_TUR').AsString) then
    if R180MessageBox(selControlloVociPaghe.MessaggioLog,'DOMANDA') = mrNo then
      Abort
    else
      selControlloVociPaghe.ValutaInserimentoVocePaghe(T210.FieldByName('PIND_TUR').AsString);
  if (DataSet.State = dsInsert) or (T210.FieldByName('PORE_COMP').medpOldValue = null) then
    VoceOld:=''
  else
    VoceOld:=T210.FieldByName('PORE_COMP').medpOldValue;
  if not selControlloVociPaghe.ControlloVociPaghe(VoceOld,T210.FieldByName('PORE_COMP').AsString) then
    if R180MessageBox(selControlloVociPaghe.MessaggioLog,'DOMANDA') = mrNo then
      Abort
    else
      selControlloVociPaghe.ValutaInserimentoVocePaghe(T210.FieldByName('PORE_COMP').AsString);
  case DataSet.State of
    dsInsert:RegistraLog.SettaProprieta('I',R180Query2NomeTabella(DataSet),Copy(Name,1,4),DataSet,True);
    dsEdit:RegistraLog.SettaProprieta('M',R180Query2NomeTabella(DataSet),Copy(Name,1,4),DataSet,True);
  end;
end;

procedure TA022FContrattiDtM1.T210BeforeDelete(DataSet: TDataSet);
begin
  RegistraLog.SettaProprieta('C',R180Query2NomeTabella(DataSet),Copy(Name,1,4),DataSet,True);
end;

procedure TA022FContrattiDtM1.T210AfterDelete(DataSet: TDataSet);
begin
  RegistraLog.RegistraOperazione;
end;

procedure TA022FContrattiDtM1.T200ARR_INDTURNO_PALValidate(Sender: TField);
begin
  if Sender.IsNull then Exit;
  R180OraValidate(Sender.AsString);
end;

procedure TA022FContrattiDtM1.T200IndNotteDaGetText(Sender: TField;
  var Text: string; DisplayText: Boolean);
begin
  if Sender.IsNull then Text:='' else Text:=FormatDateTime('hh:nn',Sender.AsDateTime);
end;

procedure TA022FContrattiDtM1.T201FasciaDa1GetText(Sender: TField;
  var Text: string; DisplayText: Boolean);
begin
  if Sender.IsNull then Text:='' else Text:=FormatDateTime('hh:nn',Sender.AsDateTime);
end;

end.
