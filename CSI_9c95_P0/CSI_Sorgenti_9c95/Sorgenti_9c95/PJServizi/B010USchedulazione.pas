unit B010USchedulazione;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  R001UGESTTAB, Grids, DBGrids, ActnList, ImgList, Db, Menus, ComCtrls,
  ToolWin, C180FunzioniGenerali, C013UCheckList, Variants;

type
  TB010FSchedulazione = class(TR001FGestTab)
    dGrdSchedulazione: TDBGrid;
    mnuSchedulazione: TPopupMenu;
    Copiaschedulazione1: TMenuItem;
    Eliminaschedulazione1: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure dGrdSchedulazioneEditButtonClick(Sender: TObject);
    procedure mnuSchedulazionePopup(Sender: TObject);
    procedure Eliminaschedulazione1Click(Sender: TObject);
    procedure Copiaschedulazione1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  B010FSchedulazione: TB010FSchedulazione;

implementation

uses B010UMessaggiOrologiDTM1, B014UCopiaSchedulazione;

{$R *.DFM}

procedure TB010FSchedulazione.FormCreate(Sender: TObject);
begin
  inherited;
  DButton.DataSet:=B010FMessaggiOrologiDTM1.selT290;
end;

procedure TB010FSchedulazione.dGrdSchedulazioneEditButtonClick(
  Sender: TObject);
var Browse:Boolean;
begin
// Creazione check list delle parametrizzazioni
  C013FCheckList:=TC013FCheckList.Create(nil);
  with B010FMessaggiOrologiDTM1.selT291 do
  begin
    if not Active then
    begin
      Session:=B010FMessaggiOrologiDTM1.SessioneIWB010.SessioneOracle;
      Open;
    end;
    Refresh;
    First;
    while not Eof do
    begin
      C013FCheckList.clbListaDati.Items.Add(Format('%-*s ',[5,FieldByName('CODICE').AsString]) + FieldByName('DESCRIZIONE').AsString);
      Next;
    end;
    Close;
    Session:=B010FMessaggiOrologiDTM1.SessioneOracleB010;
  end;
  Browse:=B010FMessaggiOrologiDTM1.selt290.State = dsBrowse;
  if B010FMessaggiOrologiDTM1.selt290.State in [dsEdit,dsInsert] then
    B010FMessaggiOrologiDTM1.selt290.Post;
  R180PutCheckList(dGrdSchedulazione.SelectedField.AsString,5,C013FCheckList.clbListaDati);
  if C013FCheckList.ShowModal = mrOK then
  begin
    B010FMessaggiOrologiDTM1.selt290.Edit;
    dGrdSchedulazione.SelectedField.AsString:=R180GetCheckList(5,C013FCheckList.clbListaDati);
    if Browse then
      B010FMessaggiOrologiDTM1.selt290.Post;
  end
  else if not Browse then
    B010FMessaggiOrologiDTM1.selt290.Edit;
  FreeAndNil(C013FCheckList);
end;

procedure TB010FSchedulazione.mnuSchedulazionePopup(Sender: TObject);
begin
  Copiaschedulazione1.Visible:=(B010FMessaggiOrologiDTM1.selT290.RecordCount > 0) and
                               (B010FMessaggiOrologiDTM1.selT290.State = dsBrowse) and
                               (not B010FMessaggiOrologiDTM1.selT290.FieldByName('DATAHH').IsNull) and
                               (not B010FMessaggiOrologiDTM1.selT290.FieldByName('PARAMETRIZZAZIONE').IsNull);
  Eliminaschedulazione1.Visible:=(B010FMessaggiOrologiDTM1.selT290.RecordCount > 0) and
                                 (B010FMessaggiOrologiDTM1.selT290.State = dsBrowse);
end;

procedure TB010FSchedulazione.Eliminaschedulazione1Click(Sender: TObject);
{Eliminazione delle schedulazioni esistenti}
begin
  if MessageDlg('Attenzione!' + #13 + 'Verranno eliminate tutte le schedulazioni esistenti' + #13 + 'Confermare?',mtConfirmation,[mbYes,mbNo],0) = mrYes then
  with B010FMessaggiOrologiDTM1.selT290 do
  try
    DisableControls;
    First;
    while not Eof do
    begin
      Delete;
    end;
  finally
    EnableControls;
    B010FMessaggiOrologiDTM1.selT290.Session.Commit;
  end;
end;

procedure TB010FSchedulazione.Copiaschedulazione1Click(Sender: TObject);
{copia delle schedulazione a intervalli fissi}
var Partenza,Intervallo,Termine:Integer;
    HH,MM,GG,G,S:String;
begin
  B014FCopiaSchedulazione:=TB014FCopiaSchedulazione.Create(nil);
  with B014FCopiaSchedulazione do
  try
    if ShowModal = mrOK then
    begin
      S:=B010FMessaggiOrologiDTM1.selT290.FieldByName('PARAMETRIZZAZIONE').AsString;
      HH:=B010FMessaggiOrologiDTM1.selT290.FieldByName('DATAYY').AsString;
      MM:=B010FMessaggiOrologiDTM1.selT290.FieldByName('DATAMM').AsString;
      GG:=B010FMessaggiOrologiDTM1.selT290.FieldByName('DATADD').AsString;
      G:=B010FMessaggiOrologiDTM1.selT290.FieldByName('GIORNO').AsString;
      Partenza:=R180OreMinutiExt(B010FMessaggiOrologiDTM1.selT290.FieldByName('DATAHH').AsString);
      Intervallo:=StrToInt(edtIntervallo.Text);
      Termine:=R180OreMinutiExt(edtTermine.Text);
      if (Intervallo < 1) or (Termine < 1) or (Termine >= 1440) then
        raise Exception.Create('Dati errati!');
      inc(Partenza,Intervallo);
      while Partenza <= Termine do
      begin
        B010FMessaggiOrologiDTM1.selT290.Append;
        B010FMessaggiOrologiDTM1.selT290.FieldByName('DATAHH').AsString:=R180MinutiOre(Partenza);
        B010FMessaggiOrologiDTM1.selT290.FieldByName('PARAMETRIZZAZIONE').AsString:=S;
        B010FMessaggiOrologiDTM1.selT290.FieldByName('DATAYY').AsString:=HH;
        B010FMessaggiOrologiDTM1.selT290.FieldByName('DATAMM').AsString:=MM;
        B010FMessaggiOrologiDTM1.selT290.FieldByName('DATADD').AsString:=GG;
        B010FMessaggiOrologiDTM1.selT290.FieldByName('GIORNO').AsString:=G;
        B010FMessaggiOrologiDTM1.selT290.Post;
        inc(Partenza,Intervallo);
      end;
      B010FMessaggiOrologiDTM1.selT290.Session.Commit;
    end;
  finally
    Free;
  end;
end;

end.
