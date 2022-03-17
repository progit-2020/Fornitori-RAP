unit A090UAssenzeAnnoMW;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, R005UDataModuleMW, USelI010, A000UInterfaccia, DB, OracleData;

type
  TA090FAssenzeAnnoMW = class(TR005FDataModuleMW)
    Q265: TOracleDataSet;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    { Private declarations }
  public
    selI010:TselI010;
  end;

implementation

{$R *.dfm}

procedure TA090FAssenzeAnnoMW.DataModuleCreate(Sender: TObject);
begin
  inherited;
  selI010:=TselI010.Create(Self);
  selI010.Apri(SessioneOracle,Parametri.Layout,Parametri.Applicazione,'NOME_CAMPO,NOME_LOGICO,POSIZIONE','','NOME_LOGICO');
  Q265.Open;
end;

procedure TA090FAssenzeAnnoMW.DataModuleDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(selI010);
end;

end.
