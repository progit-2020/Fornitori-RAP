unit A012UCalendariDtM1;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  DB, A000UCostanti, A000USessione,A000UInterfaccia, RegistrazioneLog, OracleData, Oracle,
  C180FunzioniGenerali, Variants, StrUtils, DBCtrls;

type
  TA012FCalendariDtM1 = class(TDataModule)
    Q010: TOracleDataSet;
    Q010CODICE: TStringField;
    Q010DESCRIZIONE: TStringField;
    Q010LUNEDI: TStringField;
    Q010MARTEDI: TStringField;
    Q010MERCOLEDI: TStringField;
    Q010GIOVEDI: TStringField;
    Q010VENERDI: TStringField;
    Q010SABATO: TStringField;
    Q010DOMENICA: TStringField;
    Q011: TOracleDataSet;
    CancQ011: TOracleQuery;
    GeneraCal: TOracleQuery;
    UpdQ011: TOracleQuery;
    selT013: TOracleDataSet;
    dsrT013: TDataSource;
    selT013CODICE: TStringField;
    selT013ANNO: TIntegerField;
    selT013MESE: TIntegerField;
    selT013GIORNO: TIntegerField;
    Q010IGNORAFESTIVITA: TStringField;
    Q010NUMGG_LAV: TIntegerField;
    procedure Q010AfterInsert(DataSet: TDataSet);
    procedure Q010BeforeDelete(DataSet: TDataSet);
    procedure A004FCalendariDtM1Create(Sender: TObject);
    procedure A012FCalendariDtM1Destroy(Sender: TObject);
    procedure Q010AfterCancel(DataSet: TDataSet);
    procedure Q010AfterDelete(DataSet: TDataSet);
    procedure Q010AfterPost(DataSet: TDataSet);
    procedure Q010BeforePost(DataSet: TDataSet);
    procedure Q011BeforePost(DataSet: TDataSet);
    procedure Q010FilterRecord(DataSet: TDataSet; var Accept: Boolean);
    procedure Q010AfterScroll(DataSet: TDataSet);
    procedure selT013BeforePost(DataSet: TDataSet);
    procedure Q010NUMGG_LAVValidate(Sender: TField);
  private
    { Private declarations }
    VecchioCodiceDizionario:String;
  public
    { Public declarations }
    procedure GeneraCalendario(DaGiorno,AGiorno:TDateTime);
  end;

var
  A012FCalendariDtM1: TA012FCalendariDtM1;

implementation

uses A012UCalendari;

{$R *.DFM}

procedure TA012FCalendariDtM1.A004FCalendariDtM1Create(Sender: TObject);
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
  Q010.Open;
  A012FCalendari.DButton.DataSet:=Q010;
  //Q011.Prepare;
  //CancQ011.Prepare;
end;

procedure TA012FCalendariDtM1.Q010AfterInsert(DataSet: TDataSet);
begin
  Q010['Lunedi']:='S';
  Q010['Martedi']:='S';
  Q010['Mercoledi']:='S';
  Q010['Giovedi']:='S';
  Q010['Venerdi']:='S';
  Q010['Sabato']:='N';
  Q010['Domenica']:='N';
end;

procedure TA012FCalendariDtM1.Q010BeforeDelete(DataSet: TDataSet);
{Cancello i giorni usando la Cache}
begin
  CancQ011.SetVariable('Codice',Q010['Codice']);
  CancQ011.Execute;
  RegistraLog.SettaProprieta('C','T010_CALENDIMPOSTAZ',Copy(Name,1,4),Q010,True);
  A000AggiornaFiltroDizionario('CALENDARI',Q010.FieldByName('Codice').AsString,'');
end;

procedure TA012FCalendariDtM1.Q010AfterCancel(DataSet: TDataSet);
begin
  Q010.CancelUpdates;
  selT013.CancelUpdates;
end;

procedure TA012FCalendariDtM1.Q010AfterDelete(DataSet: TDataSet);
begin
  try
    SessioneOracle.ApplyUpdates([Q010],True);
    RegistraLog.RegistraOperazione;
    SessioneOracle.Commit;
  except
    SessioneOracle.Rollback;
  end;
end;

procedure TA012FCalendariDtM1.Q010AfterPost(DataSet: TDataSet);
var Calend:String;
begin
  Calend:=Q010Codice.AsString;
  try
    SessioneOracle.ApplyUpdates([Q010,selT013],True);
    SessioneOracle.Commit;
    RegistraLog.RegistraOperazione;
  except
    SessioneOracle.Rollback;
  end;
  A000AggiornaFiltroDizionario('CALENDARI',VecchioCodiceDizionario,Calend);
  Q010.Close;
  Q010.Open;
  Q010.Locate('Codice',Calend,[]);
end;

procedure TA012FCalendariDtM1.Q010AfterScroll(DataSet: TDataSet);
begin
  selT013.Close;
  selT013.SetVariable('CODICE',Q010.FieldBYName('CODICE').AsString);
  selT013.Open;
end;

procedure TA012FCalendariDtM1.GeneraCalendario(DaGiorno,AGiorno:TDateTime);
begin
  GeneraCal.SetVariable('DAL',DaGiorno);
  GeneraCal.SetVariable('AL',AGiorno);
  GeneraCal.SetVariable('COD',Q010.FieldByName('CODICE').AsString);
  GeneraCal.Execute;
  RegistraLog.SettaProprieta('I','T011_CALENDARI',Copy(Name,1,4),nil,True);
  RegistraLog.InserisciDato('GENERAZIONE','',Format('%s %s - %s',[Q010.FieldByName('CODICE').AsString,DateToStr(DaGiorno),DateToStr(AGiorno)]));
  RegistraLog.RegistraOperazione;
end;

(*procedure TA012FCalendariDtM1.CalcoloPasqua;
{Calcolo della Pasqua e Pasquetta}
var aaLeft,aaRight:String;
begin
  aaLeft:=Copy(IntToStr(Anno0),1,2);
  aaRight:=Copy(IntToStr(Anno0),3,2);
  S_Anno:=StrToInt(aaLeft);
  D_Anno:=StrToInt(aaRight);
  VarCal:=Anno0 div 19;
  Anno1:=Anno0 - VarCal * 19;
  VarCal:=S_Anno div 30;
  Anno2:=S_Anno - VarCal * 30;
  VarCal:=(S_Anno - 15) div 25;
  Anno3:=(S_Anno - 15) - VarCal * 25;
  VarCal:=S_Anno div 4;
  VarCal1:=Anno3 div 3;
  VarCal2:=(S_Anno - 15) div 25;
  Ope1:=30 + Anno1 * 11 - Anno2 + VarCal + VarCal2 * 8 + VarCal1;
  VarCal:=Ope1 div 30;
  Ope:=Ope1 - VarCal * 30;
  if Ope <> 11 then
    begin
    if Ope > 11 then
      begin
      VarCal:=Anno0 div 19;
      Anno4:=VarCal * 19;
      if (Ope = 12) and (Anno4 > 10) then Ope:=13;
      end
    else
      Ope:=Ope + 30;
    end
  else
    Ope:=12;
  VarCal:=S_Anno div 4;
  Anno4:=S_Anno - VarCal * 4;
  VarCal:=D_Anno div 4;
  Erre1:=D_Anno + VarCal + Anno4 * 5 + Ope * 6;
  VarCal:=Erre1 div 7;
  Erre:=Erre1 - VarCal * 7;
  gPasqua:=68 - Ope - Erre;
  mPasqua:=3;
  if gPasqua < 32 then
    begin
    if gPasqua < 31 then
      begin
      gPasquetta:=gPasqua+1;
      mPasquetta:=mPasqua;
      end
    else
      begin
      gPasquetta:=gPasqua + 1 - 31;
      mPasquetta:=4;
      end;
    end
  else
    begin
    gPasqua:=gPasqua - 31;
    mPasqua:=4;
    gPasquetta:=gPasqua+1;
    mPasquetta:=mPasqua;
    end;
end;*)

procedure TA012FCalendariDtM1.A012FCalendariDtM1Destroy(Sender: TObject);
var i:Integer;
begin
  for i:=0 to Self.ComponentCount - 1 do
    if Self.Components[i] is TDataSet then
      (Self.Components[i] as TDataSet).Close;
end;

procedure TA012FCalendariDtM1.Q010BeforePost(DataSet: TDataSet);
var NGGLav:Integer;

  function GGLavChange:Boolean;
  begin
    Result:=False;
    if Q010.FieldByName('LUNEDI').medpOldValue <> Q010.FieldByName('LUNEDI').Value then
      Result:=True;
    if Q010.FieldByName('MARTEDI').medpOldValue <> Q010.FieldByName('MARTEDI').Value then
      Result:=True;
    if Q010.FieldByName('MERCOLEDI').medpOldValue <> Q010.FieldByName('MERCOLEDI').Value then
      Result:=True;
    if Q010.FieldByName('GIOVEDI').medpOldValue <> Q010.FieldByName('GIOVEDI').Value then
      Result:=True;
    if Q010.FieldByName('VENERDI').medpOldValue <> Q010.FieldByName('VENERDI').Value then
      Result:=True;
    if Q010.FieldByName('SABATO').medpOldValue <> Q010.FieldByName('SABATO').Value then
      Result:=True;
    if Q010.FieldByName('DOMENICA').medpOldValue <> Q010.FieldByName('DOMENICA').Value then
      Result:=True;
  end;

begin
  NGGLav:=0;
  //Calcolo N GG lavorativi
  if Q010.FieldByName('LUNEDI').AsString = 'S' then
    inc(NGGLav);
  if Q010.FieldByName('MARTEDI').AsString = 'S' then
    inc(NGGLav);
  if Q010.FieldByName('MERCOLEDI').AsString = 'S' then
    inc(NGGLav);
  if Q010.FieldByName('GIOVEDI').AsString = 'S' then
    inc(NGGLav);
  if Q010.FieldByName('VENERDI').AsString = 'S' then
    inc(NGGLav);
  if Q010.FieldByName('SABATO').AsString = 'S' then
    inc(NGGLav);
  if Q010.FieldByName('DOMENICA').AsString = 'S' then
    inc(NGGLav);
  if (not Q010.FieldByName('NUMGG_LAV').IsNull) and
     (Q010.FieldByName('NUMGG_LAV').AsInteger <> NGGLav) then
  begin
    if (VarToStr(Q010.FieldByName('NUMGG_LAV').Value) <> VarToStr(Q010.FieldByName('NUMGG_LAV').OldValue)) or GGLavChange then
      if R180MessageBox('Attenzione! I giorni lavorativi specificati sono diversi da ' + Q010.FieldByName('NUMGG_LAV').AsString + '.' + #13#10 +
                        'Confermare?', DOMANDA) = mrNo then
        Abort;
  end
  else if (not Q010.FieldByName('NUMGG_LAV').IsNull) and (Q010.FieldByName('NUMGG_LAV').AsInteger = NGGLav) then
    Q010.FieldByName('NUMGG_LAV').Clear;

  if DataSet.State in [dsEdit] then
    VecchioCodiceDizionario:=Q010.FieldByName('Codice').medpOldValue
  else
    VecchioCodiceDizionario:='';
  if QueryPK1.EsisteChiave('T010_CALENDIMPOSTAZ',Q010.RowId,Q010.State,['CODICE'],[Q010Codice.AsString]) then
    raise Exception.Create('Codice già esistente!');
  case DataSet.State of
    dsInsert:RegistraLog.SettaProprieta('I','T010_CALENDIMPOSTAZ',Copy(Name,1,4),Q010,True);
    dsEdit:RegistraLog.SettaProprieta('M','T010_CALENDIMPOSTAZ',Copy(Name,1,4),Q010,True);
  end;

  //Aggiorno codice su T013
  with selT013 do
  try
    First;
    while not Eof do
    begin
      Edit;
      FieldByName('CODICE').AsString:=Q010.FieldByName('Codice').AsString;
      Post;
      Next;
    end;
    DisableControls;
  finally
    First;
    EnableControls;
  end;
  if (Q010.State = dsEdit) and (Q010.FieldByName('Codice').Value <> Q010.FieldByName('Codice').medpOldValue) then
  begin
    UpdQ011.SetVariable('NewCodice',Q010.FieldByName('Codice').Value);
    UpdQ011.SetVariable('OldCodice',Q010.FieldByName('Codice').medpOldValue);
    UpdQ011.Execute;
  end;
end;

procedure TA012FCalendariDtM1.Q011BeforePost(DataSet: TDataSet);
begin
  RegistraLog.SettaProprieta('M','T011_CALENDARI',Copy(Name,1,4),Q011,True);
  RegistraLog.RegistraOperazione;
end;

procedure TA012FCalendariDtM1.selT013BeforePost(DataSet: TDataSet);
var D:TDateTime;
begin
  with DataSet do
    if FieldByName('ANNO').AsInteger > 0 then
      D:=EncodeDate(FieldByName('ANNO').AsInteger,FieldByName('MESE').AsInteger,FieldByName('Giorno').AsInteger)
    else
      D:=EncodeDate(R180Anno(Date),FieldByName('MESE').AsInteger,FieldByName('Giorno').AsInteger);
end;

procedure TA012FCalendariDtM1.Q010FilterRecord(DataSet: TDataSet;
  var Accept: Boolean);
begin
  Accept:=A000FiltroDizionario('CALENDARI',DataSet.FieldByName('CODICE').AsString);
end;

procedure TA012FCalendariDtM1.Q010NUMGG_LAVValidate(Sender: TField);
begin
  if (Sender.AsInteger < 0) or (Sender.AsInteger > 7) then
    raise Exception.Create('Inserire un numero tra 0 e 7.');
end;

end.
