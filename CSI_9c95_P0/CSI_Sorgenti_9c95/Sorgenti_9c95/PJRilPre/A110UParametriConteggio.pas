unit A110UParametriConteggio;

interface

uses
  Windows, Messages, SysUtils, Math, Classes, Graphics, Controls, Forms, Dialogs,
  Db, Menus, StdCtrls, Mask, DBCtrls, Buttons, ExtCtrls, ComCtrls,
  R004UGestStorico, R004UGestStoricoDtM, ImgList, ToolWin, ActnList,
  Oracle, OracleData, A000UCostanti, A000USessione,A000UInterfaccia, P050UArrotondamenti, Variants,
  A120UTIPIRIMBORSI, L001Call, C013UCheckList, C180FunzioniGenerali, A129UIndennitaKm,
  C009UCopiaSu, Grids, DBGrids, A110USoglieRimborsiPasto, A110UParametriConteggioDtM,
  System.Actions;

type
  TA110FParametriConteggio = class(TR004FGestStorico)
    Panel1: TPanel;
    pmnParametri: TPopupMenu;
    NuovoElemento1: TMenuItem;
    GroupBox1: TGroupBox;
    lblArrotondamentoOre: TLabel;
    Label1: TLabel;
    dedtArrotondamentoOre: TDBEdit;
    dRgpTipoArrotondamento: TDBRadioGroup;
    LblArrTotaleImportiPerDatiPaghe: TLabel;
    LblTariffaDopoRiduzione: TLabel;
    dLblArrTotaleImportiPerDatiPaghe: TDBText;
    dLblTariffaDopoRiduzione: TDBText;
    dcmbArrTariffaDopoRiduzione: TDBLookupComboBox;
    dcmbArrTotaleImportiPerDatiPaghe: TDBLookupComboBox;
    LblCodice: TLabel;
    LblDescrizione: TLabel;
    DBText1: TDBText;
    dedtDescrizione: TDBEdit;
    dcmbCodice: TDBLookupComboBox;
    Label2: TLabel;
    dCmbTipoMissione: TDBLookupComboBox;
    DBText2: TDBText;
    GroupBox3: TGroupBox;
    lblOreMinimePerIndennita: TLabel;
    dedtOreMinimePerIndennita: TDBEdit;
    Label3: TLabel;
    dEdtTariffaIntera: TDBEdit;
    optTipoIndennita: TDBRadioGroup;
    PclRegole: TPageControl;
    TabSheet1: TTabSheet;
    LblLimiteOreRetribuiteIntere: TLabel;
    lblNMaxGgInteriNelMese: TLabel;
    LblPercDiRetrDopoIlSuperoGg: TLabel;
    LblPercDiRetrDopoIlSuperOre: TLabel;
    LblPercdiRetrRimbPasto: TLabel;
    dedtLimiteOreRetribuiteIntere: TDBEdit;
    dedtPercdiRetrDopoIlSuperoOre: TDBEdit;
    dedtNMaxGgRetrInteriNelMese: TDBEdit;
    dedtPercdiretrDopoIlSuperoGG: TDBEdit;
    dedtPercdiRetrRimbPasto: TDBEdit;
    ChkRiduzioneRimbPasto: TDBCheckBox;
    TabSheet2: TTabSheet;
    Label5: TLabel;
    DBText4: TDBText;
    Label8: TLabel;
    Label9: TLabel;
    dedtNumeroOre: TDBEdit;
    dedtImporto: TDBEdit;
    dedtNumeroOre2: TDBEdit;
    TabSheet3: TTabSheet;
    Label7: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    dEdtCodPagheIndIntera: TDBEdit;
    dEdtCodPagheSupHH: TDBEdit;
    dEdtCodPagheSupGG: TDBEdit;
    dEdtCodPagheSupHHGG: TDBEdit;
    TabSheet4: TTabSheet;
    dEdtIndennita: TDBEdit;
    BtnIndennita: TButton;
    dEdtRimborsi: TDBEdit;
    BtnRimborsi: TButton;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    DEdtNMaxRimb: TDBEdit;
    DRgpDataRif: TDBRadioGroup;
    DChkTabTariff: TDBCheckBox;
    grpScaglioni: TGroupBox;
    DBGrid1: TDBGrid;
    PopMenuRimborsi: TPopupMenu;
    Accedi1: TMenuItem;
    GroupBox4: TGroupBox;
    lblGiustifOreMaxGg: TLabel;
    dchkGiustifCopreDebitoGg: TDBCheckBox;
    dedtGiustifOreMaxGg: TDBEdit;
    RGCausali: TRadioGroup;
    ECausale: TDBLookupComboBox;
    Label16: TLabel;
    LCausale: TDBText;
    drgrpTipoPasto: TDBRadioGroup;
    dchkRimbKmAuto: TDBCheckBox;
    DBText3: TDBText;
    dtxtIndKmAuto: TDBText;
    dcmbIndKmAuto: TDBLookupComboBox;
    dedtRimbKmAutoMinimo: TDBEdit;
    lblRimbKmAutoMinimo: TLabel;
    lblRimbKmAutoMinimoKm: TLabel;
    lblIndKmAuto: TLabel;
    procedure DChkTabTariffClick(Sender: TObject);
    procedure optTipoIndennitaChange(Sender: TObject);
    procedure DButtonStateChange(Sender: TObject);
    procedure BtnRimborsiClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure BtnIndennitaClick(Sender: TObject);
    procedure dcmbCodiceKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormActivate(Sender: TObject);
    procedure dedtOreMinimePerIndennitaKeyUp(Sender: TObject;
      var Key: Word; Shift: TShiftState);
    procedure dedtLimiteOreRetribuiteIntereKeyUp(Sender: TObject;
      var Key: Word; Shift: TShiftState);
    procedure NuovoElemento1Click(Sender: TObject);
    procedure ChkRiduzioneRimbPastoClick(Sender: TObject);
    procedure RGCausaliClick(Sender: TObject);
    procedure ECausaleKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ECausaleKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure ECausaleCloseUp(Sender: TObject);
    procedure TAnnullaClick(Sender: TObject);
    procedure Accedi1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure drgrpTipoPastoChange(Sender: TObject);
    procedure dchkRimbKmAutoClick(Sender: TObject);
    procedure dcmbIndKmAutoKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    procedure DisabilitaBlocchi;
  public
    Assenza:Boolean;
  end;

var
  A110FParametriConteggio: TA110FParametriConteggio;

procedure OpenA110ParametriConteggio;

implementation

{$R *.DFM}

procedure OpenA110ParametriConteggio;
begin
  SolaLetturaOriginale:=SolaLettura;
  SolaLettura:=False;
  case A000GetInibizioni('Funzione','OpenA110ParametriConteggio') of
    'N':begin
        ShowMessage('Funzione non abilitata!');
        Exit;
        end;
    'R':SolaLettura:=True;
  end;
  Screen.Cursor:=crHourGlass;
  Application.CreateForm(TA110FParametriConteggio,A110FParametriConteggio);
  Application.CreateForm(TA110FParametriConteggioDtM,A110FParametriConteggioDtM);
  try
    Screen.Cursor:=crDefault;
    A110FParametriConteggio.ShowModal;
  finally
    SolaLettura:=SolaLetturaOriginale;
    A110FParametriConteggioDtM.Free;
    A110FParametriConteggio.Free;
  end;
end;

procedure TA110FParametriConteggio.DisabilitaBlocchi;
var OptStato,OptStatoGen:Boolean;
begin
  with A110FParametriConteggioDtM do
  begin
    OptStato:=True;
    if (chkRiduzioneRimbPasto.Checked) or (DChkTabTariff.Checked) or
       ((not ChkRiduzioneRimbPasto.Checked) and (optTipoIndennita.ItemIndex = 1)) then
    begin
      if DButton.State in [dsEdit,dsInsert] then
        A110FParametriConteggioMW.PulisciCampiIndOr;
      OptStato:=False;
    end;
    dedtLimiteOreRetribuiteIntere.Enabled:=OptStato;
    LblLimiteOreRetribuiteIntere.Enabled:=OptStato;
    dedtNMaxGgRetrInteriNelMese.Enabled:=OptStato;
    lblNMaxGgInteriNelMese.Enabled:=OptStato;
    dedtPercdiRetrDopoIlSuperoOre.Enabled:=OptStato;
    LblPercDiRetrDopoIlSuperOre.Enabled:=OptStato;
    dedtPercdiretrDopoIlSuperoGG.Enabled:=OptStato;
    LblPercDiRetrDopoIlSuperoGg.Enabled:=OptStato;

    OptStatoGen:=Not(DChkTabTariff.Checked);
//==================================================
//BLOCCO RIFERITO ALL'INDENNITA' DI TRASFERTA INTERA
//==================================================
    GroupBox3.Enabled:=OptStatoGen;
    dEdtTariffaIntera.Enabled:=OptStatoGen;
    dedtOreMinimePerIndennita.Enabled:=OptStatoGen;
    optTipoIndennita.Enabled:=OptStatoGen;
    Label3.Enabled:=OptStatoGen;
    if Not(OptStatoGen) then
    begin
      if DButton.State in [dsEdit,dsInsert] then
        A110FParametriConteggioMW.PulisciCampiStatoGen;
    end;
//==================================================
//BLOCCO RIFERITO AI CODICI VOCE PAGHE
//====================================
    dEdtCodPagheSupGG.Visible:=OptStatoGen;
    dEdtCodPagheSupHHGG.Visible:=OptStatoGen;
    dEdtCodPagheIndIntera.Visible:=OptStatoGen;
    dEdtCodPagheSupHH.Visible:=OptStatoGen;
    Label11.Visible:=OptStatoGen;
    Label12.Visible:=OptStatoGen;
    Label7.Visible:=OptStatoGen;
    Label10.Visible:=OptStatoGen;
//====================================
    lblOreMinimePerIndennita.Enabled:=OptStatoGen;
    LblTariffaDopoRiduzione.Enabled:=OptStatoGen;
    dcmbArrTariffaDopoRiduzione.Enabled:=OptStatoGen;
    dLblTariffaDopoRiduzione.Enabled:=OptStatoGen;
    ChkRiduzioneRimbPasto.Enabled:=OptStatoGen;
    if DChkTabTariff.Checked and (DButton.State in [dsEdit,dsInsert]) then
      A110FParametriConteggioMW.ResetRiduzionePasto;

    LblPercdiRetrRimbPasto.Enabled:=ChkRiduzioneRimbPasto.Checked;
    dedtPercdiRetrRimbPasto.Enabled:=ChkRiduzioneRimbPasto.Checked;
  end;
end;

procedure TA110FParametriConteggio.drgrpTipoPastoChange(Sender: TObject);
begin
  inherited;
  //Caratto 17/10/2013
  //Spostato da click a change. In questo modo si scatena quandosi cambia il valore anche
  //scorrendo gli elementi. Altrimenti rimaneva abilitato o meno in base al valore del primo
  //Non ha mai funzionato.
  DBGrid1.Enabled:=R180In(drgrpTipoPasto.ItemIndex,[0,1]);
  if DBGrid1.Enabled then
    DBGrid1.TitleFont.Color:=clBlue
  else
    DBGrid1.TitleFont.Color:=clInactiveCaption;
  Label5.Enabled:=drgrpTipoPasto.ItemIndex = 2;
  dedtImporto.Enabled:=drgrpTipoPasto.ItemIndex = 2;
  label8.Enabled:=drgrpTipoPasto.ItemIndex = 2;
  dedtNumeroOre.Enabled:=drgrpTipoPasto.ItemIndex = 2;
  Label9.Enabled:=drgrpTipoPasto.ItemIndex = 2;
  dedtNumeroOre2.Enabled:=drgrpTipoPasto.ItemIndex = 2;
end;

procedure TA110FParametriConteggio.ECausaleCloseUp(Sender: TObject);
begin
  //LCausale.Visible:=ECausale.KeyValue <> null;
end;

procedure TA110FParametriConteggio.ECausaleKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
(*  if Key = vk_Delete then
  begin
    (Sender as TDBLookupComboBox).KeyValue:=null;
    LCausale.Visible:=False;
  end;*)
  if Key = vk_Delete then
  begin
    (Sender as TDBLookupComboBox).KeyValue:=null;
    if (Sender as TDBLookupComboBox).Field <> nil then
      if (Sender as TDBLookupComboBox).DataSource.State in [dsEdit,dsInsert] then
        (Sender as TDBLookupComboBox).Field.Clear;
  end;
end;

procedure TA110FParametriConteggio.ECausaleKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  //LCausale.Visible:=ECausale.KeyValue <> null;
end;

procedure TA110FParametriConteggio.FormActivate(Sender: TObject);
begin
  inherited;
  PclRegole.ActivePageIndex:=0;
  drgrpTipoPastoChange(nil);
end;

procedure TA110FParametriConteggio.dedtOreMinimePerIndennitaKeyUp(
  Sender: TObject; var Key: Word; Shift: TShiftState);
var c:char;
begin
  inherited;
  if length(TRIM(dedtOreMinimePerIndennita.Text)) = 1 then
  begin
    c:= TRIM(dedtOreMinimePerIndennita.Text)[1];
    if (ord(c) < 48) or (ord(c) > 57) then
      A110FParametriConteggiodtm.M010.FieldByName('OREMINIMEPERINDENNITA').CLEAR;
  end;
end;

procedure TA110FParametriConteggio.dedtLimiteOreRetribuiteIntereKeyUp(
  Sender: TObject; var Key: Word; Shift: TShiftState);
var c:char;
begin
  inherited;
  if length(TRIM(dedtLimiteOreRetribuiteIntere.Text)) = 1 then
  begin
    c:= TRIM(dedtLimiteOreRetribuiteIntere.Text)[1];
    if (ord(c) < 48) or (ord(c) > 57) then
      A110FParametriConteggiodtm.M010.FieldByName('LIMITEORERETRIBUITEINTERE').CLEAR;
  end;
end;

procedure TA110FParametriConteggio.NuovoElemento1Click(Sender: TObject);
var Griglia:TInserisciDLL;
    i:integer;
    sFiltro:string;
begin
  if (PmnParametri.PopupComponent.Name = dcmbArrTotaleImportiPerDatiPaghe.Name) or
     (PmnParametri.PopupComponent.Name = dcmbArrTariffaDopoRiduzione.Name) then
  begin
    OpenP050FArrotondamenti(TDBLookupComboBox(pmnParametri.PopupComponent).Field.AsString);
    A110FParametriConteggioDtM.A110FParametriConteggioMW.selP050.Refresh;
  end
  else if (PmnParametri.PopupComponent.Name = dcmbTipoMissione.Name) then
  begin
    with A110FParametriConteggioDtM.A110FParametriConteggioMW.SelM011 do
    begin
      sFiltro:='';
      Griglia.NomeTabella:='M011_TIPOMISSIONE';
      Griglia.Titolo:='Tipo missione';
      Griglia.FiltroDizAllinea:='TIPI MISSIONE';
      for i:=0 to FieldCount -1 do
      begin
        Griglia.Display[i]:=Fields[i].DisplayLabel;
        Griglia.Size[i]:=Fields[i].DisplayWidth;
      end;
      //Imposto il filtro prima di aprire la tabella
      for i:=0 to High(Parametri.FiltroDizionario) do
        if Parametri.FiltroDizionario[i].Tabella = 'TIPOLOGIA TRASFERTA' then
        begin
          If Parametri.FiltroDizionario[i].Abilitato then
          begin
            if sFiltro<>''then
              sFiltro:=sFiltro + 'OR';
            sFiltro:=sFiltro + '(CODICE=''' + Parametri.FiltroDizionario[i].Codice + ''')';
          end
          else
          begin
            if sFiltro<>''then
              sFiltro:=sFiltro + 'AND';
            sFiltro:=sFiltro + '(CODICE<>''' + Parametri.FiltroDizionario[i].Codice + ''')';
          end
        end;
    end;
    Inserisci(Griglia,dcmbTipoMissione.Text,sFiltro);
    //Caratto 17/10/2013 Faceva refresh ma non del dataset perchè fuori dal with
    //Non ha mai funzionato!
    A110FParametriConteggioDtM.A110FParametriConteggioMW.SelM011.Refresh;
  end
  else if PmnParametri.PopupComponent.Name = dEdtRimborsi.Name then
  begin
    try
      OpenA120TipiRimborsi('');
    finally
      A110FParametriConteggioDtM.A110FParametriConteggioMW.CaricaListe;
    end;
  end
  else if PmnParametri.PopupComponent.Name = dEdtIndennita.Name then
  begin
    try
      OpenA129IndennitaKm('',0);
    finally
      A110FParametriConteggioDtM.A110FParametriConteggioMW.CaricaListe;
    end;
  end;
end;

procedure TA110FParametriConteggio.ChkRiduzioneRimbPastoClick(
  Sender: TObject);
//var OptStato:Boolean;
begin
  inherited;
  {with A110FParametriConteggioDtM do
  begin
    OptStato:=True;
    If (ChkRiduzioneRimbPasto.Checked) or (M010.FieldByName('TIPO_TARIFFA').AsString = 'G') then
    begin
      M010.FieldByName('LIMITEORERETRIBUITEINTERE').Clear;
      M010.FieldByName('PERCRETRIBSUPEROORE').Clear;
      M010.FieldByName('MAXGIORNIRETRMESE').Clear;
      M010.FieldByName('PERCRETRIBSUPEROGG').Clear;
      OptStato:=False;
    end
    else
    begin
      M010.FieldByName('PERCRETRIBPASTO').Clear;
    end;
  end;

  LblLimiteOreRetribuiteIntere.Enabled:=(not ChkRiduzioneRimbPasto.Checked) and OptStato;
  dedtLimiteOreRetribuiteIntere.Enabled:=(not ChkRiduzioneRimbPasto.Checked) and OptStato;
  LblPercDiRetrDopoIlSuperOre.Enabled:=(not ChkRiduzioneRimbPasto.Checked) and OptStato;
  dedtPercdiRetrDopoIlSuperoOre.Enabled:=(not ChkRiduzioneRimbPasto.Checked) and OptStato;
  lblNMaxGgInteriNelMese.Enabled:=(not ChkRiduzioneRimbPasto.Checked) and OptStato;
  dedtNMaxGgRetrInteriNelMese.Enabled:=(not ChkRiduzioneRimbPasto.Checked) and OptStato;
  LblPercDiRetrDopoIlSuperoGg.Enabled:=(not ChkRiduzioneRimbPasto.Checked) and OptStato;
  dedtPercdiretrDopoIlSuperoGG.Enabled:=(not ChkRiduzioneRimbPasto.Checked) and OptStato;
  LblPercdiRetrRimbPasto.Enabled:=ChkRiduzioneRimbPasto.Checked;
  dedtPercdiRetrRimbPasto.Enabled:=ChkRiduzioneRimbPasto.Checked;}
  DisabilitaBlocchi;
end;

procedure TA110FParametriConteggio.dcmbCodiceKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  if Key = vk_Delete then
  begin
    (Sender as TDBLookupComboBox).KeyValue:=null;
    if (Sender as TDBLookupComboBox).Field <> nil then
      if (Sender as TDBLookupComboBox).DataSource.State in [dsEdit,dsInsert] then
        (Sender as TDBLookupComboBox).Field.Clear;
  end;
end;

procedure TA110FParametriConteggio.dcmbIndKmAutoKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  if Key = vk_Delete then
  begin
    (Sender as TDBLookupComboBox).KeyValue:=null;
    if (Sender as TDBLookupComboBox).Field <> nil then
      if (Sender as TDBLookupComboBox).DataSource.State in [dsEdit,dsInsert] then
        (Sender as TDBLookupComboBox).Field.Clear;
  end;
end;

procedure TA110FParametriConteggio.Accedi1Click(Sender: TObject);
begin
  inherited;
  with A110FParametriConteggioDtM do
  begin
    OpenA110SoglieRimborsiPasto;
    A110FParametriConteggioMW.selM013.Refresh;
  end;
end;

procedure TA110FParametriConteggio.BtnIndennitaClick(Sender: TObject);
begin
  if DButton.State in [dsEdit,dsInsert] then
  begin
    C013FCheckList:=TC013FCheckList.Create(nil);
    try
      C013FCheckList.clbListaDati.Items.Assign(A110FParametriConteggioDtM.A110FParametriConteggioMW.LstDescIndennita);
      R180PutCheckList(dEdtIndennita.Field.AsString,5,C013FCheckList.clbListaDati);
      if (C013FCheckList.ShowModal = mrOK) and (not dEdtIndennita.Field.ReadOnly) then
      begin
        dEdtIndennita.Field.AsString:=R180GetCheckList(5,C013FCheckList.clbListaDati);
        // CUNEO_ASLCN1 - commessa 2013/107 SVILUPPO#1.ini
        // filtra dataset per indennità km automatica
        A110FParametriConteggioDtM.A110FParametriConteggioMW.OpenselM021RimbAuto;
        // CUNEO_ASLCN1 - commessa 2013/107 SVILUPPO#1.fine
      end;
    finally
      C013FCheckList.Free;
    end;
  end;
end;

procedure TA110FParametriConteggio.FormCreate(Sender: TObject);
begin
  inherited;
  Copiada1.Visible:=True;
  Assenza:=True;
end;

procedure TA110FParametriConteggio.FormShow(Sender: TObject);
begin
  inherited;
  with A110FParametriConteggioDtM.A110FParametriConteggioMW do
  begin
    dcmbCodice.ListSource:=dSource;
    dcmbTipoMissione.ListSource:=DsrM011;
    dcmbArrTotaleImportiPerDatiPaghe.ListSource:=DsrP050;
    dcmbArrTariffaDopoRiduzione.ListSource:=DsrP050;
    DBText4.DataSource:=DsrP030;
    if A110FParametriConteggioDtM.A110FParametriConteggioMW.IsCausalePresenza then
      ECausale.ListSource:=DsrT275
    else
      ECausale.ListSource:=DsrT265;
    DbGrid1.DataSource:=DsrM013;
    // CUNEO_ASLCN1 - commessa 2013/107 SVILUPPO#1.ini
    // imposta gli item di selezione per il codice di indennità km
    dcmbIndKmAuto.ListSource:=dsrM021RimbAuto;
    // CUNEO_ASLCN1 - commessa 2013/107 SVILUPPO#1.ini
  end;
end;

procedure TA110FParametriConteggio.BtnRimborsiClick(Sender: TObject);
begin
  if DButton.State in [dsEdit,dsInsert] then
  begin
    C013FCheckList:=TC013FCheckList.Create(nil);
    try
      C013FCheckList.clbListaDati.Items.Assign(A110FParametriConteggioDtM.A110FParametriConteggioMW.LstDescRimborsi);
      R180PutCheckList(dEdtRimborsi.Field.AsString,5,C013FCheckList.clbListaDati);
      if (C013FCheckList.ShowModal = mrOK) and (not dEdtRimborsi.Field.ReadOnly) then
        dEdtRimborsi.Field.AsString:=R180GetCheckList(5,C013FCheckList.clbListaDati);
    finally
      C013FCheckList.Free;
    end;
  end;
end;

procedure TA110FParametriConteggio.DButtonStateChange(Sender: TObject);
begin
  inherited;
  BtnRimborsi.Enabled:=DButton.State in [dsInsert, dsEdit];
  RGCausali.Enabled:=DButton.State in [dsInsert, dsEdit];
  // CUNEO_ASLCN1 - commessa 2013/107 SVILUPPO#1.ini
  // imposta abilitazione della combobox di selezione indennità km automatica
  //lblIndKmAuto.Enabled:=(DButton.State in [dsInsert, dsEdit]) and (dchkRimbKmAuto.Checked);
  dcmbIndKmAuto.Enabled:=(DButton.State in [dsInsert, dsEdit]) and (dchkRimbKmAuto.Checked);
  //lblRimbKmAutoMinimo.Enabled:=(DButton.State in [dsInsert, dsEdit]) and (dchkRimbKmAuto.Checked);
  dedtRimbKmAutoMinimo.Enabled:=(DButton.State in [dsInsert, dsEdit]) and (dchkRimbKmAuto.Checked);
  //lblRimbKmAutoMinimoKm.Enabled:=(DButton.State in [dsInsert, dsEdit]) and (dchkRimbKmAuto.Checked);
  // CUNEO_ASLCN1 - commessa 2a013/107 SVILUPPO#1.fine
end;

// CUNEO_ASLCN1 - commessa 2013/107 SVILUPPO#1.ini
procedure TA110FParametriConteggio.dchkRimbKmAutoClick(Sender: TObject);
begin
  // imposta abilitazione della combobox di selezione indennità km automatica
  lblIndKmAuto.Enabled:=(DButton.State in [dsInsert, dsEdit]) and (dchkRimbKmAuto.Checked);
  dcmbIndKmAuto.Enabled:=(DButton.State in [dsInsert, dsEdit]) and (dchkRimbKmAuto.Checked);
  lblRimbKmAutoMinimo.Enabled:=(DButton.State in [dsInsert, dsEdit]) and (dchkRimbKmAuto.Checked);
  dedtRimbKmAutoMinimo.Enabled:=(DButton.State in [dsInsert, dsEdit]) and (dchkRimbKmAuto.Checked);
  lblRimbKmAutoMinimoKm.Enabled:=(DButton.State in [dsInsert, dsEdit]) and (dchkRimbKmAuto.Checked);
end;
// CUNEO_ASLCN1 - commessa 2013/107 SVILUPPO#1.fine

procedure TA110FParametriConteggio.optTipoIndennitaChange(Sender: TObject);
begin
  inherited;
  DisabilitaBlocchi;
end;

procedure TA110FParametriConteggio.RGCausaliClick(Sender: TObject);
var Causale: String;
begin
  if (RGCausali.ItemIndex = 0) and (Assenza) then
  begin
    ECausale.ListSource:=A110FParametriConteggioDtM.A110FParametriConteggioMW.DsrT275;
    //LCausale.DataSource:=A110FParametriConteggioDtM.D275;
    Assenza:=False;
  end;
  if (RGCausali.ItemIndex = 1) and (not Assenza) then
  begin
    ECausale.ListSource:=A110FParametriConteggioDtM.A110FParametriConteggioMW.DsrT265;
    //LCausale.DataSource:=A110FParametriConteggioDtM.D265;
    Assenza:=True;
  end;
  ECausale.KeyValue:=null;
  if ECausale.ListSource <> nil then
    Causale:=VarToStr(ECausale.ListSource.DataSet.Lookup('Codice',A110FParametriConteggioDtM.M010.FieldByName('CAUSALE_MISSIONE').AsString,'Codice'));
  if Causale <> '' then
    ECausale.KeyValue:=Causale;
  //LCausale.Visible:=ECausale.KeyValue <> null;
  dchkGiustifCopreDebitoGg.Visible:=Assenza;
end;

procedure TA110FParametriConteggio.TAnnullaClick(Sender: TObject);
begin
  inherited;
  actRefreshExecute(nil);
end;

procedure TA110FParametriConteggio.DChkTabTariffClick(Sender: TObject);
begin
  inherited;
  DisabilitaBlocchi;
end;

end.
