unit W004UModificaTabelloneFM;

interface

uses
  SysUtils, Classes, Controls, Forms, OracleData, StrUtils, Math, Variants,
  IWApplication, IWAppForm, IWVCLBaseContainer, IWContainer, IWRegion,
  IWCompLabel, IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl,
  IWControl, IWCompButton, IWHTMLContainer, IWHTML40Container, IWVCLComponent,
  IWBaseLayoutComponent, IWBaseContainerLayout, IWContainerLayout,
  IWTemplateProcessorHTML, medpIWMultiColumnComboBox, meIWEdit,
  IWDBGrids, medpIWDBGrid, meIWImageFile, meIWLabel, meIWCheckBox, A000UCostanti,
  A000UInterfaccia, R010UPaginaWeb, C018UIterAutDM, WC018URiepilogoIterFM, C190FunzioniGeneraliWeb,
  W001UIrisWebDtM, W004UReperibilitaDM, IWTypes, meIWButton, meIWComboBox,
  IWCompJQueryWidget, IWCompGrids, medpIWMessageDlg, C180FunzioniGenerali;

type
  TAutorizza = record
    Rowid:String;
    Checked:Boolean;
    Caption:TCaption;
  end;

  TW004FModificaTabelloneFM = class(TFrame)
    IWFrameRegion: TIWRegion;
    jQModificaTabellone: TIWJQueryWidget;
    grdPianificazione: TmedpIWDBGrid;
    IWTemplateProcessorHTML1: TIWTemplateProcessorHTML;
    btnSvuota: TmeIWButton;
    btnConferma: TmeIWButton;
    btnAnnulla: TmeIWButton;
    procedure IWFrameRegionCreate(Sender: TObject);
    procedure grdPianificazioneRenderCell(ACell: TIWGridCell; const ARow, AColumn: Integer);
    procedure btnSvuotaClick(Sender: TObject);
    procedure btnConfermaClick(Sender: TObject);
    procedure btnAnnullaClick(Sender: TObject);
  private
    TurnoModificato,RecordFittizio,RicaricaTurni: Boolean;
    OldTurno1,OldPrior1,OldTurno2,OldPrior2,OldTurno3,OldPrior3: String;
    procedure InserisciRecordFittizio;
    procedure CancellaRecordFittizio;
    procedure CaricaValoriOld;
    procedure TrasformaComponenti;
    procedure Uscita;
  public
    W004DM_Mod: TW004FReperibilitaDM;
    Data:TDateTime;
    Prog:Integer;
    Tipo:String;
    procedure CaricaGriglia;
    procedure AfterCancellazione;
    procedure AfterInserimento;
    procedure AfterModifica;
  end;

implementation

{$R *.dfm}

uses W004UReperibilita;

procedure TW004FModificaTabelloneFM.IWFrameRegionCreate(Sender: TObject);
begin
  Self.Parent:=(Self.Owner as TIWAppForm);
  OldTurno1:='';
  OldPrior1:='';
  OldTurno2:='';
  OldPrior2:='';
  OldTurno3:='';
  OldPrior3:='';
  TurnoModificato:=False;
  RecordFittizio:=False;
  RicaricaTurni:=True;
  (Self.Owner as TW004FReperibilita).grdModifica:=grdPianificazione;
end;

procedure TW004FModificaTabelloneFM.CaricaGriglia;
var Dipendente:String;
begin
  grdPianificazione.medpDataSet:=W004DM_Mod.selT380;
  grdPianificazione.DataSource:=W004DM_Mod.dsrT380Tab;

  with W004DM_Mod.selT380 do
  begin
    Filter:='(PROGRESSIVO = ' + IntToStr(Prog) + ') AND (DATA = ' + FloatToStr(Data) + ')';
    Filtered:=True;
    if RecordCount = 0 then
      InserisciRecordFittizio;
    Dipendente:=FieldByName('MATRICOLA').AsString + ' ' + FieldByName('T030NOMINATIVO').AsString;
  end;

  //Creazione ClientDataSet con stessa struttura del DataSet di partenza
  with grdPianificazione do
  begin
    medpCreaCDS;
    medpEliminaColonne;
    medpAggiungiColonna('MATRICOLA','Matricola','',nil);
    medpAggiungiColonna('DATA','Data','',nil);
    medpAggiungiColonna('DATA_GIORNO','gg','',nil);
    medpAggiungiColonna('TURNO1','Turno 1','',nil);
    medpColonna('TURNO1').Visible:=False;
    medpAggiungiColonna('C_TURNO1','Turno 1','',nil);
    medpAggiungiColonna('PRIORITA1','Priorità 1','',nil);
    medpColonna('PRIORITA1').Visible:=Tipo = 'R';
    medpAggiungiColonna('TURNO2','Turno 2','',nil);
    medpColonna('TURNO2').Visible:=False;
    medpAggiungiColonna('C_TURNO2','Turno 2','',nil);
    medpAggiungiColonna('PRIORITA2','Priorità 2','',nil);
    medpColonna('PRIORITA2').Visible:=Tipo = 'R';
    medpAggiungiColonna('TURNO3','Turno 3','',nil);
    medpColonna('TURNO3').Visible:=False;
    medpAggiungiColonna('C_TURNO3','Turno 3','',nil);
    medpAggiungiColonna('PRIORITA3','Priorità 3','',nil);
    medpColonna('PRIORITA3').Visible:=Tipo = 'R';
    if Parametri.CampiRiferimento.C3_DatoPianificabile <> '' then
      medpAggiungiColonna('DATOLIBERO',R180Capitalize(Parametri.CampiRiferimento.C3_DatoPianificabile),'',nil);
    medpAggiungiRowClick('DBG_ROWID',(Self.Owner as TW004FReperibilita).DBGridColumnClick);
    medpInizializzaCompGriglia;
    medpCaricaCDS;
  end;

  TrasformaComponenti;

  TR010FPaginaWeb(Self.Parent).VisualizzajQMessaggio(jQModificaTabellone,820,-1,Self.Height + 25,'Pianificazione turni di ' + IfThen(Tipo ='R','reperibilità','guardia') + ': ' + Dipendente,'#' + Name,False,True);
end;

procedure TW004FModificaTabelloneFM.InserisciRecordFittizio;
begin
  with W004DM_Mod.selT380 do
  begin
    Append;
    FieldByName('DATA').AsDateTime:=Data;
    FieldByName('PROGRESSIVO').AsInteger:=Prog;
    FieldByName('TIPOLOGIA').AsString:=Tipo;
    Post;
    Refresh;
    RecordFittizio:=True;
  end;
end;

procedure TW004FModificaTabelloneFM.CancellaRecordFittizio;
begin
  W004DM_Mod.selT380.Delete;
  SessioneOracle.Commit;
  RecordFittizio:=False;
end;

procedure TW004FModificaTabelloneFM.CaricaValoriOld;
var i:Integer;
begin
  with grdPianificazione do
  begin
    if medpCompGriglia[0].CompColonne[medpIndexColonna('C_TURNO1')] <> nil then
      OldTurno1:=Trim((medpCompCella(0,medpIndexColonna('C_TURNO1'),0) as TMedpIWMultiColumnComboBox).Text)
    else
      OldTurno1:=medpValoreColonna(0,'TURNO1');
    if medpCompGriglia[0].CompColonne[medpIndexColonna('PRIORITA1')] <> nil then
      OldPrior1:=Trim((medpCompCella(0,medpIndexColonna('PRIORITA1'),0) as TmeIWEdit).Text)
    else
      OldPrior1:=medpValoreColonna(0,'PRIORITA1');
    if medpCompGriglia[0].CompColonne[medpIndexColonna('C_TURNO2')] <> nil then
      OldTurno2:=Trim((medpCompCella(0,medpIndexColonna('C_TURNO2'),0) as TMedpIWMultiColumnComboBox).Text)
    else
      OldTurno2:=medpValoreColonna(0,'TURNO2');
    if medpCompGriglia[0].CompColonne[medpIndexColonna('PRIORITA2')] <> nil then
      OldPrior2:=Trim((medpCompCella(0,medpIndexColonna('PRIORITA2'),0) as TmeIWEdit).Text)
    else
      OldPrior2:=medpValoreColonna(0,'PRIORITA2');
    if medpCompGriglia[0].CompColonne[medpIndexColonna('C_TURNO3')] <> nil then
      OldTurno3:=Trim((medpCompCella(0,medpIndexColonna('C_TURNO3'),0) as TMedpIWMultiColumnComboBox).Text)
    else
      OldTurno3:=medpValoreColonna(0,'TURNO3');
    if medpCompGriglia[0].CompColonne[medpIndexColonna('PRIORITA3')] <> nil then
      OldPrior3:=Trim((medpCompCella(0,medpIndexColonna('PRIORITA3'),0) as TmeIWEdit).Text)
    else
      OldPrior3:=medpValoreColonna(0,'PRIORITA3');
  end;
end;

procedure TW004FModificaTabelloneFM.grdPianificazioneRenderCell(ACell: TIWGridCell; const ARow, AColumn: Integer);
var
  NumColonna:Integer;
  NomeCampo,Cod: String;
begin
  if not grdPianificazione.medpRenderCell(ACell,ARow,AColumn,True,True) then
    Exit;

  NumColonna:=grdPianificazione.medpNumColonna(AColumn);
  NomeCampo:=grdPianificazione.medpColonna(NumColonna).DataField;

  // assegnazione componenti alle celle
  if (ARow > 0) and (ARow - 1 <= High(grdPianificazione.medpCompGriglia)) and (grdPianificazione.medpCompGriglia[ARow - 1].CompColonne[NumColonna] <> nil) then
  begin
    ACell.Text:='';
    ACell.Control:=grdPianificazione.medpCompGriglia[ARow - 1].CompColonne[NumColonna];
  end;

  if (NomeCampo = 'MATRICOLA') or (NomeCampo = 'DATOLIBERO') then
    ACell.Css:='invisibile';

  if ARow > 0 then
  begin
    // allineamento al centro per alcuni campi
    if (NomeCampo = 'DATA') or
       (NomeCampo = 'DATA_GIORNO') or
       (Copy(NomeCampo,1,8) = 'PRIORITA') then
      ACell.Css:=ACell.Css + ' align_center';

    if (NomeCampo = 'C_TURNO1') and
       (ACell.Control = nil) then
    begin
      Cod:=grdPianificazione.medpValoreColonna(ARow - 1,'TURNO1');
      if Cod <> '' then
        ACell.Text:=Format('%s - %s',[Cod,VarToStr(WR000DM.selT350.Lookup('CODICE',Cod,'DESCRIZIONE'))]);
    end
    else if (NomeCampo = 'C_TURNO2') and
       (ACell.Control = nil) then
    begin
      Cod:=grdPianificazione.medpValoreColonna(ARow - 1,'TURNO2');
      if Cod <> '' then
        ACell.Text:=Format('%s - %s',[Cod,VarToStr(WR000DM.selT350.Lookup('CODICE',Cod,'DESCRIZIONE'))]);
    end
    else if (NomeCampo = 'C_TURNO3') and
       (ACell.Control = nil) then
    begin
      Cod:=grdPianificazione.medpValoreColonna(ARow - 1,'TURNO3');
      if Cod <> '' then
        ACell.Text:=Format('%s - %s',[Cod,VarToStr(WR000DM.selT350.Lookup('CODICE',Cod,'DESCRIZIONE'))]);
    end
    else if (NomeCampo = 'PRIORITA2') and
            (grdPianificazione.medpValoreColonna(ARow - 1,'TURNO2') = '') then
    begin
      ACell.Text:=''
    end
    else if (NomeCampo = 'PRIORITA3') and
            (grdPianificazione.medpValoreColonna(ARow - 1,'TURNO3') = '') then
    begin
      ACell.Text:='';
    end;
  end;
end;

procedure TW004FModificaTabelloneFM.TrasformaComponenti;
// Trasforma i componenti della riga indicata da text a control e viceversa per la grid grdPianificazione
var
  DaTestoAControlli:Boolean;
  i,j,c:Integer;
begin
  with grdPianificazione do
  begin
    i:=0;
    c:=medpIndexColonna('TURNO1');
    DaTestoAControlli:=medpCompGriglia[i].CompColonne[c] = nil;

    if DaTestoAControlli then
    begin
      // matricola
      c:=medpIndexColonna('MATRICOLA');
      medpPreparaComponenteGenerico('C',0,0,DBG_MECMB,'10','2','','','S');
      medpCreaComponenteGenerico(0,c,Componenti);
      with (medpCompCella(0,c,0) as TMedpIWMultiColumnComboBox) do
      begin
        PopUpHeight:=15;
        ShowHint:=True;
        AddRow(medpValoreColonna(i,'MATRICOLA') + ';');
        Text:=medpValoreColonna(i,'MATRICOLA');
      end;
      // data
      c:=medpIndexColonna('DATA');
      medpPreparaComponenteGenerico('C',0,0,DBG_EDT,'DATA','','','','S');
      medpCreaComponenteGenerico(0,c,Componenti);
      with (medpCompCella(0,c,0) as TmeIWEdit) do
      begin
        Text:=medpValoreColonna(i,'DATA');
        Css:=StringReplace(Css,'input_data_dmy','',[rfReplaceAll]);
        NonEditableAsLabel:=True;
        Editable:=False;
      end;
      // turno 1
      c:=medpIndexColonna('C_TURNO1');
      medpPreparaComponenteGenerico('C',0,0,DBG_MECMB,'10','2','','','S');
      medpCreaComponenteGenerico(i,c,Componenti);
      with (medpCompCella(i,c,0) as TMedpIWMultiColumnComboBox) do
      begin
        LookupColumn:=1;
        PopUpHeight:=15;
        ShowHint:=True;
        for j:=0 to (Self.Owner as TW004FReperibilita).lstTurniDisponibili.Count - 1 do
          AddRow((Self.Owner as TW004FReperibilita).lstTurniDisponibili[j]);
        Text:=medpValoreColonna(i,'TURNO1');
      end;
      // priorità chiamata turno 1
      c:=medpIndexColonna('PRIORITA1');
      medpPreparaComponenteGenerico('C',0,0,DBG_EDT,'1','','','','');
      medpCreaComponenteGenerico(i,c,Componenti);
      with (medpCompCella(i,c,0) as TmeIWEdit) do
      begin
        Text:=medpValoreColonna(i,'PRIORITA1');
        MaxLength:=1;
      end;
      // turno 2
      c:=medpIndexColonna('C_TURNO2');
      medpPreparaComponenteGenerico('C',0,0,DBG_MECMB,'10','2','','','S');
      medpCreaComponenteGenerico(i,c,Componenti);
      with (medpCompCella(i,c,0) as TMedpIWMultiColumnComboBox) do
      begin
        LookupColumn:=1;
        PopUpHeight:=15;
        ShowHint:=True;
        for j:=0 to (Self.Owner as TW004FReperibilita).lstTurniDisponibili.Count - 1 do
          AddRow((Self.Owner as TW004FReperibilita).lstTurniDisponibili[j]);
        Text:=medpValoreColonna(i,'TURNO2');
      end;
      // priorità chiamata turno 2
      c:=medpIndexColonna('PRIORITA2');
      medpPreparaComponenteGenerico('C',0,0,DBG_EDT,'1','','','','');
      medpCreaComponenteGenerico(i,c,Componenti);
      with (medpCompCella(i,c,0) as TmeIWEdit) do
      begin
        Text:=medpValoreColonna(i,'PRIORITA2');
        MaxLength:=1;
      end;
      // turno 3
      c:=medpIndexColonna('C_TURNO3');
      medpPreparaComponenteGenerico('C',0,0,DBG_MECMB,'10','2','','','S');
      medpCreaComponenteGenerico(i,c,Componenti);
      with (medpCompCella(i,c,0) as TMedpIWMultiColumnComboBox) do
      begin
        LookupColumn:=1;
        PopUpHeight:=15;
        ShowHint:=True;
        for j:=0 to (Self.Owner as TW004FReperibilita).lstTurniDisponibili.Count - 1 do
          AddRow((Self.Owner as TW004FReperibilita).lstTurniDisponibili[j]);
        Text:=medpValoreColonna(i,'TURNO3');
      end;
      // priorità chiamata turno 3
      c:=medpIndexColonna('PRIORITA3');
      medpPreparaComponenteGenerico('C',0,0,DBG_EDT,'1','','','','');
      medpCreaComponenteGenerico(i,c,Componenti);
      with (medpCompCella(i,c,0) as TmeIWEdit) do
      begin
        Text:=medpValoreColonna(i,'PRIORITA3');
        MaxLength:=1;
      end;
      // dato libero
      if Parametri.CampiRiferimento.C3_DatoPianificabile <> '' then
      begin
        // dato libero
        c:=medpIndexColonna('DATOLIBERO');
        medpPreparaComponenteGenerico('C',0,0,DBG_CMB,'20','','','','S');
        medpCreaComponenteGenerico(i,c,Componenti);
        with (medpCompCella(i,c,0) as TmeIWComboBox) do
        begin
          ItemsHaveValues:=True;
          Items.NameValueSeparator:=NAME_VALUE_SEPARATOR;
          Items.Assign((Self.Owner as TW004FReperibilita).lstDatoLibero);
          ItemIndex:=R180IndexOf(Items,medpValoreColonna(i,'DATOLIBERO'),(Self.Owner as TW004FReperibilita).DatoLiberoCodLen);
        end;
      end;
      CaricaValoriOld;
    end
    else
    begin
      // matricola
      FreeAndNil(medpCompGriglia[i].CompColonne[medpIndexColonna('MATRICOLA')]);
      // data
      FreeAndNil(medpCompGriglia[i].CompColonne[medpIndexColonna('DATA')]);
      // turno 1
      FreeAndNil(medpCompGriglia[i].CompColonne[medpIndexColonna('C_TURNO1')]);
      FreeAndNil(medpCompGriglia[i].CompColonne[medpIndexColonna('PRIORITA1')]);
      // turno 2
      FreeAndNil(medpCompGriglia[i].CompColonne[medpIndexColonna('C_TURNO2')]);
      FreeAndNil(medpCompGriglia[i].CompColonne[medpIndexColonna('PRIORITA2')]);
      // turno 3
      FreeAndNil(medpCompGriglia[i].CompColonne[medpIndexColonna('C_TURNO3')]);
      FreeAndNil(medpCompGriglia[i].CompColonne[medpIndexColonna('PRIORITA3')]);
      // dato libero
      if Parametri.CampiRiferimento.C3_DatoPianificabile <> '' then
        FreeAndNil(medpCompGriglia[i].CompColonne[medpIndexColonna('DATOLIBERO')]);
    end;
    medpBrowse:=not DaTestoAControlli;
  end;
end;

procedure TW004FModificaTabelloneFM.btnSvuotaClick(Sender: TObject);
begin
  with grdPianificazione do
  begin
    (medpCompCella(0,medpIndexColonna('C_TURNO1'),0) as TMedpIWMultiColumnComboBox).Text:='';
    (medpCompCella(0,medpIndexColonna('PRIORITA1'),0) as TmeIWEdit).Text:='';
    (medpCompCella(0,medpIndexColonna('C_TURNO2'),0) as TMedpIWMultiColumnComboBox).Text:='';
    (medpCompCella(0,medpIndexColonna('PRIORITA2'),0) as TmeIWEdit).Text:='';
    (medpCompCella(0,medpIndexColonna('C_TURNO3'),0) as TMedpIWMultiColumnComboBox).Text:='';
    (medpCompCella(0,medpIndexColonna('PRIORITA3'),0) as TmeIWEdit).Text:='';
  end;
end;

procedure TW004FModificaTabelloneFM.btnConfermaClick(Sender: TObject);
begin
  with grdPianificazione do
    if (Trim((medpCompCella(0,medpIndexColonna('C_TURNO1'),0) as TMedpIWMultiColumnComboBox).Text) = '')
    and (Trim((medpCompCella(0,medpIndexColonna('C_TURNO2'),0) as TMedpIWMultiColumnComboBox).Text) = '')
    and (Trim((medpCompCella(0,medpIndexColonna('C_TURNO3'),0) as TMedpIWMultiColumnComboBox).Text) = '')
    then
    begin
      if not RecordFittizio then
        (Self.Owner as TW004FReperibilita).Cancellazione(W004DM_Mod.selT380.Rowid)
      else
        raise exception.Create('Selezionare almeno un turno!');
    end
    else
    begin
      if RecordFittizio then
        (Self.Owner as TW004FReperibilita).Inserimento
      else
        (Self.Owner as TW004FReperibilita).Modifica(W004DM_Mod.selT380.Rowid);
    end;
end;

procedure TW004FModificaTabelloneFM.btnAnnullaClick(Sender: TObject);
begin
  RicaricaTurni:=False;
  Uscita;
end;

procedure TW004FModificaTabelloneFM.AfterCancellazione;
begin
  InserisciRecordFittizio;
  AfterModifica;
end;

procedure TW004FModificaTabelloneFM.AfterInserimento;
begin
  RecordFittizio:=False;
  W004DM_Mod.selT380.Refresh;
  AfterModifica;
end;

procedure TW004FModificaTabelloneFM.AfterModifica;
begin
  W004DM_Mod.selT380.Filter:='(PROGRESSIVO = ' + IntToStr(Prog) + ') AND (DATA = ' + FloatToStr(Data) + ')';
  W004DM_Mod.selT380.Filtered:=True;
  grdPianificazione.medpInizializzaCompGriglia;
  grdPianificazione.medpCaricaCDS;//Elimina anche i controlli
  TrasformaComponenti;//testo -> controlli
  Uscita;
end;

procedure TW004FModificaTabelloneFM.Uscita;
begin
  if RecordFittizio then
    CancellaRecordFittizio;
  W004DM_Mod.selT380.Filtered:=False;
  if RicaricaTurni then
    (Self.Owner as TW004FReperibilita).GetTurniPianificati;
  (Self.Owner as TW004FReperibilita).grdModifica:=nil;
  Free;
end;

end.
