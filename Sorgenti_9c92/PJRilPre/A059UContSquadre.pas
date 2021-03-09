unit A059UContSquadre;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, Mask, ExtCtrls, DBCtrls, C180FunzioniGenerali, QRPDFFilt,
  ComCtrls, C001StampaLib, A003UDataLavoroBis, A000UCostanti, A000USessione,A000UInterfaccia, A000UMessaggi, Variants;

type
  TA059FContSquadre = class(TForm)
    Label1: TLabel;
    Label3: TLabel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    RgpModalita: TRadioGroup;
    LDaData: TLabel;
    LAData: TLabel;
    BDaData: TBitBtn;
    BAData: TBitBtn;
    cmbDaSquadra: TDBLookupComboBox;
    cmbASquadra: TDBLookupComboBox;
    LSquadra1: TDBText;
    LSquadra2: TDBText;
    BitBtn4: TBitBtn;
    PrinterSetupDialog1: TPrinterSetupDialog;
    RgpTipo: TRadioGroup;
    procedure BDaDataClick(Sender: TObject);
    procedure cmbDaSquadraKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure cmbDaSquadraCloseUp(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure RgpModalitaClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormActivate(Sender: TObject);
  private
    Operativa:boolean;
  public
    TipoModulo, DocumentoPDF: String;
    DataInizio,DataFine:TDateTime;
  end;

var
  A059FContSquadre: TA059FContSquadre;

procedure openA059ContSquadre;

implementation

uses A059UContSquadreDtM1, A059UStampa;

{$R *.DFM}

procedure OpenA059ContSquadre;
begin
  SolaLetturaOriginale:=SolaLettura;
  SolaLettura:=False;
  case A000GetInibizioni('Funzione','OpenA059ContSquadre') of
    'N':
        begin
        ShowMessage('Funzione non abilitata!');
        Exit;
        end;
    'R':SolaLettura:=True;
  end;
  A059FContSquadre:=TA059FContSquadre.Create(nil);
  with A059FContSquadre do
    try
      A059FContSquadreDtM1:=TA059FContSquadreDtM1.Create(nil);
      ShowModal;
    finally
      SolaLettura:=SolaLetturaOriginale;
      A059FContSquadreDtM1.Free;
      Free;
    end;
end;

procedure TA059FContSquadre.BDaDataClick(Sender: TObject);
begin
  if Sender = BDaData then
  begin
    DataInizio:=DataOut(DataInizio,'Da data','G');
    LDaData.Caption:=FormatDateTime('dd mmmm yyyy',DataInizio);
  end
  else
  begin
    DataFine:=DataOut(DataFine,'Da data','G');
    LAData.Caption:=FormatDateTime('dd mmmm yyyy',DataFine);
  end;
end;

procedure TA059FContSquadre.cmbDaSquadraKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if (Key = VK_DELETE) and (not(Sender as TDBLookupComboBox).ListVisible) then
    if Sender = cmbDaSquadra then
      LSquadra1.Visible:=False
    else
      LSquadra2.Visible:=False;
  if (Key = VK_UP) or (Key = VK_DOWN) then
    cmbDaSquadraCloseUp(Sender);
  if Key = vk_Delete then
  begin
    (Sender as TDBLookupComboBox).KeyValue:=null; 
    if (Sender as TDBLookupComboBox).Field <> nil then
      //if (Sender as TDBLookupComboBox).DataSource.State in [dsEdit,dsInsert] then 
        (Sender as TDBLookupComboBox).Field.Clear;
  end;
end;

procedure TA059FContSquadre.cmbDaSquadraCloseUp(Sender: TObject);
begin
  if Sender = cmbDaSquadra then
    LSquadra1.Visible:=cmbDaSquadra.KeyValue <> ''
  else
    LSquadra2.Visible:=cmbASquadra.KeyValue <> '';
end;

procedure TA059FContSquadre.BitBtn1Click(Sender: TObject);
begin
  if (Trim(cmbDaSquadra.KeyValue) = '') or (Trim(cmbASquadra.KeyValue) = '') then
    raise Exception.Create(A000MSG_A059_ERR_SQUADRA_MANCANTE);
  if cmbASquadra.KeyValue < cmbDaSquadra.KeyValue then
    raise Exception.Create(A000MSG_A059_ERR_SQUADRE);
  with A059FStampa.QRTitolo do
  begin
    A059FStampa.QRTitolo.Caption:='Riepilogo pianificazione ';
    if Parametri.CampiRiferimento.C11_PianifOrariProg = 'S' then
      Caption:=Caption + 'progressiva ';
    if RgpModalita.ItemIndex = 0 then
      Caption:=Caption + 'operativa'
    else
    begin
      if Parametri.CampiRiferimento.C11_PianifOrariProg = 'S' then
      begin
        if RgpTipo.ItemIndex = 0 then
          Caption:=Caption + 'iniziale '
        else
          Caption:=Caption + 'corrente '
      end;
      Caption:=Caption + 'non operativa';
    end;
    Caption:=Caption+' squadre turnisti';
  end;
  A059FStampa.QRRange.Caption:=Format('dalla squadra %s alla squadra %s',[cmbDaSquadra.KeyValue,cmbASquadra.KeyValue]);
  A059FStampa.QRData.Caption:=Format('dal %s al %s',[FormatDateTime('dd/mm/yyyy',DataInizio),FormatDateTime('dd/mm/yyyy',DataFine)]);
  A059FStampa.QRGiorni.Caption:=R180ElencoGiorni(DataInizio,DataFine,'dd ');
  A059FStampa.QRMesi.Caption:=R180ElencoMesi(DataInizio,DataFine,'dd ');
  //Dimensiono i QRRichText
  A059FStampa.QRTurno1.Width:=A059FStampa.QRSubDetail1.Width - A059FStampa.QRTurno1.Left;
  A059FStampa.QRTurno2.Width:=A059FStampa.QRSubDetail1.Width - A059FStampa.QRTurno2.Left;
  A059FStampa.QRTurno3.Width:=A059FStampa.QRSubDetail1.Width - A059FStampa.QRTurno3.Left;
  A059FStampa.QRTurno4.Width:=A059FStampa.QRSubDetail1.Width - A059FStampa.QRTurno4.Left;
  A059FStampa.QRSquadra1.Width:=A059FStampa.QRBand1.Width - A059FStampa.QRSquadra1.Left;
  A059FStampa.QRSquadra2.Width:=A059FStampa.QRBand1.Width - A059FStampa.QRSquadra2.Left;
  A059FStampa.QRSquadra3.Width:=A059FStampa.QRBand1.Width - A059FStampa.QRSquadra3.Left;
  A059FStampa.QRSquadra4.Width:=A059FStampa.QRBand1.Width - A059FStampa.QRSquadra4.Left;
  with A059FContSquadreDtM1.Q600Squadre do
  begin
    Close;
    SetVariable('Codice1',cmbDaSquadra.KeyValue);
    SetVariable('Codice2',cmbASquadra.KeyValue);
    Open;
  end;
  if (TipoMOdulo = 'COM') and (Trim(DocumentoPDF) <> '') and (Trim(DocumentoPDF) <> '<VUOTO>') then
  begin
      A059FStampa.QRep.ShowProgress:=False;
      A059FStampa.QRep.ExportToFilter(TQRPDFDocumentFilter.Create(DocumentoPDF));
  end
  else if Sender = BitBtn4 then
    A059FStampa.QRep.PreView
  else
    A059FStampa.QRep.Print;
end;

procedure TA059FContSquadre.BitBtn2Click(Sender: TObject);
begin
  if PrinterSetupDialog1.Execute then
    C001SettaQuickReport(A059FStampa.QRep);
end;

procedure TA059FContSquadre.FormActivate(Sender: TObject);
begin
  LSquadra2.DataSource:=A059FContSquadreDtM1.A059MW.D600B;
  cmbASquadra.ListSource:=A059FContSquadreDtM1.A059MW.D600B;
  LSquadra1.DataSource:=A059FContSquadreDtM1.A059MW.D600;
  cmbDaSquadra.ListSource:=A059FContSquadreDtM1.A059MW.D600;
end;

procedure TA059FContSquadre.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  FreeAndNil(A059FStampa);
end;

procedure TA059FContSquadre.FormCreate(Sender: TObject);
begin
  TipoModulo:='CS';
  A059FStampa:=TA059FStampa.Create(nil);
  RgpModalitaClick(nil);
end;

procedure TA059FContSquadre.FormDestroy(Sender: TObject);
begin
  FreeAndNil(A059FStampa);
end;

procedure TA059FContSquadre.RgpModalitaClick(Sender: TObject);
begin
  Operativa:=RgpModalita.ItemIndex = 0;
  //Applico le abilitazioni previste nel tab Permessi della form <A008> Profilo utenti
  if not SolaLettura then
  begin
    //PIANIFICAZIONE PROGRESSIVA
    if Parametri.CampiRiferimento.C11_PianifOrariProg = 'S' then
      RgpTipo.Enabled:=not Operativa
    else
      RgpTipo.Enabled:=False;
  end;
end;

procedure TA059FContSquadre.FormShow(Sender: TObject);
begin
  RgpTipo.Visible:=Parametri.CampiRiferimento.C11_PianifOrariProg='S';
end;

end.
