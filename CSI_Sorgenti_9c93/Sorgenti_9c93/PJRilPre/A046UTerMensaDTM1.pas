unit A046UTerMensaDTM1;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, A000UCostanti, A000USessione,A000UInterfaccia, RegistrazioneLog, OracleData, Oracle,
  C180FunzioniGenerali, Variants, ControlloVociPaghe;

type
  TA046FTerMensaDTM1 = class(TDataModule)
    Q360TerMensa: TOracleDataSet;
    I: TStringField;
    Q360TerMensaDIFFTRA2TIMB: TDateTimeField;
    Q360TerMensaTIMBANTECENTRATA: TStringField;
    Q360TerMensaTIMBDOPOUSCITA: TStringField;
    Q360TerMensaCONTROLLOPRESENZA: TStringField;
    Q360TerMensaINTERVALLO: TStringField;
    Q360TerMensaPAUSAMENSAGESTITA: TStringField;
    Q360TerMensaPRESENZAMINIMA: TStringField;
    Q360TerMensaVOCEPAGHE1: TStringField;
    Q360TerMensaVOCEPAGHE2: TStringField;
    Q360TerMensaORARIOSPEZZATO: TStringField;
    Q360TerMensaCAUSALE: TStringField;
    Q360TerMensaCENA_DALLE: TStringField;
    Q360TerMensaCENA_ALLE: TStringField;
    Q360TerMensaMENSA_STIMBRATA: TStringField;
    Q360TerMensaMENSA_NON_STIMBRATA: TStringField;
    Q360TerMensaORE_MINIME: TStringField;
    Q360TerMensaMENSA_STIMBRATA_INTERO: TStringField;
    Q360TerMensaMENSA_NON_STIMBRATA_INTERO: TStringField;
    Q360TerMensaTIMBANTECENTRATA_INTERO: TStringField;
    Q360TerMensaTIMBDOPOUSCITA_INTERO: TStringField;
    Q360TerMensaCONTROLLOPRESENZA_INTERO: TStringField;
    Q360TerMensaORARIOSPEZZATO_INTERO: TStringField;
    Q360TerMensaPAUSAMENSAGESTITA_INTERO: TStringField;
    Q360TerMensaPRESENZAMINIMA_INTERO: TStringField;
    Q360TerMensaINTERVALLO_INTERO: TStringField;
    Q360TerMensaORE_MINIME_INTERO: TStringField;
    Q360TerMensaALIMENTA_BUONIPASTO: TStringField;
    Q360TerMensaCODICE: TStringField;
    selInterfaccia: TOracleDataSet;
    dsrInterfaccia: TDataSource;
    Q360TerMensaD_CODICE: TStringField;
    Q360TerMensaMATURA_BUONO: TStringField;
    Q360TerMensaMATURA_BUONO_INTERO: TStringField;
    Q360TerMensaMENSA_DALLE: TStringField;
    Q360TerMensaMENSA_ALLE: TStringField;
    Q360TerMensaINTERVALLO_PM_INTERO: TStringField;
    procedure Q360TerMensaCalcFields(DataSet: TDataSet);
    procedure Q360TerMensaDIFFTRA2TIMBGetText(Sender: TField; var Text: string;
      DisplayText: Boolean);
    procedure A046FTerMensaDTM1Create(Sender: TObject);
    procedure A046FTerMensaDTM1Destroy(Sender: TObject);
    procedure Q360TerMensaAfterPost(DataSet: TDataSet);
    procedure Q360TerMensaAfterCancel(DataSet: TDataSet);
    procedure Q360TimbMensaNewRecord(DataSet: TDataSet);
    procedure BDEQ360TerMensaDIFFTRA2TIMBSetText(Sender: TField;
      const Text: String);
    procedure Q360TerMensaBeforePost(DataSet: TDataSet);
    procedure Q360TerMensaINTERVALLOValidate(Sender: TField);
    procedure Q360TerMensaCENA_DALLEValidate(Sender: TField);
    procedure Q360TerMensaBeforeDelete(DataSet: TDataSet);
    procedure Q360TerMensaAfterDelete(DataSet: TDataSet);
  private
    { Private declarations }
    selControlloVociPaghe:TControlloVociPaghe;
  public
    { Public declarations }
  end;

var
  A046FTerMensaDTM1: TA046FTerMensaDTM1;

implementation

uses A046UTerMensa;

{$R *.DFM}

procedure TA046FTerMensaDTM1.A046FTerMensaDTM1Create(Sender: TObject);
var i:Integer;
begin
  if not(SessioneOracle.Connected) then
  begin
    Password(Application.Name);
    A000ParamDBOracle(SessioneOracle);
  end;
  for i:=0 to Self.ComponentCount - 1 do
  begin
    if Components[i] is TOracleQuery then
      (Components[i] as TOracleQuery).Session:=SessioneOracle;
    if Components[i] is TOracleDataSet then
      (Components[i] as TOracleDataSet).Session:=SessioneOracle;
  end;
  selControlloVociPaghe:=TControlloVociPaghe.Create(Self,'');
  if A000LookupTabella(Parametri.CampiRiferimento.C18_AccessiMensa,selInterfaccia) then
  begin
    if selInterfaccia.VariableIndex('DECORRENZA') >= 0 then
      selInterfaccia.SetVariable('DECORRENZA',EncodeDate(3999,12,31));
    selInterfaccia.Open;
  end
  else
    A046FTerMensa.lblInterfaccia.Caption:='<INTERFACCIA UNICA>';
end;

procedure TA046FTerMensaDTM1.A046FTerMensaDTM1Destroy(Sender: TObject);
begin
  FreeAndNil(selControlloVociPaghe);
  Q360TerMensa.Close;
end;

procedure TA046FTerMensaDTM1.Q360TerMensaAfterPost(DataSet: TDataSet);
begin
  SessioneOracle.ApplyUpDates([Q360TerMensa],True);
  SessioneOracle.Commit;
  RegistraLog.RegistraOperazione;
end;

procedure TA046FTerMensaDTM1.Q360TerMensaAfterCancel(DataSet: TDataSet);
begin
  Q360TerMensa.CancelUpDates;
  SessioneOracle.Commit;
end;

procedure TA046FTerMensaDTM1.Q360TerMensaAfterDelete(DataSet: TDataSet);
begin
  SessioneOracle.ApplyUpDates([Q360TerMensa],True);
  RegistraLog.RegistraOperazione;
  SessioneOracle.Commit;
end;

procedure TA046FTerMensaDTM1.Q360TimbMensaNewRecord(DataSet: TDataSet);
begin
  Q360TerMensa.FieldByName('DiffTra2Timb').AsDateTime:=0;
end;

procedure TA046FTerMensaDTM1.BDEQ360TerMensaDIFFTRA2TIMBSetText(Sender: TField;
  const Text: String);
begin
  {$I CampoOra}
end;

procedure TA046FTerMensaDTM1.Q360TerMensaBeforeDelete(DataSet: TDataSet);
begin
  RegistraLog.SettaProprieta('C',R180Query2NomeTabella(DataSet),Copy(Name,1,4),DataSet,True);
end;

procedure TA046FTerMensaDTM1.Q360TerMensaBeforePost(DataSet: TDataSet);
var VoceOld:String;
begin
  if (not Q360TerMensaCena_Dalle.IsNull) or (not Q360TerMensaCena_Alle.IsNull) then
    if R180OreMinutiExt(Q360TerMensaCena_Dalle.AsString) > R180OreMinutiExt(Q360TerMensaCena_Alle.AsString) then
      raise Exception.Create('L''intervallo della Cena non è corretto!');
  //Controllo voci paghe
  if (DataSet.State = dsInsert) or (Q360TerMensa.FieldByName('VOCEPAGHE1').medpOldValue = null) then
    VoceOld:=''
  else
    VoceOld:=Q360TerMensa.FieldByName('VOCEPAGHE1').medpOldValue;
  if not selControlloVociPaghe.ControlloVociPaghe(VoceOld,Q360TerMensa.FieldByName('VOCEPAGHE1').AsString) then
    if R180MessageBox(selControlloVociPaghe.MessaggioLog,'DOMANDA') = mrNo then
      Abort
    else
      selControlloVociPaghe.ValutaInserimentoVocePaghe(Q360TerMensa.FieldByName('VOCEPAGHE1').AsString);

  if (DataSet.State = dsInsert) or (Q360TerMensa.FieldByName('VOCEPAGHE2').medpOldValue = null) then
    VoceOld:=''
  else
    VoceOld:=Q360TerMensa.FieldByName('VOCEPAGHE2').medpOldValue;
  if not selControlloVociPaghe.ControlloVociPaghe(VoceOld,Q360TerMensa.FieldByName('VOCEPAGHE2').AsString) then
    if R180MessageBox(selControlloVociPaghe.MessaggioLog,'DOMANDA') = mrNo then
      Abort
    else
      selControlloVociPaghe.ValutaInserimentoVocePaghe(Q360TerMensa.FieldByName('VOCEPAGHE2').AsString);
  case DataSet.State of
    dsInsert:RegistraLog.SettaProprieta('I',R180Query2NomeTabella(DataSet),Copy(Name,1,4),DataSet,True);
    dsEdit:RegistraLog.SettaProprieta('M',R180Query2NomeTabella(DataSet),Copy(Name,1,4),DataSet,True);
  end;
  if A046FTerMensa.lblInterfaccia.Caption = '<INTERFACCIA UNICA>' then
    Q360TerMensa.FieldByName('CODICE').AsString:='<UNICA>';
end;

procedure TA046FTerMensaDTM1.Q360TerMensaINTERVALLOValidate(
  Sender: TField);
begin
  if Not(Sender.IsNull) then
    R180OraValidate(Sender.AsString);
end;

procedure TA046FTerMensaDTM1.Q360TerMensaCENA_DALLEValidate(
  Sender: TField);
begin
  if not Sender.IsNull then
    R180OraValidate(Sender.AsString);
end;

procedure TA046FTerMensaDTM1.Q360TerMensaDIFFTRA2TIMBGetText(Sender: TField;
  var Text: string; DisplayText: Boolean);
begin
  if Sender.IsNull then Text:='' else Text:=FormatDateTime('hh:nn',Sender.AsDateTime);
end;

procedure TA046FTerMensaDTM1.Q360TerMensaCalcFields(DataSet: TDataSet);
begin
  if selInterfaccia.Active then
    Q360TerMensa.FieldByName('D_CODICE').AsString:=varToStr(selInterfaccia.Lookup('CODICE',Q360TerMensa.FieldByName('CODICE').AsString,'DESCRIZIONE'))
  else
    Q360TerMensa.FieldByName('D_CODICE').AsString:='<INTERFACCIA UNICA>';
  A046FTerMensa.lblInterfaccia.Caption:=Q360TerMensa.FieldByName('D_CODICE').AsString;
end;

end.
