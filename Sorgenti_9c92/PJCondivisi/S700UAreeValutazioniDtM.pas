unit S700UAreeValutazioniDtM;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, R004UGESTSTORICODTM, DB, Oracle, OracleData, C700USelezioneAnagrafe,
  C180FunzioniGenerali, A000UCostanti, A000USessione, A000UInterfaccia, Math;

type
  TS700FAreeValutazioniDtM = class(TR004FGestStoricoDtM)
    selSG701: TOracleDataSet;
    selSG700: TOracleDataSet;
    dsrSG700: TDataSource;
    selSG700COD_AREA: TStringField;
    selSG700COD_VALUTAZIONE: TStringField;
    selSG700DESCRIZIONE: TStringField;
    selSG701COD_AREA: TStringField;
    selSG701DECORRENZA: TDateTimeField;
    selSG701DECORRENZA_FINE: TDateTimeField;
    selSG701DESCRIZIONE: TStringField;
    selSG701PESO_PERCENTUALE: TFloatField;
    selSG700DECORRENZA: TDateTimeField;
    selSG710: TOracleDataSet;
    selSG711: TOracleQuery;
    selSG701PESO_VARIABILE_ITEMS: TStringField;
    selSG701TIPO_PUNTEGGIO_ITEMS: TStringField;
    selSG746: TOracleDataSet;
    selSG701STATI_ABILITATI_PUNTEGGI: TStringField;
    selSG700PESO_PERCENTUALE: TFloatField;
    updSG701: TOracleQuery;
    selSG701TIPO_PESO_PERCENTUALE: TStringField;
    selSG701ITEM_PERSONALIZZATI_MIN: TIntegerField;
    selSG701ITEM_PERSONALIZZATI_MAX: TIntegerField;
    selSG701ITEM_TUTTI_VALUTABILI: TStringField;
    selSG701TIPO_LINK_ITEM: TStringField;
    selSG700COD_AREA_LINK: TStringField;
    selSG700COD_VALUTAZIONE_LINK: TStringField;
    selLinkItem: TOracleDataSet;
    selSG700DESCRIZIONE_LINK: TStringField;
    selLinkItemCOD_AREA: TStringField;
    selLinkItemCOD_VALUTAZIONE: TStringField;
    selLinkItemDESCRIZIONE: TStringField;
    selSG701STATI_ABILITATI_ELEMENTI: TStringField;
    selSG701TESTO_ITEM_PERSONALIZZATI: TStringField;
    selSG701PESO_EQUO_ITEMS: TStringField;
    selSG701PESO_PERC_MIN: TFloatField;
    selSG701PESO_PERC_MAX: TFloatField;
    selSG701PUNTEGGI_SOLO_ITEM_VALUTABILI: TStringField;
    procedure selSG700ApplyRecord(Sender: TOracleDataSet; Action: Char; var Applied: Boolean; var NewRowId: string);
    procedure AfterPost(DataSet: TDataSet); override;
    procedure BeforePost(DataSet: TDataSet); override;
    procedure BeforeDelete(DataSet: TDataSet); override;
    procedure OnNewRecord(DataSet: TDataSet); override;
    procedure selSG700NewRecord(DataSet: TDataSet);
    procedure selSG701AfterScroll(DataSet: TDataSet);
    procedure DataModuleCreate(Sender: TObject);
    procedure selSG701PESO_PERCENTUALEValidate(Sender: TField);
    procedure selSG700BeforeDelete(DataSet: TDataSet);
    procedure selSG700BeforePost(DataSet: TDataSet);
    procedure selSG700COD_VALUTAZIONEValidate(Sender: TField);
    procedure selSG700PESO_PERCENTUALEValidate(Sender: TField);
    procedure selSG700CalcFields(DataSet: TDataSet);
    procedure selSG700AfterPost(DataSet: TDataSet);
  private
    { Private declarations }
    procedure ControllaSchedeEsistenti;
  public
    { Public declarations }
    procedure RicalcolaPesoArea;
  end;

var
  S700FAreeValutazioniDtM: TS700FAreeValutazioniDtM;

implementation

uses S700UAreeValutazioni;

{$R *.dfm}

procedure TS700FAreeValutazioniDtM.DataModuleCreate(Sender: TObject);
begin
  inherited;
  InterfacciaR004:=S700FAreeValutazioni.InterfacciaR004;
  InizializzaDataSet(selSG701,[evBeforeEdit,
                               evBeforeInsert,
                               evBeforePost,
                               evBeforeDelete,
                               evAfterDelete,
                               evAfterPost,
                               evOnTranslateMessage,
                               evOnNewRecord]);
  S700fAreeValutazioni.DButton.Dataset:=selSG701;
  selSG701.Open;
  selSG701PESO_PERCENTUALE.EditMask:='!990,00;1;_';
end;

procedure TS700FAreeValutazioniDtM.selSG701AfterScroll(DataSet: TDataSet);
begin
  inherited;
  selSG700.Close;
  selSG700.SetVariable('COD_AREA',selSG701.FieldByName('COD_AREA').AsString);
  selSG700.SetVariable('DECORRENZA',selSG701.FieldByName('DECORRENZA').AsDateTime);
  selSG700.Open;
  if S700FAreeValutazioni.Visible then
  begin
//    NumRecords;
    S700FAreeValutazioni.frmToolbarFiglio.AbilitaAzioniTF(nil);
  end;
  S700FAreeValutazioni.AbilitaComponenti;
end;

procedure TS700FAreeValutazioniDtM.selSG701PESO_PERCENTUALEValidate(Sender: TField);
begin
  inherited;
  if (Sender.AsInteger < 0)
  or (Sender.AsInteger > 100) then
    raise exception.create('Il valore del campo ' + Sender.DisplayLabel + ' deve essere compreso tra 0 e 100!');
  S700FAreeValutazioni.AbilitaComponenti;
end;

procedure TS700FAreeValutazioniDtM.selSG700NewRecord(DataSet: TDataSet);
begin
  inherited;
  selSG700.FieldByName('COD_AREA').AsString:=selSG701.FieldByName('COD_AREA').AsString;
  selSG700.FieldByName('DECORRENZA').AsDateTime:=selSG701.FieldByName('DECORRENZA').AsDateTime;
end;

procedure TS700FAreeValutazioniDtM.selSG700PESO_PERCENTUALEValidate(Sender: TField);
begin
  inherited;
  if (selSG700.FieldByName('PESO_PERCENTUALE').AsInteger < 0)
  or (selSG700.FieldByName('PESO_PERCENTUALE').AsInteger > 100) then
    raise exception.create('Il valore del campo Peso % deve essere compreso tra 0 e 100!');
  S700FAreeValutazioni.AbilitaComponenti;
end;

procedure TS700FAreeValutazioniDtM.BeforeDelete(DataSet: TDataSet);
begin
  inherited;
  ControllaSchedeEsistenti;
end;

procedure TS700FAreeValutazioniDtM.OnNewRecord(DataSet: TDataSet);
begin
  inherited;
  R180SetVariable(selLinkItem,'DATA',selSG701.FieldByName('DECORRENZA_FINE').AsDateTime);
  selLinkItem.Open;
  S700FAreeValutazioni.AbilitaComponenti;
end;

procedure TS700FAreeValutazioniDtM.BeforePost(DataSet: TDataSet);
begin
  S700FAreeValutazioni.dedtCodArea.SetFocus;
  //Controlli sulla testata
  if (selSG701.FieldByName('TIPO_PESO_PERCENTUALE').AsString = '1')
  and (selSG701.FieldByName('PESO_PERCENTUALE').AsFloat = 0) then
  begin
    if S700FAreeValutazioni.dedtPesoPercentuale.Enabled then
      S700FAreeValutazioni.dedtPesoPercentuale.SetFocus;
    raise exception.Create('Indicare il Peso % dell''area');
  end;
  if S700FAreeValutazioni.dedtPesoPercMin.Enabled
  and (   (selSG701.FieldByName('PESO_PERCENTUALE').AsFloat < selSG701.FieldByName('PESO_PERC_MIN').AsFloat)
       or (selSG701.FieldByName('PESO_PERCENTUALE').AsFloat > selSG701.FieldByName('PESO_PERC_MAX').AsFloat))
  and not ((selSG701.FieldByName('PESO_PERCENTUALE').AsFloat = 0) and (selSG700.RecordCount = 0)) then
  begin
    if S700FAreeValutazioni.dedtPesoPercentuale.Enabled then
      S700FAreeValutazioni.dedtPesoPercentuale.SetFocus;
    raise exception.Create('Il Peso % dell''area dev''essere compreso nel range Min-Max');
  end;
  if selSG701.FieldByName('ITEM_PERSONALIZZATI_MIN').AsInteger > selSG701.FieldByName('ITEM_PERSONALIZZATI_MAX').AsInteger then
  begin
    S700FAreeValutazioni.dedtItemPersonalizzatiMin.SetFocus;
    raise exception.Create('Impostare correttamente il range del dato Elementi personalizzati!');
  end;
  if (selSG701.FieldByName('ITEM_PERSONALIZZATI_MAX').AsInteger > 0)
  and (Trim(selSG701.FieldByName('TESTO_ITEM_PERSONALIZZATI').AsString) = '') then
  begin
    S700FAreeValutazioni.dmemTestoItemPersonalizzati.SetFocus;
    raise exception.Create('Compilare il campo ' + S700FAreeValutazioni.lblTestoItemPersonalizzati.Caption + '!');
  end;
  if (selSG700.State in [dsInsert]) or InterfacciaR004.StoricizzazioneInCorso then
    ControllaSchedeEsistenti;
  inherited;
  S700FAreeValutazioni.AbilitaComponenti;
end;

procedure TS700FAreeValutazioniDtM.AfterPost(DataSet: TDataSet);
begin
  inherited;
  try
    RicalcolaPesoArea;
  except
    on E:exception do
    begin
      ShowMessage(E.Message);
      S700FAreeValutazioni.frmToolbarFiglio.actTFModificaExecute(S700FAreeValutazioni.frmToolbarFiglio.actTFModifica);
    end;
  end;
end;

procedure TS700FAreeValutazioniDtM.selSG700AfterPost(DataSet: TDataSet);
begin
  inherited;
  S700FAreeValutazioni.AbilitaComponenti;
end;

procedure TS700FAreeValutazioniDtM.selSG700ApplyRecord(Sender: TOracleDataSet; Action: Char; var Applied: Boolean; var NewRowId: string);
begin
  inherited;
  (*//Controlli sui figli
  if (Action <> 'D') and (Action <> 'I') and (Action <> 'U') then
    Exit;
  if selSG700.FieldByName('COD_VALUTAZIONE').IsNull then
    raise exception.Create('Inserire il codice valutazione.');
  if selSG700.FieldByName('DESCRIZIONE').IsNull then
    raise exception.Create('Inserire la descrizione della valutazione.');
  case Action of
    'D':RegistraLog.SettaProprieta('C',R180Query2NomeTabella(Sender),Copy(Name,1,4),Sender,True);
    'I':RegistraLog.SettaProprieta('I',R180Query2NomeTabella(Sender),Copy(Name,1,4),Sender,True);
    'U':RegistraLog.SettaProprieta('M',R180Query2NomeTabella(Sender),Copy(Name,1,4),Sender,True);
  end;
  if Action in ['D','I','U'] then
    RegistraLog.RegistraOperazione;
  if (selSG701.FieldByName('PESO_PERCENTUALE').AsFloat < 0)
  or (selSG701.FieldByName('PESO_PERCENTUALE').AsFloat > 100) then
    raise exception.create('Il Peso % dell''area deve essere compreso tra 0 e 100!');*)
end;

procedure TS700FAreeValutazioniDtM.selSG700BeforeDelete(DataSet: TDataSet);
begin
  inherited;
  ControllaSchedeEsistenti;
end;

procedure TS700FAreeValutazioniDtM.selSG700BeforePost(DataSet: TDataSet);
begin
  inherited;
  if selSG700.FieldByName('COD_VALUTAZIONE').IsNull then
    raise exception.Create('Inserire il codice dell''elemento!');
  if selSG700.FieldByName('DESCRIZIONE').IsNull then
    raise exception.Create('Inserire la descrizione dell''elemento!');
  if (selSG701.FieldByName('TIPO_LINK_ITEM').AsString <> '0') then
  begin
    if selSG700.FieldByName('COD_AREA_LINK').IsNull then
      raise exception.Create('Inserire il codice dell''area collegata!');
    if selSG700.FieldByName('COD_VALUTAZIONE_LINK').IsNull then
      raise exception.Create('Inserire il codice dell''elemento collegato!');
    R180SetVariable(selLinkItem,'DATA',selSG701.FieldByName('DECORRENZA_FINE').AsDateTime);
    selLinkItem.Open;
    if VarToStr(selLinkItem.Lookup('COD_AREA;COD_VALUTAZIONE',VarArrayOf([selSG700.FieldByName('COD_AREA_LINK').AsString,selSG700.FieldByName('COD_VALUTAZIONE_LINK').AsString]),'DESCRIZIONE')) = '' then
      raise exception.Create('L''elemento collegato non è valido! Sceglierne uno dalla lista!');
  end;
  if dsrSG700.State in [dsInsert] then
    ControllaSchedeEsistenti;
end;

procedure TS700FAreeValutazioniDtM.selSG700CalcFields(DataSet: TDataSet);
begin
  inherited;
  R180SetVariable(selLinkItem,'DATA',selSG701.FieldByName('DECORRENZA_FINE').AsDateTime);
  selLinkItem.Open;
  with selSG700 do
    FieldByName('DESCRIZIONE_LINK').AsString:=VarToStr(selLinkItem.Lookup('COD_AREA;COD_VALUTAZIONE',VarArrayOf([FieldByName('COD_AREA_LINK').AsString,FieldByName('COD_VALUTAZIONE_LINK').AsString]),'DESCRIZIONE'));
end;

procedure TS700FAreeValutazioniDtM.selSG700COD_VALUTAZIONEValidate(Sender: TField);
begin
  inherited;
  selSG711.SetVariable('COD_AREA',selSG700.FieldByName('COD_AREA').AsString);
  selSG711.SetVariable('COD_VALUTAZIONE',selSG700.FieldByName('COD_VALUTAZIONE').AsString);
  selSG711.Execute;
  if selSG711.FieldAsInteger(0) > 0 then
    raise exception.Create('Il codice elemento ' + selSG700.FieldByName('COD_VALUTAZIONE').AsString + ' dell''area ' + selSG700.FieldByName('COD_AREA').AsString + ' è già stato inserito manualmente nelle schede di valutazione!');
end;

procedure TS700FAreeValutazioniDtM.ControllaSchedeEsistenti;
begin
  with selSG710 do
  begin
    Close;
    SetVariable('COD_AREA',selSG700.FieldByName('COD_AREA').AsString);
    SetVariable('DEC_INI',selSG701.FieldByName('DECORRENZA').AsDateTime);
//    SetVariable('DEC_FIN',selSG701.FieldByName('DECORRENZA_FINE').AsDateTime);
    Open;
    if FieldByName('N_REC_SCHEDE').AsInteger > 0 then
      ShowMessage('Attenzione! Sono già state create delle Schede di valutazione con il codice area ' + selSG700.FieldByName('COD_AREA').AsString + #13 +
                  'in date successive alla decorrenza corrente! Potrebbero verificarsi dei disallineamenti!');
  end;
end;

procedure TS700FAreeValutazioniDtM.RicalcolaPesoArea;
var
  BM: TBookmark;
  PesoArea,PesoItem: Real;
begin
  inherited;
  selSG700.DisableControls;
  BM:=selSG700.GetBookmark;
  //Se l'area prevede la ripartizione equa dei pesi degli elementi...
  if selSG701.FieldByName('PESO_EQUO_ITEMS').AsString = 'S' then
  begin
    try
      selSG700.ReadOnly:=False;
      //...divido il peso dell'area per il numero di elementi
      PesoArea:=IfThen(selSG701.FieldByName('TIPO_PESO_PERCENTUALE').AsString = '1',100,selSG701.FieldByName('PESO_PERCENTUALE').AsFloat);
      PesoItem:=0;
      if selSG700.RecordCount > 0 then
        PesoItem:=R180Arrotonda(PesoArea / selSG700.RecordCount,0.01,'P');
      selSG700.First;
      while not selSG700.Eof do
      begin
        selSG700.Edit;
        selSG700.FieldByName('PESO_PERCENTUALE').AsFloat:=PesoItem;
        selSG700.Post;
        PesoArea:=PesoArea - PesoItem;
        selSG700.Next;
      end;
      selSG700.Last;
      while (PesoArea <> 0)
      and (selSG700.RecordCount > 0) do
      begin
        selSG700.Edit;
        selSG700.FieldByName('PESO_PERCENTUALE').AsFloat:=PesoItem + (0.01 * IfThen(PesoArea < 0,-1,1));
        selSG700.Post;
        PesoArea:=R180Arrotonda(PesoArea + (0.01 * IfThen(PesoArea < 0,1,-1)),0.01,'P');
        selSG700.Prior;
      end;
      SessioneOracle.ApplyUpdates([selSG700],True);
      selSG700.GotoBookmark(BM);
    finally
      selSG700.FreeBookmark(BM);
      selSG700.EnableControls;
      selSG700.ReadOnly:=True;
    end;
  end
  else
  begin
    try
      PesoArea:=0;
      selSG700.First;
      while not selSG700.Eof do
      begin
        PesoArea:=PesoArea + selSG700.FieldByName('PESO_PERCENTUALE').AsFloat;
        selSG700.Next;
      end;
      selSG700.GotoBookmark(BM);
    finally
      selSG700.FreeBookmark(BM);
      selSG700.EnableControls;
    end;
    if selSG701.FieldByName('TIPO_PESO_PERCENTUALE').AsString = '1' then
    begin
      if PesoArea <> 100 then
        raise exception.create('La somma di Peso % degli elementi deve essere 100!');
    end
    else
    begin
      updSG701.SetVariable('PESO_PERCENTUALE',PesoArea);
      updSG701.SetVariable('COD_AREA',selSG701.FieldByName('COD_AREA').AsString);
      updSG701.SetVariable('DECORRENZA',selSG701.FieldByName('DECORRENZA').AsDateTime);
      updSG701.Execute;
      selSG701.RefreshRecord;
      if (PesoArea < 0) or (PesoArea > 100) then
        raise exception.create('Il Peso % dell''area deve essere compreso tra 0 e 100!');
    end;
  end;
  (*if (selSG701.FieldByName('PESO_PERCENTUALE').AsFloat = 0)
  and (selSG700.RecordCount > 0) then
  begin
    selSG701.AfterPost:=nil;
    selSG701.Edit;
    selSG701.FieldByName('PESO_VARIABILE_ITEMS').AsString:='S';
    selSG701.FieldByName('PESO_EQUO_ITEMS').AsString:='N';
    selSG701.Post;
    selSG701.AfterPost:=AfterPost;
  end;*)
  if (selSG701.FieldByName('PESO_PERCENTUALE').AsFloat = 0)
  and (selSG701.FieldByName('PESO_VARIABILE_ITEMS').AsString = 'N')
  and (   (selSG701.FieldByName('ITEM_PERSONALIZZATI_MAX').AsInteger > 0)
       or (selSG700.RecordCount > 0)) then
  begin
    selSG701.AfterPost:=nil;
    selSG701.Edit;
    selSG701.FieldByName('ITEM_TUTTI_VALUTABILI').AsString:='S';
    selSG701.Post;
    selSG701.AfterPost:=AfterPost;
  end;
  //Aggiorno il range Min-Max
  selSG701.AfterPost:=nil;
  selSG701.Edit;
  if not S700FAreeValutazioni.dedtPesoPercMin.Enabled
  or (selSG701.FieldByName('PESO_PERC_MIN').AsFloat = selSG701.FieldByName('PESO_PERC_MAX').AsFloat) then
  begin
    selSG701.FieldByName('PESO_PERC_MIN').AsString:=selSG701.FieldByName('PESO_PERCENTUALE').AsString;
    selSG701.FieldByName('PESO_PERC_MAX').AsString:=selSG701.FieldByName('PESO_PERCENTUALE').AsString;
  end
  else if selSG700.RecordCount > 0 then
  begin
    if (selSG701.FieldByName('PESO_PERCENTUALE').AsFloat < selSG701.FieldByName('PESO_PERC_MIN').AsFloat) then
      selSG701.FieldByName('PESO_PERC_MIN').AsFloat:=selSG701.FieldByName('PESO_PERCENTUALE').AsFloat
    else if (selSG701.FieldByName('PESO_PERCENTUALE').AsFloat > selSG701.FieldByName('PESO_PERC_MAX').AsFloat) then
      selSG701.FieldByName('PESO_PERC_MAX').AsFloat:=selSG701.FieldByName('PESO_PERCENTUALE').AsFloat;
  end;
  selSG701.Post;
  selSG701.AfterPost:=AfterPost;
  SessioneOracle.Commit;
end;

end.
