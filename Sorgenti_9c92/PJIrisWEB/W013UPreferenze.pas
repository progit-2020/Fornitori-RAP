unit W013UPreferenze;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, R012UWEBANAGRAFICO, IWBaseLayoutComponent, IWBaseContainerLayout,
  IWContainerLayout, IWTemplateProcessorHTML, IWCompLabel, IWApplication,
  IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl, IWControl,
  IWHTMLControls, IWCompListbox, Oracle, OracleData,
  A000UInterfaccia, A000USessione, C190FunzioniGeneraliWeb,
  IWVCLBaseContainer, IWContainer, RegistrazioneLog,
  IWCompButton, R010UPAGINAWEB, IWVCLComponent,
  DB, DBClient, IWDBGrids, medpIWDBGrid, IWCompGrids, IWCompExtCtrls, meIWLabel,
  meIWLink, meIWComboBox, meIWButton, meIWImageFile;

type
  TW013FPreferenze = class(TR012FWebAnagrafico)
    lblCompetenze: TmeIWLabel;
    cmbCompetenze: TmeIWComboBox;
    cmbDestinazioni: TmeIWComboBox;
    lblDestinazioni: TmeIWLabel;
    btnInserisci: TmeIWButton;
    grdPreferenze: TmedpIWDBGrid;
    dsrSG113: TDataSource;
    cdsSG113: TClientDataSet;
    procedure IWAppFormCreate(Sender: TObject);
    procedure btnInserisciClick(Sender: TObject);
    procedure btnCancellaClick(Sender: TObject);
    procedure grdPreferenzeRenderCell(ACell: TIWGridCell; const ARow,
      AColumn: Integer);
    procedure grdPreferenzeAfterCaricaCDS(Sender: TObject; DBG_ROWID: string);
  private
    ListaCompetenze,ListaDestinazioni:TStringList;
    TabComp,TabDest,CodiceComp,CodiceDest:String;
    DimComp,DimDest:Integer;
    StoricoComp,StoricoDest:Boolean;
    procedure GetCompetenze;
    procedure GetDestinazioni;
    procedure DBGridColumnClick(ASender: TObject; const AValue: string);
  protected
    procedure VisualizzaDipendenteCorrente; override;
    procedure RefreshPage; override;
    procedure DistruggiOggetti; override;
  public
    function  InizializzaAccesso:Boolean; override;
  end;

implementation

uses W001UIrisWebDtM;

{$R *.dfm}

function TW013FPreferenze.InizializzaAccesso:Boolean;
var
  T, C, Storico: String;
begin
  // controlli bloccanti di accesso
  Result:=False;
  A000GetTabella(Parametri.CampiRiferimento.C12_PreferenzeCompetenza,T,C,Storico);
  if T = '' then
  begin
    GGetWebApplicationThreadVar.ShowMessage('Dato PREFERENZE COMPETENZA non specificato in Aziende/Gestione moduli!');
    Exit;
  end;
  Result:=True;

  GetDipendentiDisponibili(Parametri.DataLavoro);
  selAnagrafeW.SearchRecord('PROGRESSIVO',ParametriForm.Progressivo,[srFromBeginning]);
  VisualizzaDipendenteCorrente;
end;

procedure TW013FPreferenze.IWAppFormCreate(Sender: TObject);
var
  T,C,Storico,s,j:String;
begin
  inherited;
  btnInserisci.Visible:=not SolaLettura;
  ListaCompetenze:=TStringList.Create;
  ListaDestinazioni:=TStringList.Create;
  TabComp:='';
  TabDest:='';
  CodiceComp:='';
  CodiceDest:='';
  lblCompetenze.Caption:=lblCompetenze.Caption + ' (' + Parametri.CampiRiferimento.C12_PreferenzeCompetenza + '): ';
  lblDestinazioni.Caption:=lblDestinazioni.Caption + ' (' + Parametri.CampiRiferimento.C12_PreferenzeDestinazione + '): ';

  //Caricamento competenze
  A000GetTabella(Parametri.CampiRiferimento.C12_PreferenzeCompetenza,T,C,Storico);
  if T = '' then
  begin
    // spostato in InizializzaAccesso (causa scarso tempo questa soluzione non è molto elegante)
    //GGetWebApplicationThreadVar.ShowMessage('Dato PREFERENZE COMPETENZA non specificato in Aziende/Gestione moduli!');
    Exit;
  end;
  TabComp:=T;
  CodiceComp:=C;
  StoricoComp:=Storico = 'S';
  with WR000DM.selSQL do
  begin
    Close;
    SQL.Clear;
    SQL.Add('SELECT DATA_LENGTH FROM COLS WHERE COLUMN_NAME = ''' + Parametri.CampiRiferimento.C12_PreferenzeCompetenza + ''' AND TABLE_NAME = ''T430_STORICO''');
    Open;
    DimComp:=FieldByName('DATA_LENGTH').AsInteger;
    CloseAll;
  end;
  GetCompetenze;

  //Caricamento destinazioni
  A000GetTabella(Parametri.CampiRiferimento.C12_PreferenzeDestinazione,T,C,Storico);
  if T = '' then
  begin
    GGetWebApplicationThreadVar.ShowMessage('Dato PREFERENZE DESTINAZIONE non specificato in Aziende/Gestione moduli!');
    Exit;
  end;
  TabDest:=T;
  CodiceDest:=C;
  StoricoDest:=Storico = 'S';
  with WR000DM.selSQL do
  begin
    Close;
    SQL.Clear;
    SQL.Add('SELECT DATA_LENGTH FROM COLS WHERE COLUMN_NAME = ''' + Parametri.CampiRiferimento.C12_PreferenzeDestinazione + ''' AND TABLE_NAME = ''T430_STORICO''');
    Open;
    DimDest:=FieldByName('DATA_LENGTH').AsInteger;
    CloseAll;
  end;
  GetDestinazioni;

  //Preparazione query principale
  s:='';
  c:='';
  j:='';
  if TabComp <> 'T430_STORICO' then
  begin
    if TabComp = 'T480_COMUNI' then
      c:=', I501COMP.CITTA DESC_COMP'
    else
      c:=', I501COMP.DESCRIZIONE DESC_COMP';
    s:=', ' + TabComp + ' I501COMP ';
    j:=' AND SG113.PREFERENZA_COMPETENZA = I501COMP.' + CodiceComp;
    if StoricoComp then
      j:=j + ' AND I501COMP.DECORRENZA = (SELECT MAX(DECORRENZA) FROM ' + TabComp +
        ' WHERE ' + CodiceComp + ' = I501COMP.' + CodiceComp + ' AND DECORRENZA <= SG113.DATA_REGISTRAZIONE)';
  end;
  if TabDest <> 'T430_STORICO' then
  begin
    if TabDest = 'T480_COMUNI' then
      c:=c + ', I501DEST.CITTA DESC_DEST'
    else
      c:=c + ', I501DEST.DESCRIZIONE DESC_DEST';
    s:=s + ', ' + TabDest + ' I501DEST ';
    j:=j + ' AND SG113.PREFERENZA_DESTINAZIONE = I501DEST.' + CodiceDest;
    if StoricoDest then
      j:=j + ' AND I501DEST.DECORRENZA = (SELECT MAX(DECORRENZA) FROM ' + TabDest +
        ' WHERE ' + CodiceDest + ' = I501DEST.' + CodiceDest + ' AND DECORRENZA <= SG113.DATA_REGISTRAZIONE)';
  end;
  with WR000DM.selSG113 do
  begin
    SetVariable('TABELLECAMPI',c);
    SetVariable('TABELLE',s);
    SetVariable('TABELLEJOIN',j);
  end;
  // MONDOEDP - commessa MAN/08 SVILUPPO#161.ini
  grdPreferenze.medpRighePagina:=GetRighePaginaTabella;
  // MONDOEDP - commessa MAN/08 SVILUPPO#161.fine
  grdPreferenze.medpDataSet:=WR000DM.selSG113;
end;

procedure TW013FPreferenze.RefreshPage;
begin
  VisualizzaDipendenteCorrente;
end;

procedure TW013FPreferenze.VisualizzaDipendenteCorrente;
begin
  inherited;
  ParametriForm.Progressivo:=selAnagrafeW.FieldByName('PROGRESSIVO').AsInteger;
  with WR000DM.selSG113 do
  begin
    Close;
    SetVariable('FILTRO',' AND SG113.PROGRESSIVO = ' + IntToStr(selAnagrafeW.FieldByName('PROGRESSIVO').AsInteger));
    SetVariable('DATALAVORO',Parametri.DataLavoro);
    Open;
  end;
  cmbCompetenze.ItemIndex:=-1;
  cmbDestinazioni.ItemIndex:=-1;

  grdPreferenze.medpCreaCDS;
  grdPreferenze.medpEliminaColonne;
  grdPreferenze.medpAggiungiColonna('DBG_COMANDI','','',nil);;
  grdPreferenze.medpAggiungiColonna('DATA_REGISTRAZIONE','Data','',nil);
  grdPreferenze.medpAggiungiColonna('PREFERENZA_COMPETENZA','Competenza','',nil);
  grdPreferenze.medpAggiungiColonna('DESC_COMP','','',nil);
  grdPreferenze.medpAggiungiColonna('PREFERENZA_DESTINAZIONE','Destinazione','',nil);
  grdPreferenze.medpAggiungiColonna('DESC_DEST','','',nil);
  grdPreferenze.medpAggiungiRowClick('DBG_ROWID',DBGridColumnClick);
  grdPreferenze.medpInizializzaCompGriglia;
  if not SolaLettura then
    grdPreferenze.medpPreparaComponenteGenerico('R',0,0,DBG_IMG,'','CANCELLA','null','null');
  grdPreferenze.medpCaricaCDS;
end;



procedure TW013FPreferenze.GetCompetenze;
var S:String;
begin
  //Elenco competenze
  ListaCompetenze.Clear;
  cmbCompetenze.Items.Clear;
  with WR000DM.selSQL do
  begin
    Close;
    SQL.Clear;
    if TabComp <> 'T430_STORICO' then
    begin
      if TabComp = 'T480_COMUNI' then
        S:='SELECT ' + CodiceComp + ' CODICE, CITTA DESCRIZIONE FROM ' + TabComp + ' A'
      else
        S:='SELECT ' + CodiceComp + ' CODICE, DESCRIZIONE FROM ' + TabComp + ' A';
      if StoricoComp then
        S:=S + ' WHERE A.' + CodiceComp + ' <> ''*'' AND A.DECORRENZA = (SELECT MAX(DECORRENZA) FROM ' + TabComp +
           ' WHERE ' + CodiceComp + ' = A.' + CodiceComp + ' AND DECORRENZA <= TO_DATE(''' + DateToStr(Date) + ''',''DD/MM/YYYY''))';
    end
    else
      S:='SELECT DISTINCT ' + CodiceComp + ' CODICE, '''' DESCRIZIONE FROM T430_STORICO';
    S:=S + ' ORDER BY CODICE';
    SQL.Add(S);
    Open;
    while not Eof do
    begin
      cmbCompetenze.Items.Add(StringReplace(Format('%-' + IntToStr(DimComp) + 's %s',[FieldByName('CODICE').AsString,FieldByName('DESCRIZIONE').AsString]),' ',SPAZIO,[rfReplaceAll]));
      ListaCompetenze.Add(FieldByName('CODICE').AsString);
      Next;
    end;
    CloseAll;
  end;
  cmbCompetenze.RequireSelection:=cmbCompetenze.Items.Count > 0;
end;

procedure TW013FPreferenze.GetDestinazioni;
var S:String;
begin
  //Elenco destinazioni
  ListaDestinazioni.Clear;
  cmbDestinazioni.Items.Clear;
  with WR000DM.selSQL do
  begin
    Close;
    SQL.Clear;
    if TabDest <> 'T430_STORICO' then
    begin
      if TabDest = 'T480_COMUNI' then
        S:='SELECT ' + CodiceDest + ' CODICE, CITTA DESCRIZIONE FROM ' + TabDest + ' A'
      else
        S:='SELECT ' + CodiceDest + ' CODICE, DESCRIZIONE FROM ' + TabDest + ' A';
      if StoricoDest then
        S:=S + ' WHERE A.' + CodiceDest + ' <> ''*'' AND A.DECORRENZA = (SELECT MAX(DECORRENZA) FROM ' + TabDest +
           ' WHERE ' + CodiceDest + ' = A.' + CodiceDest + ' AND DECORRENZA <= TO_DATE(''' + DateToStr(Date) + ''',''DD/MM/YYYY''))';
    end
    else
      S:='SELECT DISTINCT ' + CodiceDest + ' CODICE, '''' DESCRIZIONE FROM T430_STORICO';
    S:=S + ' ORDER BY CODICE';
    SQL.Add(S);
    Open;
    while not Eof do
    begin
      cmbDestinazioni.Items.Add(StringReplace(Format('%-' + IntToStr(DimDest) + 's %s',[FieldByName('CODICE').AsString,FieldByName('DESCRIZIONE').AsString]),' ',SPAZIO,[rfReplaceAll]));
      ListaDestinazioni.Add(FieldByName('CODICE').AsString);
      Next;
    end;
    CloseAll;
  end;
  cmbDestinazioni.RequireSelection:=cmbDestinazioni.Items.Count > 0;
end;

procedure TW013FPreferenze.grdPreferenzeAfterCaricaCDS(Sender: TObject; DBG_ROWID: string);
var i:Integer;
begin
  if not SolaLettura then
  begin
    for i:=0 to High(grdPreferenze.medpCompGriglia) do
    begin
      (grdPreferenze.medpCompCella(i,0,0) as TmeIWImageFile).OnClick:=btnCancellaClick;
    end;
  end;
end;

procedure TW013FPreferenze.grdPreferenzeRenderCell(ACell: TIWGridCell; const ARow, AColumn: Integer);
begin
  inherited;

  if not (ACell.Grid as TmedpIWDBGrid).medpRenderCell(ACell,ARow,AColumn,True,True) then
    Exit;

  // assegnazione componenti
  if (ARow > 0) and (ARow <= High(grdPreferenze.medpCompGriglia) + 1) and (grdPreferenze.medpCompGriglia[ARow - 1].CompColonne[AColumn] <> nil) then
    begin
      ACell.Text:='';
      ACell.Control:=grdPreferenze.medpCompGriglia[ARow - 1].CompColonne[AColumn];
    end;
end;

procedure TW013FPreferenze.DBGridColumnClick(ASender: TObject; const AValue: string);
begin
  inherited;
  cdsSG113.Locate('DBG_ROWID',AValue,[]);
end;

procedure TW013FPreferenze.btnInserisciClick(Sender: TObject);
var C,D:String;
  Data:TDateTime;
begin
  inherited;
  with WR000DM.selSG113 do
  begin
    Append;
    FieldByName('PROGRESSIVO').AsInteger:=selAnagrafeW.FieldByName('PROGRESSIVO').AsInteger;
    Data:=Now;
    FieldByName('DATA_REGISTRAZIONE').AsDateTime:=Data;
    C:=Trim(Copy(StringReplace(cmbCompetenze.Text,SPAZIO,' ',[rfReplaceAll]),1,DimComp));
    FieldByName('PREFERENZA_COMPETENZA').AsString:=C;
    D:=Trim(Copy(StringReplace(cmbDestinazioni.Text,SPAZIO,' ',[rfReplaceAll]),1,DimDest));
    FieldByName('PREFERENZA_DESTINAZIONE').AsString:=D;
    try
      RegistraLog.SettaProprieta('I','SG113_PREFERENZE',medpCodiceForm,WR000DM.selSG113,True);
      Post;
      RegistraLog.RegistraOperazione;
      SessioneOracle.Commit;
    except
      Cancel;
    end;
  end;
  VisualizzaDipendenteCorrente;
end;

procedure TW013FPreferenze.btnCancellaClick(Sender: TObject);
var
  FN: String;
begin
  FN:=(Sender as TmeIWImageFile).FriendlyName;
  with WR000DM.selSG113 do
  begin
    if SearchRecord('ROWID',FN,[srFromBeginning]) then
    begin
      DBGridColumnClick(Sender,FN);

      RegistraLog.SettaProprieta('C','SG113_PREFERENZE',medpCodiceForm,WR000DM.selSG113,True);
      Delete;
      RegistraLog.RegistraOperazione;
      SessioneOracle.Commit;
    end;
  end;
  VisualizzaDipendenteCorrente;
end;

procedure TW013FPreferenze.DistruggiOggetti;
begin
  if ListaCompetenze <> nil then
    FreeAndNil(ListaCompetenze);
  if ListaDestinazioni <> nil then
    FreeAndNil(ListaDestinazioni);

  if (GGetWebApplicationThreadVar <> nil) and
     (GGetWebApplicationThreadVar.Data <> nil) then
  begin
    try WR000DM.selSG113.CloseAll; except end;
  end;
end;

end.
