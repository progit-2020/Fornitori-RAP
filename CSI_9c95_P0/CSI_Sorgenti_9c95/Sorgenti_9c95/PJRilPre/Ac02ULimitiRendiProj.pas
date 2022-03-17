unit Ac02ULimitiRendiProj;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  R001UGESTTAB, DB, Menus, Buttons, ExtCtrls, ComCtrls, StdCtrls, DBCtrls,
  Mask, ImgList, ToolWin, ActnList, A000UMessaggi,
  C700USelezioneAnagrafe, A000UCostanti, A000USessione, A000UInterfaccia, A003UDataLavoroBis,
  C001UFiltroTabelleDtM, A002UInterfacciaSt, OracleData,
  C001UFiltroTabelle, C001UScegliCampi, C005UDatiAnagrafici, C013UCheckList,
  C180FUNZIONIGENERALI, SelAnagrafe, Variants, Grids, DBGrids, System.Actions;

type
  TAc02FLimitiRendiProj = class(TR001FGestTab)
    frmSelAnagrafe: TfrmSelAnagrafe;
    ProgressBar1: TProgressBar;
    dgrdLimitiMensInd: TDBGrid;
    actElaborazioneCedolino: TAction;
    PnlBottom: TPanel;
    rgpOrdinamento: TRadioGroup;
    ToolButton2: TToolButton;
    procedure FormShow(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure frmSelAnagrafebtnSelezioneClick(Sender: TObject);
    procedure frmSelAnagrafeR003DatianagraficiClick(Sender: TObject);
    procedure rgpOrdinamentoClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    ParamID:Integer;
    ParamDec:TDateTime;
    procedure CambiaProgressivo;
  end;

var
  Ac02FLimitiRendiProj: TAc02FLimitiRendiProj;

procedure OpenAc02FLimitiRendiProj(Prog,Id:LongInt;Decorrenza:TDateTime);

implementation

uses Ac02ULimitiRendiProjDtM, C016UElencoVoci;

{$R *.DFM}

procedure OpenAc02FLimitiRendiProj(Prog,Id:LongInt;Decorrenza:TDateTime);
begin
  SolaLetturaOriginale:=SolaLettura;
  SolaLettura:=False;
  case A000GetInibizioni('Funzione','OpenAc02FLimitiRendiProj') of
    'N':begin
        ShowMessage(A000MSG_ERR_FUNZ_NON_ABILITATA);
        Exit;
        end;
    'R':SolaLettura:=True;
  end;
  Screen.Cursor:=crHourglass;
  Application.CreateForm(TAc02FLimitiRendiProj, Ac02FLimitiRendiProj);
  C700Progressivo:=Prog;
  Ac02FLimitiRendiProj.ParamID:=Id;
  Ac02FLimitiRendiProj.ParamDec:=Decorrenza;
  Application.CreateForm(TAc02FLimitiRendiProjDtM, Ac02FLimitiRendiProjDtM);
  try
    Screen.Cursor:=crDefault;
    Ac02FLimitiRendiProj.ShowModal;
  finally
    SolaLettura:=SolaLetturaOriginale;
    Ac02FLimitiRendiProj.Free;
    Ac02FLimitiRendiProjDtM.Free;
  end;
end;

procedure TAc02FLimitiRendiProj.FormShow(Sender: TObject);
begin
  inherited;
  C700DatiVisualizzati:='MATRICOLA,T430BADGE,COGNOME,NOME';
  C700DatiSelezionati:=C700CampiBase;
  C700DataLavoro:=Parametri.DataLavoro;
  frmSelAnagrafe.CreaSelAnagrafe(Ac02FLimitiRendiProjDtM.Ac02MW,SessioneOracle,StatusBar,2,True);
  frmSelAnagrafe.OnCambiaProgressivo:=CambiaProgressivo;
  frmSelAnagrafe.VisualizzaDipendente;
  if ParamID <> 0 then
    Ac02FLimitiRendiProjDtM.Ac02MW.selT753.SearchRecord('ID_T752;DECORRENZA',VarArrayOf([ParamID,ParamDec]),[srFromBeginning]);
  //La form è di sola visualizzazione. La toolbar c'è in previsione di un utilizzo futuro, ma per ora è nascosta.
  actInserisci.Enabled:=False;
  actModifica.Enabled:=False;
  actCancella.Enabled:=False;
  actConferma.Enabled:=False;
  actAnnulla.Enabled:=False;
  actGomma.Enabled:=False;
  actInserisci.Visible:=False;
  actModifica.Visible:=False;
  actCancella.Visible:=False;
  actConferma.Visible:=False;
  actAnnulla.Visible:=False;
  actGomma.Visible:=False;
end;

procedure TAc02FLimitiRendiProj.FormDestroy(Sender: TObject);
begin
  inherited;
  frmSelAnagrafe.DistruggiSelAnagrafe;
end;

procedure TAc02FLimitiRendiProj.frmSelAnagrafebtnSelezioneClick(Sender: TObject);
begin
  inherited;
  try
    C700Datalavoro:=Ac02FLimitiRendiProjDtM.Ac02MW.selT753.FieldByName('DECORRENZA').AsDateTime;
  except
    C700Datalavoro:=Parametri.DataLavoro;
  end;
  if C700DataLavoro = 0 then
    C700DataLavoro:=R180FineMese(Parametri.DataLavoro);
  frmSelAnagrafe.btnSelezioneClick(Sender);
end;

procedure TAc02FLimitiRendiProj.frmSelAnagrafeR003DatianagraficiClick(Sender: TObject);
begin
  inherited;
  try
    C005DataVisualizzazione:=Ac02FLimitiRendiProjDtM.Ac02MW.selT753.FieldByName('DECORRENZA').AsDateTime;
  except
    C005DataVisualizzazione:=Parametri.DataLavoro;
  end;
  frmSelAnagrafe.R003DatianagraficiClick(Sender);
end;

procedure TAc02FLimitiRendiProj.rgpOrdinamentoClick(Sender: TObject);
begin
  CambiaProgressivo;
end;

procedure TAc02FLimitiRendiProj.CambiaProgressivo;
begin
  Ac02FLimitiRendiProjDtM.Ac02MW.selT753.Filtered:=True;
  Ac02FLimitiRendiProjDtM.Ac02MW.RiapriSelT753(C700Progressivo,rgpOrdinamento.ItemIndex);
  NumRecords;
end;

end.
