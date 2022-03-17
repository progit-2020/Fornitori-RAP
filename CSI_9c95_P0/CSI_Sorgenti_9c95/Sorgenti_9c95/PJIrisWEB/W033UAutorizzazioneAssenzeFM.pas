unit W033UAutorizzazioneAssenzeFM;

interface

uses
  SysUtils, Classes, Controls, Forms, OracleData, StrUtils, Math, Variants,
  IWApplication, IWAppForm, IWVCLBaseContainer, IWContainer, IWRegion,
  IWCompLabel, IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl,
  IWControl, IWCompButton, IWHTMLContainer, IWHTML40Container, IWVCLComponent,
  IWBaseLayoutComponent, IWBaseContainerLayout, IWContainerLayout,
  IWTemplateProcessorHTML,
  IWDBGrids, medpIWDBGrid, meIWImageFile, meIWLabel, meIWCheckBox,
  A000UInterfaccia, R010UPaginaWeb, C018UIterAutDM, WC018URiepilogoIterFM, C190FunzioniGeneraliWeb,
  W001UIrisWebDtM, W033UProspettoAssenzeDM, IWTypes, meIWButton,
  IWCompJQueryWidget, IWCompGrids;

type
  TAutorizza = record
    Rowid:String;
    Checked:Boolean;
    Caption:TCaption;
  end;

  TW033FAutorizzazioneAssenzeFM = class(TFrame)
    IWFrameRegion: TIWRegion;
    jQAutorizzazioneAssenze: TIWJQueryWidget;
    grdAssenze: TmedpIWDBGrid;
    IWTemplateProcessorHTML1: TIWTemplateProcessorHTML;
    btnChiudi: TmeIWButton;
    procedure IWFrameRegionCreate(Sender: TObject);
    procedure btnChiudiClick(Sender: TObject);
    procedure grdAssenzeRenderCell(ACell: TIWGridCell; const ARow, AColumn: Integer);
    procedure grdAssenzeAfterCaricaCDS(Sender: TObject; DBG_ROWID: string);
  private
    ShowAvvertimenti,bAvvertimenti,bVistiPrec: Boolean;
    Autorizza: TAutorizza;

    WC018Esiste:Integer;
    WC018:TWC018FRiepilogoIterFM;
    procedure VisualizzaDettagli(Sender:TObject);

    procedure chkAutorizzazioneClick(Sender: TObject);
    procedure AutorizzazioneOK;
    procedure DBGridColumnClick(ASender: TObject; const AValue: string);
    procedure imgIterClick(Sender: TObject);
  public
    W033DM_Aut: TW033FProspettoAssenzeDM;
    W001DM_Aut: TW001FIrisWebDtM;
    C018_Aut: TC018FIterAutDM;
    procedure CaricaGriglia(ID: String);
  end;

implementation

{$R *.dfm}

uses W033UProspettoAssenze;

procedure TW033FAutorizzazioneAssenzeFM.IWFrameRegionCreate(Sender: TObject);
begin
  Self.Parent:=(Self.Owner as TIWAppForm);
end;

procedure TW033FAutorizzazioneAssenzeFM.CaricaGriglia(ID: String);
var Dipendente:String;
begin
  grdAssenze.medpDataSet:=W033DM_Aut.selaT050;
  grdAssenze.DataSource:=W033DM_Aut.dsrT050;

  //Filtro il dataset delle richieste autorizzabili
  with W033DM_Aut.selaT050 do
  begin
    Filter:='ID = ' + ID;
    Filtered:=True;
    Dipendente:=FieldByName('MATRICOLA').AsString + ' ' + FieldByName('NOMINATIVO').AsString;
  end;

  //Creazione ClientDataSet con stessa struttura del DataSet di partenza
  grdAssenze.medpCreaCDS;
  grdAssenze.medpEliminaColonne;
  grdAssenze.medpAggiungiColonna('D_AUTORIZZAZIONE','Autorizz.','',nil);
  if C018_Aut.UtilizzoAvviso then
    grdAssenze.medpAggiungiColonna('D_VISTI_PREC','Visti prec.','',nil);
  grdAssenze.medpAggiungiColonna(DBG_ITER,'Dettagli','',nil);
  with W001DM_Aut.selT265 do
  begin
    Filter:='(TIPOCUMULO <> ''H'') and (NO_SUPERO_COMPETENZE_WEB = ''N'')';
    ShowAvvertimenti:=RecordCount > 0;
    Filter:='';
  end;
  if ShowAvvertimenti then
    grdAssenze.medpAggiungiColonna('D_AVVERTIMENTI','Avvertimenti','',nil);
  grdAssenze.medpAggiungiColonna('ID','ID','',nil);
  grdAssenze.medpAggiungiColonna('DATA_RICHIESTA','Richiesta','',nil);
  grdAssenze.medpAggiungiColonna('TIPO_RICHIESTA','Tipologia','',nil);
  grdAssenze.medpAggiungiColonna('DAL','Dal','',nil);
  grdAssenze.medpAggiungiColonna('AL','Al','',nil);
  grdAssenze.medpAggiungiColonna('D_CAUSALE_2','Causale','',nil);
  grdAssenze.medpAggiungiColonna('D_TIPOGIUST','Tipo','',nil);
  grdAssenze.medpAggiungiColonna('D_CSI_TIPO_MG','Mezza gg.','',nil);
  grdAssenze.medpAggiungiColonna('D_DAORE_AORE','Ore','',nil);
  if not W033DM_Aut.selaT050.FieldByName('DATANAS').IsNull then
    grdAssenze.medpAggiungiColonna('DATANAS','Familiare','',nil);
  grdAssenze.medpColonna('ID').Visible:=False;
  grdAssenze.medpColonna('D_CSI_TIPO_MG').Visible:=(Self.Owner as TW033FProspettoAssenze).GestioneTipoMezzaGiornata;
  grdAssenze.medpAggiungiRowClick('DBG_ROWID',DBGridColumnClick);
  grdAssenze.medpInizializzaCompGriglia;
  grdAssenze.medpPreparaComponenteGenerico('R',0,0,DBG_CHK,'','Si','','');
  grdAssenze.medpPreparaComponenteGenerico('R',0,1,DBG_CHK,'','No','','');
  // visti precedenti
  if C018_Aut.UtilizzoAvviso then
    grdAssenze.medpPreparaComponenteGenerico('R',grdAssenze.medpIndexColonna('D_VISTI_PREC'),0,DBG_LBL,'','','','','',False);
  // supero competenze
  if ShowAvvertimenti then
    grdAssenze.medpPreparaComponenteGenerico('R',grdAssenze.medpIndexColonna('D_AVVERTIMENTI'),0,DBG_LBL,'','','','','',False);
  grdAssenze.medpPreparaComponenteGenerico('R',grdAssenze.medpIndexColonna(DBG_ITER),0,DBG_IMG,'','ELENCO','','');
  grdAssenze.medpCaricaCDS;

  TR010FPaginaWeb(Self.Parent).VisualizzajQMessaggio(jQAutorizzazioneAssenze,820,-1,Self.Height + 25,'Autorizzazione assenze: ' + Dipendente,'#' + Name,False,True);
end;

procedure TW033FAutorizzazioneAssenzeFM.grdAssenzeAfterCaricaCDS(Sender: TObject;
  DBG_ROWID: string);
var
  i,idxSuperoComp,LivAut: Integer;
  VisAutorizza: Boolean;
  DatoAutorizzatore:String;
begin
  bVistiPrec:=False;
  bAvvertimenti:=False;
  for i:=0 to High(grdAssenze.medpCompGriglia) do
  begin
    LivAut:=StrToIntDef(grdAssenze.medpValoreColonna(i,'LIVELLO_AUTORIZZAZIONE'),0);
    C018_Aut.Id:=StrToIntDef(VarToStr(grdAssenze.medpValoreColonna(i,'ID')),-1);
    C018_Aut.CodIter:=VarToStr(grdAssenze.medpValoreColonna(i,'COD_ITER'));
    with (grdAssenze.medpCompCella(i,DBG_ITER,0) as TmeIWImageFile) do
    begin
      OnClick:=imgIterClick;
      Hint:=C018_Aut.LeggiNoteComplete;
      ImageFile.FileName:=IfThen(C018_Aut.NoteIndicate,fileImgElencoHighlight,fileImgElenco);
    end;
    if C018_Aut.UtilizzoAvviso then
      with (grdAssenze.medpCompCella(i,'D_VISTI_PREC',0) as TmeIWLabel) do
      begin
        Caption:=C018_Aut.VistiPrecedenti[LivAut];
        if Caption = 'No' then
          Css:='font_rosso';
        Visible:=True;
        if Caption <> '' then
          bVistiPrec:=True;
      end;

    //Check SI-NO: colonna 0
    VisAutorizza:=(LivAut > 0); (*C018: se livello < 0 vuol dire che la richiesta fa parte del mio iter ma non posso autorizzare perchè già autorizzata successivamente*)
    if not VisAutorizza then
      FreeAndNil(grdAssenze.medpCompGriglia[i].CompColonne[0]);
    if grdAssenze.medpCompGriglia[i].CompColonne[0] <> nil then
      C018_Aut.SetValoriAut(grdAssenze,i,0,0,1,chkAutorizzazioneClick);
    // EMPOLI_ASL11: segnala anomalia su dati modificati (T852)
    // flag supero competenze
    if ShowAvvertimenti then
    begin
      idxSuperoComp:=grdAssenze.medpIndexColonna('D_AVVERTIMENTI');
      DatoAutorizzatore:=C018_Aut.GetDatoAutorizzatore('SUPERO_COMPETENZE').Valore;
      with (grdAssenze.medpCompCella(i,idxSuperoComp,0) as TmeIWLabel) do
      begin
        if DatoAutorizzatore = 'S' then
        begin
          Css:='font_rosso';
          Caption:='Competenze esaurite';
          bAvvertimenti:=True;
        end
        else
          Caption:='';
        Visible:=Caption <> '';
      end;
    end;
  end;
end;

procedure TW033FAutorizzazioneAssenzeFM.imgIterClick(Sender: TObject);
var
  FN: String;
begin
  FN:=(Sender as TmeIWImageFile).FriendlyName;
  if grdAssenze.medpStato = msBrowse then
    DBGridColumnClick(Sender,FN);
  with W033DM_Aut.selaT050 do
  begin
    if not SearchRecord('ROWID',FN,[srFromBeginning]) then
    begin
      //GGetWebApplicationThreadVar.ShowMessage('La richiesta da visualizzare non è più disponibile!');
      Exit;
    end;
    //-->C018_Aut.VisualizzaDettagli(Sender);
    VisualizzaDettagli(Sender);
  end;
end;

procedure TW033FAutorizzazioneAssenzeFM.VisualizzaDettagli(Sender:TObject);
begin
  with C018_Aut.selTabellaIter do
  begin
    C018_Aut.CodIter:=FieldByName('COD_ITER').AsString;
    C018_Aut.Id:=FieldByName('ID').AsInteger;
  end;

  C018_Aut.LeggiIterCompleto;

  if WC018Esiste = 1 then
    try
      FreeAndNil(TWC018FRiepilogoIterFM(WC018));
    except
    end;
  WC018:=TWC018FRiepilogoIterFM.Create(Self.Owner);
  WC018Esiste:=1;
  WC018.C018:=C018_Aut;
  WC018.Livello:=IfThen(WR000DM.Responsabile,C018_Aut.selTabellaIter.FieldByName('LIVELLO_AUTORIZZAZIONE').AsInteger,0);
  WC018.WC018Esiste:=@WC018Esiste;
  WC018.ComponenteHint:=(Sender as TIWCustomControl);
  WC018.Visualizza;
end;

procedure TW033FAutorizzazioneAssenzeFM.chkAutorizzazioneClick(Sender: TObject);
begin
  Autorizza.Rowid:=(Sender as TmeIWCheckBox).FriendlyName;
  Autorizza.Checked:=(Sender as TmeIWCheckBox).Checked;
  Autorizza.Caption:=(Sender as TmeIWCheckBox).Caption;

  // verifica presenza record
  with W033DM_Aut.selaT050 do
  begin
    Refresh;
    if not SearchRecord('ROWID',Autorizza.RowId,[srFromBeginning]) then
    begin
      //GGetWebApplicationThreadVar.ShowMessage('Attenzione! La richiesta da autorizzare non è più disponibile!');
      Exit;
    end;
  end;
  DBGridColumnClick(Sender,Autorizza.Rowid);
  AutorizzazioneOK;
  btnChiudiClick(nil);
end;

procedure TW033FAutorizzazioneAssenzeFM.AutorizzazioneOK;
var
  Aut,Resp: String;
begin
  Aut:='';
  Resp:='';
  // autorizzazione richiesta
  with W033DM_Aut.selaT050 do
  begin
    Resp:=Parametri.Operatore;
    if Autorizza.Checked and (Autorizza.Caption = 'Si') then
      // autorizzazione SI
      Aut:=C018SI
    else if Autorizza.Checked and (Autorizza.Caption = 'No') then
      // autorizzazione NO
      Aut:=C018NO
    else if not Autorizza.Checked then
      // autorizzazione non impostata
      Aut:='';
    // salva i dati di autorizzazione
    try
      C018_Aut.CodIter:=FieldByName('COD_ITER').AsString;
      C018_Aut.Id:=FieldByName('ID').AsInteger;
      C018_Aut.InsAutorizzazione(FieldByName('LIVELLO_AUTORIZZAZIONE').AsInteger,Aut,Resp,'','',True);
      if C018_Aut.MessaggioOperazione <> '' then
        raise Exception.Create(C018_Aut.MessaggioOperazione)
      else
        SessioneOracle.Commit;
      W033DM_Aut.selT050.Refresh;
      //Aggiorno il ClientDataSet delle assenze
      with W033DM_Aut.cdsListaAss do
        while Locate('ID_AUTORIZZABILE',VarArrayOf([C018_Aut.Id]),[]) do
          if W033DM_Aut.selT050.Locate('ID',VarArrayOf([C018_Aut.Id]),[]) then
          begin
            Edit;
            FieldByName('ID_AUTORIZZABILE').AsInteger:=0;
            Post;
          end
          else
            Delete;
    except
      on E: Exception do
        //GGetWebApplicationThreadVar.ShowMessage('Impostazione dell''autorizzazione fallita!' + CRLF +
        //                           'Motivo: ' + E.Message);
        Exit;
    end;
  end;
end;

procedure TW033FAutorizzazioneAssenzeFM.DBGridColumnClick(ASender: TObject; const AValue: string);
var
  IdRiga: Integer;
begin
  // se il click è effettuato sulla stessa riga esce subito
  // per evitare di rieseguire operazioni inutili
  if (W033DM_Aut.cdsT050.FieldByName('DBG_ROWID').AsString = AValue) and
     (W033DM_Aut.selaT050.RowId = AValue) then
    Exit;

  // prova la locate prima con rowid, quindi con id richiesta
  if not W033DM_Aut.cdsT050.Locate('DBG_ROWID',AValue,[]) then
    if TryStrToInt(AValue,IdRiga) then
    begin
      if not W033DM_Aut.cdsT050.Locate('ID',IdRiga,[]) then
        Exit;
    end
    else
      Exit;
end;

procedure TW033FAutorizzazioneAssenzeFM.grdAssenzeRenderCell(ACell: TIWGridCell; const ARow, AColumn: Integer);
var
  NumColonna:Integer;
  NomeCampo: String;
begin
  if not grdAssenze.medpRenderCell(ACell,ARow,AColumn,True,True) then
    Exit;

  NumColonna:=grdAssenze.medpNumColonna(AColumn);
  NomeCampo:=grdAssenze.medpColonna(NumColonna).DataField;

  //se vuote, nascondo la colonne supplementari
  if ((NomeCampo = 'D_AVVERTIMENTI') and not bAvvertimenti)
  or ((NomeCampo = 'D_VISTI_PREC') and not bVistiPrec) then
    ACell.Css:='invisibile';

  // assegnazione componenti alle celle
  if (ARow > 0) and (ARow - 1 <= High(grdAssenze.medpCompGriglia)) and (grdAssenze.medpCompGriglia[ARow - 1].CompColonne[NumColonna] <> nil) then
  begin
    ACell.Text:='';
    ACell.Control:=grdAssenze.medpCompGriglia[ARow - 1].CompColonne[NumColonna];
  end;

  // impostazione stili css particolari (colonne "Autorizzazione" ed "Elaborazione")
  if (ARow > 0) and (ARow - 1 <= High(grdAssenze.medpCompGriglia)) and (ACell.Control = nil) then
  begin
    if NomeCampo = 'D_AUTORIZZAZIONE' then
      ACell.Css:=ACell.Css + ' font_grassetto align_center' +
                 IfThen(grdAssenze.medpValoreColonna(ARow - 1,'AUTORIZZ_UTILE') = C018NO,' font_rosso')
    else if ((NomeCampo = 'DAL') or
             (NomeCampo = 'AL') or
             (NomeCampo = 'D_CAUSALE_2')) then
      ACell.Css:=ACell.Css + ' font_blu'
    else if NomeCampo = 'TIPO_RICHIESTA' then
    begin
      if ACell.Text = 'D' then
        ACell.Text:='Definitiva'
      else if ACell.Text = 'P' then
        ACell.Text:='Preventiva'
      else if ACell.Text = 'R' then
        ACell.Text:='Revoca'
      else if ACell.Text = 'C' then
        ACell.Text:='Cancellazione';
    end;
  end;
end;

procedure TW033FAutorizzazioneAssenzeFM.btnChiudiClick(Sender: TObject);
begin
  TR010FPaginaWeb(Self.Parent).RefreshPageAttivo:=True;
  W033DM_Aut.selaT050.Filtered:=False;
  Free;
end;

end.
