unit W022UImpostaNoteFM;

interface

uses
  SysUtils, Classes, Controls, Forms, IWAppForm,
  IWVCLBaseContainer, IWContainer, IWRegion, IWHTMLContainer,
  IWHTML40Container, IWCompButton, IWVCLBaseControl, IWBaseControl,
  IWBaseHTMLControl, IWControl, IWVCLComponent,
  IWBaseLayoutComponent, IWBaseContainerLayout, IWContainerLayout,
  IWTemplateProcessorHTML, IWTypes, DBClient, IWDBGrids,
  DB, Oracle, StrUtils, Variants,
  A000UCostanti, A000UInterfaccia, C180FunzioniGenerali, C190FunzioniGeneraliWeb, R010UPAGINAWEB,
  W022USchedaValutazioniDtM,
  medpIWDBGrid, meIWMemo, medpIWMessageDlg, meIWButton, IWCompJQueryWidget, meIWImageFile,
  IWCompGrids;

type
  TW022FImpostaNoteFM = class(TFrame)
    IWFrameRegion: TIWRegion;
    jQImpostaNote: TIWJQueryWidget;
    IWTemplateProcessorFrame: TIWTemplateProcessorHTML;
    grdNote: TmedpIWDBGrid;
    cdsNote: TClientDataSet;
    dsrNote: TDataSource;
    btnApplica: TmeIWButton;
    btnChiudi: TmeIWButton;
    procedure btnChiudiClick(Sender: TObject);
    procedure IWFrameRegionCreate(Sender: TObject);
    procedure grdNoteRenderCell(ACell: TIWGridCell; const ARow, AColumn: Integer);
    procedure btnApplicaClick(Sender: TObject);
  private
    FComponenteHint:TIWCustomControl;
    NoteOriginali,colNote:String;
    NoteModificate,Validazione:Boolean;
    IdxNote:Integer;
    procedure CreaColonne;
    procedure PutComponenteHint(pComponenteHint:TIWCustomControl);
    procedure ResultExit(Sender: TObject; R: TmeIWModalResult; KI: String);
  public
    ReadOnly: Boolean;
    W022DtM3:TW022FSchedaValutazioniDtM;
    procedure Apri;
    procedure Visualizza;
    property ComponenteHint:TIWCustomControl read FComponenteHint write PutComponenteHint;
  end;

implementation

{$R *.dfm}

uses W022UDettaglioValutazioni;

procedure TW022FImpostaNoteFM.IWFrameRegionCreate(Sender: TObject);
begin
  Self.Parent:=TIWAppForm(Self.Owner);
  NoteOriginali:='';
  NoteModificate:=False;
end;

procedure TW022FImpostaNoteFM.Apri;
begin
  Validazione:=grdNote.medpDataSet = W022DtM3.cdsNoteValida;
  CreaColonne;
  btnApplica.Visible:=False;
  if not ReadOnly then
  begin
    btnApplica.Visible:=not Validazione;
    grdNote.medpPreparaComponenteGenerico('C',0,0,DBG_MEMO,'100%','','','','S');
    grdNote.medpCreaComponenteGenerico(0,IdxNote,grdNote.Componenti);
    TmeIWMemo(grdNote.medpCompCella(0,IdxNote,0)).Css:=TmeIWMemo(grdNote.medpCompCella(0,IdxNote,0)).Css + ' WC018memoheight';
    NoteOriginali:=Trim(grdNote.medpValoreColonna(0,colNote));
    TmeIWMemo(grdNote.medpCompCella(0,IdxNote,0)).Text:=NoteOriginali;
  end;
end;

procedure TW022FImpostaNoteFM.PutComponenteHint(pComponenteHint:TIWCustomControl);
begin
  FComponenteHint:=pComponenteHint;
end;

procedure TW022FImpostaNoteFM.CreaColonne;
begin
  grdNote.medpPaginazione:=False;
  grdNote.medpBrowse:=False;
  grdNote.medpCreaCDS;
  //Impostazione delle colonne da visualizzare sulla DBGrid
  grdNote.medpEliminaColonne;
  colNote:=IfThen(Validazione,'MOTIVAZIONE','NOTE_PUNTEGGIO');
  if Validazione then
    grdNote.medpAggiungiColonna(colNote,'Motivazione','',nil,nil)
  else
  begin
    grdNote.medpAggiungiColonna('COD_AREA','Cod. area','',nil,nil);
    grdNote.medpAggiungiColonna('D_AREA','Desc. area','',nil,nil);
    grdNote.medpAggiungiColonna('COD_VALUTAZIONE','Cod. elem.','',nil,nil);
    grdNote.medpAggiungiColonna('D_VALUTAZIONE','Desc. elem.','',nil,nil);
    grdNote.medpAggiungiColonna('COD_PUNTEGGIO','Cod. punt.','',nil,nil);
    grdNote.medpAggiungiColonna('D_PUNTEGGIO','Desc. punt.','',nil,nil);
    grdNote.medpAggiungiColonna(colNote,'Note','',nil,nil);
  end;
  IdxNote:=grdNote.medpIndexColonna(colNote);
  grdNote.medpInizializzaCompGriglia;
  grdNote.RigaInserimento:=False;
  grdNote.medpCaricaCDS;
end;

procedure TW022FImpostaNoteFM.Visualizza;
begin
  grdNote.Caption:=IfThen(Validazione,'Motivazione rifiuto','Note punteggio');
  TR010FPaginaWeb(Self.Parent).VisualizzajQMessaggio(jQImpostaNote,820,-1,EM2PIXEL * 24,grdNote.Caption,'#' + Name,False,True);
end;

procedure TW022FImpostaNoteFM.grdNoteRenderCell(ACell: TIWGridCell; const ARow, AColumn: Integer);
var
  NumColonna: Integer;
  Campo: String;
begin
  if not TmedpIWDBGrid(ACell.Grid).medpRenderCell(ACell,ARow,AColumn,True,True,False) then
    Exit;

  NumColonna:=grdNote.medpNumColonna(AColumn);
  Campo:=grdNote.medpColonna(NumColonna).DataField;

  // assegnazione stili
  if (ARow > 0) and (Length(grdNote.medpCompGriglia) > 0) then
  begin
    if R180In(Campo,['COD_AREA','COD_VALUTAZIONE','COD_PUNTEGGIO']) then
      ACell.Css:=ACell.Css + ' align_center'
    else if Campo = colNote then
      ACell.Css:=ACell.Css + ' WC018note';
    ACell.Wrap:=not R180In(Campo,['COD_AREA','COD_VALUTAZIONE','COD_PUNTEGGIO']);
  end;

  // Assegnazione componenti alle celle
  if (ARow > 0) and (ARow <= High(grdNote.medpCompGriglia) + 1) and (grdNote.medpCompGriglia[ARow - 1].CompColonne[NumColonna] <> nil) then
  begin
    ACell.Text:='';
    ACell.Control:=grdNote.medpCompGriglia[ARow - 1].CompColonne[NumColonna];
  end;
end;

procedure TW022FImpostaNoteFM.btnApplicaClick(Sender: TObject);
begin
  if btnApplica.Visible or Validazione then
    if NoteOriginali <> Trim(TmeIWMemo(grdNote.medpCompCella(0,IdxNote,0)).Text) then
    begin
      NoteOriginali:=Trim(TmeIWMemo(grdNote.medpCompCella(0,IdxNote,0)).Text);
      with grdNote.medpDataSet do
      begin
        Edit;
        FieldByName(colNote).AsString:=NoteOriginali;
        Post;
      end;
      NoteModificate:=True;
    end;
end;

procedure TW022FImpostaNoteFM.btnChiudiClick(Sender: TObject);
begin
  if Validazione then
    MsgBox.WebMessageDlg('La scheda verrà respinta ' + IfThen(Trim(TmeIWMemo(grdNote.medpCompCella(0,IdxNote,0)).Text) <> '','con la motivazione indicata','senza indicare una motivazione') + '. Confermare?',mtConfirmation,[mbYes,mbNo,mbCancel],ResultExit,'')
  else
  begin
    if (grdNote.medpCompCella(0,IdxNote,0) <> nil) and (NoteOriginali <> Trim(TmeIWMemo(grdNote.medpCompCella(0,IdxNote,0)).Text)) then
      MsgBox.WebMessageDlg('Salvare le modifiche alle note?',mtConfirmation,[mbYes,mbNo,mbCancel],ResultExit,'')
    else
      ResultExit(nil,mrYes,'');
  end;
end;

procedure TW022FImpostaNoteFM.ResultExit(Sender: TObject; R: TmeIWModalResult; KI: String);
begin
  if R = mrCancel then
    exit
  else
  begin
    if R = mrYes then
    begin
      btnApplicaClick(nil);
      if Validazione then
        with (Self.Owner as TW022FDettaglioValutazioni) do
          btnAvanzaStatoClick(btnRetrocediStato)
      else if NoteModificate then
      begin
        W022DtM3.Q711.Edit;
        W022DtM3.Q711.FieldByName('NOTE_PUNTEGGIO').AsString:=grdNote.medpDataSet.FieldByName(colNote).AsString;
        W022DtM3.Q711.Post; //L'ApplyUpdates o il CancelUpdates vanno fatti successivamente, perché il record appena modificato può non essere confermato
        ComponenteHint.Hint:=StringReplace(grdNote.medpDataSet.FieldByName(colNote).AsString,CRLF,' ',[rfReplaceAll]);
        if ComponenteHint is TmeIWImageFile then
          TmeIWImageFile(ComponenteHint).ImageFile.FileName:=IfThen(ComponenteHint.Hint <> '',fileImgElencoHighlight,fileImgElenco);
      end;
    end
    else if Validazione then
      (Self.Owner as TW022FDettaglioValutazioni).NoteValidaRichiesto:=False;
    Free;
  end;
end;

end.
