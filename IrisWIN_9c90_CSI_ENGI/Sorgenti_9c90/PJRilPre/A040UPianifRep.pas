unit A040UPianifRep;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Menus, ComCtrls, StdCtrls, ExtCtrls, Grids, Spin, DBCGrids,
  DB, DBGrids, OracleData, DBCtrls, Buttons, ActnList, ImgList, ToolWin, Variants,
  A000UCostanti, A000USessione, A000UInterfaccia, A083UMsgElaborazioni,
  C004UParamForm, C005UDatiAnagrafici, C180FunzioniGenerali, C700USelezioneAnagrafe,
  R001UGestTab, RegistrazioneLog, SelAnagrafe, StrUtils, A000UMessaggi,
  System.Actions;

type
  TA040FPianifRep = class(TR001FGestTab)
    Panel2: TPanel;
    EMese: TSpinEdit;
    Label3: TLabel;
    EAnno: TSpinEdit;
    Label4: TLabel;
    ScrollBox3: TScrollBox;
    dGrdPianif: TDBGrid;
    Label5: TLabel;
    frmSelAnagrafe: TfrmSelAnagrafe;
    chkNonContDipPian: TCheckBox;
    actGestioneMensile: TAction;
    GestioneMensile1: TMenuItem;
    BitBtn1: TBitBtn;
    PopupMenu1: TPopupMenu;
    Gestionemensile2: TMenuItem;
    actAcquisizioneTurni: TAction;
    Acquisizioneturni1: TMenuItem;
    actVisualizzaAnomalie: TAction;
    ProgressBar1: TProgressBar;
    ToolButton2: TToolButton;
    ToolButton4: TToolButton;
    procedure FormCreate(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);
    procedure EAnnoChange(Sender: TObject);
    procedure Stampa1Click(Sender: TObject);
    procedure dGrdPianifCellClick(Column: TColumn);
    procedure frmSelAnagrafebtnSelezioneClick(Sender: TObject);
    procedure frmSelAnagrafeR003DatianagraficiClick(Sender: TObject);
    procedure dGrdPianifDrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure actGestioneMensileExecute(Sender: TObject);
    procedure DButtonStateChange(Sender: TObject);
    procedure frmSelAnagrafebtnEreditaSelezioneClick(Sender: TObject);
    procedure actVisualizzaAnomalieExecute(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    DataRif:TDateTime;
  end;

var
  A040FPianifRep: TA040FPianifRep;

procedure OpenA040PianifRep(Prog:LongInt;Tipologia:String;DataIn:TDateTime = 0);

implementation

uses A040UPianifRepDtM1,A040UInserimento,A040UStampa,A040UDialogStampa,
     A040UPianifRepDtM2,A040UStampa2;

{$R *.DFM}

procedure OpenA040PianifRep(Prog:LongInt;Tipologia:String;DataIn:TDateTime = 0);
begin
  SolaLetturaOriginale:=SolaLettura;
  SolaLettura:=False;
  if Tipologia = 'REPERIB' then
    case A000GetInibizioni('Funzione','OpenA040PianifRep') of
      'N':begin
          ShowMessage(A000MSG_ERR_FUNZ_NON_ABILITATA);
          Exit;
          end;
      'R':SolaLettura:=True;
    end
  else
    case A000GetInibizioni('Funzione','OpenA040PianifGuardia') of
      'N':begin
          ShowMessage(A000MSG_ERR_FUNZ_NON_ABILITATA);
          Exit;
          end;
      'R':SolaLettura:=True;
    end;
  A040FPianifRep:=TA040FPianifRep.Create(nil);
  with A040FPianifRep do
  try
    DataRif:=DataIn;

    A040FPianifRepDtM1:=TA040FPianifRepDtM1.Create(nil);
    with A040FPianifRepDtM1.A040MW do
    begin
      CodTipologia:=IfThen(Tipologia = 'REPERIB','R','G');
      ImpostaTipologiaDataSet;
    end;
    C700Progressivo:=Prog;
    actGestioneMensile.Enabled:=not SolaLettura;
    A040FPianifRepDtM1.selT380.ReadOnly:=SolaLettura;
    A040FPianifRepDtM2:=TA040FPianifRepDtM2.Create(nil);
    ShowModal;
  finally
    SolaLettura:=SolaLetturaOriginale;
    FreeAndNil(A040FPianifRepDtM1);
    FreeAndNil(A040FInserimento);
    FreeAndNil(A040FStampa);
    FreeAndNil(A040FDialogStampa);
    FreeAndNil(A040FPianifRepDtM2);
    FreeAndNil(A040FStampa2);
    Free;
  end;
end;

procedure TA040FPianifRep.FormCreate(Sender: TObject);
begin
  inherited;
  Application.HintPause:=100;
  Application.HintHidePause:=6000;
  A040FInserimento:=TA040FInserimento.Create(nil);
  A040FDialogStampa:=TA040FDialogStampa.Create(nil);
  A040FStampa:=TA040FStampa.Create(nil);
  A040FStampa2:=TA040FStampa2.Create(nil);
end;

procedure TA040FPianifRep.FormActivate(Sender: TObject);
begin
  DButton.DataSet:=A040FPianifRepDtM1.selT380;
  inherited;
end;

procedure TA040FPianifRep.FormShow(Sender: TObject);
var c,c1,c2,c3,cDL:Integer;
begin
  inherited;
  with A040FPianifRepDtM1.A040MW do
  begin
    A040FPianifRep.Caption:='<A040> Pianificazione turni ' + sTipo;
    A040FDialogStampa.Caption:='<A040> Stampa turni ' + sTipo + ' mensile';
    A040FStampa.QRLTitolo.Caption:='Turni ' + sTipo + ' mensile';
    c:=R180GetColonnaDBGrid(dGrdPianif,'PRIORITA1');
    dGrdPianif.Columns[c].Visible:=CodTipologia = 'R';
    c:=R180GetColonnaDBGrid(dGrdPianif,'PRIORITA2');
    dGrdPianif.Columns[c].Visible:=CodTipologia = 'R';
    c:=R180GetColonnaDBGrid(dGrdPianif,'PRIORITA3');
    dGrdPianif.Columns[c].Visible:=CodTipologia = 'R';
    VisualizzaCampi;
  end;
  // caricamento picklist TURNI della griglia
  c1:=R180GetColonnaDBGrid(dGrdPianif,'TURNO1');
  dGrdPianif.Columns[c1].PickList.Clear;
  c2:=R180GetColonnaDBGrid(dGrdPianif,'TURNO2');
  dGrdPianif.Columns[c2].PickList.Clear;
  c3:=R180GetColonnaDBGrid(dGrdPianif,'TURNO3');
  dGrdPianif.Columns[c3].PickList.Clear;
  with A040FPianifRepDtM1.A040MW.Q350 do
  begin
    First;
    while not Eof do
    begin
      dGrdPianif.Columns[c1].PickList.Add(Format('%-*s',[5,FieldByName('CODICE').AsString]) + ' - ' + FieldByName('DESCRIZIONE').AsString);
      dGrdPianif.Columns[c2].PickList.Add(Format('%-*s',[5,FieldByName('CODICE').AsString]) + ' - ' + FieldByName('DESCRIZIONE').AsString);
      dGrdPianif.Columns[c3].PickList.Add(Format('%-*s',[5,FieldByName('CODICE').AsString]) + ' - ' + FieldByName('DESCRIZIONE').AsString);
      Next;
    end;
  end;
  // Reperimento dato libero e caricamento picklist
  cDL:=R180GetColonnaDBGrid(dGrdPianif,'DATOLIBERO');
  dGrdPianif.Columns[cDL].Visible:=False;
  if A000LookupTabella(Parametri.CampiRiferimento.C3_DatoPianificabile,A040FPianifRepDtM1.A040MW.selDatoLibero) then
  begin
    A040FPianifRepDtM1.A040MW.selT380.FieldByName('DATOLIBERO').DisplayLabel:=R180Capitalize(Parametri.CampiRiferimento.C3_DatoPianificabile);
    dGrdPianif.Columns[cDL].Visible:=True;
    with A040FPianifRepDtM1.A040MW.selDatoLibero do
    begin
      First;
      while not Eof do
      begin
        dGrdPianif.Columns[cDL].PickList.Add(Format('%-*s',[20,FieldByName('CODICE').AsString]) + ' - ' + FieldByName('DESCRIZIONE').AsString);
        Next;
      end;
    end;
  end;
  actAcquisizioneTurni.Visible:=(not SolaLettura) and (A040FPianifRepDtM1.A040MW.CodTipologia = 'R') and (Parametri.CampiRiferimento.C30_WebSrv_A025_URL_GET <> '') and (Parametri.CampiRiferimento.C30_WebSrv_A025_URL_PUT <> '');
  actVisualizzaAnomalie.Visible:=actAcquisizioneTurni.Visible;
  actVisualizzaAnomalie.Enabled:=False;
  ProgressBar1.Visible:=actAcquisizioneTurni.Visible;
  CreaC004(SessioneOracle,'A040',Parametri.ProgOper);
  chkNonContDipPian.Checked:=(C004FParamForm.GetParametro('chkNonContDipPian','N') = 'S');
  A040FInserimento.chkTuttiDip.Checked:=(C004FParamForm.GetParametro('chkTuttiDip','N') = 'S');
  C700DatiVisualizzati:='MATRICOLA,T430BADGE,COGNOME,NOME';
  C700DatiSelezionati:=C700CampiBase + ',T030.COGNOME || '' '' || T030.NOME NOMINATIVO,TO_CHAR(T430BADGE) CHR_BADGE';
  if DataRif = 0 then
    DataRif:=Parametri.DataLavoro;
  C700DataLavoro:=DataRif;
  C700DataDal:=DataRif;
  frmSelAnagrafe.SelezionePeriodica:=True;
  frmSelAnagrafe.CreaSelAnagrafe(A040FPianifRepDtM1.A040MW,SessioneOracle,StatusBar,2,True);
  actGestioneMensile.Enabled:=(C700SelAnagrafe.RecordCount > 0) and (not SolaLettura);
  A040FPianifRepDtM1.A040MW.ImpostaFiltro(C700SelAnagrafe.SQL.Text);
  A040FPianifRepDtM1.A040MW.ImpostaCampiLookup;
  EAnno.OnChange:=nil;
  EMese.OnChange:=nil;
  EAnno.Value:=R180Anno(DataRif);
  EMese.Value:=R180Mese(DataRif);
  EAnno.OnChange:=EAnnoChange;
  EMese.OnChange:=EAnnoChange;
  EAnnoChange(nil);
end;

procedure TA040FPianifRep.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  if Action <> caNone then
  begin
    C004FParamForm.Cancella001;
    C004FParamForm.PutParametro('chkNonContDipPian',IfThen(chkNonContDipPian.Checked,'S','N'));
    C004FParamForm.PutParametro('chkTuttiDip',IfThen(A040FInserimento.chkTuttiDip.Checked,'S','N'));
    try SessioneOracle.Commit; except end;
    FreeAndNil(C004FParamForm);
  end;
end;

procedure TA040FPianifRep.FormDestroy(Sender: TObject);
begin
  frmSelAnagrafe.DistruggiSelAnagrafe;
  inherited;
end;

procedure TA040FPianifRep.EAnnoChange(Sender: TObject);
var
  cDL: Integer;
begin
  Screen.Cursor:=crHourGlass;
  try
    with A040FPianifRepDtM1.A040MW do
    begin
      DataInizio:=EncodeDate(EAnno.Value,EMese.Value,1);
      DataFine:=R180FineMese(DataInizio);
      if frmSelAnagrafe.SettaPeriodoSelAnagrafe(DataInizio,DataFine) then
        C700SelAnagrafe.Close;
      RefreshT380;
      //Gestione del dato libero storico
      with selDatoLibero do
        if Active and (VariableIndex('DECORRENZA') >= 0) then
        begin
          SetVariable('DECORRENZA',DataFine);
          Close;
          Open;
          cDL:=R180GetColonnaDBGrid(dGrdPianif,'DATOLIBERO');
          dGrdPianif.Columns[cDL].PickList.Clear;
          while not Eof do
          begin
            dGrdPianif.Columns[cDL].PickList.Add(Format('%-*s',[20,FieldByName('CODICE').AsString]) + ' - ' + FieldByName('DESCRIZIONE').AsString);
            Next;
          end;
        end;
    end;
  finally
    Screen.Cursor:=crDefault;
  end;
end;

procedure TA040FPianifRep.Stampa1Click(Sender: TObject);
begin
  if C700SelAnagrafe.RecordCount = 0 then
    raise Exception.Create(A000MSG_ERR_NO_DIP);
  frmSelAnagrafe.SalvaC00SelAnagrafe;
  A040FDialogStampa.DataSt:=A040FPianifRepDtM1.A040MW.DataInizio;
  A040FDialogStampa.ShowModal;
  Screen.Cursor:=crHourGlass;
  frmSelAnagrafe.RipristinaC00SelAnagrafe(A040FPianifRepDtM1.A040MW);
  Screen.Cursor:=crDefault;
end;

procedure TA040FPianifRep.dGrdPianifCellClick(Column: TColumn);
begin
// creazione hint della griglia
  dGrdPianif.Hint:=A040FPianifRepDtM1.A040MW.GetHint(dGrdPianif.Columns[R180GetColonnaDBGrid(dGrdPianif,'DATOLIBERO')].Visible);
end;

procedure TA040FPianifRep.frmSelAnagrafebtnEreditaSelezioneClick(Sender: TObject);
begin
  inherited;
  frmSelAnagrafe.btnEreditaSelezioneClick(Sender);
  actGestioneMensile.Enabled:=(C700SelAnagrafe.RecordCount > 0) and (not SolaLettura);
  // impostazione Filtro e aggiornamento selezione
  A040FPianifRepDtM1.A040MW.ImpostaFiltro(C700SelAnagrafe.SQL.Text);
  Screen.Cursor:=crHourGlass;
  try
    A040FPianifRepDtM1.A040MW.RefreshT380;
  finally
    Screen.Cursor:=crDefault;
  end;
end;

procedure TA040FPianifRep.frmSelAnagrafebtnSelezioneClick(Sender: TObject);
begin
  inherited;
  C700DataDal:=EncodeDate(EAnno.Value,EMese.Value,1);
  C700DataLavoro:=R180FineMese(C700DataDal);
  frmSelAnagrafe.btnSelezioneClick(Sender);
  actGestioneMensile.Enabled:=(C700SelAnagrafe.RecordCount > 0) and (not SolaLettura);
  // impostazione Filtro e aggiornamento selezione
  A040FPianifRepDtM1.A040MW.ImpostaFiltro(C700SelAnagrafe.SubstitutedSQL);
  Screen.Cursor:=crHourGlass;
  try
    A040FPianifRepDtM1.A040MW.RefreshT380;
  finally
    Screen.Cursor:=crDefault;
  end;
end;

procedure TA040FPianifRep.frmSelAnagrafeR003DatianagraficiClick(Sender: TObject);
begin
  inherited;
  C005DataVisualizzazione:=A040FPianifRepDtM1.A040MW.DataInizio;
  frmSelAnagrafe.R003DatianagraficiClick(Sender);
end;

procedure TA040FPianifRep.dGrdPianifDrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
var i:integer;
begin
  inherited;
  if gdFixed in State then exit;

  with A040FPianifRepDtM1.A040MW do
  begin
    //Ciclo su tabella
    for i:=1 to 31 do
      if (ElencoDate[i].Colorata) and (ElencoDate[i].Data = selT380.FieldByName('DATA').AsDateTime) then
      begin
        if gdSelected in State then
        begin
          dgrdPianif.Canvas.Brush.Color:=clHighLight;
          dgrdPianif.Canvas.Font.Color:=clWhite;
        end
        else
        begin
          dgrdPianif.Canvas.Brush.Color:=$00FFFF80;
          dgrdPianif.Canvas.Font.Color:=clWindowText;
        end;
        Break;
      end;

    if not (gdSelected in State)
    and (R180In(Copy(Column.FieldName,1,Length(Column.FieldName) - 1),['TURNO','PRIORITA']))
    and (   (selT380.FieldByName('SUPERO_MAXMESE1').AsString = 'S')
         or (selT380.FieldByName('SUPERO_MAXMESE2').AsString = 'S')
         or (selT380.FieldByName('SUPERO_MAXMESE3').AsString = 'S')) then
    begin
      dgrdPianif.Canvas.Brush.Color:=clRed;
      dgrdPianif.Canvas.Font.Color:=clWindowText;
    end;
    dgrdPianif.DefaultDrawColumnCell(Rect,DataCol,Column,State);
  end;
end;

procedure TA040FPianifRep.actGestioneMensileExecute(Sender: TObject);
begin
  inherited;
  A040FInserimento.ShowModal;
end;

procedure TA040FPianifRep.actVisualizzaAnomalieExecute(Sender: TObject);
begin
  inherited;
  frmSelAnagrafe.SalvaC00SelAnagrafe;
  C700Distruzione;
  OpenA083MsgElaborazioni(Parametri.Azienda,Parametri.Operatore,'A040WEBSRV','');
  C700DatiSelezionati:=C700CampiBase + ',T030.COGNOME || '' '' || T030.NOME NOMINATIVO,TO_CHAR(T430BADGE) CHR_BADGE';
  C700Creazione(SessioneOracle);
  frmSelAnagrafe.RipristinaC00SelAnagrafe(A040FPianifRepDtM1.A040MW);
  //Gestire ricreazione selAnagrafe con campi di lookup sul T380
end;

procedure TA040FPianifRep.DButtonStateChange(Sender: TObject);
begin
  inherited;
  frmSelAnagrafe.Enabled:=DButton.State = dsBrowse;
end;

end.
