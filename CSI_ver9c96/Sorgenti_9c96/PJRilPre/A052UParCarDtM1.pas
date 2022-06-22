unit A052UParCarDtM1;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, A000UCostanti, A000USessione,A000UInterfaccia, StdCtrls, C180FunzioniGenerali, A052UParCar,
  RegistrazioneLog, Oracle, OracleData, Variants,  A052UParCarMW, System.Generics.Collections;

type
  TA052FParCarDtM1 = class(TDataModule)
    selT950: TOracleDataSet;
    procedure selT950AfterScroll(DataSet: TDataSet);
    procedure selT950AfterDelete(DataSet: TDataSet);
    procedure A052FParCarDtM1Create(Sender: TObject);
    procedure selT950BeforePost(DataSet: TDataSet);
    procedure BDEQ950BeforeInsert(DataSet: TDataSet);
    procedure A052FParCarDtM1Destroy(Sender: TObject);
    procedure BDEQ950BeforeDelete(DataSet: TDataSet);
    procedure BDEQ950AfterPost(DataSet: TDataSet);
    procedure selT950FilterRecord(DataSet: TDataSet; var Accept: Boolean);
  private
    { Private declarations }
    VecchioCodiceDizionario:String;
    procedure SalvaImpostazioni(Sezione:String);
    procedure GetFont(Sezione:String);
    procedure GetLabels(Sezione:String);
  public
    { Public declarations }
    A052FParCarMW: TA052FParCarMW;
  end;

var
  A052FParCarDtM1: TA052FParCarDtM1;

implementation

{$R *.DFM}

procedure TA052FParCarDtM1.A052FParCarDtM1Create(Sender: TObject);
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
  A052FParCarMW:=TA052FParCarMW.Create(Self);
  A052FParCarMW.SelT950_Funzioni:=selT950;
  selT950.Open;
  selT950.FieldByName('Codice').Required:=True;
end;

procedure TA052FParCarDtM1.selT950BeforePost(DataSet: TDataSet);
begin
  A052FParCarMW.selT950BeforePost;
  selT950.FieldByName('ORIENTAMENTO').Clear;  //LORENA 07/02/2005
  case A052FParCar.cmbOrientamento.ItemIndex of
    1:selT950.FieldByName('ORIENTAMENTO').AsString:='V';
    2:selT950.FieldByName('ORIENTAMENTO').AsString:='O';
  end;
  case DataSet.State of
    dsInsert:RegistraLog.SettaProprieta('I',R180Query2NomeTabella(DataSet),Copy(Name,1,4),DataSet,True);
    dsEdit:RegistraLog.SettaProprieta('M',R180Query2NomeTabella(DataSet),Copy(Name,1,4),DataSet,True);
  end;
end;

procedure TA052FParCarDtM1.SalvaImpostazioni(Sezione: String);
{Registrazione dati impostazione sul campo Memo Intestazione}
var S,Suff:String;
    i:Integer;
    Parente:TScrollBox;
    FontProperties: TFontProperties;
    LabelProperties: TLabelProperties;
begin
  Parente:=A052FParCar.Intestazione;
  if Sezione = TSezione.INTESTAZIONE then
    Parente:=A052FParCar.Intestazione
  else if Sezione = TSezione.DETTAGLIO then
    Parente:=A052FParCar.Dettaglio
  else if Sezione = TSezione.RIEPILOGO then
    Parente:=A052FParCar.Riepilogo;

  FontProperties:=A052FParCarMW.dicSezioni[Sezione].FontProperties;

  with A052FParCar do
  begin
    Parente.HorzScrollBar.Position:=0;
    Parente.VertScrollBar.Position:=0;
    //Font della ScrollBox Attiva
    FontProperties.Color:=Parente.Font.Color;
    FontProperties.Name:=Parente.Font.Name;
    FontProperties.Size:=Parente.Font.Size;

    FontProperties.Bold:=(fsBold in Parente.Font.Style);
    FontProperties.Italic:=(fsItalic in Parente.Font.Style);
    FontProperties.Underline:=(fsUnderline in Parente.Font.Style);
    FontProperties.StrikeOut:=(fsStrikeOut in Parente.Font.Style);

    //Proprietà delle label
    for i:=0 to Parente.ComponentCount - 1 do
      with (Parente.Components[i] as TLabel) do
      begin
        LabelProperties:=TLabelProperties.Create();
        //usare Name= Hint perchè alcuni campi possono essere presenti più volte
        //nel riepilogo; perciò il nome del campo viene salvato nell'hint e non nel nome
        //del componente stesso
        LabelProperties.Name:=Hint;
        LabelProperties.Caption:=Caption;
        LabelProperties.Top:=Top;
        LabelProperties.Left:=Left;
        LabelProperties.Height:=Height;
        LabelProperties.Width:=Width;
        LabelProperties.Tag:=Tag;
        LabelProperties.UniqueName:=Name; //il nome è stato creato da CreaNomeUnivocoLabel
        A052FParCarMW.dicSezioni[Sezione].LstLabels.Add(LabelProperties);
      end;
    end;
end;

procedure TA052FParCarDtM1.GetFont(sezione:String);
var Parente:TScrollBox;
  FontProperties:TFontProperties;
begin
  Parente:=nil;
  if sezione = TSezione.INTESTAZIONE then
    Parente:=A052FParCar.Intestazione
  else if sezione = TSezione.DETTAGLIO then
    Parente:=A052FParCar.Dettaglio
  else
    Parente:=A052FParCar.Riepilogo;

  FontProperties:=A052FParCarMW.dicSezioni[sezione].FontProperties;
  if FontProperties.Name <> '' then
  begin
    with A052FParCar do
    begin
      Parente.Font.Color:=FontProperties.Color;
      Parente.Font.Name:=FontProperties.Name;
      Parente.Font.Size:=FontProperties.Size;
      Parente.Font.Style:=R180GetFontStyle(FontProperties.getStyle);
    end;
  end;
end;

procedure TA052FParCarDtM1.GetLabels(Sezione:String);
var
  LstLabels:TList<TLabelProperties>;
  LabelProperties:TLabelProperties;
begin
  LstLabels:=A052FParCarMW.dicSezioni[sezione].LstLabels;

  with A052FParCar do
  begin
    //Linea di partenza delle Impostazioni delle Labels
    for LabelProperties in LstLabels do
      AddLabel(Sezione,LabelProperties);
    end;
end;

procedure TA052FParCarDtM1.BDEQ950BeforeInsert(DataSet: TDataSet);
begin
  A052FParCar.DistruggiIntestazione;
  A052FParCar.DistruggiDettaglio;
  A052FParCar.DistruggiRiepilogo;
end;

procedure TA052FParCarDtM1.A052FParCarDtM1Destroy(Sender: TObject);
var i:Integer;
begin
  for i:=0 to Self.ComponentCount - 1 do
    if Self.Components[i] is TDataSet then
      (Self.Components[i] as TDataSet).Close;
  FreeAndNil(A052FParCarMW);
end;

procedure TA052FParCarDtM1.BDEQ950BeforeDelete(DataSet: TDataSet);
begin
  RegistraLog.SettaProprieta('C',R180Query2NomeTabella(DataSet),Copy(Name,1,4),DataSet,True);
  A052FParCarMW.selT950BeforeDelete;
end;

procedure TA052FParCarDtM1.BDEQ950AfterPost(DataSet: TDataSet);
var s: String;
begin
  A052FParCarMW.ResetDictSezioni;

  for s in A052FParCarMW.dicSezioni.Keys do
    SalvaImpostazioni(s);
  A052FParCarMW.selT950AfterPost;
  RegistraLog.RegistraOperazione;
end;

procedure TA052FParCarDtM1.selT950FilterRecord(DataSet: TDataSet;
  var Accept: Boolean);
begin
  Accept:=A052FParCarMW.SelT950Filter;
end;

procedure TA052FParCarDtM1.selT950AfterDelete(DataSet: TDataSet);
begin
  RegistraLog.RegistraOperazione;
  A052FParCarMW.selT950AfterDelete;
end;

procedure TA052FParCarDtM1.selT950AfterScroll(DataSet: TDataSet);
var lstErrori: TStringList;
  s: String;
begin
  lstErrori:=A052FParCarMW.SelT950AfterScroll;
  for s in lstErrori do
  begin
    MessageDlg(s, mtError,[mbOK],0);
  end;
  FreeAndNil(lstErrori);
  with A052FParCar do
  begin
    DistruggiIntestazione;
    DistruggiDettaglio;
    DistruggiRiepilogo;
  end;
  if A052FParCarMW.selT951.RecordCount > 0 then
  begin
    for s in A052FParCarMW.dicSezioni.Keys do
    begin
      GetFont(s);
      GetLabels(s);
    end;
  end;
  with A052FParCar do
  begin
    cmbOrientamento.ItemIndex:=0;  //LORENA 07/02/2005
    if selT950.FieldByName('ORIENTAMENTO').AsString = 'V' then
      cmbOrientamento.ItemIndex:=1
    else if selT950.FieldByName('ORIENTAMENTO').AsString = 'O' then
      cmbOrientamento.ItemIndex:=2;
  end;
end;

end.
