unit A005UDatiLiberi;

interface

uses
  Windows,
  Messages,
  SysUtils,
  Classes,
  Graphics,
  Controls,
  Forms,
  Dialogs,
  Db,
  Menus,
  StdCtrls,
  Mask,
  DBCtrls,
  Buttons,
  ExtCtrls,
  ComCtrls,
  ImgList,
  ToolWin,
  ActnList,
  OracleData,
  Grids,
  DBGrids,
  Variants,
  System.Actions,
  Oracle,
  System.ImageList,
  System.StrUtils,
  R004UGestStorico,
  R004UGestStoricoDtM,
  A000UCostanti,
  A000USessione,
  A000UInterfaccia,
  A000UMessaggi,
  C180FunzioniGenerali;

type
  TRecordDatoLibero = record
    NomeTabelle:String;
    NomeCampo:String;
    Accesso:String;
    Scadenza:String;
    Storico:Boolean;
  end;

  TA115FDatiLiberiStoricizzati = class(TR004FGestStorico)
    pnlContenuto: TPanel;
    dgrdDati: TDBGrid;
    pnlPrincipale: TPanel;
    lblCodice: TLabel;
    lblDescrizione: TLabel;
    dedtCodice: TDBEdit;
    dedtDescrizione: TDBEdit;
    Panel1: TPanel;
    lblSelDato: TLabel;
    cmbSelDato: TComboBox;
    procedure FormShow(Sender: TObject);
    procedure Stampa1Click(Sender: TObject);
    procedure TGommaClick(Sender: TObject);
    procedure TRegisClick(Sender: TObject);
    procedure TAnnullaClick(Sender: TObject);
    procedure TCancClick(Sender: TObject);
    procedure TModifClick(Sender: TObject);
    procedure TInserClick(Sender: TObject);
    procedure btnStoricoSuccClick(Sender: TObject);
    procedure btnStoricoPrecClick(Sender: TObject);
    procedure actRefreshExecute(Sender: TObject);
    procedure TPrimoClick(Sender: TObject);
    procedure TCercaClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnStoricizzaClick(Sender: TObject);
    procedure dgrdDatiKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure cmbSelDatoSelect(Sender: TObject);
    procedure DButtonStateChange(Sender: TObject);
  private
    { Private declarations }
    sSolaLetturaForm: boolean;
  protected
    { Protected declarations }
  public
    { Public declarations }
    TabelleDati:array of TRecordDatoLibero;
    NCNuovoElemento,CodNuovoElemento: String;
    bStoricizza, chiudi: boolean;
  end;

var
  A115FDatiLiberiStoricizzati: TA115FDatiLiberiStoricizzati;

procedure OpenA005DatiLiberi(NomeCampo,Cod:String);

implementation

uses A005UDatiLiberiDM;

{$R *.DFM}

procedure OpenA005DatiLiberi(NomeCampo,Cod:String);
begin
  SolaLetturaOriginale:=SolaLettura;
  SolaLettura:=False;
  case A000GetInibizioni('Funzione','OpenA005DatiLiberi') of
    'N':begin
        ShowMessage('Funzione non abilitata!');
        SolaLettura:=SolaLetturaOriginale;
        Exit;
        end;
    'R':SolaLettura:=True;
  end;
  Screen.Cursor:=crHourglass;
  Application.CreateForm(TA115FDatiLiberiStoricizzati,A115FDatiLiberiStoricizzati);
  Application.CreateForm(TA115FDatiLiberiStoricizzatiDtM,A115FDatiLiberiStoricizzatiDtM);
  A115FDatiLiberiStoricizzati.NCNuovoElemento:=NomeCampo;
  A115FDatiLiberiStoricizzati.CodNuovoElemento:=Cod;
  A115FDatiLiberiStoricizzati.sSolaLetturaForm:=SolaLettura;
  try
    Screen.Cursor:=crDefault;
    A115FDatiLiberiStoricizzati.ShowModal;
  finally
    SolaLettura:=SolaLetturaOriginale;
    A115FDatiLiberiStoricizzati.Free;
    A115FDatiLiberiStoricizzatiDtM.Free;
  end;
end;

procedure TA115FDatiLiberiStoricizzati.FormShow(Sender: TObject);
var i: Integer;
begin
  A115FDatiLiberiStoricizzatiDtM.bVariazioneDati:=False;
  SetLength(TabelleDati,0);
  cmbSelDato.ItemIndex:=-1;
  with A115FDatiLiberiStoricizzatiDtM do
  begin

    selI500.Close;
    selI500.SetVariable('Nome',Parametri.Layout);
    selI500.Open;
    i:=0;
    while not selI500.Eof do
    begin
      SetLength(TabelleDati,i + 1);
      TabelleDati[i].NomeTabelle:='I501' + selI500.FieldByName('NOMECAMPO').AsString;
      TabelleDati[i].NomeCampo:=selI500.FieldByName('NOMECAMPO').AsString;
      TabelleDati[i].Accesso:=selI500.FieldByName('ACCESSO').AsString;
      TabelleDati[i].Storico:=selI500.FieldByName('STORICO').AsString = 'S';
      // gestione scadenza
      TabelleDati[i].Scadenza:=selI500.FieldByName('SCADENZA').AsString;
      cmbSelDato.Items.add(selI500.FieldByName('CAPTION').AsString);
      if selI500.FieldByName('NOMECAMPO').AsString = NCNuovoElemento then
        cmbSelDato.ItemIndex:=i;
      i:=i + 1;
      selI500.Next;
    end;

    if cmbSelDato.Items.Count > 0 then
    begin
      if cmbSelDato.ItemIndex = -1 then
        cmbSelDato.ItemIndex:=0;
      cmbSelDatoSelect(nil)
    end;
  end;
  chiudi:=i = 0;
  if chiudi then
    R180MessageBox(A000MSG_A005_ERR_NO_DATI, ERRORE);
  bStoricizza:=False;
  inherited;
end;

procedure TA115FDatiLiberiStoricizzati.cmbSelDatoSelect(Sender: TObject);
var
  i: integer;
  VC,IsStorico:Boolean;
begin
  with A115FDatiLiberiStoricizzatiDtM do
  begin
    VC:=False;
    IsStorico:=TabelleDati[cmbSelDato.ItemIndex].Storico;
    if IsStorico then
    begin
      VC:=actVisioneCorrente.Checked;
      if VC then
        actVisioneCorrente.Checked:=False;
    end;

    selI501.Close;
    selI501.SQL.Clear;
    selI501.SQL.Add('SELECT I501.*,I501.ROWID FROM ' + TabelleDati[cmbSelDato.ItemIndex].NomeTabelle + ' I501');
    selI501.SQL.Add('WHERE CODICE <> ''*''');
    selI501.SQL.Add('ORDER BY CODICE ' + IfThen(IsStorico,',DECORRENZA'));
    selI501.ReadBuffer:=1000;
    InterfacciaR004.AliasNomeTabella:='<I501>';
    if IsStorico then
      // gestione scadenza
      InterfacciaR004.AllineaSoloDecorrenzeIntersecanti:=TabelleDati[cmbSelDato.ItemIndex].Scadenza = 'S';

    InizializzaDButton;
    SolaLettura:=TabelleDati[cmbSelDato.ItemIndex].Accesso = 'R';
    //Se tutta la funzione è in sola lettura impongo questa condizione indipendentemente dal tipo dato
    if (sSolaLetturaForm) or (InterfacciaR004.LChiavePrimaria.Count = 0) then
      SolaLettura:=True;
    selI501.ReadOnly:=SolaLettura;

    if selI501.VariableIndex('DECORRENZA') >= 0 then
      selI501.DeleteVariable('DECORRENZA');

    selI501.Open;
    if not IsStorico then
    begin
      for i:=0 to selI501.Fields.Count - 1 do
      begin
        selI501.Fields[i].Visible:=R180In(selI501.Fields[i].FieldName,['CODICE','DESCRIZIONE']);
        if TabelleDati[cmbSelDato.ItemIndex].NomeTabelle.ToUpper = 'I501' + Parametri.CampiRiferimento.C29_ChiamateRepFiltro1.ToUpper then
          selI501.Fields[i].Visible:=selI501.Fields[i].Visible or R180In(selI501.Fields[i].FieldName,['TELEFONO','EMAIL']);
      end;
    end;

    if IsStorico and VC then
      Visionecorrente1Click(nil);

    selI501.SearchRecord('CODICE',CodNuovoElemento,[srFromBeginning]);

    if IsStorico then
      CercaStoricoCorrente;
  end;
  NumRecords;
  for i:= 0 to dgrdDati.Columns.Count - 1 do
    if dgrdDati.Columns[i].Width > 300 then
      dgrdDati.Columns[i].Width:=300;
end;

procedure TA115FDatiLiberiStoricizzati.FormClose(Sender: TObject;
  var Action: TCloseAction);
//Esecuzione dell'allineamento dei periodi storici in uscita
begin
  //Se si è verificata almeno una variazione di dati
  with A115FDatiLiberiStoricizzatiDtM do
  begin
    if bVariazioneDati then
    begin
      SetPanelMessage('Attendere: aggiornamento di ' + IntToStr(tabT430.RecordCount) + ' dip. in corso');
      A115FDatiLiberiStoricizzati.Repaint;
      Screen.Cursor:=crHourglass;
      //Eseguo procedura di allineamento periodi storici per tutti i progressivi variati
      tabT430.First;
      while not tabT430.Eof do
      begin
        scrT430.SetVariable('Progressivo',tabT430.FieldByName('PROGRESSIVO').Value);
        scrT430.Execute;
        tabT430.Next;
      end;
      Screen.Cursor:=crDefault;
    end;
  end;
end;

procedure TA115FDatiLiberiStoricizzati.btnStoricizzaClick(Sender: TObject);
begin
  if chiudi then
  begin
    R180MessageBox(A000MSG_A005_ERR_NO_DATI, ERRORE);
    Self.Close;
  end
  else
  begin
    bStoricizza:=True;
    try
      TDateTimeField(DButton.DataSet.FieldByName('DECORRENZA')).DisplayFormat:='dd/mm/yyyy';
      DButton.DataSet.FieldByName('DECORRENZA').EditMask:='!00/00/0000;1;_';
      DButton.DataSet.FieldByName('DECORRENZA_FINE').EditMask:='!00/00/0000;1;_'; // gestione scadenza
    except
    end;
    inherited;
  end;
end;

procedure TA115FDatiLiberiStoricizzati.TCercaClick(Sender: TObject);
begin
  if chiudi then
  begin
    R180MessageBox(A000MSG_A005_ERR_NO_DATI, ERRORE);
    Self.Close;
  end
  else
    inherited;
end;

procedure TA115FDatiLiberiStoricizzati.TPrimoClick(Sender: TObject);
begin
  if chiudi then
  begin
    R180MessageBox(A000MSG_A005_ERR_NO_DATI, ERRORE);
    Self.Close;
  end
  else
    inherited;
end;

procedure TA115FDatiLiberiStoricizzati.actRefreshExecute(Sender: TObject);
begin
  if chiudi then
  begin
    R180MessageBox(A000MSG_A005_ERR_NO_DATI, ERRORE);
    Self.Close;
  end
  else
    inherited;
end;

procedure TA115FDatiLiberiStoricizzati.btnStoricoPrecClick(Sender: TObject);
begin
  if chiudi then
  begin
    R180MessageBox(A000MSG_A005_ERR_NO_DATI, ERRORE);
    Self.Close;
  end
  else
    inherited;
end;

procedure TA115FDatiLiberiStoricizzati.btnStoricoSuccClick(Sender: TObject);
begin
  if chiudi then
  begin
    R180MessageBox(A000MSG_A005_ERR_NO_DATI, ERRORE);
    Self.Close;
  end
  else
    inherited;
end;

procedure TA115FDatiLiberiStoricizzati.dgrdDatiKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;
  if (Shift = [ssCtrl]) and (Key = 46) and
     (not SolaLettura) and (actCancella.Visible) and (actCancella.Enabled) and
     (not dgrdDati.ReadOnly) and (DButton.State = dsBrowse) and
     (DButton.DataSet is TOracleDataSet) and (not (DButton.DataSet as TOracleDataSet).ReadOnly)
  then
  begin
    Key:=0;
    actCancella.Execute;
  end;
end;

procedure TA115FDatiLiberiStoricizzati.TInserClick(Sender: TObject);
begin
  if chiudi then
  begin
    R180MessageBox(A000MSG_A005_ERR_NO_DATI, ERRORE);
    Self.Close;
  end
  else
    inherited;
end;

procedure TA115FDatiLiberiStoricizzati.TModifClick(Sender: TObject);
begin
  if chiudi then
  begin
    R180MessageBox(A000MSG_A005_ERR_NO_DATI, ERRORE);
    Self.Close;
  end
  else
    inherited;
end;

procedure TA115FDatiLiberiStoricizzati.TCancClick(Sender: TObject);
begin
  if chiudi then
  begin
    R180MessageBox(A000MSG_A005_ERR_NO_DATI, ERRORE);
    Self.Close;
  end
  else
    inherited;
end;

procedure TA115FDatiLiberiStoricizzati.TAnnullaClick(Sender: TObject);
begin
  if chiudi then
  begin
    R180MessageBox(A000MSG_A005_ERR_NO_DATI, ERRORE);
    Self.Close;
  end
  else
    inherited;
end;

procedure TA115FDatiLiberiStoricizzati.TRegisClick(Sender: TObject);
begin
  if chiudi then
  begin
    R180MessageBox(A000MSG_A005_ERR_NO_DATI, ERRORE);
    Self.Close;
  end
  else
  begin
    inherited;
  end;
end;

procedure TA115FDatiLiberiStoricizzati.TGommaClick(Sender: TObject);
begin
  if chiudi then
  begin
    R180MessageBox(A000MSG_A005_ERR_NO_DATI, ERRORE);
    Self.Close;
  end
  else
    inherited;
end;

procedure TA115FDatiLiberiStoricizzati.Stampa1Click(Sender: TObject);
begin
  if chiudi then
  begin
    R180MessageBox(A000MSG_A005_ERR_NO_DATI, ERRORE);
    Self.Close;
  end
  else
    inherited;
end;

procedure TA115FDatiLiberiStoricizzati.DButtonStateChange(Sender: TObject);
var
  IsStorico: Boolean;
begin
  inherited;
  cmbSelDato.Enabled:=not (DButton.State in [dsEdit,dsInsert]);
  lblSelDato.Enabled:=not (DButton.State in [dsEdit,dsInsert]);
  IsStorico:=TabelleDati[cmbSelDato.ItemIndex].Storico;
  dedtDecorrenza.DataField:=IfThen(IsStorico, 'DECORRENZA', '');
  dedtDecorrenza.Enabled:=IsStorico;
  lblDecorrenza.Enabled:=IsStorico;
  if not IsStorico then
  begin
    actStoricizza.Enabled:=False;
    actStoricoPrecedente.Enabled:=False;
    actStoricoSuccessivo.Enabled:=False;
    cmbDateDecorrenza.Enabled:=False;
    cmbDateDecorrenza.Items.Clear;
    chkStoriciPrec.Enabled:=False;
    chkStoriciSucc.Enabled:=False;
    actVisioneCorrente.Enabled:=False;
    actDataLavoro.Enabled:=False;
  end;
  dedtDecorrenzaChange(nil);
end;

end.
