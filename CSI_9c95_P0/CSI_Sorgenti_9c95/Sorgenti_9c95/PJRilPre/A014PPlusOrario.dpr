program A014PPlusOrario;

uses
  SysUtils,Forms,
  R001UGestTab in '..\Repositary\R001UGESTTAB.pas' {R001FGestTab},
  A014UPlusOrario in 'A014UPlusOrario.pas' {A014FPlusOrario},
  A014UPlusOrarioDtM1 in 'A014UPlusOrarioDtM1.pas' {A014FPlusOrarioDtM1: TDataModule};

{$R *.RES}

begin
  Application.Initialize;
  //TimeSeparator:=':';
  Application.CreateForm(TA014FPlusOrario, A014FPlusOrario);
  Application.CreateForm(TA014FPlusOrarioDtM1, A014FPlusOrarioDtM1);
  Application.Run;
end.
