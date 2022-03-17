unit A109UImmaginiMW;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, R005UDataModuleMW, A000UInterfaccia, Oracle, OracleData, DB;

type
  TA109FimmaginiMW = class(TR005FDataModuleMW)
    selT004: TOracleDataSet;
    selT004TIPO: TStringField;
    selT004IMMAGINE: TBlobField;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    OS:TOracleSession;
  public
    { Public declarations }
  end;


implementation

{$R *.dfm}

procedure TA109FimmaginiMW.DataModuleCreate(Sender: TObject);
begin
  inherited;
  //Alberto 22/08/2006: si usa una specifica connessione Oracle in modo che
  //possa usare i capi BLOB invece che LONG RAW
  //E' necessario che sia UseOCI7 = False
  OS:=TOracleSession.create(nil);
  OS.LogonDatabase:=SessioneOracle.LogonDataBase;
  OS.LogonUsername:=SessioneOracle.LogonUsername;
  OS.LogonPassword:=SessioneOracle.LogonPassword;
  OS.LogonDatabase:=SessioneOracle.LogonDataBase;
  OS.Preferences.UseOCI7:=False;
  OS.Logon;
  selT004.Session:=OS;
  selT004.Open;
end;

procedure TA109FimmaginiMW.DataModuleDestroy(Sender: TObject);
begin
  inherited;
  OS.Logoff;
end;

end.
