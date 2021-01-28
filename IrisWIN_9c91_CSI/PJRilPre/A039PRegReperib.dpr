program A039PRegReperib;

uses
  Forms,
  A039URegReperib in 'A039URegReperib.pas' {A039FRegReperib},
  R001UGESTTAB in '..\Repositary\R001UGESTTAB.pas' {R001FGestTab},
  A039URegReperibDTM1 in 'A039URegReperibDTM1.pas' {A039FREGREPERIBDTM1: TDataModule},
  R005UDataModuleMW in '..\Repositary\R005UDataModuleMW.pas' {R005FDataModuleMW: TDataModule},
  A039URegReperibMW in '..\MWRilPre\A039URegReperibMW.pas' {A039FRegReperibMW: TDataModule};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TA039FRegReperib, A039FRegReperib);
  Application.CreateForm(TA039FREGREPERIBDTM1, A039FREGREPERIBDTM1);
  Application.Run;
end.
