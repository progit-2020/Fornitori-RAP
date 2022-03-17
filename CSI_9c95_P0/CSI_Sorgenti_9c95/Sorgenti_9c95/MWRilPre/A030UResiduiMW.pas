unit A030UResiduiMW;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, R005UDataModuleMW, DB, OracleData, C180FunzioniGenerali,
  A000UCostanti, A000USessione, A000UInterfaccia, A003UDataLavoroBis, DatiBloccati, QueryStorico;

type
  TVisualizzaSceltaAnnoForm = function(A: Word):Word of object;

  TA030FResiduiMW = class(TR005FDataModuleMW)
    Q130: TOracleDataSet;
    Q130PROGRESSIVO: TFloatField;
    Q130ANNO: TFloatField;
    Q130D_Anno: TStringField;
    Q130SALDOORELAV: TStringField;
    Q130SALDOOREPO: TStringField;
    Q130ORECOMPENSABILI: TStringField;
    Q130BANCA_ORE: TStringField;
    Q130RIPOSICOMP: TStringField;
    selT275: TOracleDataSet;
    selT131: TOracleDataSet;
    selT131PROGRESSIVO: TIntegerField;
    selT131ANNO: TIntegerField;
    selT131CAUSALE: TStringField;
    selT131C_CAUSALE: TStringField;
    selT131D_CAUSALE: TStringField;
    selT131ORE_FASCIA1: TStringField;
    selT131ORE_FASCIA2: TStringField;
    selT131ORE_FASCIA3: TStringField;
    selT131ORE_FASCIA4: TStringField;
    selT131ORE_FASCIA5: TStringField;
    selT131ORE_FASCIA6: TStringField;
    Q260: TOracleDataSet;
    T264: TOracleDataSet;
    T264Progressivo: TFloatField;
    T264Anno: TFloatField;
    T264CodRaggr: TStringField;
    T264D_Raggruppamento: TStringField;
    T264Residuo1: TStringField;
    T264Residuo2: TStringField;
    T264Residuo3: TStringField;
    T264Residuo4: TStringField;
    T264Residuo5: TStringField;
    T264Residuo6: TStringField;
    selT692: TOracleDataSet;
    selT692PROGRESSIVO: TIntegerField;
    selT692ANNO: TIntegerField;
    selT692BUONIPASTO: TIntegerField;
    selT692TICKET: TIntegerField;
    selSG657: TOracleDataSet;
    SelSG656: TOracleDataSet;
    SelSG656PROGRESSIVO: TIntegerField;
    SelSG656ANNO: TIntegerField;
    SelSG656PROFILO_CREDITI: TStringField;
    SelSG656C_PROFILO_CREDITI: TStringField;
    SelSG656CREDITI: TFloatField;
    Q263: TOracleDataSet;
    Q262: TOracleDataSet;
    D260: TDataSource;
    procedure bdeQ130SALDOORELAVValidate(Sender: TField);
    procedure Q130AfterCancel(DataSet: TDataSet);
    procedure Q130AfterDelete(DataSet: TDataSet);
    procedure Q130AfterPost(DataSet: TDataSet);
    procedure Q130BeforeDelete(DataSet: TDataSet);
    procedure Q130BeforeInsert(DataSet: TDataSet);
    procedure Q130BeforePost(DataSet: TDataSet);
    procedure Q130CalcFields(DataSet: TDataSet);
    procedure Q130NewRecord(DataSet: TDataSet);
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
    procedure selT131AfterPost(DataSet: TDataSet);
    procedure selT131BeforeDelete(DataSet: TDataSet);
    procedure selT131BeforePost(DataSet: TDataSet);
    procedure selT131NewRecord(DataSet: TDataSet);
    procedure T264AnnoChange(Sender: TField);
    procedure T264AfterPost(DataSet: TDataSet);
    procedure T264AfterEdit(DataSet: TDataSet);
    procedure T264AfterScroll(DataSet: TDataSet);
    procedure T264BeforeDelete(DataSet: TDataSet);
    procedure T264BeforePost(DataSet: TDataSet);
    procedure T264NewRecord(DataSet: TDataSet);
    procedure Q260AfterOpen(DataSet: TDataSet);
    procedure Q260FilterRecord(DataSet: TDataSet; var Accept: Boolean);
    procedure selT692AfterPost(DataSet: TDataSet);
    procedure selT692BeforeDelete(DataSet: TDataSet);
    procedure selT692BeforePost(DataSet: TDataSet);
    procedure selT692NewRecord(DataSet: TDataSet);
    procedure SelSG656AfterPost(DataSet: TDataSet);
    procedure SelSG656BeforeDelete(DataSet: TDataSet);
    procedure SelSG656BeforePost(DataSet: TDataSet);
    procedure SelSG656NewRecord(DataSet: TDataSet);
    procedure Q130RIPOSICOMPValidate(Sender: TField);
    procedure selT131ORE_FASCIA1Validate(Sender: TField);
  private
    UMisura:String;
    procedure CambiaPicture;
  public
    Anno:Word;
    VisualizzaSceltaAnnoForm:TVisualizzaSceltaAnnoForm;
    selDatiBloccati:TDatiBloccati;
    procedure SettaProgressivo;
  end;

implementation

{$R *.dfm}

procedure TA030FResiduiMW.DataModuleCreate(Sender: TObject);
begin
  inherited;
  selDatiBloccati:=TDatiBloccati.Create(Self);
  selDatiBloccati.TipoLog:='M';
  UMisura:='G';
  Q130.SetVariable('ORDERBY','ORDER BY ANNO DESC');
  selT131.SetVariable('ORDERBY','ORDER BY ANNO DESC');
  T264.SetVariable('ORDERBY','ORDER BY ANNO DESC,CODRAGGR');
  selT692.SetVariable('ORDERBY','ORDER BY ANNO DESC');
  selSG656.SetVariable('ORDERBY','ORDER BY ANNO DESC');
  Q260.Open;
end;

procedure TA030FResiduiMW.DataModuleDestroy(Sender: TObject);
begin
  FreeAndNil(selDatiBloccati);
end;

procedure TA030FResiduiMW.SettaProgressivo;
begin
  Q130.Close;
  Q130.SetVariable('Progressivo',SelAnagrafe.FieldByName('PROGRESSIVO').AsInteger);
  Q130.Open;
  selT131.Close;
  selT131.SetVariable('Progressivo',SelAnagrafe.FieldByName('PROGRESSIVO').AsInteger);
  selT131.Open;
  T264.SetVariable('Progressivo',SelAnagrafe.FieldByName('PROGRESSIVO').AsInteger);
  T264.Close;
  T264.Open;
  Q263.Close;
  Q263.SetVariable('Prog',SelAnagrafe.FieldByName('PROGRESSIVO').AsInteger);
  Q263.Open;
  selT692.Close;
  selT692.SetVariable('Progressivo',SelAnagrafe.FieldByName('PROGRESSIVO').AsInteger);
  selT692.Open;
  selSG656.Close;
  selSG656.SetVariable('Progressivo',SelAnagrafe.FieldByName('PROGRESSIVO').AsInteger);
  selSG656.Open;
end;

procedure TA030FResiduiMW.Q130AfterCancel(DataSet: TDataSet);
begin
  Q130.CancelUpdates;
end;

procedure TA030FResiduiMW.Q130AfterDelete(DataSet: TDataSet);
begin
  RegistraLog.RegistraOperazione;
  SessioneOracle.Commit;
end;

procedure TA030FResiduiMW.Q130AfterPost(DataSet: TDataSet);
{Scarico le modifiche nella cache sul database}
var Anno:Word;
begin
  Anno:=Q130Anno.AsInteger;
  try
    SessioneOracle.ApplyUpdates([Q130],True);
    RegistraLog.RegistraOperazione;
    SessioneOracle.Commit;
  except
    SessioneOracle.RollBack;
    ShowMessage('Modifiche fallite!');
  end;
  try
    Q130.Close;
  except
    Q130.Close;
  end;
  Q130.Open;
  Q130.CachedUpdates:=True;
  Q130.Locate('Anno',Anno,[]);
end;

procedure TA030FResiduiMW.Q130BeforeDelete(DataSet: TDataSet);
begin
  if selDatiBloccati.DatoBloccato(SelAnagrafe.FieldByName('PROGRESSIVO').AsInteger,Encodedate(StrToInt(Q130.FieldByName('Anno').AsString),1,1),'T130') then
    raise Exception.Create(selDatiBloccati.MessaggioLog);
  RegistraLog.SettaProprieta('C',R180Query2NomeTabella(DataSet),NomeOwner,DataSet,True);
end;

procedure TA030FResiduiMW.Q130BeforeInsert(DataSet: TDataSet);
var A:Word;
begin
  A:=R180Anno(Date);
  if Assigned(VisualizzaSceltaAnnoForm) then
      A:=VisualizzaSceltaAnnoForm(A);
  if Q130.Locate('Anno',A,[]) then
    raise Exception.Create(Format('Residui del %d già esistenti!',[A]));
  Anno:=A;
end;

procedure TA030FResiduiMW.Q130BeforePost(DataSet: TDataSet);
begin
  if selDatiBloccati.DatoBloccato(SelAnagrafe.FieldByName('PROGRESSIVO').AsInteger,Encodedate(StrToInt(Q130.FieldByName('Anno').AsString),1,1),'T130') then
    raise Exception.Create(selDatiBloccati.MessaggioLog);
  if QueryPK1.EsisteChiave('T130_RESIDANNOPREC',Q130.RowId,Q130.State,['PROGRESSIVO','ANNO'],[Q130Progressivo.AsString,Q130Anno.AsString]) then
    raise Exception.Create('Residuo già esistente!');
  if (R180OreMinutiExt(Q130SaldoOrelav.AsString) < R180OreMinutiExt(Q130OreCompensabili.AsString)) and
     (R180OreMinutiExt(Q130OreCompensabili.AsString) > 0) then
    raise Exception.Create('Le ore compensabili non possono superare le ore lavorate!');
  if (R180OreMinutiExt(Q130Banca_Ore.AsString) > 0) and
     (R180OreMinutiExt(Q130OreCompensabili.AsString) < R180OreMinutiExt(Q130Banca_Ore.AsString)) then
    raise Exception.Create('La banca ore residua non può superare le ore compensabili!');
  case DataSet.State of
    dsInsert:RegistraLog.SettaProprieta('I',R180Query2NomeTabella(DataSet),NomeOwner,DataSet,True);
    dsEdit:RegistraLog.SettaProprieta('M',R180Query2NomeTabella(DataSet),NomeOwner,DataSet,True);
  end;
end;

procedure TA030FResiduiMW.Q130CalcFields(DataSet: TDataSet);
{Descrizione residui}
var Anno:Word;
begin
  Anno:=Q130.FieldByName('Anno').AsInteger;
  if Anno = 0 then
    Q130.FieldByName('D_Anno').AsString:=''
  else
    Q130.FieldByName('D_Anno').AsString:='Residui fine ' + IntToStr(Anno - 1);
end;

procedure TA030FResiduiMW.Q130NewRecord(DataSet: TDataSet);
{Impostazioni nuovo record}
begin
  Q130Progressivo.AsInteger:=SelAnagrafe.FieldByName('PROGRESSIVO').AsInteger;
  Q130Anno.AsInteger:=Anno;
  Q130SaldoOreLav.AsString:='  000.00';
  Q130SaldoOrePO.AsString:='-000.00';
end;

procedure TA030FResiduiMW.Q130RIPOSICOMPValidate(Sender: TField);
begin
  if not Sender.IsNull then
    OreMinutiValidate(Sender.AsString);
end;

procedure TA030FResiduiMW.Q260AfterOpen(DataSet: TDataSet);
begin
  DataSet.FieldByName('CODICE').DisplayWidth:=8;
end;

procedure TA030FResiduiMW.Q260FilterRecord(DataSet: TDataSet; var Accept: Boolean);
begin
  Accept:=A000FiltroDizionario('RAGGRUPPAMENTI ASSENZA',DataSet.FieldByName('CODICE').AsString);
end;

procedure TA030FResiduiMW.SelSG656AfterPost(DataSet: TDataSet);
begin
  RegistraLog.RegistraOperazione;
  SessioneOracle.Commit;
end;

procedure TA030FResiduiMW.SelSG656BeforeDelete(DataSet: TDataSet);
begin
  if selDatiBloccati.DatoBloccato(SelAnagrafe.FieldByName('PROGRESSIVO').AsInteger,Encodedate(StrToInt(selSG656.FieldByName('Anno').AsString),1,1),'SG656') then
    raise Exception.Create(selDatiBloccati.MessaggioLog);
  RegistraLog.SettaProprieta('C',R180Query2NomeTabella(DataSet),NomeOwner,DataSet,True);
end;

procedure TA030FResiduiMW.SelSG656BeforePost(DataSet: TDataSet);
begin
  if selDatiBloccati.DatoBloccato(SelAnagrafe.FieldByName('PROGRESSIVO').AsInteger,Encodedate(StrToInt(selSG656.FieldByName('Anno').AsString),1,1),'SG656') then
    raise Exception.Create(selDatiBloccati.MessaggioLog);
  if QueryPK1.EsisteChiave('SG656_RESIDUOCREDITI',selSG656.RowId,selSG656.State,['PROGRESSIVO','ANNO','PROFILO_CREDITI'],[selSG656Progressivo.AsString,selSG656Anno.AsString,selSG656C_Profilo_Crediti.AsString]) then
    raise Exception.Create('Residuo già esistente!');
  case DataSet.State of
    dsInsert:RegistraLog.SettaProprieta('I',R180Query2NomeTabella(DataSet),NomeOwner,DataSet,True);
    dsEdit:RegistraLog.SettaProprieta('M',R180Query2NomeTabella(DataSet),NomeOwner,DataSet,True);
  end;
end;

procedure TA030FResiduiMW.SelSG656NewRecord(DataSet: TDataSet);
begin
  SelSG656.FieldByName('Progressivo').AsInteger:=SelAnagrafe.FieldByName('PROGRESSIVO').AsInteger;
end;

procedure TA030FResiduiMW.selT131AfterPost(DataSet: TDataSet);
begin
  RegistraLog.RegistraOperazione;
  SessioneOracle.Commit; //Massimo: gestione log
end;

procedure TA030FResiduiMW.selT131BeforeDelete(DataSet: TDataSet);
begin
  if selDatiBloccati.DatoBloccato(SelAnagrafe.FieldByName('PROGRESSIVO').AsInteger,Encodedate(StrToInt(selT131.FieldByName('Anno').AsString),1,1),'T131') then
    raise Exception.Create(selDatiBloccati.MessaggioLog);
  RegistraLog.SettaProprieta('C',R180Query2NomeTabella(DataSet),NomeOwner,DataSet,True);
end;

procedure TA030FResiduiMW.selT131BeforePost(DataSet: TDataSet);
begin
  if selDatiBloccati.DatoBloccato(SelAnagrafe.FieldByName('PROGRESSIVO').AsInteger,Encodedate(StrToInt(selT131.FieldByName('Anno').AsString),1,1),'T131') then
    raise Exception.Create(selDatiBloccati.MessaggioLog);
  if QueryPK1.EsisteChiave('T131_RESIDPRESENZE',selT131.RowId,selT131.State,['PROGRESSIVO','ANNO','CAUSALE'],[selT131Progressivo.AsString,selT131Anno.AsString,selT131Causale.AsString]) then
    raise Exception.Create('Residuo già esistente!');
  case DataSet.State of
    dsInsert:RegistraLog.SettaProprieta('I',R180Query2NomeTabella(DataSet),NomeOwner,DataSet,True);
    dsEdit:RegistraLog.SettaProprieta('M',R180Query2NomeTabella(DataSet),NomeOwner,DataSet,True);
  end;
end;

procedure TA030FResiduiMW.selT131NewRecord(DataSet: TDataSet);
begin
  selT131.FieldByName('PROGRESSIVO').AsInteger:=SelAnagrafe.FieldByName('PROGRESSIVO').AsInteger;
end;

procedure TA030FResiduiMW.selT131ORE_FASCIA1Validate(Sender: TField);
begin
  OreMinutiValidate(Sender.AsString);
end;

procedure TA030FResiduiMW.selT692AfterPost(DataSet: TDataSet);
begin
  RegistraLog.RegistraOperazione;
  SessioneOracle.Commit;
end;

procedure TA030FResiduiMW.selT692BeforeDelete(DataSet: TDataSet);
begin
  if selDatiBloccati.DatoBloccato(SelAnagrafe.FieldByName('PROGRESSIVO').AsInteger,Encodedate(StrToInt(selT692.FieldByName('Anno').AsString),1,1),'T692') then
    raise Exception.Create(selDatiBloccati.MessaggioLog);
  RegistraLog.SettaProprieta('C',R180Query2NomeTabella(DataSet),NomeOwner,DataSet,True);
end;

procedure TA030FResiduiMW.selT692BeforePost(DataSet: TDataSet);
begin
  if selDatiBloccati.DatoBloccato(SelAnagrafe.FieldByName('PROGRESSIVO').AsInteger,Encodedate(StrToInt(selT692.FieldByName('Anno').AsString),1,1),'T692') then
    raise Exception.Create(selDatiBloccati.MessaggioLog);
  if QueryPK1.EsisteChiave('T692_RESIDUOBUONI',selT692.RowId,selT692.State,['PROGRESSIVO','ANNO'],[selT692Progressivo.AsString,selT692Anno.AsString]) then
    raise Exception.Create('Residuo già esistente!');
  case DataSet.State of
    dsInsert:RegistraLog.SettaProprieta('I',R180Query2NomeTabella(DataSet),NomeOwner,DataSet,True);
    dsEdit:RegistraLog.SettaProprieta('M',R180Query2NomeTabella(DataSet),NomeOwner,DataSet,True);
  end;
end;

procedure TA030FResiduiMW.selT692NewRecord(DataSet: TDataSet);
begin
  selT692.FieldByName('Progressivo').AsInteger:=SelAnagrafe.FieldByName('PROGRESSIVO').AsInteger;
end;

procedure TA030FResiduiMW.T264AfterEdit(DataSet: TDataSet);
{Abilito/disabilito i controlli prima di modificare il record}
begin
  T264AnnoChange(T264Anno);
end;

procedure TA030FResiduiMW.T264AfterPost(DataSet: TDataSet);
begin
  RegistraLog.RegistraOperazione;
  SessioneOracle.Commit;
end;

procedure TA030FResiduiMW.T264AfterScroll(DataSet: TDataSet);
var i:Byte;
begin
  for i:=4 to 9 do
    T264.Fields[i].EditMask:='';
end;

procedure TA030FResiduiMW.T264BeforeDelete(DataSet: TDataSet);
begin
  if selDatiBloccati.DatoBloccato(SelAnagrafe.FieldByName('PROGRESSIVO').AsInteger,Encodedate(StrToInt(T264.FieldByName('Anno').AsString),1,1),'T264') then
    raise Exception.Create(selDatiBloccati.MessaggioLog);
  RegistraLog.SettaProprieta('C',R180Query2NomeTabella(DataSet),NomeOwner,DataSet,True);
end;

procedure TA030FResiduiMW.T264BeforePost(DataSet: TDataSet);
begin
  if selDatiBloccati.DatoBloccato(SelAnagrafe.FieldByName('PROGRESSIVO').AsInteger,Encodedate(StrToInt(T264.FieldByName('Anno').AsString),1,1),'T264') then
    raise Exception.Create(selDatiBloccati.MessaggioLog);
  if QueryPK1.EsisteChiave('T264_RESIDASSANN',T264.RowId,T264.State,['PROGRESSIVO','ANNO','CODRAGGR'],[T264Progressivo.AsString,T264Anno.AsString,T264CodRaggr.AsString]) then
    raise Exception.Create('Residuo già esistente!');
  T264Residuo1.AsString:=StringReplace(T264Residuo1.AsString,' ','',[rfReplaceAll]);
  T264Residuo2.AsString:=StringReplace(T264Residuo2.AsString,' ','',[rfReplaceAll]);
  T264Residuo3.AsString:=StringReplace(T264Residuo3.AsString,' ','',[rfReplaceAll]);
  T264Residuo4.AsString:=StringReplace(T264Residuo4.AsString,' ','',[rfReplaceAll]);
  T264Residuo5.AsString:=StringReplace(T264Residuo5.AsString,' ','',[rfReplaceAll]);
  T264Residuo6.AsString:=StringReplace(T264Residuo6.AsString,' ','',[rfReplaceAll]);
  case DataSet.State of
    dsInsert:RegistraLog.SettaProprieta('I',R180Query2NomeTabella(DataSet),NomeOwner,DataSet,True);
    dsEdit:RegistraLog.SettaProprieta('M',R180Query2NomeTabella(DataSet),NomeOwner,DataSet,True);
  end;
end;

procedure TA030FResiduiMW.T264NewRecord(DataSet: TDataSet);
{Record nuovo:Unita di misura = Giorni}
begin
  T264.FieldByName('Progressivo').AsInteger:=SelAnagrafe.FieldByName('PROGRESSIVO').AsInteger;
end;

procedure TA030FResiduiMW.T264AnnoChange(Sender: TField);
{Ricerco il profilo assenze individuali o annuali al cambiamento
di anno o raggruppamento per risalire all'unità di misura}
var Trovato:Boolean;
    DataStorico:TDateTime;
    QSProfAsse:TQueryStorico;
begin
  if Sender = T264Anno then
    if Trim(T264.FieldByName('CodRaggr').AsString) = '' then exit;
  if Sender = T264CodRaggr then
    if Trim(T264.FieldByName('Anno').AsString) = '' then exit;
  {Cerco su profilo individuale}
  with Q263(*,A011FResiduiAsse*) do
    Trovato:=Locate('Anno;CodRaggr',
       VarArrayOf([T264.FieldByName('Anno').AsInteger,T264.FieldByName('CodRaggr').AsString]),[]);
  if Trovato then
    UMisura:=Q263.FieldByName('UMisura').AsString
  else
  begin
    {Cerco su profilo Annuale}
    DataStorico:=StrToDate('01/01/' + T264.FieldByName('Anno').AsString);
    QSProfAsse:=TQueryStorico.Create(nil);
    QSProfAsse.Session:=SessioneOracle;
    QSProfAsse.GetDatiStorici('T430PASSENZE',SelAnagrafe.FieldByName('PROGRESSIVO').AsInteger,DataStorico,EncodeDate(3999,12,31));
    if not QSProfAsse.LocDatoStorico(DataStorico) then
      QSProfAsse.First;
    Q262.Close;
    Q262.SetVariable('Anno',T264.FieldByName('Anno').AsInteger);
    Q262.SetVariable('CodProfilo',QSProfAsse.FieldByName('T430PASSENZE').AsString);
    Q262.SetVariable('CodRaggr',T264.FieldByName('CodRaggr').AsString);
    Q262.Open;
    Trovato:=Q262.RecordCount > 0;
    QSProfAsse.Free;
    if Trovato then
      UMisura:=Q262.FieldByName('UMisura').AsString
    else
      {Cerco direttamente sulla causale}
      UMisura:=Q260.Lookup('CODICE',T264.FieldByName('CodRaggr').AsString,'UMISURA');
  end;
  CambiaPicture;
end;

procedure TA030FResiduiMW.CambiaPicture;
{Cambia la EditMask dei campi a seconda dell'unità di misura}
var i:Byte;
begin
  with T264 do
    for i:=4 to 9 do
      if UMisura = 'O' then
        Fields[i].EditMask:='!#990.00;1;_'
      else
        Fields[i].EditMask:='!#90,9;1;_';
end;

procedure TA030FResiduiMW.bdeQ130SALDOORELAVValidate(Sender: TField);
begin
  if Sender.IsNull then
    exit;
  OreMinutiValidate(Sender.AsString);
end;


end.
