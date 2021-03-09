unit ToolbarFiglio;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Menus, StdCtrls, Buttons, ExtCtrls, ComCtrls, A000UCostanti, A000USessione, A000UInterfaccia,
  DBGrids, DBCtrls, DB, Oracle, OracleData,
  Variants, ActnList, ImgList, ToolWin, System.Actions, System.ImageList;

type
  TfrmToolbarFiglio = class(TFrame)
    tlbarFiglio: TToolBar;
    btnTFPrimo: TToolButton;
    btnTFPrec: TToolButton;
    btnTFSucc: TToolButton;
    btnTFUltimo: TToolButton;
    btnTFsep1: TToolButton;
    btnTFRefresh: TToolButton;
    btnTFsep2: TToolButton;
    btnTFInserisci: TToolButton;
    btnTFModifica: TToolButton;
    btnTFCancella: TToolButton;
    btnTFsep3: TToolButton;
    btnTFAnnulla: TToolButton;
    btnTFConferma: TToolButton;
    btnTFsep4: TToolButton;
    btnTFGomma: TToolButton;
    actlstToolbarFiglio: TActionList;
    imglstToolbarFiglio: TImageList;
    actTFPrimo: TAction;
    actTFPrec: TAction;
    actTFSucc: TAction;
    actTFUltimo: TAction;
    actTFRefresh: TAction;
    actTFInserisci: TAction;
    actTFModifica: TAction;
    actTFConferma: TAction;
    actTFAnnulla: TAction;
    actTFCancella: TAction;
    actTFGomma: TAction;
    btnTFsep0: TToolButton;
    actTFCopiaSu: TAction;
    btnTFCopiaSu: TToolButton;
    actTFRicerca: TAction;
    actTFStampa: TAction;
    btnTFRicerca: TToolButton;
    btnTFStampa: TToolButton;
    btnTFsep5: TToolButton;
    btnTFsep6: TToolButton;
    actTFGenerica1: TAction;
    btnTFsep7: TToolButton;
    btnTFGenerico1: TToolButton;
    actTFGenerica2: TAction;
    btnTFGenerico2: TToolButton;
    procedure actTFBrowseExecute(Sender: TObject);
    procedure actTFInserisciExecute(Sender: TObject);
    procedure actTFModificaExecute(Sender: TObject);
    procedure actTFCancellaExecute(Sender: TObject);
    procedure actTFGommaExecute(Sender: TObject);
    procedure actTFAnnullaExecute(Sender: TObject);
    procedure actTFConfermaExecute(Sender: TObject);
    procedure actTFRicercaExecute(Sender: TObject);
  private
    { Private declarations }
    procedure SetTFDButton(DS:TDataSource);
  public
    { Public declarations }
    DButton:TDataSource;
    TFDBGrid:TDBGrid;
    TFDBGridOptions:TDBGridOptions;
    TFCache:Boolean;
    TFSolaLettura,ConfermaCancella,RefreshDopoPost:Boolean;
    lstLock:array of TComponent;
    property TFDButton:TDataSource read DButton write SetTFDButton;
    procedure AbilitaAzioniTF(Sender: TObject);
    procedure DButtonStateChange(Sender: TObject);
  end;

implementation

uses C001URicerca;

{$R *.DFM}

(* Nello show della form in cui si inserisce questa toolbar,
   inserire il seguente codice:

  frmToolbarFiglio.TFDButton:=A007FProfiliOrariDtM1.D221;
  frmToolbarFiglio.TFDBGrid:=DBGrid1;
  //Per non richiedere la conferma della cancellazione:
  //frmToolbarFiglio.ConfermaCancella:=False;
  //Per gestire i pulsanti quando CachedUpdate:=False; (si considera lo state della singola riga invece che tutta l'operazione di inserimento/modifica)
  //A007FProfiliOrariDtM1.D221.OnStateChange:=frmToolbarFiglio2.DButtonStateChange;
  SetLength(frmToolbarFiglio.lstLock,4);
  frmToolbarFiglio.lstLock[0]:=Panel1;
  frmToolbarFiglio.lstLock[1]:=File1;
  frmToolbarFiglio.lstLock[2]:=Strumenti1;
  frmToolbarFiglio.lstLock[3]:=frmSelAnagrafe;
  frmToolbarFiglio.AbilitaAzioniTF(nil);
*)

procedure TfrmToolbarFiglio.SetTFDButton(DS:TDataSource);
begin
  DButton:=DS;
  ConfermaCancella:=True;
  TFSolaLettura:=SolaLettura;
  RefreshDopoPost:=False;
end;

procedure TfrmToolbarFiglio.actTFBrowseExecute(Sender: TObject);
var SavePlace: TBookmark;
begin
  if DButton = nil then
    exit;
  if Sender = actTFPrimo then
    DButton.DataSet.First
  else if Sender = actTFPrec then
    DButton.DataSet.Prior
  else if Sender = actTFSucc then
    DButton.DataSet.Next
  else if Sender = actTFUltimo then
    DButton.DataSet.Last
  else if Sender = actTFRefresh then
  begin
    SavePlace:=DButton.DataSet.GetBookmark;
    try
      DButton.DataSet.Refresh;
      try
        DButton.DataSet.GotoBookmark(SavePlace);
      except
      end;
    finally
      DButton.DataSet.FreeBookmark(SavePlace); { DONE : TEST IW 15 }
    end;
  end;
end;

procedure TfrmToolbarFiglio.actTFInserisciExecute(Sender: TObject);
begin
  if DButton = nil then
    exit;
  if TFSolaLettura then
    exit;
  if TFDBGrid <> nil then
  try
    TFDBGridOptions:=TFDBGrid.Options;
    TFDBGrid.Options:=[dgEditing,dgColumnResize,dgAlwaysShowEditor,dgTitles,dgIndicator,dgColLines,dgRowLines,dgTabs,dgConfirmDelete,dgCancelOnExit];
    if not ConfermaCancella then
      TFDBGrid.Options:=TFDBGrid.Options - [dgConfirmDelete];
    TFDBGrid.SelectedIndex:=0;
  except
  end;
  if TFCache then
    TOracleDataSet(DButton.DataSet).ReadOnly:=False;
  if TORacleDataSet(DButton.DataSet).RecNo = DButton.DataSet.RecordCount then
    DButton.DataSet.Append
  else
    DButton.DataSet.Insert;
  AbilitaAzioniTF(Sender);
end;

procedure TfrmToolbarFiglio.actTFModificaExecute(Sender: TObject);
begin
  if DButton = nil then
    exit;
  if TFSolaLettura then
    exit;
  if TFDBGrid <> nil then
  try
    TFDBGridOptions:=TFDBGrid.Options;
    TFDBGrid.Options:=[dgEditing,dgColumnResize,dgAlwaysShowEditor,dgTitles,dgIndicator,dgColLines,dgRowLines,dgTabs,dgConfirmDelete,dgCancelOnExit];
    if not ConfermaCancella then
      TFDBGrid.Options:=TFDBGrid.Options - [dgConfirmDelete];
    TFDBGrid.SelectedIndex:=0;
  except
  end;
  if TFCache then
  begin
    TOracleDataSet(DButton.DataSet).ReadOnly:=False;
    if TOracleDataSet(DButton.DataSet).UpdatesPending then
      TOracleDataSet(DButton.DataSet).CommitUpdates;
  end;
  DButton.DataSet.Edit;
  AbilitaAzioniTF(Sender);
end;

procedure TfrmToolbarFiglio.actTFRicercaExecute(Sender: TObject);
{Crea la form di ricerca e si posiziona sul record}
var i,j:Integer;
    ElencoCampi,Filtro:String;
    Valori,Campi:TStringList;
    Pippo:Variant;
begin
  Valori:=TStringList.Create;
  Campi:=TStringList.Create;
  ElencoCampi:='';
  C001FRicerca:=TC001FRicerca.Create(nil);
  with C001FRicerca,Dbutton.DataSet do
  try
    Grid.RowCount:=FieldCount + 1;
    j:=0;
    for i:=0 to FieldCount - 1 do
      if not((Fields[i].Calculated) or (Fields[i].Lookup)) then
      begin
        inc(j);
        Campi.Add(Fields[i].FieldName);
        Grid.Cells[0,j]:=Fields[i].DisplayLabel;
      end;
    Grid.RowCount:=Campi.Count + 1;
    if ShowModal = mrOk then
    begin
      Filtro:='';
      for i:=1 to Grid.RowCount - 1 do
        if Trim(Grid.Cells[1,i]) <> '' then
        begin
          ElencoCampi:=ElencoCampi + ';' + Campi[i-1];
          Valori.Add(Trim(Grid.Cells[1,i]));
          if Filtro <> '' then
            Filtro:=Filtro + ' AND ';
          Filtro:=Filtro + '(' + Campi[i-1] + '=' + '''' + StringReplace(Trim(Grid.Cells[1,i]),'%','*',[rfReplaceAll]) + ''')';
        end;
      if chkFiltro.Checked then
      begin
        FilterOptions:=[foCaseInsensitive];
        Filter:=Filtro;
        Filtered:=False;
        Filtered:=True;
      end
      else
        if Valori.Count > 0 then
        begin
          Pippo:=VarArrayCreate([0,Valori.Count - 1],VarVariant);
          for i:=0 to Valori.Count - 1 do
            Pippo[i]:=Valori[i];
          if Valori.Count > 1 then
            Locate(Copy(ElencoCampi,2,1000),Pippo,[loCaseInsensitive, loPartialKey])
          else
            Locate(Copy(ElencoCampi,2,1000),Valori[0],[loCaseInsensitive, loPartialKey])
        end;
    end;
  finally
    C001FRicerca.Free;
  end;
end;

procedure TfrmToolbarFiglio.actTFCancellaExecute(Sender: TObject);
var Cancella:Boolean;
begin
  if DButton = nil then
    exit;
  if TFSolaLettura then
    exit;
  if DButton.DataSet.RecordCount = 0 then
    exit;
  Cancella:=True;
  if ConfermaCancella then
    Cancella:=MessageDlg('Confermi cancellazione ?', mtInformation, [mbYes, mbNo], 0) = mrYes;
  if Cancella then
  begin
    if TFCache then
    begin
      TOracleDataSet(DButton.DataSet).ReadOnly:=False;
      DButton.DataSet.Delete;
      {$IFDEF WIN32}TOracleDataSet(DButton.DataSet).Session.ApplyUpdates([TOracleDataSet(DButton.DataSet)],True);{$ENDIF}
      TOracleDataSet(DButton.DataSet).ReadOnly:=True;
    end
    else
      DButton.DataSet.Delete;
  end;
end;

procedure TfrmToolbarFiglio.actTFAnnullaExecute(Sender: TObject);
begin
  TOracleDataSet(DButton.DataSet).CancelUpdates;
  if TFCache then
    TOracleDataSet(DButton.DataSet).ReadOnly:=True;
  if TFDBGrid <> nil then
  try
    TFDBGrid.Options:=TFDBGridOptions;
  except
  end;
  AbilitaAzioniTF(Sender);
end;

procedure TfrmToolbarFiglio.actTFConfermaExecute(Sender: TObject);
var SavePlace: TBookmark;
begin
  SavePlace:=DButton.DataSet.GetBookmark;
  try
    if DButton.DataSet.State in [dsEdit,dsInsert] then
      DButton.DataSet.Post;
    if TFCache then
    begin
      {$IFDEF WIN32}TOracleDataSet(DButton.DataSet).Session.ApplyUpdates([TOracleDataSet(DButton.DataSet)],True);{$ENDIF}
      TOracleDataSet(DButton.DataSet).ReadOnly:=True;
    end;
    if TFDBGrid <> nil then
    try
      TFDBGrid.Options:=TFDBGridOptions;
    except
    end;
    if RefreshDopoPost then
    begin
      DButton.DataSet.Refresh;
      if DButton.DataSet.BookmarkValid(SavePlace) then
        DButton.DataSet.GotoBookmark(SavePlace);
    end;
  finally
    { DONE : TEST IW 15 }
    DButton.DataSet.FreeBookmark(SavePlace);
  end;
  AbilitaAzioniTF(Sender);
end;

procedure TfrmToolbarFiglio.actTFGommaExecute(Sender: TObject);
var F:TField;
    AC:TControl;
begin
  if DButton = nil then
    exit;
  if DButton.DataSet.RecordCount = 0 then
    exit;
  if DButton.DataSet.State = dsBrowse then
    DButton.DataSet.Edit;
  F:=nil;
  AC:=TForm(Self.Owner).ActiveControl;
  if AC is TDBEdit then
    F:=(AC as TDBEdit).Field;
  if AC is TDBLookupComboBox then
    F:=(AC as TDBLookupComboBox ).DataSource.DataSet.FieldByName((AC as TDBLookupComboBox ).DataField);
  if AC is TDBComboBox then
    F:=(AC as TDBComboBox).Field;
  if AC is TDBGrid then
    F:=(AC as TDBGrid).SelectedField;
  if (F <> nil) and (not F.ReadOnly) then
    F.Clear;
end;

procedure TfrmToolbarFiglio.AbilitaAzioniTF(Sender: TObject);
var Modifica,Attivo:Boolean;
    i:Integer;
begin
  try
    TFCache:=TOracleDataSet(DButton.DataSet).CachedUpdates;
    Attivo:=TOracleDataSet(DButton.DataSet).Active;
    Modifica:=False;
    if Attivo then
      if TFCache then
        Modifica:=((Sender = actTFInserisci) or (Sender = actTFModifica))
      else
        Modifica:=DButton.State <> dsBrowse;
    actTFRicerca.Enabled:=Attivo and not Modifica;
    actTFPrimo.Enabled:=Attivo and (not Modifica or TFCache);
    actTFPrec.Enabled:=Attivo and (not Modifica or TFCache);
    actTFSucc.Enabled:=Attivo and (not Modifica or TFCache);
    actTFUltimo.Enabled:=Attivo and (not Modifica or TFCache);
    actTFRefresh.Enabled:=Attivo and not Modifica;
    actTFCopiaSu.Enabled:=Attivo and (not Modifica and not TFSolaLettura);
    actTFInserisci.Enabled:=Attivo and (not Modifica and not TFSolaLettura);
    actTFModifica.Enabled:=Attivo and (not Modifica and not TFSolaLettura);
    actTFCancella.Enabled:=Attivo and (not Modifica and not TFSolaLettura);
    actTFConferma.Enabled:=Attivo and Modifica;
    actTFAnnulla.Enabled:=Attivo and Modifica;
    actTFGomma.Enabled:=Attivo and Modifica;
    actTFStampa.Enabled:=Attivo and not Modifica;
    if not Attivo then
    begin
      actTFGenerica1.Enabled:=False;
      actTFGenerica2.Enabled:=False;
    end;
    for i:=0 to High(lstLock) do
      if lstLock[i] is TMenuItem then
        TMenuItem(lstLock[i]).Enabled:=not Modifica
      else if lstLock[i] is TAction then
        TAction(lstLock[i]).Enabled:=not Modifica
      else if lstLock[i] <> nil then
        TControl(lstLock[i]).Enabled:=not Modifica;
  except
  end;
end;

procedure TfrmToolbarFiglio.DButtonStateChange(Sender: TObject);
{Abilita/Disabilita i bottoni}
var Browse:Boolean;
    i:Integer;
begin
  Browse:=not (DButton.State in [dsInsert,dsEdit]);
  actTFRicerca.Enabled:=Browse;
  actTFPrimo.Enabled:=Browse;
  actTFPrec.Enabled:=Browse;
  actTFSucc.Enabled:=Browse;
  actTFUltimo.Enabled:=Browse;
  actTFRefresh.Enabled:=Browse;
  actTFCopiaSu.Enabled:=Browse and not TFSolaLettura;
  actTFInserisci.Enabled:=Browse and not TFSolaLettura;
  actTFModifica.Enabled:=Browse and not TFSolaLettura;
  actTFCancella.Enabled:=Browse and not TFSolaLettura;
  actTFConferma.Enabled:=not Browse;
  actTFAnnulla.Enabled:=not Browse;
  actTFGomma.Enabled:=not Browse;
  actTFStampa.Enabled:=Browse;
  for i:=0 to High(lstLock) do
    if lstLock[i] is TMenuItem then
      TMenuItem(lstLock[i]).Enabled:=Browse
    else if lstLock[i] is TAction then
      TAction(lstLock[i]).Enabled:=not Browse
    else
      TControl(lstLock[i]).Enabled:=Browse;
  if not Browse then
    TFDBGridOptions:=TFDBGrid.Options
  else if TFDBGridOptions <> [] then
    TFDBGrid.Options:=TFDBGridOptions;
end;

end.
