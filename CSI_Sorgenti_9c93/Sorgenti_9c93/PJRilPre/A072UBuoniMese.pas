unit A072UBuoniMese;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  R001UGESTTAB, Db, Menus, Buttons, ExtCtrls, ComCtrls, Grids, DBGrids,
  StdCtrls, A000UCostanti, A000USessione,A000UInterfaccia, ActnList, ImgList, ToolWin,
  C001UFiltroTabelle, C001UFiltroTabelleDtM, C001UScegliCampi,
  C700USelezioneAnagrafe,A002UInterfacciaSt, SelAnagrafe, C005UDatiAnagrafici, Variants,
  System.Actions, C012UVisualizzaTesto;

type
  TA072FBuoniMese = class(TR001FGestTab)
    DBGrid1: TDBGrid;
    frmSelAnagrafe: TfrmSelAnagrafe;
    procedure frmSelAnagrafeR003DatianagraficiClick(Sender: TObject);
    procedure frmSelAnagrafebtnSelezioneClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure DButtonStateChange(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure DBGrid1EditButtonClick(Sender: TObject);
  private
    { Private declarations }
    procedure CambiaProgressivo;
  public
    { Public declarations }
  end;

var
  A072FBuoniMese: TA072FBuoniMese;

procedure OpenA072BuoniMese(Prog:LongInt);

implementation

uses A072UBuoniMeseDTM1;

{$R *.DFM}

procedure OpenA072BuoniMese(Prog:LongInt);
begin
  if Prog <= 0 then
  begin
    ShowMessage('Nessun dipendente selezionato!');
    exit;
  end;
  SolaLetturaOriginale:=SolaLettura;
  SolaLettura:=False;
  case A000GetInibizioni('Funzione','OpenA072BuoniMese') of
    'N':begin
        ShowMessage('Funzione non abilitata!');
        Exit;
        end;
    'R':SolaLettura:=True;
  end;
  A072FBuoniMese:=TA072FBuoniMese.Create(nil);
  with A072FBuoniMese do
    try
      C700Progressivo:=Prog;
      A072FBuoniMeseDtM1:=TA072FBuoniMeseDtM1.Create(nil);
      ShowModal;
    finally
      SolaLettura:=SolaLetturaOriginale;
      A072FBuoniMeseDtM1.Free;
      Free;
    end;
end;

procedure TA072FBuoniMese.FormShow(Sender: TObject);
begin
  inherited;
  C700DatiVisualizzati:='MATRICOLA,T430BADGE,COGNOME,NOME';
  C700DatiSelezionati:=C700CampiBase;
  C700DataLavoro:=Parametri.DataLavoro;
  frmSelAnagrafe.OnCambiaProgressivo:=CambiaProgressivo;
  frmSelAnagrafe.CreaSelAnagrafe(SessioneOracle,StatusBar,2,True);
end;

procedure TA072FBuoniMese.CambiaProgressivo;
begin
  if C700OldProgressivo <> C700Progressivo then
  begin
    A072FBuoniMeseDtM1.SettaProgressivo;
    NumRecords;
  end;
end;

procedure TA072FBuoniMese.frmSelAnagrafeR003DatianagraficiClick(
  Sender: TObject);
begin
  C005DataVisualizzazione:=Parametri.DataLavoro;
  frmSelAnagrafe.R003DatianagraficiClick(Sender);
end;

procedure TA072FBuoniMese.frmSelAnagrafebtnSelezioneClick(Sender: TObject);
begin
  C700DataLavoro:=Parametri.DataLavoro;
  frmSelAnagrafe.btnSelezioneClick(Sender);
end;

procedure TA072FBuoniMese.DBGrid1EditButtonClick(Sender: TObject);
var
  StrListNote:TStringList;
  Pulsanti:TMsgDlgButtons;
begin
  inherited;
  Pulsanti:=[];
  if A072FBuoniMeseDtm1.Q680.state in [dsInsert,dsEdit] then
    Pulsanti:=[mbOK,mbCancel];
  StrListNote:=TStringList.Create;
  try
    StrListNote.Text:=A072FBuoniMeseDtM1.Q680.FieldByName('NOTE').AsString;
    OpenC012VisualizzaTesto(Self.Caption,'',StrListNote,'',Pulsanti);
    A072FBuoniMeseDtM1.Q680.FieldByName('NOTE').AsString:=StrListNote.Text;
  finally
    FreeAndNil(StrListNote);
  end;
end;

procedure TA072FBuoniMese.DButtonStateChange(Sender: TObject);
begin
  inherited;
  frmSelAnagrafe.Enabled:=DButton.State = dsBrowse;
end;

procedure TA072FBuoniMese.FormDestroy(Sender: TObject);
begin
  inherited;
  frmSelAnagrafe.DistruggiSelAnagrafe;
end;

end.
