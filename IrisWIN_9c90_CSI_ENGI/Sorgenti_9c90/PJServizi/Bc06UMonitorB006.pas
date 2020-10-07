unit Bc06UMonitorB006;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, System.Actions, Vcl.ActnList, Vcl.Menus,
  A000USessione, A000UInterfaccia, Oracle, Bc06UConfigMonitorB006,
  System.ImageList, Vcl.ImgList, Vcl.ToolWin, Vcl.ComCtrls, Data.DB, Vcl.Grids,
  Vcl.DBGrids, Vcl.StdCtrls, Bc06UMonitorB006DtM, System.StrUtils, Vcl.ExtCtrls,
  C180FunzioniGenerali, Bc06UClassi, A083UMsgElaborazioni;

type
  TBc06FMonitorB006 = class(TForm)
    MainMenu: TMainMenu;
    File1: TMenuItem;
    N1: TMenuItem;
    Chiudi1: TMenuItem;
    ActionList: TActionList;
    actStartMonitoraggio: TAction;
    actStopMonitoraggio: TAction;
    actChiudi: TAction;
    actConfigurazione: TAction;
    Configurazione1: TMenuItem;
    ToolBar: TToolBar;
    ImageList1: TImageList;
    ToolButton1: TToolButton;
    ToolButton2: TToolButton;
    ToolButton3: TToolButton;
    ToolButton4: TToolButton;
    ToolButton5: TToolButton;
    ToolButton6: TToolButton;
    ToolButton7: TToolButton;
    ToolButton8: TToolButton;
    grpUltimoControllo: TGroupBox;
    dgrdInfoControllo: TDBGrid;
    ToolButton9: TToolButton;
    ToolButton10: TToolButton;
    actControllaOra: TAction;
    pnlStato: TPanel;
    lblTitStato: TLabel;
    lblStato: TLabel;
    pnlLog: TPanel;
    splSplitter: TSplitter;
    pgcMsgControllo: TPageControl;
    tbsMsg1: TTabSheet;
    memMsg1: TMemo;
    tbsMsg2: TTabSheet;
    memMsg2: TMemo;
    Splitter2: TSplitter;
    grpLogControllo: TGroupBox;
    memLogControllo: TMemo;
    actLogAttivit‡: TAction;
    ToolButton11: TToolButton;
    ToolButton12: TToolButton;
    pnlPulsantiLog: TPanel;
    btnSvuotaLog: TButton;
    procedure actConfigurazioneExecute(Sender: TObject);
    procedure actStartMonitoraggioExecute(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure actStopMonitoraggioExecute(Sender: TObject);
    procedure actControllaOraExecute(Sender: TObject);
    procedure actChiudiExecute(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure dgrdInfoControlloDrawColumnCell(Sender: TObject;
      const Rect: TRect; DataCol: Integer; Column: TColumn;
      State: TGridDrawState);
    procedure actLogAttivit‡Execute(Sender: TObject);
    procedure btnSvuotaLogClick(Sender: TObject);
  private
    { Private declarations }
  public
    procedure SvuotaLog;
    procedure AggiungiLineaLog(Linea:String);
    procedure AggiornaInterfaccia;
    procedure BloccaInterfaccia;
  end;

var
  Bc06FMonitorB006: TBc06FMonitorB006;

implementation

{$R *.dfm}

procedure TBc06FMonitorB006.FormShow(Sender: TObject);
begin
  pgcMsgControllo.ActivePageIndex:=0;
  actStartMonitoraggio.Enabled:=False;
  actStopMonitoraggio.Enabled:=False;
  actControllaOra.Enabled:=False;
  Bc06FMonitorB006DtM.LeggiConfigurazione;
  AggiornaInterfaccia;
end;

procedure TBc06FMonitorB006.actChiudiExecute(Sender: TObject);
begin
  if Bc06FMonitorB006DtM.MonitorAttivo then
    raise Exception.Create('Arrestare il controllo prima di chiudere l''applicazione.');
  if R180MessageBox('Uscire dall''utilit‡ di monitoraggio?',DOMANDA) = mrYes then
    Application.Terminate;
end;

procedure TBc06FMonitorB006.actConfigurazioneExecute(Sender: TObject);
var
  OldSolaLettura:Boolean;
begin
  if Bc06FConfigMonitorB006 <> nil then
    FreeAndNil(Bc06FConfigMonitorB006);

  OldSolaLettura:=SolaLettura;
  SolaLettura:=SolaLettura or Bc06FMonitorB006DtM.MonitorAttivo; // Se il monitor Ë attivo blocco le modifiche
  Bc06FConfigMonitorB006:=TBc06FConfigMonitorB006.Create(Self);
  try
    Bc06FConfigMonitorB006.ShowModal;
    if Bc06FConfigMonitorB006.Modificato and not SolaLettura then // Sicurezza
    begin
      actStartMonitoraggio.Enabled:=False;
      actStopMonitoraggio.Enabled:=False;
      actControllaOra.Enabled:=False;
      Bc06FMonitorB006DtM.LeggiConfigurazione;
      AggiornaInterfaccia;
    end;
  finally
    SolaLettura:=OldSolaLettura;
    FreeAndNil(Bc06FConfigMonitorB006);
  end;
end;

procedure TBc06FMonitorB006.actControllaOraExecute(Sender: TObject);
begin
  Cursor:=crHourGlass;
  BloccaInterfaccia;
  try
    Bc06FMonitorB006DtM.ControllaOra;
  finally
    Cursor:=crDefault;
    AggiornaInterfaccia;
  end;
end;

procedure TBc06FMonitorB006.actLogAttivit‡Execute(Sender: TObject);
begin
  OpenA083MsgElaborazioni(Parametri.Azienda,Parametri.Operatore,'Bc06','');
end;

procedure TBc06FMonitorB006.actStartMonitoraggioExecute(Sender: TObject);
begin
  if Bc06FMonitorB006DtM.MonitorAttivo then
    raise Exception.Create('Il monitoraggio Ë gi‡ attivo.');
  // Lancio manualmente i controlli la prima volta
  Bc06FMonitorB006DtM.ControllaOra;
  Bc06FMonitorB006DtM.StartMonitor;
end;

procedure TBc06FMonitorB006.actStopMonitoraggioExecute(Sender: TObject);
begin
  Bc06FMonitorB006DtM.StopMonitor;
end;

procedure TBc06FMonitorB006.SvuotaLog;
begin
  memLogControllo.Lines.Clear;
end;

procedure TBc06FMonitorB006.AggiungiLineaLog(Linea:String);
begin
  memLogControllo.Lines.Add(Format('[%s]: %s',[DateTimeToStr(Now),Linea]));
  Application.ProcessMessages;
end;

procedure TBc06FMonitorB006.btnSvuotaLogClick(Sender: TObject);
begin
  memLogControllo.Clear;
end;

procedure TBc06FMonitorB006.AggiornaInterfaccia;
begin
  actStartMonitoraggio.Enabled:=not Bc06FMonitorB006DtM.MonitorAttivo;
  actStopMonitoraggio.Enabled:=Bc06FMonitorB006DtM.MonitorAttivo;
  actControllaOra.Enabled:=True;
  actChiudi.Enabled:=not  Bc06FMonitorB006DtM.MonitorAttivo;
  lblStato.Caption:=IfThen(Bc06FMonitorB006DtM.MonitorAttivo,'Attivo','Non attivo');
end;

procedure TBc06FMonitorB006.dgrdInfoControlloDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
var
  DsOrigine:TDataSet;
  EsitoContr:Integer;
begin
  DsOrigine:=dgrdInfoControllo.DataSource.DataSet;
  EsitoContr:=DsOrigine.FieldByName('ESITO_CONTROLLO').AsInteger;
  if (EsitoContr <> ESITO_OK) and (EsitoContr <> ESITO_CONTROLLO_SALTATO) and
     (EsitoContr <> ESITO_INDEFINITO) then
  begin
    dgrdInfoControllo.Canvas.Brush.Color:=clRed;
    dgrdInfoControllo.Canvas.Font.Style:=[fsBold];
    dgrdInfoControllo.Canvas.Font.Color:=clWhite;
  end
  else
  begin
    dgrdInfoControllo.Canvas.Brush.Color:=dgrdInfoControllo.Color;
    dgrdInfoControllo.Canvas.Font.Color:=dgrdInfoControllo.Font.Color;
  end;

  dgrdInfoControllo.DefaultDrawColumnCell(Rect,DataCol,Column,State);
end;

procedure TBc06FMonitorB006.BloccaInterfaccia;
begin
  actControllaOra.Enabled:=False;
  actStartMonitoraggio.Enabled:=False;
  actStopMonitoraggio.Enabled:=False;
end;

procedure TBc06FMonitorB006.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action:=caNone;
  actChiudiExecute(nil);
end;

end.
