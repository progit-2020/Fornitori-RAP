unit Ac09UIndFunzione;

interface

uses
  R001UGESTTAB, Menus, ComCtrls, StdCtrls, Buttons, ExtCtrls, Mask, Forms, Grids,
  DBGrids, Controls, Classes, System.Actions, ActnList, ImgList, Dialogs, DB, ToolWin,
  SysUtils, StrUtils, Types, Graphics, Math,
  A000UInterfaccia, A000UMessaggi, A000USessione, A003UDataLavoroBis,
  C004UParamForm, C005UDatiAnagrafici, C180FunzioniGenerali, C700USelezioneAnagrafe,
  ToolbarFiglio, SelAnagrafe, Ac08URegistraIndFunzione;

type
  TAc09FIndFunzione = class(TR001FGestTab)
    pnlGrigliaDati: TPanel;
    dgrdIndFunzione: TDBGrid;
    frmSelAnagrafe: TfrmSelAnagrafe;
    pnlParametri: TPanel;
    sbtDallaData: TSpeedButton;
    sbtAllaData: TSpeedButton;
    lblDallaData: TLabel;
    lblAllaData: TLabel;
    edtAllaData: TMaskEdit;
    edtDallaData: TMaskEdit;
    rgpTipoDati: TRadioGroup;
    N4: TMenuItem;
    ProgressBar1: TProgressBar;
    btnChiudi: TBitBtn;
    MnuCopia1: TPopupMenu;
    Copia1: TMenuItem;
    CopiaInExcel1: TMenuItem;
    pnlDettaglio: TPanel;
    frmToolbarFiglio: TfrmToolbarFiglio;
    pnlIntestazioneGriglia: TPanel;
    Splitter1: TSplitter;
    pgcDettaglio: TPageControl;
    tshDettIndennita: TTabSheet;
    tshTotaliPeriodo: TTabSheet;
    dgrdTotaliPeriodo: TDBGrid;
    dgrdDettIndennita: TDBGrid;
    MnuCopia2: TPopupMenu;
    Copia2: TMenuItem;
    CopiaInExcel2: TMenuItem;
    actRegistraIndFunzione: TAction;
    N5: TMenuItem;
    Calcoloindennitdifunzione1: TMenuItem;
    ToolButton2: TToolButton;
    TRegistraIndFunzione: TToolButton;
    procedure FormCreate(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure actRegistraIndFunzioneExecute(Sender: TObject);
    procedure frmSelAnagrafeR003DatianagraficiClick(Sender: TObject);
    procedure frmSelAnagrafebtnSelezioneClick(Sender: TObject);
    procedure dgrdIndFunzioneDrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure Copia1Click(Sender: TObject);
    procedure pgcDettaglioChange(Sender: TObject);
    procedure edtDallaDataChange(Sender: TObject);
    procedure sbtDallaDataClick(Sender: TObject);
    procedure sbtAllaDataClick(Sender: TObject);
    procedure edtAllaDataDblClick(Sender: TObject);
    procedure rgpTipoDatiClick(Sender: TObject);
    procedure frmToolbarFigliobtnTFConfermaClick(Sender: TObject);
    procedure frmToolbarFigliobtnTFCancellaClick(Sender: TObject);
    procedure frmToolbarFigliobtnTFAnnullaClick(Sender: TObject);
  private
    { Private declarations }
    DataI,DataF:TDateTime;
    procedure GetParametriFunzione;
    procedure PutParametriFunzione;
    procedure CambiaProgressivo;
  public
    { Public declarations }
    procedure AbilitazioniComponenti;
    procedure CaricaListaIndFunzione;
  end;

var
  Ac09FIndFunzione: TAc09FIndFunzione;

procedure OpenAc09IndFunzione(Prog:LongInt;DataDal,DataAl:TDateTime);

implementation

uses Ac09UIndFunzioneDM;

{$R *.DFM}

procedure OpenAc09IndFunzione(Prog:LongInt;DataDal,DataAl:TDateTime);
begin
  SolaLetturaOriginale:=SolaLettura;
  SolaLettura:=False;
  case A000GetInibizioni('Funzione','OpenAc09IndFunzione') of
    'N':begin
        ShowMessage(A000MSG_ERR_FUNZ_NON_ABILITATA);
        SolaLettura:=SolaLetturaOriginale;
        Exit;
        end;
    'R':SolaLettura:=True;
  end;
  Ac09FIndFunzione:=TAc09FIndFunzione.Create(nil);
  with Ac09FIndFunzione do
    try
      C700Progressivo:=Prog;
      DataI:=DataDal;
      DataF:=DataAl;
      Ac09FIndFunzioneDM:=TAc09FIndFunzioneDM.Create(nil);
      ShowModal;
    finally
      SolaLettura:=SolaLetturaOriginale;
      Ac09FIndFunzioneDM.Free;
      Free;
    end;
end;

procedure TAc09FIndFunzione.FormCreate(Sender: TObject);
begin
  inherited;
  C700Progressivo:=0;
  A000SettaVariabiliAmbiente;
end;

procedure TAc09FIndFunzione.FormActivate(Sender: TObject);
begin
  inherited;
  DButton.DataSet:=Ac09FIndFunzioneDM.selCSI006;
  dgrdDettIndennita.DataSource:=Ac09FIndFunzioneDM.Ac09MW.dsrCSI007;
  dgrdTotaliPeriodo.DataSource:=Ac09FIndFunzioneDM.Ac09MW.dsrbCSI006;
  dgrdIndFunzione.SetFocus;
  dgrdIndFunzione.SelectedIndex:=0;
  rgpTipoDati.ItemIndex:=0;
end;

procedure TAc09FIndFunzione.FormShow(Sender: TObject);
begin
  inherited;
  CreaC004(SessioneOracle,'Ac09',Parametri.ProgOper);
  GetParametriFunzione;
  if DataI > 0 then //richiamo esterno
  begin
    edtDallaData.Text:=FormatDateTime('dd/mm/yyyy',DataI);
    edtAllaData.Text:=FormatDateTime('dd/mm/yyyy',DataF);
  end;
  C700DatiVisualizzati:='MATRICOLA,T430BADGE,COGNOME,NOME';
  C700DatiSelezionati:=C700CampiBase;
  C700DataLavoro:=Parametri.DataLavoro;
  frmSelAnagrafe.OnCambiaProgressivo:=CambiaProgressivo;
  frmSelAnagrafe.CreaSelAnagrafe(Ac09FIndFunzioneDM.Ac09MW,SessioneOracle,StatusBar,2,True);
  if not Ac09FIndFunzioneDM.Ac09MW.selCSI007.Active then
    Ac09FIndFunzioneDM.Ac09MW.selCSI006.Refresh;
  //Disabilito anomalie
  frmToolbarFiglio.TFDButton:=Ac09FIndFunzioneDM.Ac09MW.dsrCSI007;
  frmToolbarFiglio.TFDBGrid:=dgrdDettIndennita;
  frmToolbarFiglio.RefreshDopoPost:=True;
  SetLength(frmToolbarFiglio.lstLock,7);
  frmToolbarFiglio.lstLock[0]:=Panel1;
  frmToolbarFiglio.lstLock[1]:=File1;
  frmToolbarFiglio.lstLock[2]:=Strumenti1;
  frmToolbarFiglio.lstLock[3]:=frmSelAnagrafe;
  frmToolbarFiglio.lstLock[4]:=pnlGrigliaDati;
  frmToolbarFiglio.lstLock[5]:=pnlParametri;
  frmToolbarFiglio.lstLock[6]:=tshTotaliPeriodo;
  pgcDettaglio.ActivePage:=tshDettIndennita;
  AbilitazioniComponenti;
  if Trim(Parametri.CampiRiferimento.C3_Indennita_Funzione) = '' then
  begin
    ShowMessage(A000MSG_Ac09_ERR_CAMPO_RIFERIMENTO);
    Close;
  end;
end;

procedure TAc09FIndFunzione.GetParametriFunzione;
begin
  edtDallaData.Text:=C004FParamForm.GetParametro('edtDallaData',FormatDateTime('dd/mm/yyyy',R180InizioMese(Parametri.DataLavoro)));
  edtAllaData.Text:=C004FParamForm.GetParametro('edtAllaData',FormatDateTime('dd/mm/yyyy',R180FineMese(Parametri.DataLavoro)));
end;

procedure TAc09FIndFunzione.PutParametriFunzione;
var DataDa,DataA:TDateTime;
begin
  C004FParamForm.Cancella001;
  try
    DataDa:=StrToDate(edtDallaData.Text);
  except
    DataDa:=Parametri.DataLavoro;
  end;
  C004FParamForm.PutParametro('edtDallaData',DateToStr(DataDa));
  try
    DataA:=StrToDate(edtAllaData.Text);
  except
    DataA:=Parametri.DataLavoro;
  end;
  C004FParamForm.PutParametro('edtAllaData',DateToStr(DataA));
  try SessioneOracle.Commit; except end;
end;

procedure TAc09FIndFunzione.FormDestroy(Sender: TObject);
begin
  PutParametriFunzione;
  C004FParamForm.Free;
  frmSelAnagrafe.DistruggiSelAnagrafe;
end;

procedure TAc09FIndFunzione.actRegistraIndFunzioneExecute(Sender: TObject);
var DataDal,DataAl:TDateTime;
begin
  frmSelAnagrafe.SalvaC00SelAnagrafe;
  C700Distruzione;
  DataDal:=StrToDate(edtDallaData.Text);
  DataAl:=StrToDate(edtAllaData.Text);
  DataDal:=Min(Max(DataDal,R180InizioMese(DataAl)),DataAl);//devono afferire allo stesso mese, in ordine cronologico
  OpenAc08RegistraIndFunzione(C700Progressivo,DataDal,DataAl);
  C700DatiSelezionati:=C700CampiBase;
  C700Creazione(SessioneOracle);
  frmSelAnagrafe.RipristinaC00SelAnagrafe(Ac09FIndFunzioneDM.Ac09MW);
  CambiaProgressivo;
end;

procedure TAc09FIndFunzione.frmSelAnagrafeR003DatianagraficiClick(Sender: TObject);
begin
  inherited;
  try
    C005DataVisualizzazione:=StrToDate(edtDallaData.Text);
  except
    C005DataVisualizzazione:=Parametri.DataLavoro;
  end;
  if C005DataVisualizzazione = 0 then
    C005DataVisualizzazione:=Parametri.DataLavoro;
  frmSelAnagrafe.R003DatianagraficiClick(Sender);
end;

procedure TAc09FIndFunzione.frmToolbarFigliobtnTFAnnullaClick(Sender: TObject);
begin
  inherited;
  frmToolbarFiglio.actTFAnnullaExecute(Sender);
  with Ac09FIndFunzioneDM.Ac09MW do
  begin
    TotOreInd:=R180OreMinuti(selCSI006.FieldByName('SUM_ORE').AsString);
    TotOreDisSer:=R180OreMinuti(selCSI006.FieldByName('SUM_DISAGIO_SERALE').AsString);
  end;
end;

procedure TAc09FIndFunzione.frmToolbarFigliobtnTFCancellaClick(Sender: TObject);
begin
  inherited;
  frmToolbarFiglio.actTFCancellaExecute(Sender);
  Ac09FIndFunzioneDM.Ac09MW.AggiornaCSI006;
end;

procedure TAc09FIndFunzione.frmToolbarFigliobtnTFConfermaClick(Sender: TObject);
begin
  inherited;
  frmToolbarFiglio.actTFConfermaExecute(Sender);
  Ac09FIndFunzioneDM.Ac09MW.AggiornaCSI006;
end;

procedure TAc09FIndFunzione.frmSelAnagrafebtnSelezioneClick(Sender: TObject);
begin
  inherited;
  try
    C700DataDal:=StrToDate(edtDallaData.Text);
  except
    C700DataDal:=Parametri.DataLavoro;
  end;
  try
    C700DataLavoro:=StrToDate(edtAllaData.Text);
  except
    C700DataLavoro:=Parametri.DataLavoro;
  end;
  if C700DataDal = 0 then
    C700DataDal:=Parametri.DataLavoro;
  if C700DataLavoro = 0 then
    C700DataLavoro:=Parametri.DataLavoro;
  frmSelAnagrafe.SelezionePeriodica:=True;
  frmSelAnagrafe.btnSelezioneClick(Sender);
end;

procedure TAc09FIndFunzione.CambiaProgressivo;
begin
  with Ac09FIndFunzioneDM do
  begin
    if Ac09MW.SelAnagrafe = nil then Exit;
    Screen.Cursor:=crHourglass;
    //Dataset principale
    selCSI006.Close;
    selCSI006.SetVariable('Progressivo',C700Progressivo);
    selCSI006.SetVariable('PeriodoDa',StrToDate(edtDallaData.Text));
    selCSI006.SetVariable('PeriodoA',StrToDate(edtAllaData.Text));
    case rgpTipoDati.ItemIndex of
      0:selCSI006.SetVariable('TipoRecord','M');
      1:selCSI006.SetVariable('TipoRecord','A');
      2:selCSI006.SetVariable('TipoRecord','E');
    end;
    selCSI006.SetVariable('ListaIndFunzione',IfThen(Parametri.VersioneOracle >= 11,'listagg(CSI007.INDFUNZIONE,'','') within group (order by CSI007.INDFUNZIONE)','to_char(wm_concat(CSI007.INDFUNZIONE))'));
    selCSI006.Open;
    if selCSI006.RecordCount = 0 then
      selCSI006AfterScroll(nil);
    NumRecords;
    //Dataset totali
    with Ac09MW do
    begin
      selbCSI006.Close;
      selbCSI006.SetVariable('Progressivo',C700Progressivo);
      selbCSI006.SetVariable('PeriodoDa',StrToDate(edtDallaData.Text));
      selbCSI006.SetVariable('PeriodoA',StrToDate(edtAllaData.Text));
      case rgpTipoDati.ItemIndex of
        0:selbCSI006.SetVariable('TipoRecord','M');
        1:selbCSI006.SetVariable('TipoRecord','A');
        2:selbCSI006.SetVariable('TipoRecord','E');
      end;
    end;
    Ac09MW.selbCSI006.Open;
    AbilitazioniComponenti;
    Ac09MW.CaricaElencoDate;
    Screen.Cursor:=crDefault;
  end;
end;

procedure TAc09FIndFunzione.AbilitazioniComponenti;
var Abilita: Boolean;
begin
  if frmToolbarFiglio.TFDButton = nil then
    Exit;
  frmToolbarFiglio.AbilitaAzioniTF(nil);
  Abilita:=(pgcDettaglio.ActivePageIndex = 0) and not (DButton.State in [dsInsert,dsEdit]) and (Ac09FIndFunzioneDM.Ac09MW.selCSI006.RecordCount > 0) and not SolaLettura and (Ac09FIndFunzioneDM.Ac09MW.selCSI006.FieldByName('TIPO_RECORD').AsString = 'M');
  frmToolbarFiglio.actTFCopiaSu.Enabled:=Abilita;
  frmToolbarFiglio.actTFInserisci.Enabled:=Abilita;
  frmToolbarFiglio.actTFModifica.Enabled:=Abilita;
  frmToolbarFiglio.actTFCancella.Enabled:=Abilita;
  pnlIntestazioneGriglia.Caption:=pgcDettaglio.ActivePage.Caption;
  pnlParametri.Enabled:=not (DButton.State in [dsInsert,dsEdit]) and not (frmToolbarFiglio.TFDButton.State in [dsInsert,dsEdit]);
end;

procedure TAc09FIndFunzione.dgrdIndFunzioneDrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
var i:integer;
begin
  inherited;
  if gdFixed in State then exit;

  with Ac09FIndFunzioneDM.Ac09MW do
  begin
    //Ciclo su tabella
    for i:=0 to High(ElencoDate) do
      if (ElencoDate[i].Colorata) and (ElencoDate[i].Data = selCSI006.FieldByName('DATA').AsDateTime) then
      begin
        if gdSelected in State then
        begin
          dgrdIndFunzione.Canvas.Brush.Color:=clHighLight;
          dgrdIndFunzione.Canvas.Font.Color:=clWhite;
        end
        else
        begin
          dgrdIndFunzione.Canvas.Brush.Color:=$00FFFF80;
          dgrdIndFunzione.Canvas.Font.Color:=clWindowText;
        end;
        Break;
      end;
    dgrdIndFunzione.DefaultDrawColumnCell(Rect,DataCol,Column,State);
  end;
end;

procedure TAc09FIndFunzione.Copia1Click(Sender: TObject);
var NomeSender:String;
    GridExcel:TDBGrid;
    CopyToExcel:Boolean;
begin
  inherited;
  NomeSender:=(Sender as TMenuItem).Name;
  if Copy(NomeSender,Length(NomeSender)) = '1' then
    GridExcel:=dgrdIndFunzione
  else
    GridExcel:=dgrdTotaliPeriodo;
  CopyToExcel:=Copy(NomeSender,1,Length(NomeSender) - 1) = 'CopiaInExcel';
  with Ac09FIndFunzioneDM do
  begin
    evtAssegnaProc(False);
    R180DBGridCopyToClipboard(GridExcel,CopyToExcel,False);
    evtAssegnaProc(True);
    Ac09MW.AggiornaCSI006;
  end;
end;

procedure TAc09FIndFunzione.pgcDettaglioChange(Sender: TObject);
begin
  inherited;
  AbilitazioniComponenti;
end;

procedure TAc09FIndFunzione.edtDallaDataChange(Sender: TObject);
var
  DataStr2: String;
begin
  if sender = edtDallaData then
    DataStr2:=edtDallaData.Text
  else
    DataStr2:=edtAllaData.Text;
  try
    CambiaProgressivo;
  except
  end
end;

procedure TAc09FIndFunzione.sbtDallaDataClick(Sender: TObject);
begin
  edtDallaData.Text:=FormatDateTime('dd/mm/yyyy',DataOut(StrToDate(edtDallaData.Text),'Data inizio periodo','G'));
end;

procedure TAc09FIndFunzione.sbtAllaDataClick(Sender: TObject);
begin
  edtAllaData.Text:=FormatDateTime('dd/mm/yyyy',DataOut(StrToDate(edtAllaData.Text),'Data fine periodo','G'));
end;

procedure TAc09FIndFunzione.edtAllaDataDblClick(Sender: TObject);
begin
  inherited;
  edtAllaData.Text:=DateToStr(R180FineMese(StrToDate(edtDallaData.Text)));
end;

procedure TAc09FIndFunzione.rgpTipoDatiClick(Sender: TObject);
begin
  CambiaProgressivo;
end;

procedure TAc09FIndFunzione.CaricaListaIndFunzione;
var i:Integer;
begin
  for i:=0 to dgrdDettIndennita.columns.Count - 1 do
    if dgrdDettIndennita.Columns[i].FieldName = 'INDFUNZIONE' then
    begin
      dgrdDettIndennita.Columns[i].PickList.Clear;
      with Ac09FIndFunzioneDM.Ac09MW.selCSI004 do
      begin
        First;
        while not Eof do
        begin
          dgrdDettIndennita.Columns[i].PickList.Add(FieldByName('CODICE').AsString);
          Next;
        end;
      end;
    end;
end;

end.
