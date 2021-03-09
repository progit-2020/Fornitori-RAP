unit S740URegoleValutazioni;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, R004UGestStorico, ActnList, ImgList, DB, Menus, StdCtrls, ComCtrls,
  ToolWin, Mask, DBCtrls, Buttons, Math, StrUtils, A003UDataLavoroBis,
  A000UCostanti, A000USessione, A000UInterfaccia, C013UCheckList, C180FunzioniGenerali,
  ExtCtrls, C600USelAnagrafe, Grids, DBGrids, CheckLst, System.Actions,
  System.ImageList;

type
  TS740FRegoleValutazioni = class(TR004FGestStorico)
    pgcRegole: TPageControl;
    tshGenerico: TTabSheet;
    lblGiorniMinimi: TLabel;
    lblPathIstruzioni: TLabel;
    dedtGiorniMinimi: TDBEdit;
    dedtPathIstruzioni: TDBEdit;
    tshStampa: TTabSheet;
    tshP1: TTabSheet;
    pnlTestata: TPanel;
    dedtCodice: TDBEdit;
    lblCodice: TLabel;
    lblDescrizione: TLabel;
    dedtDescrizione: TDBEdit;
    C600frmSelAnagrafe: TC600frmSelAnagrafe;
    Label3: TLabel;
    dedtFiltroAnagrafe: TDBEdit;
    lblPagineAbilitate: TLabel;
    dedtPagineAbilitate: TDBEdit;
    btnPagineAbilitate: TButton;
    tshP2: TTabSheet;
    dchkAssegnPreventivaObiettivi: TDBCheckBox;
    grpPeriodoAssegnObiettivi: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    dedtDataDaObiettivi: TDBEdit;
    dedtDataAObiettivi: TDBEdit;
    btnDataDaObiettivi: TButton;
    btnDataAObiettivi: TButton;
    tshP3: TTabSheet;
    tshP4: TTabSheet;
    lblTestoValutazioniComplessive: TLabel;
    dmemTestoValutazioniComplessive: TDBMemo;
    dchkAbilitaAreeFormative: TDBCheckBox;
    dchkAreaFormativaObbligatoria: TDBCheckBox;
    dchkAbilitaAccettazioneValutato: TDBCheckBox;
    drgpAbilitaCommentiValutato: TDBRadioGroup;
    lblCodiciTipoRapporto: TLabel;
    dedtCodiciTipoRapporto: TDBEdit;
    btnSceltaCodiciTipoRapporto: TButton;
    pgcStampa: TPageControl;
    tshVarie: TTabSheet;
    gbxLogo: TGroupBox;
    lblLarghezza: TLabel;
    lblAltezza: TLabel;
    dedtLogoLarghezza: TDBEdit;
    dedtLogoAltezza: TDBEdit;
    dchkAggiornaDataCompilazione: TDBCheckBox;
    tshDatiAnagrafici: TTabSheet;
    gbxDatiStampa: TGroupBox;
    dcbxDatoStampa1: TDBLookupComboBox;
    dcbxDatoStampa2: TDBLookupComboBox;
    dcbxDatoStampa3: TDBLookupComboBox;
    dcbxDatoStampa4: TDBLookupComboBox;
    dcbxDatoStampa5: TDBLookupComboBox;
    dchkDescLunga1: TDBCheckBox;
    dchkDescLunga3: TDBCheckBox;
    dchkDescLunga5: TDBCheckBox;
    dcbxDatoStampa6: TDBLookupComboBox;
    dchkStampaVariazioni5: TDBCheckBox;
    tshEtichette: TTabSheet;
    gpbStampaCampiOpzionali: TGroupBox;
    clbCampiOpzionaliStampa: TCheckListBox;
    GroupBox2: TGroupBox;
    clbCampiOpzionaliCompilazione: TCheckListBox;
    dchkStampaPeriodoValutazione: TDBCheckBox;
    dgrdEtichette: TDBGrid;
    lblDatoVariazioneValutatore: TLabel;
    dcbxDatoVariazioneValutatore: TDBLookupComboBox;
    tshP5: TTabSheet;
    DBCheckBox1: TDBCheckBox;
    dchkValutaCessatiRuolo: TDBCheckBox;
    lblPathFilePDF: TLabel;
    edtPathFilePDF: TDBEdit;
    sbtPathFilePDF: TButton;
    OpenDialog1: TOpenDialog;
    dcbxCodParProtocollo: TDBLookupComboBox;
    lblCodParProtocollo: TLabel;
    dlblDescParProtocollo: TDBText;
    lblPathInformazioni: TLabel;
    dedtPathInformazioni: TDBEdit;
    dchkInvioEmail: TDBCheckBox;
    procedure FormShow(Sender: TObject);
    procedure DButtonDataChange(Sender: TObject; Field: TField);
    procedure DButtonStateChange(Sender: TObject);
    procedure btnStoricizzaClick(Sender: TObject);
    procedure btnDataDaClick(Sender: TObject);
    procedure btnPagineAbilitateClick(Sender: TObject);
    procedure dcbxDatoStampa1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure dchkDescLunga1Click(Sender: TObject);
    procedure drgpNumeroFirmeValutatoriClick(Sender: TObject);
    procedure dedtFirma1Exit(Sender: TObject);
    procedure C600frmSelAnagrafebtnSelezioneClick(Sender: TObject);
    procedure btnSceltaCodiciTipoRapportoClick(Sender: TObject);
    procedure TAnnullaClick(Sender: TObject);
    procedure sbtPathFilePDFClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure AbilitaComponenti;
  end;

var
  S740FRegoleValutazioni: TS740FRegoleValutazioni;

procedure OpenS740FRegoleValutazioni;

implementation

{$R *.dfm}
uses
  S740URegoleValutazioniDtM;

procedure OpenS740FRegoleValutazioni;
begin
  SolaLetturaOriginale:=SolaLettura;
  SolaLettura:=False;
  case A000GetInibizioni('Funzione','OpenS740FRegoleValutazioni') of
    'N':begin
        ShowMessage('Funzione non abilitata!');
        Exit;
        end;
    'R':SolaLettura:=True;
  end;
  Screen.Cursor:=crHourGlass;
  Application.CreateForm(TS740FRegoleValutazioni,S740FRegoleValutazioni);
  Application.CreateForm(TS740FRegoleValutazioniDtM,S740FRegoleValutazioniDtM);
  try
    Screen.Cursor:=crDefault;
    S740FRegoleValutazioni.ShowModal;
  finally
    SolaLettura:=SolaLetturaOriginale;
    S740FRegoleValutazioni.Free;
    S740FRegoleValutazioniDtM.Free;
  end;
end;

procedure TS740FRegoleValutazioni.FormShow(Sender: TObject);
begin
  inherited;
  pgcRegole.TabIndex:=0;
  pgcStampa.TabIndex:=0;
  with S740FRegoleValutazioniDtM.SG741 do
    while not Eof do
    begin
      if (Parametri.DataLavoro >= FieldByName('DECORRENZA').AsDateTime)
      and (Parametri.DataLavoro <= FieldByName('DECORRENZA_FINE').AsDateTime) then
        Break;
      Next;
    end;
  C600frmSelAnagrafe.CreaSelAnagrafe(SessioneOracle,nil,0,False);
  C600frmSelAnagrafe.C600FSelezioneAnagrafe.OpenC600SelAnagrafe:=False;
  AbilitaComponenti;
end;

procedure TS740FRegoleValutazioni.sbtPathFilePDFClick(Sender: TObject);
begin
  with S740FRegoleValutazioniDtM do
  begin
    OpenDialog1.Title:='Scelta percorso iniziale dell''archivio delle schede in formato PDF';
    OpenDialog1.InitialDir:=SG741.FieldByName('PATH_FILEPDF').AsString;
    OpenDialog1.FileName:='x';
    OpenDialog1.Options:=[ofPathMustExist,ofHideReadOnly,ofEnableSizing];
    OpenDialog1.Filter:='Tutti i file (*.*)|*.*';
    if OpenDialog1.Execute then
      SG741.FieldByName('PATH_FILEPDF').AsString:=R180GetFilePath(OpenDialog1.FileName);
  end;
end;

procedure TS740FRegoleValutazioni.TAnnullaClick(Sender: TObject);
begin
  S740FRegoleValutazioniDtM.SG742.CancelUpdates;
  inherited;
end;

procedure TS740FRegoleValutazioni.DButtonDataChange(Sender: TObject;
  Field: TField);
begin
  inherited;
  AbilitaComponenti;
end;

procedure TS740FRegoleValutazioni.DButtonStateChange(Sender: TObject);
begin
  inherited;
  AbilitaComponenti;
end;

procedure TS740FRegoleValutazioni.btnSceltaCodiciTipoRapportoClick(
  Sender: TObject);
begin
  inherited;
  with S740FRegoleValutazioniDtM do
  begin
    C013FCheckList:=TC013FCheckList.Create(nil);
    try
      C013FCheckList.clbListaDati.Items.Assign(ListaCodiciTipoRapporto);
      R180PutCheckList(SG741.FieldByName('COD_TIPI_RAPPORTO').AsString,5,C013FCheckList.clbListaDati);
      if C013FCheckList.ShowModal = mrOK then
        SG741.FieldByName('COD_TIPI_RAPPORTO').AsString:=R180GetCheckList(5,C013FCheckList.clbListaDati);
    finally
      C013FCheckList.Free;
    end;
  end;
end;

procedure TS740FRegoleValutazioni.btnStoricizzaClick(Sender: TObject);
begin
  inherited;
  AbilitaComponenti;
end;

procedure TS740FRegoleValutazioni.btnDataDaClick(Sender: TObject);
var NomeCampo,Titolo:String;
begin
  if (Sender as TButton).Name = 'btnDataDaObiettivi' then
    NomeCampo:='DATA_DA_OBIETTIVI'
  else if (Sender as TButton).Name = 'btnDataAObiettivi' then
    NomeCampo:='DATA_A_OBIETTIVI';
  Titolo:=IfThen(Pos('DATA_DA',NomeCampo) > 0,'Data inizio periodo','Data fine periodo');
  with S740FRegoleValutazioniDtM do
  begin
    if SG741.FieldByName(NomeCampo).IsNull then
      SG741.FieldByName(NomeCampo).AsDateTime:=Parametri.DataLavoro;
    SG741.FieldByName(NomeCampo).AsDateTime:=DataOut(SG741.FieldByName(NomeCampo).AsDateTime,Titolo,'G');
  end;
end;

procedure TS740FRegoleValutazioni.btnPagineAbilitateClick(Sender: TObject);
begin
  inherited;
  with S740FRegoleValutazioniDtM do
  begin
    C013FCheckList:=TC013FCheckList.Create(nil);
    try
      C013FCheckList.clbListaDati.Items.Add('P0 Valutazione intermedia');
      C013FCheckList.clbListaDati.Items.Add('P1 Valutazioni complessive');
      C013FCheckList.clbListaDati.Items.Add('P2 Obiettivi pianificati');
      C013FCheckList.clbListaDati.Items.Add('P3 Proposte formative');
      C013FCheckList.clbListaDati.Items.Add('P4 Commenti valutato');
      C013FCheckList.clbListaDati.Items.Add('P5 Note');
      R180PutCheckList(SG741.FieldByName('PAGINE_ABILITATE').AsString,2,C013FCheckList.clbListaDati);
      if C013FCheckList.ShowModal = mrOK then
        SG741.FieldByName('PAGINE_ABILITATE').AsString:=R180GetCheckList(2,C013FCheckList.clbListaDati);
    finally
      C013FCheckList.Free;
    end;
  end;
end;

procedure TS740FRegoleValutazioni.dcbxDatoStampa1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
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

procedure TS740FRegoleValutazioni.dchkDescLunga1Click(Sender: TObject);
begin
  inherited;
  AbilitaComponenti;
end;

procedure TS740FRegoleValutazioni.drgpNumeroFirmeValutatoriClick(Sender: TObject);
begin
  inherited;
  AbilitaComponenti;
end;

procedure TS740FRegoleValutazioni.dedtFirma1Exit(Sender: TObject);
begin
  inherited;
  AbilitaComponenti;
end;

procedure TS740FRegoleValutazioni.C600frmSelAnagrafebtnSelezioneClick(Sender: TObject);
var S:String;
  function TrasformaV430(X:String):String;
  var Apice:Boolean;
      i:Integer;
  begin
    Result:='';
    i:=1;
    Apice:=False;
    while i <= Length(X) do
    begin
      if X[i] = '''' then
        Apice:=not Apice;
      if (not Apice) and (Copy(X,i,5) = 'V430.') then
      begin
        X:=Copy(X,1,i - 1) + Copy(X,i + 5,4) + '.' + Copy(X,i + 9,Length(X));
        inc(i,5);
      end;
      inc(i);
    end;
    Result:=X;
  end;
begin
  C600frmSelAnagrafe.C600DataDal:=R180AddMesi(S740FRegoleValutazioniDtM.SG741.FieldByName('DECORRENZA').AsDateTime,12) - 1;
  C600frmSelAnagrafe.C600DataLavoro:=C600frmSelAnagrafe.C600DataDal;
  C600frmSelAnagrafe.SelezionePeriodica:=False;
  C600frmSelAnagrafe.C600FSelezioneAnagrafe.grpSelezionePeriodica.ItemIndex:=0;
  C600frmSelAnagrafe.C600FSelezioneAnagrafe.chkCessati.Enabled:=False;
  C600frmSelAnagrafe.C600FSelezioneAnagrafe.chkCessati.Checked:=True;
  C600frmSelAnagrafe.btnSelezioneClick(nil);
  if C600frmSelAnagrafe.C600ModalResult = mrOK then
  begin
    S:=EliminaRitornoACapo(Trim(C600frmSelAnagrafe.C600FSelezioneAnagrafe.SQLCreato.Text));
    if Pos('ORDER BY',UpperCase(S)) > 0 then
      S:=Copy(S,1,Pos('ORDER BY',UpperCase(S)) - 1);
    S740FRegoleValutazioniDtM.SG741.FieldByName('FILTRO_ANAGRAFE').AsString:=S;
  end;
end;

procedure TS740FRegoleValutazioni.AbilitaComponenti;
var i:Integer;
begin
  C600frmSelAnagrafe.btnSelezione.Enabled:=DButton.State in [dsEdit,dsInsert];
  btnSceltaCodiciTipoRapporto.Enabled:=DButton.State in [dsEdit,dsInsert];
  sbtPathFilePDF.Enabled:=DButton.State in [dsEdit,dsInsert];
  btnPagineAbilitate.Enabled:=DButton.State in [dsEdit,dsInsert];
  grpPeriodoAssegnObiettivi.Enabled:=dchkAssegnPreventivaObiettivi.Checked;
  dedtDataDaObiettivi.Enabled:=grpPeriodoAssegnObiettivi.Enabled;
  dedtDataAObiettivi.Enabled:=grpPeriodoAssegnObiettivi.Enabled;
  btnDataDaObiettivi.Enabled:=DButton.State in [dsEdit,dsInsert];
  btnDataAObiettivi.Enabled:=DButton.State in [dsEdit,dsInsert];
  dchkAreaFormativaObbligatoria.Enabled:=dchkAbilitaAreeFormative.Checked;
  if not dchkAreaFormativaObbligatoria.Enabled then
    dchkAreaFormativaObbligatoria.Checked:=False;
  try
    drgpAbilitaCommentiValutato.Controls[0].Enabled:=True;
    drgpAbilitaCommentiValutato.Controls[1].Enabled:=True;
    drgpAbilitaCommentiValutato.Controls[2].Enabled:=dchkAbilitaAccettazioneValutato.Checked;
    drgpAbilitaCommentiValutato.Controls[3].Enabled:=dchkAbilitaAccettazioneValutato.Checked;
    // verifica che l'item attualmente selezionato sia abilitato
    i:=drgpAbilitaCommentiValutato.Values.IndexOf(drgpAbilitaCommentiValutato.DataSource.DataSet.FieldByName(drgpAbilitaCommentiValutato.DataField).AsString);
    if (drgpAbilitaCommentiValutato.ItemIndex = i)
    and (not drgpAbilitaCommentiValutato.Controls[i].Enabled) then
      // seleziona il primo radiobutton abilitato nell'ordine
      for i:=0 to drgpAbilitaCommentiValutato.Items.Count - 1 do
        if drgpAbilitaCommentiValutato.Controls[i].Enabled then
        begin
          drgpAbilitaCommentiValutato.ItemIndex:=i;
          Break;
        end;
  except
  end;
  dcbxDatoStampa2.Enabled:=not dchkDescLunga1.Checked;
  dcbxDatoStampa4.Enabled:=not dchkDescLunga3.Checked;
  if dchkStampaVariazioni5.Checked then
    dchkDescLunga5.Checked:=True;
  dchkDescLunga5.Enabled:=not dchkStampaVariazioni5.Checked;
  dcbxDatoStampa6.Enabled:=not dchkDescLunga5.Checked;
  clbCampiOpzionaliStampa.Enabled:=DButton.State in [dsEdit,dsInsert];
  clbCampiOpzionaliCompilazione.Enabled:=DButton.State in [dsEdit,dsInsert];
  if not (DButton.State in [dsEdit,dsInsert]) then
    for i:=1 to clbCampiOpzionaliStampa.Items.Count do
    begin
      clbCampiOpzionaliStampa.Checked[i - 1]:=R180InConcat(IntToStr(i),S740FRegoleValutazioniDtM.SG741.FieldByName('CAMPI_OPZIONALI_STAMPA').AsString);
      clbCampiOpzionaliCompilazione.Checked[i - 1]:=R180InConcat(IntToStr(i),S740FRegoleValutazioniDtM.SG741.FieldByName('CAMPI_OPZIONALI_COMPILAZIONE').AsString);
    end;
end;

end.
