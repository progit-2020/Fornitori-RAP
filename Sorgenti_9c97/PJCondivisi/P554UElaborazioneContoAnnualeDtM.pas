unit P554UElaborazioneContoAnnualeDtM;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  R004UGESTSTORICODTM, Db, OracleData,  C700USelezioneAnagrafe, A000UCostanti, A000USessione, A000UInterfaccia, Variants,
  Oracle;


type
  TP554FElaborazioneContoAnnualeDtM = class(TR004FGestStoricoDtM)
    selP555_ID: TOracleDataSet;
    selP554: TOracleDataSet;
    insP554: TOracleQuery;
    delP555: TOracleQuery;
    updP554: TOracleQuery;
    delP554: TOracleQuery;
    seleP554: TOracleDataSet;
    selP552: TOracleDataSet;
    selP552a: TOracleDataSet;
    delP555a: TOracleQuery;
    delP555b: TOracleQuery;
    insP555: TOracleQuery;
    selP050: TOracleDataSet;
    selP500: TOracleDataSet;
    selP555: TOracleDataSet;
    selP552b: TOracleDataSet;
    selP555a: TOracleDataSet;
    selP555b: TOracleDataSet;
    selP553: TOracleDataSet;
    updP555: TOracleQuery;
    selP555Esporta: TOracleDataSet;
    selP551: TOracleDataSet;
    selP555Righe: TOracleDataSet;
    selQuery: TOracleDataSet;
    selP551Formato: TOracleDataSet;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  P554FElaborazioneContoAnnualeDtM: TP554FElaborazioneContoAnnualeDtM;

implementation

{$R *.DFM}

end.
