unit A020UCausPresenzeMW;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, DB,OracleData,Oracle,
  Dialogs, R005UDataModuleMW,ControlloVociPaghe,RegistrazioneLog,
  A000USessione, A000UMessaggi, A000UInterfaccia, A000UCostanti, C180FunzioniGenerali;

type
  TA020CheckTipoGiorno = procedure (tipoGiorno: String) of Object;
  TA020CheckVocipaghe = procedure (Msg: String) of Object;
  TA020ShowMessage = procedure (Msg: String) of Object;
  TA020RefreshGrid = procedure of Object;

  TA020FCausPresenzeMW = class(TR005FDataModuleMW)
    chkT276: TOracleDataSet;
    selT275lkp: TOracleDataSet;
    dsrT275lkp: TDataSource;
    selT162: TOracleDataSet;
    dsrT162: TDataSource;
    updT277: TOracleQuery;
    updT276: TOracleQuery;
    selT305: TOracleDataSet;
    selT265: TOracleDataSet;
    selT265CODICE: TStringField;
    selT265DESCRIZIONE: TStringField;
    dsrT265: TDataSource;
    dsrT270: TDataSource;
    selT270: TOracleDataSet;
    selT277: TOracleDataSet;
    selT277CODICE: TStringField;
    selT277TIPO_GIORNO: TStringField;
    selT277DESC_GIORNO: TStringField;
    selT277DALLE: TStringField;
    selT277ALLE: TStringField;
    selT277FASCE_PN: TStringField;
    dsrT277: TDataSource;
    dsrT276: TDataSource;
    selT276: TOracleDataSet;
    selT276CODICE: TStringField;
    selT276TIPOGIORNO: TStringField;
    selT276DALLE: TStringField;
    selT276ALLE: TStringField;
    selT276LIMITE: TStringField;
    selT276VOCEPAGHE: TStringField;
    selT275lkpOreNorm: TOracleDataSet;
    dsrT275lkpOreNorm: TDataSource;
    procedure DataModuleDestroy(Sender: TObject);
    procedure selT270FilterRecord(DataSet: TDataSet; var Accept: Boolean);
    procedure selT277TIPO_GIORNOValidate(Sender: TField);
    procedure selT277DALLEValidate(Sender: TField);
    procedure selT277FASCE_PNValidate(Sender: TField);
    procedure selT277AfterPost(DataSet: TDataSet);
    procedure selT277BeforeDelete(DataSet: TDataSet);
    procedure selT277BeforePost(DataSet: TDataSet);
    procedure selT277CalcFields(DataSet: TDataSet);
    procedure selT277NewRecord(DataSet: TDataSet);
    procedure selT276TIPOGIORNOValidate(Sender: TField);
    procedure selT276DALLEValidate(Sender: TField);
    procedure selT276AfterPost(DataSet: TDataSet);
    procedure selT276BeforeDelete(DataSet: TDataSet);
    procedure selT276BeforePost(DataSet: TDataSet);
    procedure selT276NewRecord(DataSet: TDataSet);
    procedure selT275lkpAfterOpen(DataSet: TDataSet);
    procedure selT275lkpOreNormFilterRecord(DataSet: TDataSet; var Accept: Boolean);
  private
    VecchioCodiceDizionario:String;
  public
    SelT275: TOracleDataSet;
    SelControlloVociPaghe: TControlloVociPaghe;
    CheckTipoGiorno: TA020CheckTipoGiorno;
    ShowCustomMessage: TA020ShowMessage;
    RefreshVociPagheGrid: TA020RefreshGrid;
    ControlloVociPagheBeforeDelete, ControlloVociPagheBeforePost: TA020CheckVocipaghe;
    procedure T275AfterPost;
    procedure T275AfterCancel;
    procedure T275AfterScroll;
    procedure T275BeforeDelete;
    procedure T275BeforePostStep1;
    procedure T275BeforePostStep2;
    procedure T275CodiceValidate;
    procedure InizializzaDataSet;
    procedure ValidataCampoOra(Sender: TField; const Text: string);
    procedure ValidataArrotondamento(Sender: TField);
    procedure FilterRecord(DataSet: TDataSet;var Accept: Boolean);
    const
      D_FlexSogliaObblFac:array[0..2] of TItemsValues = (
      (Item:'No';                                Value:'N'),
      (Item:'Solo se <= soglia facolt./obblig.'; Value:'A'),
      (Item:'Fino alla soglia facolt./obblig.';  Value:'B')
      );
      D_TipoGiorno:array[0..12] of TItemsValues = (
      (Item:'Tutti i giorni';            Value:'T'),
      (Item:'Lavorativi';                Value:'L'),
      (Item:'Non lavorativi';            Value:'N'),
      (Item:'Prefestivi';                Value:'P'),
      (Item:'Festivi';                   Value:'F'),
      (Item:'Festivi infrasettimanali';  Value:'I'),
      (Item:'Lunedì';                    Value:'1'),
      (Item:'Martedì';                   Value:'2'),
      (Item:'Mercoledì';                 Value:'3'),
      (Item:'Giovedì';                   Value:'4'),
      (Item:'Venerdì';                   Value:'5'),
      (Item:'Sabato';                    Value:'6'),
      (Item:'Domenica';                  Value:'7')
      );
      D_FascePN:array[0..1] of TItemsValues = (
      (Item:''; Value:'S'),
      (Item:''; Value:'N')
      );
      D_VociSuddiviseTipoGiorno:array[0..11] of TItemsValues = (
      (Item:''; Value:'L'),
      (Item:''; Value:'NL'),
      (Item:''; Value:'PF'),
      (Item:''; Value:'F'),
      (Item:''; Value:'FF'),
      (Item:''; Value:'1'),
      (Item:''; Value:'2'),
      (Item:''; Value:'3'),
      (Item:''; Value:'4'),
      (Item:''; Value:'5'),
      (Item:''; Value:'6'),
      (Item:''; Value:'7')
      );
  end;

implementation

{$R *.dfm}

procedure TA020FCausPresenzeMW.InizializzaDataSet;
begin
  selT162.Open;
  selT275lkp.Open;
  selT275lkpOreNorm.Open;
  selT270.Open;
  selT265.Open;
  selT305.Open;
  selControlloVociPaghe:=TControlloVociPaghe.Create(Self,'');
end;

procedure TA020FCausPresenzeMW.DataModuleDestroy(Sender: TObject);
begin
  inherited;
  if selControlloVociPaghe <> nil then
    FreeAndNil(selControlloVociPaghe);
end;

procedure TA020FCausPresenzeMW.ValidataArrotondamento(Sender: TField);
{L'arrotondamento deve essere divisore di 60}
begin
  if Sender.AsInteger = 0 then exit;
  if 60 mod Sender.AsInteger <> 0 then
    raise Exception.Create(A000MSG_ERR_MINUTI_DIVISORI);
end;

procedure TA020FCausPresenzeMW.ValidataCampoOra(Sender: TField; const Text: string);
begin
  {$I CampoOra}
end;

procedure TA020FCausPresenzeMW.T275AfterCancel;
begin
  //Controllo sulle fasce orarie delle voci paghe
  with chkT276 do
  begin
    Close;
    SetVariable('Codice',selT275.FieldByName('Codice').AsString);
    Open;
    if RecordCount > 0 then
    begin
      if Assigned(ShowCustomMessage) then
        ShowCustomMessage(A000MSG_A020_ERR_FASCE_VOCI_PAGHE);
      selT275.Edit;
    end;
  end;
end;

procedure TA020FCausPresenzeMW.T275AfterPost;
var S:String;
begin
  //Controllo sulle fasce orarie delle voci paghe
  with chkT276 do
  begin
    Close;
    SetVariable('Codice',selT275.FieldByName('Codice').AsString);
    Open;
    if RecordCount > 0 then
    begin
      if Assigned(ShowCustomMessage) then
        ShowCustomMessage(A000MSG_A020_ERR_FASCE_VOCI_PAGHE);
      selT275.Edit;
      exit;
    end;
  end;
  with selT275 do
  begin
    S:=FieldByName('CODICE').AsString;
    A000AggiornaFiltroDizionario('CAUSALI PRESENZA',VecchioCodiceDizionario,S);
    DisableControls;
    Refresh;
    Locate('CODICE',S,[]);
    EnableControls;
  end;
end;

procedure TA020FCausPresenzeMW.T275AfterScroll;
begin
  with selT276 do
  begin
    DisableControls;
    Close;
    SetVariable('Codice',selT275.FieldByName('Codice').AsString);
    Open;
    EnableControls;
  end;
  with selT277 do
  begin
    DisableControls;
    Close;
    SetVariable('CODICE',selT275.FieldByName('Codice').AsString);
    Open;
    EnableControls;
  end;
end;

procedure TA020FCausPresenzeMW.T275BeforeDelete;
begin
  //Cancellazione Q276
  while not selT276.Eof do
    selT276.Delete;
  //Cancellazione sel277
  while not selT277.Eof do
    selT277.Delete;
  A000AggiornaFiltroDizionario('CAUSALI PRESENZA',selT275.FieldByName('CODICE').AsString,'');
end;

procedure TA020FCausPresenzeMW.T275BeforePostStep1;
begin
  if selT275.State = dsEdit then
    VecchioCodiceDizionario:=VarToStr(selT275.FieldByName('CODICE').medpOldValue)
  else
    VecchioCodiceDizionario:='';
  if QueryPK1.EsisteChiave('T275_CAUPRESENZE',selT275.RowId,selT275.State,['CODICE'],[selT275.FieldByName('Codice').AsString]) then
    raise Exception.Create('Codice già esistente!');
  with selT265 do
  begin
    if VarToStr(Lookup('CODICE',selT275.FieldByName('Codice').AsString,'CODICE')) <> '' then
      raise Exception.Create('Codice già esistente come causale di assenza!');
  end;
  with selT305 do
  begin
    Close;
    SetVariable('Codice',selT275.FieldByName('Codice').AsString);
    Open;
    if RecordCount > 0 then
      raise Exception.Create('Codice già esistente come causale di giustificazione!');
  end;
end;

procedure TA020FCausPresenzeMW.T275BeforePostStep2;
begin
  //Con causali vincolate ad U/E, non ha senso impostare NO_ECCEDENZA_IN_FASCIA a P (prima Entrata/ultima Uscita)
  if (selT275.FieldByName('TipoConteggio').AsString = 'E') and
     (selT275.FieldByName('NO_ECCEDENZA_IN_FASCIA').AsString = 'P') then
    selT275.FieldByName('NO_ECCEDENZA_IN_FASCIA').AsString:='N';
  { TODO : TEST IW 15 }
  if selT275.State = dsEdit then
  begin
    if selT275.FieldByName('Codice').Value <> selT275.FieldByName('Codice').medpOldValue then
    begin
      updT276.SetVariable('Codice',selT275.FieldByName('Codice').Value);
      updT276.SetVariable('Codice_Old',selT275.FieldByName('Codice').medpOldValue);
      updT276.Execute;
    end;
    if selT275.FieldByName('Codice').Value <> selT275.FieldByName('Codice').medpOldValue then
    begin
      updT277.SetVariable('Codice',selT275.FieldByName('Codice').Value);
      updT277.SetVariable('Codice_Old',selT275.FieldByName('Codice').medpOldValue);
      updT277.Execute;
    end;
  end;
  if (selT275.FieldByName('PERIODICITA_ABBATTIMENTO').IsNull) or (selT275.FieldByName('ORENORMALI').AsString <> 'A') then
    selT275.FieldByName('PERIODICITA_ABBATTIMENTO').AsInteger:=-1;
end;

procedure TA020FCausPresenzeMW.T275CodiceValidate;
begin
  if (selT275.State in [dsInsert,dsEdit]) and (Trim(selT275.FieldByName('Sigla').AsString) = '') then
    selT275.FieldByName('Sigla').AsString:=Copy(selT275.FieldByName('Codice').AsString,1,1);
end;

procedure TA020FCausPresenzeMW.FilterRecord(DataSet: TDataSet;var Accept: Boolean);
begin
  if DataSet = selT275 then
    Accept:=A000FiltroDizionario('CAUSALI PRESENZA',DataSet.FieldByName('CODICE').AsString)
  else if DataSet = selT270 then
    Accept:=A000FiltroDizionario('RAGGRUPPAMENTI PRESENZA',DataSet.FieldByName('CODICE').AsString);
end;

procedure TA020FCausPresenzeMW.selT270FilterRecord(DataSet: TDataSet; var Accept: Boolean);
begin
  FilterRecord(DataSet,Accept);
end;

procedure TA020FCausPresenzeMW.selT275lkpAfterOpen(DataSet: TDataSet);
begin
  inherited;
  DataSet.FieldByName('CODICE').DisplayWidth:=7;
end;

procedure TA020FCausPresenzeMW.selT275lkpOreNormFilterRecord(DataSet: TDataSet; var Accept: Boolean);
begin
  inherited;
  if (SelT275 <> nil) and (SelT275.Active) then
    Accept:=DataSet.FieldByName('CODICE').AsString <> SelT275.FieldByName('CODICE').AsString;
end;

procedure TA020FCausPresenzeMW.selT276AfterPost(DataSet: TDataSet);
begin
  RegistraLog.RegistraOperazione;
  if Assigned(RefreshVociPagheGrid) then
    RefreshVociPagheGrid;
end;

procedure TA020FCausPresenzeMW.selT276BeforeDelete(DataSet: TDataSet);
var VoceOld:String;
begin
  //Controllo voci paghe
  if selT276.FieldByName('VOCEPAGHE').medpOldValue = null then
    VoceOld:=''
  else
    VoceOld:=selT276.FieldByName('VOCEPAGHE').medpOldValue;
  if not selControlloVociPaghe.ControlloVociPaghe(VoceOld,'') then
    if Assigned(ControlloVociPagheBeforeDelete) then
      ControlloVociPagheBeforeDelete(selControlloVociPaghe.MessaggioLog);
  RegistraLog.SettaProprieta('C',R180Query2NomeTabella(DataSet),NomeOwner,DataSet,True);
end;

procedure TA020FCausPresenzeMW.selT276BeforePost(DataSet: TDataSet);
var VoceOld:String;
begin
  //Controllo voci paghe
  // Gallizio 08/02/2019: (*) = aggiunto per gestire medpOldValue
  VoceOld:='';  // (*)
  if selT276.State = dsEdit then // (*)
  begin
    if selT276.FieldByName('VOCEPAGHE').medpOldValue = null then
      VoceOld:=''
    else
      VoceOld:=selT276.FieldByName('VOCEPAGHE').medpOldValue;
  end; // (*)
  if not selControlloVociPaghe.ControlloVociPaghe(VoceOld,selT276.FieldByName('VOCEPAGHE').AsString) then
    if Assigned(ControlloVociPagheBeforePost) then
      ControlloVociPagheBeforePost(selControlloVociPaghe.MessaggioLog);
  case DataSet.State of
    dsInsert:RegistraLog.SettaProprieta('I',R180Query2NomeTabella(DataSet),NomeOwner,DataSet,True);
    dsEdit:RegistraLog.SettaProprieta('M',R180Query2NomeTabella(DataSet),NomeOwner,DataSet,True);
  end;
end;

procedure TA020FCausPresenzeMW.selT276DALLEValidate(Sender: TField);
begin
  R180OraValidate(Sender.AsString);
end;

procedure TA020FCausPresenzeMW.selT276NewRecord(DataSet: TDataSet);
begin
  selT276.FieldByName('Codice').AsString:=selT275.FieldByName('Codice').AsString;
end;

procedure TA020FCausPresenzeMW.selT276TIPOGIORNOValidate(Sender: TField);
begin
  //if (Sender.AsString <> 'L') and (Sender.AsString <> 'NL') and (Sender.AsString <> 'PF') and (Sender.AsString <> 'F') then
  if not R180In(Sender.AsString,['L','NL''PF','F','FF','1','2','3','4','5','6','7']) then
    raise Exception.Create(A000MSG_A020_ERR_VALORI_TIPO_GIORNO);
end;

procedure TA020FCausPresenzeMW.selT277AfterPost(DataSet: TDataSet);
begin
  RegistraLog.RegistraOperazione;
end;

procedure TA020FCausPresenzeMW.selT277BeforeDelete(DataSet: TDataSet);
begin
  RegistraLog.SettaProprieta('C',R180Query2NomeTabella(DataSet),NomeOwner,DataSet,True);
end;

procedure TA020FCausPresenzeMW.selT277BeforePost(DataSet: TDataSet);
begin
  if selT277.FieldByName('FASCE_PN').AsString = 'S' then
  begin
    selT277.FieldByName('DALLE').AsString:='00.00';
    selT277.FieldByName('ALLE').Clear;
  end
  else if selT277.FieldByName('DALLE').IsNull or selT277.FieldByName('ALLE').IsNull then
    raise Exception.Create(A000MSG_A020_ERR_FASCIA_AUTORIZZAZIONE);
  case DataSet.State of
    dsInsert:RegistraLog.SettaProprieta('I',R180Query2NomeTabella(DataSet),NomeOwner,DataSet,True);
    dsEdit:RegistraLog.SettaProprieta('M',R180Query2NomeTabella(DataSet),NomeOwner,DataSet,True);
  end;
end;

procedure TA020FCausPresenzeMW.selT277CalcFields(DataSet: TDataSet);
begin
  if selT277.FieldByName('TIPO_GIORNO').AsString = 'T' then
    selT277.FieldByName('DESC_GIORNO').AsString:='Tutti i giorni'
  else if selT277.FieldByName('TIPO_GIORNO').AsString = 'L' then
    selT277.FieldByName('DESC_GIORNO').AsString:='Lavorativi'
  else if selT277.FieldByName('TIPO_GIORNO').AsString = 'N' then
    selT277.FieldByName('DESC_GIORNO').AsString:='Non lavorativi'
  else if selT277.FieldByName('TIPO_GIORNO').AsString = 'P' then
    selT277.FieldByName('DESC_GIORNO').AsString:='Prefestivi'
  else if selT277.FieldByName('TIPO_GIORNO').AsString = 'F' then
    selT277.FieldByName('DESC_GIORNO').AsString:='Festivi'
  else if selT277.FieldByName('TIPO_GIORNO').AsString = 'I' then
    selT277.FieldByName('DESC_GIORNO').AsString:='Festivi infrasettimanali'
  else if selT277.FieldByName('TIPO_GIORNO').AsString = '1' then
    selT277.FieldByName('DESC_GIORNO').AsString:='Lunedì'
  else if selT277.FieldByName('TIPO_GIORNO').AsString = '2' then
    selT277.FieldByName('DESC_GIORNO').AsString:='Martedì'
  else if selT277.FieldByName('TIPO_GIORNO').AsString = '3' then
    selT277.FieldByName('DESC_GIORNO').AsString:='Mercoledì'
  else if selT277.FieldByName('TIPO_GIORNO').AsString = '4' then
    selT277.FieldByName('DESC_GIORNO').AsString:='Giovedì'
  else if selT277.FieldByName('TIPO_GIORNO').AsString = '5' then
    selT277.FieldByName('DESC_GIORNO').AsString:='Venerdì'
  else if selT277.FieldByName('TIPO_GIORNO').AsString = '6' then
    selT277.FieldByName('DESC_GIORNO').AsString:='Sabato'
  else if selT277.FieldByName('TIPO_GIORNO').AsString = '7' then
    selT277.FieldByName('DESC_GIORNO').AsString:='Domenica';
end;

procedure TA020FCausPresenzeMW.selT277DALLEValidate(Sender: TField);
begin
  if not Sender.IsNull then
    R180OraValidate(Sender.AsString);
end;

procedure TA020FCausPresenzeMW.selT277FASCE_PNValidate(Sender: TField);
begin
  if (Sender.AsString <> 'S') and (Sender.AsString <> 'N') then
    raise Exception.Create(A000MSG_A020_ERR_VALORI_AMMESSI_SN);
end;

procedure TA020FCausPresenzeMW.selT277NewRecord(DataSet: TDataSet);
begin
  selT277.FieldByName('Codice').AsString:=selT275.FieldByName('Codice').AsString;
end;

procedure TA020FCausPresenzeMW.selT277TIPO_GIORNOValidate(Sender: TField);
begin
  if Assigned(CheckTipoGiorno) then
    CheckTipoGiorno(selT277.FieldByName('TIPO_GIORNO').AsString);
end;

end.
