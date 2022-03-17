unit A083UMsgElaborazioni;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, SelAnagrafe, Oracle, C700USelezioneAnagrafe, A000UInterfaccia,
  ExtCtrls, StdCtrls, CheckLst, Mask, Buttons, A003UDataLavoroBis, ComCtrls,
  Grids, DBGrids, C180FunzioniGenerali, L021Call, R001UGestTab, ActnList,
  ImgList, DB, Menus, ToolWin, A000UCostanti, A000USessione, OracleData, C004UParamForm,
  Printers, Math, C012UVisualizzaTesto, System.Actions, A000UMessaggi, System.ImageList, InputPeriodo;

type
  TA083FMsgElaborazioni = class(TR001FGestTab)
    pnlFiltri: TPanel;
    DBGrid: TDBGrid;
    chkSelAnagrafe: TCheckBox;
    Splitter1: TSplitter;
    pmnuCheck: TPopupMenu;
    SelezionaTutto1: TMenuItem;
    Deselezionatutto1: TMenuItem;
    Invertiselezione1: TMenuItem;
    pmnuGrid: TPopupMenu;
    CopiainExcel1: TMenuItem;
    Copia1: TMenuItem;
    Panel2: TPanel;
    PnlAzienda: TPanel;
    ListChkAziende: TCheckListBox;
    lblAzienda: TLabel;
    PnlOperatore: TPanel;
    ListChkOperatori: TCheckListBox;
    lblOperatori: TLabel;
    PnlMaschere: TPanel;
    listChkMaschera: TCheckListBox;
    lblMaschere: TLabel;
    PnlTOperazioni: TPanel;
    listChkOperazioni: TCheckListBox;
    lblOperazioni: TLabel;
    Splitter2: TSplitter;
    Splitter3: TSplitter;
    Splitter4: TSplitter;
    PnlHideCampi: TPanel;
    Splitter5: TSplitter;
    ListChkHideCampi: TCheckListBox;
    LblHideCampi: TLabel;
    Selezionatutto2: TMenuItem;
    Deselezionatutto2: TMenuItem;
    Invertiselezione2: TMenuItem;
    N4: TMenuItem;
    pnlSelAnag: TPanel;
    frmSelAnagrafe: TfrmSelAnagrafe;
    chkUltimoMov: TCheckBox;
    pnlButton: TPanel;
    PrinterSetupDialog2: TPrinterSetupDialog;
    BtnChiudi: TBitBtn;
    BtnSalvaFile: TBitBtn;
    chkDettaglioCompleto: TCheckBox;
    frmInputPeriodo: TfrmInputPeriodo;
    procedure FormShow(Sender: TObject);
    procedure ListChkAziendeClickCheck(Sender: TObject);
    procedure chkSelAnagrafeClick(Sender: TObject);
    procedure actRefreshExecute(Sender: TObject);
    procedure SelezionaTutto1Click(Sender: TObject);
    procedure Deselezionatutto1Click(Sender: TObject);
    procedure Invertiselezione1Click(Sender: TObject);
    procedure pnlFiltriResize(Sender: TObject);
    procedure CopiainExcel1Click(Sender: TObject);
    procedure Copia1Click(Sender: TObject);
    procedure Selezionatutto2Click(Sender: TObject);
    procedure Deselezionatutto2Click(Sender: TObject);
    procedure Invertiselezione2Click(Sender: TObject);
    procedure Stampa1Click(Sender: TObject);
    procedure ListChkHideCampiClickCheck(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    //procedure BtnStampaClick(Sender: TObject);
    procedure BtnStampanteClick(Sender: TObject);
    procedure BtnChiudiClick(Sender: TObject);
    procedure BtnSalvaFileClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    VetOperatori:array of String;
    VetMaschere:array of String;
    VetOperazioni:array of String;
    ParAzienda,ParOperatore,
    ParMaschera,ParTipo:String;
    C004FParamFormPrv:TC004FParamForm;
    function GetOperatori:String;
    function GetMaschere:String;
    function GetOperazioni:String;
    function GetCampiChk(var LstChk:TCheckListBox):String;
    procedure PutParametri;
    procedure CaricaListChkHideCampi(ValIn:String);
    procedure CaricaList;
    procedure SizePanel;
    procedure CambiaProgressivo;
    procedure CaricaListChkAziende;
    procedure CaricaListChkOperatori;
    procedure CaricaListChkMaschera;
    procedure CaricaListChkOperazioni;
    procedure SviluppoQuery;
    procedure VerificaData(Data: TDateTime);
    { Metodi Property }
    function _GetDataI: TDateTime;
    procedure _PutDataI(const Value: TDateTime);
    function _GetDataF: TDateTime;
    procedure _PutDataF(const Value: TDateTime);
  public
    { Public declarations }
    procedure RefreshNumRecords;
    { Property }
    property DataI:TDateTime read _GetDataI write _PutDataI;
    property DataF:TDateTime read _GetDataF write _PutDataF;
  end;

var
  A083FMsgElaborazioni: TA083FMsgElaborazioni;

procedure OpenA083MsgElaborazioni(P_Azienda,P_Operatore,P_Maschera,P_Tipo:String);

implementation

uses A083UMsgElaborazioniDtm;

{$R *.dfm}

procedure OpenA083MsgElaborazioni(P_Azienda,P_Operatore,P_Maschera,P_Tipo:String);
begin
  SolaLetturaOriginale:=SolaLettura;
  SolaLettura:=False;
  if (P_Azienda = '') or (P_Operatore = '') or (P_Maschera = '') then
    case A000GetInibizioni('Funzione','OpenA083MsgElaborazioni') of
      'N':begin
          ShowMessage(A000MSG_ERR_FUNZ_NON_ABILITATA);
          Exit;
          end;
      'R':SolaLettura:=True;
    end;
  A083FMsgElaborazioni:=TA083FMsgElaborazioni.Create(nil);
  A083FMsgElaborazioniDtm:=TA083FMsgElaborazioniDtm.Create(nil);
  with A083FMsgElaborazioni do
    try
      ParAzienda:=P_Azienda;
      ParOperatore:=P_Operatore;
      ParMaschera:=P_Maschera;
      ParTipo:=P_Tipo;
      ShowModal;
    finally
      SolaLettura:=SolaLetturaOriginale;
      Free;
      A083FMsgElaborazioniDtm.Free;
    end;
end;

function TA083FMsgElaborazioni.GetCampiChk(var LstChk:TCheckListBox):String;
var i:integer;
begin
  Result:='';
  for i:=0 to LstChk.Items.Count - 1 do
    if LstChk.Checked[i] then
    begin
      if Result <> '' then
        Result:=Result + ',';
      Result:=Result + IntToStr(i);
    end;
end;

procedure TA083FMsgElaborazioni.PutParametri;
begin
  C004FParamFormPrv.Cancella001;
  C004FParamFormPrv.PutParametro(ListChkHideCampi.Name,GetCampiChk(ListChkHideCampi));
end;

procedure TA083FMsgElaborazioni.CaricaListChkHideCampi(ValIn:String);
var i:Integer;
    CampiChk:String;
begin
  CampiChk:=C004FParamFormPrv.GetParametro(ListChkHideCampi.Name,'');  //Deafault tutti visualizzati
  if ValIn <> '' then
    CampiChk:=ValIn;
  if CampiChk = '' then
    CampiChk:='1,5,6,7,8';
  ListChkHideCampi.Items.Clear;
  for i:=0 to DButton.DataSet.FieldCount - 1 do
  begin
    ListChkHideCampi.Items.Add(DButton.DataSet.Fields[i].DisplayLabel);
    DButton.DataSet.Fields[i].Visible:=(Pos(',' + IntToStr(i) + ',',',' + CampiChk + ',') > 0);
    ListChkHideCampi.Checked[ListChkHideCampi.Count-1]:=DButton.DataSet.Fields[i].Visible;
  end;
end;

procedure TA083FMsgElaborazioni.VerificaData(Data:TDateTime);
begin
  if Data <= 0 then
  begin
    R180MessageBox(A000MSG_ERR_DATA_ERRATA,'ERRORE');
    Abort;
  end;
end;

procedure TA083FMsgElaborazioni.SizePanel;
var NPanel:Integer;
begin
  NPanel:=0;
  if PnlAzienda.Visible then
    inc(NPanel);
  if PnlOperatore.Visible then
    inc(NPanel);
  if PnlMaschere.Visible then
    inc(NPanel);
  if PnlTOperazioni.Visible then
    inc(NPanel);
  if PnlHideCampi.Visible then
    inc(NPanel);
  PnlAzienda.Width:=A083FMsgElaborazioni.Width div NPanel;
  PnlOperatore.Width:=PnlAzienda.Width;
  PnlMaschere.Width:=PnlAzienda.Width;
  PnlTOperazioni.Width:=PnlAzienda.Width;
  PnlHideCampi.Width:=PnlAzienda.Width;
end;

procedure TA083FMsgElaborazioni.Stampa1Click(Sender: TObject);
var D:TDateTime;
    SQL:String;
begin
  R001LinkC700:=False;
  with A083FMsgElaborazioniDtm do
  begin
    QueryStampa.Clear;
    NomiCampiR001.Clear;
    if DButton.DataSet = selOutAnagrafe then
    begin
      QueryStampa.Add('SELECT I005.DATA, I005.MASCHERA, NVL(I005.OPERATORE,''SERVIZI_MONDOEDP'') AS OPERATORE,');
      QueryStampa.Add('NVL(NVL(I006.AZIENDA_MSG,I005.AZIENDA),''AZIN'') AS AZIENDA_MSG, I006.DATA_MSG, TRIM(I006.TIPO) AS TIPO,');
      QueryStampa.Add('I006.MSG, T030.COGNOME, T030.NOME, T030.MATRICOLA');
      QueryStampa.Add('FROM MONDOEDP.I005_MSGINFO I005, MONDOEDP.I006_MSGDATI I006, T030_ANAGRAFICO T030');
      QueryStampa.Add(' WHERE I005.ID = I006.ID');
      QueryStampa.Add('   AND T030.PROGRESSIVO(+) = I006.PROGRESSIVO');
      QueryStampa.Add(' AND NVL(NVL(I006.AZIENDA_MSG,I005.AZIENDA),''AZIN'') IN (' + GetAziende + ')');
      if GetOperatori <> '' then
        QueryStampa.Add(' AND NVL(NVL(I006.AZIENDA_MSG,I005.AZIENDA),''AZIN'')||''.''||NVL(I005.OPERATORE,''SERVIZI_MONDOEDP'') IN (' + GetOperatori + ')');
      if GetMaschere <> '' then
        QueryStampa.Add(' AND I005.MASCHERA IN (' + GetMaschere + ')');
      if GetOperazioni <> '' then
        QueryStampa.Add(' AND I006.TIPO IN (' + GetOperazioni + ')');
      if (DataI > 0) and (DataF > 0) then
        QueryStampa.Add(' AND TRUNC(I005.DATA) BETWEEN TO_DATE(''' + frmInputPeriodo.edtInizio.Text + ''',''DD/MM/YYYY'') AND TO_DATE(''' + frmInputPeriodo.edtFine.Text + ''',''DD/MM/YYYY'')');
      QueryStampa.Add('ORDER BY I005.ID DESC, I005.DATA');
      {Ora i campi MATRICOLA, COGNOME, NOME vengono visualizzati sempre
      NomiCampiR001.Add('T030.MATRICOLA');
      NomiCampiR001.Add('T030.COGNOME');
      NomiCampiR001.Add('T030.NOME');}
    end
    else
    begin
      SQL:=TOracleDataSet(DButton.DataSet).SubstitutedSQL;
      SQL:=StringReplace(SQL,', T030.COGNOME||'' ''||T030.NOME AS NOMINATIVO',',T030.COGNOME, T030.NOME',[]);
      QueryStampa.Add(SQL);
    end;
    NomiCampiR001.Add('I005.DATA');
    NomiCampiR001.Add('I005.MASCHERA');
    NomiCampiR001.Add('I005.OPERATORE');
    NomiCampiR001.Add('I006.AZIENDA_MSG');
    NomiCampiR001.Add('I006.DATA_MSG');
    NomiCampiR001.Add('I006.TIPO');
    NomiCampiR001.Add('I006.MSG');
    NomiCampiR001.Add('T030.COGNOME');
    NomiCampiR001.Add('T030.NOME');
    NomiCampiR001.Add('T030.MATRICOLA');
  end;
  inherited;
end;

procedure TA083FMsgElaborazioni.CaricaList;
begin
  with A083FMsgElaborazioniDtm do
  begin
    OpenselI005Valori('DISTINCT NVL(NVL(I005.AZIENDA_MSG,I005.AZIENDA),''AZIN'')||''.''||NVL(I005.OPERATORE,''SERVIZI_MONDOEDP'') AS OPERATORE');
    CaricaListChkOperatori;
    OpenselI005Valori('DISTINCT I005.MASCHERA');
    CaricaListChkMaschera;
    CaricaListChkOperazioni;
  end;
end;

procedure TA083FMsgElaborazioni.CaricaListChkAziende;
begin
  ////Riferirsi direttamente a MONDOEDP.I090_ENTI
  ListChkAziende.Items.Clear;
  with A083FMsgElaborazioniDtm do
  begin
    selI005Aziende.First;
    while Not selI005Aziende.Eof do
    begin
      ListChkAziende.Items.Add(selI005Aziende.FieldByName('AZIENDA').AsString);
      if pos(selI005Aziende.FieldByName('AZIENDA').AsString,ParAzienda) > 0 then
        ListChkAziende.Checked[ListChkAziende.Count-1]:=True;
      selI005Aziende.Next;
    end;
    if selI005Aziende.RecordCount <= 1 then
    begin
      ListChkAziende.Checked[0]:=True;
      ListChkAziende.Enabled:=False;
    end;
    PnlAzienda.Visible:=(ParAzienda = '');
  end;
end;

procedure TA083FMsgElaborazioni.CaricaListChkMaschera;
var i:Integer;
begin
  with A083FMsgElaborazioniDtm do
  begin
    ListChkMaschera.Items.Clear;
    SetLength(VetMaschere,0);
    selI005Valori.First;
    while not selI005Valori.Eof do
    begin
      i:=low(FunzioniDisponibili);
      //Caratto: 11/04/2013. Unificazione L021. Considero le maschere win e web (FunzioniDisponibili.S ,FunzioniDisponibili.SW)
      while i <= High(FunzioniDisponibili) do
      begin
        if L021VerificaMaschera(selI005Valori.FieldByName('MASCHERA').AsString,i) and
           L021VerificaApplicazione(Parametri.Applicazione,i) then
          Break;
        inc(i);
      end;
      if (i <= High(FunzioniDisponibili)) and
         (L021VerificaMaschera(selI005Valori.FieldByName('MASCHERA').AsString,i)) and
         L021VerificaApplicazione(Parametri.Applicazione,i) then
      begin
        SetLength(VetMaschere,High(VetMaschere) + 2);
        VetMaschere[High(VetMaschere)]:=selI005Valori.FieldByName('MASCHERA').AsString;
        ListChkMaschera.Items.Add(FunzioniDisponibili[i].N + ' (' + selI005Valori.FieldByName('MASCHERA').AsString + ') ');
      end
      else if selI005Valori.FieldByName('MASCHERA').AsString = 'B006' then
      begin
        SetLength(VetMaschere,High(VetMaschere) + 2);
        VetMaschere[High(VetMaschere)]:='B006';
        ListChkMaschera.Items.Add('Acquisizione automatica timbrature (B006)');
      end
      else if selI005Valori.FieldByName('MASCHERA').AsString = 'B013' then
      begin
        SetLength(VetMaschere,High(VetMaschere) + 2);
        VetMaschere[High(VetMaschere)]:='B013';
        ListChkMaschera.Items.Add('Integrazione anagrafica EMK (B013)');
      end
      else if selI005Valori.FieldByName('MASCHERA').AsString = 'B014' then
      begin
        SetLength(VetMaschere,High(VetMaschere) + 2);
        VetMaschere[High(VetMaschere)]:='B014';
        ListChkMaschera.Items.Add('Integrazione anagrafica (B014) ');
      end
      else if selI005Valori.FieldByName('MASCHERA').AsString = 'B015' then
      begin
        SetLength(VetMaschere,High(VetMaschere) + 2);
        VetMaschere[High(VetMaschere)]:='B015';
        ListChkMaschera.Items.Add('Scarico giustificativi (B015)');
      end
      else if selI005Valori.FieldByName('MASCHERA').AsString = 'B019' then
      begin
        SetLength(VetMaschere,High(VetMaschere) + 2);
        VetMaschere[High(VetMaschere)]:='B019';
        ListChkMaschera.Items.Add('Schedulatore di stampe (B019)');
      end
      //Caratto: 11/04/2013. Unificazione L021. b021 era prima presente su L021Call
      else if selI005Valori.FieldByName('MASCHERA').AsString = 'B021' then
      begin
        SetLength(VetMaschere,High(VetMaschere) + 2);
        VetMaschere[High(VetMaschere)]:='B021';
        ListChkMaschera.Items.Add('Servizi Web REST (B021)');
      end
      else if selI005Valori.FieldByName('MASCHERA').AsString = 'B027' then
      begin
        SetLength(VetMaschere,High(VetMaschere) + 2);
        VetMaschere[High(VetMaschere)]:='B027';
        ListChkMaschera.Items.Add('Servizo Cartellino (B027)');
      end
      else if selI005Valori.FieldByName('MASCHERA').AsString = 'P007' then
      begin
        SetLength(VetMaschere,High(VetMaschere) + 2);
        VetMaschere[High(VetMaschere)]:='P007';
        ListChkMaschera.Items.Add('Recupero DMA (P007)');
      end
      else if selI005Valori.FieldByName('MASCHERA').AsString = 'A077COM' then
      begin
        SetLength(VetMaschere,High(VetMaschere) + 2);
        VetMaschere[High(VetMaschere)]:='A077COM';
        ListChkMaschera.Items.Add('A077PCOMServer (A077)');
      end
      else if selI005Valori.FieldByName('MASCHERA').AsString = 'P077COM' then
      begin
        SetLength(VetMaschere,High(VetMaschere) + 2);
        VetMaschere[High(VetMaschere)]:='P077COM';
        ListChkMaschera.Items.Add('P077PCOMServer (P077)');
      end
      else if selI005Valori.FieldByName('MASCHERA').AsString = 'W000' then
      begin
        SetLength(VetMaschere,High(VetMaschere) + 2);
        VetMaschere[High(VetMaschere)]:='W000';
        ListChkMaschera.Items.Add('IrisWEB (W000)');
      end
      else if selI005Valori.FieldByName('MASCHERA').AsString = 'A004WEBSRV' then
      begin
        SetLength(VetMaschere,High(VetMaschere) + 2);
        VetMaschere[High(VetMaschere)]:='A004WEBSRV';
        ListChkMaschera.Items.Add('WebService Giustificativi (A004WEBSRV)');
      end
      else if selI005Valori.FieldByName('MASCHERA').AsString = 'A025WEBSRV' then
      begin
        SetLength(VetMaschere,High(VetMaschere) + 2);
        VetMaschere[High(VetMaschere)]:='A025WEBSRV';
        ListChkMaschera.Items.Add('WebService Turni (A025WEBSRV)');
      end
      else if selI005Valori.FieldByName('MASCHERA').AsString = 'A040WEBSRV' then
      begin
        SetLength(VetMaschere,High(VetMaschere) + 2);
        VetMaschere[High(VetMaschere)]:='A040WEBSRV';
        ListChkMaschera.Items.Add('WebService Turni reperibilità (A040WEBSRV)');
      end;
      if (Pos(',' + selI005Valori.FieldByName('MASCHERA').AsString + ',',',' + ParMaschera + ',') > 0) and
         (Not selI005Valori.FieldByName('MASCHERA').IsNull) then
        if listChkMaschera.Count > 0 then
          listChkMaschera.Checked[listChkMaschera.Count - 1]:=True;
      selI005Valori.Next;
    end;
    PnlMaschere.Visible:=(ParMaschera = '');
  end;
end;

procedure TA083FMsgElaborazioni.CaricaListChkOperatori;
var i:Integer;
begin
  with A083FMsgElaborazioniDtm do
  begin
    if Not selI005Valori.Active then
      Exit;
    ListChkOperatori.Items.Clear;
    SetLength(VetOperatori,0);
    SetLength(VetOperatori,selI005Valori.RecordCount);
    i:=0;
    selI005Valori.First;
    while Not selI005Valori.Eof do
    begin
      VetOperatori[i]:=selI005Valori.FieldByName('OPERATORE').AsString;
      ListChkOperatori.Items.Add(selI005Valori.FieldByName('OPERATORE').AsString);
      if selI005Valori.FieldByName('OPERATORE').AsString = (Parametri.Azienda + '.' + ParOperatore) then
        ListChkOperatori.Checked[ListChkOperatori.Count-1]:=True;
      inc(i);
      selI005Valori.Next;
    end;
    if ParOperatore <> '' then
      ListChkOperatori.Enabled:=False;

    PnlOperatore.Visible:=(ParOperatore = '');
  end;
end;

function TA083FMsgElaborazioni.GetOperatori:String;
var i:Integer;
begin
  Result:='';
  for i:=0 to ListChkOperatori.Items.Count - 1 do
    if ListChkOperatori.Checked[i] then
    begin
      if Result <> '' then
        Result:=Result + ', ';
      Result:=Result + '''' + VetOperatori[i] + '''';
    end;
end;

function TA083FMsgElaborazioni.GetOperazioni:String;
var i:Integer;
begin
  Result:='';
  for i:=0 to listChkOperazioni.Items.Count - 1 do
    if listChkOperazioni.Checked[i] then
    begin
      if Result <> '' then
        Result:=Result + ', ';
      Result:=Result + '''' + VetOperazioni[i] + '''';
    end;
end;

procedure TA083FMsgElaborazioni.Invertiselezione1Click(Sender: TObject);
var I:Integer;
begin
  inherited;
  for i:=0 to TCheckListBox(pmnuCheck.PopupComponent).Items.Count - 1 do
    TCheckListBox(pmnuCheck.PopupComponent).Checked[i]:=Not TCheckListBox(pmnuCheck.PopupComponent).Checked[i];

  if pmnuCheck.PopupComponent = ListChkHideCampi then
    for i:=0 to DButton.DataSet.FieldCount - 1 do
      DButton.DataSet.Fields[i].Visible:=Not DButton.DataSet.Fields[i].Visible;
end;

procedure TA083FMsgElaborazioni.Invertiselezione2Click(Sender: TObject);
begin
  inherited;
  R180DBGridSelezionaRighe(DBGrid,'C');
end;

function TA083FMsgElaborazioni.GetMaschere:String;
var i:Integer;
begin
  Result:='';
  for i:=0 to listChkMaschera.Items.Count - 1 do
    if listChkMaschera.Checked[i] then
    begin
      if Result <> '' then
        Result:=Result + ', ';
      Result:=Result + '''' +  VetMaschere[i] + '''';
    end;
end;

procedure TA083FMsgElaborazioni.CaricaListChkOperazioni;
var i:integer;
begin
  SetLength(VetOperazioni,0);
  SetLength(VetOperazioni,3);
  ListChkOperazioni.Items.Clear;
  ListChkOperazioni.Items.Add('Anomalie');
  VetOperazioni[0]:='A';
  ListChkOperazioni.Items.Add('Informazioni');
  VetOperazioni[1]:='I';
  ListChkOperazioni.Items.Add('Riepiloghi bloccati');
  VetOperazioni[2]:='B';
  PnlTOperazioni.Visible:=(ParTipo = '');
  for i:=0 to High(VetOperazioni) do
    if (pos(',' + VetOperazioni[i] + ',',',' + Partipo + ',') > 0) or (ParTipo = '') then
      ListChkOperazioni.Checked[i]:=True;
end;

procedure TA083FMsgElaborazioni.chkSelAnagrafeClick(Sender: TObject);
var i:Integer;
begin
  (*
  CaricaList;
  for i:=0 to ListChkAziende.Items.Count - 1 do
    ListChkAziende.Checked[i]:=False;
  *)
  ListChkAziende.Checked[ListChkAziende.Items.IndexOf(UpperCase(Parametri.Azienda))]:=True;
  frmSelAnagrafe.Enabled:=chkSelAnagrafe.Checked;
  frmSelAnagrafe.btnSelezione.Enabled:=chkSelAnagrafe.Checked;
  frmSelAnagrafe.btnEreditaSelezione.Enabled:=chkSelAnagrafe.Checked;
  ListChkAziende.Enabled:=(Not chkSelAnagrafe.Checked) and (A083FMsgElaborazioniDtm.selI005Aziende.RecordCount > 1) and (ParAzienda = '');
  (*
  if chkSelAnagrafe.Checked then
    CaricaListChkHideCampi(GetCampiChk(ListChkHideCampi));
  *)
end;

procedure TA083FMsgElaborazioni.Copia1Click(Sender: TObject);
begin
  inherited;
  R180DBGridCopyToClipboard(DBGrid,Sender = CopiaInExcel1, False);
end;

procedure TA083FMsgElaborazioni.CopiainExcel1Click(Sender: TObject);
begin
  inherited;
  R180DBGridCopyToClipboard(DBGrid,Sender = CopiaInExcel1, False);
end;

procedure TA083FMsgElaborazioni.Deselezionatutto1Click(Sender: TObject);
var I:Integer;
begin
  inherited;
  for i:=0 to TCheckListBox(pmnuCheck.PopupComponent).Items.Count - 1 do
    TCheckListBox(pmnuCheck.PopupComponent).Checked[i]:=False;

  if pmnuCheck.PopupComponent = ListChkHideCampi then
    for i:=0 to DButton.DataSet.FieldCount - 1 do
      DButton.DataSet.Fields[i].Visible:=False;
end;

procedure TA083FMsgElaborazioni.Deselezionatutto2Click(Sender: TObject);
begin
  inherited;
  R180DBGridSelezionaRighe(DBGrid,'N');
end;

procedure TA083FMsgElaborazioni.actRefreshExecute(Sender: TObject);
begin
  SviluppoQuery;
  CaricaListChkHideCampi(GetCampiChk(ListChkHideCampi));
  NumRecords;
  //inherited;
end;

procedure TA083FMsgElaborazioni.RefreshNumRecords;
begin
  NumRecords;
end;

procedure TA083FMsgElaborazioni.BtnChiudiClick(Sender: TObject);
begin
  inherited;
  Self.Close;
end;

procedure TA083FMsgElaborazioni.BtnSalvaFileClick(Sender: TObject);
const LR = 118;
var StrList:TStringList;
    S,S1,TempTxt:String;
    i,MsgIdx,UV,
    LungTxt,j,StartTxt:Integer;
  function LunghezzaCampo(F:TField):Integer;
  var j:Integer;
      Ultimo:Boolean;
  begin
    if F is TStringField then
    begin
      Result:=F.Size;
      Ultimo:=True;
      for j:=F.Index + 1 to F.DataSet.FieldCount - 1 do
        if F.Visible then Ultimo:=False;
      if Ultimo then
        Result:=1;
    end
    else
      Result:=F.DisplayWidth;
    Result:=Max(Result,Length(F.DisplayLabel));
  end;
begin
  StrList:=TStringList.Create;
  MsgIdx:=DButton.Dataset.FieldByName('MSG').Index;
  DButton.Dataset.FieldByName('MSG').Index:=DButton.Dataset.FieldCount - 1;
  with DButton do
  begin
    DataSet.First;
    DataSet.DisableControls;
    S:='';
    UV:=-1;
    for i:=0 to DataSet.FieldCount - 1 do
      if DataSet.Fields[i].Visible then
      begin
        S:=S + Format(' %-*s',[Lunghezzacampo(DataSet.Fields[i]), DataSet.Fields[i].DisplayLabel]);
        UV:=i;
      end;
    while not DataSet.Eof do
    begin
      S:='';
      for i:=0 to DataSet.FieldCount - 1 do
        if DataSet.Fields[i].Visible then
        begin
          S1:=DataSet.Fields[i].AsString;
          TempTxt:=S1;
          if i = UV then
          begin
            LungTxt:=LR - Length(S);//Spazio disponibile per il messaggio
            if LungTxt = 0 then LungTxt:=-1;
            if Length(S1) > (LungTxt - 1) then
            begin
              StartTxt:=1;
              TempTxt:='';
              for j:=0 to (Length(S1) div LungTxt) do
              begin
                TempTxt:=TempTxt + Copy(S1,StartTxt,LungTxt);
                if j < (Length(S1) div LungTxt) then
                  TempTxt:=TempTxt + #13#10 + Format('%*s',[Length(S)+1,'']);
                StartTxt:=StartTxt + LungTxt;
              end;
            end;
          end;
          S:=S + Format(' %-*s',[Lunghezzacampo(DataSet.Fields[i]), TempTxt]);
        end;
      StrList.Add(S);
      DataSet.Next;
    end;
    DataSet.First;
    DataSet.EnableControls;
  end;
  OpenC012VisualizzaTesto('<A083> Messaggi delle elaborazioni','',StrList,'');
  DButton.Dataset.FieldByName('MSG').Index:=MsgIdx;
  FreeAndNil(StrList);
end;

procedure TA083FMsgElaborazioni.BtnStampanteClick(Sender: TObject);
begin
  inherited;
  PrinterSetupDialog2.Execute;
end;

procedure TA083FMsgElaborazioni.CambiaProgressivo;
begin
  //FIX;
end;

procedure TA083FMsgElaborazioni.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  PutParametri;
  SessioneOracle.Commit;
end;

procedure TA083FMsgElaborazioni.FormCreate(Sender: TObject);
begin
  inherited;
  frmInputPeriodo.CaptionDataOutI:= 'Descrizione';
  frmInputPeriodo.CaptionDataOutF:= 'Descrizione';
end;

procedure TA083FMsgElaborazioni.FormDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(C004FParamFormPrv);
  frmSelAnagrafe.DistruggiSelAnagrafe;
end;

procedure TA083FMsgElaborazioni.FormShow(Sender: TObject);
begin
  inherited;
  //INIZIALIZZAZIONE C700
  C700DatiVisualizzati:='MATRICOLA,T430BADGE,COGNOME,NOME';
  C700DatiSelezionati:=C700CampiBase;
  C700DataLavoro:=Parametri.DataLavoro;
  frmSelAnagrafe.OnCambiaProgressivo:=CambiaProgressivo;
  frmSelAnagrafe.CreaSelAnagrafe(SessioneOracle,StatusBar,2,False);
  frmSelAnagrafe.NumRecords;
  C004FParamFormPrv:=CreaC004(SessioneOracle,'A083',Parametri.ProgOper,False);

  frmSelAnagrafe.Enabled:=chkSelAnagrafe.Checked;
  frmSelAnagrafe.btnSelezione.Enabled:=chkSelAnagrafe.Checked;
  frmSelAnagrafe.btnEreditaSelezione.Enabled:=chkSelAnagrafe.Checked;

  DataI:= Date;
  DataF:= Date;
  if RegistraMsg.ID > 0 then
    with A083FMsgElaborazioniDtm do
    begin
      GetDataDaID.SetVariable('ID',RegistraMsg.ID);
      GetDataDaID.Execute;
      DataI:=GetDataDaID.FieldAsDate(0);
      DataF:=GetDataDaID.FieldAsDate(0);
    end;
  if (ParAzienda = '') and (ParOperatore = '') and (ParMaschera = '') then
    chkUltimoMov.Visible:=False;
  chkUltimoMov.Checked:=chkUltimoMov.Visible;
  CaricaListChkAziende;
  CaricaList;
  SizePanel;
  SviluppoQuery;
  CaricaListChkHideCampi('');
  Self.WindowState:=wsMaximized;
end;

procedure TA083FMsgElaborazioni.SelezionaTutto1Click(Sender: TObject);
var I:Integer;
begin
  inherited;
  for i:=0 to TCheckListBox(pmnuCheck.PopupComponent).Items.Count - 1 do
    TCheckListBox(pmnuCheck.PopupComponent).Checked[i]:=True;

  if pmnuCheck.PopupComponent = ListChkHideCampi then
    for i:=0 to DButton.DataSet.FieldCount - 1 do
      DButton.DataSet.Fields[i].Visible:=True;
end;

procedure TA083FMsgElaborazioni.Selezionatutto2Click(Sender: TObject);
begin
  inherited;
  R180DBGridSelezionaRighe(DBGrid,'S');
end;

procedure TA083FMsgElaborazioni.SviluppoQuery;
var SQL:String;
    D:TDateTime;
begin
  VerificaData(DataI);
  VerificaData(DataF);
  with A083FMsgElaborazioniDtm do
  begin
    SQL:=' AND NVL(NVL(I006.AZIENDA_MSG,I005.AZIENDA),''AZIN'') IN (' + GetAziende + ')';
    if GetOperatori <> '' then
      SQL:=SQL + #13#10 + ' AND NVL(NVL(I006.AZIENDA_MSG,I005.AZIENDA),''AZIN'')||''.''||NVL(I005.OPERATORE,''SERVIZI_MONDOEDP'') IN (' + GetOperatori + ')';
    if GetMaschere <> '' then
      SQL:=SQL + #13#10 + ' AND I005.MASCHERA IN (' + GetMaschere + ')';
    if GetOperazioni <> '' then
      SQL:=SQL + #13#10 + ' AND I006.TIPO IN (' + GetOperazioni + ')';
    if (DataI > 0) and (DataF > 0) then
      SQL:=SQL + #13#10 + ' AND TRUNC(I005.DATA) BETWEEN TO_DATE(''' + frmInputPeriodo.edtInizio.Text + ''',''DD/MM/YYYY'') AND TO_DATE(''' + frmInputPeriodo.edtFine.Text + ''',''DD/MM/YYYY'')';
    if chkUltimoMov.Checked and (RegistraMsg.ID > 0) then
      SQL:=SQL + ' AND I005.ID = ' + IntToStr(RegistraMsg.ID);
    if chkDettaglioCompleto.Checked then
    begin
      SQL:='select I005.ID FROM MONDOEDP.I005_MSGINFO I005, MONDOEDP.I006_MSGDATI I006 WHERE I005.ID = I006.ID' + #13#10 + SQL;
      SQL:=Format('and I005.ID in (%s)',[SQL]);
    end;
    if (C700SelAnagrafe.Active) and chkSelAnagrafe.Checked then
    begin
      selOutAnagrafe.Close;
      selOutAnagrafe.SetVariable('FILTRO',SQL);
      C700MergeSelAnagrafe(selOutAnagrafe,False);
      C700MergeSettaPeriodo(selOutAnagrafe,Parametri.DataLavoro,Parametri.DataLavoro);
      selOutAnagrafe.Open;
      DButton.DataSet:=selOutAnagrafe;
    end
    else
    begin
      selOutPut.Close;
      selOutPut.SetVariable('FILTRO',SQL);
      selOutPut.Open;
      DButton.DataSet:=selOutPut;
    end;
  end;
end;

procedure TA083FMsgElaborazioni.ListChkAziendeClickCheck(Sender: TObject);
begin
  CaricaList;
end;

procedure TA083FMsgElaborazioni.ListChkHideCampiClickCheck(Sender: TObject);
var i:Integer;
begin
  inherited;
  i:=0;
  while (i <= DButton.DataSet.FieldCount - 1) and
        (DButton.DataSet.Fields[i].DisplayLabel <> ListChkHideCampi.Items[ListChkHideCampi.ItemIndex]) do
    inc(i);
  if (i > DButton.DataSet.FieldCount - 1) or
     (DButton.DataSet.Fields[i].DisplayLabel <> ListChkHideCampi.Items[ListChkHideCampi.ItemIndex]) then
    Exit;
  DButton.DataSet.Fields[i].Visible:=ListChkHideCampi.Checked[ListChkHideCampi.ItemIndex];
end;

procedure TA083FMsgElaborazioni.pnlFiltriResize(Sender: TObject);
begin
  inherited;
  Panel2.Height:=PnlFiltri.Height - 50;
  ListChkAziende.Height:=Panel2.Height - 20;
  ListChkOperatori.Height:=Panel2.Height - 20;
  listChkMaschera.Height:=Panel2.Height - 20;
  listChkOperazioni.Height:=Panel2.Height - 20;
  ListChkHideCampi.Height:=Panel2.Height - 20;
  SizePanel;
end;

{ DataI }
function TA083FMsgElaborazioni._GetDataI: TDateTime;
begin
  Result := frmInputPeriodo.DataInizio;
end;
procedure TA083FMsgElaborazioni._PutDataI(const Value: TDateTime);
begin
  frmInputPeriodo.DataInizio := Value;
end;
{ DataI----- }
{ DataF }
function TA083FMsgElaborazioni._GetDataF: TDateTime;
begin
  Result := frmInputPeriodo.DataFine;
end;
procedure TA083FMsgElaborazioni._PutDataF(const Value: TDateTime);
begin
  frmInputPeriodo.DataFine := Value;
end;
{ DataF----- }

end.
