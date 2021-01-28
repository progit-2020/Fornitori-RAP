unit C015UElencoValori;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, DBCtrls, Grids, DBGrids, ExtCtrls, Db, Oracle, OracleData, 
  Menus, ActnList, A000UInterfaccia,
  A000UCostanti, A000USessione, C180FunzioniGenerali, RegistrazioneLog,  Variants,
  ComCtrls, System.Actions;
type
  TC015FElencoValori = class(TForm)
    Panel1: TPanel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    DSelTab: TDataSource;
    pmnRicerca: TPopupMenu;
    Testocontenuto1: TMenuItem;
    SelTab: TOracleDataSet;
    ActionList1: TActionList;
    actRicercaTestoContenuto: TAction;
    actSuccessivo: TAction;
    Successivo1: TMenuItem;
    dgrdElencoValori: TDBGrid;
    N1: TMenuItem;
    Selezionatutto: TMenuItem;
    Deselezionatutto: TMenuItem;
    Invertiselezione: TMenuItem;
    N2: TMenuItem;
    Copia: TMenuItem;
    CopiainExcel: TMenuItem;
    StatusBar1: TStatusBar;
    procedure FormActivate(Sender: TObject);
    procedure dgrdElencoValoriTitleClick(Column: TColumn);
    procedure actRicercaTestoContenutoExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure SelTabBeforePost(DataSet: TDataSet);
    procedure SelTabAfterPost(DataSet: TDataSet);
    procedure SelTabBeforeDelete(DataSet: TDataSet);
    procedure SelTabAfterDelete(DataSet: TDataSet);
    procedure DSelTabDataChange(Sender: TObject; Field: TField);
    procedure SelTabTranslateMessage(Sender: TOracleDataSet;
      ErrorCode: Integer; const ConstraintName: String; Action: Char;
      var Msg: String);
    procedure dgrdElencoValoriDblClick(Sender: TObject);
    procedure SelTabAfterOpen(DataSet: TDataSet);
    procedure FormKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure SelezionatuttoClick(Sender: TObject);
    procedure DeselezionatuttoClick(Sender: TObject);
    procedure InvertiselezioneClick(Sender: TObject);
    procedure CopiaClick(Sender: TObject);
    procedure SelTabAfterScroll(DataSet: TDataSet);
    procedure BitBtn1Click(Sender: TObject);
  private
    { Private declarations }
    sPv_NomeTabella: string;
    sPv_SqlText:string;
    sPv_NomeCampiCodice:string;
    vPv_Codice:variant;
    vPv_ArrCodici:variant;
    ColonnaOrdinamento: Integer;
    OrdinamentoDiscendente: Boolean;
    TestoContenuto: String;
    bPv_Activate:boolean;
    ODSFL:TFieldList;
  public
    { Public declarations }
  end;

var
  C015FElencoValori: TC015FElencoValori;

procedure OpenC015FElencoValori(sNomeTabella: string; sCaption: string; sSqlText: String; sNomiCampiCodice:string; var vCodice,vArrCodici: variant; ODS:TOracleDataSet=nil; Larghezza:Integer=450; Altezza:Integer=280; PulsanteAnnulla:Boolean=True); overload;
procedure OpenC015FElencoValori(sNomeTabella: string; sCaption: string; sSqlText: String; sNomiCampiCodice:string; var vCodice: variant; ODS:TOracleDataSet=nil; Larghezza:Integer=450; Altezza:Integer=280; PulsanteAnnulla:Boolean=True); overload;
procedure OpenC015FElencoValori(OS: TOracleSession; sNomeTabella: string; sCaption: string; sSqlText: String; sNomiCampiCodice:string; var vCodice,vArrCodici: variant; ODS:TOracleDataSet=nil; Larghezza:Integer=450; Altezza:Integer=280; PulsanteAnnulla:Boolean=True); overload;

implementation

{$R *.DFM}

procedure OpenC015FElencoValori(sNomeTabella: string; sCaption: string; sSqlText: String; sNomiCampiCodice:string; var vCodice,vArrCodici: variant; ODS:TOracleDataSet=nil; Larghezza:Integer=450; Altezza:Integer=280; PulsanteAnnulla:Boolean=True);
{Serve per Gestire una tabella: oltre alla funzione di ricerca prevede anche inserimento/modifica/cancellazione e registraz. log}
//var i:Integer;
begin
  //Il parametro vCodice è un variant che permette di indicare più campi facenti parte del codice
  //Se il codice fosse formato dal campo PROGRESSIVO e dal campo DATA il parametro codice
  //dovrebbe essere passato, ad esempio, in questo modo:
  //var
  //  A: Variant;
  //begin
  //  A:= VarArrayOf([1, FormatDateTime('ddmmyyyy','01012002')]);
  //end;
  C015FElencoValori:=TC015FElencoValori.Create(nil);
  try
    C015FElencoValori.Width:=Larghezza;
    C015FElencoValori.Height:=Altezza;
    C015FElencoValori.Caption:=sCaption;
    C015FElencoValori.sPv_SqlText:=sSqlText;
    C015FElencoValori.sPv_NomeCampiCodice:=sNomiCampiCodice;
    C015FElencoValori.vPv_Codice:=vCodice;
    C015FElencoValori.sPv_NomeTabella:=sNomeTabella;
    C015FElencoValori.ODSFL:=nil;
    C015FElencoValori.BitBtn2.Visible:=PulsanteAnnulla;
    if ODS <> nil then
    begin
      if sSqlText = '' then
        C015FElencoValori.sPv_SqlText:=ODS.SQL.Text;
      C015FElencoValori.selTab.Variables.Assign(ODS.Variables);
      C015FElencoValori.selTab.Filtered:=ODS.Filtered;
      C015FElencoValori.selTab.Filter:=ODS.Filter;
      C015FElencoValori.selTab.OnFilterRecord:=ODS.OnFilterRecord;
      C015FElencoValori.ODSFL:=ODS.FieldList;
    end;
    if C015FElencoValori.ShowModal = mrOk then
    begin
      vCodice:=C015FElencoValori.vPv_Codice;
      vArrCodici:=C015FElencoValori.vPv_ArrCodici;
    end;
    //else
    //  vCodice:=null;
  finally
    C015FElencoValori.Free;
  end;
end;

procedure OpenC015FElencoValori(sNomeTabella: string; sCaption: string; sSqlText: String; sNomiCampiCodice:string; var vCodice: variant; ODS:TOracleDataSet=nil; Larghezza:Integer=450; Altezza:Integer=280; PulsanteAnnulla:Boolean=True);
{non è prevista la restituzine di codici multipli: il parametro vArrCodici non esite e viene passato in modo fittizio}
var A:Variant;
begin
  OpenC015FElencoValori(sNomeTabella,sCaption,sSqlText,sNomiCampiCodice,vCodice,A,ODS,Larghezza,Altezza,PulsanteAnnulla);
end;

procedure OpenC015FElencoValori(OS: TOracleSession; sNomeTabella: string; sCaption: string; sSqlText: String; sNomiCampiCodice:string; var vCodice,vArrCodici: variant; ODS:TOracleDataSet=nil; Larghezza:Integer=450; Altezza:Integer=280; PulsanteAnnulla:Boolean=True); overload;
begin
  A000SessioneIrisWIN.SessioneOracle:=OS;
  OpenC015FElencoValori(sNomeTabella,sCaption,sSqlText,sNomiCampiCodice,vCodice,vArrCodici,ODS,Larghezza,Altezza,PulsanteAnnulla);
end;

procedure TC015FElencoValori.FormCreate(Sender: TObject);
var i:Integer;
begin
  bPv_Activate:=False;
  ColonnaOrdinamento:=-1;
  if not(SessioneOracle.Connected) then
  begin
    if Password(Application.Name) = -1 then
      Application.Terminate;
    A000ParamDBOracle(SessioneOracle);
  end;
  for i:=0 to Self.ComponentCount - 1 do
    begin
    if Components[i] is TOracleQuery then
      (Components[i] as TOracleQuery).Session:=SessioneOracle;
    if Components[i] is TOracleDataSet then
      (Components[i] as TOracleDataSet).Session:=SessioneOracle;
    end;
end;

procedure TC015FElencoValori.FormKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (Key = 79) and (ssCtrl in Shift) then
    ModalResult:=mrOK;
end;

procedure TC015FElencoValori.InvertiselezioneClick(Sender: TObject);
begin
  R180DBGridSelezionaRighe(dgrdElencoValori,'C');
end;

procedure TC015FElencoValori.FormActivate(Sender: TObject);
begin
  with SelTab do
  begin
    Close;
    Sql.Text:=sPv_SqlText;
    Open;
  end;
  OrdinamentoDiscendente:=False;
  //Mi posiziono sul Codice che mi è stato passato
  try
    if (sPv_NomeCampiCodice <> '') and (not SelTab.SearchRecord(sPv_NomeCampiCodice, vPv_Codice, [srFromBeginning])) then
      SelTab.First;
  except
  end;
  bPv_Activate:=True;
  DSelTabDataChange(nil,nil);
  try
    dgrdElencoValori.SetFocus;
  except
  end;
  //StatusBar1.SimpleText:='Record ' + IntToStr(SelTab.RecNo) + '/' + IntToStr(SelTab.RecordCount);
end;

procedure TC015FElencoValori.dgrdElencoValoriDblClick(Sender: TObject);
begin
  ModalResult:=mrOK;
end;

procedure TC015FElencoValori.dgrdElencoValoriTitleClick(Column: TColumn);
var
  i:integer;
  sDep:string;
begin
  if Pos('ORDER BY',UpperCase(sPv_SqlText)) > 0 then
    SelTab.Sql.Text:=Copy(sPv_SqlText,1,Pos('ORDER BY',UpperCase(sPv_SqlText))-1)
  else
    SelTab.Sql.Text:=sPv_SqlText;

  if Column.Index = ColonnaOrdinamento then
    OrdinamentoDiscendente:=not(OrdinamentoDiscendente)
  else
    OrdinamentoDiscendente:=False;
  sDep:='';
  if OrdinamentoDiscendente then
    sDep:=Column.FieldName + ' DESC,'
  else
    sDep:=Column.FieldName + ',';
  for i:=0 to dgrdElencoValori.Columns.Count - 1 do
  begin
    if (dgrdElencoValori.Columns[i].Visible) and (dgrdElencoValori.Columns[i]<>Column) then
      sDep:=sDep + dgrdElencoValori.Columns[i].FieldName + ',';
  end;
  if sDep <> '' then
    sDep:='ORDER BY ' + Copy(sDep,1,length(sDep)-1);
  SelTab.SQL.Add(sDep);
  ColonnaOrdinamento:=Column.Index;
  SelTab.Close;
  SelTab.Open;
  dgrdElencoValori.SelectedIndex:=ColonnaOrdinamento;
end;

procedure TC015FElencoValori.actRicercaTestoContenutoExecute(
  Sender: TObject);
var
  Trovato: Integer;
begin
  if (Sender = actRicercaTestoContenuto) or (TestoContenuto = '') then
  begin
    TestoContenuto:=UpperCase(SelTab.FieldByName(dgrdElencoValori.Columns[dgrdElencoValori.SelectedIndex].FieldName).AsString);
    if InputQuery('Ricerca per testo contenuto',dgrdElencoValori.Columns[dgrdElencoValori.SelectedIndex].FieldName,TestoContenuto) then
    begin
      Trovato:=0;
      SelTab.DisableControls;
      while (not SelTab.Eof) and (Trovato = 0) do
      begin
        Trovato:=Pos(UpperCase(TestoContenuto),UpperCase(SelTab.FieldByName(dgrdElencoValori.Columns[dgrdElencoValori.SelectedIndex].FieldName).AsString));
        if Trovato = 0 then
          SelTab.Next;
      end;
      if Trovato = 0 then
      begin
        ShowMessage('Il testo "' + UpperCase(TestoContenuto) + '" non è contenuto in nessun elemento della colonna "' +
          dgrdElencoValori.Columns[dgrdElencoValori.SelectedIndex].FieldName +'"');
        SelTab.First;
      end;
      SelTab.EnableControls;
      dgrdElencoValori.SelectedRows.CurrentRowSelected:=True;
    end;
  end
  else
  begin
    Trovato:=0;
    SelTab.DisableControls;
    while (not SelTab.Eof) and (Trovato = 0) do
    begin
      if Trovato = 0 then
        SelTab.Next;
      Trovato:=Pos(UpperCase(TestoContenuto),UpperCase(SelTab.FieldByName(dgrdElencoValori.Columns[dgrdElencoValori.SelectedIndex].FieldName).AsString));
    end;
    if Trovato = 0 then
    begin
      ShowMessage('Il testo "' + UpperCase(TestoContenuto) + '" non è contenuto in nessun altro elemento della colonna "' +
        dgrdElencoValori.Columns[dgrdElencoValori.SelectedIndex].FieldName +'"');
      SelTab.First;
    end;
    SelTab.EnableControls;
    dgrdElencoValori.SelectedRows.CurrentRowSelected:=True;
  end;
end;

procedure TC015FElencoValori.BitBtn1Click(Sender: TObject);
var A:variant;
    i,r:Integer;
    sMyNomeCampi:TStringList;
begin
  if not bPv_Activate then
    exit;
  if sPv_NomeCampiCodice <> '' then
  begin
    sMyNomeCampi:=TStringList.Create;
    sMyNomeCampi.CommaText:=StringReplace(sPv_NomeCampiCodice,';',',',[rfReplaceAll]);
    //Creo un array contenente i valori dei campi facenti parte del codice
    A := VarArrayCreate([0, dgrdElencoValori.SelectedRows.Count - 1, 0, Pos(';',sPv_NomeCampiCodice)], varVariant);
    for r:=0 to dgrdElencoValori.SelectedRows.Count - 1 do
    begin
      selTab.GotoBookmark(dgrdElencoValori.SelectedRows.Items[r]);
      begin
        for i:=0 to sMyNomeCampi.Count-1 do
          A[r,i]:=SelTab.FieldByName(sMyNomeCampi[i]).asVariant;
      end;
    end;
    FreeAndNil(sMyNomeCampi);
  end;
  vPv_ArrCodici:=A;
end;

procedure TC015FElencoValori.BitBtn2Click(Sender: TObject);
begin
  vPv_Codice:=VarArrayOf(['']);
  vPv_ArrCodici:=VarArrayOf(['']);
end;

procedure TC015FElencoValori.SelTabBeforePost(DataSet: TDataSet);
begin
  case DataSet.State of
    dsInsert:RegistraLog.SettaProprieta('I',sPv_NomeTabella,Copy(Name,1,4),SelTab,True);
    dsEdit:RegistraLog.SettaProprieta('M',sPv_NomeTabella,Copy(Name,1,4),SelTab,True);
  end;
end;

procedure TC015FElencoValori.SelTabAfterPost(DataSet: TDataSet);
begin
  RegistraLog.RegistraOperazione;
end;

procedure TC015FElencoValori.SelTabAfterScroll(DataSet: TDataSet);
begin
  StatusBar1.SimpleText:='Record ' + IntToStr(SelTab.RecNo) + '/' + IntToStr(SelTab.RecordCount);
end;

procedure TC015FElencoValori.SelTabBeforeDelete(DataSet: TDataSet);
begin
  RegistraLog.SettaProprieta('C',sPv_NomeTabella,Copy(Name,1,4),SelTab,True);
end;

procedure TC015FElencoValori.SelezionatuttoClick(Sender: TObject);
begin
  R180DBGridSelezionaRighe(dgrdElencoValori,'S');
end;

procedure TC015FElencoValori.SelTabAfterDelete(DataSet: TDataSet);
begin
  RegistraLog.RegistraOperazione;
end;

procedure TC015FElencoValori.SelTabAfterOpen(DataSet: TDataSet);
var i:Integer;
begin
  try
    if ODSFL <> nil then
      for i:=0 to DataSet.FieldCount - 1 do
        if ODSFL.Find(DataSet.Fields[i].FieldName) <> nil then
        begin
          DataSet.Fields[i].Visible:=ODSFL.FieldByName(DataSet.Fields[i].FieldName).Visible;
          DataSet.Fields[i].DisplayLabel:=ODSFL.FieldByName(DataSet.Fields[i].FieldName).DisplayLabel;
          DataSet.Fields[i].DisplayWidth:=ODSFL.FieldByName(DataSet.Fields[i].FieldName).DisplayWidth;
        end
        else
          DataSet.Fields[i].Visible:=False;
  except
  end;
end;

procedure TC015FElencoValori.DSelTabDataChange(Sender: TObject;
  Field: TField);
var
  A:variant;
  i:integer;
  sMyNomeCampi:TStringList;
begin
  if not bPv_Activate then
    exit;
  //Valorizzo la variabile sPv_Codice
  if sPv_NomeCampiCodice <> '' then
  begin
    sMyNomeCampi:=TStringList.Create;
    sMyNomeCampi.CommaText:=StringReplace(sPv_NomeCampiCodice,';',',',[rfReplaceAll]);
    //Creo un array contenente i valori dei campi facenti parte del codice
    A := VarArrayCreate([0, Pos(';',sPv_NomeCampiCodice)], varVariant);
    for i:=0 to sMyNomeCampi.Count-1 do
      A[i]:=SelTab.FieldByName(sMyNomeCampi[i]).asVariant;
    vPv_Codice:=A;
    if vPv_Codice[0] = null then
      vPv_Codice:=VarArrayOf(['']);
    FreeAndNil(sMyNomeCampi);
  end;
end;

procedure TC015FElencoValori.SelTabTranslateMessage(Sender: TOracleDataSet;
  ErrorCode: Integer; const ConstraintName: String; Action: Char;
  var Msg: String);
begin
  If errorcode = 1 then
    Msg:='Elemento già esistente!' + #$D#$A + 'Chiave violata: ' + ConstraintName;
end;

procedure TC015FElencoValori.CopiaClick(Sender: TObject);
begin
  R180DBGridCopyToClipboard(dgrdElencoValori,Sender = CopiaInExcel);
end;

procedure TC015FElencoValori.DeselezionatuttoClick(Sender: TObject);
begin
  R180DBGridSelezionaRighe(dgrdElencoValori,'N');
end;

end.
