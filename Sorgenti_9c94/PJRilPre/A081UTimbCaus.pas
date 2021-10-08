unit A081UTimbCaus;
interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Buttons, DBCtrls, StdCtrls, Spin ,C001StampaLib, C180FunzioniGenerali,A000UCostanti, A000USessione,A000UInterfaccia,
  Grids, DBGrids, ExtCtrls,DB,ComCtrls, checklst, Menus, 
  A003UDataLavoroBis, C004UParamForm, QueryStorico, Oracle, SelAnagrafe,
  C700USelezioneAnagrafe, C005UDatiAnagrafici, Variants;

type
  TA081FTimbCaus = class(TForm)
    BtnPrinterSetUp: TBitBtn;
    BtnPreView: TBitBtn;
    BtnClose: TBitBtn;
    PrinterSetupDialog1: TPrinterSetupDialog;
    lblCampoRaggr: TLabel;
    dcmbCampoRaggr: TDBLookupComboBox;
    StatusBar: TStatusBar;
    ProgressBar: TProgressBar;
    CgpListaCausali: TCheckListBox;
    lblListaCausali: TLabel;
    LblDaData: TLabel;
    LblAData: TLabel;
    BtnDaData: TBitBtn;
    BtnAData: TBitBtn;
    chkTotData: TCheckBox;
    chkTotRaggr: TCheckBox;
    chkTotCaus: TCheckBox;
    BtnStampa: TBitBtn;
    chkSaltoCaus: TCheckBox;
    chkSaltoRaggr: TCheckBox;
    PopupMenu1: TPopupMenu;
    Selezionatutto1: TMenuItem;
    Annullatutto1: TMenuItem;
    chkTotGenerale: TCheckBox;
    chkStampaDett: TCheckBox;
    frmSelAnagrafe: TfrmSelAnagrafe;
    procedure dcmbCampoRaggrKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure BtnPrinterSetUpClick(Sender: TObject);
    procedure BtnPreViewClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure BtnDaDataClick(Sender: TObject);
    procedure BtnADataClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure Selezionatutto1Click(Sender: TObject);
    procedure Annullatutto1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure frmSelAnagrafeR003DatianagraficiClick(Sender: TObject);
    procedure frmSelAnagrafebtnSelezioneClick(Sender: TObject);
  Private
    CampoRagg,NomeCampo,ElencoCausali:String;
    function ControllaData(DataI,DataF:TDateTime):Boolean;
    function GetCausali:String;
    procedure ScorriQueryAnagrafica;
    procedure InserisciDipendente;
    procedure GetParametriFunzione;
    procedure PutParametriFunzione;
  public
    DaData,AData:TDateTime;
    DocumentoPDF,TipoModulo: string;
  end;

var
  A081FTimbCaus: TA081FTimbCaus;

procedure OpenA081TimbCaus(Prog:Integer);

implementation

uses A081UStampa, UInputTime, A081UTimbCausDtM1;

{$R *.DFM}

procedure OpenA081TimbCaus(Prog:Integer);
begin
  SolaLetturaOriginale:=SolaLettura;
  SolaLettura:=False;
  case A000GetInibizioni('Funzione','OpenA081TimbCaus') of
    'N':
        begin
        ShowMessage('Funzione non abilitata!');
        Exit;
        end;
    'R':SolaLettura:=True;
  end;
  A081FTimbCaus:=TA081FTimbCaus.Create(nil);
  C700Progressivo:=Prog;
  with A081FTimbCaus do
    try
      A081FTimbCausDtM1:=TA081FTimbCausDtM1.Create(nil);
      ShowModal;
    finally
      SolaLettura:=SolaLetturaOriginale;
      A081FTimbCausDtM1.Free;
      Free;
    end;
end;

procedure TA081FTimbCaus.FormCreate(Sender: TObject);
begin
  TipoModulo:='CS';
  A081FStampa:=TA081FStampa.Create(nil);
end;

procedure TA081FTimbCaus.FormShow(Sender: TObject);
begin
  CreaC004(SessioneOracle,'A081',Parametri.ProgOper);
  DaData:=R180InizioMese(Parametri.DataLavoro);
  AData:=R180FineMese(Parametri.DataLavoro);
  LblDaData.Caption:=FormatDateTime('dd MMM yyyy',DaData);
  LblAData.Caption:=FormatDateTime('dd MMM yyyy',AData);
  CgpListaCausali.Items.Clear;
  with A081FTimbCausDtM1.A081MW.Q305 do
    begin
    First;
    while not Eof do
      begin
      CgpListaCausali.Items.Add(Format('%-5s %s',[FieldByName('Codice').AsString,FieldByName('Descrizione').AsString]));
      Next;
      end;
    end;
  GetParametriFunzione;
  C700DatiVisualizzati:='MATRICOLA,T430BADGE,COGNOME,NOME';
  C700DatiSelezionati:=C700CampiBase;
  C700DataLavoro:=Parametri.DataLavoro;
  frmSelAnagrafe.CreaSelAnagrafe(SessioneOracle,StatusBar,0,False);
end;

function TA081FTimbCaus.ControllaData(DataI,DataF:TDateTime):Boolean;
begin
  Result:=(DataI <= DataF);
  BtnStampa.Enabled:=Result;
  if not(Result) then
    MessageDlg('La data iniziale non puo''' +#13+
               'essere precedente a quella finale',mtWarning,[mbOK],0);
end;

function GetTime(Time:TDateTime;Msg:String;ShowSeconds:Boolean):TDateTime;
begin
  FInputTime:=TFInputTime.Create(nil);
  FInputTime.TimeIn:=Time;
  FInputTime.ShowSeconds:=ShowSeconds;
  FInputTime.Caption:=Msg;
  FInputTime.ShowModal;
  Result:=FInputTime.TimeOut;
  FInputTime.Release;
end;

procedure TA081FTimbCaus.BtnPrinterSetUpClick(Sender: TObject);
begin
  if PrinterSetUpDialog1.Execute then
    C001SettaQuickReport(A081FStampa.RepR);
end;

procedure TA081FTimbCaus.InserisciDipendente;
var S:String;
    P:Variant;
begin
  with A081FTimbCausDtM1 do
    begin
      TabellaStampa.Insert;
      if CampoRagg <> '' then
        TabellaStampa.FieldByName('Gruppo').Value:=C700SelAnagrafe.FieldByName(CampoRagg).Value;
      P:=C700SelAnagrafe.FieldByName('T430Badge').Value;
      TabellaStampa.FieldByName('Badge').Value:=P;
      TabellaStampa.FieldByName('Cognome').Value:=C700SelAnagrafe.FieldByName('Cognome').AsString + ' ' + C700SelAnagrafe.FieldByName('Nome').AsString;
      TabellaStampa.FieldByName('Matricola').Value:=C700SelAnagrafe.FieldByName('Matricola').Value;
      TabellaStampa.FieldByName('Data').Value:=QGiustificativiAssenza.FieldByName('Data').AsDateTime;
      S:=QGiustificativiAssenza.FieldByName('Causale').AsString;
      TabellaStampa.FieldByName('Causale').Value:=S;
      TabellaStampa.FieldByName('Descrizione').Value:=VarToStr(A081MW.Q305.Lookup('Codice',S,'Descrizione'));
      TabellaStampa.Post;
    end;
end;

procedure TA081FTimbCaus.ScorriQueryAnagrafica;
begin
  with A081FTimbCausDtM1 do
    begin
    ProgressBar.Position:=0;
    ProgressBar.Max:=C700SelAnagrafe.RecordCount;
    C700SelAnagrafe.First;
    frmSelAnagrafe.ElaborazioneInterrompibile:=True;
    Self.Enabled:=False;
    try
      while not C700SelAnagrafe.EOF do
        begin
        frmSelAnagrafe.VisualizzaDipendente;
        //Impostazione query dei giustificativi
        with QGiustificativiAssenza do
          begin
          Close;
          SetVariable('Progressivo',C700Progressivo);
          SetVariable('Data1',DaData);
          SetVariable('Data2',AData);
          Open;
          while not Eof do
            begin
            InserisciDipendente;
            Next;
            end;
          end;
        ProgressBar.StepBy(1);
        C700SelAnagrafe.Next;
        end;
      finally
        frmSelAnagrafe.ElaborazioneInterrompibile:=False;
        Self.Enabled:=True;
        frmSelAnagrafe.VisualizzaDipendente;
        ProgressBar.Position:=0;
      end;
    end;
end;

procedure TA081FTimbCaus.BtnPreViewClick(Sender: TObject);
var App,S:String;
begin
  ElencoCausali:=GetCausali;
  if ElencoCausali = '' then
    raise Exception.Create('Nessuna causale selezionata');
  A081FTimbCausDtM1.CreaTabellaStampa;
  with A081FTimbCausDtM1.QGiustificativiAssenza do
    begin
    if Active then
      Close;
    DeleteVariables;
    SQL.Clear;
   //NOUVA SQL
    SQL.Add('SELECT PROGRESSIVO,DATA,CAUSALE');
    SQL.Add('FROM T100_TIMBRATURE T100');
    SQL.Add('WHERE PROGRESSIVO = :PROGRESSIVO AND');
    SQL.Add('DATA BETWEEN :DATA1 AND :DATA2 AND');
    S:='''O'',''I''';
    SQL.Add('FLAG IN (' + S + ') AND');
    SQL.Add('CAUSALE IN (' + ElencoCausali + ')');
    SQL.Add('ORDER BY PROGRESSIVO,DATA');
    DeclareVariable('PROGRESSIVO',otInteger);
    DeclareVariable('DATA1',otDate);
    DeclareVariable('DATA2',otDate);
    end;
  if (dcmbCampoRaggr.KeyValue <> Null) then
  begin
    App:=dcmbCampoRaggr.KeyValue;
    NomeCampo:=dcmbCampoRaggr.Text;
    CampoRagg:=App;
    S:=C700SelAnagrafe.SQL.Text;
    if R180InserisciColonna(S,App) then
    begin
      C700SelAnagrafe.CloseAll;
      C700SelAnagrafe.SQL.Text:=S;
    end;
  end;
  with C700SelAnagrafe do
    begin
    if GetVariable('DataLavoro') <> AData then
      begin
      Close;
      SetVariable('DataLavoro',AData);
      end;
    Open;
    frmSelAnagrafe.NumRecords;
    end;
  ScorriQueryAnagrafica;
  A081FStampa.CampoRagg:=CampoRagg;
  A081FStampa.NomeCampo:=NomeCampo;
  A081FStampa.DaData:=DaData;
  A081FStampa.AData:=AData;
  A081FStampa.CreaReport(Sender = BtnPreView);
  A081FTimbCausDtM1.TabellaStampa.Close;
end;

function TA081FTimbCaus.GetCausali:String;
var i:Integer;
begin
  Result:='';
  for i:=0 to CgpListaCausali.Items.Count - 1 do
    if CgpListaCausali.Checked[i] then
      begin
      if Result <> '' then Result:=Result + ',';
      Result:=Result + '''' + Trim(Copy(CgpListaCausali.Items[i],1,5)) + '''';
      end;
end;

procedure TA081FTimbCaus.BtnDaDataClick(Sender: TObject);
begin
  DaData:=DataOut(DaData,'Dalla data:','G');
  LblDaData.Caption:=FormatDateTime('dd mmm yyyy',DaData);
  ControllaData(DaData,AData);
end;

procedure TA081FTimbCaus.BtnADataClick(Sender: TObject);
begin
  AData:=DataOut(AData,'Alla data:','G');
  LblAData.Caption:=FormatDateTime('dd mmm yyyy',AData);
  ControllaData(DaData,AData);
end;

procedure TA081FTimbCaus.Selezionatutto1Click(Sender: TObject);
var i:Integer;
begin
  for i:=0 to CgpListaCausali.Items.Count - 1 do
    CgpListaCausali.Checked[i]:=True;
end;

procedure TA081FTimbCaus.Annullatutto1Click(Sender: TObject);
var i:Integer;
begin
  for i:=0 to CgpListaCausali.Items.Count - 1 do
    CgpListaCausali.Checked[i]:=False;
end;

procedure TA081FTimbCaus.GetParametriFunzione;
{Leggo i parametri della form}
var x, y, i,r:integer;
    e: boolean;
    svalore, snome, selemento:string;
begin
  with A081FTimbCaus do
    begin
    chkTotData.Checked:= C004FParamForm.GetParametro('TOTDATA','N') = 'S';
    chkTotRaggr.Checked:= C004FParamForm.GetParametro('TOTGRUPPO','N') = 'S';
    chkTotCaus.Checked:= C004FParamForm.GetParametro('TOTCAUSALI','N') = 'S';
    chkSaltoCaus.Checked:= C004FParamForm.GetParametro('SALTOPAGINACAUSALI','N') = 'S';
    chkSaltoRaggr.Checked:= C004FParamForm.GetParametro('SALTOPAGINAGRUPPO','N') = 'S';
    chkTotGenerale.Checked:= C004FParamForm.GetParametro('TOTGENERALI','N') = 'S';
    chkStampaDett.Checked:= C004FParamForm.GetParametro('DETTAGLIO','S') = 'S';
    dcmbCampoRaggr.KeyValue:=C004FParamForm.GetParametro('CAMPORAGGRUPPA',dcmbCampoRaggr.Text);
    if dcmbCampoRaggr.Text = '' then
      dcmbCampoRaggr.KeyValue:=null;
    // lettura causali selezionate
    x:=0; //contatore di paramento
    snome:='LISTACAUSALI';
    repeat
    // ciclo sui parametri LISTACAUSALI0,LISTACAUSALI1,ecc.
      svalore:=C004FParamForm.GetParametro(snome+IntToStr(x),'');
      y:=0; // contatore di elementi nel parametro
      if svalore<>'' then
        begin
        repeat
        // ciclo sugli elementi nel parametro max 16 per parametro
          selemento:=Copy(svalore,(y*5)+1,5);
          if selemento<>'' then
            begin
            i:=0;
            e:=true;
            r:=CgpListaCausali.Items.Count;
            while (i<r) and (e) do
              begin
              if Copy(CgpListaCausali.Items[i],1,5)=selemento then
                 begin
                 CgpListaCausali.Checked[i]:=true;
                 e:=false;
                 end
              else
                 if Copy(CgpListaCausali.Items[i],1,5)>selemento then
                    e:=false;
              inc(i);
              end;
            inc(y);
            end;
        until selemento ='';
        inc(x);
      end;
    until svalore ='';

    end;
end;

procedure TA081FTimbCaus.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  PutParametriFunzione;
  C004FParamForm.Free;
end;

procedure TA081FTimbCaus.PutParametriFunzione;
{Scrivo i parametri della forma}
var i,x,y,r:integer;
    svalore,snome:string;
begin
  C004FParamForm.Cancella001;
  with A081FTimbCaus do
    begin
    if chkTotData.Checked then
      C004FParamForm.PutParametro('TOTDATA','S')
    else
      C004FParamForm.PutParametro('TOTDATA','N');
    if chkTotRaggr.Checked then
      C004FParamForm.PutParametro('TOTGRUPPO','S')
    else
      C004FParamForm.PutParametro('TOTGRUPPO','N');
    if chkTotCaus.Checked then
      C004FParamForm.PutParametro('TOTCAUSALI','S')
    else
      C004FParamForm.PutParametro('TOTCAUSALI','N');
    if chkSaltoCaus.Checked then
      C004FParamForm.PutParametro('SALTOPAGINACAUSALI','S')
    else
      C004FParamForm.PutParametro('SALTOPAGINACAUSALI','N');
    if chkSaltoRaggr.Checked then
      C004FParamForm.PutParametro('SALTOPAGINAGRUPPO','S')
    else
      C004FParamForm.PutParametro('SALTOPAGINAGRUPPO','N');
    if chkTotGenerale.Checked then
      C004FParamForm.PutParametro('TOTGENERALI','S')
    else
      C004FParamForm.PutParametro('TOTGENERALI','N');
    if chkStampaDett.Checked then
      C004FParamForm.PutParametro('DETTAGLIO','S')
    else
      C004FParamForm.PutParametro('DETTAGLIO','N');
    C004FParamForm.PutParametro('CAMPORAGGRUPPA',VarToStr(dcmbCampoRaggr.KeyValue));
    // salvo l'elenco delle causali selezionate
    x:=0; //contatore parametri causali
    y:=0; //contatore elementi per parametro
    svalore:='';
    snome:='LISTACAUSALI';
    r:=CgpListaCausali.Items.Count;
    For i:=1 to r do
      begin
      if CgpListaCausali.Checked[i-1] then
         begin
         svalore:=svalore+Copy(CgpListaCausali.Items[i-1],1,5);
         inc(y);
         if y=16 then
            begin
            C004FParamForm.PutParametro(snome+IntToStr(x),svalore);
            inc(x);
            y:=0;
            svalore:='';
            end;
         end;
      end;
    C004FParamForm.PutParametro(snome+IntToStr(x),svalore);
    end;
  try SessioneOracle.Commit; except end;
end;

procedure TA081FTimbCaus.frmSelAnagrafeR003DatianagraficiClick(
  Sender: TObject);
begin
  C005DataVisualizzazione:=AData;
  frmSelAnagrafe.R003DatianagraficiClick(Sender);
end;

procedure TA081FTimbCaus.frmSelAnagrafebtnSelezioneClick(Sender: TObject);
begin
  C700DataLavoro:=AData;
  frmSelAnagrafe.btnSelezioneClick(Sender);
end;

procedure TA081FTimbCaus.FormDestroy(Sender: TObject);
begin
  A081FStampa.Release;
  frmSelAnagrafe.DistruggiSelAnagrafe;
end;

procedure TA081FTimbCaus.dcmbCampoRaggrKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = vk_Delete then
  begin
    (Sender as TDBLookupComboBox).KeyValue:=null; 
    if (Sender as TDBLookupComboBox).Field <> nil then
      if (Sender as TDBLookupComboBox).DataSource.State in [dsEdit,dsInsert] then 
        (Sender as TDBLookupComboBox).Field.Clear;
  end;
end;

end.
