unit A038UVociVariabiliDtM1;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, A000UCostanti, A000USessione,A000UInterfaccia, C700USelezioneAnagrafe, OracleData, Oracle,
  RegistrazioneLog, C180FunzioniGenerali, Variants,
  USelI010,A038UVociVariabiliMW;

type
  TA038FVociVariabiliDtM1 = class(TDataModule)
    QI010_: TOracleDataSet;
    scrDecodeVoci: TOracleQuery;
    procedure A033FStampaAnomalieDtM1Create(Sender: TObject);
    procedure A033FStampaAnomalieDtM1Destroy(Sender: TObject);
    procedure Q195FilterRecord(DataSet: TDataSet; var Accept: Boolean);
    procedure D195StateChange(Sender: TObject);
  private
    { Private declarations }
  public
    A038FVociVariabiliMW : TA038FVociVariabiliMW;
    selI010:TselI010;
    procedure SettaQuery(Par:String);
  end;

var
  A038FVociVariabiliDtM1: TA038FVociVariabiliDtM1;

implementation

uses A038UVociVariabili;

{$R *.DFM}

procedure TA038FVociVariabiliDtM1.A033FStampaAnomalieDtM1Create(
  Sender: TObject);
var i:Integer;
begin
  for i:=0 to Self.ComponentCount - 1 do
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
  A038FVociVariabiliMW:=TA038FVociVariabiliMW.Create(Self);
  with A038FVociVariabiliMW do
  begin
    OnFilterRecord:=Q195FilterRecord;
    OnStateChange:=D195StateChange;
    A038FVociVariabili.dbgrid1.DataSource:=dsrT195;

    selT195.SetVariable('DATA1',A038FVociVariabili.Data1);
    selT195.SetVariable('DATA2',A038FVociVariabili.Data2);
    selT195.SetVariable('T','1');
    selT195.SetVariable('T195_ROWID','');
    selT195.SetVariable('T195','(SELECT PROGRESSIVO,DATARIF,VOCEPAGHE,SUM(VALORE) VALORE,SUM(IMPORTO) IMPORTO,UM,DAL,AL,OPERAZIONE,COD_INTERNO,MAX(DATA_CASSA) DATA_CASSA ' +
                           'FROM T195_VOCIVARIABILI '+
                           'GROUP BY PROGRESSIVO,DATARIF,VOCEPAGHE,UM,DAL,AL,OPERAZIONE,COD_INTERNO) T195');
  end;
  selI010:=TselI010.Create(Self);
  selI010.Apri(SessioneOracle,'',Parametri.Applicazione,'NOME_CAMPO,NOME_LOGICO,POSIZIONE','','POSIZIONE,NOME_LOGICO');
end;

procedure TA038FVociVariabiliDtM1.A033FStampaAnomalieDtM1Destroy(
  Sender: TObject);
var i:Integer;
begin
  for i:=0 to Self.ComponentCount - 1 do
    if Self.Components[i] is TOracleDataSet then
      (Self.Components[i] as TOracleDataSet).Close;
  FreeAndNil(selI010);
  FreeAndNil(A038FVociVariabiliMW);
end;

procedure TA038FVociVariabiliDtM1.SettaQuery(Par:String);
begin
  Screen.Cursor:=crHourGlass;
  A038FVociVariabili.Q195Modificata:=True;
  if Par = 'PROGRESSIVO' then
    with A038FVociVariabiliMW.selT195 do
    begin
      SetVariable('PROGRESSIVO',C700Progressivo);
      if not A038FVociVariabili.chkTuttiDipendenti.Checked then
      begin
        if A038FVociVariabili.PageControl1.ActivePage = A038FVociVariabili.tabVoci then
        begin
          Close;
          Open;
          A038FVociVariabili.Q195Modificata:=False;
        end;
      end;
    end
  else if Par = 'DATA1' then
    with A038FVociVariabiliMW.selT195 do
    begin
      //Close;
      SetVariable('DATA1',A038FVociVariabili.Data1);
      //Open;
    end
  else if Par = 'DATA2' then
    with A038FVociVariabiliMW.selT195 do
    begin
      //Close;
      SetVariable('DATA2',A038FVociVariabili.Data2);
      //Open;
    end
  else if Par = 'T' then
    with A038FVociVariabiliMW.selT195 do
    begin
      //Close;
      if A038FVociVariabili.chkTuttiDipendenti.Checked then
        SetVariable('T','T')
      else
        SetVariable('T','1');
      //Open;
    end
  else if Par = 'TIPO_ELENCO' then
    with A038FVociVariabiliMW.selT195 do
    begin
      CloseAll;
      if A038FVociVariabili.rgpTipoElenco.ItemIndex = 0 then
      begin
        SetVariable('T195_ROWID',',T195.ROWID');
        SetVariable('T195','T195_VOCIVARIABILI T195');
      end
      else
      begin
        SetVariable('T195_ROWID','');
        SetVariable('T195','(SELECT PROGRESSIVO,DATARIF,VOCEPAGHE,SUM(VALORE) VALORE,SUM(IMPORTO) IMPORTO,UM,DAL,AL,OPERAZIONE,COD_INTERNO,MAX(DATA_CASSA) DATA_CASSA ' +
                           'FROM T195_VOCIVARIABILI '+
                           'GROUP BY PROGRESSIVO,DATARIF,VOCEPAGHE,UM,DAL,AL,OPERAZIONE,COD_INTERNO) T195');
      end;
      ReadOnly:=(A038FVociVariabili.rgpTipoElenco.ItemIndex = 1) or SolaLettura;
      //Open;
    end;
  Screen.Cursor:=crDefault;
  A038FVociVariabili.StatusBar.Panels[0].Text:='--- Records';
end;

procedure TA038FVociVariabiliDtM1.Q195FilterRecord(DataSet: TDataSet;
  var Accept: Boolean);
var i:Integer;
begin
  Accept:=False;
  with A038FVociVariabili do
  begin
    if chkMeseCassa.Checked then
    begin
      Accept:=DataCassa = DataSet.FieldByName('Data_Cassa').AsDateTime;
      if not Accept then exit;
    end;
    Accept:=chkUMNumero.Checked and (DataSet.FieldByName('UM').AsString = 'N') or
            chkUMOre.Checked and (DataSet.FieldByName('UM').AsString = 'H') or
            chkUMValuta.Checked and (DataSet.FieldByName('UM').AsString = 'V');
    if not Accept then exit;
    if chkVoci.Checked then
    begin
      Accept:=False;
      i:=CheckListBox1.Items.IndexOf(DataSet.FieldByName('VocePaghe').AsString);
      if i >= 0 then
        Accept:=CheckListBox1.Checked[i];
      if Accept then exit;
    end;
    if chkCodici.Checked then
    begin
      Accept:=False;
      for i:=0 to CheckListBox2.Items.Count - 1 do
        if CheckListBox2.Checked[i] and
           (DataSet.FieldByName('Cod_Interno').AsString = Trim(Copy(CheckListBox2.Items[i],1,4))) then
        begin
          Accept:=True;
          Break;
        end;
    end;
  end;
end;

procedure TA038FVociVariabiliDtM1.D195StateChange(Sender: TObject);
begin
  A038FVociVariabili.frmSelAnagrafe.Enabled:= A038FVociVariabiliMW.DsrT195.State = dsBrowse;
end;
end.
