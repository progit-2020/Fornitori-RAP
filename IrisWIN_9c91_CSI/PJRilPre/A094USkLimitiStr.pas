unit A094USkLimitiStr;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  R001UGESTTAB, StdCtrls, DBCtrls, ExtCtrls, Mask, DB, Menus, Buttons,
  ComCtrls, C700USelezioneAnagrafe, A000UCostanti, A000USessione,A000UInterfaccia, C180FUnzioniGenerali,
  C001UFiltroTabelleDtM, C001UFiltroTabelle, C001UScegliCampi, A002UInterfacciaSt, Grids, DBGrids, C005UDatiAnagrafici,
  Oracle, OracleData, ActnList, ImgList, ToolWin, SelAnagrafe, Variants,
  System.Actions, System.ImageList;

type
  TElencoDate = record
    Data:TDateTime;
    Colorata:Boolean;
  end;

  TA094FSkLimitiStr = class(TR001FGestTab)
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    DBGrid1: TDBGrid;
    TabSheet3: TTabSheet;
    DBGrid3: TDBGrid;
    TabSheet4: TTabSheet;
    DBGrid2: TDBGrid;
    Panel3: TPanel;
    Label1: TLabel;
    DBEdit1: TDBEdit;
    LCampo1: TLabel;
    DBLookupComboBox1: TDBLookupComboBox;
    DBText1: TDBText;
    LCampo2: TLabel;
    DBLookupComboBox2: TDBLookupComboBox;
    DBText2: TDBText;
    Panel4: TPanel;
    Label2: TLabel;
    DBEdit2: TDBEdit;
    RCampo1: TLabel;
    DBLookupComboBox3: TDBLookupComboBox;
    RCampo2: TLabel;
    DBLookupComboBox4: TDBLookupComboBox;
    DBText3: TDBText;
    DBText4: TDBText;
    PopupMenu1: TPopupMenu;
    Assegnazioneannua1: TMenuItem;
    DBGrid4: TDBGrid;
    frmSelAnagrafe: TfrmSelAnagrafe;
    TabSheet5: TTabSheet;
    DBGrid5: TDBGrid;
    procedure DButtonDataChange(Sender: TObject; Field: TField);
    procedure DBGrid1DrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure Stampa1Click(Sender: TObject);
    procedure DBLookupComboBox3KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormDestroy(Sender: TObject);
    procedure DButtonStateChange(Sender: TObject);
    procedure PageControl1Change(Sender: TObject);
    procedure TInserClick(Sender: TObject);
    procedure PageControl1Changing(Sender: TObject;
      var AllowChange: Boolean);
    procedure Assegnazioneannua1Click(Sender: TObject);
    procedure frmSelAnagrafeR003DatianagraficiClick(Sender: TObject);
    procedure frmSelAnagrafebtnSelezioneClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure DBGrid5EditButtonClick(Sender: TObject);
  private
    { Private declarations }
    ElencoMesi: array of TElencoDate;
    procedure CambiaProgressivo;
  public
    { Public declarations }
    DataCorrente:TDateTime;
    procedure CaricaElencoMesi;
    procedure GetSelAnagrafeInterna;
  end;

var
  A094FSkLimitiStr: TA094FSkLimitiStr;

procedure OpenA094LimitiStr(Prog:LongInt; Data:TDateTime);

implementation

uses A094USkLimitiStrDtM1, A008UListaGriglia;

{$R *.DFM}

procedure OpenA094LimitiStr(Prog:LongInt; Data:TDateTime);
begin
  SolaLetturaOriginale:=SolaLettura;
  SolaLettura:=False;
  case A000GetInibizioni('Funzione','OpenA094LimitiStr') of
    'N':begin
        ShowMessage('Funzione non abilitata!');
        Exit;
        end;
  end;
  A094FSkLimitiStr:=TA094FSkLimitiStr.Create(nil);
  with A094FSkLimitiStr do
    try
      DataCorrente:=Data;
      C700Progressivo:=Prog;
      A094FSkLimitiStrDtM1:=TA094FSkLimitiStrDtM1.Create(nil);
      ShowModal;
    finally
      SolaLettura:=SolaLetturaOriginale;
      A094FSkLimitiStrDtM1.Free;
      A094FSkLimitiStrDtM1:=nil;  // daniloc. 24.11.2009
      Free;
    end;
end;

procedure TA094FSkLimitiStr.FormShow(Sender: TObject);
var i:Integer;
begin
  inherited;
  PageControl1.ActivePage:=TabSheet1;
  DButton.DataSet:=A094FSkLimitiStrDtm1.Q820;
  DBGrid1.DataSource:=DButton;
  DButton.AutoEdit:=True;
  C700DatiVisualizzati:='MATRICOLA,T430BADGE,COGNOME,NOME';
  C700DatiSelezionati:=C700CampiBase;
  C700DataLavoro:=Parametri.DataLavoro;
  frmSelAnagrafe.OnCambiaProgressivo:=CambiaProgressivo;
  frmSelAnagrafe.CreaSelAnagrafe(SessioneOracle,StatusBar,2,True);
  // Lettura abilitazioni su I071
  dbGrid1.ReadOnly:=Parametri.A094_Mese = 'N';
  TOracleDataSet(dbGrid1.DataSource.DataSet).ReadOnly:=Parametri.A094_Mese = 'N';
  dbGrid4.ReadOnly:=Parametri.A094_Anno = 'N';
  TOracleDataSet(dbGrid4.DataSource.DataSet).ReadOnly:=Parametri.A094_Anno = 'N';
  TabSheet3.Enabled:=Parametri.A094_Raggr = 'S';
  TabSheet4.Enabled:=Parametri.A094_Raggr = 'S';
  TabSheet5.Enabled:=Parametri.A094_Raggr = 'S';
  for i:=dbGrid1.Columns.Count - 1 downto 0 do
    if (UpperCase(dbGrid1.Columns[i].FieldName) = 'CAUSALE') or
       (UpperCase(dbGrid1.Columns[i].FieldName) = 'DAL') or
       (UpperCase(dbGrid1.Columns[i].FieldName) = 'AL') then
      dbGrid1.Columns[i].Visible:=Parametri.CampiRiferimento.C15_LimitiMensCaus = 'S';
end;

procedure TA094FSkLimitiStr.CambiaProgressivo;
begin
  if C700OldProgressivo <> C700Progressivo then
  begin
    A094FSkLimitiStrDtM1.SettaProgressivo;
    NumRecords;
  end;
end;

procedure TA094FSkLimitiStr.DButtonDataChange(Sender: TObject; Field: TField);
begin
  inherited;
  with A094FSkLimitiStrDtM1 do
    if DButton.DataSet = Q820 then
    begin
      if (Field <> nil) and (DButton.State in [dsEdit,dsInsert]) then
        if Q820.FieldByName('CAUSALE').IsNull then
          if Q820.FieldByName('LIQUIDABILE').AsString = 'S' then
            Q820.FieldByName('CAUSALE').AsString:=A000LimiteMensileLiquidabile
          else if Q820.FieldByName('LIQUIDABILE').AsString = 'N' then
            Q820.FieldByName('CAUSALE').AsString:=A000LimiteMensileResiduabile;
    end;
end;

procedure TA094FSkLimitiStr.DButtonStateChange(Sender: TObject);
begin
  inherited;
  if DButton.DataSet = A094FSkLimitiStrDtM1.Q820 then
  begin
    actInserisci.Enabled:=actInserisci.Enabled and (Parametri.A094_Mese = 'S');
    actModifica.Enabled:=actModifica.Enabled and (Parametri.A094_Mese = 'S');
    actCancella.Enabled:=actCancella.Enabled and (Parametri.A094_Mese = 'S');
  end;
  if (DButton.DataSet = A094FSkLimitiStrDtM1.QAnno_810) or
     (DButton.DataSet = A094FSkLimitiStrDtM1.QANNO_811) or
     (DButton.DataSet = A094FSkLimitiStrDtM1.T800) then
  begin
    actInserisci.Enabled:=actInserisci.Enabled and (Parametri.A094_Raggr = 'S');
    actModifica.Enabled:=actModifica.Enabled and (Parametri.A094_Raggr = 'S');
    actCancella.Enabled:=actCancella.Enabled and (Parametri.A094_Raggr = 'S');
  end;
  frmSelAnagrafe.Enabled:=DButton.State = dsBrowse;
end;

procedure TA094FSkLimitiStr.PageControl1Change(Sender: TObject);
begin
  R001LinkC700:=PageControl1.ActivePage = TabSheet1;
  with A094FSkLimitiStrDtm1 do
  begin
    if PageControl1.ActivePage=TabSheet1 then
      begin
      DButton.DataSet:=Q820;
      DBGrid1.DataSource:=DButton;
      DButton.AutoEdit:=True;
      end;
    if PageControl1.ActivePage=TabSheet3 then
      begin
      DButton.DataSet:=QAnno_810;
      DBEdit1.DataSource:=DButton;
      DBLookupComboBox1.DataSource:=DButton;
      DBLookupComboBox2.DataSource:=DButton;
      A094FSkLimitiStraordMW.CambiaData(QAnno_810.FieldByName('ANNO').AsString,'L');
      DButton.AutoEdit:=False;
      end;
    if PageControl1.ActivePage=TabSheet4 then
      begin
      DButton.DataSet:=QANNO_811;
      DBEdit2.DataSource:=DButton;
      DBLookUpComboBox3.DataSource:=DButton;
      DBLookUpComboBox4.DataSource:=DButton;
      A094FSkLimitiStraordMW.CambiaData(QAnno_811.FieldByName('ANNO').AsString,'R');
      DButton.AutoEdit:=False;
      end;
    if PageControl1.ActivePage=TabSheet5 then
      begin
      DButton.DataSet:=T800;
      DBGrid1.DataSource:=DButton;
      DButton.AutoEdit:=True;
      end;
  end;
  NumRecords;
end;

procedure TA094FSkLimitiStr.TInserClick(Sender: TObject);
begin
   DButton.DataSet.Insert;
end;

procedure TA094FSkLimitiStr.PageControl1Changing(Sender: TObject;
  var AllowChange: Boolean);
begin
  if DButton.State in [dsEdit,dsInsert] then
    begin
    AllowChange:=False;
    Exit;
    end;
  with A094FSkLimitiStrDtm1 do
    begin
    if PageControl1.ActivePage=TabSheet1 then
      DBGrid1.DataSource:=nil;
    if PageControl1.ActivePage=TabSheet3 then
      begin
      DBEdit1.DataSource:=nil;
      DBLookupComboBox1.DataSource:=nil;
      DBLookupComboBox2.DataSource:=nil;
      end;
    if PageControl1.ActivePage=TabSheet4 then
      begin
      DBEdit2.DataSource:=nil;
      DBLookupComboBox3.DataSource:=nil;
      DBLookupComboBox4.DataSource:=nil;
      end;
    end;
end;

procedure TA094FSkLimitiStr.DBGrid5EditButtonClick(Sender: TObject);
begin
  inherited;
  if (DButton.State <> dsEdit) and (DButton.State <> dsInsert) then exit;
  A008FListaGriglia:=TA008FListaGriglia.Create(nil);
  A008FListaGriglia.Lista.Items.Clear;
  with A094FSkLimitiStrDtM1.A094FSkLimitiStraordMW.QCols do
  begin
    First;
    while not Eof do
    begin
      A008FListaGriglia.Lista.Items.Add(FieldByName('COLUMN_NAME').AsString);
      Next;
    end;
  end;

  with A008FListaGriglia do
    try
      Caption:='Campi per raggruppamento';
      if ShowModal = mrOk then
        if Lista.ItemIndex >= 0 then
          DbGrid5.SelectedField.AsString:=Lista.Items[Lista.ItemIndex];
    finally
      Release;
    end;
end;

procedure TA094FSkLimitiStr.Assegnazioneannua1Click(Sender: TObject);
var S,Tipo:String;
begin
  if DButton.State <> dsBrowse then
    exit;
  Tipo:='';
  if DButton.DataSet = A094FSkLimitiStrDtM1.QAnno_810 then
    Tipo:='L'
  else if DButton.DataSet = A094FSkLimitiStrDtM1.QAnno_811 then
    Tipo:='R';

  if Tipo = '' then
    exit;
  S:='00.00';
  if InputQuery('Assegnazione annua', 'Valore mensile:',S) then
  begin
    S:=R180MinutiOre(R180OreMinutiExt(S));
    A094FSkLimitiStrDtM1.A094FSkLimitiStraordMW.AssegnazioneAnnua(DButton.DataSet.FieldByName('Anno').AsInteger,
                                                                  DButton.DataSet.FieldByName('Campo1').AsString,
                                                                  DButton.DataSet.FieldByName('Campo2').AsString,
                                                                  Tipo,
                                                                  S);
  end;
end;

procedure TA094FSkLimitiStr.frmSelAnagrafeR003DatianagraficiClick(
  Sender: TObject);
begin
  C005DataVisualizzazione:=Parametri.DataLavoro;
  frmSelAnagrafe.R003DatianagraficiClick(Sender);
end;

procedure TA094FSkLimitiStr.GetSelAnagrafeInterna;
begin
  GetC700SelAnagrafeInterna;
end;

procedure TA094FSkLimitiStr.frmSelAnagrafebtnSelezioneClick(
  Sender: TObject);
begin
  C700DataLavoro:=Parametri.DataLavoro;
  frmSelAnagrafe.btnSelezioneClick(Sender);
end;

procedure TA094FSkLimitiStr.FormDestroy(Sender: TObject);
begin
  inherited;
  frmSelAnagrafe.DistruggiSelAnagrafe;
end;

procedure TA094FSkLimitiStr.DBLookupComboBox3KeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  if Key = vk_Delete then
  begin
    (Sender as TDBLookupComboBox).KeyValue:=null; 
    if (Sender as TDBLookupComboBox).Field <> nil then
      if (Sender as TDBLookupComboBox).DataSource.State in [dsEdit,dsInsert] then
        (Sender as TDBLookupComboBox).Field.Clear;
  end;
end;

procedure TA094FSkLimitiStr.Stampa1Click(Sender: TObject);
begin
  if PageControl1.ActivePage <> TabSheet1 then
  begin
    QueryStampa.Clear;
    NomiCampiR001.Clear;
    inherited;
  end
  else
  begin
    QueryStampa.Clear;
    QueryStampa.Add('select');
    QueryStampa.Add('T1.progressivo,');
    QueryStampa.Add('T1.anno,');
    QueryStampa.Add('T1.mese,');
    QueryStampa.Add('T1.dal,');
    QueryStampa.Add('T1.al,');
    QueryStampa.Add('T1.causale,');
    QueryStampa.Add('T1.liquidabile,');
    QueryStampa.Add('T1.ore_teoriche,');
    QueryStampa.Add('T1.ore,');
    QueryStampa.Add('T1.liquidabile_annuo,');
    QueryStampa.Add('T1.residuabile_annuo');
    QueryStampa.Add('from');
    QueryStampa.Add('(select progressivo,anno,SUBSTR(TO_CHAR(mese),1,2) mese,SUBSTR(TO_CHAR(dal),1,2) dal,SUBSTR(TO_CHAR(al),1,2) al,causale,');
    QueryStampa.Add('liquidabile,ore_teoriche,ore,'''' liquidabile_annuo,'''' residuabile_annuo');
    QueryStampa.Add('from t820_limitiind');
    QueryStampa.Add('UNION');
    QueryStampa.Add('select');
    QueryStampa.Add('progressivo,');
    QueryStampa.Add('anno,');
    QueryStampa.Add('''Dati annuali'' mese,');
    QueryStampa.Add(''''' dal,');
    QueryStampa.Add(''''' al,');
    QueryStampa.Add(''''' causale,');
    QueryStampa.Add(''''' liquidabile,');
    QueryStampa.Add(''''' ore_teoriche,');
    QueryStampa.Add(''''' ore,');
    QueryStampa.Add('liquidabile liquidabile_annuo,');
    QueryStampa.Add('residuabile residuabile_annuo');
    QueryStampa.Add('from t825_liquidindannuo');
    QueryStampa.Add(') T1');
    QueryStampa.Add('where T1.progressivo <> 0 order by progressivo,anno,mese');
    NomiCampiR001.Clear;
    NomiCampiR001.Add('T1.progressivo');
    NomiCampiR001.Add('T1.anno');
    NomiCampiR001.Add('T1.mese');
    NomiCampiR001.Add('T1.dal');
    NomiCampiR001.Add('T1.al');
    NomiCampiR001.Add('T1.causale');
    NomiCampiR001.Add('T1.liquidabile');
    NomiCampiR001.Add('T1.ore_teoriche');
    NomiCampiR001.Add('T1.ore');
    NomiCampiR001.Add('T1.liquidabile_annuo');
    NomiCampiR001.Add('T1.residuabile_annuo');
    inherited;
  end;
end;

procedure TA094FSkLimitiStr.DBGrid1DrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
var i:integer;
begin
  inherited;
  if gdFixed in State then exit;
  begin
    //Ciclo su tabella
    for i:=0 to High(ElencoMesi) do
      try
        if (ElencoMesi[i].Colorata) and (ElencoMesi[i].Data = EncodeDate(A094FSkLimitiStrDtM1.Q820.FieldByName('ANNO').AsInteger,A094FSkLimitiStrDtM1.Q820.FieldByName('MESE').AsInteger,1)) then
        begin
          if gdSelected in State then
          begin
            DBGrid1.Canvas.Brush.Color:=clHighLight;
            DBGrid1.Canvas.Font.Color:=clWhite;
          end
          else
          begin
            DBGrid1.Canvas.Brush.Color:=$00FFFF80;
            DBGrid1.Canvas.Font.Color:=clWindowText;
          end;
          DBGrid1.DefaultDrawColumnCell(Rect,DataCol,Column,State);
          Break;
        end;
      except
      end;
  end;
end;

procedure TA094FSkLimitiStr.CaricaElencoMesi;
var i:integer;
    Puntatore:TBookmark;
begin
  i:=0;
  with A094FSkLimitiStrDtM1.Q820 do
  begin
    SetLength(ElencoMesi,RecordCount);
    if RecordCount = 0 then
      exit;
    DisableControls;
    Puntatore:=GetBookmark;
  	{ TODO : TEST IW 15 }
    try
      First;
      ElencoMesi[i].Data:=EncodeDate(FieldByName('ANNO').AsInteger,FieldByName('MESE').AsInteger,1);
      inc(i);
      while not Eof do
      begin
        if ElencoMesi[i - 1].Data <> EncodeDate(FieldByName('ANNO').AsInteger,FieldByName('MESE').AsInteger,1) then
        begin
          ElencoMesi[i].Data:=EncodeDate(FieldByName('ANNO').AsInteger,FieldByName('MESE').AsInteger,1);
          ElencoMesi[i].Colorata:=not ElencoMesi[i - 1].Colorata;
          inc(i);
        end;
        Next;
      end;
      GotoBookmark(Puntatore);
    finally
      FreeBookmark(Puntatore);
    end;
    EnableControls;
  end;
end;

end.
