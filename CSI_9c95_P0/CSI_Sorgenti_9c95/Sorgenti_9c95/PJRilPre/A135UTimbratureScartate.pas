unit A135UTimbratureScartate;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, R001UGESTTAB, ActnList, ImgList, DB, Menus, ComCtrls, ToolWin,
  ExtCtrls, StdCtrls, Spin, Grids, DBGrids, SelAnagrafe, A000UCostanti, A000USessione,
  A000UInterfaccia, C180FUNZIONIGENERALI, C700USelezioneAnagrafe;

type
  TA135FTimbratureScartate = class(TR001FGestTab)
    gpbTimbratureScartate: TGroupBox;
    gpbTimbraturePresenza: TGroupBox;
    Splitter1: TSplitter;
    pnlIntestazione: TPanel;
    sedtMese: TSpinEdit;
    sedtAnno: TSpinEdit;
    lblMese: TLabel;
    lblAnno: TLabel;
    dgrdTimbratureScartate: TDBGrid;
    dgrdTimbraturePresenza: TDBGrid;
    frmSelAnagrafe: TfrmSelAnagrafe;
    procedure MeseAnnoChange(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    procedure CambiaProgressivo;
  public
    { Public declarations }
    Progressivo:Integer;
    InizioMese,FineMese:TDateTime;
    Giorno,Mese,Anno:Word;
    procedure CaricaDati;
  end;

var
  A135FTimbratureScartate: TA135FTimbratureScartate;

  procedure OpenA135FTimbratureScartate(Prog:LongInt);

implementation

uses
  A135UTimbratureScartateDtM;

{$R *.dfm}


procedure OpenA135FTimbratureScartate(Prog:LongInt);
begin
  SolaLetturaOriginale:=SolaLettura;
  SolaLettura:=False;
  case A000GetInibizioni('Funzione','OpenA135FTimbratureScartate') of
    'N':begin
        ShowMessage('Funzione non abilitata!');
        Exit;
        end;
    'R':SolaLettura:=True;
  end;
  Application.CreateForm(TA135FTimbratureScartate,A135FTimbratureScartate);
  Application.CreateForm(TA135FTimbratureScartateDtM,A135FTimbratureScartateDtM);
  C700Progressivo:=Prog;
  try
    A135FTimbratureScartate.ShowModal;
  finally
    SolaLettura:=SolaLetturaOriginale;
    A135FTimbratureScartateDtM.Free;
    A135FTimbratureScartate.Free;
  end;
end;

procedure TA135FTimbratureScartate.FormShow(Sender: TObject);
begin
  inherited;
  actModifica.Visible:=False;
  actInserisci.Visible:=False;
  actCancella.Visible:=False;
  ToolButton10.Visible:=False;
  actAnnulla.Visible:=False;
  actConferma.Visible:=False;
  ToolButton14.Visible:=False;
  actGomma.Visible:=False;
  ToolButton16.Visible:=False;
  //
  C700DatiVisualizzati:='MATRICOLA,T430BADGE,COGNOME,NOME';
  C700DatiSelezionati:=C700CampiBase;
  C700DataLavoro:=Parametri.DataLavoro;
  frmSelAnagrafe.OnCambiaProgressivo:=CambiaProgressivo;
  frmSelAnagrafe.CreaSelAnagrafe(SessioneOracle,StatusBar,2,True);
  frmSelAnagrafe.NumRecords;
  DecodeDate(Date,Anno,Mese,Giorno);
  sedtMese.Value:=Mese;
  sedtAnno.Value:=Anno;
  InizioMese:=EncodeDate(Anno,Mese,1);
  FineMese:=R180FineMese(InizioMese);
  CaricaDati;
end;

procedure TA135FTimbratureScartate.CambiaProgressivo;
begin
  Progressivo:=C700Progressivo;
  CaricaDati;
end;

procedure TA135FTimbratureScartate.MeseAnnoChange(Sender: TObject);
begin
  inherited;
  if Sender = sedtMese then
    begin
    if sedtMese.Value <> Mese then
      begin
      Mese:=sedtMese.Value;
      end;
    end
  else
    begin
    if sedtAnno.Value <> Anno then
      begin
      Anno:=sedtAnno.Value;
      end;
    end;
  InizioMese:=EncodeDate(Anno,Mese,1);
  FineMese:=R180FineMese(InizioMese);
  CaricaDati;
end;

procedure TA135FTimbratureScartate.CaricaDati;
begin
  with A135FTimbratureScartateDtM.selT103 do
  begin
    Close;
    SetVariable('PROGRESSIVO',Progressivo);
    SetVariable('DATAINIZIO',InizioMese);
    SetVariable('DATAFINE',FineMese);
    Open;
    if Recordcount = 0 then
      gpbTimbraturePresenza.Caption:='Timbrature di Presenza';
  end;
  with A135FTimbratureScartateDtM.selT100 do
  begin
    Close;
    SetVariable('PROGRESSIVO',Progressivo);
    SetVariable('DATAGIORNO',A135FTimbratureScartateDtM.selT103.FieldByName('DATA').AsDateTime);
    Open;
  end;
end;

end.
