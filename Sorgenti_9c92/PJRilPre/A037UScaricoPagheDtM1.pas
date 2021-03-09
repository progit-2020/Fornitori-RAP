unit A037UScaricoPagheDtM1;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, A000UCostanti, A000USessione,A000UInterfaccia, OracleData, Oracle,
  C180FunzioniGenerali, Variants, C700USelezioneAnagrafe,
  USelI010, DBClient,A037UScaricoPagheMW;

type
  TA037FScaricoPagheDtM1 = class(TDataModule)
    DI010: TDataSource;
    QEnte: TOracleDataSet;
    Q210: TOracleDataSet;
    procedure A037FScaricoPagheDtM1Create(Sender: TObject);
    procedure A037FScaricoPagheDtM1Destroy(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    A037FScaricoPagheMW: TA037FScaricoPagheMW;
    selI010A:TselI010;
    procedure GetUltimaDataCassa(MeseSucc:Boolean);
  end;

var
  A037FScaricoPagheDtM1: TA037FScaricoPagheDtM1;

implementation

uses A037UScaricoPaghe;

{$R *.DFM}

procedure TA037FScaricoPagheDtM1.A037FScaricoPagheDtM1Create(Sender: TObject);
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
  A037FScaricoPagheMW:=TA037FScaricoPagheMW.Create(Self);
  selI010A:=TselI010.Create(Self);
  selI010A.Apri(SessioneOracle,'',Parametri.Applicazione,'NOME_CAMPO,NOME_LOGICO','','NOME_LOGICO');
  DI010.DataSet:=selI010A;
  //selT193.Open;
  GetUltimaDataCassa(True);
  A037FScaricoPaghe.DBLookupParPaghe.ListSource:=A037FScaricoPagheMW.dsrT191;
end;

procedure TA037FScaricoPagheDtM1.GetUltimaDataCassa(MeseSucc:Boolean);
begin
  //Verifica della registrazione della data di cassa
  if A037FScaricoPagheMW.selT199.RecordCount > 0 then
  begin
    A037FScaricoPaghe.DataCassa:=R180InizioMese(A037FScaricoPagheMW.selT199.FieldByName('DATA_CASSA').AsDateTime);
    A037FScaricoPaghe.edtUltimaDataCassa.Text:=FormatDateTime('mmmm yyyy',A037FScaricoPaghe.DataCassa);
  end
  else
    with A037FScaricoPagheMW.selMaxDataCassa do
    try
      Open;
      if Fields[0].IsNull then
      begin
        A037FScaricoPaghe.DataCassa:=R180InizioMese(Date);
        A037FScaricoPaghe.edtUltimaDataCassa.Text:='';
      end
      else
      begin
        A037FScaricoPaghe.DataCassa:=R180InizioMese(Fields[0].AsDateTime);
        A037FScaricoPaghe.edtUltimaDataCassa.Text:=FormatDateTime('mmmm yyyy',Fields[0].AsDateTime);
      end;
    finally
      Close;
    end;
  if MeseSucc then
  begin
    A037FScaricoPaghe.DataFile:=A037FScaricoPaghe.DataCassa;
    A037FScaricoPaghe.EDataFile.Text:=FormatDateTime('dd/mm/yyyy',A037FScaricoPaghe.DataFile);
  end;
end;

procedure TA037FScaricoPagheDtM1.A037FScaricoPagheDtM1Destroy(Sender: TObject);
var i:Integer;
begin
  FreeAndNil(A037FScaricoPagheMW);
  for i:=0 to Self.ComponentCount - 1 do
    if Self.Components[i] is TOracleDataSet then
      (Self.Components[i] as TOracleDataSet).Close;
  FreeAndNil(selI010A);
end;

end.
