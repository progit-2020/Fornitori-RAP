unit A034UIntPagheDTM1;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, A000UCostanti, A000USessione,A000UInterfaccia, DbCtrls, RegistrazioneLog,
  OracleData, Oracle, C180FunzioniGenerali, Variants,
  A034UIntPagheMW,A000UMessaggi;

type
  TA034FINTPAGHEDTM1 = class(TDataModule)
    selT190: TOracleDataSet;
    dsc190: TDataSource;
    selT190CODICE: TStringField;
    selT190CODINTERNO: TStringField;
    selT190FLAG: TStringField;
    selT190VOCE_PAGHE: TStringField;
    selT190Descrizione: TStringField;
    selT190ORDINE: TIntegerField;
    selT190UM: TStringField;
    procedure A034FINTPAGHEDTM1Create(Sender: TObject);
    procedure A034FINTPAGHEDTM1Destroy(Sender: TObject);
    procedure selT190FilterRecord(DataSet: TDataSet; var Accept: Boolean);
    procedure selT190BeforeDeleteInsert(DataSet: TDataSet);
    procedure selT190CalcFields(DataSet: TDataSet);
    procedure selT190FLAGValidate(Sender: TField);
    procedure selT190BeforePost(DataSet: TDataSet);
  private
    { Private declarations }
    procedure AllineamentoCodici;
  public
    { Public declarations }
    A034FIntPagheMW: TA034FIntPagheMW;
  end;

var
  A034FINTPAGHEDTM1: TA034FINTPAGHEDTM1;

implementation

uses A034UIntPaghe;
{$R *.DFM}

procedure TA034FINTPAGHEDTM1.A034FINTPAGHEDTM1Create(Sender: TObject);
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
  A034FIntPagheMW:=TA034FIntPagheMW.Create(Self);
  A034FIntPagheMW.selT190_Funzioni:=selT190;
  A034FIntPagheMW.ImpostaSelC9ScaricoPaghe;

  A034FIntPaghe.DButton.DataSet:=A034FIntPagheMW.selC9ScaricoPaghe;
  if A034FIntPagheMW.selC9ScaricoPaghe.FieldByName('CODICE').AsString = '<INTERFACCIA UNICA>' then
  begin
    A034FIntPaghe.lblInterfaccia.Caption:='';
    A034FIntPaghe.DBText1.DataSource:=nil;
    A034FIntPaghe.DBText2.DataSource:=nil;
    A034FIntPaghe.DBText1.Caption:='<INTERFACCIA UNICA>';
  end
  else
  begin
    A034FIntPaghe.lblInterfaccia.Caption:=Parametri.CampiRiferimento.C9_ScaricoPaghe + ':';
    A034FIntPaghe.DBText1.DataSource:=A034FIntPaghe.DButton;
    A034FIntPaghe.DBText2.DataSource:=A034FIntPaghe.DButton;
  end;
  selT190.Open;
  AllineamentoCodici;
  selT190.Refresh;
end;

procedure TA034FINTPAGHEDTM1.AllineamentoCodici;
begin
  selT190.ReadOnly:=False;
  A034FIntPagheMW.AllineaCodici;
  selT190.ReadOnly:=True;
end;

procedure TA034FINTPAGHEDTM1.A034FINTPAGHEDTM1Destroy(Sender: TObject);
var i:Integer;
begin
  FreeAndNil(A034FIntPagheMW);
  for i:=0 to Self.ComponentCount - 1 do
    if Self.Components[i] is TDataSet then
      (Self.Components[i] as TDataSet).Close;
end;

procedure TA034FINTPAGHEDTM1.selT190FilterRecord(DataSet: TDataSet;
  var Accept: Boolean);
begin
  Accept:=A034FIntPagheMW.AcceptFilterT190;
end;

procedure TA034FINTPAGHEDTM1.selT190BeforeDeleteInsert(DataSet: TDataSet);
begin
  Abort;
end;


procedure TA034FINTPAGHEDTM1.selT190CalcFields(DataSet: TDataSet);
begin
  A034FIntPagheMW.CalcFieldsT190;
end;

procedure TA034FINTPAGHEDTM1.selT190FLAGValidate(Sender: TField);
begin
  if (Sender.AsString <> 'S') and (Sender.AsString <> 'N') then
    raise Exception.Create('Valori amessi: S/N');
end;

procedure TA034FINTPAGHEDTM1.selT190BeforePost(DataSet: TDataSet);
var i:Integer;
  VoceOld:String;
begin
  for i:=1 to High(VettConst) do
    if selT190.FieldByName('CodInterno').AsString = VettConst[i].CodInt then
    begin
      if Trim(VettConst[i].VocePaghe) = 'S' then
      begin
        if (selT190.FieldByName('Flag').AsString = 'S') and (selT190.FieldByName('Voce_Paghe').AsString = '') then
          raise Exception.Create(A000MSG_A034_ERR_NO_CODICE_PAGHE);
        //Controllo voci paghe
        if (DataSet.State = dsInsert) or (selT190.FieldByName('Voce_Paghe').medpOldValue = null) then
          VoceOld:=''
        else
          VoceOld:=selT190.FieldByName('Voce_Paghe').medpOldValue;
        if not A034FIntPagheMW.selControlloVociPaghe.ControlloVociPaghe(VoceOld,selT190.FieldByName('Voce_Paghe').AsString) then
          if R180MessageBox(A034FIntPagheMW.selControlloVociPaghe.MessaggioLog,'DOMANDA') = mrNo then
            Abort
          else
            A034FIntPagheMW.selControlloVociPaghe.ValutaInserimentoVocePaghe(selT190.FieldByName('Voce_Paghe').AsString);
      end
      else
        selT190.FieldByName('Voce_Paghe').Clear;
      Break;
    end;
end;

end.
