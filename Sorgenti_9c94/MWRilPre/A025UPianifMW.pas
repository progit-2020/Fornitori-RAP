unit A025UPianifMW;

interface

uses
  Windows, Messages, SysUtils, StrUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, R005UDataModuleMW, Oracle, DB, OracleData, DBClient, A000UMessaggi, A000UCostanti,
  A000UInterfaccia, A000USessione, C180FunzioniGenerali, DatiBloccati;

type
  TA025DataSetEvnt = procedure(DataSet: TDataSet) of object;
  TA025GetData = function :TDateTime of object;
  TA025CheckData = function :boolean of object;

  TA025FPianifMW = class(TR005FDataModuleMW)
    insT012: TOracleQuery;
    delT012: TOracleQuery;
    updT080: TOracleQuery;
    insT080: TOracleQuery;
    delT080: TOracleQuery;
    selT081: TOracleDataSet;
    cdsMotivazione: TClientDataSet;
    selDatoLibero: TOracleDataSet;
    dsrDatoLibero: TDataSource;
    selV010: TOracleDataSet;
    selV010DATA: TDateTimeField;
    selV010LAVORATIVO: TStringField;
    selV010FESTIVO: TStringField;
    selV010CALEND_INDIVID: TStringField;
    selV010PROGRESSIVO: TFloatField;
    selV010NUMGIORNI: TFloatField;
    selV010calcCALEND_INDIVID: TStringField;
    dscV010: TDataSource;
    Q163: TOracleDataSet;
    D163: TDataSource;
    Q020: TOracleDataSet;
    D020: TDataSource;
    procedure selDatoLiberoAfterOpen(DataSet: TDataSet);
    procedure selV010BeforeDelete(DataSet: TDataSet);
    procedure selV010BeforeInsert(DataSet: TDataSet);
    procedure selV010BeforePost(DataSet: TDataSet);
    procedure selV010ApplyRecord(Sender: TOracleDataSet; Action: Char; var Applied: Boolean; var NewRowId: string);
    procedure FiltroDizionario(DataSet: TDataSet; var Accept: Boolean);
    procedure selV010CalcFields(DataSet: TDataSet);
    procedure Q163AfterOpen(DataSet: TDataSet);
    procedure DataModuleDestroy(Sender: TObject);
    procedure Q020AfterOpen(DataSet: TDataSet);
    procedure Q020FilterRecord(DataSet: TDataSet; var Accept: Boolean);
  private
    //function ProgressivoC700: Integer; // ereditata
  public
    DataCorrente: TDateTime;
    Turno1EUItemIndex, Turno2EUItemIndex :Integer;
    DatoLiberoEnabled, PulIndennitaChecked, PulOrarioChecked, PulDatoChecked :boolean;
    Turno1, Turno1EU, Turno2, Turno2EU, Orario, Indennita, DatoLibero, DatoLiberoCaption: String;
    SelDatiBloccati: TDatiBloccati;
    CampoOrarioVisibile: TA025CheckData;
    CalcolaDataDa, CalcolaDataA: TA025GetData;
    SelT080: TOracleDataSet;
    DimensionaCmbDatiLiberi: TA025DataSetEvnt;
    procedure OpenV010;
    procedure SetSelT080;
    procedure Inizializza;
    procedure ResetCalendario;
    procedure SelT080BeforePost;
    procedure SelT080BeforeDelete;
    procedure InserisciPianificazione;
    procedure AggiornaPianificazione;
    procedure ControlliInsPianificazione;
    procedure SelT080NewRecord;
    procedure CancellaT080(DataDa, DataA: TDateTime);
    procedure CancCalendari(DataDa, DataA: TDateTime);
    procedure CancellaPianificazione(DataDa, DataA: TDateTime);
    const
      D_Turno:array[0..9] of TItemsValues = (
        (Item:'0';   Value:'0 - Riposo'),
        (Item:'1';   Value:'1'),
        (Item:'2';   Value:'2'),
        (Item:'3';   Value:'3'),
        (Item:'4';   Value:'4'),
        (Item:'5';   Value:'5'),
        (Item:'6';   Value:'6'),
        (Item:'7';   Value:'7'),
        (Item:'8';   Value:'8'),
        (Item:'9';   Value:'9')
        );
      D_TurnoEU:array[0..2] of TItemsValues = (
        (Item:' ';   Value:' '),
        (Item:'E';   Value:'E'),
        (Item:'U';   Value:'U')
        );
      D_Calend:array[0..1] of TItemsValues = (
        (Item:'S';   Value:'S'),
        (Item:'N';   Value:'N')
        );
  end;

implementation

{$R *.dfm}

procedure TA025FPianifMW.Inizializza;
begin
  OpenV010;
  cdsMotivazione.CreateDataSet;
  cdsMotivazione.Append;
  cdsMotivazione.FieldByName('CODICE').AsString:='';
  cdsMotivazione.FieldByName('DESCRIZIONE').AsString:='';
  cdsMotivazione.Post;
  cdsMotivazione.Append;
  cdsMotivazione.FieldByName('CODICE').AsString:='NO';
  cdsMotivazione.FieldByName('DESCRIZIONE').AsString:='Esigenze di servizio';
  cdsMotivazione.Post;
  selDatiBloccati:=TDatiBloccati.Create(nil);
  selDatiBloccati.TipoLog:='M';
end;

procedure TA025FPianifMW.DataModuleDestroy(Sender: TObject);
begin
  inherited;
  selDatiBloccati.Free;
end;

procedure TA025FPianifMW.Q020AfterOpen(DataSet: TDataSet);
begin
  DataSet.FieldByName('CODICE').DisplayWidth:=8;
end;

procedure TA025FPianifMW.Q020FilterRecord(DataSet: TDataSet; var Accept: Boolean);
begin
  Accept:=A000FiltroDizionario('MODELLI ORARIO',DataSet.FieldByName('CODICE').AsString);
end;

procedure TA025FPianifMW.Q163AfterOpen(DataSet: TDataSet);
begin
  DataSet.FieldByName('CODICE').DisplayWidth:=8;
end;

procedure TA025FPianifMW.FiltroDizionario(DataSet: TDataSet; var Accept: Boolean);
begin
  Accept:=A000FiltroDizionario('PROFILI INDENNITA',DataSet.FieldByName('CODICE').AsString);
end;

procedure TA025FPianifMW.selDatoLiberoAfterOpen(DataSet: TDataSet);
begin
  selDatoLibero.Fields[0].DisplayWidth:=selDatoLibero.Fields[0].Size + 2;
  selDatoLibero.Fields[1].DisplayWidth:=selDatoLibero.Fields[1].Size;
  if Assigned(DimensionaCmbDatiLiberi) then
    DimensionaCmbDatiLiberi(DataSet);
end;

procedure TA025FPianifMW.selV010ApplyRecord(Sender: TOracleDataSet; Action: Char; var Applied: Boolean; var NewRowId: string);
begin
  //D(elete) U(pdate) I(nsert)
  Applied:=True;
  if R180In(Action,['U','I']) and selV010.UpdatesPending then
  begin
    CancCalendari(Sender.FieldByName('DATA').AsDateTime,
                  Sender.FieldByName('DATA').AsDateTime);
    with InsT012 do
    begin
      ClearVariables;
      SetVariable('PROGRESSIVO',Sender.FieldByName('PROGRESSIVO').AsInteger);
      SetVariable('DATA',Sender.FieldByName('DATA').AsDateTime);
      SetVariable('LAVORATIVO',Sender.FieldByName('LAVORATIVO').AsString);
      SetVariable('FESTIVO',Sender.FieldByName('FESTIVO').AsString);
      SetVariable('NUMGIORNI',Sender.FieldByName('NUMGIORNI').AsInteger);
      Execute;
    end;
  end;
  case Action of
    'I':RegistraLog.SettaProprieta('I','T012_CALENDINDIVID',NomeOwner,Sender,True);
    'U':RegistraLog.SettaProprieta('M','T012_CALENDINDIVID',NomeOwner,Sender,True);
  end;
  if Action in ['I','U'] then
    RegistraLog.RegistraOperazione;
end;

procedure TA025FPianifMW.selV010BeforeDelete(DataSet: TDataSet);
begin
  Abort;
end;

procedure TA025FPianifMW.selV010BeforeInsert(DataSet: TDataSet);
begin
  Abort;
end;

procedure TA025FPianifMW.selV010BeforePost(DataSet: TDataSet);
begin
  DataSet.FieldByName('LAVORATIVO').AsString:=UpperCase(DataSet.FieldByName('LAVORATIVO').AsString);
  DataSet.FieldByName('FESTIVO').AsString:=UpperCase(DataSet.FieldByName('FESTIVO').AsString);
  if (Not R180In(DataSet.FieldByName('FESTIVO').AsString,['S','N'])) or
     (Not R180In(DataSet.FieldByName('LAVORATIVO').AsString,['S','N'])) then
    raise Exception.Create(A000MSG_ERR_DATO_BOOLEAN_ERRATO);
end;

procedure TA025FPianifMW.selV010CalcFields(DataSet: TDataSet);
begin
  selV010.FieldByName('calcCALEND_INDIVID').AsString:=IfThen(selV010.FieldByName('CALEND_INDIVID').AsString = 'S','Individuale','Standard');
end;

// ereditata
{
function TA025FPianifMW.ProgressivoC700:Integer;
begin
  if SelAnagrafe <> nil then
    Result:=SelAnagrafe.FieldByName('PROGRESSIVO').AsInteger
  else
    Result:=0;
end;
}

procedure TA025FPianifMW.SetSelT080;
var DataDa,DataA:TDateTime;
begin
  selT081.Close;
  selT081.ClearVariables;
  selT081.SetVariable('PROGRESSIVO',ProgressivoC700);
  selT081.Open;
  SelT080.FieldByName('D_MOTIVAZIONE').Visible:=selT081.FieldByName('COUNT').AsInteger > 0;
  SelT080.DisableControls;
  SelT080.Close;
  DataDa:=CalcolaDataDa;
  DataA:=CalcolaDataA;
  SelT080.SetVariable('Progressivo',ProgressivoC700);
  SelT080.SetVariable('Data1',DataDa);
  SelT080.SetVariable('Data2',DataA);
  SelT080.Open;
  SelT080.EnableControls;
end;

procedure TA025FPianifMW.OpenV010;
var DataDa, DataA:TDateTime;
begin
  DataDa:=CalcolaDataDa;
  DataA:=CalcolaDataA;
  R180SetVariable(selV010,'PROGRESSIVO',ProgressivoC700);
  R180SetVariable(selV010,'DATA1', DataDa);
  R180SetVariable(selV010,'DATA2', DataA);
  selV010.Open;
end;

procedure TA025FPianifMW.CancCalendari(DataDa, DataA:TDateTime);
begin
  with delT012 do
  begin
    ClearVariables;
    SetVariable('PROGRESSIVO',ProgressivoC700);
    SetVariable('DATADA',DataDa);
    SetVariable('DATAA',DataA);
    Execute;
  end;
end;

procedure TA025FPianifMW.SelT080BeforeDelete;
begin
  if selDatiBloccati.DatoBloccato(ProgressivoC700,R180InizioMese(SelT080.FieldByName('DATA').AsDateTime),'T080') then
    raise Exception.Create(selDatiBloccati.MessaggioLog);
end;

procedure TA025FPianifMW.SelT080BeforePost;
var colVisible: boolean;
begin
  if Assigned(CampoOrarioVisibile) then
    colVisible:=CampoOrarioVisibile
  else
    raise Exception.Create(A000MSG_ERR_FUNZIONE_MANCANTE);
  if SelT080.FieldByName('DATA').IsNull or (SelT080.FieldByName('ORARIO').IsNull and SelT080.FieldByName('INDPRESENZA').IsNull and SelT080.FieldByName('DATOLIBERO').IsNull) then
  begin
    SelT080.Cancel;
    Exit;
  end;
  if selDatiBloccati.DatoBloccato(ProgressivoC700,R180InizioMese(SelT080.FieldByName('DATA').AsDateTime),'T080') then
    raise Exception.Create(selDatiBloccati.MessaggioLog);
  SelT080.FieldByName('TURNO1').AsString:=Trim(SelT080.FieldByName('TURNO1').AsString);
  SelT080.FieldByName('TURNO2').AsString:=Trim(SelT080.FieldByName('TURNO2').AsString);
  if SelT080.FieldByName('TURNO1').AsString <> '' then
    SelT080.FieldByName('TURNO1').AsInteger:=SelT080.FieldByName('TURNO1').Value;
  if SelT080.FieldByName('TURNO2').AsString <> '' then
    SelT080.FieldByName('TURNO2').AsInteger:=SelT080.FieldByName('TURNO2').Value;
  if SelT080.FieldByName('ORARIO').AsString <> '' then
  begin
    Q020.SearchRecord('CODICE',SelT080.FieldByName('ORARIO').AsString,[srFromBeginning]);
    if (StrToIntDef(Trim(SelT080.FieldByName('TURNO1').AsString),-1) > Q020.FieldByName('Turni').AsInteger) then
      raise Exception.Create(Format(A000MSG_A025_DLG_FMT_TURNO_NON_PREVISTO,[SelT080.FieldByName('TURNO1').AsString,Q020.FieldByName('Turni').AsString]));
    if (StrToIntDef(Trim(SelT080.FieldByName('TURNO2').AsString),-1) > Q020.FieldByName('Turni').AsInteger) then
      raise Exception.Create(Format(A000MSG_A025_DLG_FMT_TURNO_NON_PREVISTO,[SelT080.FieldByName('TURNO2').AsString,Q020.FieldByName('Turni').AsString]));
  end;
  if (SelT080.FieldByName('DATA').AsString <> '') and
     (SelT080.FieldByName('ORARIO').AsString = '') and
     (SelT080.FieldByName('INDPRESENZA').AsString = '') then
    if not colVisible then
      raise Exception.Create(A000MSG_A025_ERR_COD_ORARIO_INDENNITA)
    else if SelT080.FieldByName('DATOLIBERO').AsString = '' then
      raise Exception.Create('Sono richiesti o il codice Orario o il codice Indennità o il codice ' +
        SelT080.FieldByName('DATOLIBERO').DisplayLabel + '!');
  if (SelT080.FieldByName('ORARIO').AsString = '') and
    ((SelT080.FieldByName('TURNO1').AsString <> '') or
     (SelT080.FieldByName('TURNO2').AsString <> '') or
     (SelT080.FieldByName('TURNO1EU').AsString <> '') or
     (SelT080.FieldByName('TURNO2EU').AsString <> '')) then
    raise Exception.Create(A000MSG_A025_ERR_CODICE_ORARIO);
  if SelT080.FieldByName('MOTIVAZIONE').AsString <> '' then
  begin
    R180SetVariable(selT081,'PROGRESSIVO',SelT080.FieldByName('PROGRESSIVO').AsInteger);
    R180SetVariable(selT081,'DATA',SelT080.FieldByName('DATA').AsDateTime);
    selT081.Open;
    if selT081.FieldByName('COUNT').AsInteger = 0 then
      raise Exception.Create(A000MSG_A025_ERR_MOTIV_PIANIF);
    if SelT080.FieldByName('ORARIO').AsString = '' then
      raise Exception.Create(A000MSG_A025_ERR_MOTIV_PIANIF_ORARIO);
  end;
  if (SelT080.FieldByName('TURNO2').AsString <> '') and
     (SelT080.FieldByName('TURNO1').AsString = '') then
    raise Exception.Create(A000MSG_A025_ERR_PRIMO_TURNO);
  if (SelT080.FieldByName('TURNO1EU').AsString <> '') and
    ((SelT080.FieldByName('TURNO1').AsString = '') or
     (SelT080.FieldByName('TURNO1').AsString = '0')) then
     SelT080.FieldByName('TURNO1EU').AsString:='';
  if (SelT080.FieldByName('TURNO2EU').AsString <> '') and
    ((SelT080.FieldByName('TURNO2').AsString = '') or
     (SelT080.FieldByName('TURNO2').AsString = '0')) then
     SelT080.FieldByName('TURNO2EU').AsString:='';
end;

procedure TA025FPianifMW.SelT080NewRecord;
begin
  SelT080.FieldByName('PROGRESSIVO').AsInteger:=ProgressivoC700;
end;

procedure TA025FPianifMW.ResetCalendario;
begin
  CancCalendari(CalcolaDataDa, CalcolaDataA);
  RegistraLog.SettaProprieta('C','T012_CALENDINDIVID',NomeOwner,selV010,True);
  SessioneOracle.Commit;
  selV010.Refresh;
end;

procedure TA025FPianifMW.InserisciPianificazione;
var T1,T2:String;
begin
  T1:=Trim(Copy(Turno1,1,2));
  T2:=Trim(Copy(Turno2,1,2));
  if StrToIntDef(T1,-1) >= 0 then
    T1:=IntToStr(StrToInt(T1));
  if StrToIntDef(T2,-1) >= 0 then
    T2:=IntToStr(StrToInt(T2));
  with insT080 do
  begin
    ClearVariables;
    SetVariable('Progressivo',ProgressivoC700);
    SetVariable('Data',DataCorrente);
    if PulOrarioChecked then
    begin
      SetVariable('ORARIO','null');
      SetVariable('TURNO1','null');
      SetVariable('TURNO2','null');
      SetVariable('TURNO1EU','null');
      SetVariable('TURNO2EU','null');
      SetVariable('ORARIOI','null');
      SetVariable('TURNO1I','null');
      SetVariable('TURNO2I','null');
      SetVariable('TURNO1EUI','null');
      SetVariable('TURNO2EUI','null');
    end
    else if Orario = '' then
    begin
      SetVariable('ORARIO','ORARIO');
      SetVariable('TURNO1','TURNO1');
      SetVariable('TURNO2','TURNO2');
      SetVariable('TURNO1EU','TURNO1EU');
      SetVariable('TURNO2EU','TURNO2EU');
      SetVariable('ORARIOI','null');
      SetVariable('TURNO1I','null');
      SetVariable('TURNO2I','null');
      SetVariable('TURNO1EUI','null');
      SetVariable('TURNO2EUI','null');
    end
    else
    begin
      SetVariable('ORARIO','''' + Orario + '''');
      SetVariable('TURNO1','''' + T1 + '''');
      SetVariable('TURNO2','''' + T2 + '''');
      SetVariable('TURNO1EU','''' + Turno1EU + '''');
      SetVariable('TURNO2EU','''' + Turno2EU + '''');
      SetVariable('ORARIOI','''' + Orario + '''');
      SetVariable('TURNO1I','''' + T1 + '''');
      SetVariable('TURNO2I','''' + T2 + '''');
      SetVariable('TURNO1EUI','''' + Turno1EU + '''');
      SetVariable('TURNO2EUI','''' + Turno2EU + '''');
    end;
    if PulIndennitaChecked then
    begin
      SetVariable('INDPRESENZA','null');
      SetVariable('INDPRESENZAI','null');
    end
    else if Indennita = '' then
    begin
      SetVariable('INDPRESENZA','INDPRESENZA');
      SetVariable('INDPRESENZAI','null');
    end
    else
    begin
      SetVariable('INDPRESENZA','''' + Indennita + '''');
      SetVariable('INDPRESENZAI','''' + Indennita + '''');
    end;
    if PulDatoChecked then
    begin
      SetVariable('DATOLIBERO','null');
      SetVariable('DATOLIBEROI','null');
    end
    else if DatoLibero = '' then
    begin
      SetVariable('DATOLIBERO','DATOLIBERO');
      SetVariable('DATOLIBEROI','null');
    end
    else
    begin
      SetVariable('DATOLIBERO','''' + DatoLibero + '''');
      SetVariable('DATOLIBEROI','''' + DatoLibero + '''');
    end;
    try
      Execute;
    except
    end;
    RegistraLog.SettaProprieta('I','T080_PIANIFORARI',NomeOwner,nil,True);
    RegistraLog.InserisciDato('PROGRESSIVO','',IntToStr(ProgressivoC700));
    RegistraLog.InserisciDato('DATA','',DateToStr(DataCorrente));
    RegistraLog.InserisciDato('ORARIO','',VarToStr(GetVariable('Orario')));
    RegistraLog.InserisciDato('TURNO1','',VarToStr(GetVariable('Turno1')));
    RegistraLog.InserisciDato('TURNO2','',VarToStr(GetVariable('Turno2')));
    RegistraLog.InserisciDato('TURNO1EU','',VarToStr(GetVariable('Turno1EU')));
    RegistraLog.InserisciDato('TURNO2EU','',VarToStr(GetVariable('Turno2EU')));
    RegistraLog.InserisciDato('INDPRESENZA','',VarToStr(GetVariable('IndPresenza')));
    if DatoLiberoEnabled then
      RegistraLog.InserisciDato('DATOLIBERO','',VarToStr(GetVariable('DatoLibero')));
    RegistraLog.RegistraOperazione;
  end;
end;

procedure TA025FPianifMW.AggiornaPianificazione;
begin
  with updT080 do
  begin
    ClearVariables;
    SetVariable('Progressivo',ProgressivoC700);
    SetVariable('Data',DataCorrente);
    if PulOrarioChecked then
    begin
      SetVariable('ORARIO','null');
      SetVariable('TURNO1','null');
      SetVariable('TURNO2','null');
      SetVariable('TURNO1EU','null');
      SetVariable('TURNO2EU','null');
    end
    else
    begin
      SetVariable('ORARIO','ORARIO');
      SetVariable('TURNO1','TURNO1');
      SetVariable('TURNO2','TURNO2');
      SetVariable('TURNO1EU','TURNO1EU');
      SetVariable('TURNO2EU','TURNO2EU');
    end;
    if PulIndennitaChecked then
      SetVariable('INDPRESENZA','null')
    else
      SetVariable('INDPRESENZA','INDPRESENZA');
    if PulDatoChecked then
      SetVariable('DATOLIBERO','null')
    else
      SetVariable('DATOLIBERO','DATOLIBERO');
    try
      Execute;
    except
    end;
    RegistraLog.SettaProprieta('U','T080_PIANIFORARI',NomeOwner,nil,True);
    RegistraLog.InserisciDato('PROGRESSIVO','',IntToStr(ProgressivoC700));
    RegistraLog.InserisciDato('DATA','',DateToStr(DataCorrente));
    RegistraLog.InserisciDato('ORARIO','',VarToStr(GetVariable('Orario')));
    RegistraLog.InserisciDato('TURNO1','',VarToStr(GetVariable('Turno1')));
    RegistraLog.InserisciDato('TURNO2','',VarToStr(GetVariable('Turno2')));
    RegistraLog.InserisciDato('TURNO1EU','',VarToStr(GetVariable('Turno1EU')));
    RegistraLog.InserisciDato('TURNO2EU','',VarToStr(GetVariable('Turno2EU')));
    RegistraLog.InserisciDato('INDPRESENZA','',VarToStr(GetVariable('IndPresenza')));
    if DatoLiberoEnabled then
      RegistraLog.InserisciDato('DATOLIBERO','',VarToStr(GetVariable('DatoLibero')));
    RegistraLog.RegistraOperazione;
  end;
end;

procedure TA025FPianifMW.ControlliInsPianificazione;
var T1,T2:Integer;
begin
  T1:=StrToIntDef(Trim(Copy(Turno1,1,2)),-1);
  T2:=StrToIntDef(Trim(Copy(Turno2,1,2)),-1);
  if Trim(Turno1) = '' then
    T1:=0;
  if Trim(Turno2) = '' then
    T2:=0;
  if T1 = -1 then
    raise Exception.Create(Format(A000MSG_A025_DLG_FMT_TURNO_ERRATO,[Turno1]));
  if T2 = -1 then
    raise Exception.Create(Format(A000MSG_A025_DLG_FMT_TURNO_ERRATO,[Turno2]));
  if (T1 > Q020.FieldByName('Turni').AsInteger) then
    raise Exception.Create(Format(A000MSG_A025_DLG_FMT_TURNO_NON_PREVISTO,[Turno1,Q020.FieldByName('Turni').AsString]));
  if (T2 > Q020.FieldByName('Turni').AsInteger) then
    raise Exception.Create(Format(A000MSG_A025_DLG_FMT_TURNO_NON_PREVISTO,[Turno2,Q020.FieldByName('Turni').AsString]));
  if (not PulOrarioChecked) and (not PulIndennitaChecked) and (not PulDatoChecked) and
     (Orario = '') and (Indennita = '') then
    if not DatoLiberoEnabled then
      raise Exception.Create(A000MSG_A025_ERR_COD_ORARIO_INDENNITA)
    else if DatoLibero = '' then
      raise Exception.Create('Sono richiesti o il codice Orario o il codice Indennità o il codice ' +
        DatoLiberoCaption + '!');
  if (Orario = '') and
    ((Turno1 <> '') or (Turno2 <> '') or
     (Turno1EU <> '') or (Turno2EU <> '')) then
    raise Exception.Create(A000MSG_A025_ERR_CODICE_ORARIO);
  if (Turno2 <> '') and (Turno1 = '') then
    raise Exception.Create(A000MSG_A025_ERR_PRIMO_TURNO);
  if (Turno1EU <> '') and
     ((Turno1 = '') or (T1 = 0)) then
    Turno1EUItemIndex:=0;
  if (Turno2EU <> '') and
     ((Turno2 = '') or (T2 = 0)) then
    Turno2EUItemIndex:=0;
end;

procedure TA025FPianifMW.CancellaPianificazione(DataDa, DataA:TDateTime);
{Cancellazione pianificazione}
begin
  with delT080 do
  begin
    SetVariable('Progressivo',ProgressivoC700);
    SetVariable('Data1',DataDa);
    SetVariable('Data2',DataA);
    SetVariable('CONDIZIONE','');
    Execute;
  end;
  SessioneOracle.Commit;
  RegistraLog.SettaProprieta('C','T080_PIANIFORARI',NomeOwner,nil,True);
  RegistraLog.InserisciDato('PROGRESSIVO','',VarToStr(delT080.GetVariable('Progressivo')));
  RegistraLog.InserisciDato('DAL - AL','',Format('%s - %s',[DateToStr(DataDa),DateToStr(DataA)]));
  RegistraLog.RegistraOperazione;
  SetSelT080;
end;

procedure TA025FPianifMW.CancellaT080(DataDa, DataA:TDateTime);
begin
  with delT080 do
  begin
    SetVariable('Progressivo',ProgressivoC700);
    SetVariable('Data1',DataDa);
    SetVariable('Data2',DataA);
    SetVariable('CONDIZIONE','AND ORARIO IS NULL AND TURNO1 IS NULL AND TURNO2 IS NULL AND TURNO1EU IS NULL AND TURNO2EU IS NULL AND INDPRESENZA IS NULL AND DATOLIBERO IS NULL');
    Execute;
  end;
end;

end.
