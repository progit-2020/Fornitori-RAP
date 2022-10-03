unit WC700USelezioneAnagrafeDM;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, WR300UBaseDM, DB, OracleData, A000UInterfaccia, A000USessione, Oracle;

type
  TWC700ScrollEvent = procedure(DataSet: TDataSet) of object;

  TWC700FSelezioneAnagrafeDM = class(TWR300FBaseDM)
    selAnagrafe: TOracleDataSet;
    dscAnagrafe: TDataSource;
    selDistinct: TOracleDataSet;
    selT003Nome: TOracleDataSet;
    selT003: TOracleDataSet;
    insT003: TOracleQuery;
    delT003: TOracleQuery;
    procedure selAnagrafeAfterScroll(DataSet: TDataSet);
    procedure selT003NomeFilterRecord(DataSet: TDataSet; var Accept: Boolean);
  private
    //function GetWC700Progressivo:Integer;
  public
    // property WC700Progressivo:Integer read GetWC700Progressivo;
    ScrollEvent: TWC700ScrollEvent;
  end;

implementation

{$R *.dfm}

(*
function TWC700FSelezioneAnagrafeDM.GetWC700Progressivo:Integer;
begin
  Result:=-1;
  if (selAnagrafe.Active) and (selAnagrafe.RecordCount > 0) then
  try
    Result:=selAnagrafe.FieldByName('PROGRESSIVO').AsInteger;
  except
  end;
end;
*)

procedure TWC700FSelezioneAnagrafeDM.selAnagrafeAfterScroll(DataSet: TDataSet);
begin
  inherited;
  if Assigned(ScrollEvent) then
    ScrollEvent(DataSet);
end;

procedure TWC700FSelezioneAnagrafeDM.selT003NomeFilterRecord(DataSet: TDataSet; var Accept: Boolean);
begin
  inherited;
  Accept:=A000FiltroDizionario('SELEZIONI ANAGRAFICHE',DataSet.FieldByName('NOME').AsString);
end;

end.
