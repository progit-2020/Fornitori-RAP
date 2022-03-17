unit Wc10UFesteParticolariDM;

interface

uses
  System.SysUtils, System.Classes, Data.DB, Datasnap.DBClient, OracleData,
  Oracle, A000USessione, A000UInterfaccia, A000UCostanti;

type
  TWc10FFesteParticolariDM = class(TDataModule)
    selC010: TOracleDataSet;
    cdsLista: TClientDataSet;
    cdsListaGG: TClientDataSet;
    cdsListaPag: TClientDataSet;
    updCSI010: TOracleQuery;
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    const
      D_TipoFesta:array[0..2] of TItemsValues = (
        (Item:'Santo Patrono';                  Value:'A'),
        (Item:'Ex-festività';                   Value:'B'),
        (Item:'Festività in giorno di riposo';  Value:'C')
        );
      D_Scelte:array[0..3] of TItemsValues = (
        (Item:'Fruizione';                Value:'A'),
        (Item:'Pagamento';                Value:'B'),
        (Item:'Aumenta competenza ferie'; Value:'C'),
        (Item:'Scelta non concessa';      Value:'Z')
        );
  end;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure TWc10FFesteParticolariDM.DataModuleCreate(Sender: TObject);
var i:Integer;
begin
 try
  for i:=0 to Self.ComponentCount - 1 do
  begin
    if Components[i] is TOracleQuery then
      (Components[i] as TOracleQuery).Session:=SessioneOracle
    else if Components[i] is TOracleDataSet then
      (Components[i] as TOracleDataSet).Session:=SessioneOracle
    else if Components[i] is TOracleScript then
      (Components[i] as TOracleScript).Session:=SessioneOracle;
  end;
 except
 end;
end;

end.
