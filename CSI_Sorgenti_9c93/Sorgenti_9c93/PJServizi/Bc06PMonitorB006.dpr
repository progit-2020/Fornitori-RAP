program Bc06PMonitorB006;

uses
  Vcl.Forms,
  System.SysUtils,
  Oracle,
  OracleMonitor,
  Midaslib,
  C180FunzioniGenerali,
  Classes,
  HtmlHelpViewer,
  Bc06UMonitorB006 in 'Bc06UMonitorB006.pas' {Bc06FMonitorB006},
  R001UGESTTAB in '..\Repositary\R001UGESTTAB.pas' {R001FGestTab},
  R004UGestStoricoDTM in '..\Repositary\R004UGestStoricoDTM.pas' {R004FGestStoricoDtM: TDataModule},
  Bc06UConfigMonitorB006 in 'Bc06UConfigMonitorB006.pas' {Bc06FConfigMonitorB006},
  Bc06UMonitorB006DtM in 'Bc06UMonitorB006DtM.pas' {Bc06FMonitorB006DtM: TDataModule},
  A000Versione in '..\Copy\A000Versione.pas',
  A000UInterfaccia in '..\Copy\A000UInterfaccia.pas',
  A000USessione in '..\Copy\A000USessione.pas',
  ToolbarFiglio in '..\Componenti\ToolbarFiglio.pas' {frmToolbarFiglio: TFrame},
  Bc06UExecMonitorB006DtM in 'Bc06UExecMonitorB006DtM.pas' {Bc06FExecMonitorB006DtM: TDataModule},
  Bc06UClassi in 'Bc06UClassi.pas',
  C012UVisualizzaTesto in '..\Copy\C012UVisualizzaTesto.pas' {C012FVisualizzaTesto},
  C017UEMailDtM in '..\Copy\C017UEMailDtM.pas' {C017FEMailDtM: TDataModule},
  InputPeriodo in '..\Componenti\InputPeriodo.pas' {frmInputPeriodo: TFrame};

var
  Oper:Integer;
  Configurazione:TConfigIni;
  LocalOracleAliasList:TStringList;
  CHMFile:String;

{$R *.res}

begin
  {$WARN SYMBOL_PLATFORM OFF}
  ReportMemoryLeaksOnShutdown:=(DebugHook <> 0);
  {$WARN SYMBOL_PLATFORM ON}
  Application.Initialize;
  Application.MainFormOnTaskbar:=True;
  Application.Title:=NOME_APPLICAZIONE;
  Parametri.Applicazione:='RILPRE';
  Parametri.NomePJ:='Presenze-Assenze';
  Parametri.VersionePJ:=VersionePA;
  Parametri.BuildPJ:=BuildPA;
  Parametri.DataPJ:=DataPA;

  Configurazione:=TConfigIni.GetConfig(IncludeTrailingPathDelimiter(GetCurrentDir) + CONFIG_INI_FILE);
  LocalOracleAliasList:=TStringList.Create;
  LocalOracleAliasList.Assign(Oracle.OracleAliasList);
  LocalOracleAliasList.CaseSensitive:=False;

  try
    while True do
    begin
      Oper:=Password(NOME_APPLICAZIONE + Format(' %s(%s)',[VersionePA,BuildPA]),Configurazione.Azienda,Configurazione.Database);

      if Oper = -1 then
      begin
        Parametri.Azienda:='';
        Break;
      end;

      if (LocalOracleAliasList.IndexOf(CONFIG_DB.ToUpper) > -1) then
      begin
        // In questo caso consento l'accesso solo con CONFIG_DB o CONFIG_DB_TEST
        if not R180In(Parametri.Database.ToUpper,[CONFIG_DB.ToUpper(*,CONFIG_DB_TEST.ToUpper*)]) then
        begin
          R180MessageBox(Format('E'' possibile collegarsi solo al database %s.',[CONFIG_DB(*,CONFIG_DB_TEST*)]),ESCLAMA);
          Continue;
        end;
      end;

      // Verifica permessi: nel caso che la funzione non esista (versioni vecchie) per default accesso completo a SYSMAN,MONDOEDP e sola lettura gli altri
      if False and (A000GetAbilitazioniFunzioni('Funzione','OpenBc06MonitorB006').Funzione <> '') then
      begin
        SolaLettura:=False;
        case A000GetInibizioni('Funzione','OpenBc06MonitorB006') of
          'N':begin
                R180MessageBox('Questa funzione non è abilitata per l''utente corrente.',ESCLAMA);
                Continue;
              end;
          'R':SolaLettura:=True;
        end;
      end
      else
        SolaLettura:=not R180In(Parametri.Operatore,['MONDOEDP','SYSMAN']);

      Break;
    end;
  finally
    FreeAndNil(Configurazione);
    FreeAndNil(LocalOracleAliasList);
  end;

  if Parametri.Azienda = '' then
    Application.Terminate;

  A000ParamDBOracle(SessioneOracle);

  Application.HelpFile:='Help\IrisWIN_accessori.chm';
  if False then
  begin
    // Copia del file CHM in directory temporanea
    // Per il momento questa funzione è implementata, ma è inutilizzata
    CHMFile:=R180PreparaFileHelpTemp('IrisWIN_accessori.chm');
    if CHMFile <> '' then
      Application.HelpFile:=CHMFile
    else
      Application.HelpFile:='Help\IrisWIN_accessori.chm';
  end;

  Application.CreateForm(TBc06FMonitorB006DtM, Bc06FMonitorB006DtM);
  Application.CreateForm(TBc06FMonitorB006, Bc06FMonitorB006);
  Application.Run;
end.
