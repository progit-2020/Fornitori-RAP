unit A117UOreLiquidateAnniPrec;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  R001UGESTTAB, DB, Menus, Buttons, ExtCtrls, ComCtrls, DBCtrls, StdCtrls,
  Grids, DBGrids, Mask, C180FunzioniGenerali, C700USelezioneAnagrafe,
  A000UCostanti, A000USessione, A000UInterfaccia, A002UInterfacciaSt, A003UDataLavoroBis,
  C001UFiltroTabelleDtM, C001UFiltroTabelle, C001UScegliCampi, C005UDatiAnagrafici,
  ActnList, ImgList, ToolWin, SelAnagrafe, Variants;

type
  TA117FOreLiquidateAnniPrec = class(TR001FGestTab)
    frmSelAnagrafe: TfrmSelAnagrafe;
    Panel2: TPanel;
    dgrdOreLiquidate: TDBGrid;
    procedure FormDestroy(Sender: TObject);
    procedure DButtonStateChange(Sender: TObject);
    procedure frmSelAnagrafeR003DatianagraficiClick(Sender: TObject);
    procedure frmSelAnagrafebtnSelezioneClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure dgrdOreLiquidateEditButtonClick(Sender: TObject);
    procedure dgrdOreLiquidateDrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
  private
    { Private declarations }
    procedure CambiaProgressivo;
  public
  end;

var
  A117FOreLiquidateAnniPrec: TA117FOreLiquidateAnniPrec;

procedure OpenA117OreLiquidateAnniPrec(Progressivo:LongInt; Data:TDateTime);

implementation

uses A117UOreLiquidateAnniPrecDtM;

{$R *.DFM}

procedure OpenA117OreLiquidateAnniPrec(Progressivo:LongInt; Data:TDateTime);
begin
  if Progressivo <= 0 then
  begin
    ShowMessage('Nessun dipendente selezionato!');
    exit;
  end;
  SolaLetturaOriginale:=SolaLettura;
  SolaLettura:=False;
  case A000GetInibizioni('Funzione','OpenA117OreLiquidateAnniPrec') of
    'N':begin
        ShowMessage('Funzione non abilitata!');
        Exit;
        end;
    'R':SolaLettura:=True;
  end;
  Application.CreateForm(TA117FOreLiquidateAnniPrec, A117FOreLiquidateAnniPrec);
  C700Progressivo:=Progressivo;
  Application.CreateForm(TA117FOreLiquidateAnniPrecDtM, A117FOreLiquidateAnniPrecDtM);
  try
    A117FOreLiquidateAnniPrec.ShowModal;
  finally
    SolaLettura:=SolaLetturaOriginale;
    A117FOreLiquidateAnniPrec.Free;
    A117FOreLiquidateAnniPrecDtM.Free;
  end;
end;

procedure TA117FOreLiquidateAnniPrec.FormShow(Sender: TObject);
begin
  inherited;
  C700DatiVisualizzati:='MATRICOLA,T430BADGE,COGNOME,NOME';
  C700DatiSelezionati:=C700CampiBase;
  C700DataLavoro:=Parametri.DataLavoro;
  frmSelAnagrafe.OnCambiaProgressivo:=CambiaProgressivo;
  frmSelAnagrafe.CreaSelAnagrafe(SessioneOracle,StatusBar,2,True);
end;

procedure TA117FOreLiquidateAnniPrec.CambiaProgressivo;
begin
  if C700OldProgressivo <> C700Progressivo then
    with A117FOreLiquidateAnniPrecDtM do
    begin
      SettaProgressivo;
      Q134.Locate('ANNO',R180Anno(Parametri.DataLavoro) - 1,[]);
      NumRecords;
    end;
end;

procedure TA117FOreLiquidateAnniPrec.DButtonStateChange(Sender: TObject);
begin
  inherited;
  frmSelAnagrafe.Enabled:=DButton.State = dsBrowse;
end;

procedure TA117FOreLiquidateAnniPrec.frmSelAnagrafeR003DatianagraficiClick(
  Sender: TObject);
begin
  try
    C005DataVisualizzazione:=EncodeDate(DButton.DataSet.FieldByName('Anno').AsInteger,1,1);
  except
    C005DataVisualizzazione:=Parametri.DataLavoro;
  end;
  frmSelAnagrafe.R003DatianagraficiClick(Sender);
end;

procedure TA117FOreLiquidateAnniPrec.frmSelAnagrafebtnSelezioneClick(Sender: TObject);
begin
  try
    if A117FOreLiquidateAnniPrecDtM.Q134.FieldByName('ANNO').AsInteger = 0 then
      C700DataLavoro:=Parametri.DataLavoro
    else
      C700DataLavoro:=EncodeDate(A117FOreLiquidateAnniPrecDtM.Q134.FieldByName('ANNO').AsInteger,1,1);
  except
    C700DataLavoro:=Parametri.DataLavoro;
  end;
  frmSelAnagrafe.btnSelezioneClick(Sender);
end;

procedure TA117FOreLiquidateAnniPrec.FormDestroy(Sender: TObject);
begin
  inherited;
  frmSelAnagrafe.DistruggiSelAnagrafe;
end;

procedure TA117FOreLiquidateAnniPrec.dgrdOreLiquidateDrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
{Evidenziazione in rosso del residuo negativo delle ore perse (MILANO_HMAGGIORE)}
begin
  if gdFixed in State then exit;
  if (DataCol in [5,6]) and
     (R180OreMinutiExt(dgrdOreLiquidate.DataSource.DataSet.FieldByName('OREPERSE_RES').AsString) < 0) then
  begin
    if gdSelected in State then
    begin
      dgrdOreLiquidate.Canvas.Brush.Color:=clHighLight;
      dgrdOreLiquidate.Canvas.Font.Color:=clWhite;
    end
    else
      dgrdOreLiquidate.Canvas.Font.Color:=clRed;
    dgrdOreLiquidate.DefaultDrawColumnCell(Rect,DataCol,Column,State);
  end;
end;

procedure TA117FOreLiquidateAnniPrec.dgrdOreLiquidateEditButtonClick(
  Sender: TObject);
begin
  with A117FOreLiquidateAnniPrecDtM do
  begin
    case dgrdOreLiquidate.SelectedIndex of
      1: //Richiesta data di liquidazione tramite calendario
      begin
        if Q134.FieldByName('DATA').IsNull then
          Q134.FieldByName('DATA').AsDateTime:=R180InizioMese(Parametri.DataLavoro);
        Q134.FieldByName('DATA').AsDateTime:=DataOut(Q134.FieldByName('DATA').AsDateTime,'Mese di liquidazione','M');
      end;
    end;
  end;
end;

end.
