program A090PAssenzeAnno;

uses
  Forms,
  MidasLib,
  A090UAssenzeAnno in 'A090UAssenzeAnno.pas' {A090FAssenzeAnno},
  A090UAssenzeAnnoDtM1 in 'A090UAssenzeAnnoDtM1.pas' {A090FAssenzeAnnoDtM1: TDataModule},
  A090UStampa in 'A090UStampa.pas' {A090FStampa},
  SelAnagrafe in '..\Componenti\SelAnagrafe.pas' {frmSelAnagrafe: TFrame},
  R005UDataModuleMW in '..\Repositary\R005UDataModuleMW.pas' {R005FDataModuleMW: TDataModule},
  A090UAssenzeAnnoMW in '..\MWRilPre\A090UAssenzeAnnoMW.pas' {A090FAssenzeAnnoMW: TDataModule};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TA090FAssenzeAnno, A090FAssenzeAnno);
  Application.CreateForm(TA090FAssenzeAnnoDtM1, A090FAssenzeAnnoDtM1);
  Application.Run;
end.
