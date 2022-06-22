unit Bc06UConfigMonitorB006;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, R001UGESTTAB, System.Actions,
  Vcl.ActnList, System.ImageList, Vcl.ImgList, Data.DB, Vcl.Menus, Vcl.ComCtrls,
  Vcl.ToolWin, Bc06UMonitorB006DtM, Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.Mask,
  Vcl.DBCtrls, Vcl.Grids, Vcl.DBGrids, ToolbarFiglio, A000USessione, C180FunzioniGenerali,
  C012UVisualizzaTesto, Oracle, OracleData, Bc06UClassi;

type
  TBc06FConfigMonitorB006 = class(TR001FGestTab)
    pnlTabPadre: TPanel;
    frmToolbarFiglio: TfrmToolbarFiglio;
    Panel2: TPanel;
    dgrdImpostazioni: TDBGrid;
    DBGrid1: TDBGrid;
    Splitter1: TSplitter;
    procedure FormShow(Sender: TObject);
    procedure DButtonStateChange(Sender: TObject);
    procedure dgrdImpostazioniEditButtonClick(Sender: TObject);
    procedure frmToolbarFiglioactTFCopiaSuExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure TRegisClick(Sender: TObject);
    procedure frmToolbarFiglioactTFConfermaExecute(Sender: TObject);
    procedure TCancClick(Sender: TObject);
    procedure frmToolbarFigliobtnTFCancellaClick(Sender: TObject);
    procedure DBGrid1EditButtonClick(Sender: TObject);
  private
    C012StringList:TStringList; // Usata per modifica query
  public
    Modificato:Boolean;
    procedure AbilitaComponenti;
  end;

var
  Bc06FConfigMonitorB006: TBc06FConfigMonitorB006;

implementation

{$R *.dfm}

procedure TBc06FConfigMonitorB006.FormCreate(Sender: TObject);
begin
  inherited;
  Modificato:=False;
  DButton.DataSet:=Bc06FMonitorB006DtM.Bc06FExecMonitorB006DtM.selI190;
end;

procedure TBc06FConfigMonitorB006.FormShow(Sender: TObject);
begin
  inherited;
  frmToolbarFiglio.TFDButton:=Bc06FMonitorB006DtM.dsrI191;
  frmToolbarFiglio.RefreshDopoPost:=True;
  frmToolbarFiglio.TFDBGrid:=dgrdImpostazioni;
  Bc06FMonitorB006DtM.dsrI191.OnStateChange:=frmToolbarFiglio.DButtonStateChange;
  SetLength(frmToolbarFiglio.lstLock,3);
  frmToolbarFiglio.lstLock[0]:=Panel1;
  frmToolbarFiglio.lstLock[1]:=File1;
  frmToolbarFiglio.lstLock[2]:=Strumenti1;
  frmToolbarFiglio.AbilitaAzioniTF(nil);

  // Lista delle connessioni DB disponibili
  dgrdImpostazioni.Columns.Items[0].PickList.Assign(Oracle.OracleAliasList);

  C012StringList:=nil;

  DBGrid1.Columns[7].PickList.Assign(Bc06FMonitorB006DtM.Bc06FExecMonitorB006DtM.ListaEmailAuthType);
end;

procedure TBc06FConfigMonitorB006.DBGrid1EditButtonClick(Sender: TObject);
var
  OldPwd,NuovaPwd:String;
begin
  if DBGrid1.SelectedField.FieldName = 'D_EMAIL_SMTP_PASSWORD' then
  begin
    OldPwd:=Bc06FMonitorB006DtM.Bc06FExecMonitorB006DtM.selI190.FieldByName('D_EMAIL_SMTP_PASSWORD').AsString;
    NuovaPwd:=InputBox('Cambia password','Nuova password:',OldPwd);
    if NuovaPwd <> OldPwd then
      Bc06FMonitorB006DtM.Bc06FExecMonitorB006DtM.selI190.FieldByName('EMAIL_SMTP_PASSWORD').AsString:=R180Cripta(NuovaPwd,SALT_CRIPTA);
  end;
end;

procedure TBc06FConfigMonitorB006.DButtonStateChange(Sender: TObject);
begin
  inherited;
  AbilitaComponenti;
end;

procedure TBc06FConfigMonitorB006.dgrdImpostazioniEditButtonClick(Sender: TObject);
var
  CampoSelezionato:String;
  OldPwd,NuovaPwd:String;
begin
    CampoSelezionato:=dgrdImpostazioni.SelectedField.FieldName;
    // La colonna Password è nascosta
    if CampoSelezionato = 'D_CONNESSIONE_PWD' then
    begin
      if False and (not SolaLettura) and (Bc06FMonitorB006DtM.Bc06FExecMonitorB006DtM.selI191.State in [dsEdit,dsInsert]) then
      begin
        OldPwd:=Bc06FMonitorB006DtM.Bc06FExecMonitorB006DtM.selI191.FieldByName('D_CONNESSIONE_PWD_DECRYPT').AsString;
        NuovaPwd:=InputBox('Cambia password','Nuova password:',OldPwd);
        if (NuovaPwd <> '') and (NuovaPwd <> OldPwd) then
        begin
          NuovaPwd:=R180Cripta(NuovaPwd,SALT_CRIPTA);
          Bc06FMonitorB006DtM.Bc06FExecMonitorB006DtM.selI191.FieldByName('CONNESSIONE_PWD').AsString:=NuovaPwd;
        end;
      end;
    end
    else if R180In(CampoSelezionato,['QUERY_SERVIZIO_CONNESSO','QUERY_MSG1','QUERY_MSG2']) then
    begin
      C012StringList:=TStringList.Create;
      try
        C012StringList.Text:=Bc06FMonitorB006DtM.Bc06FExecMonitorB006DtM.selI191.FieldByName(CampoSelezionato).AsString;
        if (not SolaLettura) and (Bc06FMonitorB006DtM.Bc06FExecMonitorB006DtM.selI191.State in [dsEdit,dsInsert]) then
        begin
          OpenC012VisualizzaTesto('Modifica query','',C012StringList,'',[mbOK,mbCancel]);
          if Trim(C012StringList.Text) <> Trim(Bc06FMonitorB006DtM.Bc06FExecMonitorB006DtM.selI191.FieldByName(CampoSelezionato).AsString) then
            Bc06FMonitorB006DtM.Bc06FExecMonitorB006DtM.selI191.FieldByName(CampoSelezionato).AsString:=Trim(C012StringList.Text);
        end
        else
        begin
          OpenC012VisualizzaTesto('Modifica query','',C012StringList,'',[mbCancel]);
        end;
      finally
        FreeAndNil(C012StringList);
      end;
    end;
end;

procedure TBc06FConfigMonitorB006.frmToolbarFiglioactTFConfermaExecute(
  Sender: TObject);
begin
  inherited;
  frmToolbarFiglio.actTFConfermaExecute(Sender);
  Modificato:=True;
end;

procedure TBc06FConfigMonitorB006.frmToolbarFiglioactTFCopiaSuExecute(
  Sender: TObject);
var
  GridDS:TOracleDataSet;
  DatiOrig:array of Variant;
  i:Integer;
begin
  GridDS:=dgrdImpostazioni.DataSource.DataSet as TOracleDataSet; // selI191
  if (GridDS = nil) or (GridDS.State <> dsBrowse) or (GridDS.RecordCount = 0) then
    Exit;
  // Salvo i valori attuali
  SetLength(DatiOrig,GridDS.Fields.Count); // GridDS.Fields.Count >= num GridDS.Fields di tipo fkData
  for i:=0 to GridDS.Fields.Count - 1 do
  begin
    if GridDS.Fields[i].FieldKind = fkData then
      DatiOrig[i]:=GridDS.Fields[i].Value
    else
      DatiOrig[i]:=''; // Non lo uso comunque
  end;
  // Creo il nuovo record
  frmToolbarFiglio.actTFInserisciExecute(frmToolbarFiglio.actTFInserisci);
  // Valorizzo i nuovi campi
  for i:=0 to GridDS.Fields.Count - 1 do
  begin
    if GridDS.Fields[i].FieldKind = fkData then
      GridDS.Fields[i].Value:=DatiOrig[i];
  end;
end;

procedure TBc06FConfigMonitorB006.frmToolbarFigliobtnTFCancellaClick(
  Sender: TObject);
begin
  inherited;
  frmToolbarFiglio.actTFCancellaExecute(Sender);
  Modificato:=True;
end;

procedure TBc06FConfigMonitorB006.TCancClick(Sender: TObject);
begin
  if Bc06FMonitorB006DtM.Bc06FExecMonitorB006DtM.selI190.RecordCount < 2 then
    Abort;
  inherited;
  Modificato:=True;
end;

procedure TBc06FConfigMonitorB006.TRegisClick(Sender: TObject);
begin
  inherited;
  Modificato:=True;
end;

procedure TBc06FConfigMonitorB006.AbilitaComponenti;
var
  Abilita:Boolean;
  CurrOpt:TDBGridOptions;
begin
  Abilita:=(DButton.DataSet.State = dsBrowse) and (DButton.DataSet.RecordCount > 0) and (not SolaLettura);
  frmToolbarFiglio.Enabled:=Abilita;

  CurrOpt:=dgrdImpostazioni.Options;
  if Abilita then
    Include(CurrOpt,dgEditing)
  else
    Exclude(CurrOpt,dgEditing);
  dgrdImpostazioni.Options:=CurrOpt;

  if frmToolbarFiglio.TFDButton <> nil then
    frmToolbarFiglio.TFDButton.AutoEdit:=Abilita;
  frmToolbarFiglio.actTFCopiaSu.Enabled:=Abilita;
  frmToolbarFiglio.actTFInserisci.Enabled:=Abilita;
  frmToolbarFiglio.actTFModifica.Enabled:=Abilita;
  frmToolbarFiglio.actTFCancella.Enabled:=Abilita;
end;

end.
