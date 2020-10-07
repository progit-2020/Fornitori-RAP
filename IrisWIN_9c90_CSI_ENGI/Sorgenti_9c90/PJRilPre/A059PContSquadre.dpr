program A059PContSquadre;

uses
  Forms,
  A059UContSquadre in 'A059UContSquadre.pas' {A059FContSquadre},
  A059UContSquadreDtM1 in 'A059UContSquadreDtM1.pas' {A059FContSquadreDtM1: TDataModule},
  A059UStampa in 'A059UStampa.pas' {A059FStampa},
  R005UDataModuleMW in '..\Repositary\R005UDataModuleMW.pas' {R005FDataModuleMW: TDataModule},
  A059UContSquadraMW in '..\MWRilPre\A059UContSquadraMW.pas' {A059FContSquadraMW: TDataModule};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TA059FContSquadre, A059FContSquadre);
  Application.CreateForm(TA059FContSquadreDtM1, A059FContSquadreDtM1);
  Application.Run;
end.
