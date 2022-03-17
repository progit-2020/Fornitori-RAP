program A114PEstrazioniStampe;

uses
  Forms,
  MidasLib,
  A114UEstrazioniStampeDtm in 'A114UEstrazioniStampeDtm.pas' {A114FEstrazioniStampeDtm: TDataModule},
  A114UEstrazioniStampe in 'A114UEstrazioniStampe.pas' {A114FEstrazioniStampe},
  A114UVisFile in 'A114UVisFile.pas' {A114FVisFile};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TA114FEstrazioniStampeDtm, A114FEstrazioniStampeDtm);
  Application.CreateForm(TA114FEstrazioniStampe, A114FEstrazioniStampe);
  Application.CreateForm(TA114FVisFile, A114FVisFile);
  Application.Run;
end.
