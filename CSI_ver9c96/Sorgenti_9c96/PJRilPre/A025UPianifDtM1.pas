unit A025UPianifDtM1;

interface

uses
  Windows, Messages, SysUtils, StrUtils, Classes, Graphics, Controls, Forms, Dialogs,
  DB, A000UCostanti, A000USessione, A000UInterfaccia, A000UMessaggi, OracleData, Oracle,
  C700USelezioneAnagrafe, C180FunzioniGenerali, Variants, DBClient, A025UPianifMW;

type
  TA025FPianifDtM1 = class(TDataModule)
    Q080: TOracleDataSet;
    Q080PROGRESSIVO: TFloatField;
    Q080DATA: TDateTimeField;
    Q080ORARIO: TStringField;
    Q080TURNO1: TStringField;
    Q080TURNO1EU: TStringField;
    Q080TURNO2: TStringField;
    Q080TURNO2EU: TStringField;
    Q080FLAGAGG: TStringField;
    Q080INDPRESENZA: TStringField;
    Q080DATOLIBERO: TStringField;
    Q080D_ORARIO: TStringField;
    Q080D_INDENNITA: TStringField;
    Q080D_DATOLIBERO: TStringField;
    Q080VALORGIOR: TStringField;
    Q080MOTIVAZIONE: TStringField;
    Q080D_MOTIVAZIONE: TStringField;
    procedure A025FPianifDtM1Create(Sender: TObject);
    procedure A025FPianifDtM1Destroy(Sender: TObject);
    procedure Q080NewRecord(DataSet: TDataSet);
    procedure Q080BeforePost(DataSet: TDataSet);
    procedure Q080ORARIOValidate(Sender: TField);
    procedure Q080TURNO1Validate(Sender: TField);
    procedure Q080TURNO1EUValidate(Sender: TField);
    procedure Q080TURNO2Validate(Sender: TField);
    procedure Q080TURNO2EUValidate(Sender: TField);
    procedure Q080INDPRESENZAValidate(Sender: TField);
    procedure Q080DATOLIBEROValidate(Sender: TField);
    procedure Q080ORARIOSetText(Sender: TField; const Text: String);
    procedure Q080INDPRESENZASetText(Sender: TField; const Text: String);
    procedure Q080DATOLIBEROSetText(Sender: TField; const Text: String);
    procedure Q080AfterPost(DataSet: TDataSet);
    procedure Q080BeforeDelete(DataSet: TDataSet);
  private
    function CalcolaDataDa:TDateTime;
    function CalcolaDataA:TDateTime;
    function CampoOrarioVisibile:boolean;
    procedure DimensionaCmbDatiLiberi(DataSet: TDataSet);
  public
    A025MW: TA025FPianifMW;
  end;

var
  A025FPianifDtM1: TA025FPianifDtM1;

implementation

uses A025UPianif;

{$R *.DFM}

procedure TA025FPianifDtM1.A025FPianifDtM1Create(Sender: TObject);
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
  A025MW:=TA025FPianifMW.Create(Self);
  A025MW.SelT080:=Q080;
  A025MW.CalcolaDataDa:=CalcolaDataDa;
  A025MW.CalcolaDataA:=CalcolaDataA;
  A025MW.CampoOrarioVisibile:=CampoOrarioVisibile;
  A025MW.Inizializza;
  A025MW.selV010.ReadOnly:=True;
  A025FPianif.dGrdPianif.Columns[1].PickList.Clear;
  with A025MW.Q020 do
  begin
    Open;
    First;
    while not Eof do
    begin
      A025FPianif.dGrdPianif.Columns[1].PickList.Add(Format('%-*s',[5,FieldByName('CODICE').AsString]) + ' - ' +
        FieldByName('DESCRIZIONE').AsString);
      Next;
    end;
  end;
  A025FPianif.dGrdPianif.Columns[8].PickList.Clear;
  with A025MW.Q163 do
  begin
    Open;
    First;
    while not Eof do
    begin
      A025FPianif.dGrdPianif.Columns[8].PickList.Add(Format('%-*s',[5,FieldByName('CODICE').AsString]) + ' - ' +
        FieldByName('DESCRIZIONE').AsString);
      Next;
    end;
  end;
  if A000LookupTabella(Parametri.CampiRiferimento.C3_DatoPianificabile,A025MW.selDatoLibero) then
  begin
    if Parametri.CampiRiferimento.C3_DatoPianificabile = 'COMUNE' then
      Q080.FieldbyName('D_DATOLIBERO').Tag:=999;
    if A025MW.selDatoLibero.VariableIndex('DECORRENZA') >= 0 then
      A025MW.selDatoLibero.SetVariable('DECORRENZA',R180FineMese(Parametri.DataLavoro));
    A025FPianif.dGrdPianif.Columns[10].Visible:=True;
  end
  else
  begin
    A025MW.selDatoLibero.SQL.Clear;
    A025MW.selDatoLibero.SQL.Add('SELECT NULL CODICE, NULL DESCRIZIONE FROM DUAL');
    A025FPianif.dGrdPianif.Columns[10].Visible:=False;
  end;
  A025MW.selDatoLibero.Open;
  with A025FPianif do
  begin
    DButton.DataSet:=Q080;
    dGrdPianif.Columns[10].PickList.Clear;
    dGrdPianif.Columns[11].Visible:=dGrdPianif.Columns[10].Visible;
    lblDatoLibero.Visible:=dGrdPianif.Columns[10].Visible;
    dCmbDatoLibero.Enabled:=dGrdPianif.Columns[10].Visible;
    chkPulDato.Enabled:=dGrdPianif.Columns[10].Visible;
    if dGrdPianif.Columns[10].Visible then
    begin
      A025MW.selDatoLibero.First;
      while not A025MW.selDatoLibero.Eof do
      begin
        dGrdPianif.Columns[10].PickList.Add(Format('%-*s',[20,A025MW.selDatoLibero.FieldByName('CODICE').AsString]) + ' - ' +
          A025MW.selDatoLibero.FieldByName('DESCRIZIONE').AsString);
        A025MW.selDatoLibero.Next;
      end;
      Q080.FieldByName('DATOLIBERO').DisplayLabel:=Copy(Parametri.CampiRiferimento.C3_DatoPianificabile,1,1) +
        LowerCase(Copy(Parametri.CampiRiferimento.C3_DatoPianificabile,2,Length(Parametri.CampiRiferimento.C3_DatoPianificabile) - 1));
      lblDatoLibero.Caption:=dGrdPianif.Columns[10].Title.Caption;
      dGrdPianif.Columns[10].Width:=A025MW.selDatoLibero.FieldByName('CODICE').Size * 10;
      dGrdPianif.Columns[11].Width:=A025MW.selDatoLibero.FieldByName('DESCRIZIONE').Size * 10;
    end;
  end;
  A025MW.SetSelT080;
end;

procedure TA025FPianifDtM1.A025FPianifDtM1Destroy(Sender: TObject);
var i:Integer;
begin
  for i:=0 to Self.ComponentCount - 1 do
    if Self.Components[i] is TDataSet then
      (Self.Components[i] as TDataSet).Close;
end;

function TA025FPianifDtM1.CalcolaDataA: TDateTime;
begin
  if Trim(A025FPianif.EDataA.Text) = '/  /' then
    A025FPianif.EDataA.Text:=DateToStr(Date);
  try
    Result:=StrToDate(A025FPianif.EDataA.Text);
  except
    Result:=StrToDate('31/12/3999');
  end;
end;

function TA025FPianifDtM1.CalcolaDataDa: TDateTime;
begin
  if Trim(A025FPianif.EDataDa.Text) = '/  /' then
    A025FPianif.EDataDa.Text:=DateToStr(Date);
  try
    Result:=StrToDate(A025FPianif.EDataDa.Text);
  except
    Result:=StrToDate('01/01/1900');
  end;
end;

function TA025FPianifDtM1.CampoOrarioVisibile: boolean;
begin
  Result:=A025FPianif.dGrdPianif.Columns[10].Visible;
end;

procedure TA025FPianifDtM1.Q080NewRecord(DataSet: TDataSet);
begin
  A025MW.SelT080NewRecord;
end;

procedure TA025FPianifDtM1.Q080BeforeDelete(DataSet: TDataSet);
begin
  A025MW.SelT080BeforeDelete;
  RegistraLog.SettaProprieta('C',R180Query2NomeTabella(DataSet),Copy(Name,1,4),DataSet,True);
end;

procedure TA025FPianifDtM1.Q080BeforePost(DataSet: TDataSet);
begin
  A025MW.SelT080BeforePost;
  case DataSet.State of
    dsInsert:RegistraLog.SettaProprieta('I',R180Query2NomeTabella(DataSet),Copy(Name,1,4),DataSet,True);
    dsEdit:RegistraLog.SettaProprieta('M',R180Query2NomeTabella(DataSet),Copy(Name,1,4),DataSet,True);
  end;
end;

procedure TA025FPianifDtM1.Q080AfterPost(DataSet: TDataSet);
begin
  RegistraLog.RegistraOperazione;
end;

procedure TA025FPianifDtM1.Q080ORARIOValidate(Sender: TField);
begin
  if Q080.FieldByName('ORARIO').AsString <> '' then
    if R180IndexOf(A025FPianif.dGrdPianif.Columns[1].PickList,Q080.FieldByName('ORARIO').AsString,5) = -1 then
      raise Exception.Create(A000MSG_A025_ERR_COD_ORARIO);
end;

procedure TA025FPianifDtM1.Q080TURNO1Validate(Sender: TField);
begin
  if Trim(Q080.FieldByName('TURNO1').AsString) <> '' then
    if StrToIntDef(Trim(Q080.FieldByName('TURNO1').AsString),-1) = -1 then
      raise Exception.Create(A000MSG_A025_ERR_TURNO1);
end;

procedure TA025FPianifDtM1.Q080TURNO1EUValidate(Sender: TField);
begin
  if Q080.FieldByName('TURNO1EU').AsString <> '' then
    if R180IndexOf(A025FPianif.dGrdPianif.Columns[4].PickList,Q080.FieldByName('TURNO1EU').AsString,1) = -1 then
      raise Exception.Create(A000MSG_A025_ERR_TURNO1EU)
end;

procedure TA025FPianifDtM1.Q080TURNO2Validate(Sender: TField);
begin
  if Trim(Q080.FieldByName('TURNO2').AsString) <> '' then
    if StrToIntDef(Trim(Q080.FieldByName('TURNO2').AsString),-1) = -1 then
      raise Exception.Create(A000MSG_A025_ERR_TURNO2);
end;

procedure TA025FPianifDtM1.DimensionaCmbDatiLiberi(DataSet: TDataSet);
begin
  A025FPianif.dcmbDatoLibero.DropDownWidth:=(A025MW.selDatoLibero.Fields[0].Size + 2 + A025MW.selDatoLibero.Fields[1].Size + 2) * 10;
end;

procedure TA025FPianifDtM1.Q080TURNO2EUValidate(Sender: TField);
begin
  if Q080.FieldByName('TURNO2EU').AsString <> '' then
    if R180IndexOf(A025FPianif.dGrdPianif.Columns[6].PickList,Q080.FieldByName('TURNO2EU').AsString,1) = -1 then
      raise Exception.Create(A000MSG_A025_ERR_TURNO2EU);
end;

procedure TA025FPianifDtM1.Q080INDPRESENZAValidate(Sender: TField);
begin
  if Q080.FieldByName('INDPRESENZA').AsString <> '' then
    if R180IndexOf(A025FPianif.dGrdPianif.Columns[8].PickList,Q080.FieldByName('INDPRESENZA').AsString,5) = -1 then
      raise Exception.Create(A000MSG_A025_ERR_COD_INDENNITA);
end;

procedure TA025FPianifDtM1.Q080DATOLIBEROValidate(Sender: TField);
begin
  if Q080.FieldByName('DATOLIBERO').AsString <> '' then
    if R180IndexOf(A025FPianif.dGrdPianif.Columns[10].PickList,Q080.FieldByName('DATOLIBERO').AsString,20) = -1 then
      raise Exception.Create(Format(A000MSG_A025_ERR_FMT_COD_NON_VALIDO,[Q080.FieldByName('DATOLIBERO').DisplayLabel]));
end;

procedure TA025FPianifDtM1.Q080ORARIOSetText(Sender: TField;const Text: String);
begin
  Sender.AsString:=Trim(Copy(Text,1,5));
end;

procedure TA025FPianifDtM1.Q080INDPRESENZASetText(Sender: TField;const Text: String);
begin
  Sender.AsString:=Trim(Copy(Text,1,5));
end;

procedure TA025FPianifDtM1.Q080DATOLIBEROSetText(Sender: TField;const Text: String);
begin
  Sender.AsString:=Trim(Copy(Text,1,20));
end;

end.
