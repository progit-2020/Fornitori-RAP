unit A125UBadgeServizio;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  R001UGESTTAB, DB, Menus, Buttons, ExtCtrls, ComCtrls, DBCtrls, StdCtrls,
  Grids, DBGrids, Mask, C180FunzioniGenerali, C700USelezioneAnagrafe,
  A000UCostanti, A000USessione, A000UInterfaccia, A002UInterfacciaSt, A003UDataLavoroBis,
  C001UFiltroTabelleDtM, C001UFiltroTabelle, C001UScegliCampi, C004UParamForm, C005UDatiAnagrafici,
  ActnList, ImgList, ToolWin, SelAnagrafe, Variants;

type
  TA125FBadgeServizio = class(TR001FGestTab)
    frmSelAnagrafe: TfrmSelAnagrafe;
    Panel2: TPanel;
    dgrdOreLiquidate: TDBGrid;
    pnlTitolo: TPanel;
    procedure FormDestroy(Sender: TObject);
    procedure DButtonStateChange(Sender: TObject);
    procedure frmSelAnagrafeR003DatianagraficiClick(Sender: TObject);
    procedure frmSelAnagrafebtnSelezioneClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure dgrdOreLiquidateEditButtonClick(Sender: TObject);
  private
    { Private declarations }
    procedure CambiaProgressivo;
  public
    { Public declarations }
    AnnoRif: Word;
  end;

var
  A125FBadgeServizio: TA125FBadgeServizio;

procedure OpenA125BadgeServizio(Progressivo:LongInt);

implementation

uses A125UBadgeServizioDtM;

{$R *.DFM}

procedure OpenA125BadgeServizio(Progressivo:LongInt);
var iMese,iGiorno:Word;
begin
  if Progressivo <= 0 then
  begin
    ShowMessage('Nessun dipendente selezionato!');
    exit;
  end;
  SolaLetturaOriginale:=SolaLettura;
  SolaLettura:=False;
  case A000GetInibizioni('Funzione','OpenA125BadgeServizio') of
    'N':begin
        ShowMessage('Funzione non abilitata!');
        Exit;
        end;
    'R':SolaLettura:=True;
  end;
  Application.CreateForm(TA125FBadgeServizio, A125FBadgeServizio);
  C700Progressivo:=Progressivo;
  Application.CreateForm(TA125FBadgeServizioDtM, A125FBadgeServizioDtM);
  try
    A125FBadgeServizio.ShowModal;
    DecodeDate(Date,A125FBadgeServizio.AnnoRif,iMese,iGiorno);
  finally
    SolaLettura:=SolaLetturaOriginale;
    A125FBadgeServizio.Free;
    A125FBadgeServizioDtM.Free;
  end;
end;

procedure TA125FBadgeServizio.FormShow(Sender: TObject);
begin
  inherited;
  C700DatiVisualizzati:='MATRICOLA,T430BADGE,COGNOME,NOME';
  C700DatiSelezionati:=C700CampiBase;
  C700DataLavoro:=Parametri.DataLavoro;
  frmSelAnagrafe.OnCambiaProgressivo:=CambiaProgressivo;
  frmSelAnagrafe.CreaSelAnagrafe(SessioneOracle,StatusBar,2,True);
end;

procedure TA125FBadgeServizio.CambiaProgressivo;
begin
  if C700OldProgressivo <> C700Progressivo then
    with A125FBadgeServizioDtM do
    begin
      SettaProgressivo;
      NumRecords;
    end;
end;

procedure TA125FBadgeServizio.DButtonStateChange(Sender: TObject);
begin
  inherited;
  frmSelAnagrafe.Enabled:=DButton.State = dsBrowse;
  if DButton.State = dsBrowse then
    Numrecords;
end;

procedure TA125FBadgeServizio.frmSelAnagrafeR003DatianagraficiClick(
  Sender: TObject);
begin
  try
    C005DataVisualizzazione:=EncodeDate(DButton.DataSet.FieldByName('Anno').AsInteger,1,1);
  except
    C005DataVisualizzazione:=Parametri.DataLavoro;
  end;
  frmSelAnagrafe.R003DatianagraficiClick(Sender);
end;

procedure TA125FBadgeServizio.frmSelAnagrafebtnSelezioneClick(Sender: TObject);
begin
  try
    if A125FBadgeServizioDtM.Q435.FieldByName('DECORRENZA').IsNull then
      C700DataLavoro:=Parametri.DataLavoro
    else
      C700DataLavoro:=A125FBadgeServizioDtM.Q435.FieldByName('DECORRENZA').AsDateTime;
  except
    C700DataLavoro:=Parametri.DataLavoro;
  end;
  frmSelAnagrafe.btnSelezioneClick(Sender);
end;

procedure TA125FBadgeServizio.FormDestroy(Sender: TObject);
begin
  inherited;
  frmSelAnagrafe.DistruggiSelAnagrafe;
end;

procedure TA125FBadgeServizio.dgrdOreLiquidateEditButtonClick(
  Sender: TObject);
begin
  with A125FBadgeServizioDtM do
  begin
    case dgrdOreLiquidate.SelectedIndex of
      1: //Richiesta data di decorrenza
      begin
        if Q435.FieldByName('DECORRENZA').IsNull then
          Q435.FieldByName('DECORRENZA').AsDateTime:=Parametri.DataLavoro;
        Q435.FieldByName('DECORRENZA').AsDateTime:=DataOut(Q435.FieldByName('DECORRENZA').AsDateTime,'Decorrenza badge di servizio','G');
      end;
      2: //Richiesta data di scadenza
      begin
        if Q435.FieldByName('SCADENZA').IsNull then
          Q435.FieldByName('SCADENZA').AsDateTime:=Parametri.DataLavoro;
        Q435.FieldByName('SCADENZA').AsDateTime:=DataOut(Q435.FieldByName('SCADENZA').AsDateTime,'Scadenza badge di servizio','G');
      end;
    end;
  end;
end;

end.
