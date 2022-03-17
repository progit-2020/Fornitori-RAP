unit A153UPartecipEventiStraord;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs,
  A000USessione, A000UInterfaccia, A000UCostanti,
  C013UCheckList, C015UElencoValori, C180FunzioniGenerali, C700USelezioneAnagrafe,
  R001UGESTTAB, SelAnagrafe,
  ActnList, ImgList, DB, Menus, ComCtrls, ToolWin, Grids, DBGrids, checklst,
  System.Actions, System.ImageList;

type
  TA153FPartecipEventiStraord = class(TR001FGestTab)
    frmSelAnagrafe: TfrmSelAnagrafe;
    dgrdPartEvStr: TDBGrid;
    procedure FormShow(Sender: TObject);
    procedure dgrdPartEvStrEditButtonClick(Sender: TObject);
  private
    { Private declarations }
    procedure CambiaProgressivo;
  public
    { Public declarations }
  end;

var
  A153FPartecipEventiStraord: TA153FPartecipEventiStraord;

procedure OpenA153PartecipEventiStraord(Prog:LongInt; Causale:String);

implementation

uses A153UPartecipEventiStraordDtM;

{$R *.dfm}

procedure OpenA153PartecipEventiStraord(Prog:LongInt; Causale:String);
begin
  if Prog <= 0 then
  begin
    R180MessageBox('Nessun dipendente selezionato!',INFORMA);
    exit;
  end;
  SolaLetturaOriginale:=SolaLettura;
  SolaLettura:=False;
  case A000GetInibizioni('Funzione','OpenA153PartecipEventiStraord') of
    'N':begin
          R180MessageBox('Funzione non abilitata!',INFORMA);
          Exit;
        end;
    'R':SolaLettura:=True;
  end;
  A153FPartecipEventiStraord:=TA153FPartecipEventiStraord.Create(nil);
  with A153FPartecipEventiStraord do
  try
    C700Progressivo:=Prog;
    A153FPartecipEventiStraordDtM:=TA153FPartecipEventiStraordDtM.Create(nil);
    ShowModal;
  finally
    SolaLettura:=SolaLetturaOriginale;
    A153FPartecipEventiStraordDtM.Free;
    Free;
  end;
end;

procedure TA153FPartecipEventiStraord.dgrdPartEvStrEditButtonClick(Sender: TObject);
var vCodice: Variant;
    FID,LungCodice:Integer;
  procedure CaricaListaServizi(clb:TCheckListBox);
  begin
    with A153FPartecipEventiStraordDtM.selServizi do
    begin
      LungCodice:=FieldByName('CODICE').Size;
      First;
      while not Eof do
      begin
        clb.Items.Add(Format('%-*s %s',[LungCodice,FieldByName('Codice').AsString,FieldByName('Descrizione').AsString]));
        Next;
      end;
    end;
  end;
begin
  inherited;
  if not (DButton.State in [dsEdit,dsInsert]) then
    exit;
  if (dgrdPartEvStr.SelectedField.FieldName = 'D_CODICE') or (dgrdPartEvStr.SelectedField.FieldName = 'D_DESCRIZIONE') then
  begin
    vCodice:=VarArrayOf([A153FPartecipEventiStraordDtM.selT724.FieldByName('ID').Value]);
    OpenC015FElencoValori('T722_PERIODI_EVENTI_STR',
                          '<A153> Selezione dell''evento straordinario',
                          A153FPartecipEventiStraordDtM.selT722.SQL.Text,
                          'ID',vCodice,A153FPartecipEventiStraordDtM.selT722);
    if (not VarIsClear(vCodice)) and (vCodice[0] <> null) then
    begin
      FID:=vCodice[0];
      with A153FPartecipEventiStraordDtM do
      begin
        selT724.FieldByName('ID').AsInteger:=FID;
        if FID <> StrToIntDef(VarToStr(selT724.FieldByName('ID').OldValue),-1) then
        begin
          selT724.FieldByName('DAL').AsDateTime:=selT722.Lookup('ID',FID,'DECORRENZA');
          selT724.FieldByName('AL').AsDateTime:=selT722.Lookup('ID',FID,'DECORRENZA_FINE');
        end;
      end;
    end;
  end;
  if dgrdPartEvStr.SelectedField.FieldName = 'SERVIZI' then
    with A153FPartecipEventiStraordDtM do
    begin
      if A000LookupTabella(TORINO_COMUNE_STRUTT_EVENTI_STR,selServizi) then
        with TC013FCheckList.Create(nil) do
        try
          ApriSelServizi;
          CaricaListaServizi(clbListaDati);
          R180PutCheckList(selT724.FieldByName('SERVIZI').AsString,LungCodice,clbListaDati);
          if ShowModal = mrOK then
            selT724.FieldByName('SERVIZI').AsString:=R180GetCheckList(LungCodice,clbListaDati);
        finally
          Release;
        end;
    end;
end;

procedure TA153FPartecipEventiStraord.FormShow(Sender: TObject);
begin
  inherited;
  DButton.DataSet:=A153FPartecipEventiStraordDtM.selT724;
  C700DatiVisualizzati:='MATRICOLA,T430BADGE,COGNOME,NOME';
  C700DatiSelezionati:=C700CampiBase;
  C700DataLavoro:=Parametri.DataLavoro;
  frmSelAnagrafe.OnCambiaProgressivo:=CambiaProgressivo;
  frmSelAnagrafe.CreaSelAnagrafe(SessioneOracle,StatusBar,2,True);
  frmSelAnagrafe.NumRecords;
end;

procedure TA153FPartecipEventiStraord.CambiaProgressivo;
begin
  with A153FPartecipEventiStraordDtM.selT724 do
  begin
    Close;
    SetVariable('PROGRESSIVO',C700Progressivo);
    Open;
  end;
end;

end.
