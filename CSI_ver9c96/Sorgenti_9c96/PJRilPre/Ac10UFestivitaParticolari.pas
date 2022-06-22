unit Ac10UFestivitaParticolari;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, R001UGESTTAB, System.Actions,
  Vcl.ActnList, Vcl.ImgList, Data.DB, Vcl.Menus, Vcl.ComCtrls, Vcl.ToolWin,
  Ac10UFestivitaParticolariDtm, Vcl.StdCtrls, Vcl.Mask, Vcl.DBCtrls,
  A003UDataLavoroBis, A000UInterfaccia, Vcl.Buttons, C600USelAnagrafe,
  C013UCheckList, C180FunzioniGenerali, Ac10UFestivitaParticolariMW, Vcl.ExtCtrls,
  ToolbarFiglio, Vcl.Grids, Vcl.DBGrids, A000USessione, A000UCostanti;

type
  TAc10FFestivitaParticolari = class(TR001FGestTab)
    pnlMaster: TPanel;
    dEdtSelezioneAnagrafe: TDBEdit;
    lblCompCausSost: TLabel;
    dCmbCompCausSost: TDBComboBox;
    lblCausSostit: TLabel;
    btnCausSostituzione: TButton;
    dEdtCausSostituzione: TDBEdit;
    lblCausNOFruibili: TLabel;
    btnCausInComp: TButton;
    dEdtCausInComp: TDBEdit;
    lblCausInserimento: TLabel;
    dCmbCausInserimento: TDBLookupComboBox;
    btnSceltePossibili: TButton;
    DEdtFlagScelta: TDBEdit;
    dCmbScelta: TDBComboBox;
    btnFineScelta: TButton;
    btnInizioScelta: TButton;
    dEdtFineScelta: TDBEdit;
    dEdtInizioScelta: TDBEdit;
    dCmbCondizApplic: TDBComboBox;
    dCmbNOScelta: TDBComboBox;
    btnDataFestivita: TButton;
    dcmbTipoFestivita: TDBComboBox;
    dEdtDataFestivita: TDBEdit;
    lblSceltePossibili: TLabel;
    lblScelta: TLabel;
    lblFineScelta: TLabel;
    lblInizioScelta: TLabel;
    lblCondizApplic: TLabel;
    lblNOScelta: TLabel;
    lblSelezioneAnagrafe: TLabel;
    lblTipoFestivita: TLabel;
    lblDataFestivita: TLabel;
    pnlDetail: TPanel;
    frmToolbarFiglio: TfrmToolbarFiglio;
    dGrdDetail: TDBGrid;
    drgpFiltro: TRadioGroup;
    btnSelezioneAnagrafe: TSpeedButton;
    procedure dcmbTipoFestivitaDrawItem(Control: TWinControl; Index: Integer;
      Rect: TRect; State: TOwnerDrawState);
    procedure btnDataFestivitaClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnSelezioneAnagrafeClick(Sender: TObject);
    procedure TModifClick(Sender: TObject);
    procedure TAnnullaClick(Sender: TObject);
    procedure TRegisClick(Sender: TObject);
    procedure TInserClick(Sender: TObject);
    procedure dCmbNOSceltaDrawItem(Control: TWinControl; Index: Integer;
      Rect: TRect; State: TOwnerDrawState);
    procedure dCmbCondizApplicDrawItem(Control: TWinControl; Index: Integer;
      Rect: TRect; State: TOwnerDrawState);
    procedure btnInizioSceltaClick(Sender: TObject);
    procedure btnFineSceltaClick(Sender: TObject);
    procedure dCmbSceltaDrawItem(Control: TWinControl; Index: Integer;
      Rect: TRect; State: TOwnerDrawState);
    procedure btnSceltePossibiliClick(Sender: TObject);
    procedure btnCausInCompClick(Sender: TObject);
    procedure btnCausSostituzioneClick(Sender: TObject);
    procedure dCmbCompCausSostDrawItem(Control: TWinControl; Index: Integer;
      Rect: TRect; State: TOwnerDrawState);
    procedure drgpFiltroClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure frmToolbarFigliobtnTFAnnullaClick(Sender: TObject);
    procedure dcmbTipoFestivitaChange(Sender: TObject);
    procedure frmToolbarFigliobtnTFModificaClick(Sender: TObject);
    procedure frmToolbarFiglioactTFModificaExecute(Sender: TObject);
    procedure dGrdDetailEditButtonClick(Sender: TObject);
    procedure DButtonStateChange(Sender: TObject);
    procedure dCmbSceltaChange(Sender: TObject);
  private
    { Private declarations }
    C600frmSelAnagrafe:TC600frmSelAnagrafe;
    procedure MostraListaCausali(var inOutValori:string;Filtro:string);
    procedure CaricaPickupListDGrdDetail(NomeCol:string;ListaVal:array of TItemsValues);
    procedure ChkElencoSceltePossibili(var elenco:string);
    procedure Abilitazione(Edit:boolean = True);
    procedure GetData(EditGenerico:TDBEdit;DlgCaption:string);
  public
    { Public declarations }
  end;

var
  Ac10FFestivitaParticolari: TAc10FFestivitaParticolari;

procedure OpenAC10FestivitaParticolari;

implementation

{$R *.dfm}

procedure OpenAC10FestivitaParticolari;
begin
  SolaLetturaOriginale:=SolaLettura;
  SolaLettura:=False;
  case A000GetInibizioni('Funzione','OpenAC10FestivitaParticolari') of
    'N':begin
        ShowMessage('Funzione non abilitata!');
        Exit;
        end;
    'R':SolaLettura:=True;
  end;

  Ac10FFestivitaParticolari:=TAc10FFestivitaParticolari.Create(nil);
  Ac10FFestivitaParticolariDtm:=TAc10FFestivitaParticolariDtm.Create(nil);
  try
    Ac10FFestivitaParticolari.ShowModal;
  finally
    SolaLettura:=SolaLetturaOriginale;
    FreeAndNil(Ac10FFestivitaParticolariDtm);
    FreeAndNil(Ac10FFestivitaParticolari);
  end;
end;

procedure TAc10FFestivitaParticolari.ChkElencoSceltePossibili(var elenco:string);
var
  MyC013:TC013FCheckList;
  i:integer;
begin
  inherited;
  MyC013:=TC013FCheckList.Create(Self);
  MyC013.Caption:='<C013> Scelte possibili';
  try
    for i:=Low(TO_CSI_D_SceltaEffettuata) to High(TO_CSI_D_SceltaEffettuata) do
      MyC013.clbListaDati.Items.Add(TO_CSI_D_SceltaEffettuata[i].Value + ' ' + TO_CSI_D_SceltaEffettuata[i].Item);
    R180PutCheckList(elenco,1,MyC013.clbListaDati);
    if MyC013.ShowModal = mrOK then
      elenco:=R180GetCheckList(1,MyC013.clbListaDati);
  finally
    FreeAndNil(MyC013);
  end;
end;

procedure TAc10FFestivitaParticolari.DButtonStateChange(Sender: TObject);
begin
  inherited;
  if Ac10FFestivitaParticolariDtm <> nil then
  begin
    Ac10FFestivitaParticolariDtm.AbilitazioniTFest(dcmbTipoFestivita.Text <> 'A');
    Ac10FFestivitaParticolariDtm.AbilitazioniSelCSI010Master;
  end;
end;

procedure TAc10FFestivitaParticolari.Abilitazione(Edit:boolean = True);
begin
  btnDataFestivita.Enabled:=Edit and not dEdtDataFestivita.Field.ReadOnly;
  btnInizioScelta.Enabled:=Edit;
  btnFineScelta.Enabled:=Edit;
  btnSelezioneAnagrafe.Enabled:=Edit and not dEdtSelezioneAnagrafe.Field.ReadOnly;
  btnSceltePossibili.Enabled:=Edit and (dCmbScelta.Items[dCmbScelta.ItemIndex] <> 'N');
  btnCausInComp.Enabled:=Edit and (dcmbTipoFestivita.Items[dcmbTipoFestivita.ItemIndex] = 'A');
  btnCausSostituzione.Enabled:=Edit{ and (dcmbTipoFestivita.Items[dcmbTipoFestivita.ItemIndex] = 'A')};
  dcmbTipoFestivita.Enabled:=not dcmbTipoFestivita.Field.ReadOnly;
end;

procedure TAc10FFestivitaParticolari.GetData(EditGenerico:TDBEdit;DlgCaption:string);
var
  DataFest:TDateTime;
begin
  inherited;
  if not TryStrToDate(EditGenerico.Text,DataFest) then
    DataFest:=Parametri.DataLavoro;
  DataFest:=DataOut(DataFest,DlgCaption,'Q',True);
  if DataFest <> DATE_NULL then
    EditGenerico.Field.AsDateTime:=DataFest;
end;

procedure TAc10FFestivitaParticolari.MostraListaCausali(var inOutValori:string; Filtro:string);
var
  MyC013:TC013FCheckList;
begin
  inherited;
  MyC013:=TC013FCheckList.Create(Self);
  try
    {Creo filtro esclusione causali selezionabili}
    if not Filtro.IsEmpty and not Ac10FFestivitaParticolariDtm.selCSI010Master.FieldByName('CAUS_INSERT').IsNull then
      Filtro:=Filtro + ',';
    Filtro:=Filtro + Ac10FFestivitaParticolariDtm.selCSI010Master.FieldByName('CAUS_INSERT').AsString;

    Ac10FFestivitaParticolariDtm.Ac10MW.OpenSelT265(Filtro);
    Ac10FFestivitaParticolariDtm.Ac10MW.selT265.First;
    while not Ac10FFestivitaParticolariDtm.Ac10MW.selT265.Eof do
    begin
      MyC013.clbListaDati.Items.Add(Format('%-5s %s',[Ac10FFestivitaParticolariDtm.Ac10MW.selT265.FieldByName('CODICE').AsString,
                                                      Ac10FFestivitaParticolariDtm.Ac10MW.selT265.FieldByName('DESCRIZIONE').AsString]));
      Ac10FFestivitaParticolariDtm.Ac10MW.selT265.Next;
    end;
    R180PutCheckList(inOutValori,5,MyC013.clbListaDati);
    if MyC013.ShowModal = mrOK then
      inOutValori:=R180GetCheckList(5,MyC013.clbListaDati);
  finally
    FreeAndNil(MyC013);
  end;
end;

procedure TAc10FFestivitaParticolari.btnCausSostituzioneClick(Sender: TObject);
var
  Aus:string;
begin
  inherited;
  Aus:=dEdtCausSostituzione.Field.AsString;
  MostraListaCausali(Aus,Ac10FFestivitaParticolariDtm.selCSI010Master.FieldByName('CAUS_INCOMP').AsString);
  dEdtCausSostituzione.Field.AsString:=Aus;
  {Filtro il dato causale d'inserimento in base al conenuto CAUS_INCOMP e CAUS_SOSTIT}
  Ac10FFestivitaParticolariDtm.Ac10MW.OpenSelT265Ins(Ac10FFestivitaParticolariDtm.selCSI010Master.FieldByName('CAUS_INCOMP').AsString,
                                                     Ac10FFestivitaParticolariDtm.selCSI010Master.FieldByName('CAUS_SOSTIT').AsString);
end;

procedure TAc10FFestivitaParticolari.btnCausInCompClick(Sender: TObject);
var
  Aus:string;
begin
  inherited;
  Aus:=dEdtCausInComp.Field.AsString;
  MostraListaCausali(Aus,Ac10FFestivitaParticolariDtm.selCSI010Master.FieldByName('CAUS_SOSTIT').AsString);
  dEdtCausInComp.Field.AsString:=Aus;
  {Filtro il dato causale d'inserimento in base al conenuto CAUS_INCOMP e CAUS_SOSTIT}
  Ac10FFestivitaParticolariDtm.Ac10MW.OpenSelT265Ins(Ac10FFestivitaParticolariDtm.selCSI010Master.FieldByName('CAUS_INCOMP').AsString,
                                                     Ac10FFestivitaParticolariDtm.selCSI010Master.FieldByName('CAUS_SOSTIT').AsString);
end;

procedure TAc10FFestivitaParticolari.btnDataFestivitaClick(Sender: TObject);
begin
  inherited;
  GetData(dEdtDataFestivita,'Data Festività');
  Ac10FFestivitaParticolariDtm.FiltraCSI010Detail;
end;

procedure TAc10FFestivitaParticolari.btnSceltePossibiliClick(Sender: TObject);
var
  MyString:string;
begin
  inherited;
  MyString:=Ac10FFestivitaParticolariDtm.selCSI010Master.FieldByName('SCELTE_POSSIBILI').AsString;
  ChkElencoSceltePossibili(MyString);
  Ac10FFestivitaParticolariDtm.selCSI010Master.FieldByName('SCELTE_POSSIBILI').AsString:=MyString;
end;

procedure TAc10FFestivitaParticolari.btnSelezioneAnagrafeClick(Sender: TObject);
var
  s:string;
begin
  inherited;
  if not (Ac10FFestivitaParticolariDtm.selCSI010Master.state in [dsInsert,dsEdit]) then
    Exit;
  C600frmSelAnagrafe.C600DataLavoro:=Parametri.DataLavoro;
  C600frmSelAnagrafe.C600DatiVisualizzati:='';
  C600frmSelAnagrafe.btnSelezioneClick(Sender);
  if C600frmSelAnagrafe.C600ModalResult = mrOK then
  begin
    s:=C600frmSelAnagrafe.C600FSelezioneAnagrafe.SQLCreato.Text.Trim;
    if Pos('ORDER BY',s.ToUpper) > 0 then
      s:=Copy(S,1,pos('ORDER BY',s.ToUpper) - 1);
    Ac10FFestivitaParticolariDtm.selCSI010Master.FieldByName('FILTRO_ANAGRA').AsString:=s;
    Ac10FFestivitaParticolariDtm.FiltraCSI010Detail;
  end;
end;

procedure TAc10FFestivitaParticolari.btnInizioSceltaClick(Sender: TObject);
begin
  inherited;
  GetData(dEdtInizioScelta,'Inizio scelta');
end;

procedure TAc10FFestivitaParticolari.btnFineSceltaClick(Sender: TObject);
begin
  inherited;
  GetData(dEdtFineScelta,'Fine scelta');
end;

procedure TAc10FFestivitaParticolari.dCmbCompCausSostDrawItem(
  Control: TWinControl; Index: Integer; Rect: TRect; State: TOwnerDrawState);
begin
  inherited;
  (Control as TDBComboBox).Canvas.TextRect(Rect,Rect.Left + 2,Rect.Top, R180ValueToItem(TO_CSI_D_CompCausSost,
                                           (Control as TDBComboBox).Items[Index]));
end;

procedure TAc10FFestivitaParticolari.dCmbCondizApplicDrawItem(
  Control: TWinControl; Index: Integer; Rect: TRect; State: TOwnerDrawState);
begin
  inherited;
  (Control as TDBComboBox).Canvas.TextRect(Rect,Rect.Left + 2,Rect.Top, R180ValueToItem(TO_CSI_D_CondizioneApplic,
                                           (Control as TDBComboBox).Items[Index]));
end;

procedure TAc10FFestivitaParticolari.dCmbNOSceltaDrawItem(Control: TWinControl;
  Index: Integer; Rect: TRect; State: TOwnerDrawState);
begin
  inherited;
  (Control as TDBComboBox).Canvas.TextRect(Rect,Rect.Left + 2,Rect.Top, R180ValueToItem(TO_CSI_D_CompNOScelta,
                                           (Control as TDBComboBox).Items[Index]));
end;

procedure TAc10FFestivitaParticolari.dCmbSceltaChange(Sender: TObject);
begin
  inherited;
  btnSceltePossibili.Enabled:=dCmbScelta.Items[dCmbScelta.ItemIndex] <> 'N';
end;

procedure TAc10FFestivitaParticolari.dCmbSceltaDrawItem(Control: TWinControl;
  Index: Integer; Rect: TRect; State: TOwnerDrawState);
begin
  inherited;
  (Control as TDBComboBox).Canvas.TextRect(Rect,Rect.Left + 2,Rect.Top, R180ValueToItem(TO_CSI_D_Scelta,
                                           (Control as TDBComboBox).Items[Index]));
end;

procedure TAc10FFestivitaParticolari.dcmbTipoFestivitaChange(Sender: TObject);
begin
  inherited;
  Ac10FFestivitaParticolariDtm.AbilitazioniTFest(dcmbTipoFestivita.Text <> 'A');
  Ac10FFestivitaParticolariDtm.FiltraCSI010Detail;
end;

procedure TAc10FFestivitaParticolari.dcmbTipoFestivitaDrawItem(
  Control: TWinControl; Index: Integer; Rect: TRect; State: TOwnerDrawState);
begin
  inherited;
  (Control as TDBComboBox).Canvas.TextRect(Rect,Rect.Left + 2,Rect.Top, R180ValueToItem(TO_CSI_D_TipoFestivita,
                                           (Control as TDBComboBox).Items[Index]));
end;

procedure TAc10FFestivitaParticolari.dGrdDetailEditButtonClick(Sender: TObject);
var
  MyString:string;
begin
  inherited;
  if Ac10FFestivitaParticolariDtm.selCSI010Detail.state in [dsInsert,dsEdit] then
  begin
    if(Sender as TDBGrid).SelectedField = Ac10FFestivitaParticolariDtm.selCSI010Detail.FieldByName('SCELTE_POSSIBILI') then
    begin
      MyString:=Ac10FFestivitaParticolariDtm.selCSI010Detail.FieldByName('SCELTE_POSSIBILI').AsString;
      ChkElencoSceltePossibili(MyString);
      Ac10FFestivitaParticolariDtm.selCSI010Detail.FieldByName('SCELTE_POSSIBILI').AsString:=MyString;
    end;
    if (Sender as TDBGrid).SelectedField = Ac10FFestivitaParticolariDtm.selCSI010Detail.FieldByName('CAUS_INCOMP') then
    begin
      MyString:=Ac10FFestivitaParticolariDtm.selCSI010Detail.FieldByName('CAUS_INCOMP').AsString;
      MostraListaCausali(MyString,Ac10FFestivitaParticolariDtm.selCSI010Master.FieldByName('CAUS_INCOMP').AsString);
      Ac10FFestivitaParticolariDtm.selCSI010Detail.FieldByName('CAUS_INCOMP').AsString:=MyString;
    end;
    if (Sender as TDBGrid).SelectedField = Ac10FFestivitaParticolariDtm.selCSI010Detail.FieldByName('CAUS_SOSTIT') then
    begin
      MyString:=Ac10FFestivitaParticolariDtm.selCSI010Detail.FieldByName('CAUS_SOSTIT').AsString;
      MostraListaCausali(MyString,Ac10FFestivitaParticolariDtm.selCSI010Master.FieldByName('CAUS_INCOMP').AsString);
      Ac10FFestivitaParticolariDtm.selCSI010Detail.FieldByName('CAUS_SOSTIT').AsString:=MyString;
    end;
  end;
end;

procedure TAc10FFestivitaParticolari.drgpFiltroClick(Sender: TObject);
begin
  inherited;
  Ac10FFestivitaParticolariDtm.FiltraCSI010Detail;
  frmToolbarFiglio.actTFModifica.Enabled:=drgpFiltro.Items[drgpFiltro.ItemIndex] = 'Manuali';
end;

procedure TAc10FFestivitaParticolari.FormDestroy(Sender: TObject);
begin
  FreeAndNil(frmToolbarFiglio);
  C600frmSelAnagrafe.DistruggiSelAnagrafe;
  FreeAndNil(C600frmSelAnagrafe);
  inherited;
end;

procedure TAc10FFestivitaParticolari.CaricaPickupListDGrdDetail(NomeCol:string;ListaVal:array of TItemsValues);
var
  IndColonna, i:integer;
begin
  IndColonna:=R180GetColonnaDBGrid(dGrdDetail,NomeCol);
  dGrdDetail.Columns[IndColonna].PickList.Clear;
  for i:=Low(ListaVal) to High(ListaVal) do
    dGrdDetail.Columns[IndColonna].PickList.Add(ListaVal[i].Value + ' ' + ListaVal[i].Item);
end;

procedure TAc10FFestivitaParticolari.FormShow(Sender: TObject);
begin
  inherited;
  //DButton.DataSet:=Ac10FFestivitaParticolariDtm.selCSI010Master;
  Ac10FFestivitaParticolariDtm.AbilitazioniSelCSI010Master;
  C600frmSelAnagrafe:=TC600frmSelAnagrafe.Create(Self);
  C600frmSelAnagrafe.CreaSelAnagrafe(SessioneOracle,nil,0,False);
  C600frmSelAnagrafe.C600DataLavoro:=Parametri.DataLavoro;
  C600frmSelAnagrafe.C600Progressivo:=0;
  //Inizializzazione toolbar figlio
  frmToolbarFiglio.TFDButton:=Ac10FFestivitaParticolariDtm.dsrSelCSI10Detail;
  frmToolbarFiglio.TFDBGrid:=dGrdDetail;
  frmToolbarFiglio.tlbarFiglio.HandleNeeded;
  Ac10FFestivitaParticolariDtm.dsrSelCSI10Detail.OnStateChange:=frmToolbarFiglio.DButtonStateChange;
  SetLength(frmToolbarFiglio.lstLock,3);
  frmToolbarFiglio.lstLock[0]:=Panel1;
  frmToolbarFiglio.lstLock[1]:=File1;
  frmToolbarFiglio.lstLock[2]:=Strumenti1;
  frmToolbarFiglio.AbilitaAzioniTF(nil);
  frmToolbarFiglio.actTFInserisci.Visible:=False;
  frmToolbarFiglio.actTFCancella.Visible:=False;
  //Fine inizializzazione

  CaricaPickupListDGrdDetail('CONDIZIONE_APPLIC',TO_CSI_D_CondizioneApplic);
  CaricaPickupListDGrdDetail('FLAG_SCELTA',TO_CSI_D_Scelta);
  CaricaPickupListDGrdDetail('COMP_NOSCELTA',TO_CSI_D_CompNOScelta);
  CaricaPickupListDGrdDetail('COMP_CAUSSOST',TO_CSI_D_CompCausSost);
  CaricaPickupListDGrdDetail('SCELTA_EFFETTUATA',TO_CSI_D_SceltaEffettuata);
  CaricaPickupListDGrdDetail('SCELTA_DEFINITIVA',TO_CSI_D_CompNOScelta);
  Abilitazione(False);
end;

procedure TAc10FFestivitaParticolari.frmToolbarFiglioactTFModificaExecute(
  Sender: TObject);
begin
  inherited;
  frmToolbarFiglio.actTFModificaExecute(Sender);
end;

procedure TAc10FFestivitaParticolari.frmToolbarFigliobtnTFAnnullaClick(
  Sender: TObject);
begin
  inherited;
  frmToolbarFiglio.actTFAnnullaExecute(Sender);
end;

procedure TAc10FFestivitaParticolari.frmToolbarFigliobtnTFModificaClick(
  Sender: TObject);
begin
  inherited;
  frmToolbarFiglio.actTFModificaExecute(Sender);
end;

procedure TAc10FFestivitaParticolari.TAnnullaClick(Sender: TObject);
begin
  inherited;
  Abilitazione(False);
  Ac10FFestivitaParticolariDtm.selCSI010Detail.Refresh;
end;

procedure TAc10FFestivitaParticolari.TInserClick(Sender: TObject);
begin
  inherited;
  Abilitazione(True);
end;

procedure TAc10FFestivitaParticolari.TModifClick(Sender: TObject);
begin
  inherited;
  Abilitazione(True);
end;

procedure TAc10FFestivitaParticolari.TRegisClick(Sender: TObject);
begin
  inherited;
  Abilitazione(False);
end;

end.
