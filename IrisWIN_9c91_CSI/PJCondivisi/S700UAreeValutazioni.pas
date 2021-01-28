unit S700UAreeValutazioni;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, R004UGestStorico, ActnList, ImgList, DB, Menus, StdCtrls, ComCtrls,
  ToolWin, Grids, DBGrids, DBCtrls, Buttons, Mask, C180FunzioniGenerali, A000UCostanti, A000USessione,
  A000UInterfaccia, A003UDataLavoroBis, Oracle, OracleData, ToolbarFiglio, Math,
  ExtCtrls, C013UCheckList, C015UElencoValori, System.Actions;

type
  TS700FAreeValutazioni = class(TR004FGestStorico)
    pnlTestata: TPanel;
    lblCodiceArea: TLabel;
    lblDescrizione: TLabel;
    dedtCodArea: TDBEdit;
    dedtDescrizione: TDBEdit;
    pnlDettaglio: TPanel;
    frmToolbarFiglio: TfrmToolbarFiglio;
    gpbDettaglio: TGroupBox;
    dgrdDettaglio: TDBGrid;
    drgpTipoPunteggioItems: TDBRadioGroup;
    drgpTipoPesoPercentuale: TDBRadioGroup;
    lblItemPersonalizzati: TLabel;
    lblItemPersonalizzatiMax: TLabel;
    dedtItemPersonalizzatiMin: TDBEdit;
    dedtItemPersonalizzatiMax: TDBEdit;
    lblItemPersonalizzatiMin: TLabel;
    dchkItemTuttiValutabili: TDBCheckBox;
    dchkTipoLinkItem: TDBRadioGroup;
    gpbStatiAvanzamento: TGroupBox;
    lblStatiAbilitatiElementi: TLabel;
    dedtStatiAbilitatiElementi: TDBEdit;
    btnStatiAbilitatiElementi: TButton;
    lblStatiAbilitatiPunteggi: TLabel;
    dedtStatiAbilitatiPunteggi: TDBEdit;
    btnStatiAbilitatiPunteggi: TButton;
    dmemTestoItemPersonalizzati: TDBMemo;
    lblTestoItemPersonalizzati: TLabel;
    gpbPesoItems: TGroupBox;
    dchkPesoVariabileItems: TDBCheckBox;
    dchkPesoEquoItems: TDBCheckBox;
    lblPesoPercentuale: TLabel;
    dedtPesoPercentuale: TDBEdit;
    lblPesoPercMin: TLabel;
    dedtPesoPercMin: TDBEdit;
    lblPesoPercMax: TLabel;
    dedtPesoPercMax: TDBEdit;
    dchkPunteggiSoloItemValutabili: TDBCheckBox;
    procedure TCancClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure DButtonStateChange(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Stampa1Click(Sender: TObject);
    procedure dchkPesoVariabileItemsClick(Sender: TObject);
    procedure btnStatiAbilitatiPunteggiClick(Sender: TObject);
    procedure dedtItemPersonalizzatiMaxChange(Sender: TObject);
    procedure frmToolbarFiglioactTFCancellaExecute(Sender: TObject);
    procedure frmToolbarFiglioactTFAnnullaExecute(Sender: TObject);
    procedure frmToolbarFiglioactTFConfermaExecute(Sender: TObject);
    procedure drgpTipoPesoPercentualeChange(Sender: TObject);
    procedure dchkTipoLinkItemChange(Sender: TObject);
    procedure dgrdDettaglioEditButtonClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure dchkPesoEquoItemsClick(Sender: TObject);
    procedure dedtPesoPercentualeChange(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure AbilitaComponenti;
  end;

var
  S700FAreeValutazioni: TS700FAreeValutazioni;

procedure OpenS700FAreeValutazioni(Data:TDateTime; Area,Valutazione:String);

implementation

uses S700UAreeValutazioniDtM;

{$R *.dfm}

procedure OpenS700FAreeValutazioni(Data:TDateTime; Area,Valutazione:String);
begin
  SolaLetturaOriginale:=SolaLettura;
  SolaLettura:=False;
  case A000GetInibizioni('Funzione','OpenS700FAreeValutazioni') of
    'N':begin
        ShowMessage('Funzione non abilitata!');
        Exit;
        end;
    'R':SolaLettura:=True;
  end;
  Application.CreateForm(TS700FAreeValutazioni, S700FAreeValutazioni);
  Application.CreateForm(TS700FAreeValutazioniDtM, S700FAreeValutazioniDtM);
  with S700FAreeValutazioniDtM.selSG701 do
  begin
    if RecordCount > 0 then
      SearchRecord('COD_AREA',Area,[srFromBeginning]);
    while (FieldByName('COD_AREA').AsString = Area) and not Eof do
    begin
      if  (Data >= FieldByName('DECORRENZA').AsDateTime)
      and (Data <= FieldByName('DECORRENZA_FINE').AsDateTime) then
        Break;
      Next;
    end;
  end;
  if S700FAreeValutazioniDtM.selSG700.Active then
    S700FAreeValutazioniDtM.selSG700.SearchRecord('COD_VALUTAZIONE',Valutazione,[srFromBeginning]);
  try
    Screen.Cursor:=crDefault;
    S700FAreeValutazioni.ShowModal;
  finally
    SolaLettura:=SolaLetturaOriginale;
    S700FAreeValutazioni.Free;
    S700FAreeValutazioniDtM.Free;
  end;
end;

procedure TS700FAreeValutazioni.FormShow(Sender: TObject);
begin
  inherited;
  frmToolbarFiglio.TFDButton:=S700FAreeValutazioniDtM.dsrSG700;
  frmToolbarFiglio.TFDBGrid:=dgrdDettaglio;
  SetLength(frmToolbarFiglio.lstLock,4);
  frmToolbarFiglio.lstLock[0]:=ToolBar1;
  frmToolbarFiglio.lstLock[1]:=grbDecorrenza;
  frmToolbarFiglio.lstLock[2]:=File1;
  frmToolbarFiglio.lstLock[3]:=Strumenti1;
  frmToolbarFiglio.AbilitaAzioniTF(nil);
  SetTabelleRelazionate([S700FAreeValutazioniDtM.selSG701,S700FAreeValutazioniDtM.selSG700]);
//  NumRecords;
  AbilitaComponenti;
end;

procedure TS700FAreeValutazioni.frmToolbarFiglioactTFAnnullaExecute(Sender: TObject);
begin
  inherited;
  frmToolbarFiglio.actTFAnnullaExecute(Sender);
  try
    S700FAreeValutazioniDtM.RicalcolaPesoArea;
  except
    on E:exception do
    begin
      ShowMessage(E.Message);
      frmToolbarFiglio.actTFModificaExecute(frmToolbarFiglio.actTFModifica);
    end;
  end;
end;

procedure TS700FAreeValutazioni.frmToolbarFiglioactTFCancellaExecute(Sender: TObject);
begin
  inherited;
  frmToolbarFiglio.actTFCancellaExecute(Sender);
  try
    S700FAreeValutazioniDtM.RicalcolaPesoArea;
  except
    on E:exception do
    begin
      ShowMessage(E.Message);
      frmToolbarFiglio.actTFModificaExecute(frmToolbarFiglio.actTFModifica);
    end;
  end;
end;

procedure TS700FAreeValutazioni.frmToolbarFiglioactTFConfermaExecute(Sender: TObject);
begin
  inherited;
  frmToolbarFiglio.actTFConfermaExecute(Sender);
  try
    S700FAreeValutazioniDtM.RicalcolaPesoArea;
  except
    on E:exception do
    begin
      ShowMessage(E.Message);
      frmToolbarFiglio.actTFModificaExecute(frmToolbarFiglio.actTFModifica);
    end;
  end;
end;

procedure TS700FAreeValutazioni.Stampa1Click(Sender: TObject);
begin
  QueryStampa.Clear;
  QueryStampa.Add('SELECT t1.cod_area, t1.descrizione, t1.decorrenza, t1.decorrenza_fine, t1.peso_percentuale,');
  QueryStampa.Add('       t1.peso_variabile_items, t1.tipo_punteggio_items,');
  QueryStampa.Add('       t2.cod_valutazione, t2.descrizione');
  QueryStampa.Add('FROM   sg701_aree_valutazioni t1, sg700_valutazioni t2');
  QueryStampa.Add('WHERE  t1.cod_area = t2.cod_area (+)');
  QueryStampa.Add('AND    t1.decorrenza = t2.decorrenza (+)');
  NomiCampiR001.Clear;
  NomiCampiR001.Add('t1.cod_area');
  NomiCampiR001.Add('t1.descrizione');
  NomiCampiR001.Add('t1.decorrenza');
  NomiCampiR001.Add('t1.decorrenza_fine');
  NomiCampiR001.Add('t1.peso_percentuale');
  NomiCampiR001.Add('t1.peso_variabile_items');
  NomiCampiR001.Add('t1.tipo_punteggio_items');
  NomiCampiR001.Add('t2.cod_valutazione');
  NomiCampiR001.Add('t2.descrizione');
  inherited;
end;

procedure TS700FAreeValutazioni.btnStatiAbilitatiPunteggiClick(Sender: TObject);
begin
  C013FCheckList:=TC013FCheckList.Create(nil);
  try
    with C013FCheckList do
    begin
      with S700FAreeValutazioniDtM.selSG746 do
      begin
        Open;
        while not Eof do
        begin
          clbListaDati.Items.Add(Format('%-7s %s',[FieldByName('CODREGOLA').AsString + '.' + IntToStr(FieldByName('CODICE').AsInteger),FieldByName('DESCRIZIONE').AsString]));
          Next;
        end;
        Close;
      end;
      if Sender = btnStatiAbilitatiPunteggi then
        R180PutCheckList(dedtStatiAbilitatiPunteggi.Text,7,clbListaDati)
      else
        R180PutCheckList(dedtStatiAbilitatiElementi.Text,7,clbListaDati);
      ShowModal;
    end;
  finally
    if Sender = btnStatiAbilitatiPunteggi then
      S700FAreeValutazioniDtM.selSG701.FieldByName('STATI_ABILITATI_PUNTEGGI').AsString:=Trim(R180GetCheckList(7,C013FCheckList.clbListaDati))
    else
      S700FAreeValutazioniDtM.selSG701.FieldByName('STATI_ABILITATI_ELEMENTI').AsString:=Trim(R180GetCheckList(7,C013FCheckList.clbListaDati));
    FreeAndNil(C013FCheckList);
  end;
end;

procedure TS700FAreeValutazioni.DButtonStateChange(Sender: TObject);
begin
  inherited;
  AbilitaComponenti;
end;

procedure TS700FAreeValutazioni.dchkPesoEquoItemsClick(Sender: TObject);
begin
  inherited;
  with S700FAreeValutazioniDtM.selSG701 do
    if State in [dsInsert,dsEdit] then
      if (StrToIntDef(dedtItemPersonalizzatiMax.Text,0) > 0) then
      begin
        if dchkPesoEquoItems.Checked then
          FieldByName('PESO_VARIABILE_ITEMS').AsString:='N'
        else
          FieldByName('PESO_VARIABILE_ITEMS').AsString:='S';
      end;
  AbilitaComponenti;
end;

procedure TS700FAreeValutazioni.dchkPesoVariabileItemsClick(Sender: TObject);
begin
  inherited;
  with S700FAreeValutazioniDtM.selSG701 do
    if State in [dsEdit,dsInsert] then
      if dchkPesoVariabileItems.Checked then
        FieldByName('PESO_EQUO_ITEMS').AsString:='N'
      else
      begin
        FieldByName('PESO_PERC_MIN').AsString:=FieldByName('PESO_PERCENTUALE').AsString;
        FieldByName('PESO_PERC_MAX').AsString:=FieldByName('PESO_PERCENTUALE').AsString;
        if (StrToIntDef(dedtItemPersonalizzatiMax.Text,0) > 0) then
          FieldByName('PESO_EQUO_ITEMS').AsString:='S';
        if (FieldByName('PESO_PERCENTUALE').AsFloat = 0)
        and (   (StrToIntDef(dedtItemPersonalizzatiMax.Text,0) > 0)
             or (    S700FAreeValutazioniDtM.selSG700.Active
                 and (S700FAreeValutazioniDtM.selSG700.RecordCount > 0))) then
          FieldByName('ITEM_TUTTI_VALUTABILI').AsString:='S';
      end;
  AbilitaComponenti;
end;

procedure TS700FAreeValutazioni.dchkTipoLinkItemChange(Sender: TObject);
begin
  inherited;
  with S700FAreeValutazioniDtM.selSG701 do
    if State in [dsInsert,dsEdit] then
    begin
      if dchkTipoLinkItem.ItemIndex = 1 then
      begin
        FieldByName('ITEM_PERSONALIZZATI_MIN').AsInteger:=0;
        FieldByName('ITEM_PERSONALIZZATI_MAX').AsInteger:=0;
        FieldByName('ITEM_TUTTI_VALUTABILI').AsString:='S';
        FieldByName('PUNTEGGI_SOLO_ITEM_VALUTABILI').AsString:='S';
        FieldByName('PESO_VARIABILE_ITEMS').AsString:='N';
        FieldByName('PESO_EQUO_ITEMS').AsString:='S';
        FieldByName('TIPO_PUNTEGGIO_ITEMS').AsString:='1';
        FieldByName('TESTO_ITEM_PERSONALIZZATI').AsString:='';
        FieldByName('STATI_ABILITATI_ELEMENTI').AsString:='';
        FieldByName('STATI_ABILITATI_PUNTEGGI').AsString:='';
      end
      else if dchkTipoLinkItem.ItemIndex = 2 then
      begin
        FieldByName('ITEM_PERSONALIZZATI_MIN').AsInteger:=0;
        FieldByName('ITEM_PERSONALIZZATI_MAX').AsInteger:=0;
        FieldByName('TIPO_PUNTEGGIO_ITEMS').AsString:='1';
        FieldByName('TESTO_ITEM_PERSONALIZZATI').AsString:='';
        FieldByName('STATI_ABILITATI_PUNTEGGI').AsString:='';
      end;
    end;
  AbilitaComponenti;
end;

procedure TS700FAreeValutazioni.dedtItemPersonalizzatiMaxChange(Sender: TObject);
begin
  inherited;
  with S700FAreeValutazioniDtM.selSG701 do
    if State in [dsInsert,dsEdit] then
    begin
      if (StrToIntDef(dedtItemPersonalizzatiMax.Text,0) > 0)
      and not dchkPesoVariabileItems.Checked
      and not dchkPesoEquoItems.Checked then
        FieldByName('PESO_VARIABILE_ITEMS').AsString:='S';
      if (StrToIntDef(dedtItemPersonalizzatiMax.Text,0) > 0)
      and not dchkPesoVariabileItems.Checked
      and (FieldByName('PESO_PERCENTUALE').AsFloat = 0) then
        FieldByName('ITEM_TUTTI_VALUTABILI').AsString:='S';
    end;
  AbilitaComponenti;
end;

procedure TS700FAreeValutazioni.dedtPesoPercentualeChange(Sender: TObject);
begin
  inherited;
  with S700FAreeValutazioniDtM.selSG701 do
    if State in [dsInsert,dsEdit] then
      if not dedtPesoPercMin.Enabled
      or (dedtPesoPercMin.Text = dedtPesoPercMax.Text) then
      begin
        FieldByName('PESO_PERC_MIN').AsString:=FieldByName('PESO_PERCENTUALE').AsString;
        FieldByName('PESO_PERC_MAX').AsString:=FieldByName('PESO_PERCENTUALE').AsString;
      end;
end;

procedure TS700FAreeValutazioni.dgrdDettaglioEditButtonClick(Sender: TObject);
var
  vCodice:Variant;
begin
  inherited;
  if S700FAreeValutazioniDtM.dsrSG700.State in [dsBrowse] then
    exit;
  with S700FAreeValutazioniDtM.selSG700 do
  begin
    vCodice:=VarArrayOf([FieldByName('COD_AREA_LINK').AsString,FieldByName('COD_VALUTAZIONE_LINK').AsString]);
    OpenC015FElencoValori('SG700_VALUTAZIONI','<S700> Selezione dell''elemento collegato',S700FAreeValutazioniDtM.selLinkItem.SQL.Text,'COD_AREA;COD_VALUTAZIONE',vCodice,S700FAreeValutazioniDtM.selLinkItem,700);
    if not VarIsClear(vCodice) then
    begin
      FieldByName('COD_AREA_LINK').AsString:=VarToStr(vCodice[0]);
      FieldByName('COD_VALUTAZIONE_LINK').AsString:=VarToStr(vCodice[1]);
    end;
  end;
end;

procedure TS700FAreeValutazioni.drgpTipoPesoPercentualeChange(Sender: TObject);
begin
  inherited;
  with S700FAreeValutazioniDtM.selSG701 do
    if State in [dsInsert,dsEdit] then
    begin
      if drgpTipoPesoPercentuale.ItemIndex = 0 then
      begin
        if FieldByName('TIPO_LINK_ITEM').AsString = '1' then
          FieldByName('TIPO_LINK_ITEM').AsString:='0';
      end
      else
      begin
        FieldByName('PESO_PERC_MIN').AsString:=FieldByName('PESO_PERCENTUALE').AsString;
        FieldByName('PESO_PERC_MAX').AsString:=FieldByName('PESO_PERCENTUALE').AsString;
      end;
    end;
  AbilitaComponenti;
end;

procedure TS700FAreeValutazioni.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  if not ToolBar1.Enabled then
    Action:=caNone;
end;

procedure TS700FAreeValutazioni.FormCreate(Sender: TObject);
begin
  inherited;
  TStringGrid(dgrdDettaglio).Options:=TStringGrid(dgrdDettaglio).Options-[goColMoving];
end;

procedure TS700FAreeValutazioni.TCancClick(Sender: TObject);
begin
  if R180MessageBox('Attenzione: verranno cancellate anche tutte le valutazioni collegate all''area. Continuare?','DOMANDA') = mrYes then
    inherited;
end;

procedure TS700FAreeValutazioni.AbilitaComponenti;
begin
  if not S700FAreeValutazioniDtM.selSG700.Active then
    exit;
  lblPesoPercentuale.Enabled:=not ((drgpTipoPesoPercentuale.ItemIndex = 0) and (S700FAreeValutazioniDtM.selSG700.RecordCount > 0)) or dchkPesoEquoItems.Checked;
  dedtPesoPercentuale.Enabled:=lblPesoPercentuale.Enabled;
  lblPesoPercMin.Enabled:=(drgpTipoPesoPercentuale.ItemIndex = 0) and (dchkPesoVariabileItems.Checked);
  dedtPesoPercMin.Enabled:=lblPesoPercMin.Enabled;
  lblPesoPercMax.Enabled:=lblPesoPercMin.Enabled;
  dedtPesoPercMax.Enabled:=lblPesoPercMin.Enabled;
  dchkTipoLinkItem.Enabled:=S700FAreeValutazioniDtM.selSG700.RecordCount = 0;
  dchkTipoLinkItem.Controls[0].Enabled:=dchkTipoLinkItem.Enabled;
  dchkTipoLinkItem.Controls[1].Enabled:=dchkTipoLinkItem.Enabled and (drgpTipoPesoPercentuale.ItemIndex = 1);
  dchkTipoLinkItem.Controls[2].Enabled:=dchkTipoLinkItem.Enabled;
  lblItemPersonalizzati.Enabled:=not R180In(dchkTipoLinkItem.ItemIndex,[1,2]);
  lblItemPersonalizzatiMin.Enabled:=lblItemPersonalizzati.Enabled;
  dedtItemPersonalizzatiMin.Enabled:=lblItemPersonalizzati.Enabled;
  lblItemPersonalizzatiMax.Enabled:=lblItemPersonalizzati.Enabled;
  dedtItemPersonalizzatiMax.Enabled:=lblItemPersonalizzati.Enabled;
  //dchkPesoVariabileItems.Enabled:=((StrToFloatDef(dedtPesoPercentuale.Text,0) > 0) or (S700FAreeValutazioniDtM.selSG700.RecordCount = 0)) and (dchkTipoLinkItem.ItemIndex <> 1);
  //dchkPesoVariabileItems.Enabled:=((S700FAreeValutazioniDtM.selSG701.FieldByName('PESO_PERCENTUALE').AsFloat > 0) or (S700FAreeValutazioniDtM.selSG700.RecordCount = 0)) and (dchkTipoLinkItem.ItemIndex <> 1) and (not dchkPesoEquoItems.Checked or (StrToIntDef(dedtItemPersonalizzatiMax.Text,0) > 0));
  dchkPesoVariabileItems.Enabled:=(dchkTipoLinkItem.ItemIndex <> 1) and (not dchkPesoEquoItems.Checked or (StrToIntDef(dedtItemPersonalizzatiMax.Text,0) > 0));
  //dchkPesoEquoItems.Enabled:=((StrToFloatDef(dedtPesoPercentuale.Text,0) > 0) or (S700FAreeValutazioniDtM.selSG700.RecordCount = 0)) and (dchkTipoLinkItem.ItemIndex <> 1) and (not dchkPesoVariabileItems.Checked or (StrToIntDef(dedtItemPersonalizzatiMax.Text,0) > 0));
  //dchkPesoEquoItems.Enabled:=((S700FAreeValutazioniDtM.selSG701.FieldByName('PESO_PERCENTUALE').AsFloat > 0) or (S700FAreeValutazioniDtM.selSG700.RecordCount = 0)) and (dchkTipoLinkItem.ItemIndex <> 1) and (not dchkPesoVariabileItems.Checked or (StrToIntDef(dedtItemPersonalizzatiMax.Text,0) > 0));
  dchkPesoEquoItems.Enabled:=(dchkTipoLinkItem.ItemIndex <> 1) and (not dchkPesoVariabileItems.Checked or (StrToIntDef(dedtItemPersonalizzatiMax.Text,0) > 0));
  //dchkItemTuttiValutabili.Enabled:=dchkTipoLinkItem.ItemIndex <> 1;
  dchkItemTuttiValutabili.Enabled:=(dchkTipoLinkItem.ItemIndex <> 1) and not ((S700FAreeValutazioniDtM.selSG701.FieldByName('PESO_PERCENTUALE').AsFloat = 0) and not dchkPesoVariabileItems.Checked and ((StrToIntDef(dedtItemPersonalizzatiMax.Text,0) > 0) or (S700FAreeValutazioniDtM.selSG700.RecordCount > 0)));
  dchkPunteggiSoloItemValutabili.Enabled:=dchkTipoLinkItem.ItemIndex <> 1;
  drgpTipoPunteggioItems.Enabled:=not R180In(dchkTipoLinkItem.ItemIndex,[1,2]);
  lblTestoItemPersonalizzati.Enabled:=StrToIntDef(dedtItemPersonalizzatiMax.Text,0) > 0;
  dmemTestoItemPersonalizzati.Enabled:=lblTestoItemPersonalizzati.Enabled;
  btnStatiAbilitatiElementi.Enabled:=(DButton.State in [dsEdit,dsInsert]) and (S700FAreeValutazioniDtM.selSG701.RecordCount > 0) and (dchkTipoLinkItem.ItemIndex <> 1);
  btnStatiAbilitatiPunteggi.Enabled:=(DButton.State in [dsEdit,dsInsert]) and (S700FAreeValutazioniDtM.selSG701.RecordCount > 0) and not R180In(dchkTipoLinkItem.ItemIndex,[1,2]);
  pnlDettaglio.Enabled:=(DButton.State = dsBrowse) and (S700FAreeValutazioniDtM.selSG701.RecordCount > 0);
  dgrdDettaglio.Columns[1].Width:=IfThen(R180In(dchkTipoLinkItem.ItemIndex,[1,2]),270,643) + IfThen(dchkPesoEquoItems.Checked,46);
  dgrdDettaglio.Columns[2].Width:=45;
  dgrdDettaglio.Columns[3].Width:=50;
  dgrdDettaglio.Columns[4].Width:=50;
  dgrdDettaglio.Columns[5].Width:=270;
  dgrdDettaglio.Columns[2].Visible:=not dchkPesoEquoItems.Checked;
  dgrdDettaglio.Columns[3].Visible:=R180In(dchkTipoLinkItem.ItemIndex,[1,2]);
  dgrdDettaglio.Columns[4].Visible:=dgrdDettaglio.Columns[3].Visible;
  dgrdDettaglio.Columns[5].Visible:=dgrdDettaglio.Columns[3].Visible;
end;

end.
