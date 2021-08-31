unit A060UTimbIrregolariDtM1;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  DB, A000UCostanti, A000USessione,A000UInterfaccia, C180FunzioniGenerali, Oracle, OracleData,
  Variants, DateUtils, StdCtrls, DBGrids, ComCtrls, RegistrazioneLog, A060UTimbIrregolariMW;

type
  TA060FTimbIrregolariDtM1 = class(TDataModule)
  procedure A060FTimbIrregolariDtM1Create(Sender: TObject);
  procedure A060FTimbIrregolariDtM1Destroy(Sender: TObject);
  private
    { Private declarations }
  public
    A060MW:TA060FTimbIrregolariMW;
  end;

var
  A060FTimbIrregolariDtM1: TA060FTimbIrregolariDtM1;

implementation

{$R *.DFM}

procedure TA060FTimbIrregolariDtM1.A060FTimbIrregolariDtM1Create(Sender: TObject);
begin
  A060MW:=TA060FTimbIrregolariMW.Create(nil);
end;

procedure TA060FTimbIrregolariDtM1.A060FTimbIrregolariDtM1Destroy(Sender: TObject);
begin
  FreeAndNil(A060MW);
end;


end.

