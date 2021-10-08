unit A167URegistraIncentiviDtM;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, R004UGESTSTORICODTM, DB, OracleData,  A000UCostanti, A000USessione, A000UInterfaccia,
  Oracle, DBClient, DatiBloccati, QueryStorico, A167URegistraIncentiviMW;

type
  TA167FRegistraIncentiviDtM = class(TR004FGestStoricoDtM)
    dsrI010: TDataSource;
    selT775: TOracleDataSet;
    selT760: TOracleDataSet;
    selT762: TOracleDataSet;
    selT460: TOracleDataSet;
    selT040: TOracleDataSet;
    selT040A: TOracleDataSet;
    selT770: TOracleDataSet;
    selT763: TOracleDataSet;
    ControlloT257: TOracleDataSet;
    selP150: TOracleDataSet;
    selP030: TOracleDataSet;
    TabellaStampa: TClientDataSet;
    selT766: TOracleDataSet;
    TabellaStampaTotali: TClientDataSet;
    selT769: TOracleDataSet;
    selT762Risp: TOracleDataSet;
    ControlloT770: TOracleDataSet;
    selT762Imp: TOracleDataSet;
    selT762ImpTot: TOracleDataSet;
    selT070: TOracleDataSet;
    selT071: TOracleDataSet;
    ControlloT070: TOracleDataSet;
    selT040B: TOracleDataSet;
    TabellaAcconti: TClientDataSet;
    selT774: TOracleDataSet;
    selT768: TOracleDataSet;
    selT767: TOracleDataSet;
    selT768Flex: TOracleDataSet;
    selSG735: TOracleDataSet;
    TabellaTipoD: TClientDataSet;
    selT430Lav: TOracleDataSet;
    selT430Dati: TOracleDataSet;
    CreaTabellaTest: TOracleScript;
    selTabellaTest: TOracleDataSet;
    cdsT430Dati: TClientDataSet;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    { Private declarations }
  public
    selDatiBloccati:TDatiBloccati;
    A167FRegistraIncentiviMW : TA167FRegistraIncentiviMW;
  end;

var
  A167FRegistraIncentiviDtM: TA167FRegistraIncentiviDtM;

implementation

uses A167URegistraIncentivi;

{$R *.dfm}

procedure TA167FRegistraIncentiviDtM.DataModuleCreate(Sender: TObject);
begin
  inherited;
  InizializzaDataSet(selT762,[evAfterDelete,
                              evAfterPost,
                              evBeforeDelete,
                              evBeforePostNoStorico]);
  A167FRegistraIncentiviMW:=TA167FRegistraIncentiviMW.Create(Self);
  dsrI010.DataSet:=A167FRegistraIncentiviMW.selI010;
  selDatiBloccati:=TDatiBloccati.Create(Self);
  selT460.Open;
  selT766.Open;
  A167FRegistraIncentivi.PeriodoProva:=TPeriodoProva.Create(nil);
  A167FRegistraIncentivi.PeriodoProva.Session:=SessioneOracle;
  cdsT430Dati.CreateDataSet;
  cdsT430Dati.LogChanges:=False;

end;

procedure TA167FRegistraIncentiviDtM.DataModuleDestroy(Sender: TObject);
begin
  FreeAndNil(A167FRegistraIncentiviMW);
  inherited;
  FreeAndNil(selDatiBloccati);
  FreeAndNil(A167FRegistraIncentivi.PeriodoProva);
end;

end.
