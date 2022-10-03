unit A008UAziende;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  R001UGESTTAB, A000UMessaggi, DB, Menus, Buttons, ExtCtrls, ComCtrls, StdCtrls, DBCtrls,
  Mask, Grids, DBGrids, checklst, ActnList, ImgList, ToolWin, Variants,
  A000UCostanti, A000USessione, C180FunzioniGenerali, L021Call, C012UVisualizzaTesto,
  Oracle, OracleData, A008UIterCondizValidita, idSMTP, idMessage, System.Actions,
  medpSendMail, System.ImageList;

type
  TA008FAziende = class(TR001FGestTab)
    ScrollBox1: TScrollBox;
    Label1: TLabel;
    DBEdit1: TDBEdit;
    Label3: TLabel;
    DBEdit3: TDBEdit;
    Label4: TLabel;
    DBEdit4: TDBEdit;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    DBGrid1: TDBGrid;
    Panel3: TPanel;
    Label2: TLabel;
    DBEdit2: TDBEdit;
    Panel2: TPanel;
    GroupBox4: TGroupBox;
    Label5: TLabel;
    dedtLungPassword: TDBEdit;
    dedtValidPassword: TDBEdit;
    Label8: TLabel;
    dedtValidUtente: TDBEdit;
    Label11: TLabel;
    Panel4: TPanel;
    Label13: TLabel;
    dedtPathAllClient: TDBEdit;
    btnPathAllClient: TButton;
    OpenDialog1: TOpenDialog;
    Label14: TLabel;
    dedtDominioDip: TDBEdit;
    Label15: TLabel;
    dedtDominioUsr: TDBEdit;
    dcmbDominioDipTipo: TDBComboBox;
    dcmbDominioUsrTipo: TDBComboBox;
    pnlTopGestModuli: TPanel;
    cmbFiltroGestModuli: TComboBox;
    lblFiltroGestModuli: TLabel;
    dedtValidCifre: TDBEdit;
    lblValidCifre: TLabel;
    dedtValidMaiuscole: TDBEdit;
    lblValidMaiuscole: TLabel;
    lblValidCarattSpeciali: TLabel;
    dedtValidCarattSpeciali: TDBEdit;
    GroupBox2: TGroupBox;
    DBCheckBox2: TDBCheckBox;
    DBCheckBox3: TDBCheckBox;
    GroupBox1: TGroupBox;
    Label9: TLabel;
    Label10: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label12: TLabel;
    DBEdit9: TDBEdit;
    DBEdit10: TDBEdit;
    DBEdit5: TDBEdit;
    DBEdit6: TDBEdit;
    DBEdit7: TDBEdit;
    DBCheckBox4: TDBCheckBox;
    lblGruppoBadge: TLabel;
    dedtGruppoBadge: TDBEdit;
    btnTestMail: TSpeedButton;
    grpRicAziendaAuto: TGroupBox;
    dchkLoginUsrAbilitato: TDBCheckBox;
    dchkLoginDipAbilitato: TDBCheckBox;
    tabRegistrazioneLog: TTabSheet;
    GroupBox3: TGroupBox;
    TabelleLog: TCheckListBox;
    DBCheckBox1: TDBCheckBox;
    pmnLogOperazioni: TPopupMenu;
    Selezionatutto1: TMenuItem;
    Annullatutto1: TMenuItem;
    Invertiselezione1: TMenuItem;
    procedure btnPathAllClientClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure DBGrid1EditButtonClick(Sender: TObject);
    procedure DBCheckBox1Click(Sender: TObject);
    procedure DButtonStateChange(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure TGommaClick(Sender: TObject);
    procedure cmbCodiceIterDrawItem(Control: TWinControl; Index: Integer; Rect: TRect; State: TOwnerDrawState);
    procedure cmbCodiceIterChange(Sender: TObject);
    procedure cmbFiltroGestModuliChange(Sender: TObject);
    procedure btnTestMailClick(Sender: TObject);
    procedure PageControl1Change(Sender: TObject);
    procedure TCancClick(Sender: TObject);
    procedure OnPmnLogOperazioniClick(Sender: TObject);
  private
    procedure PutElenco(S:String);
    procedure CaricaCmbFiltroGestModuli;
    procedure AbilitaAzioni;
  public
    procedure EditaCampoMemo(var InDBGrid:TDBGrid;NomeCampo:String);
  end;

var
  A008FAziende: TA008FAziende;

implementation

uses A008UOperatoriDtM1, A008UListaGriglia, A000UInterfaccia;

{$R *.DFM}

procedure TA008FAziende.FormCreate(Sender: TObject);
begin
  inherited;
  PageControl1.ActivePage:=TabSheet1;
  dedtValidCarattSpeciali.Hint:='Caratteri speciali considerati: ' + SPECIAL_CHAR;
  lblValidCarattSpeciali.Hint:='Caratteri speciali considerati: ' + SPECIAL_CHAR;
  //tabIterAutorizzativi.TabVisible:=ITER_ATTIVO = 'S';
end;

procedure TA008FAziende.FormActivate(Sender: TObject);
begin
  DButton.DataSet:=A008FOperatoriDtM1.QI090;
  inherited;
end;

procedure TA008FAziende.DBGrid1EditButtonClick(Sender: TObject);
var
  i: Integer;
  S: String;
begin
  if DButton.State <> dsEdit then
    exit;
  if A008FOperatoriDtM1.QI091.State = dsEdit then
    A008FOperatoriDtM1.QI091.Cancel;
  A008FListaGriglia:=TA008FListaGriglia.Create(nil);
  PutElenco(A008FOperatoriDtM1.QI091Tipo.AsString);
  with A008FListaGriglia do
    try
      Caption:=A008FOperatoriDtM1.QI091D_Tipo.AsString;
      if ShowModal = mrOk then
      begin
        S:='';
        if Lista.MultiSelect then
        begin
          // selezione multipla
          for i:=0 to Lista.Count - 1 do
            if Lista.Selected[i] then
              S:=S + Lista.Items[i] + ',';
          if S <> '' then
            S:=Copy(S,1,Length(S) - 1);
        end
        else if Lista.ItemIndex >= 0 then
        begin
          // selezione singola
          S:=Lista.Items[Lista.ItemIndex];
        end;
        if S <> '' then
        begin
          with A008FOperatoriDtM1.QI091 do
          begin
            Edit;
            FieldByName('DATO').AsString:=S;
            Post;
          end;
        end;
      end;
    finally
      Release;
    end;
end;

procedure TA008FAziende.PutElenco(S:String);
var i,j:Integer;
begin
  A008FListaGriglia.Lista.Items.BeginUpdate;
  A008FListaGriglia.Lista.Items.Clear;
  for i:=1 to High(DatiEnte) do
    if S = DatiEnte[i].Nome then
    begin
      (*
      if DatiEnte[i].Lista = 'SN' then
      begin
        A008FListaGriglia.Lista.Items.Add('S');
        A008FListaGriglia.Lista.Items.Add('N');
      end
      else*)
      if DatiEnte[i].Lista = 'OFFICE' then
      begin
        A008FListaGriglia.Lista.Items.Add('MICROSOFT OFFICE');
        A008FListaGriglia.Lista.Items.Add('OPEN OFFICE');
      end
      (*
      else if DatiEnte[i].Lista = 'ICE' then
      begin
        A008FListaGriglia.Lista.Items.Add('I'); // I=Inversione giorno
        A008FListaGriglia.Lista.Items.Add('C'); // C=Cambio orario
        A008FListaGriglia.Lista.Items.Add('E'); // E=Inversione giorno e cambio orario
      end
      else if DatiEnte[i].Lista = 'NFT' then
      begin
        A008FListaGriglia.Lista.Items.Add('N');
        A008FListaGriglia.Lista.Items.Add('F');
        A008FListaGriglia.Lista.Items.Add('T');
      end
      else if DatiEnte[i].Lista = 'NOF' then
      begin
        A008FListaGriglia.Lista.Items.Add('N');
        A008FListaGriglia.Lista.Items.Add('O');
        A008FListaGriglia.Lista.Items.Add('F');
      end
      else if DatiEnte[i].Lista = 'SNL' then
      begin
        A008FListaGriglia.Lista.Items.Add('S');
        A008FListaGriglia.Lista.Items.Add('N');
        A008FListaGriglia.Lista.Items.Add('L');
      end
      *)
      else if DatiEnte[i].Lista = 'C11_MODORA_PUNTNOM' then
      begin
        A008FListaGriglia.Lista.Items.Add('MODELLO ORARIO');
        A008FListaGriglia.Lista.Items.Add('PUNTI NOMINALI');
      end
      {else if DatiEnte[i].Lista = 'C11_OPE_NOOPE' then
      begin}
        {Se il tipo pianificazione è progressiva disabilito la possibilità
        di selezionare la gestione assenze operativa
        {Bruno 07/05/2014 -  if VarToStr(A008FOperatoriDtM1.QI091.Lookup('TIPO','C11_PIANIFORARIPROG','DATO')) = 'N' then}
        {A008FListaGriglia.Lista.Items.Add('OPERATIVA');
        A008FListaGriglia.Lista.Items.Add('NON OPERATIVA');
      end}
      else if DatiEnte[i].Lista = 'C11_NO_SOVR_AGG' then
      begin
        A008FListaGriglia.Lista.Items.Add('NO');
        A008FListaGriglia.Lista.Items.Add('SOVRASCRIVI');
        A008FListaGriglia.Lista.Items.Add('AGGIUNGI');
      end
      else if DatiEnte[i].Lista = 'C90_AUTENTICAZIONI' then
      begin
        A008FListaGriglia.Lista.Items.Add('No autenticazione');
        A008FListaGriglia.Lista.Items.Add('TLSv1');
        A008FListaGriglia.Lista.Items.Add('TLSv1_1');
        A008FListaGriglia.Lista.Items.Add('TLSv1_2');
        A008FListaGriglia.Lista.Items.Add('SSLv2');
        A008FListaGriglia.Lista.Items.Add('SSLv23');
        A008FListaGriglia.Lista.Items.Add('SSLv3');
      end
      else if DatiEnte[i].Lista = 'C90_USETLS' then
      begin
        A008FListaGriglia.Lista.Items.Add('NO');
        A008FListaGriglia.Lista.Items.Add('IMPLICIT');
        A008FListaGriglia.Lista.Items.Add('EXPLICIT');
        A008FListaGriglia.Lista.Items.Add('REQUIRE');
      end
      else if DatiEnte[i].Lista = 'C3_INDPRES' then
        with A008FOperatoriDtM1.QI091 do
        begin
          if VarToStr(Lookup('Tipo','C3_INDPRES','Dato')) <> '' then
            A008FListaGriglia.Lista.Items.Add(VarToStr(Lookup('Tipo','C3_INDPRES','Dato')));
          if VarToStr(Lookup('Tipo','C3_INDPRES2','Dato')) <> '' then
            A008FListaGriglia.Lista.Items.Add(VarToStr(Lookup('Tipo','C3_INDPRES2','Dato')));
        end
      else if (DatiEnte[i].Lista = 'T430') or (DatiEnte[i].Lista = 'T430_MULTI') then
      begin
        with A008FOperatoriDtM1.QCols do
        begin
          First;
          while not Eof do
          begin
            A008FListaGriglia.Lista.Items.Add(FieldByName('COLUMN_NAME').AsString);
            Next;
          end;
        end;
        A008FListaGriglia.Lista.MultiSelect:=(DatiEnte[i].Lista = 'T430_MULTI'); // nuovo 27.06.2012
        A008FListaGriglia.Lista.ExtendedSelect:=A008FListaGriglia.Lista.MultiSelect;
      end
      else if DatiEnte[i].Lista = 'T275' then
      begin
        // sfrutta la query selDizionario per estrarre l'elenco delle causali di presenza
        with A008FOperatoriDtM1.selDizionario do
        begin
          Filtered:=False;
          Filter:='TABELLA = ''CAUSALI PRESENZA''';
          Filtered:=True;
          First;
          A008FListaGriglia.Lista.Items.Add('');
          while not Eof do
          begin
            A008FListaGriglia.Lista.Items.Add(FieldByName('CODICE').AsString);
            Next;
          end;
        end;
      end
      (*
      else if DatiEnte[i].Lista = 'RA' then
      begin
        A008FListaGriglia.Lista.Items.Add('R');
        A008FListaGriglia.Lista.Items.Add('A');
      end
      *)
      else if DatiEnte[i].Lista = 'EUT' then
      begin
        A008FListaGriglia.Lista.Items.Add('E');
        A008FListaGriglia.Lista.Items.Add('U');
        A008FListaGriglia.Lista.Items.Add('EU');
        A008FListaGriglia.Lista.Items.Add('T');
      end
      (*
      else if DatiEnte[i].Lista = 'TP' then
      begin
        A008FListaGriglia.Lista.Items.Add('T');
        A008FListaGriglia.Lista.Items.Add('P');
      end
      else if DatiEnte[i].Lista = 'NA' then
      begin
        A008FListaGriglia.Lista.Items.Add('N');
        A008FListaGriglia.Lista.Items.Add('A');
      end
      *)
      else
      begin
        for j:=1 to Length(DatiEnte[i].Lista) do
          A008FListaGriglia.Lista.Items.Add(DatiEnte[i].Lista[j]);
      end;

      A008FListaGriglia.Lista.Items.EndUpdate;
      Break;
    end;
end;

procedure TA008FAziende.OnPmnLogOperazioniClick(Sender: TObject);
var
  i:Integer;
begin
  if DButton.State in [dsInsert,dsEdit] then
  begin
  for i:=0 to TabelleLog.Items.Count - 1 do
    if Sender = Selezionatutto1 then
      TabelleLog.Checked[i]:=True
    else if Sender = Annullatutto1 then
      TabelleLog.Checked[i]:=False
    else if Sender = Invertiselezione1 then
      TabelleLog.Checked[i]:=not TabelleLog.Checked[i];
  end;
end;

procedure TA008FAziende.CaricaCmbFiltroGestModuli;
var i:Integer;
begin
  cmbFiltroGestModuli.Items.Clear;
  cmbFiltroGestModuli.Items.Add('');
  for i:=Low(DatiEnte) to High(DatiEnte) do
    if cmbFiltroGestModuli.Items.IndexOf(DatiEnte[i].Gruppo) < 0 then
      cmbFiltroGestModuli.Items.Add(DatiEnte[i].Gruppo);
  if cmbFiltroGestModuli.Items.IndexOf(A008FOperatoriDtM1.A181MW.NON_ASSEGNATO) < 0 then
    cmbFiltroGestModuli.Items.Add(A008FOperatoriDtM1.A181MW.NON_ASSEGNATO);
  cmbFiltroGestModuli.Sorted:=True;
end;

procedure TA008FAziende.AbilitaAzioni;
begin
  actCancella.Enabled:=(DButton.State = dsBrowse) and not(SolaLettura) and (PageControl1.ActivePageIndex = 0);
  TCanc.Enabled:=(DButton.State  = dsBrowse) and not(SolaLettura) and (PageControl1.ActivePageIndex = 0);
  actInserisci.Enabled:=(DButton.State  = dsBrowse) and not(SolaLettura) and (PageControl1.ActivePageIndex = 0);
  TInser.Enabled:=(DButton.State  = dsBrowse) and not(SolaLettura) and (PageControl1.ActivePageIndex = 0);
end;

procedure TA008FAziende.TCancClick(Sender: TObject);
var iAzienda,dsAzienda:String;
begin
  if PageControl1.ActivePageIndex > 0 then
    Exit;
  dsAzienda:=A008FOperatoriDtM1.QI090.FieldByName('AZIENDA').AsString;
  if (dsAzienda <> 'AZIN') then
  begin
    if Parametri.Azienda <> dsAzienda then
    begin
      iAzienda:=Dialogs.InputBox('Cancellazione azienda ' + dsAzienda,
                                 Format(A000MSG_A008_DLG_FMT_CANC_AZ_PROMPT,[dsAzienda]),
                                 '');
      if iAzienda = dsAzienda then
      begin
        if Dialogs.MessageDlg(Format(A000MSG_A008_MSG_FMT_CANC_AZ_AVVISO,[dsAzienda]),
                              mtWarning,[mbYes,mbNo],0) = mrYes then
          inherited
        else
          raise Exception.Create(Format(A000MSG_A008_ERR_FMT_CANC_AZIENDA,[dsAzienda]));
      end
      else
        raise Exception.Create(Format(A000MSG_A008_ERR_FMT_CANC_AZIENDA,[dsAzienda]));
    end
    else
      raise Exception.Create(A000MSG_A008_ERR_NO_CANC_AZIENDA_CORR);
  end
  else
    raise Exception.Create(A000MSG_A008_ERR_NO_CANC_AZIN);
end;

procedure TA008FAziende.TGommaClick(Sender: TObject);
var StatoPrec:Boolean;
begin
  StatoPrec:=A008FOperatoriDtm1.QI091.FieldByName('DATO').ReadOnly;
  A008FOperatoriDtm1.QI091.FieldByName('DATO').ReadOnly:=False;
  inherited;
  A008FOperatoriDtm1.QI091.FieldByName('DATO').ReadOnly:=StatoPrec;
end;

procedure TA008FAziende.DBCheckBox1Click(Sender: TObject);
begin
  TabelleLog.Enabled:=(DButton.State in [dsEdit,dsInsert]) and DbCheckBox1.Checked;
end;

procedure TA008FAziende.DButtonStateChange(Sender: TObject);
begin
  inherited;
  TabelleLog.Enabled:=(DButton.State in [dsEdit,dsInsert]) and DbCheckBox1.Checked;
  btnPathAllClient.Enabled:=DButton.State in [dsEdit,dsInsert];
  //cmbFiltroGestModuli.Enabled:=DButton.State = dsBrowse;
  AbilitaAzioni;
end;

procedure TA008FAziende.EditaCampoMemo(var InDBGrid:TDBGrid;NomeCampo:String);
var
  Str:TStringList;
  SolaLettura:Boolean;
  CaptionC012:String;
  BottoniC012:TMsgDlgButtons;
begin
  if InDBGrid.SelectedField.FieldName = NomeCampo then
  begin
    Str:=TStringList.Create;
    try
      SolaLettura:=TOracleDataSet(InDBGrid.DataSource.DataSet).ReadOnly or
                   InDBGrid.SelectedField.ReadOnly; // bugfix
      CaptionC012:=InDBGrid.SelectedField.DisplayLabel;
      BottoniC012:=[mbOK,mbCancel];
      if SolaLettura then
      begin
        CaptionC012:=InDBGrid.SelectedField.DisplayLabel + ' (Sola lettura)';
        BottoniC012:=[mbCancel];
      end;
      Str.Text:=InDBGrid.DataSource.DataSet.FieldByName(NomeCampo).AsString;
      OpenC012VisualizzaTesto(CaptionC012,'',Str,'',BottoniC012);
      if not SolaLettura then
      begin
        InDBGrid.DataSource.DataSet.Edit;
        InDBGrid.DataSource.DataSet.FieldByName(NomeCampo).AsString:=Trim(Str.Text);
        InDBGrid.DataSource.DataSet.Post
      end;
    finally
      FreeAndNil(Str);
    end;
  end;
end;

procedure TA008FAziende.FormShow(Sender: TObject);
begin
  with A008FOperatoriDtM1 do
  begin
    QI090.AfterScroll:=A008FOperatoriDtM1.QI090AfterScroll;
    QI090AfterScroll(A008FOperatoriDtM1.QI090);
  end;
  CaricaCmbFiltroGestModuli;
end;

procedure TA008FAziende.PageControl1Change(Sender: TObject);
begin
  AbilitaAzioni;
end;

procedure TA008FAziende.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  if Action in [caHide,caFree] then
    A008FOperatoriDtM1.QI090.AfterScroll:=nil;
end;

procedure TA008FAziende.btnPathAllClientClick(Sender: TObject);
begin
  inherited;
  if OpenDialog1.Execute then
    A008FOperatoriDtM1.QI090.FieldByName('PATHALLCLIENT').AsString:=R180GetFilePath(OpenDialog1.FileName);
end;

procedure TA008FAziende.btnTestMailClick(Sender: TObject);
var
  MyAddress, Err:String;
begin
  inherited;
  with TmedpSendMail.Create do
    try
      Err:=ConnettiSMTP;
      if Err.Trim.IsEmpty and InputQuery('Indirizzo E-Mail','',MyAddress) then
        Err:=Invia(MyAddress,'Test invio E-Mail','');
      if not Err.IsEmpty then
        raise Exception.Create(Err);
    finally
      Free;
    end;
end;

procedure TA008FAziende.cmbCodiceIterChange(Sender: TObject);
begin
  inherited;
  with A008FOperatoriDtm1 do
  begin
    cdsI096LookUp.Filtered:=False;
  end;
end;

procedure TA008FAziende.cmbCodiceIterDrawItem(Control: TWinControl; Index: Integer; Rect: TRect; State: TOwnerDrawState);
begin
  inherited;
  if Index = 0 then
    (Control as TComboBox).Canvas.TextRect(Rect,Rect.Left + 2,Rect.Top,'Tutti')
  else
    (Control as TComboBox).Canvas.TextRect(Rect,Rect.Left + 2,Rect.Top,A000IterAutorizzativi[Index - 1].Desc);
end;

procedure TA008FAziende.cmbFiltroGestModuliChange(Sender: TObject);
begin
  inherited;
  with A008FOperatoriDtM1 do
  begin
    A181MW.GruppoFiltroI091:=cmbFiltroGestModuli.Text;
    QI091.Filtered:=True;
  end;
end;

end.
