unit A080UModConteDtM1;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, A000UCostanti, A000USessione,A000UInterfaccia, RegistrazioneLog, OracleData, Oracle,
  C180FunzioniGenerali, Variants, Math,A000UMessaggi;

type
  TA080FModConteDtM1 = class(TDataModule)
    Q025: TOracleDataSet;
    Q025CODICE: TStringField;
    Q025DESCRIZIONE: TStringField;
    Q025CARTELLINO: TStringField;
    Q025ISTITUTI: TStringField;
    Q025SCOSTSETT: TStringField;
    Q025INDENNITA: TStringField;
    Q025INDPRESENZA: TStringField;
    Q025CONTEGGIO: TIntegerField;
    Q025COMPPREC: TIntegerField;
    Q025LIQPREC: TIntegerField;
    Q025COMPATT: TIntegerField;
    Q025LIQATT: TIntegerField;
    Q025MESISALDOPREC: TIntegerField;
    Q025LIQUIDDISTRIBUITA: TStringField;
    Q025TIPOLIMITECOMPA: TStringField;
    Q025LIMITECOMPA: TStringField;
    Q026: TOracleDataSet;
    Q026CODICE: TStringField;
    Q026ANNO_RIF: TIntegerField;
    Q026MESE_RIF: TIntegerField;
    Q026MESE_ABBATT: TIntegerField;
    D026: TDataSource;
    Q025RECUPERO_SERBATOI: TStringField;
    Q025BANCAORE: TStringField;
    Q025ABBATTIMENTO_LIQUIDABILE: TStringField;
    Q025RECUPERODEBITO_MAX: TStringField;
    Q025PERIODICITA_ABBATTIMENTO: TStringField;
    Q025ABBATTIMENTO_MOBILE_MAX: TStringField;
    Q025ABBATTIMENTO_MOBILE_SALDI: TStringField;
    Q025CAUSALI_COMPENSABILI: TStringField;
    selT275: TOracleDataSet;
    dsrT275: TDataSource;
    Q025RECUPERODEBITO: TIntegerField;
    Q025LIMITE_MM_ECCLIQ_TIPO: TStringField;
    Q025LIMITE_MM_ECCLIQ_DEFAULT: TStringField;
    Q025LIMITE_MM_ECCRES_TIPO: TStringField;
    Q025LIMITE_MM_ECCRES_DEFAULT: TStringField;
    Q025TRASF_SUPERO_LIQANN: TStringField;
    Q025SOGLIA_COMP_LIQ: TStringField;
    Q025SALDO_NEGATIVO_MINIMO: TStringField;
    Q025BANCAORE_RESID: TStringField;
    Q025ABBATT_MOBILE_RIFERIMENTO: TStringField;
    Q025BANCA_ORE_LIMITATA_SALDO_COMP: TStringField;
    Q025BANCA_ORE_LIMITATA_STR_LIQ: TStringField;
    Q025ARR_SOGLIA_COMP_LIQ: TStringField;
    selT265: TOracleDataSet;
    dsrT265: TDataSource;
    Q025RIPOSO_NONFRUITO: TStringField;
    Q025ARRREC_LIQPREC: TStringField;
    Q025ARRREC_COMPATT: TStringField;
    Q025ARRREC_LIQATT: TStringField;
    Q025ARRREC_COMPPREC: TStringField;
    Q025BANCA_ORE_ESCLUSA_ABBATT: TStringField;
    Q025RECUP_STRAORD_PREC: TStringField;
    Q025RIPOSO_RECUPLIQUID: TStringField;
    Q025RECUPERODEBITO_TIPO: TStringField;
    Q025TIPOLIMITECOMPP: TStringField;
    Q025BANCA_ORE_RESID_ANNOPREC: TStringField;
    Q025BANCA_ORE_MENS_ARR: TStringField;
    Q025SALDO_NEGATIVO_MINIMO_TIPO: TStringField;
    Q025ARRREC_SCOSTNEG: TStringField;
    Q025PA_LIMITE: TStringField;
    Q025PA_LIMITESALDOATT: TStringField;
    Q025PA_AZZERAMENTOPERIODICO: TStringField;
    Q025PA_TIPORESIDUO: TStringField;
    Q025BANCA_ORE_ABBATTIBILE: TStringField;
    Q025ABBATT_RIF_COMPENSABILE: TStringField;
    Q025ABBATT_RIF_LIQUIDABILE: TStringField;
    Q025ABBATTIMENTO_FISSO_RECUPERO: TStringField;
    insT026: TOracleQuery;
    Q025CAUSRIPCOM_FASCE: TStringField;
    Q025D_CAUSRIPCOM_FASCE: TStringField;
    Q025D_RIPOSO_NONFRUITO: TStringField;
    Q025DEBAGG_RAPP_ANNO: TStringField;
    Q025DEBAGG_CONSIDERA_OREPREC: TStringField;
    selT950: TOracleDataSet;
    dsrT950: TDataSource;
    Q025PAR_CARTELLINO: TStringField;
    Q025D_PAR_CARTELLINO: TStringField;
    Q025PA_LIMITESALDOPREC: TStringField;
    Q025BANCA_ORE_CONTR_LIQUIDAZ: TStringField;
    Q025RNF_ASSENZE_TOLLERATE: TStringField;
    Q025RNF_FILTRO: TStringField;
    selT265RNF: TOracleDataSet;
    Q025ABBATT_RIF_RECUPERO: TStringField;
    Q025ITER_AUTORIZZATIVO_STR: TStringField;
    selTipiRichStraord: TOracleDataSet;
    dsrTipiRichStraord: TDataSource;
    Q025BANCA_ORE_ESCLUSA_SALDI: TStringField;
    Q025TIPOLIMITECOMP_NOREC: TStringField;
    Q025RECDEBITO_MAXTOLLERATO: TStringField;
    Q025CAUS_RIENTRIOBBL: TStringField;
    selT260: TOracleDataSet;
    dsrT260: TDataSource;
    Q025PA_RAGGR_LIMITE: TStringField;
    Q025PA_RAGGR_LIMITESALDOATT: TStringField;
    Q025PA_RAGGR_LIMITESALDOPREC: TStringField;
    Q025ITER_ECCGG_CHECKSALDO: TStringField;
    Q025CAUSALI_COMPENSABILI_MENSILI: TStringField;
    insT029: TOracleQuery;
    procedure A076FIndGruppoDtM1Create(Sender: TObject);
    procedure Q025AfterCancel(DataSet: TDataSet);
    procedure Q025AfterDelete(DataSet: TDataSet);
    procedure Q025AfterPost(DataSet: TDataSet);
    procedure BDEQ025SCOSTSETTValidate(Sender: TField);
    procedure Q025AfterScroll(DataSet: TDataSet);
    procedure Q025BeforePost(DataSet: TDataSet);
    procedure BDEQ025MESISALDOPRECValidate(Sender: TField);
    procedure A080FModConteDtM1Destroy(Sender: TObject);
    procedure Q025BeforeDelete(DataSet: TDataSet);
    procedure Q025LIMITECOMPAValidate(Sender: TField);
    procedure Q026NewRecord(DataSet: TDataSet);
    procedure Q025PERIODICITA_ABBATTIMENTOValidate(Sender: TField);
    procedure Q025LIQATTValidate(Sender: TField);
    procedure Q025SOGLIA_COMP_LIQValidate(Sender: TField);
    procedure Q025BANCAOREValidate(Sender: TField);
    procedure Q025ARR_SOGLIA_COMP_LIQValidate(Sender: TField);
    procedure Q025CalcFields(DataSet: TDataSet);
    procedure Q025RECUPERODEBITO_MAXValidate(Sender: TField);
    procedure Q025RECDEBITO_MAXTOLLERATOValidate(Sender: TField);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  A080FModConteDtM1: TA080FModConteDtM1;

implementation

uses A080UModConte;

{$R *.DFM}

procedure TA080FModConteDtM1.A076FIndGruppoDtM1Create(Sender: TObject);
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
  selT260.Open;
  selT260.FieldByName('CODICE').DisplayWidth:=7;
  selT265.Open;
  selT265.FieldByName('CODICE').DisplayWidth:=7;
  selT275.Open;
  Q025.Open;
  selTipiRichStraord.Open;
end;

procedure TA080FModConteDtM1.Q025AfterCancel(DataSet: TDataSet);
begin
  Q025.CancelUpdates;
  Q025AfterScroll(Q025);
end;

procedure TA080FModConteDtM1.Q025AfterDelete(DataSet: TDataSet);
begin
  SessioneOracle.ApplyUpdates([Q025],True);
  SessioneOracle.Commit;
  RegistraLog.RegistraOperazione;
end;

procedure TA080FModConteDtM1.Q025AfterPost(DataSet: TDataSet);
var S:String;
begin
  S:=Q025Codice.AsString;
  SessioneOracle.ApplyUpdates([Q025],True);
  RegistraLog.RegistraOperazione;
  Q025.Close;
  Q025.Open;
  Q025.Locate('Codice',S,[]);
end;

procedure TA080FModConteDtM1.BDEQ025SCOSTSETTValidate(Sender: TField);
begin
   if Sender.IsNull then exit;
   if StrToInt(Copy(Sender.AsString,5,2))  > 59 then
     raise Exception.Create('I minuti non possono essere maggiori di 59');
end;

procedure TA080FModConteDtM1.Q025AfterScroll(DataSet: TDataSet);
begin
  A080FModConte.PageControl1.Visible:=Q025.FieldByName('Conteggio').AsInteger = 4;
  with A080FModConte.clstSaldiAbbattibili do
  begin
    //Impostazione di partenza della list box
    if Items[0] = 'Liquidabile' then
      Items.Move(1,0);
    //Lettura dei valori selezionati e ordinamento degli elementi
    Checked[Items.IndexOf('Liquidabile')]:=Pos('L',Q025.FieldByName('ABBATTIMENTO_MOBILE_SALDI').AsString) > 0;
    Checked[Items.IndexOf('Compensabile')]:=Pos('C',Q025.FieldByName('ABBATTIMENTO_MOBILE_SALDI').AsString) > 0;
    if (R180CarattereDef(Q025.FieldByName('ABBATTIMENTO_MOBILE_SALDI').AsString,1,' ') = 'C') and (Items[0] = 'Liquidabile') or
       (R180CarattereDef(Q025.FieldByName('ABBATTIMENTO_MOBILE_SALDI').AsString,1,' ') = 'L') and (Items[0] = 'Compensabile') then
      Items.Move(1,0);
  end;
end;

procedure TA080FModConteDtM1.Q025BeforePost(DataSet: TDataSet);
var V:array[0..4] of Byte;
    i:Byte;
    L1,L2:String;
begin
  if QueryPK1.EsisteChiave('T025_CONTMENSILI',Q025.RowId,Q025.State,['CODICE'],[Q025Codice.AsString]) then
    raise Exception.Create('Elemento già esistente!');
  case DataSet.State of
    dsInsert:RegistraLog.SettaProprieta('I',R180Query2NomeTabella(DataSet),Copy(Name,1,4),DataSet,True);
    dsEdit:RegistraLog.SettaProprieta('M',R180Query2NomeTabella(DataSet),Copy(Name,1,4),DataSet,True);
  end;
  if Q025Conteggio.AsInteger <> 4 then exit;
  for i:=1 to 4 do V[i]:=0;
  inc(V[Q025CompPrec.AsInteger],1);
  inc(V[Q025LiqPrec.AsInteger],1);
  inc(V[Q025CompAtt.AsInteger],1);
  Q025.FieldByName('ABBATTIMENTO_MOBILE_SALDI').AsString:='';
  if R180GetCsvIntersect(Q025.FieldByName('CAUSALI_COMPENSABILI').AsString,Q025.FieldByName('CAUSALI_COMPENSABILI_MENSILI').AsString) <> '' then
    raise Exception.Create(Format(A000MSG_A080_ERR_FMT_CAUS_COMP,[R180GetCsvIntersect(Q025.FieldByName('CAUSALI_COMPENSABILI').AsString,Q025.FieldByName('CAUSALI_COMPENSABILI_MENSILI').AsString)]));
  with A080FModConte.clstSaldiAbbattibili do
    for i:=0 to Items.Count - 1 do
      if Checked[i] then
        if Items[i] = 'Compensabile' then
          Q025.FieldByName('ABBATTIMENTO_MOBILE_SALDI').AsString:=Q025.FieldByName('ABBATTIMENTO_MOBILE_SALDI').AsString + 'C'
        else
          Q025.FieldByName('ABBATTIMENTO_MOBILE_SALDI').AsString:=Q025.FieldByName('ABBATTIMENTO_MOBILE_SALDI').AsString + 'L';
  for i:=1 to 4 do
    if V[i] > 1 then
      raise Exception.Create(A000MSG_A080_ERR_ORDINE_SERBATOI);
  if ((Q025.FieldByName('LIMITE_MM_ECCLIQ_TIPO').AsString = 'EG') and (Q025.FieldByName('LIMITE_MM_ECCRES_TIPO').AsString <> 'EG') or
     (Q025.FieldByName('LIMITE_MM_ECCRES_TIPO').AsString = 'EG') and (Q025.FieldByName('LIMITE_MM_ECCLIQ_TIPO').AsString <> 'EG')) then
    raise Exception.Create(A000MSG_A080_ERR_TIPI_APPLICAZIONE);
  if not Q025.FieldByName('PA_LIMITE').IsNull then
  begin
    L1:=Trim(StringReplace(Q025.FieldByName('PA_LIMITESALDOATT').AsString,'.','',[]));
    L2:=Trim(StringReplace(Q025.FieldByName('PA_LIMITESALDOPREC').AsString,'.','',[]));
    if R180OreMinutiExt(Q025.FieldByName('PA_LIMITE').AsString) <
       min(IfThen(L1 = '',R180OreMinutiExt('9999.59'),R180OreMinutiExt(Q025.FieldByName('PA_LIMITESALDOATT').AsString)),
           IfThen(L2 = '',R180OreMinutiExt('9999.59'),R180OreMinutiExt(Q025.FieldByName('PA_LIMITESALDOPREC').AsString))) then
      raise Exception.Create(A000MSG_A080_ERR_RESID_INFERIORE_LIMITE);
    if R180OreMinutiExt(Q025.FieldByName('PA_LIMITE').AsString) >
       IfThen(L1 = '',R180OreMinutiExt('9999.59'),R180OreMinutiExt(Q025.FieldByName('PA_LIMITESALDOATT').AsString)) +
       IfThen(L2 = '',R180OreMinutiExt('9999.59'),R180OreMinutiExt(Q025.FieldByName('PA_LIMITESALDOPREC').AsString)) then
      raise Exception.Create(A000MSG_A080_ERR_RESID_SUPERIORE_LIMITE);
  end;
  if Q025.FieldByName('ITER_AUTORIZZATIVO_STR').AsString = '' then
    Q025.FieldByName('ITER_AUTORIZZATIVO_STR').AsString:='0';
  //Alberto 28/03/2007
  if (Q025.FieldByName('RECUPERODEBITO').AsInteger > 1) and
     ((Q025.FieldByName('PERIODICITA_ABBATTIMENTO').AsString <> 'M') or (Q025.FieldByName('MESISALDOPREC').AsInteger < 0)) then
    if MessageDlg(A000MSG_A080_DLG_NO_SALDI_MOBILI, mtConfirmation, [mbYes,mbNo],0) <> mrYes then
      Abort;
  if Q025.FieldByName('BANCA_ORE_ESCLUSA_SALDI').AsString = 'S' then
  begin
    Q025.FieldByName('BANCA_ORE_ESCLUSA_ABBATT').ASString:='N';
    Q025.FieldByName('BANCA_ORE_ABBATTIBILE').ASString:='N';
    Q025.FieldByName('BANCA_ORE_LIMITATA_SALDO_COMP').ASString:='N';
  end;
end;

procedure TA080FModConteDtM1.Q025CalcFields(DataSet: TDataSet);
begin
  Q025.FieldByName('D_RIPOSO_NONFRUITO').AsString:=VarToStr(selT265.Lookup('CODICE',Q025.FieldByName('RIPOSO_NONFRUITO').AsString,'DESCRIZIONE'));
  Q025.FieldByName('D_CAUSRIPCOM_FASCE').AsString:=VarToStr(selT275.Lookup('CODICE',Q025.FieldByName('CAUSRIPCOM_FASCE').AsString,'DESCRIZIONE'));
end;

procedure TA080FModConteDtM1.Q025PERIODICITA_ABBATTIMENTOValidate(
  Sender: TField);
begin
  Q025MesiSaldoPrec.OnValidate(Q025MesiSaldoPrec);
end;

procedure TA080FModConteDtM1.Q025RECDEBITO_MAXTOLLERATOValidate(Sender: TField);
begin
  if not Sender.IsNull then
    OreMinutiValidate(Sender.AsString);
end;

procedure TA080FModConteDtM1.Q025RECUPERODEBITO_MAXValidate(Sender: TField);
begin
  if not Sender.IsNull then
    OreMinutiValidate(Sender.AsString);
end;

procedure TA080FModConteDtM1.BDEQ025MESISALDOPRECValidate(Sender: TField);
begin
  if (Q025Periodicita_Abbattimento.AsString = 'F') and (Sender.AsInteger > 0) and (12 mod Sender.AsInteger <> 0) then
  begin
    A080FModConte.dedtMesiSaldoprec.Setfocus;
    raise Exception.Create('I mesi indicati devono essere divisori di 12');
  end;
end;

procedure TA080FModConteDtM1.Q025LIMITECOMPAValidate(Sender: TField);
begin
  if not Sender.IsNull then
    OreMinutiValidate(Sender.AsString);
end;

procedure TA080FModConteDtM1.Q025BeforeDelete(DataSet: TDataSet);
begin
  RegistraLog.SettaProprieta('C',R180Query2NomeTabella(DataSet),Copy(Name,1,4),DataSet,True);
end;

procedure TA080FModConteDtM1.Q026NewRecord(DataSet: TDataSet);
begin
  Q026.FieldByName('Codice').AsString:=Q025.FieldByName('Codice').AsString;
end;

procedure TA080FModConteDtM1.A080FModConteDtM1Destroy(Sender: TObject);
var i:Integer;
begin
  for i:=0 to Self.ComponentCount - 1 do
    if Self.Components[i] is TDataSet then
      (Self.Components[i] as TDataSet).Close;
end;

procedure TA080FModConteDtM1.Q025LIQATTValidate(Sender: TField);
begin
  if (not Sender.IsNull) and (Sender.AsString <> '0') then
    if MessageDlg('L''attivazione del serbatoio ''Liquidabile anno att.'' può comportare la trasformazione di ore liquidabili in ore compensabili, soggette ad eventuali abbattimenti.' + #13 +
                  'Confermare la scelta?',mtConfirmation,[mbYes,mbNo],0) = mrNo then
      Abort;
end;

procedure TA080FModConteDtM1.Q025SOGLIA_COMP_LIQValidate(Sender: TField);
begin
  if not Sender.IsNull then
    OreMinutiValidate(Sender.AsString);
end;

procedure TA080FModConteDtM1.Q025BANCAOREValidate(Sender: TField);
begin
  if Sender.AsString = 'N' then
  begin
    Q025.FieldByName('BANCAORE_RESID').AsString:='N';
    Q025.FieldByName('BANCA_ORE_LIMITATA_SALDO_COMP').AsString:='N';
    Q025.FieldByName('BANCA_ORE_LIMITATA_STR_LIQ').AsString:='N';
  end;
end;

procedure TA080FModConteDtM1.Q025ARR_SOGLIA_COMP_LIQValidate(
  Sender: TField);
begin
  if not Sender.IsNull then
  begin
    R180OraValidate(Sender.AsString);
    if (R180OreMinutiExt(Sender.AsString) <> 0) and (60 mod R180OreMinutiExt(Sender.AsString) > 0) then
      raise Exception.Create('I minuti devono essere divisori di 60!');
  end;
end;

end.
