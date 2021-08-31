unit A068UTurniGior;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, DB,
  StdCtrls, Buttons, C700USelezioneAnagrafe, A000UCostanti, A000USessione,A000UInterfaccia, C180FunzioniGenerali,
  ComCtrls, ExtCtrls, C001StampaLib, SelAnagrafe, Menus, C005UDatiAnagrafici,
  A003UDataLavoroBis, Variants, C004UParamForm, QRPDFFilt;

type
  TA068FTurniGior = class(TForm)
    BitBtn1: TBitBtn;
    Label1: TLabel;
    StatusBar: TStatusBar;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    BitBtn4: TBitBtn;
    PrinterSetupDialog1: TPrinterSetupDialog;
    edtIntestazione: TEdit;
    lblIntestazione: TLabel;
    frmSelAnagrafe: TfrmSelAnagrafe;
    rgpTPianif: TRadioGroup;
    procedure BitBtn1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure BitBtn4Click(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure frmSelAnagrafeR003DatianagraficiClick(Sender: TObject);
    procedure frmSelAnagrafebtnSelezioneClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    Data:TDateTime;
    AbilCont:Boolean;
    TipoModulo, DocumentoPDF: String;
  end;

var
  A068FTurniGior: TA068FTurniGior;

procedure OpenA068TurniGior(Prog:LongInt);

implementation

uses A068UTurniGiorDtM1, A068UStampa;

{$R *.DFM}

procedure OpenA068TurniGior(Prog:LongInt);
begin
  SolaLetturaOriginale:=SolaLettura;
  SolaLettura:=False;
  case A000GetInibizioni('Funzione','OpenA068TurniGior') of
    'N':begin
        ShowMessage('Funzione non abilitata!');
        Exit;
        end;
    'R':SolaLettura:=True;
  end;
  A068FTurniGior:=TA068FTurniGior.Create(nil);
  with A068FTurniGior do
    try
      C700Progressivo:=Prog;
      A068FTurniGiorDtM1:=TA068FTurniGiorDtM1.Create(nil);
      ShowModal;
    finally
      SolaLettura:=SolaLetturaOriginale;
      A068FTurniGiorDtM1.Free;
      Free;
    end;
end;

procedure TA068FTurniGior.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  C004FParamForm.Cancella001;
  C004FParamForm.PutParametro(rgpTPianif.Name,IntToStr(rgpTPianif.ItemIndex));
end;

procedure TA068FTurniGior.FormCreate(Sender: TObject);
begin
  TipoModulo:='CS';
  AbilCont:=False;
  A068FStampa:=TA068FStampa.Create(nil);
end;

procedure TA068FTurniGior.FormShow(Sender: TObject);
begin
  Data:=Parametri.DataLavoro;
  Label1.Caption:=FormatDateTime('dd mmmm yyyy',Data);
  C700DatiVisualizzati:='MATRICOLA,T430BADGE,COGNOME,NOME';
  C700DatiSelezionati:=C700CampiBase + ',T430SQUADRA,T430D_SQUADRA';
  C700DataLavoro:=Parametri.DataLavoro;
  frmSelAnagrafe.CreaSelAnagrafe(SessioneOracle,StatusBar,0,False);
  C700SelAnagrafe.OnFilterRecord:=A068FTurniGiorDtM1.QVistaFilterRecord;
  C700SelAnagrafe.Filtered:=True;
  CreaC004(SessioneOracle,'A068',Parametri.ProgOper);
  rgpTPianif.ItemIndex:=StrToInt(C004FParamForm.GetParametro(rgpTPianif.Name,'1'));
end;

procedure TA068FTurniGior.BitBtn1Click(Sender: TObject);
begin
  Data:=DataOut(Data,'Data','G');
  Label1.Caption:=FormatDateTime('dd mmmm yyyy',Data);
  C700SelAnagrafe.Close;
  C700SelAnagrafe.SetVariable('DATALAVORO',Data);
  C700SelAnagrafe.Open;
  frmSelAnagrafe.NumRecords;
end;

procedure TA068FTurniGior.BitBtn4Click(Sender: TObject);
begin
  if PrinterSetupDialog1.Execute then
    C001SettaQuickReport(A068FStampa.QRep);
end;

procedure TA068FTurniGior.BitBtn3Click(Sender: TObject);
begin
  if C700SelAnagrafe.State = dsInactive then
    C700SelAnagrafe.Open;
  with A068FTurniGiorDtM1 do
  begin
    Q081.SetVariable('DATA',Data);
    selT080.SetVariable('DATA',Data);
    Q040.SetVariable('DATA',Data);
    C700SelAnagrafe.First;
  end;
  with A068FStampa do
  begin
    QRep.DataSet:=C700SelAnagrafe;
    QRDbText1.DataSet:=C700SelAnagrafe;
    QRDbText2.DataSet:=C700SelAnagrafe;
    LEnte.Caption:=Parametri.DAzienda;
    LTitolo.Caption:='Turni previsti per il ' + Label1.Caption;
    LTitolo1.Caption:=edtIntestazione.Text;

    if (Trim(DocumentoPDF) <> '') and (Trim(DocumentoPDF) <> '<VUOTO>') and (Trim(TipoModulo) = 'COM')then
    begin
      QRep.ShowProgress:=False;
      QRep.ExportToFilter(TQRPDFDocumentFilter.Create(DocumentoPDF));
    end
    else
    QRep.Preview;
  end;
end;

procedure TA068FTurniGior.FormDestroy(Sender: TObject);
begin
  A068FStampa.Release;
  frmSelAnagrafe.DistruggiSelAnagrafe;
end;

procedure TA068FTurniGior.frmSelAnagrafeR003DatianagraficiClick(
  Sender: TObject);
begin
  C005DataVisualizzazione:=Data;
  frmSelAnagrafe.R003DatianagraficiClick(Sender);
end;

procedure TA068FTurniGior.frmSelAnagrafebtnSelezioneClick(Sender: TObject);
begin
  C700DataLavoro:=Data;
  frmSelAnagrafe.btnSelezioneClick(Sender);
end;

end.
