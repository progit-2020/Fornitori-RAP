unit A176URiepilogoIterAutorizzativi;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, R001UGESTTAB, System.Actions,
  Vcl.ActnList, Vcl.ImgList, Data.DB, Vcl.Menus, Vcl.ComCtrls, Vcl.ToolWin,
  SelAnagrafe, A000UInterfaccia, A000UCostanti, Vcl.Grids, Vcl.DBGrids,
  Vcl.ExtCtrls, Vcl.StdCtrls, C180FunzioniGenerali, Vcl.Mask,
  System.ImageList, InputPeriodo;

type
  TA176FRiepilogoIterAutorizzativi = class(TR001FGestTab)
    frmSelAnagrafe: TfrmSelAnagrafe;
    pnlFiltri: TPanel;
    dGrdIterAutorizzativi: TDBGrid;
    cmbTipoIter: TComboBox;
    ppInfoIter: TPopupMenu;
    Inforichiesta1: TMenuItem;
    lblTipoIter: TLabel;
    rgpAllegato: TRadioGroup;
    rgpCondizAllegato: TRadioGroup;
    Gestionerichiesta1: TMenuItem;
    frmInputPeriodo: TfrmInputPeriodo;
    procedure FormShow(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure cmbTipoIterChange(Sender: TObject);
    procedure Inforichiesta1Click(Sender: TObject);
    procedure dGrdIterAutorizzativiEditButtonClick(Sender: TObject);
    procedure edtDataDaChange(Sender: TObject);
    procedure rgpAllegatoClick(Sender: TObject);
    procedure rgpCondizAllegatoClick(Sender: TObject);
    procedure Gestionerichiesta1Click(Sender: TObject);
    procedure Stampa1Click(Sender: TObject);
    procedure frmInputPeriodoedtInizioExit(Sender: TObject);
    procedure frmInputPeriodoedtFineExit(Sender: TObject);
    procedure frmInputPeriodobtnDataInizioClick(Sender: TObject);
    procedure frmInputPeriodobtnDataFineClick(Sender: TObject);
    procedure frmInputPeriodobtnIndietroClick(Sender: TObject);
    procedure frmInputPeriodobtnAvantiClick(Sender: TObject);
    procedure frmSelAnagrafebtnSelezioneClick(Sender: TObject);
  private
    { Private declarations }
    procedure CambiaProgressivo;
    procedure SetDatePeriodoRichiesta;
    procedure ApriDataSetIterAutorizzativi;
    procedure ApplicaPeriodo;
    { Metodi Property }
    function _GetDataI: TDateTime;
    procedure _PutDataI(const Value: TDateTime);
    function _GetDataF: TDateTime;
    procedure _PutDataF(const Value: TDateTime);
  public
    { Public declarations }
    { Property }
    property DataI:TDateTime read _GetDataI write _PutDataI;
    property DataF:TDateTime read _GetDataF write _PutDataF;
  end;

var
  A176FRiepilogoIterAutorizzativi: TA176FRiepilogoIterAutorizzativi;

  procedure OpenA176RiepilogoIterAutorizzativi;

implementation

uses
  C700USelezioneAnagrafe, A176URiepilogoIterAutorizzativiDM, C023UInfoDati,
  A000USessione, C012UVisualizzaTesto, A000UMessaggi, A176UGestioneIterAutorizzativi;

{$R *.dfm}

procedure OpenA176RiepilogoIterAutorizzativi;
begin
  SolaLetturaOriginale:=SolaLettura;
  SolaLettura:=False;
  case A000GetInibizioni('Funzione','OpenA176RiepilogoIterAutorizzativi') of
    'N':begin
        ShowMessage(A000MSG_ERR_FUNZ_NON_ABILITATA);
        SolaLettura:=SolaLetturaOriginale;
        Exit;
        end;
    'R':SolaLettura:=True;
  end;
  A176FRiepilogoIterAutorizzativiDM:=TA176FRiepilogoIterAutorizzativiDM.Create(nil);
  A176FRiepilogoIterAutorizzativi:=TA176FRiepilogoIterAutorizzativi.Create(nil);
  try
    A176FRiepilogoIterAutorizzativi.ShowModal;
  finally
    FreeAndNil(A176FRiepilogoIterAutorizzativi);
    FreeAndNil(A176FRiepilogoIterAutorizzativiDM);
  end;
end;

procedure TA176FRiepilogoIterAutorizzativi.SetDatePeriodoRichiesta;
begin
  if (DataI <= 0) or (DataF <= 0) then
    Exit;
  A176FRiepilogoIterAutorizzativiDM.A176MW.DataRichDa:=DataI;
  A176FRiepilogoIterAutorizzativiDM.A176MW.DataRichA:=DataF;
end;

procedure TA176FRiepilogoIterAutorizzativi.Stampa1Click(Sender: TObject);
var
  i:integer;
begin
  R001LinkC700:=False;
  QueryStampa.Clear;
  QueryStampa.Text:=(A176FRiepilogoIterAutorizzativiDM.A176MW.DataSetAttivo.SubstitutedSQL);
  NomiCampiR001.Clear;
  for i:=0 to A176FRiepilogoIterAutorizzativiDM.A176MW.DataSetAttivo.FieldCount - 1 do
  begin
    NomiCampiR001.Add(A176FRiepilogoIterAutorizzativiDM.A176MW.DataSetAttivo.Fields[i].FieldName);
  end;
  inherited;
end;

procedure TA176FRiepilogoIterAutorizzativi.ApriDataSetIterAutorizzativi;
var
  indNote:integer;
begin
  DButton.DataSet:=A176FRiepilogoIterAutorizzativiDM.A176MW.DataSetAttivo;
  A176FRiepilogoIterAutorizzativiDM.A176MW.OpenDataSetAttivo;
  indNote:=R180GetColonnaDBGrid(dGrdIterAutorizzativi,'T850NOTE');
  if indNote >= 0 then
  begin
    dGrdIterAutorizzativi.Columns[indNote].ButtonStyle:=cbsEllipsis;
  end;
end;

procedure TA176FRiepilogoIterAutorizzativi.CambiaProgressivo;
begin
  A176FRiepilogoIterAutorizzativiDM.A176MW.Progressivo:=C700Progressivo;
  ApriDataSetIterAutorizzativi;
end;

procedure TA176FRiepilogoIterAutorizzativi.cmbTipoIterChange(Sender: TObject);
begin
  inherited;
  A176FRiepilogoIterAutorizzativiDM.A176MW.TipoEstrazioneIter:=A176FRiepilogoIterAutorizzativiDM.A176MW.IterDescToCod(cmbTipoIter.Items[cmbTipoIter.ItemIndex]);
  ApriDataSetIterAutorizzativi;
end;

procedure TA176FRiepilogoIterAutorizzativi.dGrdIterAutorizzativiEditButtonClick(
  Sender: TObject);
var
  Str:TStringList;
begin
  inherited;
  Str:=TStringList.Create;
  Str.Text:=dGrdIterAutorizzativi.DataSource.DataSet.FieldByName('T850NOTE').AsString;
  try
    OpenC012VisualizzaTesto('Note','',Str,'',[mbClose]);
  finally
    FreeAndNil(Str);
  end;
end;

procedure TA176FRiepilogoIterAutorizzativi.edtDataDaChange(Sender: TObject);
begin
  inherited;
  SetDatePeriodoRichiesta;
  ApriDataSetIterAutorizzativi;
end;

procedure TA176FRiepilogoIterAutorizzativi.FormCreate(Sender: TObject);
var
  i:integer;
begin
  inherited;
  SolaLettura:=False;
  for i:=low(A000IterAutorizzativi) to High(A000IterAutorizzativi) do
  begin
    cmbTipoIter.Items.Add(A000IterAutorizzativi[i].Desc);
  end;
  cmbTipoIter.ItemIndex:=cmbTipoIter.Items.IndexOf('Giustificativi');
end;

procedure TA176FRiepilogoIterAutorizzativi.FormDestroy(Sender: TObject);
begin
  frmSelAnagrafe.DistruggiSelAnagrafe;
  inherited;
end;

procedure TA176FRiepilogoIterAutorizzativi.FormShow(Sender: TObject);
begin
  inherited;
  C700DatiVisualizzati:='MATRICOLA,T430BADGE,COGNOME,NOME';
  C700DatiSelezionati:=C700CampiBase;
  C700DataLavoro:=Parametri.DataLavoro;
  A176FRiepilogoIterAutorizzativiDM.A176MW.TipoEstrazioneIter:=A176FRiepilogoIterAutorizzativiDM.A176MW.IterDescToCod(cmbTipoIter.Items[cmbTipoIter.ItemIndex]);
  A176FRiepilogoIterAutorizzativiDM.A176MW.Progressivo:=-1;
  DataI:=A176FRiepilogoIterAutorizzativiDM.A176MW.DataRichDa;
  DataF:=A176FRiepilogoIterAutorizzativiDM.A176MW.DataRichA;
  SetDatePeriodoRichiesta;
  ApriDataSetIterAutorizzativi;
  frmSelAnagrafe.OnCambiaProgressivo:=CambiaProgressivo;
  frmSelAnagrafe.CreaSelAnagrafe(SessioneOracle, StatusBar,2,True);
  frmSelAnagrafe.NumRecords;
end;

procedure TA176FRiepilogoIterAutorizzativi.frmInputPeriodobtnAvantiClick(Sender: TObject);
begin
  inherited;
  frmInputPeriodo.btnAvantiClick(Sender);
  ApplicaPeriodo;
end;

procedure TA176FRiepilogoIterAutorizzativi.frmInputPeriodobtnDataFineClick(Sender: TObject);
begin
  inherited;
  frmInputPeriodo.btnDataFineClick(Sender);
  ApplicaPeriodo;
end;

procedure TA176FRiepilogoIterAutorizzativi.frmInputPeriodobtnDataInizioClick(Sender: TObject);
begin
  inherited;
  frmInputPeriodo.btnDataInizioClick(Sender);
  ApplicaPeriodo;
end;

procedure TA176FRiepilogoIterAutorizzativi.frmInputPeriodobtnIndietroClick(Sender: TObject);
begin
  inherited;
  frmInputPeriodo.btnIndietroClick(Sender);
  ApplicaPeriodo;
end;

procedure TA176FRiepilogoIterAutorizzativi.frmInputPeriodoedtFineExit(Sender: TObject);
begin
  inherited;
  ApplicaPeriodo;
end;

procedure TA176FRiepilogoIterAutorizzativi.frmInputPeriodoedtInizioExit(Sender: TObject);
begin
  inherited;
  frmInputPeriodo.edtInizioExit(Sender);
  ApplicaPeriodo;
end;

procedure TA176FRiepilogoIterAutorizzativi.frmSelAnagrafebtnSelezioneClick(Sender: TObject);
begin
  inherited;
  frmSelAnagrafe.btnSelezioneClick(Sender);

end;

procedure TA176FRiepilogoIterAutorizzativi.Gestionerichiesta1Click(
  Sender: TObject);
var
  A176FGestioneIterAutorizzativi:TA176FGestioneIterAutorizzativi;
begin
  inherited;
  A176FGestioneIterAutorizzativi:=TA176FGestioneIterAutorizzativi.Create(nil);
  try
    A176FRiepilogoIterAutorizzativiDM.A176MW.SetIDIter(
      A176FRiepilogoIterAutorizzativiDM.A176MW.DataSetAttivo.FieldByName('T850ITER').AsString,
      A176FRiepilogoIterAutorizzativiDM.A176MW.DataSetAttivo.FieldByName('T850COD_ITER').AsString,
      A176FRiepilogoIterAutorizzativiDM.A176MW.DataSetAttivo.FieldByName('T850ID').AsInteger
    );
    A176FGestioneIterAutorizzativi.ShowModal;
  finally
    FreeAndNil(A176FGestioneIterAutorizzativi);
  end;
end;

procedure TA176FRiepilogoIterAutorizzativi.Inforichiesta1Click(Sender: TObject);
var
  C023: TC023FInfoDati;
begin
  inherited;
  C023:=TC023FInfoDati.Create(nil);
  try
    C023.C018:=A176FRiepilogoIterAutorizzativiDM.A176MW.C018;
    C023.MostraInfoRichiesta(A176FRiepilogoIterAutorizzativiDM.A176MW.DataSetAttivo);
  finally
    FreeAndNil(C023);
  end;
end;

procedure TA176FRiepilogoIterAutorizzativi.rgpAllegatoClick(Sender: TObject);
begin
  inherited;
  A176FRiepilogoIterAutorizzativiDM.A176MW.AllegatoExist:=rgpAllegato.Items[rgpAllegato.ItemIndex];
  ApriDataSetIterAutorizzativi;
end;

procedure TA176FRiepilogoIterAutorizzativi.rgpCondizAllegatoClick(
  Sender: TObject);
begin
  inherited;
  A176FRiepilogoIterAutorizzativiDM.A176MW.CondizAllegato:=rgpCondizAllegato.Items[rgpCondizAllegato.ItemIndex];
  ApriDataSetIterAutorizzativi;
end;

procedure TA176FRiepilogoIterAutorizzativi.ApplicaPeriodo;
begin
  SetDatePeriodoRichiesta;
  ApriDataSetIterAutorizzativi;
end;

{ DataF }
function TA176FRiepilogoIterAutorizzativi._GetDataF: TDateTime;
begin
  Result:=frmInputPeriodo.DataFine;
end;
procedure TA176FRiepilogoIterAutorizzativi._PutDataF(const Value: TDateTime);
begin
  frmInputPeriodo.DataFine:=Value;
end;
{ ----DataF }
{ DataI }
function TA176FRiepilogoIterAutorizzativi._GetDataI: TDateTime;
begin
  Result:=frmInputPeriodo.DataInizio;
end;
procedure TA176FRiepilogoIterAutorizzativi._PutDataI(const Value: TDateTime);
begin
  frmInputPeriodo.DataInizio:=Value;
end;
{ ----DataI }

end.
