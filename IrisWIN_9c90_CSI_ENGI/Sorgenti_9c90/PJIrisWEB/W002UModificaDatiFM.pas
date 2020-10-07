unit W002UModificaDatiFM;

interface

uses
  W002UModificaDatiDM,
  A000UCostanti, A000UInterfaccia, C180FunzioniGenerali, C190FunzioniGeneraliWeb,
  SysUtils, Classes, Controls, Forms, IWAppForm, Variants,
  IWVCLBaseContainer, IWColor, IWContainer, IWRegion, IWHTMLContainer,
  IWHTML40Container, IWCompGrids, IWDBGrids, medpIWDBGrid, IWVCLBaseControl,
  IWBaseControl, IWBaseHTMLControl, IWControl, IWCompButton, meIWButton,
  IWCompJQueryWidget, IWVCLComponent, IWBaseLayoutComponent,
  IWBaseContainerLayout, IWContainerLayout, IWTemplateProcessorHTML,
  IWCompLabel, meIWLabel, meIWEdit;

type
  TW002FModificaDatiFM = class(TFrame)
    IWFrameRegion: TIWRegion;
    btnChiudi: TmeIWButton;
    btnOk: TmeIWButton;
    grdDati: TmedpIWDBGrid;
    IWTemplateProcessorFrame: TIWTemplateProcessorHTML;
    jQVisFrame: TIWJQueryWidget;
    lblInfo: TmeIWLabel;
    procedure IWFrameRegionCreate(Sender: TObject);
    procedure grdDatiRenderCell(ACell: TIWGridCell; const ARow,
      AColumn: Integer);
    procedure btnChiudiClick(Sender: TObject);
    procedure btnOkClick(Sender: TObject);
  private
  public
    W002ModDatiDM: TW002FModificaDatiDM;
    Progressivo: Integer;
    ArrIndex: Integer;
    Nominativo: String;
    Decorrenza: TDateTime;
    UpdateString: String;
    procedure Visualizza;
  end;

implementation

uses R010UPaginaWeb;

{$R *.dfm}

procedure TW002FModificaDatiFM.IWFrameRegionCreate(Sender: TObject);
begin
  Self.Parent:=(Self.Owner as TIWAppForm);
  Progressivo:=0;
  Nominativo:='';
  ArrIndex:=-1;
  Decorrenza:=DATE_MAX;
  UpdateString:='';
end;

procedure TW002FModificaDatiFM.Visualizza;
// pre: Progressivo deve essere valorizzato
//      ArrIndex    deve essere valorizzato
begin
  // precondizioni non verificate -> modifica impossibile
  if (Progressivo = 0) {or (ArrIndex = -1)} then
    raise Exception.Create('Si è verificato un errore: dipendente da modificare non indicato');

  // inizializzazione variabili
  UpdateString:='';

  // estrae decorrenza per aggiornamento dati
  Decorrenza:=W002ModDatiDM.GetDecorrenzaUpdate(Progressivo);
  lblInfo.Caption:='La variazione dei dati anagrafici sarà effettuata a decorrere dal ' + FormatDateTime('dd/mm/yyyy',Decorrenza);

  // imposta grid
  grdDati.medpPaginazione:=False;
  grdDati.medpDataSet:=W002ModDatiDM.cdsDatiAnag;
  grdDati.medpTestoNoRecord:='Nessun dato';
  grdDati.medpRowSelect:=False;
  grdDati.medpEditMultiplo:=True;
  grdDati.medpAttivaGrid(W002ModDatiDM.cdsDatiAnag,False,False,False);

  // porta la grid in modalità modifica
  grdDati.medpModifica(True);

  (Self.Parent as TR010FPaginaWeb).VisualizzajQMessaggio(jQVisFrame,550,-1,EM2PIXEL * 10,Nominativo + ': variazione dati anagrafici','#' + Name,False,True);
end;

procedure TW002FModificaDatiFM.btnOkClick(Sender: TObject);
var
  r: Integer;
  Modificato: Boolean;
  CampoT430,Tipo,ValStr: String;
  Val: Variant;
begin
  Modificato:=False;
  UpdateString:='';

  // verifica modifiche ai dati
  grdDati.medpDataSet.Cancel;
  grdDati.medpDataSet.First;
  for r:=0 to High(grdDati.medpCompGriglia) do
  begin
    CampoT430:=Copy(grdDati.medpDataSet.FieldByName('CAMPO').AsString,5); // rimuove prefisso "T430"
    grdDati.medpDataSet.Edit;
    grdDati.medpConferma(r);
    Val:=grdDati.medpDataSet.FieldByName('VALORE').Value;
    if Val <> grdDati.medpDataSet.FieldByName('VALORE_OLD').Value then
    begin
      if (grdDati.medpDataSet.FieldByName('VALORE').IsNull) or
         (VarToStr(Val) = '') then
      begin
        // valore nullo se il corrispondente in string è ''
        ValStr:='null'
      end
      else
      begin
        Tipo:=grdDati.medpDataSet.FieldByName('DATA_TYPE').AsString;
        if Tipo = 'VARCHAR2' then
          ValStr:=QuotedStr(VarToStr(Val))
        else if Tipo = 'DATE' then
          ValStr:=Format('to_date(''%s'',''dd/mm/yyyy'')',[FormatDateTime('dd/mm/yyyy',grdDati.medpDataSet.FieldByName('VALORE').AsDateTime)])
        else if Tipo = 'NUMBER' then
          ValStr:=grdDati.medpDataSet.FieldByName('VALORE').AsString
        else
          ValStr:=QuotedStr(VarToStr(Val)); // al momento non è possibile
      end;
      UpdateString:=UpdateString + Format('%s = %s,',[CampoT430,ValStr]);
      Modificato:=True;
    end;
    grdDati.medpDataSet.Next;
  end;
  grdDati.medpDataSet.First;
  grdDati.medpStato:=msBrowse;

  // valorizza la stringa di update
  if Modificato then
    UpdateString:=Copy(UpdateString,1,Length(UpdateString) - 1);
  Free;
end;

procedure TW002FModificaDatiFM.btnChiudiClick(Sender: TObject);
begin
  UpdateString:='';
  Free;
end;

procedure TW002FModificaDatiFM.grdDatiRenderCell(ACell: TIWGridCell; const ARow, AColumn: Integer);
var
  NumColonna, DataLength, DispWidth: Integer;
  DataType: String;
begin
  inherited;
  if not grdDati.medpRenderCell(ACell,ARow,AColumn,True,True,False) then
    Exit;

  NumColonna:=grdDati.medpNumColonna(AColumn);

  // assegnazione componenti
  if (ARow > 0) and (ARow <= High(grdDati.medpCompGriglia) + 1) and (grdDati.medpCompGriglia[ARow - 1].CompColonne[NumColonna] <> nil) then
  begin
    ACell.Text:='';
    ACell.Control:=grdDati.medpCompGriglia[ARow - 1].CompColonne[NumColonna];

    // impostazioni
    if ACell.Control is TmeIWEdit then
    begin
      DataType:=grdDati.medpClientDataSet.FieldByName('DATA_TYPE').AsString;
      DataLength:=grdDati.medpClientDataSet.FieldByName('DATA_LENGTH').AsInteger;
      DispWidth:=grdDati.medpClientDataSet.FieldByName('VALORE').DisplayWidth;

      if DataType = 'VARCHAR2' then
      begin
        // campo string
        with (ACell.Control as TmeIWEdit) do
        begin
          MaxLength:=DataLength;
          if DataLength < DispWidth then
            Css:=StringReplace(Css,C190GetCssWidthChr(DispWidth),C190GetCssWidthChr(DataLength),[]);
        end;
      end
      else if DataType = 'NUMBER' then
      begin
        // campo numerico
        with (ACell.Control as TmeIWEdit) do
        begin
          MaxLength:=DataLength;
          Css:=StringReplace(Css,C190GetCssWidthChr(DispWidth),C190GetCssWidthChr(DataLength),[]);
        end;
      end
      else if DataType = 'DATE' then
      begin
        // campo data
        with (ACell.Control as TmeIWEdit) do
        begin
          Css:=Css + ' input_data_dmy';
        end;
      end;
      if DebugHook <> 0 then
        (ACell.Control as TmeIWEdit).Hint:=Format('Debug: datatype = %s, datalength = %d',[DataType,DataLength]);
    end;
  end;
end;

end.
