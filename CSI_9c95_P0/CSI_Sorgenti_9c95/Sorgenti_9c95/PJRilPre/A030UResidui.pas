unit  A030UResidui;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  R001UGESTTAB, DB, Menus, Buttons, ExtCtrls, ComCtrls, DBCtrls, StdCtrls,
  Grids, DBGrids, Mask, C180FunzioniGenerali, C700USelezioneAnagrafe,
  A000UCostanti, A000USessione,A000UInterfaccia, C001UFiltroTabelleDtM,C001UFiltroTabelle,
  C001UScegliCampi, A002UInterfacciaSt, C005UDatiAnagrafici,
  ActnList, ImgList, ToolWin, SelAnagrafe, Variants, System.Actions;

type
  TA030FResidui = class(TR001FGestTab)
    TabControl1: TTabControl;
    DBGrid2: TDBGrid;
    frmSelAnagrafe: TfrmSelAnagrafe;
    procedure TCancClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure Stampa1Click(Sender: TObject);
    procedure PageControl1Changing(Sender: TObject;
      var AllowChange: Boolean);
    procedure DButtonStateChange(Sender: TObject);
    procedure PageControl1Change(Sender: TObject);
    procedure frmSelAnagrafeR003DatianagraficiClick(Sender: TObject);
    procedure frmSelAnagrafebtnSelezioneClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    procedure CambiaProgressivo;
  public
    { Public declarations }
  end;

var
  A030FResidui: TA030FResidui;

procedure OpenA030Residui(Progressivo:LongInt; Data:TDateTime; Modificabile:Boolean);

implementation

uses A030UResiduiDtM1;

{$R *.DFM}

procedure OpenA030Residui(Progressivo:LongInt; Data:TDateTime; Modificabile:Boolean);
begin
  if Progressivo <= 0 then
  begin
    ShowMessage('Nessun dipendente selezionato!');
    exit;
  end;
  SolaLetturaOriginale:=SolaLettura;
  SolaLettura:=False;
  case A000GetInibizioni('Funzione','OpenA030Residui') of
    'N':begin
        ShowMessage('Funzione non abilitata!');
        Exit;
        end;
    'R':SolaLettura:=True;
  end;
  SolaLettura:=SolaLettura and (not Modificabile);
  A030FResidui:=TA030FResidui.Create(nil);
  C700Progressivo:=Progressivo;
  with A030FResidui do
    try
    Panel1.Visible:=Modificabile;
    A030FResiduiDtM1:=TA030FResiduiDtM1.Create(nil);
    try
      (*
      if not A030FResiduiDtM1.A030MW.Q130.Locate('Anno',StrToInt(FormatDateTime('yyyy',Data)),[]) then
        if not Modificabile then
        begin
          //Chiudo gli storici prima di eliminare le forms
          Chiudi:=caNone;
          FormClose(A030FResidui,Chiudi);
          raise Exception.Create(Format('Residui del %s inesistenti!',[FormatDateTime('yyyy',Data)]));
        end;
      *)
      ShowModal;
    except
      on E:Exception do
        ShowMessage(E.Message);
    end;
    finally
      SolaLettura:=SolaLetturaOriginale;
      A030FResiduiDtM1.Free;
      Free;
    end;
end;

procedure TA030FResidui.FormShow(Sender: TObject);
begin
  inherited;
  C700DatiVisualizzati:='MATRICOLA,T430BADGE,COGNOME,NOME';
  C700DatiSelezionati:=C700CampiBase;
  C700DataLavoro:=Parametri.DataLavoro;
  frmSelAnagrafe.OnCambiaProgressivo:=CambiaProgressivo;
  frmSelAnagrafe.CreaSelAnagrafe(A030FResiduiDtM1.A030MW,SessioneOracle,StatusBar,2,True);
end;

procedure TA030FResidui.CambiaProgressivo;
begin
  if C700OldProgressivo <> C700Progressivo then
    with A030FResiduiDtM1.A030MW do
    begin
      (*
        Massimo: ho lasciato questo controllo perchè la prima volta che viene richiamato CambiaProgressivo
        SelAnagrafe è nil, non ancora abbinata
      *)
      if not (SelAnagrafe <> nil) then
         SelAnagrafe:=C700SelAnagrafe;
      SelAnagrafe.FieldByName('PROGRESSIVO').AsInteger:=C700Progressivo;
      SettaProgressivo;
      Q130.Locate('Anno',Anno,[]);
      NumRecords;
    end;
end;

procedure TA030FResidui.TCancClick(Sender: TObject);
begin
  try
    inherited;
    with A030FResiduiDtM1.A030MW do
    begin
      selDatiBloccati.MessaggioLog:='Impossibile cancellare i residui!';
      SessioneOracle.ApplyUpdates([Q130],True);
      SessioneOracle.Commit;
    end;
  //Se fallisco annullo le operazioni
  except
    SessioneOracle.RollBack;
    ShowMessage(A030FResiduiDtM1.A030MW.selDatiBloccati.MessaggioLog);
  end;
end;

procedure TA030FResidui.Stampa1Click(Sender: TObject);
begin
  inherited;
  exit;
end;

procedure TA030FResidui.PageControl1Changing(Sender: TObject;
  var AllowChange: Boolean);
begin
  AllowChange:=not(DButton.State in [dsInsert,dsEdit]);
end;

procedure TA030FResidui.DButtonStateChange(Sender: TObject);
begin
  inherited;
  frmSelAnagrafe.Enabled:=DButton.State = dsBrowse;
end;

procedure TA030FResidui.PageControl1Change(Sender: TObject);
begin
  case TabControl1.TabIndex of
    0:DButton.DataSet:=A030FResiduiDtM1.A030MW.Q130;
    1:DButton.DataSet:=A030FResiduiDtM1.A030MW.selT131;
    2:DButton.DataSet:=A030FResiduiDtM1.A030MW.T264;
    3:DButton.DataSet:=A030FResiduiDtM1.A030MW.selT692;
    4:DButton.DataSet:=A030FResiduiDtM1.A030MW.selSG656;
  end;
end;

procedure TA030FResidui.frmSelAnagrafeR003DatianagraficiClick(
  Sender: TObject);
begin
  try
    C005DataVisualizzazione:=EncodeDate(DButton.DataSet.FieldByName('Anno').AsInteger,1,1);
  except
    C005DataVisualizzazione:=Parametri.DataLavoro;
  end;
  frmSelAnagrafe.R003DatianagraficiClick(Sender);
end;

procedure TA030FResidui.frmSelAnagrafebtnSelezioneClick(Sender: TObject);
begin
  try
    if A030FResiduiDtM1.A030MW.Q130Anno.AsInteger = 0 then
      C700DataLavoro:=Parametri.DataLavoro
    else
      C700DataLavoro:=EncodeDate(A030FResiduiDtM1.A030MW.Q130Anno.AsInteger,1,1);
  except
    C700DataLavoro:=Parametri.DataLavoro;
  end;
  frmSelAnagrafe.btnSelezioneClick(Sender);
end;

procedure TA030FResidui.FormDestroy(Sender: TObject);
begin
  inherited;
  frmSelAnagrafe.DistruggiSelAnagrafe;
end;

end.
