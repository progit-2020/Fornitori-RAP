unit A073UAcquistoBuoni;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  R001UGESTTAB, Db, Menus, Buttons, ExtCtrls, ComCtrls, StdCtrls, Grids,
  DBGrids, C700USelezioneAnagrafe, A000UCostanti, A000USessione,A000UInterfaccia, C001UFiltroTabelle,
  C001UScegliCampi,C001UFiltroTabelleDtM,C180FUnzioniGenerali, A002UInterfacciaSt,
  C005UDatiAnagrafici, ActnList, ImgList, ToolWin, SelAnagrafe, Variants, A062UQueryServizio,
  A132UMagazzinoBuoniPasto, System.Actions;

type
  TA073FAcquistoBuoni = class(TR001FGestTab)
    DBGrid1: TDBGrid;
    Riepilogo1: TMenuItem;
    frmSelAnagrafe: TfrmSelAnagrafe;
    Interrogazionidiservizio1: TMenuItem;
    N4: TMenuItem;
    N5: TMenuItem;
    MagazzinoBuonipasto1: TMenuItem;
    procedure MagazzinoBuonipasto1Click(Sender: TObject);
    procedure Interrogazionidiservizio1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Riepilogo1Click(Sender: TObject);
    procedure frmSelAnagrafeR003DatianagraficiClick(Sender: TObject);
    procedure frmSelAnagrafebtnSelezioneClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
    procedure CambiaProgressivo;
  public
    { Public declarations }
  end;

var
  A073FAcquistoBuoni: TA073FAcquistoBuoni;

procedure OpenA073AcquistoBuoni(Prog:LongInt);

implementation

uses A073UAcquistoBuoniDtM1, A073UControllo;

{$R *.DFM}

procedure OpenA073AcquistoBuoni(Prog:LongInt);
begin
  if Prog <= 0 then
  begin
    ShowMessage('Nessun dipendente selezionato!');
    exit;
  end;
  SolaLetturaOriginale:=SolaLettura;
  SolaLettura:=False;
  case A000GetInibizioni('Funzione','OpenA073AcquistoBuoni') of
    'N':begin
        ShowMessage('Funzione non abilitata!');
        Exit;
        end;
    'R':SolaLettura:=True;
  end;
  A073FAcquistoBuoni:=TA073FAcquistoBuoni.Create(nil);
  with A073FAcquistoBuoni do
    try
      C700Progressivo:=Prog;
      A073FAcquistoBuoniDtM1:=TA073FAcquistoBuoniDtM1.Create(nil);
      ShowModal;
    finally
      SolaLettura:=SolaLetturaOriginale;
      A073FAcquistoBuoniDtM1.Free;
      Free;
    end;
end;

procedure TA073FAcquistoBuoni.CambiaProgressivo;
begin
  if C700OldProgressivo <> C700Progressivo then
  begin
    A073FAcquistoBuoniDTM1.SettaProgressivo;
    NumRecords;
  end;
end;

procedure TA073FAcquistoBuoni.FormShow(Sender: TObject);
begin
  DButton.DataSet:=A073FAcquistoBuoniDtM1.Q690;
  C700DatiVisualizzati:='MATRICOLA,T430BADGE,COGNOME,NOME';
  C700DatiSelezionati:=C700CampiBase;
  C700DataLavoro:=Parametri.DataLavoro;
  frmSelAnagrafe.OnCambiaProgressivo:=CambiaProgressivo;
  frmSelAnagrafe.CreaSelAnagrafe(A073FAcquistoBuoniDtM1.A073MW,SessioneOracle,StatusBar,2,True);
  DBGrid1.Columns[R180GetColonnaDBGrid(DBGrid1,'ID_BLOCCHETTI')].Visible:=A073FAcquistoBuoniDtM1.Q690.FieldByName('ID_BLOCCHETTI').Visible;
  DBGrid1.Columns[R180GetColonnaDBGrid(DBGrid1,'DATA_MAGAZZINOLK')].Visible:=A073FAcquistoBuoniDtM1.Q690.FieldByName('DATA_MAGAZZINO').Visible;
  if A073FAcquistoBuoniDtM1.Q690.FieldByName('DATA_MAGAZZINO').Visible then
    Width:=Width + 70;
  if A073FAcquistoBuoniDtM1.Q690.FieldByName('ID_BLOCCHETTI').Visible then
    Width:=Width + 100;
end;

procedure TA073FAcquistoBuoni.Riepilogo1Click(Sender: TObject);
var A,M,G:Word;
    D:TDateTime;
begin
  if DButton.State in [dsEdit,dsInsert] then
    DButton.DataSet.Cancel;
  A073FControllo:=TA073FControllo.Create(nil);
  with A073FControllo do
    try
      D:=Parametri.DataLavoro;
      lblDipendente.Caption:=frmSelAnagrafe.lblDipendente.Caption;
      Prog:=C700Progressivo;
      if DButton.DataSet.RecordCount > 0 then
        try
          D:=DButton.DataSet.FieldByName('DATA').AsDateTime;
        except
        end;
      DecodeDate(D,A,M,G);
      EDaData.Text:=FormatDateTime('dd/mm/yyyy',D);
      EAData.Text:=FormatDateTime('dd/mm/yyyy',Date);
      ShowModal;
    finally
      Release;
    end;
end;

procedure TA073FAcquistoBuoni.frmSelAnagrafeR003DatianagraficiClick(
  Sender: TObject);
begin
  C005DataVisualizzazione:=Parametri.DataLavoro;
  frmSelAnagrafe.R003DatianagraficiClick(Sender);
end;

procedure TA073FAcquistoBuoni.frmSelAnagrafebtnSelezioneClick(
  Sender: TObject);
begin
  C700DataLavoro:=Parametri.DataLavoro;
  frmSelAnagrafe.btnSelezioneClick(Sender);
end;

procedure TA073FAcquistoBuoni.FormDestroy(Sender: TObject);
begin
  inherited;
  frmSelAnagrafe.DistruggiSelAnagrafe;
end;

procedure TA073FAcquistoBuoni.Interrogazionidiservizio1Click(Sender: TObject);
begin
  frmSelAnagrafe.SalvaC00SelAnagrafe;
  C700Distruzione;
  OpenA062QueryServizio('','');
  C700DatiSelezionati:=C700CampiBase;
  C700Creazione(SessioneOracle);
  frmSelAnagrafe.RipristinaC00SelAnagrafe(A073FAcquistoBuoniDtM1.A073MW);
end;

procedure TA073FAcquistoBuoni.MagazzinoBuonipasto1Click(Sender: TObject);
begin
  OpenA132MagazzinoBuoniPasto;
  A073FAcquistoBuoniDtM1.A073MW.selT691.Refresh;
end;

end.
