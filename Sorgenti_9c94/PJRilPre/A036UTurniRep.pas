unit A036UTurniRep;

interface

uses
  Classes, Controls, Forms, Dialogs, Db, Menus, ComCtrls, Grids, DBGrids,
  ActnList, ImgList, ToolWin, Variants, R001UGESTTAB,
  A000UInterfaccia, A000UMessaggi, A000USessione,
  C005UDatiAnagrafici, C700USelezioneAnagrafe, SelAnagrafe, System.Actions;

type
  TA036FTurniRep = class(TR001FGestTab)
    dgrdT340: TDBGrid;
    frmSelAnagrafe: TfrmSelAnagrafe;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure frmSelAnagrafeR003DatianagraficiClick(Sender: TObject);
    procedure DButtonStateChange(Sender: TObject);
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
    procedure CambiaProgressivo;
  public
    { Public declarations }
  end;

var
  A036FTurniRep: TA036FTurniRep;

procedure OpenA036TurniRep(Progressivo:LongInt);

implementation

uses A036UTurniRepDTM1;

{$R *.DFM}

procedure OpenA036TurniRep(Progressivo:LongInt);
{Turni di reperibilità}
begin
  if Progressivo <= 0 then
  begin
    ShowMessage(A000MSG_ERR_NO_DIP);
    exit;
  end;
  SolaLetturaOriginale:=SolaLettura;
  SolaLettura:=False;
  case A000GetInibizioni('Funzione','OpenA036TurniRep') of
    'N':begin
        ShowMessage(A000MSG_ERR_FUNZ_NON_ABILITATA);
        Exit;
        end;
    'R':SolaLettura:=True;
  end;
  A036FTurniRep:=TA036FTurniRep.Create(nil);
  C700Progressivo:=Progressivo;
  with A036FTurniRep do
    try
      A036FTurniRepDtM1:=TA036FTurniRepDtM1.Create(nil);
      ShowModal;
    finally
      SolaLettura:=SolaLetturaOriginale;
      A036FTurniRepDtM1.Free;
      Free;
    end;
end;

procedure TA036FTurniRep.FormCreate(Sender: TObject);
begin
  inherited;
  dgrdT340.ReadOnly:=SolaLettura;
end;

procedure TA036FTurniRep.FormDestroy(Sender: TObject);
begin
  inherited;
  frmSelAnagrafe.DistruggiSelAnagrafe;
end;

procedure TA036FTurniRep.FormActivate(Sender: TObject);
begin
  DButton.DataSet:=A036FTurniRepDtM1.selT340;
  inherited;
end;

procedure TA036FTurniRep.FormShow(Sender: TObject);
var i:Integer;
begin
  inherited;
  C700DatiVisualizzati:='MATRICOLA,T430BADGE,COGNOME,NOME';
  C700DatiSelezionati:=C700CampiBase;
  C700DataLavoro:=Parametri.DataLavoro;
  frmSelAnagrafe.OnCambiaProgressivo:=CambiaProgressivo;
  frmSelAnagrafe.CreaSelAnagrafe(A036FTurniRepDtM1.A036MW,SessioneOracle,StatusBar,2,True);
  for i:=0 to dgrdT340.Columns.Count - 1 do
    if Copy(dgrdT340.Columns[i].FieldName,1,3) = 'VP_' then
      A036FTurniRepDtM1.A036MW.CaricaPickList(dgrdT340.Columns[i].PickList,dgrdT340.Columns[i].FieldName);
end;

procedure TA036FTurniRep.frmSelAnagrafeR003DatianagraficiClick(Sender: TObject);
begin
  C005DataVisualizzazione:=Parametri.DataLavoro;
  frmSelAnagrafe.R003DatianagraficiClick(Sender);
end;

procedure TA036FTurniRep.DButtonStateChange(Sender: TObject);
begin
  inherited;
  frmSelAnagrafe.Enabled:=Dbutton.State = dsBrowse;
end;

procedure TA036FTurniRep.CambiaProgressivo;
begin
  if C700OldProgressivo <> C700Progressivo then
  begin
    A036FTurniRepDtM1.A036MW.SettaProgressivo;
    NumRecords;
  end;
end;

end.
