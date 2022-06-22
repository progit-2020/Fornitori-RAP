unit A122UIscrizioniSindacati;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  R001UGESTTAB, StdCtrls, DBCtrls, ExtCtrls, Mask, DB, Menus, Buttons,
  ComCtrls, A000UCostanti, A000UMessaggi, A000USessione, A000UInterfaccia, C001UFiltroTabelleDtM, C700USelezioneAnagrafe,
  C001UFiltroTabelle, C001UScegliCampi, A002UInterfacciaSt, C005UDatiAnagrafici,
  ActnList, ImgList, ToolWin, SelAnagrafe, Variants, Grids, DBGrids, A121UOrganizzSindacali,
  System.Actions;

type
  TA122FIscrizioniSindacati = class(TR001FGestTab)
    PopupMenu1: TPopupMenu;
    Nuovoelemento1: TMenuItem;
    frmSelAnagrafe: TfrmSelAnagrafe;
    grdIscrizioni: TDBGrid;
    procedure DButtonStateChange(Sender: TObject);
    procedure frmSelAnagrafeR003DatianagraficiClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Nuovoelemento1Click(Sender: TObject);
  private
    { Private declarations }
    procedure CambiaProgressivo;
  public
    { Public declarations }
  end;

var
  A122FIscrizioniSindacati: TA122FIscrizioniSindacati;

procedure OpenA122IscrizioniSindacati(Prog:LongInt);

implementation

uses A122UIscrizioniSindacatiDtM;

{$R *.DFM}

procedure OpenA122IscrizioniSindacati(Prog:LongInt);
{Iscrizione Sindacati}
begin
  if Prog <= 0 then
  begin
    ShowMessage(A000MSG_ERR_NO_DIP);
    exit;
  end;
  SolaLetturaOriginale:=SolaLettura;
  SolaLettura:=False;
  case A000GetInibizioni('Funzione','OpenA122IscrizioniSindacati') of
    'N':begin
        ShowMessage(A000MSG_ERR_FUNZ_NON_ABILITATA);
        Exit;
        end;
    'R':SolaLettura:=True;
  end;
  A122FIscrizioniSindacati:=TA122FIscrizioniSindacati.Create(nil);
  with A122FIscrizioniSindacati do
    try
      C700Progressivo:=Prog;
      A122FIscrizioniSindacatiDtM:=TA122FIscrizioniSindacatiDtM.Create(nil);
      ShowModal;
    finally
      SolaLettura:=SolaLetturaOriginale;
      A122FIscrizioniSindacatiDtM.Free;
      Free;
    end;
end;

procedure TA122FIscrizioniSindacati.CambiaProgressivo;
begin
  with A122FIscrizioniSindacatiDtM do
  begin
    selT246.SetVariable('Progressivo',C700Progressivo);
    selT246.Close;
    selT246.Open;
    NumRecords;
  end;
end;

procedure TA122FIscrizioniSindacati.DButtonStateChange(Sender: TObject);
begin
  inherited;
  frmSelAnagrafe.Enabled:=DButton.State = dsBrowse;
  if DButton.State = dsEdit then
    A122FIscrizioniSindacatiDtM.A122MW.CaricaSindacati;
end;

procedure TA122FIscrizioniSindacati.frmSelAnagrafeR003DatianagraficiClick(Sender: TObject);
begin
  C005DataVisualizzazione:=Date;
  frmSelAnagrafe.R003DatianagraficiClick(Sender);
end;

procedure TA122FIscrizioniSindacati.FormDestroy(Sender: TObject);
begin
  inherited;
  frmSelAnagrafe.DistruggiSelAnagrafe;
end;

procedure TA122FIscrizioniSindacati.FormShow(Sender: TObject);
begin 
  inherited;
  DButton.DataSet:=A122FIscrizioniSindacatiDtM.selT246;
  C700DatiVisualizzati:='MATRICOLA,T430BADGE,COGNOME,NOME';
  C700DatiSelezionati:=C700CampiBase;
  C700DataLavoro:=Parametri.DataLavoro;
  frmSelAnagrafe.OnCambiaProgressivo:=CambiaProgressivo;
  frmSelAnagrafe.CreaSelAnagrafe(A122FIscrizioniSindacatiDtM.A122MW, SessioneOracle, StatusBar,2,True);
end;

procedure TA122FIscrizioniSindacati.Nuovoelemento1Click(Sender: TObject);
begin
  inherited;
  OpenA121OrganizzSindacali(A122FIscrizioniSindacatiDtM.selT246.FieldByName('COD_SINDACATO').AsString);
end;

end.
