unit P690UStampaFondi;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Menus, StdCtrls, CheckLst, Buttons, Mask, ExtCtrls, C180FunzioniGenerali,
  A000UCostanti, A000USessione, A000UInterfaccia, C004UParamForm, A003UDataLavoroBis, C001StampaLib,
  Printers, DB, DBClient;

type
  TP690FStampaFondi = class(TForm)
    Panel1: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    edtDecorrenzaDa: TMaskEdit;
    edtDecorrenzaA: TMaskEdit;
    btnDecorrenzaDa: TBitBtn;
    btnDecorrenzaA: TBitBtn;
    Panel3: TPanel;
    lblTabelle: TLabel;
    clbFondi: TCheckListBox;
    Panel2: TPanel;
    btnAnteprima: TBitBtn;
    btnChiudi: TBitBtn;
    PopupMenu1: TPopupMenu;
    Selezionatutto1: TMenuItem;
    Deselezionatutto1: TMenuItem;
    Invertiselezione1: TMenuItem;
    chkRaggruppa: TCheckBox;
    chkDettRisorse: TCheckBox;
    chkDettDestinazioni: TCheckBox;
    btnStampante: TBitBtn;
    PrinterSetupDialog1: TPrinterSetupDialog;
    btnStampa: TBitBtn;
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure edtDecorrenzaDaExit(Sender: TObject);
    procedure edtDecorrenzaAExit(Sender: TObject);
    procedure btnDecorrenzaDaClick(Sender: TObject);
    procedure btnDecorrenzaAClick(Sender: TObject);
    procedure Selezionatutto1Click(Sender: TObject);
    procedure btnAnteprimaClick(Sender: TObject);
    procedure btnStampanteClick(Sender: TObject);
  private
    { Private declarations }
    Inizio,Fine:TDateTime;
    procedure GetParametriFunzione;
    procedure PutParametriFunzione;
    procedure AggiornaListaFondi;
    procedure CreaTabellaStampa(Dataset:TClientDataset);
    procedure CaricaTabellaStampa(Dataset:TClientDataset);
  public
    { Public declarations }
  end;

var
  P690FStampaFondi: TP690FStampaFondi;

  procedure OpenP690StampaFondi;

implementation

uses P690UStampaFondiDtM, P690UStampa;

{$R *.dfm}

procedure OpenP690StampaFondi;
begin
  SolaLetturaOriginale:=SolaLettura;
  SolaLettura:=False;
  case A000GetInibizioni('Funzione','OpenP690StampaFondi') of
    'N':begin
        ShowMessage('Funzione non abilitata!');
        Exit;
        end;
    'R':SolaLettura:=True;
  end;
  Application.CreateForm(TP690FStampaFondi,P690FStampaFondi);
  with P690FStampaFondi do
    try
      P690FStampaFondiDtM:=TP690FStampaFondiDtM.Create(nil);
      ShowModal;
    finally
      SolaLettura:=SolaLetturaOriginale;
      P690FStampaFondiDtM.Free;
      Free;
    end;
end;

procedure TP690FStampaFondi.btnAnteprimaClick(Sender: TObject);
var i:Integer;
  s:String;
begin
  Inizio:=StrToDate(edtDecorrenzaDa.Text);
  Fine:=StrToDate(edtDecorrenzaA.Text);
  s:='';
  for i:=0 to clbFondi.Count - 1 do
    if clbFondi.Checked[i] then
    begin
      if s <> '' then
        s:=s + ',';
      s:=s + '''' + TrimRight(Copy(clbFondi.Items[i],1,Pos('-',clbFondi.Items[i])-1)) + '''';
    end;
  if s = '' then
    raise exception.Create('Selezionare almeno un Fondo da stampare!');
  with P690FStampaFondiDtM do
  begin
    selP688.AfterScroll:=nil;
    selP688.Close;
    selP688.SetVariable('INIZIO',Inizio);
    selP688.SetVariable('FINE',Fine);
    selP688.SetVariable('COD','p684.cod_fondo IN (' + s + ')');
    if chkRaggruppa.Checked then
      selP688.SetVariable('DATI','COD_MACROCATEG,DESC_MACROCATEG,COD_FONDO_RAGGR,DESC_FONDO_RAGGR')
    else
      selP688.SetVariable('DATI','COD_MACROCATEG,DESC_MACROCATEG,COD_FONDO,DESC_FONDO,COD_RAGGR,DESC_RAGGR');
    selP688.Open;
    CreaTabellaStampa(TabStampaRis);
    CreaTabellaStampa(TabStampaDest);
    CaricaTabellaStampa(TabStampaRis);
    CaricaTabellaStampa(TabStampaDest);
    selP688.AfterScroll:=selP688AfterScroll;
    selP688.First;
  end;
  P690FStampa:=TP690FStampa.Create(nil);
  C001SettaQuickReport(P690FStampa.QRep);
  with P690FStampa do
  begin
    QRep.DataSet:=P690FStampaFondiDtM.selP688;
    QRep.Page.Orientation:=poLandScape;
    LEnte.Caption:=Parametri.RagioneSociale;
    if chkRaggruppa.Checked then
    begin
      qrdbTxtCodFondo.DataField:='COD_FONDO_RAGGR';
      qrdbTxtDescFondo.DataField:='DESC_FONDO_RAGGR';
    end
    else
    begin
      qrdbTxtCodFondo.DataField:='COD_FONDO';
      qrdbTxtDescFondo.DataField:='DESC_FONDO';
    end;
    qrbRisorseDett.Enabled:=chkDettRisorse.Checked;
    qrbDestinDett.Enabled:=chkDettDestinazioni.Checked;
    if Sender = btnAnteprima then
      QRep.Preview
    else
      QRep.Print;
  end;
  FreeAndNil(P690FStampa);
end;

procedure TP690FStampaFondi.CreaTabellaStampa(Dataset:TClientDataset);
begin
  with P690FStampaFondiDtM do
  begin
    Dataset.Close;
    Dataset.FieldDefs.Clear;
    Dataset.IndexDefs.Clear;
    Dataset.FieldDefs.Add('FONDO',ftString,15);
    Dataset.FieldDefs.Add('DEC',ftString,10);
    Dataset.FieldDefs.Add('ORDIN',ftInteger);
    Dataset.FieldDefs.Add('CODGEN',ftString,5);
    Dataset.FieldDefs.Add('DESCGEN',ftString,200);
    Dataset.FieldDefs.Add('TIPOGEN',ftString,50);
    Dataset.FieldDefs.Add('IMPGEN',ftFloat);
    Dataset.FieldDefs.Add('CODDET',ftString,5);
    Dataset.FieldDefs.Add('DESCDET',ftString,200);
    Dataset.FieldDefs.Add('IMPDET',ftFloat);
    Dataset.FieldDefs.Add('QUANTITA',ftFloat);
    Dataset.FieldDefs.Add('DATOBASE',ftFloat);
    Dataset.FieldDefs.Add('MOLTIPLICATORE',ftFloat);
    Dataset.IndexDefs.Add('Primario','FONDO;DEC;ORDIN;CODGEN;CODDET',[]);
    Dataset.IndexName:='Primario';
    Dataset.CreateDataSet;
    Dataset.LogChanges:=False;
    TFloatField(Dataset.FieldByName('IMPGEN')).DisplayFormat:='###,###,###,##0';
    TFloatField(Dataset.FieldByName('IMPDET')).DisplayFormat:='###,###,###,##0.00';
  end;
end;

procedure TP690FStampaFondi.CaricaTabellaStampa(Dataset:TClientDataset);
var s:String;
begin
  with P690FStampaFondiDtM do
  begin
    selP688.First;
    while not selP688.Eof do //ciclo per ogni fondo che interseca il periodo
    begin
      selP686.Close;
      if chkRaggruppa.Checked then
        s:='NVL(P684.cod_raggr,P684.cod_fondo) = ''' + selP688.FieldByName('COD_FONDO_RAGGR').AsString + ''''
      else
        s:='P684.cod_fondo = ''' + selP688.FieldByName('COD_FONDO').AsString + '''';
      s:=s + ' AND ' + VarToStr(selP688.GetVariable('COD'));
      selP686.SetVariable('COD',s);
      selP686.SetVariable('DEC',selP688.FieldByName('DECORRENZA_DA').AsDateTime);
      if Dataset = TabStampaRis then
        selP686.SetVariable('CLASS','R')
      else
        selP686.SetVariable('CLASS','D');
      selP686.Open;
      while not selP686.Eof do  //ciclo su tutte le risorse e le carico in TabStampa
      begin
        Dataset.Append;
        if chkRaggruppa.Checked then
          Dataset.FieldByName('FONDO').AsString:=selP688.FieldByName('COD_FONDO_RAGGR').AsString
        else
          Dataset.FieldByName('FONDO').AsString:=selP688.FieldByName('COD_FONDO').AsString;
        Dataset.FieldByName('DEC').AsString:=selP688.FieldByName('DECORRENZA_DA').AsString;
        Dataset.FieldByName('ORDIN').AsInteger:=selP686.FieldByName('ORDIN').AsInteger;
        Dataset.FieldByName('CODGEN').AsString:=selP686.FieldByName('COD_VOCE_GEN').AsString;
        Dataset.FieldByName('DESCGEN').AsString:=selP686.FieldByName('DESC_GEN').AsString;
        Dataset.FieldByName('TIPOGEN').AsString:=selP686.FieldByName('TIPO_VOCE').AsString;
        Dataset.FieldByName('IMPGEN').AsFloat:=selP686.FieldByName('TOT_IMP').AsFloat;
        selP688Dett.Close;
        selP688Dett.SetVariable('COD',VarToStr(selP686.GetVariable('COD')));
        selP688Dett.SetVariable('DEC',selP688.FieldByName('DECORRENZA_DA').AsDateTime);
        if Dataset = TabStampaRis then
          selP688Dett.SetVariable('CLASS','R')
        else
          selP688Dett.SetVariable('CLASS','D');
        selP688Dett.SetVariable('CODGEN',selP686.FieldByName('COD_VOCE_GEN').AsString);
        selP688Dett.Open;
        while not selP688Dett.Eof do
        begin
          if Dataset.State <> dsInsert then
          begin
            Dataset.Append;
            if chkRaggruppa.Checked then
              Dataset.FieldByName('FONDO').AsString:=selP688.FieldByName('COD_FONDO_RAGGR').AsString
            else
              Dataset.FieldByName('FONDO').AsString:=selP688.FieldByName('COD_FONDO').AsString;
            Dataset.FieldByName('DEC').AsString:=selP688.FieldByName('DECORRENZA_DA').AsString;
            Dataset.FieldByName('ORDIN').AsInteger:=selP686.FieldByName('ORDIN').AsInteger;
            Dataset.FieldByName('CODGEN').AsString:=selP686.FieldByName('COD_VOCE_GEN').AsString;
            Dataset.FieldByName('DESCGEN').AsString:=selP686.FieldByName('DESC_GEN').AsString;
            Dataset.FieldByName('TIPOGEN').AsString:=selP686.FieldByName('TIPO_VOCE').AsString;
            Dataset.FieldByName('IMPGEN').AsFloat:=selP686.FieldByName('TOT_IMP').AsFloat;
          end;
          Dataset.FieldByName('CODDET').AsString:=selP688Dett.FieldByName('COD_VOCE_DET').AsString;
          Dataset.FieldByName('DESCDET').AsString:=selP688Dett.FieldByName('DESCRIZIONE').AsString;
          Dataset.FieldByName('IMPDET').AsFloat:=selP688Dett.FieldByName('IMPORTO').AsFloat;
          if Dataset = TabStampaRis then
          begin
            Dataset.FieldByName('QUANTITA').AsFloat:=selP688Dett.FieldByName('QUANTITA').AsFloat;
            Dataset.FieldByName('DATOBASE').AsFloat:=selP688Dett.FieldByName('DATOBASE').AsFloat;
            Dataset.FieldByName('MOLTIPLICATORE').AsFloat:=selP688Dett.FieldByName('MOLTIPLICATORE').AsFloat;
          end;
          Dataset.Post;
          selP688Dett.Next;
        end;
        if Dataset.State = dsInsert then
          Dataset.Post;
        selP686.Next;
      end;
      selP688.Next;
    end;
  end;
end;

procedure TP690FStampaFondi.btnDecorrenzaAClick(Sender: TObject);
begin
  edtDecorrenzaA.Text:=DateToStr(DataOut(StrToDate(edtDecorrenzaA.Text),'Alla scadenza','G'));
end;

procedure TP690FStampaFondi.btnDecorrenzaDaClick(Sender: TObject);
begin
  edtDecorrenzaDa.Text:=DateToStr(DataOut(StrToDate(edtDecorrenzaDa.Text),'Dalla decorrenza','G'));
end;

procedure TP690FStampaFondi.btnStampanteClick(Sender: TObject);
begin
  if PrinterSetUpDialog1.Execute then
  begin
    if P690FStampa = nil then
      P690FStampa:=TP690FStampa.Create(nil);
    C001SettaQuickReport(P690FStampa.QRep);
  end;
end;

procedure TP690FStampaFondi.edtDecorrenzaAExit(Sender: TObject);
begin
  AggiornaListaFondi;
end;

procedure TP690FStampaFondi.edtDecorrenzaDaExit(Sender: TObject);
begin
  AggiornaListaFondi;
end;

procedure TP690FStampaFondi.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  PutParametriFunzione;
  C004FParamForm.Free;
end;

procedure TP690FStampaFondi.FormCreate(Sender: TObject);
begin
  A000SettaVariabiliAmbiente;
end;

procedure TP690FStampaFondi.FormShow(Sender: TObject);
begin
  CreaC004(SessioneOracle,'P690',Parametri.ProgOper);
  GetParametriFunzione;
  Inizio:=StrToDate(edtDecorrenzaDa.Text);
  Fine:=StrToDate(edtDecorrenzaA.Text);
  AggiornaListaFondi;
end;

procedure TP690FStampaFondi.GetParametriFunzione;
{Leggo i parametri della form}
begin
  edtDecorrenzaDa.Text:=C004FParamForm.GetParametro('DECORRENZA_DA','01/01/' + IntToStr(R180Anno(Parametri.DataLavoro)));
  edtDecorrenzaA.Text:=C004FParamForm.GetParametro('DECORRENZA_A','31/12/' + IntToStr(R180Anno(Parametri.DataLavoro)));
end;

procedure TP690FStampaFondi.PutParametriFunzione;
{Scrivo i parametri della forma}
begin
  C004FParamForm.Cancella001;
  C004FParamForm.PutParametro('DECORRENZA_DA',edtDecorrenzaDa.Text);
  C004FParamForm.PutParametro('DECORRENZA_A',edtDecorrenzaA.Text);
  try SessioneOracle.Commit; except end;
end;

procedure TP690FStampaFondi.Selezionatutto1Click(Sender: TObject);
var i:Integer;
begin
  clbFondi.SetFocus;
  for i:=0 to clbFondi.Items.Count - 1 do
    if Sender = SelezionaTutto1 then
      clbFondi.Checked[i]:=True
    else if Sender = DeselezionaTutto1 then
      clbFondi.Checked[i]:=False
    else if Sender = InvertiSelezione1 then
      clbFondi.Checked[i]:=not clbFondi.Checked[i];
end;

procedure TP690FStampaFondi.AggiornaListaFondi;
begin
  with P690FStampaFondiDtM do
  begin
    if (StrToDate(edtDecorrenzaDa.Text) <> selP684.GetVariable('INIZIO')) or
       (StrToDate(edtDecorrenzaA.Text) <> selP684.GetVariable('FINE')) then
    begin
      clbFondi.Items.Clear;
      selP684.Close;
      selP684.SetVariable('INIZIO',StrToDate(edtDecorrenzaDa.Text));
      selP684.SetVariable('FINE',StrToDate(edtDecorrenzaA.Text));
      selP684.Open;
      while not selP684.Eof do
      begin
        clbFondi.Items.Add(selP684.FieldByName('COD_FONDO').AsString + ' - ' +
          selP684.FieldByName('DESCRIZIONE').AsString);
        selP684.Next;
      end;
    end;
  end;
end;

end.
