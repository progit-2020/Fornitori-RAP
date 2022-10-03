unit A048UPastiMese;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  R001UGESTTAB, Db, Menus, Buttons, ExtCtrls, ComCtrls, Grids, DBGrids,
  StdCtrls, C700USelezioneAnagrafe, A000UCostanti, A000USessione,A000UInterfaccia, ActnList, ImgList, ToolWin,
  C001UFiltroTabelle, C001UFiltroTabelleDtM, C001UScegliCampi,
  A002UInterfacciaSt, SelAnagrafe, C005UDatiAnagrafici, Variants, System.Actions;
type
  TA048FPastiMese = class(TR001FGestTab)
    DBGrid1: TDBGrid;
    frmSelAnagrafe: TfrmSelAnagrafe;
    procedure frmSelAnagrafeR003DatianagraficiClick(Sender: TObject);
    procedure frmSelAnagrafebtnSelezioneClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
    procedure CambiaProgressivo;
  public
    { Public declarations }
  end;

var
  A048FPastiMese: TA048FPastiMese;

procedure OpenA048PastiMese(Prog:LongInt);

implementation

uses A048UPastiMeseDTM1;

{$R *.DFM}

procedure OpenA048PastiMese(Prog:LongInt);
begin
  if Prog <= 0 then
  begin
    ShowMessage('Nessun dipendente selezionato!');
    exit;
  end;
  SolaLetturaOriginale:=SolaLettura;
  SolaLettura:=False;
  case A000GetInibizioni('Funzione','OpenA048PastiMese') of
    'N':
        begin
        ShowMessage('Funzione non abilitata!');
        Exit;
        end;
    'R':SolaLettura:=True;
  end;
  A048FPastiMese:=TA048FPastiMese.Create(nil);
  with A048FPastiMese do
    try
      C700Progressivo:=Prog;
      A048FPastiMeseDtM1:=TA048FPastiMeseDtM1.Create(nil);
      ShowModal;
    finally
      SolaLettura:=SolaLetturaOriginale;
      A048FPastiMeseDtM1.Free;
      Free;
    end;
end;

procedure TA048FPastiMese.FormShow(Sender: TObject);
begin
  inherited;
  C700DatiVisualizzati:='MATRICOLA,T430BADGE,COGNOME,NOME';
  C700DatiSelezionati:=C700CampiBase;
  C700DataLavoro:=Parametri.DataLavoro;
  frmSelAnagrafe.OnCambiaProgressivo:=CambiaProgressivo;
  frmSelAnagrafe.CreaSelAnagrafe(SessioneOracle,StatusBar,2,True);
end;

procedure TA048FPastiMese.CambiaProgressivo;
begin
  if C700OldProgressivo <> C700Progressivo then
  begin
    A048FPastiMeseDtM1.SettaProgressivo;
    NumRecords;
  end;
end;

procedure TA048FPastiMese.frmSelAnagrafeR003DatianagraficiClick(
  Sender: TObject);
begin
  C005DataVisualizzazione:=Parametri.DataLavoro;
  frmSelAnagrafe.R003DatianagraficiClick(Sender);
end;

procedure TA048FPastiMese.frmSelAnagrafebtnSelezioneClick(Sender: TObject);
begin
  C700DataLavoro:=Parametri.DataLavoro;
  frmSelAnagrafe.btnSelezioneClick(Sender);
end;

procedure TA048FPastiMese.FormDestroy(Sender: TObject);
begin
  inherited;
  frmSelAnagrafe.DistruggiSelAnagrafe;
end;

end.
