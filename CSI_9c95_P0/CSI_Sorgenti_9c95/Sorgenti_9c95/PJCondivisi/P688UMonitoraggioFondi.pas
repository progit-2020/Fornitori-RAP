unit P688UMonitoraggioFondi;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, DBGrids, StdCtrls, ExtCtrls, Buttons, Mask, C180FunzioniGenerali,
  A000UCostanti, A000USessione, A000UInterfaccia, C004UParamForm, A003UDataLavoroBis, Clipbrd,
  Menus;

type
  TP688FMonitoraggioFondi = class(TForm)
    Panel3: TPanel;
    Panel1: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    edtDecorrenzaDa: TMaskEdit;
    edtDecorrenzaA: TMaskEdit;
    btnDecorrenzaDa: TBitBtn;
    btnDecorrenzaA: TBitBtn;
    dgrdDettaglio: TDBGrid;
    PopupMenu1: TPopupMenu;
    Selezionatutto1: TMenuItem;
    Deselezionatutto1: TMenuItem;
    Invertiselezione1: TMenuItem;
    MenuItem1: TMenuItem;
    Copia2: TMenuItem;
    CopiaInExcel: TMenuItem;
    Panel2: TPanel;
    rgpRaggruppamento: TRadioGroup;
    BitBtn1: TBitBtn;
    procedure FormShow(Sender: TObject);
    procedure btnDecorrenzaDaClick(Sender: TObject);
    procedure btnDecorrenzaAClick(Sender: TObject);
    procedure edtDecorrenzaDaExit(Sender: TObject);
    procedure Selezionatutto1Click(Sender: TObject);
    procedure Deselezionatutto1Click(Sender: TObject);
    procedure Invertiselezione1Click(Sender: TObject);
    procedure Copia2Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure rgpRaggruppamentoClick(Sender: TObject);
    procedure edtDecorrenzaAExit(Sender: TObject);
  private
    { Private declarations }
    Inizio,Fine:TDateTime;
    procedure GetParametriFunzione;
    procedure PutParametriFunzione;
    procedure Aggiorna;
  public
    { Public declarations }
  end;

var
  P688FMonitoraggioFondi: TP688FMonitoraggioFondi;

  procedure OpenP688MonitoraggioFondi;

implementation

uses P688UMonitoraggioFondiDtM;

{$R *.dfm}

procedure OpenP688MonitoraggioFondi;
begin
  SolaLetturaOriginale:=SolaLettura;
  SolaLettura:=False;
  case A000GetInibizioni('Funzione','OpenP688MonitoraggioFondi') of
    'N':begin
        ShowMessage('Funzione non abilitata!');
        Exit;
        end;
    'R':SolaLettura:=True;
  end;
  Application.CreateForm(TP688FMonitoraggioFondi,P688FMonitoraggioFondi);
  with P688FMonitoraggioFondi do
    try
      P688FMonitoraggioFondiDtM:=TP688FMonitoraggioFondiDtM.Create(nil);
      ShowModal;
    finally
      SolaLettura:=SolaLetturaOriginale;
      P688FMonitoraggioFondiDtM.Free;
      Free;
    end;
end;

procedure TP688FMonitoraggioFondi.btnDecorrenzaAClick(Sender: TObject);
begin
  edtDecorrenzaA.Text:=DateToStr(DataOut(StrToDate(edtDecorrenzaA.Text),'Alla scadenza','G'));
end;

procedure TP688FMonitoraggioFondi.btnDecorrenzaDaClick(Sender: TObject);
begin
  edtDecorrenzaDa.Text:=DateToStr(DataOut(StrToDate(edtDecorrenzaDa.Text),'Dalla decorrenza','G'));
end;

procedure TP688FMonitoraggioFondi.Copia2Click(Sender: TObject);
var S:String;
  i:Integer;
begin
  with dgrdDettaglio.DataSource.DataSet do
  begin
    if not Active then
      exit;
    S:='';
    Clipboard.Clear;
    DisableControls;
    Screen.Cursor:=crHourGlass;
    First;
    try
      if not EOF then
      begin
        for i:=0 to FieldCount - 1 do
          if Fields[i].Visible then
            S:=S + Fields[i].DisplayLabel + #9;
        S:=S + #13#10;
      end;
      while not EOF do
      begin
        if dgrdDettaglio.SelectedRows.CurrentRowSelected then
        begin
          for i:=0 to FieldCount - 1 do
            if Fields[i].Visible then
              S:=S + Fields[i].AsString + #9;
          S:=S + #13#10;
        end;
        Next;
      end;
    finally
      First;
      EnableControls;
      Screen.Cursor:=crDefault;
    end;
  end;
  Clipboard.AsText:=S;
end;

procedure TP688FMonitoraggioFondi.Deselezionatutto1Click(Sender: TObject);
begin
  R180DBGridSelezionaRighe(dgrdDettaglio,'N');
end;

procedure TP688FMonitoraggioFondi.edtDecorrenzaAExit(Sender: TObject);
begin
  Fine:=StrToDate(edtDecorrenzaA.Text);
  if Fine < Inizio then
  begin
    edtDecorrenzaA.SetFocus;
    raise exception.Create('''Alla scadenza'' deve essere maggiore di ''Dalla decorrenza''!');
  end;
  Aggiorna;
end;

procedure TP688FMonitoraggioFondi.edtDecorrenzaDaExit(Sender: TObject);
begin
  Inizio:=StrToDate(edtDecorrenzaDa.Text);
  Aggiorna;
end;

procedure TP688FMonitoraggioFondi.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  PutParametriFunzione;
  C004FParamForm.Free;
end;

procedure TP688FMonitoraggioFondi.FormCreate(Sender: TObject);
begin
  A000SettaVariabiliAmbiente;
end;

procedure TP688FMonitoraggioFondi.FormShow(Sender: TObject);
begin
  CreaC004(SessioneOracle,'P688',Parametri.ProgOper);
  GetParametriFunzione;
  Aggiorna;
end;

procedure TP688FMonitoraggioFondi.GetParametriFunzione;
{Leggo i parametri della form}
begin
  edtDecorrenzaDa.Text:=C004FParamForm.GetParametro('DECORRENZA_DA','01/01/' + IntToStr(R180Anno(Parametri.DataLavoro)));
  edtDecorrenzaA.Text:=C004FParamForm.GetParametro('DECORRENZA_A','31/12/' + IntToStr(R180Anno(Parametri.DataLavoro)));
end;

procedure TP688FMonitoraggioFondi.Invertiselezione1Click(Sender: TObject);
begin
  R180DBGridSelezionaRighe(dgrdDettaglio,'C');
end;

procedure TP688FMonitoraggioFondi.PutParametriFunzione;
{Scrivo i parametri della forma}
begin
  C004FParamForm.Cancella001;
  C004FParamForm.PutParametro('DECORRENZA_DA',edtDecorrenzaDa.Text);
  C004FParamForm.PutParametro('DECORRENZA_A',edtDecorrenzaA.Text);
  try SessioneOracle.Commit; except end;
end;

procedure TP688FMonitoraggioFondi.rgpRaggruppamentoClick(Sender: TObject);
begin
  if rgpRaggruppamento.ItemIndex = 0 then
  begin
    dgrdDettaglio.Columns[0].Visible:=True;
    dgrdDettaglio.Columns[1].Visible:=True;
    dgrdDettaglio.Columns[2].Visible:=True;
    dgrdDettaglio.Columns[3].Visible:=True;
    dgrdDettaglio.Columns[2].Title.Caption:='Cod.raggr.';
    dgrdDettaglio.Columns[3].Title.Caption:='Descrizione raggruppamento';
    dgrdDettaglio.Columns[2].FieldName:='COD_RAGGR';
    dgrdDettaglio.Columns[3].FieldName:='DESC_RAGGR';
    dgrdDettaglio.Columns[4].Visible:=True;
    dgrdDettaglio.Columns[5].Visible:=True;
  end
  else if rgpRaggruppamento.ItemIndex = 1 then
  begin
    dgrdDettaglio.Columns[0].Visible:=True;
    dgrdDettaglio.Columns[1].Visible:=True;
    dgrdDettaglio.Columns[2].Visible:=True;
    dgrdDettaglio.Columns[3].Visible:=True;
    dgrdDettaglio.Columns[2].Title.Caption:='Cod.fondo/raggr.';
    dgrdDettaglio.Columns[3].Title.Caption:='Descrizione fondo/raggruppamento';
    dgrdDettaglio.Columns[2].FieldName:='COD_FONDO_RAGGR';
    dgrdDettaglio.Columns[3].FieldName:='DESC_FONDO_RAGGR';
    dgrdDettaglio.Columns[4].Visible:=False;
    dgrdDettaglio.Columns[5].Visible:=False;
  end
  else if rgpRaggruppamento.ItemIndex = 2 then
  begin
    dgrdDettaglio.Columns[0].Visible:=True;
    dgrdDettaglio.Columns[1].Visible:=True;
    dgrdDettaglio.Columns[2].Visible:=False;
    dgrdDettaglio.Columns[3].Visible:=False;
    dgrdDettaglio.Columns[4].Visible:=False;
    dgrdDettaglio.Columns[5].Visible:=False;
  end;
  Aggiorna;
end;

procedure TP688FMonitoraggioFondi.Selezionatutto1Click(Sender: TObject);
begin
  R180DBGridSelezionaRighe(dgrdDettaglio,'S');
end;

procedure TP688FMonitoraggioFondi.Aggiorna;
begin
  Inizio:=StrToDate(edtDecorrenzaDa.Text);
  Fine:=StrToDate(edtDecorrenzaA.Text);
  with P688FMonitoraggioFondiDtM do
  begin
    selP688.Close;
    selP688.SetVariable('INIZIO',Inizio);
    selP688.SetVariable('FINE',Fine);
    if rgpRaggruppamento.ItemIndex = 0 then
      selP688.SetVariable('DATI','COD_MACROCATEG,DESC_MACROCATEG,COD_FONDO,DESC_FONDO,COD_RAGGR,DESC_RAGGR')
    else if rgpRaggruppamento.ItemIndex = 1 then
      selP688.SetVariable('DATI','COD_MACROCATEG,DESC_MACROCATEG,COD_FONDO_RAGGR,DESC_FONDO_RAGGR')
    else if rgpRaggruppamento.ItemIndex = 2 then
      selP688.SetVariable('DATI','COD_MACROCATEG,DESC_MACROCATEG');
    selP688.Open;
  end;
end;

end.
