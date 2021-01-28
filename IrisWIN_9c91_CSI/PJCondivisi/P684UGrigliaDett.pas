unit P684UGrigliaDett;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, R001UGESTTAB, ActnList, ImgList, DB, Menus, ComCtrls, ToolWin, Grids,
  DBGrids, StdCtrls, Buttons, ExtCtrls, Clipbrd, C180FunzioniGenerali, C016UElencoVoci,
  A003UDataLavoroBis, C015UElencoValori, A000UCostanti, A000USessione, A000UInterfaccia,
  Oracle, OracleData, System.Actions;

type
  TP684FGrigliaDett = class(TR001FGestTab)
    Panel2: TPanel;
    btnChiudi: TBitBtn;
    dgrdDettaglio: TDBGrid;
    PopupMenu1: TPopupMenu;
    Selezionatutto1: TMenuItem;
    Deselezionatutto1: TMenuItem;
    Invertiselezione1: TMenuItem;
    MenuItem1: TMenuItem;
    Copia2: TMenuItem;
    CopiaInExcel: TMenuItem;
    rgpTipoAccorp: TRadioGroup;
    lblAnno: TLabel;
    lblFondo: TLabel;
    lblCodTabella: TLabel;
    edtFondo: TEdit;
    edtDecorrenza: TEdit;
    edtVoceGen: TEdit;
    lblIntVoceGen: TLabel;
    edtVoceDet: TEdit;
    lblIntVoceDet: TLabel;
    lblVoceGen: TLabel;
    lblVoceDet: TLabel;
    Panel3: TPanel;
    procedure btnSelezionaTuttoClick(Sender: TObject);
    procedure Selezionatutto1Click(Sender: TObject);
    procedure Deselezionatutto1Click(Sender: TObject);
    procedure Invertiselezione1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure dgrdDettaglioEditButtonClick(Sender: TObject);
    procedure Copia2Click(Sender: TObject);
    procedure rgpTipoAccorpClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
    FondoElab,CodGenElab,CodDetElab:String;
    DataElab:TDateTime;
  public
    { Public declarations }
  end;

var
  P684FGrigliaDett: TP684FGrigliaDett;

  procedure OpenP684GrigliaDett(Fondo,CodGen,CodDett:String;Dec:TDateTime);

implementation

uses P684UDefinizioneFondiDtM;

{$R *.dfm}

procedure OpenP684GrigliaDett(Fondo,CodGen,CodDett:String;Dec:TDateTime);
begin
  Application.CreateForm(TP684FGrigliaDett,P684FGrigliaDett);
  with P684FGrigliaDett do
  try
    DataElab:=Dec;
    FondoElab:=Fondo;
    CodGenElab:=CodGen;
    CodDetElab:=CodDett;
    ShowModal;
  finally
    FreeAndNil(P684FGrigliaDett);
  end;
end;

procedure TP684FGrigliaDett.btnSelezionaTuttoClick(Sender: TObject);
begin
  inherited;
  R180DBGridSelezionaRighe(dgrdDettaglio,'S');
end;

procedure TP684FGrigliaDett.Copia2Click(Sender: TObject);
var S:String;
  i:Integer;
begin
  inherited;
  with dgrdDettaglio.DataSource.DataSet do
  begin
    if not Active then
      exit;
    S:='';
    Clipboard.Clear;
    DisableControls;
    Screen.Cursor:=crHourGlass;
    First;
    try
      if not EOF then
      begin
        for i:=0 to FieldCount - 1 do
          if Fields[i].Visible then
            S:=S + Fields[i].DisplayLabel + #9;
        S:=S + #13#10;
      end;
      while not EOF do
      begin
        if dgrdDettaglio.SelectedRows.CurrentRowSelected then
        begin
          for i:=0 to FieldCount - 1 do
            if Fields[i].Visible then
              S:=S + Fields[i].AsString + #9;
          S:=S + #13#10;
        end;
        Next;
      end;
    finally
      First;
      EnableControls;
      Screen.Cursor:=crDefault;
    end;
  end;
  Clipboard.AsText:=S;
end;

procedure TP684FGrigliaDett.Deselezionatutto1Click(Sender: TObject);
begin
  inherited;
  R180DBGridSelezionaRighe(dgrdDettaglio,'N');
end;

procedure TP684FGrigliaDett.dgrdDettaglioEditButtonClick(Sender: TObject);
var vCodice:Variant;
begin
  inherited;
  with P684FDefinizioneFondiDtM do
  begin
    case dgrdDettaglio.SelectedIndex of
      0: //Richiesta data dal tramite calendario
      begin
        if selP690.FieldByName('DATA_RETRIBUZIONE').IsNull then
          selP690.FieldByName('DATA_RETRIBUZIONE').AsDateTime:=Parametri.DataLavoro;
        selP690.FieldByName('DATA_RETRIBUZIONE').AsDateTime:=R180FineMese(DataOut(R180InizioMese(selP690.FieldByName('DATA_RETRIBUZIONE').AsDateTime),'Mese Retribuzione','M'));
      end;
      1: //Cod.contratto
      begin
        OpenC015FElencoValori('P210_CONTRATTI','<P684> Selezione contratto',selP210.Sql.Text,'COD_CONTRATTO',vCodice,selP210);
        if not VarIsClear(vCodice) then
          selP690.FieldByName('COD_CONTRATTO').AsString:=VarToStr(vCodice[0]);
      end;
      2: //Selezione codice voce paghe da elenco
      begin
        C016FElencoVoci:=TC016FElencoVoci.Create(nil);
        C016FElencoVoci.DecorrenzaElencoVoci:=selP690.FieldByName('DECORRENZA_DA').AsDateTime;
        C016FElencoVoci.CodContrattoElencoVoci:=selP690.FieldByName('COD_CONTRATTO').AsString;
        C016FElencoVoci.CodVoceElencoVoci:=selP690.FieldByName('COD_VOCE').AsString;
        C016FElencoVoci.CodVoceSpecialeElencoVoci:='BASE';
        C016FElencoVoci.TestoFiltroSql:=' AND COD_VOCE_SPECIALE = ''BASE''';
        if C016FElencoVoci.ShowModal = mrOK then
          selP690.FieldByName('COD_VOCE').AsString:=C016FElencoVoci.CodVoceElencoVoci;
        C016FElencoVoci.Free;
      end;
    end;
  end;
end;

procedure TP684FGrigliaDett.FormClose(Sender: TObject;
  var Action: TCloseAction);
var Imp:Real;
begin
  inherited;
  if Trim(CodGenElab) = '' then
    Exit;
  with P684FDefinizioneFondiDtM do
  begin
    selP690A.Close;
    selP690A.SetVariable('COD',selP690.FieldByName('COD_FONDO').AsString);
    selP690A.SetVariable('DEC',selP690.FieldByName('DECORRENZA_DA').AsDateTime);
    selP690A.SetVariable('CODGEN','and P690.cod_voce_gen = ''' + selP688D.FieldByName('COD_VOCE_GEN').AsString + '''');
    selP690A.SetVariable('CODDET','and P690.cod_voce_det = ''' + selP688D.FieldByName('COD_VOCE_DET').AsString + '''');
    selP690A.SetVariable('DATI',''' ''');
    selP690A.Open;
    Imp:=0;
    if selP690A.RecordCount > 0 then  //Arrotondo la somma
    begin
      Imp:=selP690A.FieldByName('Importo').AsFloat;
      if selP688D.FieldByName('COD_ARROTONDAMENTO').AsString <> '' then
      begin
        if selP050.SearchRecord('Cod_Arrotondamento',selP688D.FieldByName('COD_ARROTONDAMENTO').AsString,[srFromBeginning]) and
          (Imp <> 0) then
          Imp:=R180Arrotonda(Imp,selP050.FieldByName('VALORE').AsFloat,selP050.FieldByName('TIPO').AsString);
      end;
    end;
    if R180AzzeraPrecisione(Imp - selP688D.FieldByName('IMPORTO').AsFloat,2) <> 0 then
    begin
      if R180MessageBox('La somma degli importi delle voci è diversa dall''importo totale speso sulla destinazione dettagliata: allineare quest''ultimo?','DOMANDA') = mrYes then
      begin
        selP688D.Edit;
        selP688D.FieldByName('IMPORTO').AsFloat:=Imp;
        selP688D.Post;
        SessioneOracle.Commit;
      end;
    end;
  end;
end;

procedure TP684FGrigliaDett.FormShow(Sender: TObject);
begin
  inherited;
  edtFondo.Text:=FondoElab;
  edtDecorrenza.Text:=DateToStr(DataElab);
  edtVoceGen.Text:=CodGenElab;
  edtVoceDet.Text:=CodDetElab;
  lblIntVoceGen.Visible:=Trim(CodGenElab) <> '';
  lblIntVoceDet.Visible:=Trim(CodDetElab) <> '';
  if Trim(CodGenElab) = '' then
  begin
    actModifica.OnExecute:=nil;
    actInserisci.OnExecute:=nil;
    actCancella.OnExecute:=nil;
  end;
  with P684FDefinizioneFondiDtM do
  begin
    lblFondo.Caption:=VarToStr(selP684.Lookup('DECORRENZA_DA;COD_FONDO',VarArrayOf([DataElab,FondoElab]),'DESCRIZIONE'));
    if Trim(CodGenElab) <> '' then
      lblVoceGen.Caption:=VarToStr(selP686.Lookup('DECORRENZA_DA;COD_FONDO;CLASS_VOCE;COD_VOCE_GEN',VarArrayOf([DataElab,FondoElab,'D',CodGenElab]),'DESCRIZIONE'))
    else
      lblVoceGen.Caption:='';
    if Trim(CodDetElab) <> '' then
      lblVoceDet.Caption:=VarToStr(selP688D.Lookup('DECORRENZA_DA;COD_FONDO;COD_VOCE_GEN;COD_VOCE_DET',VarArrayOf([DataElab,FondoElab,CodGenElab,CodDetElab]),'DESCRIZIONE'))
    else
      lblVoceDet.Caption:='';
    DButton.DataSet:=selP690;
    selP690.Close;
    selP690.SetVariable('COD',FondoElab);
    selP690.SetVariable('DEC',DataElab);
    if Trim(CodGenElab) <> '' then
      selP690.SetVariable('CODGEN','and P690.cod_voce_gen = ''' + CodGenElab + '''')
    else
      selP690.SetVariable('CODGEN','');
    if Trim(CodDetElab) <> '' then
      selP690.SetVariable('CODDET','and P690.cod_voce_det = ''' + CodDetElab + '''')
    else
      selP690.SetVariable('CODDET','');
    selP690.Open;
    selP210.Close;
    selP210.Open;
  end;
end;

procedure TP684FGrigliaDett.Invertiselezione1Click(Sender: TObject);
begin
  inherited;
  R180DBGridSelezionaRighe(dgrdDettaglio,'C');
end;

procedure TP684FGrigliaDett.rgpTipoAccorpClick(Sender: TObject);
begin
  inherited;
  Panel1.Enabled:=rgpTipoAccorp.ItemIndex = 0;
  Strumenti1.Enabled:=rgpTipoAccorp.ItemIndex = 0;
  actRicerca.Enabled:=rgpTipoAccorp.ItemIndex = 0;
  actStampa.Enabled:=rgpTipoAccorp.ItemIndex = 0;
  dgrdDettaglio.ReadOnly:=rgpTipoAccorp.ItemIndex <> 0;
  with P684FDefinizioneFondiDtM do
  begin
    if rgpTipoAccorp.ItemIndex = 0 then
    begin
      dgrdDettaglio.DataSource:=DButton;
      dgrdDettaglio.Columns[0].Visible:=True;
      dgrdDettaglio.Columns[1].Visible:=True;
      dgrdDettaglio.Columns[2].Visible:=True;
      dgrdDettaglio.Columns[3].Visible:=True;
      dgrdDettaglio.Columns[4].Visible:=True;
    end
    else if rgpTipoAccorp.ItemIndex = 1 then
    begin
      selP690A.Close;
      selP690A.SetVariable('COD',selP690.FieldByName('COD_FONDO').AsString);
      selP690A.SetVariable('DEC',selP690.FieldByName('DECORRENZA_DA').AsDateTime);
      if Trim(CodGenElab) <> '' then
        selP690A.SetVariable('CODGEN','and P690.cod_voce_gen = ''' + selP690.FieldByName('COD_VOCE_GEN').AsString + '''')
      else
        selP690A.SetVariable('CODGEN','');
      if Trim(CodDetElab) <> '' then
        selP690A.SetVariable('CODDET','and P690.cod_voce_det = ''' + selP690.FieldByName('COD_VOCE_DET').AsString + '''')
      else
        selP690A.SetVariable('CODDET','');
      selP690A.SetVariable('DATI','DATA_RETRIBUZIONE');
      selP690A.Open;
      selP690A.FieldByName('DATA_RETRIBUZIONE').OnGetText:=selP690DATA_RETRIBUZIONEGetText;
      dgrdDettaglio.DataSource:=dsrP690A;
      dgrdDettaglio.Columns[0].Visible:=True;
      dgrdDettaglio.Columns[1].Visible:=False;
      dgrdDettaglio.Columns[2].Visible:=False;
      dgrdDettaglio.Columns[3].Visible:=False;
      dgrdDettaglio.Columns[4].Visible:=True;
    end
    else if rgpTipoAccorp.ItemIndex = 2 then
    begin
      selP690A.Close;
      selP690A.SetVariable('COD',selP690.FieldByName('COD_FONDO').AsString);
      selP690A.SetVariable('DEC',selP690.FieldByName('DECORRENZA_DA').AsDateTime);
      if Trim(CodGenElab) <> '' then
        selP690A.SetVariable('CODGEN','and P690.cod_voce_gen = ''' + selP690.FieldByName('COD_VOCE_GEN').AsString + '''')
      else
        selP690A.SetVariable('CODGEN','');
      if Trim(CodDetElab) <> '' then
        selP690A.SetVariable('CODDET','and P690.cod_voce_det = ''' + selP690.FieldByName('COD_VOCE_DET').AsString + '''')
      else
        selP690A.SetVariable('CODDET','');
      selP690A.SetVariable('DATI','P690.COD_CONTRATTO, P690.COD_VOCE, P200.DESCRIZIONE');
      selP690A.Open;
      dgrdDettaglio.DataSource:=dsrP690A;
      dgrdDettaglio.Columns[0].Visible:=False;
      dgrdDettaglio.Columns[1].Visible:=True;
      dgrdDettaglio.Columns[2].Visible:=True;
      dgrdDettaglio.Columns[3].Visible:=True;
      dgrdDettaglio.Columns[3].Title.Caption:='Descrizione';
      dgrdDettaglio.Columns[4].Visible:=True;
    end;
  end;
end;

procedure TP684FGrigliaDett.Selezionatutto1Click(Sender: TObject);
begin
  inherited;
  R180DBGridSelezionaRighe(dgrdDettaglio,'S');
end;

end.
