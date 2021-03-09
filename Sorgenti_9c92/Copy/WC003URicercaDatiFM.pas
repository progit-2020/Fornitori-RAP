unit WC003URicercaDatiFM;

interface

uses
  SysUtils, Classes, Controls, Forms, Variants,
  IWVCLBaseContainer, IWContainer, IWRegion, IWHTMLContainer,
  IWHTML40Container, IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl,
  IWControl, IWVCLComponent, IWBaseLayoutComponent,
  IWBaseContainerLayout, IWContainerLayout, IWTemplateProcessorHTML,
  IWCompButton, OracleData, DB, IWCompEdit,
  WR010UBase, WR200UBaseFM,
  IWAdvRadioGroup, meTIWAdvRadioGroup, meIWButton, meIWGrid, meIWEdit,
  medpIWDBGrid, IWCompGrids, IWCompJQueryWidget, C190FunzioniGeneraliWeb;

type
  TGriglia = record
    NomeCampo:String;
    Edit:TIWCustomControl;
  end;

  TWC003FRicercaDatiFM = class(TWR200FBaseFM)
    grdRicercaDati: TmeIWGrid;
    btnOk: TmeIWButton;
    btnAnnulla: TmeIWButton;
    rgpTipologia: TmeTIWAdvRadioGroup;
    procedure grdRicercaDatiRenderCell(ACell: TIWGridCell; const ARow,
      AColumn: Integer);
    procedure btnAnnullaClick(Sender: TObject);
    procedure btnOkClick(Sender: TObject);
  private
    Griglia: array of TGriglia;
  public
    SearchDataset:TOracleDataset;
    SearchGrid:TIWCustomGrid;
    ResultEvent: TProc;
    procedure Visualizza;
    procedure ReleaseOggetti; override;
  end;

implementation

{$R *.dfm}

procedure TWC003FRicercaDatiFM.Visualizza;
var
  i,idx:Integer;
begin
  grdRicercaDati.ColumnCount:=2;
  grdRicercaDati.RowCount:=1;
  SetLength(Griglia,0);
  grdRicercaDati.Cell[0,0].Width:='20%';
  grdRicercaDati.Cell[0,1].Width:='25%';
  grdRicercaDati.Cell[0,0].Text:='Nome campo';
  grdRicercaDati.Cell[0,1].Text:='Valore';
  idx:=-1;
  for i:=0 to SearchDataset.Fields.Count - 1 do
  begin
    if SearchDataset.Fields[i].FieldKind = fkData then
    begin
      inc(idx);
      grdRicercaDati.RowCount:=grdRicercaDati.RowCount + 1;
      SetLength(Griglia,Length(Griglia) + 1);
      Griglia[idx].NomeCampo:=SearchDataset.Fields[i].FieldName;
      Griglia[idx].Edit:=TmeIWEdit.Create(Self);
      (Griglia[idx].Edit as TmeIWEdit).OnSubmit:=btnOkClick;
      (Griglia[idx].Edit as TmeIWEdit).Text:='';
      (Griglia[idx].Edit as TmeIWEdit).Css:='input_perc90 nomargin';
      grdRicercaDati.Cell[idx + 1,0].Text:=SearchDataset.Fields[i].DisplayLabel;
      grdRicercaDati.Cell[idx + 1,1].Control:=Griglia[idx].Edit;
    end;
  end;
  TWR010FBase(Self.Parent).VisualizzaJQMessaggio(jQuery,400,-1,EM2PIXEL * 50,'Ricerca dati','#wc003_container',False,True);
  if grdRicercaDati.RowCount > 1 then
    TWR010FBase(Self.Parent).ActiveControl:=(Griglia[0].Edit as TmeIWEdit);
end;

procedure TWC003FRicercaDatiFM.grdRicercaDatiRenderCell(ACell: TIWGridCell;
  const ARow, AColumn: Integer);
begin
  TWR010FBase(Self.Parent).RenderCell(ACell, ARow, AColumn, True, True);
end;

procedure TWC003FRicercaDatiFM.btnOkClick(Sender: TObject);
var
  i:Integer;
  RI,Filtro,Campo,Val,ElencoCampi:String;
  Valori:TStringList;
  VarValori:Variant;
begin
  TWR010FBase(Self.Parent).ActiveControl:=nil;

  ElencoCampi:='';
  Filtro:='';
  Valori:=TStringList.Create;
  try
    for i:=1 to grdRicercaDati.RowCount - 1 do
    begin
      Val:=Trim(TmeIWEdit(grdRicercaDati.Cell[i,1].Control).Text);
      if Val <> '' then
      begin
        //Campo:=grdRicercaDati.Cell[i,0].Text;
        Campo:=Griglia[i - 1].NomeCampo;
        ElencoCampi:=ElencoCampi + ';' + Campo;
        Valori.Add(Val);
        if Filtro <> '' then
          Filtro:=Filtro + ' AND ';
        Filtro:=Filtro + '(' + Campo + '=' + '''' + StringReplace(Val,'%','*',[rfReplaceAll]) + ''')';
      end;
    end;

    if rgpTipologia.ItemIndex = 0 then
    begin
      // ricerca
      if Valori.Count > 0 then
      begin
        ElencoCampi:=Copy(ElencoCampi,2,1000);
        if Valori.Count = 1 then
          SearchDataset.SearchRecord(ElencoCampi,Valori[0],[srFromBeginning,srIgnoreCase,srPartialMatch])
        else
        begin
          VarValori:=VarArrayCreate([0,Valori.Count - 1],VarVariant);
          for i:=0 to Valori.Count - 1 do
            VarValori[i]:=Valori[i];
          SearchDataset.SearchRecord(ElencoCampi,VarValori,[srFromBeginning,srIgnoreCase,srPartialMatch]);
          VarClear(VarValori);
        end;
      end;
    end
    else
    begin
      // filtro
      if SearchDataset.RowID <> '' then
        RI:=SearchDataset.RowID
      else
      begin
        VarValori:=VarArrayCreate([0,SearchDataset.FieldCount - 1],VarVariant);
        ElencoCampi:='';
        for i:=0 to SearchDataset.FieldCount - 1 do
          if SearchDataset.Fields[i].FieldKind = fkData then
          begin
            VarValori[i]:=SearchDataset.Fields[i].Value;
            ElencoCampi:=ElencoCampi + SearchDataset.Fields[i].FieldName + ';';
          end;
      end;
      SearchDataset.FilterOptions:=[foCaseInsensitive];
      SearchDataset.Filtered:=False;
      if Filtro <> '' then
      begin
        SearchDataset.Filter:=Filtro;
        SearchDataset.Filtered:=True;
      end;
      if RI <> '' then
        SearchDataset.SearchRecord('ROWID',RI,[srFromBeginning])
      else
      begin
        SearchDataset.SearchRecord(ElencoCampi,VarValori,[srFromBeginning]);
        VarClear(VarValori);
      end;
    end;
  finally
    Valori.Free;
  end;

  //TWR100FBase(Self.Parent).R010PagGridSeleziona(SearchGrid);
  if SearchGrid <> nil then
    if SearchGrid is TmedpIWDBGrid then
      TmedpIWDBGrid(SearchGrid).medpAggiornaCDS;

  if Assigned(ResultEvent) then
    ResultEvent();

  ReleaseOggetti;
  Free;
end;

procedure TWC003FRicercaDatiFM.btnAnnullaClick(Sender: TObject);
begin
  TWR010FBase(Self.Parent).ActiveControl:=nil;

  ReleaseOggetti;
  Free;
end;

procedure TWC003FRicercaDatiFM.ReleaseOggetti;
var
  i: Integer;
begin
  inherited;
  for i:=0 to Length(Griglia) - 1 do
    FreeAndNil(Griglia[i].Edit);
  SetLength(Griglia,0);
end;

end.
