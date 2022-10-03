unit Wc01UModificaTabelloneFM;

interface

uses
  SysUtils, Classes, Controls, Forms, OracleData, StrUtils, Math, Variants,
  IWApplication, IWAppForm, IWVCLBaseContainer, IWContainer, IWRegion,
  IWCompLabel, IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl,
  IWControl, IWCompButton, IWHTMLContainer, IWHTML40Container, IWVCLComponent,
  IWBaseLayoutComponent, IWBaseContainerLayout, IWContainerLayout,
  IWTemplateProcessorHTML, medpIWMultiColumnComboBox, meIWEdit,
  IWDBGrids, medpIWDBGrid, meIWImageFile, meIWLabel, meIWCheckBox,
  A000UInterfaccia, R010UPaginaWeb, C018UIterAutDM, WC018URiepilogoIterFM, C190FunzioniGeneraliWeb,
  W001UIrisWebDtM, Wc01URichiestaRendiProjDM, IWTypes, meIWButton, meIWComboBox,
  IWCompJQueryWidget, IWCompGrids, medpIWMessageDlg, C180FunzioniGenerali, W000UMessaggi;

type
  TAutorizza = record
    Rowid:String;
    Checked:Boolean;
    Caption:TCaption;
  end;

  TWc01FModificaTabelloneFM = class(TFrame)
    IWFrameRegion: TIWRegion;
    jQModificaTabellone: TIWJQueryWidget;
    grdRendicontazione: TmedpIWDBGrid;
    IWTemplateProcessorHTML1: TIWTemplateProcessorHTML;
    btnConferma: TmeIWButton;
    btnAnnulla: TmeIWButton;
    procedure IWFrameRegionCreate(Sender: TObject);
    procedure grdRendicontazioneRenderCell(ACell: TIWGridCell; const ARow, AColumn: Integer);
    procedure btnConfermaClick(Sender: TObject);
    procedure btnAnnullaClick(Sender: TObject);
    procedure grdRendicontazioneAfterCaricaCDS(Sender: TObject;
      DBG_ROWID: string);
  private
    TurnoModificato,RecordInserito,SolaLettura,AggiornaTabellone: Boolean;
    WC018Esiste:Integer;
    WC018:TWC018FRiepilogoIterFM;
    procedure InserisciRecord;
    procedure ModificaRecord;
    procedure CancellaRecord;
    procedure TrasformaComponenti;
    procedure Uscita;
    procedure imgIterClick(Sender: TObject);
    procedure VisualizzaDettagli(Sender:TObject);
  public
    Wc01DM_Mod: TWc01FRichiestaRendiProjDM;
    C018_Mod: TC018FIterAutDM;
    Data:TDateTime;
    IdTask:String;
    procedure CaricaGriglia;
  end;

implementation

{$R *.dfm}

uses Wc01URichiestaRendiProj;

procedure TWc01FModificaTabelloneFM.IWFrameRegionCreate(Sender: TObject);
begin
  Self.Parent:=(Self.Owner as TIWAppForm);
  TurnoModificato:=False;
  RecordInserito:=False;
  AggiornaTabellone:=False;
end;

procedure TWc01FModificaTabelloneFM.CaricaGriglia;
var Dipendente:String;
begin
  grdRendicontazione.medpDataSet:=Wc01DM_Mod.selT755;
  grdRendicontazione.DataSource:=Wc01DM_Mod.dsrT755Tab;

  with Wc01DM_Mod,selT755 do
  begin
    Filter:='(ID_T752 = ' + IdTask + ') AND (DATA = ' + FloatToStr(Data) + ') AND (AUTORIZZAZIONE <> ''' + C018NO + ''')';
    Filtered:=True;
    if RecordCount = 0 then
      InserisciRecord;
    Dipendente:=FieldByName('MATRICOLA').AsString + ' ' + FieldByName('NOMINATIVO').AsString;
    cdsListaGG.Locate('DATA',Data,[]);
    SolaLettura:=True //per non creare disallineamenti, le ore vengono impostate solo da tabellone, mentre le note da questo frame
                 (*not FieldByName('AUTORIZZAZIONE').IsNull
                 or not R180InConcat(IdTask,cdsListaGG.FieldByName('ID_T752_ABILITATI').AsString)
                 or (Self.Owner as TWc01FRichiestaRendiProj).SolaLettura*);
  end;

  //Creazione ClientDataSet con stessa struttura del DataSet di partenza
  with grdRendicontazione do
  begin
    medpCreaCDS;
    medpEliminaColonne;
    medpAggiungiColonna('DATA','Data','',nil);
    medpAggiungiColonna('ID_T752','Id','',nil);
    medpAggiungiColonna('CF_C_PROGETTO','Progetto','',nil);
    medpAggiungiColonna('CF_C_ATTIVITA','Attività','',nil);
    medpAggiungiColonna('CF_C_TASK','Task','',nil);
    medpAggiungiColonna('ORE','Ore da autorizzare','',nil);
    medpAggiungiColonna('CF_ORE_AUTORIZ','Ore autorizzate','',nil);
    medpAggiungiColonna('D_AUTORIZZAZIONE','Aut.','',nil);
    medpAggiungiColonna('D_RESPONSABILE','Responsabile','',nil);
    medpAggiungiColonna(DBG_ITER,'Dettagli','',nil);

    medpColonna('ID_T752').Visible:=False;
    medpColonna('CF_ORE_AUTORIZ').Visible:=C018_Mod.IterModificaValori;

    medpInizializzaCompGriglia;
    medpPreparaComponenteGenerico('R',medpIndexColonna(DBG_ITER),0,DBG_IMG,'','ELENCO','','');
    medpCaricaCDS;
  end;

  if not SolaLettura then
    TrasformaComponenti;
  btnConferma.Visible:=not SolaLettura;
  btnAnnulla.Caption:=IfThen(SolaLettura,'Esci','Annulla');

  TR010FPaginaWeb(Self.Parent).VisualizzajQMessaggio(jQModificaTabellone,820,-1,Self.Height + 25,'Rendicontazione progetti di : ' + Dipendente,'#' + Name,False,True);
end;

procedure TWc01FModificaTabelloneFM.InserisciRecord;
begin
  with Wc01DM_Mod,selT755 do
  begin
    Append;
    FieldByName('PROGRESSIVO').AsInteger:=(Self.Owner as TWc01FRichiestaRendiProj).selAnagrafeW.FieldByName('PROGRESSIVO').AsInteger;
    FieldByName('DATA').AsDateTime:=Data;
    FieldByName('ID_T752').AsInteger:=StrToInt(IdTask);
    cdsListaGG.Locate('DATA',Data,[]);
    FieldByName('ORE').AsString:=R180MinutiOre(R180OreMinuti(cdsListaGG.FieldByName('ORE_RICHIEDIBILI').AsString) - R180OreMinuti(cdsListaGG.FieldByName('ORE_RICHIESTE').AsString));

    //Richiamo alla gestione ereditata degli iter
    try
      C018_Mod.InsRichiesta('R','','');
      if C018_Mod.MessaggioOperazione <> '' then
      begin
        Cancel;
        raise Exception.Create(C018_Mod.MessaggioOperazione);
      end;
      SessioneOracle.Commit;
      C018.SetCodIter;
      SessioneOracle.Commit;
    except
      on E:Exception do
      begin
        GGetWebApplicationThreadVar.ShowMessage(Format(A000MSG_R013_MSG_RICHIESTA_INS_FALLITO,[E.Message,E.ClassName]));
        Exit;
      end;
    end;
    Refresh;//Dopo l'inserimento e l'assegnazione del CodIter, devo aggiornare i dati del dataset filtrato (unico record appena inserito)
    RecordInserito:=True;
    //aggiorno tabella fruizioni del dipendente
    updT753.SetVariable('ID_T752',FieldByName('ID_T752').AsInteger);
    updT753.SetVariable('PROGRESSIVO',FieldByName('PROGRESSIVO').AsInteger);
    updT753.SetVariable('DATA',FieldByName('DATA').AsDateTime);
    updT753.SetVariable('VARIAZIONE',R180OreMinuti(FieldByName('ORE').AsString));//valore positivo
    updT753.Execute;
    SessioneOracle.Commit;
  end;
end;

procedure TWc01FModificaTabelloneFM.ModificaRecord;
var MinRichiedibiliTot,MinRichiesteTot,MinRichiedibili,MinRichieste,MinRichiesteOld:Integer;
begin
  with Wc01DM_Mod,selT755 do
  begin
    MinRichiesteOld:=R180OreMinuti(FieldByName('ORE').AsString);
    MinRichieste:=R180OreMinuti((grdRendicontazione.medpCompCella(0,grdRendicontazione.medpIndexColonna('ORE'),0) as TmeIWEdit).Text);
    cdsListaGG.Locate('DATA',Data,[]);
    MinRichiedibiliTot:=R180OreMinuti(cdsListaGG.FieldByName('ORE_RICHIEDIBILI').AsString);
    MinRichiesteTot:=R180OreMinuti(cdsListaGG.FieldByName('ORE_RICHIESTE').AsString);
    MinRichiedibili:=Max(MinRichiedibiliTot - MinRichiesteTot + IfThen(RecordInserito,0,MinRichiesteOld),0);
    if MinRichieste > MinRichiedibili then
      raise exception.Create('Impossibile richiedere più ore di quelle disponibili (' + R180MinutiOre(MinRichiedibili) + ')!');
    Edit;
    FieldByName('ORE').AsString:=(grdRendicontazione.medpCompCella(0,grdRendicontazione.medpIndexColonna('ORE'),0) as TmeIWEdit).Text;
    Post;
    SessioneOracle.Commit;
    //aggiorno tabella fruizioni del dipendente
    updT753.SetVariable('ID_T752',FieldByName('ID_T752').AsInteger);
    updT753.SetVariable('PROGRESSIVO',FieldByName('PROGRESSIVO').AsInteger);
    updT753.SetVariable('DATA',FieldByName('DATA').AsDateTime);
    updT753.SetVariable('VARIAZIONE',MinRichieste - MinRichiesteOld);//valore positivo o negativo
    updT753.Execute;
    SessioneOracle.Commit;
  end;
end;

procedure TWc01FModificaTabelloneFM.CancellaRecord;
var updIdT752,updProg,updVar:Integer;
    updData:TDateTime;
begin
  with Wc01DM_Mod.selT755 do
  begin
    updIdT752:=FieldByName('ID_T752').AsInteger;
    updProg:=FieldByName('PROGRESSIVO').AsInteger;
    updData:=FieldByName('DATA').AsDateTime;
    updVar:=R180OreMinuti(FieldByName('ORE').AsString);
    C018_Mod.Id:=FieldByName('ID').AsInteger;
    C018_Mod.CodIter:=FieldByName('COD_ITER').AsString;
    C018_Mod.EliminaIter;
    SessioneOracle.Commit;
    Refresh;
  end;
  with Wc01DM_Mod do
  begin
    //aggiorno tabella fruizioni del dipendente
    updT753.SetVariable('ID_T752',updIdT752);
    updT753.SetVariable('PROGRESSIVO',updProg);
    updT753.SetVariable('DATA',updData);
    updT753.SetVariable('VARIAZIONE',-updVar);//valore negativo
    updT753.Execute;
    SessioneOracle.Commit;
  end;
end;

procedure TWc01FModificaTabelloneFM.grdRendicontazioneAfterCaricaCDS(Sender: TObject; DBG_ROWID: string);
var i: Integer;
begin
  for i:=0 to High(grdRendicontazione.medpCompGriglia) do
  begin
    C018_Mod.Id:=StrToIntDef(VarToStr(grdRendicontazione.medpValoreColonna(i,'ID')),-1);
    C018_Mod.CodIter:=VarToStr(grdRendicontazione.medpValoreColonna(i,'COD_ITER'));
    with (grdRendicontazione.medpCompCella(i,DBG_ITER,0) as TmeIWImageFile) do
    begin
      OnClick:=imgIterClick;
      Hint:=C018_Mod.LeggiNoteComplete;
      ImageFile.FileName:=IfThen(C018_Mod.NoteIndicate,fileImgElencoHighlight,fileImgElenco);
    end;
  end;
end;

procedure TWc01FModificaTabelloneFM.grdRendicontazioneRenderCell(ACell: TIWGridCell; const ARow, AColumn: Integer);
var
  NumColonna:Integer;
  NomeCampo: String;
begin
  if not grdRendicontazione.medpRenderCell(ACell,ARow,AColumn,True,True) then
    Exit;

  NumColonna:=grdRendicontazione.medpNumColonna(AColumn);
  NomeCampo:=grdRendicontazione.medpColonna(NumColonna).DataField;

  // assegnazione componenti alle celle
  if (ARow > 0) and (ARow - 1 <= High(grdRendicontazione.medpCompGriglia)) and (grdRendicontazione.medpCompGriglia[ARow - 1].CompColonne[NumColonna] <> nil) then
  begin
    ACell.Text:='';
    ACell.Control:=grdRendicontazione.medpCompGriglia[ARow - 1].CompColonne[NumColonna];
  end;

  if ARow > 0 then
  begin
    // allineamento al centro per alcuni campi
    if (NomeCampo = 'DATA') or
       (NomeCampo = 'ORE') or
       (NomeCampo = 'CF_ORE_AUTORIZ') then
      ACell.Css:=ACell.Css + ' align_center'
    else if R180In(NomeCampo,['CF_C_PROGETTO','CF_C_ATTIVITA','CF_C_TASK']) then
      ACell.Hint:=grdRendicontazione.medpValoreColonna(ARow - 1,'CF_D_' + Copy(NomeCampo,6));
  end;
  if ACell.Hint <> '' then
    ACell.Css:=ACell.Css + ' tooltipHtml';
end;

procedure TWc01FModificaTabelloneFM.TrasformaComponenti;
// Trasforma i componenti della riga indicata da text a control e viceversa per la grid grdRendicontazione
var
  DaTestoAControlli:Boolean;
  i,c:Integer;
begin
  with grdRendicontazione do
  begin
    i:=0;
    c:=medpIndexColonna('ORE');
    DaTestoAControlli:=medpCompGriglia[i].CompColonne[c] = nil;

    if DaTestoAControlli then
    begin
      // ore richieste
      c:=medpIndexColonna('ORE');
      medpPreparaComponenteGenerico('C',0,0,DBG_EDT,'ORA2','','','','S');
      medpCreaComponenteGenerico(i,c,Componenti);
      with (medpCompCella(i,c,0) as TmeIWEdit) do
        Text:=medpValoreColonna(i,'ORE');
    end
    else
      FreeAndNil(medpCompGriglia[i].CompColonne[medpIndexColonna('ORE')]);
    medpBrowse:=not DaTestoAControlli;
  end;
end;

procedure TWc01FModificaTabelloneFM.btnConfermaClick(Sender: TObject);
begin
  with grdRendicontazione do
  begin
    R180OraValidate((medpCompCella(0,medpIndexColonna('ORE'),0) as TmeIWEdit).Text);
    if R180OreMinuti((medpCompCella(0,medpIndexColonna('ORE'),0) as TmeIWEdit).Text) <= 0 then
    begin
      if not RecordInserito then
        CancellaRecord
      else
        raise exception.Create(A000MSG_Wc01_NO_ORE);
    end
    else
      ModificaRecord;
  end;
  AggiornaTabellone:=True;
  Uscita;
end;

procedure TWc01FModificaTabelloneFM.btnAnnullaClick(Sender: TObject);
begin
  if RecordInserito then
    CancellaRecord;
  Uscita;
end;

procedure TWc01FModificaTabelloneFM.Uscita;
begin
  Wc01DM_Mod.selT755.Filtered:=False;
  if AggiornaTabellone then
  begin
    Wc01DM_Mod.selT755.Close;
    (Self.Owner as TWc01FRichiestaRendiProj).RicaricaProspetto;
  end;
  Free;
end;

procedure TWc01FModificaTabelloneFM.imgIterClick(Sender: TObject);
var
  FN: String;
begin
  FN:=(Sender as TmeIWImageFile).FriendlyName;
  (*if grdRendicontazione.medpStato = msBrowse then
    (Self.Owner as TWc01FRichiestaRendiProj).DBGridColumnClick(Sender,FN);*)
  with Wc01DM_Mod.selT755 do
  begin
    if not SearchRecord('ROWID',FN,[srFromBeginning]) then
    begin
      //GGetWebApplicationThreadVar.ShowMessage('La richiesta da visualizzare non è più disponibile!');
      Exit;
    end;
    VisualizzaDettagli(Sender);
  end;
end;

procedure TWc01FModificaTabelloneFM.VisualizzaDettagli(Sender:TObject);
begin
  with C018_Mod.selTabellaIter do
  begin
    C018_Mod.CodIter:=FieldByName('COD_ITER').AsString;
    C018_Mod.Id:=FieldByName('ID').AsInteger;
  end;

  C018_Mod.LeggiIterCompleto;

  if WC018Esiste = 1 then
    try
      FreeAndNil(TWC018FRiepilogoIterFM(WC018));
    except
    end;
  WC018:=TWC018FRiepilogoIterFM.Create(Self.Owner);
  WC018Esiste:=1;
  WC018.C018:=C018_Mod;
  WC018.Livello:=IfThen(WR000DM.Responsabile,C018_Mod.selTabellaIter.FieldByName('LIVELLO_AUTORIZZAZIONE').AsInteger,0);
  WC018.WC018Esiste:=@WC018Esiste;
  WC018.ComponenteHint:=(Sender as TIWCustomControl);
  WC018.Visualizza;
end;

end.
