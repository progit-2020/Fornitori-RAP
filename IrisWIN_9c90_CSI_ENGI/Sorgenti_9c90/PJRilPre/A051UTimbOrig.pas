unit A051UTimbOrig;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Buttons, DBCtrls, StdCtrls, Spin ,C001StampaLib, A000UCostanti, A000USessione,A000UInterfaccia,
  Grids, DBGrids, ExtCtrls,DB,QueryStorico,C180FunzioniGenerali,
  C004UParamForm, ComCtrls, SelAnagrafe, Menus,
  C005UDatiAnagrafici, C700USelezioneAnagrafe, Variants;

type
  TA051FTimbOrig = class(TForm)
    BtnPrinterSetUp: TBitBtn;
    BtnStampa: TBitBtn;
    BtnClose: TBitBtn;
    PrinterSetupDialog1: TPrinterSetupDialog;
    LblRaggr: TLabel;
    dcmbCampoRaggr: TDBLookupComboBox;
    Label1: TLabel;
    edtAnno: TSpinEdit;
    Label2: TLabel;
    CmBMese: TComboBox;
    Label3: TLabel;
    edtDa: TSpinEdit;
    Label4: TLabel;
    edtA: TSpinEdit;
    chkSaltoPagina: TCheckBox;
    ProgressBar1: TProgressBar;
    StatusBar: TStatusBar;
    frmSelAnagrafe: TfrmSelAnagrafe;
    rgpTimbrature: TRadioGroup;
    procedure dcmbCampoRaggrKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure BtnPrinterSetUpClick(Sender: TObject);
    procedure BtnStampaClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure CmBMeseChange(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure frmSelAnagrafeR003DatianagraficiClick(Sender: TObject);
    procedure frmSelAnagrafebtnSelezioneClick(Sender: TObject);
  private
    { Private declarations }
    CampoRagg,NomeCampo : String;
    DataI,DataF:TDateTime;
    procedure ScorriQueryAnagrafica;
    procedure AggiornaQTimbrature(Progr:Integer);
    procedure ScorriQueryTimbrature(Prog : Integer);
    procedure InserisciDipendente(Data:TDateTime;Timb1,Timb2 : String);
    procedure CalcolaDate;
    procedure GetParametriFunzione;
    procedure PutParametriFunzione;
  public
    DocumentoPDF,TipoModulo: string;
  end;

var
  A051FTimbOrig: TA051FTimbOrig;

procedure OpenA051TimbOrig(Prog:LongInt);

implementation

uses A051UStampa, A051UTimbOrigDtM1;

{$R *.DFM}

procedure OpenA051TimbOrig(Prog:LongInt);
{Stampa Timbrature originali}
begin
  SolaLetturaOriginale:=SolaLettura;
  SolaLettura:=False;
  case A000GetInibizioni('Funzione','OpenA051TimbOrig') of
    'N':begin
        ShowMessage('Funzione non abilitata!');
        Exit;
        end;
  end;
  A051FTimbOrig:=TA051FTimbOrig.Create(nil);
  with A051FTimbOrig do
    try
      C700Progressivo:=Prog;
      A051FTimbOrigDtM1:=TA051FTimbOrigDtM1.Create(nil);
      ShowModal;
    finally
      SolaLettura:=SolaLetturaOriginale;
      A051FTimbOrigDtM1.Free;
      Free;
    end;
end;

procedure TA051FTimbOrig.FormCreate(Sender: TObject);
begin
  TipoModulo:='CS';
  A051FStampa:=TA051FStampa.Create(nil);
end;

procedure TA051FTimbOrig.FormShow(Sender: TObject);
var AA,MM,GG : Word;
begin
  CreaC004(SessioneOracle,'A051',Parametri.ProgOper);
  DecodeDate(Parametri.DataLavoro,AA,MM,GG);
  CmBMese.ItemIndex:=MM-1;
  edtAnno.Value:=AA;
  edtDa.MaxValue:=R180GiorniMese(Parametri.DataLavoro);
  edtA.MaxValue:=R180GiorniMese(Parametri.DataLavoro);
  edtDa.Value:=01;
  edtA.Value:=R180GiorniMese(Parametri.DataLavoro);
  CalcolaDate;
  GetParametriFunzione;
  C700DatiVisualizzati:='MATRICOLA,T430BADGE,COGNOME,NOME';
  C700DatiSelezionati:=C700CampiBase;
  C700DataLavoro:=Parametri.DataLavoro;
  frmSelAnagrafe.CreaSelAnagrafe(SessioneOracle,StatusBar,0,False);
end;

procedure TA051FTimbOrig.CalcolaDate;
begin
  DataI:=EncodeDate(edtAnno.Value,CmBMese.ItemIndex+1,edtDa.Value);
  DataF:=EncodeDate(edtAnno.Value,CmBMese.ItemIndex+1,edtA.Value);
end;

procedure TA051FTimbOrig.BtnPrinterSetUpClick(Sender: TObject);
begin
  if PrinterSetUpDialog1.Execute then
    C001SettaQuickReport(A051FStampa.RepR);
end;

procedure TA051FTimbOrig.AggiornaQTimbrature(Progr:Integer);
begin
  with A051FTimbOrigDtM1 do
  begin
    QTimbrature.Close;
    QTimbrature.SetVariable('Progressivo',Progr);
    QTimbrature.Open;
  end;
end;

procedure TA051FTimbOrig.InserisciDipendente(Data:TDateTime;Timb1,Timb2 : String);
begin
  with A051FTimbOrigDtM1 do
    begin
    TabellaStampa.Insert;
    if CampoRagg <> '' then
      TabellaStampa.FieldByName('Gruppo').AsString:=C700SelAnagrafe.FieldByName(CampoRagg).AsString;
    TabellaStampa.FieldByName('Progressivo').AsInteger:=C700SelAnagrafe.FieldByName('Progressivo').AsInteger;
    TabellaStampa.FieldByName('Cognome').AsString:=C700SelAnagrafe.FieldByName('Cognome').AsString;
    TabellaStampa.FieldByName('Nome').AsString:=C700SelAnagrafe.FieldByName('Nome').AsString;
    TabellaStampa.FieldByName('Badge').AsInteger:=C700SelAnagrafe.FieldByName('T430Badge').AsInteger;
    TabellaStampa.FieldByName('Matricola').AsString:=C700SelAnagrafe.FieldByName('Matricola').AsString;
    TabellaStampa.FieldByName('Data').Value:=Data;
    TabellaStampa.FieldByName('Timb1').Value:=Timb1;
    TabellaStampa.FieldByName('Timb2').Value:=Timb2;
    TabellaStampa.Post;
    end;
end;

// Scorro la query delle timbrature e creo la relativa stringa con le timbrature
// sulla tabella di stampa.
procedure TA051FTimbOrig.ScorriQueryTimbrature(Prog : Integer);
CONST MAXCHARRIGA = 126;  // numero massimo di caratteri su una riga.
var DataCorr:TDateTime;
    App,Timb1,Timb2:String;
    Cau,Ril:String;
    LungTimb:Word;// numero di caratteri per rappresentare 1 timbratura.
begin
  LungTimb:=21;
  if rgpTimbrature.ItemIndex in [0,3] then
    LungTimb:=24;
  with A051FTimbOrigDtM1 do
  begin
    AggiornaQTimbrature(Prog);
    QTimbrature.First;
    if not(QTimbrature.RecordCount = 0) then
      DataCorr:=QTimbrature.FieldByName('Data').Value
    else
      DataCorr:=Now; // istruzione inutile.
    Timb1:='';
    Timb2:='';
    while not(QTimbrature.EOF) do
    begin
      if QTimbrature.FieldByName('Data').Value <> DataCorr then
      begin
        InserisciDipendente(DataCorr,Timb1,Timb2);
        DataCorr:=QTimbrature.FieldByName('Data').Value;
        Timb1:='';
        Timb2:='';
      end
      else
      begin
        App:=QTimbrature.FieldByName('Verso').AsString + FormatDateTime('hh:mm',QTimbrature.FieldByName('Ora').Value);
        Ril:=Format('%-2.2s',[QTimbrature.FieldByName('Rilevatore').AsString]);
        Cau:=Format('%-5.5s',[QTimbrature.FieldByName('Causale').AsString]);
        if rgpTimbrature.ItemIndex in [0,3] then
          App:=App + '(' + QTimbrature.FieldByName('Flag').AsString + ')';
        if trim(Ril) <> '' then
        begin
          if trim(Cau) <> '' then
            App:=App+'(R.'+Ril+' C.'+Cau+') '
          else
            App:=App+'(R.'+Ril+')         ';
        end
        else
        begin
          if trim(Cau) <> '' then
            App:=App+'(C.'+Cau+')      '
          else
            App:=App+'               ';
        end;
        if Length(Timb1) + LUNGTIMB <= MAXCHARRIGA then
        begin
          Timb1:=Timb1 + App;
        end
        else
        begin
          Timb2:=Timb2 + App;
        end;
        QTimbrature.Next;
      end;
    end;
    if QTimbrature.RecordCount <> 0 then
      InserisciDipendente(DataCorr,Timb1,Timb2);
  end;
end;

procedure TA051FTimbOrig.ScorriQueryAnagrafica;
begin
  with A051FTimbOrigDtM1 do
  begin
    ProgressBar1.Position:=0;
    ProgressBar1.Max:=C700SelAnagrafe.RecordCount;
    C700SelAnagrafe.First;
    frmSelAnagrafe.ElaborazioneInterrompibile:=True;
    Self.Enabled:=False;
    try
      while not C700SelAnagrafe.EOF do
      begin
        frmSelAnagrafe.VisualizzaDipendente;
        ProgressBar1.StepBy(1);
        ScorriQueryTimbrature(C700Progressivo);
        C700SelAnagrafe.Next;
      end;
    finally
      frmSelAnagrafe.ElaborazioneInterrompibile:=False;
      Self.Enabled:=True;
      frmSelAnagrafe.VisualizzaDipendente;
      ProgressBar1.Position:=0;
    end;
  end;
end;

procedure TA051FTimbOrig.BtnStampaClick(Sender: TObject);
var S,App:String;
begin
  CalcolaDate;
  if DataI > DataF then
    raise Exception.Create('La data iniziale deve essere minore di quella finale!');
  if C700SelAnagrafe.GetVariable('DataLavoro') <> DataF then
  begin
    C700SelAnagrafe.CloseAll;
    C700SelAnagrafe.SetVariable('DataLavoro',DataF);
  end;
  with A051FTimbOrigDtM1 do
  begin
    if (dcmbCampoRaggr.KeyValue <> Null) then
    begin
      CampoRagg:=dcmbCampoRaggr.KeyValue;
      NomeCampo:=dcmbCampoRaggr.Text;
      S:=C700SelAnagrafe.SQL.Text;
      if R180InserisciColonna(S,AliasTabella(A051MW.selI010.FieldByName('Nome_Campo').AsString)+'.'+dcmbCampoRaggr.KeyValue) then
      begin
        C700SelAnagrafe.CloseAll;
        C700SelAnagrafe.SQl.Text:=S;
      end;
    end
    else
    begin
      CampoRagg:='';
      NomeCampo:='';
    end;
  end;
  C700SelAnagrafe.Open;
  if (dcmbCampoRaggr.KeyValue <> Null) then
    App:=dcmbCampoRaggr.KeyValue
  else
    App:='';
  A051FTimbOrigDtM1.CreaTabellaStampa;
  case rgpTimbrature.ItemIndex of
    0:A051FTimbOrigDtM1.QTimbrature.SetVariable('Flag','''O'',''C'',''M''');
    1:A051FTimbOrigDtM1.QTimbrature.SetVariable('Flag','''C''');
    2:A051FTimbOrigDtM1.QTimbrature.SetVariable('Flag','''I''');
    3:A051FTimbOrigDtM1.QTimbrature.SetVariable('Flag','''O'',''C'',''M'',''I''');
  end;
  A051FTimbOrigDtM1.QTimbrature.SetVariable('DataI',DataI);
  A051FTimbOrigDtM1.QTimbrature.SetVariable('DataF',DataF);
  Screen.Cursor:=crHourGlass;
  try
    ScorriQueryAnagrafica;
  finally
    Screen.Cursor:=crDefault;
  end;
  A051FStampa.CampoRagg:=CampoRagg;
  A051FStampa.NomeCampo:=NomeCampo;
  A051FStampa.DataI:=DataI;
  A051FStampa.DataF:=DataF;
  case rgpTimbrature.ItemIndex of
    0:A051FStampa.Titolo:='Timbrature originali';
    1:A051FStampa.Titolo:='Timbrature cancellate';
    2:A051FStampa.Titolo:='Timbrature non originali';
    3:A051FStampa.Titolo:='Tutte le timbrature';
  end;
  A051FStampa.CreaReport;
  A051FTimbOrigDtM1.TabellaStampa.Close;
end;

procedure TA051FTimbOrig.CmBMeseChange(Sender: TObject);
var DataApp : TDateTime;
begin
  try
    DataApp:=EncodeDate(edtAnno.Value,CmBMese.ItemIndex + 1,01);
  except
    exit;
  end;
  if (edtDa.Value = 1) and (edtA.Value = edtA.MaxValue) then
  begin
    edtA.MaxValue:=R180GiorniMese(DataApp);
    edtA.Value:=R180GiorniMese(DataApp);
  end;
  edtDa.MaxValue:=R180GiorniMese(DataApp);
  edtA.MaxValue:=R180GiorniMese(DataApp);
  if edtDa.Value > edtDa.MaxValue then
    edtDa.Value:=edtDa.MaxValue;
  if edtA.Value > edtA.MaxValue then
    edtA.Value:=edtA.MaxValue;
end;

procedure TA051FTimbOrig.GetParametriFunzione;
{Leggo i parametri della form}
begin
  with A051FTimbOrig do
    begin
    dcmbCampoRaggr.KeyValue:=C004FParamForm.GetParametro('RAGGRUPPAMENTO',dcmbCampoRaggr.Text);
    if dcmbCampoRaggr.Text = '' then
      dcmbCampoRaggr.KeyValue:=null;
    chkSaltoPagina.Checked:=C004FParamForm.GetParametro('SALTOPAGINA','N') = 'S';
    end;
end;

procedure TA051FTimbOrig.PutParametriFunzione;
{Scrivo i parametri della forma}
begin
  C004FParamForm.Cancella001;
  with A051FTimbOrig do
    begin
    C004FParamForm.PutParametro('RAGGRUPPAMENTO',VarToStr(dcmbCampoRaggr.KeyValue));
    if chkSaltoPagina.Checked then
      C004FParamForm.PutParametro('SALTOPAGINA','S')
    else
      C004FParamForm.PutParametro('SALTOPAGINA','N');
  end;
  try SessioneOracle.Commit; except end;
end;

procedure TA051FTimbOrig.frmSelAnagrafeR003DatianagraficiClick(
  Sender: TObject);
begin
  CalcolaDate;
  C005DataVisualizzazione:=DataF;
  frmSelAnagrafe.R003DatianagraficiClick(Sender);
end;

procedure TA051FTimbOrig.frmSelAnagrafebtnSelezioneClick(Sender: TObject);
begin
  CalcolaDate;
  C700DataLavoro:=DataF;
  frmSelAnagrafe.btnSelezioneClick(Sender);
end;

procedure TA051FTimbOrig.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  PutParametriFunzione;
  C004FParamForm.Free;
end;

procedure TA051FTimbOrig.FormDestroy(Sender: TObject);
begin
  A051FStampa.Release;
  frmSelAnagrafe.DistruggiSelAnagrafe;
end;

procedure TA051FTimbOrig.dcmbCampoRaggrKeyDown(Sender: TObject; var Key: Word;
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
