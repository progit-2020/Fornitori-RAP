program A008POperatori;

uses
  Forms,
  OracleMonitor,
  R001UGESTTAB in '..\Repositary\R001UGESTTAB.pas' {R001FGestTab},
  A008UOperatoriDtM1 in 'A008UOperatoriDtM1.pas' {A008FOperatoriDtM1: TDataModule},
  TABELLE99 in '..\Repositary\TABELLE99.pas' {FrmTabelle99},
  A008UAzOper in 'A008UAzOper.pas' {A008FAzOper},
  A008UAziende in 'A008UAziende.pas' {A008FAziende},
  A008UListaGriglia in 'A008UListaGriglia.pas' {A008FListaGriglia},
  A008UCambioPassword in 'A008UCambioPassword.pas' {A008FCambioPassword},
  A008UProfili in 'A008UProfili.pas' {A008FProfili},
  A008UOperatori in 'A008UOperatori.pas' {A008FOperatori},
  A008ULoginDipendenti in 'A008ULoginDipendenti.pas' {A008FLoginDipendenti},
  A008UAccessi in 'A008UAccessi.pas' {A008FAccessi},
  ToolbarFiglio in '..\Componenti\ToolbarFiglio.pas' {frmToolbarFiglio: TFrame},
  SelAnagrafe in '..\Componenti\SelAnagrafe.pas' {frmSelAnagrafe: TFrame},
  A008UIterCondizValidita in 'A008UIterCondizValidita.pas' {A008FIterCondizValidita},
  RegolePassword in '..\Componenti\RegolePassword.pas',
  A181UAziendeMW in '..\MWRilPre\A181UAziendeMW.pas',
  R005UDataModuleMW in '..\Repositary\R005UDataModuleMW.pas' {R005FDataModuleMW: TDataModule},
  A000UMessaggi in '..\Copy\A000UMessaggi.pas',
  A008URegoleAccessoIP in 'A008URegoleAccessoIP.pas' {A008FRegoleAccessoIP},
  C600USelAnagrafe in '..\Copy\C600USelAnagrafe.pas' {C600frmSelAnagrafe: TFrame};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TA008FAzOper, A008FAzOper);
  Application.CreateForm(TA008FOperatoriDtM1, A008FOperatoriDtM1);
  Application.CreateForm(TA008FIterCondizValidita, A008FIterCondizValidita);
  Application.Run;
end.
