unit reg_meIW15NewComponents;

interface

uses
  Classes,
  Graphics, ToolsAPI, SysUtils,
  medpIWDBGrid,
  medpIWTabControl,
  medpIWStatusBar,
  medpIWImageButton,
  medpIWMulticolumnComboBox;

resourcestring
  NOME_PACKAGE = 'Componenti MEDP NEW per IW 15.0.17';
  COMPILATO_IL = 'Compilato il %s %s';
  DATA_COMPILAZIONE = '26/11/2018';
  ORA_COMPILAZIONE = '12:10';

procedure AggiungiInSplashScreen;
procedure Register;

implementation

procedure AggiungiInSplashScreen;
var
  Icona:TBitmap;
begin
  Icona:=TBitmap.Create;
  try
    Icona.LoadFromResourceName(HInstance,'ICONA_SPLASH');
    SplashScreenServices.AddPluginBitmap(NOME_PACKAGE,Icona.Handle,False,
                                         Format(COMPILATO_IL,[DATA_COMPILAZIONE,ORA_COMPILAZIONE]));
  finally
    Icona.Free;
  end;
end;

procedure Register;
begin
  RegisterComponents('MEdp IW_New', [TmedpIWDBGrid]);
  RegisterComponents('MEdp IW_New', [TmedpIWTabControl]);
  RegisterComponents('MEdp IW_New', [TmedpIWStatusBar]);
  RegisterComponents('MEdp IW_New', [TmedpIWImageButton]);
  RegisterComponents('MEdp IW_New', [TmedpIWMulticolumnComboBox]);
end;

initialization
  AggiungiInSplashScreen;

end.
