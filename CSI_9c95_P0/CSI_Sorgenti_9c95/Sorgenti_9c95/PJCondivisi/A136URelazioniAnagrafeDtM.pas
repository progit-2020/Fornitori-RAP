unit A136URelazioniAnagrafeDtM;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, R004UGESTSTORICODTM, DB, OracleData, Oracle, DBClient, A000UCostanti, A000USessione,
  A000UInterfaccia, C015UElencoValori, C180FunzioniGenerali, Provider, StrUtils,
  A136URelazioniAnagrafeMW,A000UMessaggi;

type
  TA136FRelazioniAnagrafeDtM = class(TR004FGestStoricoDtM)
    selI030: TOracleDataSet;
    selI030TABELLA: TStringField;
    selI030COLONNA: TStringField;
    selI030DECORRENZA: TDateTimeField;
    selI030DECORRENZA_FINE: TDateTimeField;
    selI030ORDINE: TIntegerField;
    selI030TIPO: TStringField;
    selI030TAB_ORIGINE: TStringField;
    selI030D_TIPO: TStringField;
    selI030COL_ORIGINE: TStringField;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
    procedure selI030AfterScroll(DataSet: TDataSet);
    procedure selI030AfterCancel(DataSet: TDataSet);
    procedure AfterPost(DataSet: TDataSet); override;
    procedure BeforePost(DataSet: TDataSet); override;
    procedure selI030TABELLAValidate(Sender: TField);
    procedure selI030TIPOValidate(Sender: TField);
    procedure selI030COLONNAValidate(Sender: TField);
    procedure BeforeInsert(DataSet: TDataSet); override;
    procedure BeforeDelete(DataSet: TDataSet); override;
    procedure selI030AfterInsert(DataSet: TDataSet);
    procedure selI030TAB_ORIGINEValidate(Sender: TField);
    procedure selI030CalcFields(DataSet: TDataSet);
  private
    { Private declarations }
    DuplicaRelazione:String;
  public
    A136FRelazioniAnagrafeMW : TA136FRelazioniAnagrafeMW;
  end;

var
  A136FRelazioniAnagrafeDtM: TA136FRelazioniAnagrafeDtM;

implementation

uses A136URelazioniAnagrafe, A136UComposizioneRelazione;

{$R *.dfm}

procedure TA136FRelazioniAnagrafeDtM.DataModuleCreate(Sender: TObject);
begin
  inherited;
  A136FRelazioniAnagrafeMW:=TA136FRelazioniAnagrafeMW.Create(Self);
  A136FRelazioniAnagrafeMW.selI030_Funzioni:=selI030;
  A136FRelazioniAnagrafeMW.A136ImpostaMsgWarning:=A136FRelazioniAnagrafe.ImpostaMsgWarning;
  InterfacciaR004:=A136FRelazioniAnagrafe.InterfacciaR004;
  InizializzaDataSet(selI030,[evBeforeEdit,
                              evBeforeInsert,
                              evBeforePost,
                              evBeforeDelete,
                              evAfterDelete,
                              evAfterPost,
                              evOnNewRecord,
                              evOnTranslateMessage]);
  InterfacciaR004.OttimizzaStorico:=False;
  A136FRelazioniAnagrafe.DButton.DataSet:=selI030;
  selI030.Open;
end;

procedure TA136FRelazioniAnagrafeDtM.DataModuleDestroy(Sender: TObject);
begin
  inherited;
  selI030.Close;
end;

procedure TA136FRelazioniAnagrafeDtM.selI030AfterCancel(DataSet: TDataSet);
begin
  inherited;
  A136FRelazioniAnagrafeDtM.selI030AfterScroll(DataSet);
end;

procedure TA136FRelazioniAnagrafeDtM.selI030AfterInsert(DataSet: TDataSet);
begin
  inherited;
  if InterfacciaR004.StoricizzazioneInCorso then
  begin
    A136FRelazioniAnagrafe.memRelazione.Lines.BeginUpdate;
    A136FRelazioniAnagrafe.memRelazione.Lines.Text:=DuplicaRelazione;
    A136FRelazioniAnagrafe.memRelazione.Lines.EndUpdate;
  end;
end;

procedure TA136FRelazioniAnagrafeDtM.AfterPost(DataSet: TDataSet);
begin
  A136FRelazioniAnagrafeMW.InserisciI035(A136FRelazioniAnagrafe.memRelazione.Lines);
  inherited;
end;

procedure TA136FRelazioniAnagrafeDtM.selI030AfterScroll(DataSet: TDataSet);
begin
  inherited;
  if not InterfacciaR004.StoricizzazioneInCorso then
  begin
    A136FRelazioniAnagrafeMW.SettaselI035;
    with A136FRelazioniAnagrafeMW.selI035 do
    begin
      A136FRelazioniAnagrafe.memRelazione.Clear;
      A136FRelazioniAnagrafe.memRelazione.Lines.BeginUpdate;
      while not Eof do
      begin
        A136FRelazioniAnagrafe.memRelazione.Lines.Add(FieldByName('RELAZIONE').AsString);
        Next;
      end;
      A136FRelazioniAnagrafe.memRelazione.Lines.EndUpdate;
    end;
  end;
  A136FRelazioniAnagrafe.AbilitaComponenti;
end;


procedure TA136FRelazioniAnagrafeDtM.selI030CalcFields(DataSet: TDataSet);

begin
  inherited;
  A136FRelazioniAnagrafeMW.ImpostaDescTipo;
  A136FRelazioniAnagrafeMW.ImpostaColonnaOrigine;
end;

procedure TA136FRelazioniAnagrafeDtM.selI030COLONNAValidate(Sender: TField);
begin
  inherited;
  with A136FRelazioniAnagrafeMW do
  begin
    SelCols.Close;
    SelCols.SetVariable('TABELLA',selI030.FieldByName('TABELLA').AsString);
    SelCols.Open;
    if VarToStr(SelCols.Lookup('COLUMN_NAME',Sender.AsString,'COLUMN_NAME')) <> Sender.AsString then
      raise Exception.Create('Selezionare un valore dalla lista!');
    if not VerificaCampiAbilitati(SolaLettura) then
      raise Exception.Create(A000MSG_A136_ERR_UTENTE_NO_CAMPO);
  end;
end;

procedure TA136FRelazioniAnagrafeDtM.selI030TABELLAValidate(Sender: TField);
begin
  inherited;
  if Sender.AsString <> UpperCase(Sender.AsString) then
    Sender.AsString:=UpperCase(Sender.AsString);
  if A136FRelazioniAnagrafe.dgrdRelazioni.Columns[0].PickList.IndexOf(Sender.AsString) < 0 then
    raise Exception.Create('Selezionare un valore dalla lista!');
  selI030.FieldByName('TAB_ORIGINE').AsString:=Sender.AsString;
end;

procedure TA136FRelazioniAnagrafeDtM.selI030TAB_ORIGINEValidate(Sender: TField);
begin
  inherited;
  if Sender.AsString <> UpperCase(Sender.AsString) then
    Sender.AsString:=UpperCase(Sender.AsString);
  if A136FRelazioniAnagrafe.dgrdRelazioni.Columns[6].PickList.IndexOf(Sender.AsString) < 0 then
    raise Exception.Create('Selezionare un valore dalla lista!');
  if (selI030.FieldByName('TIPO').AsString = 'F') and
     (Sender.AsString <> selI030.FieldByName('TABELLA').AsString) then
    raise Exception.Create(A000MSG_A136_ERR_TAB_DIVERSE);
end;

procedure TA136FRelazioniAnagrafeDtM.selI030TIPOValidate(Sender: TField);
var
  s: String;
begin
  inherited;
  if Sender.AsString <> UpperCase(Sender.AsString) then
    Sender.AsString:=UpperCase(Sender.AsString);
  if Sender.AsString = 'S' then
    s:='S - Assegnazione automatica vincolata'
  else if Sender.AsString = 'L' then
    s:='L - Assegnazione automatica libera'
  else if Sender.AsString = 'F' then
    s:='F - Assegnazione filtrata';
  if A136FRelazioniAnagrafe.dgrdRelazioni.Columns[4].PickList.IndexOf(s) < 0 then
    raise Exception.Create('Selezionare un valore dalla lista!');  
  if (Sender.AsString = 'F') and
     (selI030.FieldByName('TAB_ORIGINE').AsString <> selI030.FieldByName('TABELLA').AsString) then
    raise Exception.Create(A000MSG_A136_ERR_TAB_DIVERSE);
end;

procedure TA136FRelazioniAnagrafeDtM.BeforeInsert(DataSet: TDataSet);
begin
  inherited;
  if InterfacciaR004.StoricizzazioneInCorso then
    DuplicaRelazione:=A136FRelazioniAnagrafe.memRelazione.Lines.Text;
end;

procedure TA136FRelazioniAnagrafeDtM.BeforeDelete(DataSet: TDataSet);
begin
  inherited;
  if not A136FRelazioniAnagrafeMW.VerificaCampiAbilitati(SolaLettura) then
    raise Exception.Create('Profilo utente non abilitato alla cancellazione di una relazione con il campo selezionato!');
  A136FRelazioniAnagrafe.memRelazione.Clear;
end;

procedure TA136FRelazioniAnagrafeDtM.BeforePost(DataSet: TDataSet);
begin
  if selI030.State <> dsEdit then
    exit;
  inherited;
  A136FRelazioniAnagrafeMW.CancellaI035;
end;

end.
