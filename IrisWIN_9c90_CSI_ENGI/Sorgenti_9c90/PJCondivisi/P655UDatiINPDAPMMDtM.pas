unit P655UDatiINPDAPMMDtM;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  DB, A000UCostanti, A000USessione, A000UInterfaccia,  RegistrazioneLog, OracleData, Oracle,
  R004UGestStoricoDtM, C700USelezioneAnagrafe, C180FUNZIONIGENERALI, P999UGenerale, Variants,
  P655UDatiINPDAPMMMW;

type
  TP655FDatiINPDAPMMDtM = class(TR004FGestStoricoDtM)
    P662: TOracleDataSet;
    selP663_ID: TOracleDataSet;
    P662DATA_FINE_PERIODO: TDateTimeField;
    P662CHIUSO: TStringField;
    P662DATA_CHIUSURA: TDateTimeField;
    P662NOME_FLUSSO: TStringField;
    P662ID_FLUSSO: TFloatField;
    DselP660: TDataSource;
    procedure DataModuleCreate(Sender: TObject);
    procedure P662NewRecord(DataSet: TDataSet);
    procedure P662AfterScroll(DataSet: TDataSet);
    procedure BeforeDelete(DataSet: TDataSet); override;
    procedure AfterPost(DataSet: TDataSet); override;
    procedure DataModuleDestroy(Sender: TObject);
  private
    procedure P663NewRecord(DataSet: TDataSet);
    procedure P663VALORESetText(Sender: TField; const Text: String);
    { Private declarations }
  public
    P655FDatiINPDAPMMMW: TP655FDatiINPDAPMMMW;
  end;

var
  P655FDatiINPDAPMMDtM: TP655FDatiINPDAPMMDtM;

implementation

uses P655UDatiINPDAPMM;

{$R *.DFM}


procedure TP655FDatiINPDAPMMDtM.DataModuleCreate(Sender: TObject);
begin
  inherited;
  InizializzaDataSet(P662,[evBeforeEdit,
                           evBeforeInsert,
                           evBeforePostNoStorico,
                           evBeforeDelete,
                           evAfterDelete,
                           evAfterPost,
                           evOnTranslateMessage]);
  P655FDatiINPDAPMMMW:=TP655FDatiINPDAPMMMW.Create(Self);
  P655FDatiINPDAPMMMW.SelP662_Funzioni:=P662;
  P655FDatiINPDAPMMMW.ImpostaSelP660(P655FDatiINPDAPMM.sPb_NomeFlusso);
  P655FDatiINPDAPMMMW.P663.OnNewRecord:=P663NewRecord;
  P655FDatiINPDAPMMMW.P663.FieldByName('VALORE').OnSetText:=P663VALORESetText;
  DselP660.DataSet:=P655FDatiINPDAPMMMW.selP660;
  P662.SetVariable('NOMEFLUSSO',P655FDatiINPDAPMM.sPb_NomeFlusso);
  P662.Open;
  with P655FDatiINPDAPMM do
    DButton.DataSet:=P662;
  P662.Last;
  P662.SearchRecord('DATA_FINE_PERIODO',P662.FieldByName('DATA_FINE_PERIODO').AsDateTime,[srFromBeginning]);
end;

procedure TP655FDatiINPDAPMMDtM.DataModuleDestroy(Sender: TObject);
begin
  FreeAndNil(P655FDatiINPDAPMMMW);
  inherited;
end;

procedure TP655FDatiINPDAPMMDtM.P662NewRecord(DataSet: TDataSet);
begin
  inherited;
  selP663_ID.Close;
  selP663_ID.Open;
  P662.FieldByName('ID_FLUSSO').AsInteger:=selP663_ID.FieldByName('NEXTVAL').AsInteger;
  P662.FieldByName('NOME_FLUSSO').AsString:=P655FDatiINPDAPMM.sPb_NomeFlusso;
  P662.FieldByName('DATA_FINE_PERIODO').AsDateTime:=R180FineMese(Parametri.DataLavoro);
end;

procedure TP655FDatiINPDAPMMDtM.P662AfterScroll(DataSet: TDataSet);
begin
  inherited;
  //Leggo il dettaglio dei dati del INPDAPMM
  P655FDatiINPDAPMMMW.LeggoDettaglioINPDAPMM(P655FDatiINPDAPMM.sPb_NomeFlusso,P655FDatiINPDAPMM.rgpTipoDati.ItemIndex,P655FDatiINPDAPMM.rgpTipoRecord.ItemIndex);

  //Disabilito la variazione nel caso di INPDAPMM chiuso
  P655FDatiINPDAPMM.AbilitazioniComponenti;
end;

procedure TP655FDatiINPDAPMMDtM.AfterPost(DataSet: TDataSet);
//Refresh con posizionamento sul record modificato
var ID:String;
begin
  ID:=P662.RowID;
  P662.Refresh;
  P662.Locate('RowID',ID,[]);
end;

procedure TP655FDatiINPDAPMMDtM.BeforeDelete(
  DataSet: TDataSet);
begin
  P655FDatiINPDAPMMMW.P662BeforeDelete;
end;

procedure TP655FDatiINPDAPMMDtM.P663NewRecord(DataSet: TDataSet);
begin
  P655FDatiINPDAPMMMW.P663NewRecord(P655FDatiINPDAPMM.rgptipodati.ItemIndex);
end;

procedure TP655FDatiINPDAPMMDtM.P663VALORESetText(Sender: TField;
  const Text: String);
var
  valoreFormattato, msg: String;
begin
  if Trim(Text) <> '' then
  begin
    msg:=P655FDatiINPDAPMMMW.ImpostaValore(P655FDatiINPDAPMMMW.P663.FieldByName('PARTE').AsString,P655FDatiINPDAPMMMW.P663.FieldByName('NUMERO').AsString,Text,valoreFormattato);
    Sender.AsString:=valoreFormattato;
    if msg <> '' then
       R180MessageBox(msg, INFORMA);
  end;
end;
end.

