unit WC018URiepilogoIterFM;

interface

uses
  A000UInterfaccia, R010UPaginaWeb, A000UMessaggi,
  C018UIterAutDM, C190FunzioniGeneraliWeb,
  SysUtils, Classes, Controls, Forms, IWAppForm,
  IWVCLBaseContainer, IWContainer, IWRegion, IWHTMLContainer,
  IWHTML40Container, IWCompButton, IWVCLBaseControl, IWBaseControl,
  IWBaseHTMLControl, IWControl, IWVCLComponent,
  IWBaseLayoutComponent, IWBaseContainerLayout, IWContainerLayout,
  IWTemplateProcessorHTML, DBClient, IWDBGrids,
  DB, Oracle, StrUtils,  medpIWDBGrid, meIWMemo, medpIWMessageDlg,
  meIWButton, IWCompJQueryWidget, meIWImageFile, IWCompGrids;

type
  TWC018FRiepilogoIterFM = class(TFrame)
    IWFrameRegion: TIWRegion;
    jQRiepilogoIter: TIWJQueryWidget;
    IWTemplateProcessorFrame: TIWTemplateProcessorHTML;
    grdIter: TmedpIWDBGrid;
    cdsIter: TClientDataSet;
    dsrIter: TDataSource;
    btnApplica: TmeIWButton;
    btnChiudi: TmeIWButton;
    procedure btnChiudiClick(Sender: TObject);
    procedure IWFrameRegionCreate(Sender: TObject);
    procedure grdIterRenderCell(ACell: TIWGridCell; const ARow,
      AColumn: Integer);
    procedure btnApplicaClick(Sender: TObject);
  private
    FLivello:Integer;
    FC018:TC018FIterAutDM;
    FComponenteHint:TIWCustomControl;
    NoteOriginali:String;
    NoteModificate:Boolean;
    IdxNote:Integer;
    procedure CreaColonne;
    procedure PutLivello(pLivello:Integer);
    procedure PutC018(pC018:TC018FIterAutDM);
    procedure PutComponenteHint(pComponenteHint:TIWCustomControl);
    procedure ResultExit(Sender: TObject; R: TmeIWModalResult; KI: String);
  public
    WC018Esiste:^Integer;
    procedure Visualizza;
    property Livello:Integer read FLivello write PutLivello;
    property C018:TC018FIterAutDM read FC018 write PutC018;
    property ComponenteHint:TIWCustomControl read FComponenteHint write PutComponenteHint;
  end;

implementation

{$R *.dfm}

procedure TWC018FRiepilogoIterFM.IWFrameRegionCreate(Sender: TObject);
begin
  Self.Parent:=(Self.Owner as TIWAppForm);
  FC018:=nil;
  NoteOriginali:='';
  NoteModificate:=False;
end;

procedure TWC018FRiepilogoIterFM.PutC018(pC018:TC018FIterAutDM);
begin
  FC018:=pC018;
  if pC018 <> nil then
    grdIter.medpDataSet:=pC018.selT851;
end;

procedure TWC018FRiepilogoIterFM.PutLivello(pLivello:Integer);
begin
  CreaColonne;
  FLivello:=pLivello;
  btnApplica.Visible:=False;
  if not WR000DM.Responsabile
  and (C018.selI095.Lookup('COD_ITER',C018.CodIter,'MAX_LIV_NOTE_MODIFICABILI') <> -1)
  and (C018.selI095.Lookup('COD_ITER',C018.CodIter,'MAX_LIV_NOTE_MODIFICABILI') < C018.LivMaxAutNeg) then
    C018.AccessoReadOnly:=True; //Forzo l'accesso in ReadOnly se ho ricevuto l'autorizzazione o la negazione ad un livello superiore al limite indicato per la struttura
  if (not C018.AccessoReadOnly) and (pLivello >= 0) and (pLivello <= High(grdIter.medpCompGriglia)) and (grdIter.medpValoreColonna(pLivello,'AUTORIZZ_AUTOMATICA') <> 'S') then
  begin
    btnApplica.Visible:=True;
    grdIter.medpPreparaComponenteGenerico('C',0,0,DBG_MEMO,'99%','','','','S');
    grdIter.medpCreaComponenteGenerico(pLivello,IdxNote,grdIter.Componenti);
    NoteOriginali:=grdIter.medpValoreColonna(pLivello,'NOTE').Trim;
    with (grdIter.medpCompCella(pLivello,IdxNote,0) as TmeIWMemo) do
    begin
      Css:=Css + ' WC018memoheight';
      Text:=NoteOriginali;
    end;
    // EMPOLI_ASL11 - chiamata 82422.ini
    // salva le note originali rimuovendo l'eventuale informazione della data/ora di modifica
    NoteOriginali:=C018.PulisciCronologiaNote(NoteOriginali);
    // EMPOLI_ASL11 - chiamata 82422.fine
  end;
end;

procedure TWC018FRiepilogoIterFM.PutComponenteHint(pComponenteHint:TIWCustomControl);
begin
  FComponenteHint:=pComponenteHint;
end;

procedure TWC018FRiepilogoIterFM.CreaColonne;
begin
  grdIter.medpPaginazione:=False;
  grdIter.medpBrowse:=False;
  grdIter.medpDataSet.Refresh;
  grdIter.medpCreaCDS;
  //Impostazione delle colonne da visualizzare sulla DBGrid
  grdIter.medpEliminaColonne;
  grdIter.medpAggiungiColonna('C_TITOLO_LIVELLO','Livello','',nil,nil);
  grdIter.medpAggiungiColonna('C_STATO','Autorizzazione','',nil,nil);
  grdIter.medpAggiungiColonna('DATA','Data','',nil,nil);
  grdIter.medpAggiungiColonna('NOMINATIVO','Nominativo','',nil,nil);
  grdIter.medpAggiungiColonna('NOTE','Note','',nil,nil);
  IdxNote:=grdIter.medpIndexColonna('NOTE');
  grdIter.medpInizializzaCompGriglia;
  grdIter.RigaInserimento:=False;
  grdIter.medpCaricaCDS;
end;

procedure TWC018FRiepilogoIterFM.Visualizza;
var Titolo:String;
begin
  grdIter.Caption:=Format(A000TraduzioneStringhe(A000MSG_WC018_MSG_RICHIESTA) + ' %d',[C018.Id]);
  Titolo:=Format(A000TraduzioneStringhe(A000MSG_WC018_MSG_FMT_RIEPILOGO_ITER),[C018.DescIter,C018.DescCodIter]);
  (Self.Parent as TR010FPaginaWeb).VisualizzajQMessaggio(jQRiepilogoIter,820,-1,EM2PIXEL * 24,Titolo,'#' + Name,False,True);
end;

procedure TWC018FRiepilogoIterFM.grdIterRenderCell(ACell: TIWGridCell;
  const ARow, AColumn: Integer);
var
  NumColonna: Integer;
  Campo: String;
begin
  if not (ACell.Grid as TmedpIWDBGrid).medpRenderCell(ACell,ARow,AColumn,True,True,False) then
    Exit;

  NumColonna:=grdIter.medpNumColonna(AColumn);
  Campo:=grdIter.medpColonna(NumColonna).DataField;

  // assegnazione stili
  if (ARow > 0) and (Length(grdIter.medpCompGriglia) > 0) then
  begin
    if Campo = 'STATO' then
    begin
      ACell.Css:=ACell.Css + ' align_center';
    end
    else if Campo = 'DATA' then
    begin
      ACell.Css:=ACell.Css + ' WC018data';
      ACell.Text:=Copy(ACell.Text,1,16); // dd/mm/yyyy hh.mm = 16 caratteri
    end
    else if Campo = 'NOTE' then
      ACell.Css:=ACell.Css + ' WC018note';
  end;

  // Assegnazione componenti alle celle
  if (ARow > 0) and (ARow <= High(grdIter.medpCompGriglia) + 1) and (grdIter.medpCompGriglia[ARow - 1].CompColonne[NumColonna] <> nil) then
  begin
    ACell.Text:='';
    ACell.Control:=grdIter.medpCompGriglia[ARow - 1].CompColonne[NumColonna];
  end;
end;

procedure TWC018FRiepilogoIterFM.btnApplicaClick(Sender: TObject);
var
  NoteMemo, NoteMemoNoCronologia: string;
begin
  //if C018 <> nil then
  if (C018 <> nil) and btnApplica.Visible then // correzione 29.12.2011 - evento può essere richiamato da pulsante Chiudi
  begin
    NoteMemo:=Trim((grdIter.medpCompCella(FLivello,IdxNote,0) as TmeIWMemo).Text);
    // EMPOLI_ASL11 - chiamata 82422.ini
    if Parametri.CampiRiferimento.C90_CronologiaNote = 'S' then
      NoteMemoNoCronologia:=C018.PulisciCronologiaNote(NoteMemo)
    else
      NoteMemoNoCronologia:=NoteMemo;
    // EMPOLI_ASL11 - chiamata 82422.fine

    if NoteOriginali <> {NoteMemo}NoteMemoNoCronologia then // EMPOLI_ASL11 - chiamata 82422
    begin
      NoteOriginali:={NoteMemo}NoteMemoNoCronologia; // EMPOLI_ASL11 - chiamata 82422
      NoteMemo:=C018.SetNote(NoteMemo{NoteOriginali},FLivello); // è lo stesso, ma a livello logico è più chiaro
      RegistraLog.SettaProprieta('M',C018.TabellaIter,Copy(C018.IterCodForm,1,4),nil,True);
      RegistraLog.InserisciDato('NOTE',NoteOriginali,NoteMemoNoCronologia);
      RegistraLog.RegistraOperazione;
      SessioneOracle.Commit;
      // EMPOLI_ASL11 - chiamata 82422.ini
      // aggiorna le note se modificate per effetto del parametro "Web: cronologia note"
      if Parametri.CampiRiferimento.C90_CronologiaNote = 'S' then
        (grdIter.medpCompCella(FLivello,IdxNote,0) as TmeIWMemo).Text:=NoteMemo;
      // EMPOLI_ASL11 - chiamata 82422.fine

      NoteModificate:=True;
    end;
  end;
end;

procedure TWC018FRiepilogoIterFM.btnChiudiClick(Sender: TObject);
var
  IWC: TIWCustomControl;
  VisConferma: Boolean;
  NoteAttuali: String;
begin
  // il confronto avviene a meno della data/ora impostate automaticamente nel caso
  // di parametro aziendale "Web: cronologia note" attivo
  VisConferma:=False;
  if FLivello >=0 then
  begin
    IWC:=grdIter.medpCompCella(FLivello,IdxNote,0);
    if IWC <> nil then
    begin
      NoteAttuali:=Trim((IWC as TmeIWMemo).Text);
      if Parametri.CampiRiferimento.C90_CronologiaNote = 'S' then
        NoteAttuali:=C018.PulisciCronologiaNote(NoteAttuali);
      VisConferma:=NoteOriginali <> NoteAttuali;
    end;
  end;
  if VisConferma then
    MsgBox.WebMessageDlg(A000TraduzioneStringhe(A000MSG_WC018_DLG_SALVA_NOTE),mtConfirmation,[mbYes,mbNo,mbCancel],ResultExit,'')
  else
    ResultExit(nil,mrYes,'');
end;

procedure TWC018FRiepilogoIterFM.ResultExit(Sender: TObject; R: TmeIWModalResult; KI: String);
begin
  if R = mrCancel then
    exit
  else
  begin
    if R = mrYes then
      btnApplicaClick(nil);
    if NoteModificate then
    begin
      ComponenteHint.Hint:=C018.LeggiNoteComplete;
      if ComponenteHint is TmeIWImageFile then
        (ComponenteHint as TmeIWImageFile).ImageFile.FileName:=IfThen(C018.NoteIndicate,fileImgElencoHighlight,fileImgElenco);
    end;
    C018.selT851.Close;
    WC018Esiste^:=0;
    Free;
  end;
end;

end.
