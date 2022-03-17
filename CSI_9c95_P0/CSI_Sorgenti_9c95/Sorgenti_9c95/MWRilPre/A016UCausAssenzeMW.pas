unit A016UCausAssenzeMW;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, R005UDataModuleMW, DB, OracleData,
  A000UCostanti, A000USessione, A000UInterfaccia, A000UMessaggi,
  C180FunzioniGenerali, ControlloVociPaghe, DBClient;

type
  TA016VisualizzaTab = procedure (TabIndex:Integer) of object;

  TA016FCausAssenzeMW = class(TR005FDataModuleMW)
    selAssDaValidare: TOracleDataSet;
    selT265T275: TOracleDataSet;
    Q305: TOracleDataSet;
    Q275: TOracleDataSet;
    selP200: TOracleDataSet;
    dsrP200: TDataSource;
    QCols: TOracleDataSet;
    DCols: TDataSource;
    Q265A: TOracleDataSet;
    D265A: TDataSource;
    Q265B: TOracleDataSet;
    Q265BCODICE: TStringField;
    Q265BDESCRIZIONE: TStringField;
    Q265BCODRAGGR: TStringField;
    selT266: TOracleDataSet;
    selT266CODICE: TStringField;
    selT266ID: TStringField;
    selT266NUMGG: TFloatField;
    selT266CAUSALI: TStringField;
    dsrT266: TDataSource;
    Q260: TOracleDataSet;
    D260: TDataSource;
    selVSource: TOracleDataSet;
    selT259: TOracleDataSet;
    dsrT259: TDataSource;
    selT259CODICE: TStringField;
    selT259TIPO_CONTROLLO: TStringField;
    selT259SEX_FRUITORE: TStringField;
    selT259CAU_INCOMPATIBILE: TStringField;
    selT259SEX_CAU_INCOMP: TStringField;
    selT259INCLUDI_FAM: TStringField;
    procedure InizializzaDataSet;
    procedure selT266NUMGGValidate(Sender: TField);
    procedure QCollegamentiAfterOpen(DataSet: TDataSet);
    procedure Q265BFilterRecord(DataSet: TDataSet; var Accept: Boolean);
    procedure FiltroDizionario(DataSet: TDataSet; var Accept: Boolean);
    procedure DataModuleDestroy(Sender: TObject);
    procedure selT259NewRecord(DataSet: TDataSet);
    procedure selT259BeforePost(DataSet: TDataSet);
  private
    OldCod:Char;
    VecchioCodiceDizionario:String;
  public
    T265:TOracleDataSet;
    T265State:TDataSetState;
    VisualizzaTab:TA016VisualizzaTab;
    SelControlloVociPaghe: TControlloVociPaghe;
    D_Incomp_Caus:array of TItemsValues;
    procedure CaricaListaCausIncomp;
    procedure T265AfterPost;
    procedure T265OnNewRecord;
    procedure T265AfterScroll;
    procedure VerificaDatiInseriti;
    procedure VerificaTipoCumulo;
    procedure AllineaFieldTipoCumulo(Cod :Char);
    procedure Competenza1Validate(Sender: TField);
    procedure GMCumuloValidate(Sender: TField);
    procedure HMaxUnitarioValidate(Sender: TField);
    procedure CodCauInizioValidate(Sender: TField);
    procedure GMaxUnitarioValidate(Sender: TField);
    procedure ORESETTValidate(Sender: TField);
    procedure FRUIZ_MINValidate(Sender: TField);
    procedure CM_DEBSETTValidate(Sender: TField);
    procedure HMAssenzaGetText(Sender: TField; var Text: string; DisplayText: Boolean);
    const
      D_CopriGGNonLav:array[0..2] of TItemsValues = (
        (Item:'Non estende il periodo';                     Value:'N'),
        (Item:'Estende se non è nuovo periodo';             Value:'S'),
        (Item:'Estende sempre il periodo';                  Value:'E')
        );
      D_FruizioneFamiliari:array[0..2] of TItemsValues = (
        (Item:'No';              Value:'N'),
        (Item:'Data nasc./adoz.';Value:'S'),
        (Item:'Data nasc.';      Value:'D')
        );
      D_ModRecupero:array[0..5] of TItemsValues = (
        (Item:'Nessun recupero';                            Value:'0'),
        (Item:'Anno precedente e anno corrente (Comp-Liq)'; Value:'PC'),
        (Item:'Anno precedente e anno corrente (Liq-Comp)'; Value:'PL'),
        (Item:'Anno corrente (Comp-Liq)';                   Value:'AC'),
        (Item:'Anno corrente (Liq-Comp)';                   Value:'AL'),
        (Item:'Banca ore residua (Comp)';                   Value:'BO')
        );
      D_DetReperib:array[0..5] of TItemsValues = (
        (Item:'No';                             Value:'0'),
        (Item:'Si';                             Value:'1'),
        (Item:'Turni diurni e entr. notturni';  Value:'4'),
        (Item:'Turni diurni e usc.  notturni';  Value:'5'),
        (Item:'Solo su turni diurni';           Value:'2'),
        (Item:'Solo fruiz. dalle..alle';        Value:'3')
        );
      D_InfCont:array[0..6] of TItemsValues = (
        (Item:'Aumenta le ore lavorate';                                  Value:'A'),
        (Item:'Aumenta le ore lav. fino a completare il debito';          Value:'G'),
        (Item:'Aumenta ore rese da assenza fino a completare il debito';  Value:'I'),
        (Item:'Lascia inalterate le ore lavorate';                        Value:'B'),
        (Item:'Aumenta le ore lav. ma ininfl. ai fini retrib.';           Value:'C'),
        (Item:'Diminuisce le ore lavorate';                               Value:'D'),
        (Item:'Aumenta le ore lav. ma solo compensabili';                 Value:'H')
        );
      D_Cumulo: array [0..20] of TItemsValues = (
        (Item:'H - Nessun cumulo';                                                          Value:'H'),
        (Item:'A - Inizio anno solare';                                                     Value:'A'),
        (Item:'B - A partire dalla data di assunzione';                                     Value:'B'),
        (Item:'C - All''indietro dalla data di fine assenza';                               Value:'C'),
        (Item:'D - A partire da una certa data espressa in giorno e mese';                  Value:'D'),
        (Item:'E - A partire da inizio mese';                                               Value:'E'),
        (Item:'F - A partire dall''ultimo giorno di assenza con causale o data figlio';     Value:'F'),
        (Item:'G - Come ''F'' ma periodicità annuale';                                      Value:'G'),
        (Item:'I - All''indietro dalla data di inizio assenza';                             Value:'I'),
        (Item:'L - Periodo in inserimento';                                                 Value:'L'),
        (Item:'M - Anno solare con maturazione competenze proporzionata ad ore lavorate';   Value:'M'),
        (Item:'N - Anno solare con competenze relative al residuo anno precedente';         Value:'N'),
        (Item:'O - All''indietro dalla data di inizio periodo assenza continuativo';        Value:'O'),
        (Item:'P - Anno solare con competenze relative alle festività lavorate';            Value:'P'),
        (Item:'Q - Anno solare con competenze relative ai giorni non lavorativi';           Value:'Q'),
        (Item:'R - Anno solare con competenze relative alla modalità di recupero';          Value:'R'),
        (Item:'S - Anno solare con competenze maturate da causali specifiche';              Value:'S'),
        (Item:'T - Periodico con competenze maturate da causale specifica';                 Value:'T'),
        (Item:'U - Anno solare con competenze relative alle festività infrasettimanali';    Value:'U'),
        (Item:'V - Anno solare con competenze maturate da turni di reperibilità';           Value:'V'),
        (Item:'Z - Personalizzato';                                                         Value:'Z')
        );
      D_Incomp_TipoContr:array[0..1] of TItemsValues = (
        (Item:'A - Stesso giorno per stesso figlio';  Value:'A'),
        (Item:'B - Stesso mese per stesso figlio';    Value:'B')
        );
      D_Incomp_Genere:array[0..2] of TItemsValues = (
        (Item:'M - Maschile';     Value:'M'),
        (Item:'F - Femminile';    Value:'F'),
        (Item:'I - Ininfluente';  Value:'I')
        );
      D_Incomp_InclFam:array[0..2] of TItemsValues = (
        (Item:'S - Includi assenze del familiare';  Value:'S'),
        (Item:'N - Solo assenze del dipendente';    Value:'N'),
        (Item:'F - Solo assenze del familiare';     Value:'F')
        );
  end;



implementation

{$R *.dfm}

procedure TA016FCausAssenzeMW.InizializzaDataSet;
begin
  OldCod:=#0;
  Q260.Open;
  Q265A.Open;
  Q265B.Open;
  Q275.Open;
  selT265T275.Open;
  Q305.Open;
  QCols.Open;
  SelP200.Open;
  SelControlloVociPaghe:=TControlloVociPaghe.Create(Self,'');
end;

procedure TA016FCausAssenzeMW.DataModuleDestroy(Sender: TObject);
begin
  FreeAndNil(SelControlloVociPaghe);
  inherited;
end;

procedure TA016FCausAssenzeMW.Q265BFilterRecord(DataSet: TDataSet; var Accept: Boolean);
{Filtro la query in modo da non avere le causali col raggruppamento corrente}
begin
  Accept:=Q265B.FieldByName('CodRaggr').AsString <> T265.FieldByName('CodRaggr').AsString;
end;

procedure TA016FCausAssenzeMW.QCollegamentiAfterOpen(DataSet: TDataSet);
begin
  try
    DataSet.FieldByName('CODICE').DisplayWidth:=8;
  except
  end;
end;

procedure TA016FCausAssenzeMW.selT259BeforePost(DataSet: TDataSet);
  procedure CtrlCampoIncomp(Campo,Titolo:String;Lista:array of TItemsValues);
  var i:Integer;
      Trov:Boolean;
  begin
    selT259.FieldByName(Campo).AsString:=Trim(selT259.FieldByName(Campo).AsString);
    if selT259.FieldByName(Campo).AsString = '' then
      raise exception.Create(Format(A000MSG_ERR_FMT_DATO_NON_VALORIZZATO,[Titolo]));
    Trov:=False;
    for i:=0 to High(Lista) do
      if selT259.FieldByName(Campo).AsString = Lista[i].Value then
        Trov:=True;
    if (not Trov)
    and (Campo = 'CAU_INCOMPATIBILE')
    and (selT259.FieldByName('CODICE').AsString <> '')
    and (selT259.FieldByName(Campo).AsString = selT259.FieldByName('CODICE').AsString) then
      Trov:=True;
    if not Trov then
      raise exception.Create(Format(A000MSG_ERR_FMT_DATO_ELEM_LISTA,[Titolo]));
  end;
begin
  inherited;
  CtrlCampoIncomp('TIPO_CONTROLLO','Tipo',D_Incomp_TipoContr);
  CtrlCampoIncomp('SEX_FRUITORE','Genere',D_Incomp_Genere);
  CtrlCampoIncomp('CAU_INCOMPATIBILE','Caus. incomp.',D_Incomp_Caus);
  CtrlCampoIncomp('SEX_CAU_INCOMP','Genere incomp.',D_Incomp_Genere);
  CtrlCampoIncomp('INCLUDI_FAM','Incl. fam.',D_Incomp_InclFam);
end;

procedure TA016FCausAssenzeMW.selT259NewRecord(DataSet: TDataSet);
begin
  inherited;
  selT259.FieldByName('CODICE').AsString:=T265.FieldByName('CODICE').AsString;
end;

procedure TA016FCausAssenzeMW.selT266NUMGGValidate(Sender: TField);
begin
  if not Sender.IsNull then
    if Sender.AsFloat <= 0 then
      raise Exception.Create(A000MSG_A016_ERR_MASSIMALE);
end;

procedure TA016FCausAssenzeMW.FiltroDizionario(DataSet: TDataSet;var Accept: Boolean);
begin
  if DataSet = T265 then
    Accept:=A000FiltroDizionario('CAUSALI ASSENZA',DataSet.FieldByName('CODICE').AsString)
  else if DataSet = Q260 then
    Accept:=A000FiltroDizionario('RAGGRUPPAMENTI ASSENZA',DataSet.FieldByName('CODICE').AsString);
end;

procedure TA016FCausAssenzeMW.T265AfterPost;
var S:String;
    i:Integer;
begin
  with selT266 do
  begin
    ReadOnly:=False;
    DisableControls;
    First;
    i:=0;
    while not Eof do
    begin
      Edit;
      FieldByName('CODICE').AsString:=T265.FieldByName('CODICE').AsString;
      FieldByName('ID').AsString:=IntToStr(i);
      Post;
      inc(i);
      Next;
    end;
    SessioneOracle.ApplyUpdates([selT266],True);
    ReadOnly:=True;
    EnableControls;
  end;
  SessioneOracle.ApplyUpdates([selT259],True);
  with T265 do
  begin
    S:=FieldByName('CODICE').AsString;
    A000AggiornaFiltroDizionario('CAUSALI ASSENZA',VecchioCodiceDizionario,S);
    DisableControls;
    Refresh;
    EnableControls;
    Locate('Codice',S,[]);
  end;
end;

procedure TA016FCausAssenzeMW.T265OnNewRecord;
begin
  OldCod:=#0;
end;

procedure TA016FCausAssenzeMW.T265AfterScroll;
begin
  selT259.Close;
  selT259.SetVariable('CODICE',T265.FieldByName('CODICE').AsString);
  selT259.Open;
end;

procedure TA016FCausAssenzeMW.VerificaDatiInseriti;
{Controllo che il codice non sia già usato da altre causali}
begin
  if T265.State = dsEdit then
    VecchioCodiceDizionario:=VarToStr(T265.FieldByName('CODICE').medpOldValue)
  else
    VecchioCodiceDizionario:='';
  if QueryPK1.EsisteChiave('T265_CAUASSENZE',T265.RowId,T265.State,['CODICE'],[T265.FieldByName('Codice').AsString]) then
    raise Exception.Create(A000MSG_ERR_CODICE_ESISTENTE);
  Q275.Close;
  Q275.SetVariable('Codice',T265.FieldByName('Codice').AsString);
  Q275.Open;
  if Q275.RecordCount > 0 then
    raise Exception.Create(A000MSG_ERR_CODICE_PRES_DUPLICATO);
  Q305.Close;
  Q305.SetVariable('Codice',T265.FieldByName('Codice').AsString);
  Q305.Open;
  if Q305.RecordCount > 0 then
    raise Exception.Create(A000MSG_A016_ERR_CODICE_GIUST_DUPLICATO);
  if (not T265.FieldByName('Fruiz_Min').IsNull) and (not T265.FieldByName('Fruiz_Arr').IsNull) then
    if R180OreMinutiExt(T265.FieldByName('Fruiz_Min').AsString) mod R180OreMinutiExt(T265.FieldByName('Fruiz_Arr').AsString) > 0 then
    begin
      if Assigned(VisualizzaTab) then
        VisualizzaTab(2);
      T265.FieldByName('Fruiz_Min').FocusControl;
      raise Exception.Create(A000MSG_A016_ERR_ARROTONDAMENTO);
    end;
  if (not T265.FieldByName('OREGG_MAX_INF6').IsNull and T265.FieldByName('OREGG_MAX_SUP6').IsNull)
  or (not T265.FieldByName('OREGG_MAX_SUP6').IsNull and T265.FieldByName('OREGG_MAX_INF6').IsNull) then
  begin
    if Assigned(VisualizzaTab) then
      VisualizzaTab(1);
    T265.FieldByName('OREGG_MAX_SUP6').FocusControl;
    raise Exception.Create(A000MSG_A016_ERR_MAX_PER_LAVORATO);
  end
  else if R180OreMinutiExt(T265.FieldByName('OREGG_MAX_INF6').AsString) > R180OreMinutiExt(T265.FieldByName('OREGG_MAX_SUP6').AsString) then
  begin
    if Assigned(VisualizzaTab) then
      VisualizzaTab(1);
    T265.FieldByName('OREGG_MAX_SUP6').FocusControl;
    raise Exception.Create(A000MSG_A016_ERR_SUP6_MINORE_INF6);
  end;
  if T265.FieldByName('TIPOCUMULO').AsString = 'H' then
    T265.FieldByName('CAUSALE_SUCCESSIVA').Clear
  else if (T265.FieldByName('TIPOCUMULO').AsString = 'B') and T265.FieldByName('DURATACUMULO').IsNull then
    raise Exception.Create(A000MSG_A016_ERR_DURATANULLA);
  if T265.FieldByName('CODICE').AsString = T265.FieldByName('CAUSALE_SUCCESSIVA').AsString then
  begin
    if Assigned(VisualizzaTab) then
      VisualizzaTab(2);
    T265.FieldByName('CAUSALE_SUCCESSIVA').FocusControl;
    raise Exception.Create(A000MSG_A016_ERR_CAUS_SUCCESSIVA);
  end;
  if (T265.FieldByName('Fruizione').AsString = 'S') and
     (T265.FieldByName('Fruizione_Familiari').AsString = 'N') and
     (T265.FieldByName('CodCauFruizione').IsNull) then
    raise Exception.Create(A000MSG_A016_ERR_PERIODO_CAUSALE);
  if T265.FieldByName('ALLARME_FRUIZIONE_CONTINUATIVA').AsFloat < 0 then
  begin
    if Assigned(VisualizzaTab) then
      VisualizzaTab(4);
    T265.FieldByName('ALLARME_FRUIZIONE_CONTINUATIVA').FocusControl;
    raise Exception.Create(A000MSG_A016_ERR_NUM_GIORNI);
  end;
end;

procedure TA016FCausAssenzeMW.VerificaTipoCumulo;
begin
  if (T265.FieldByName('TipoCumulo').AsString = 'R') and (T265.FieldByName('TipoRecupero').AsString = '0') then
    raise Exception.Create(A000MSG_A016_ERR_TIPO_CUMULO_R);
  if (T265.FieldByName('TipoCumulo').AsString = 'N') and (T265.FieldByName('UMisura').AsString <> 'O') then
    T265.FieldByName('UMisura').AsString:='O';
  if (T265.FieldByName('TipoCumulo').AsString = 'M') and (T265.FieldByName('UMisura').AsString <> 'O') then
    T265.FieldByName('UMisura').AsString:='O';
  if (T265.FieldByName('TipoCumulo').AsString = 'P') and (T265.FieldByName('UMisura').AsString <> 'G') then
    T265.FieldByName('UMisura').AsString:='G';
  if (T265.FieldByName('TipoCumulo').AsString = 'Q') and (T265.FieldByName('UMisura').AsString <> 'G') then
    T265.FieldByName('UMisura').AsString:='G';
  if R180CarattereDef(T265.FieldByName('Cumulo_Familiari').AsString,1,'N') in ['S','D'] then
    T265.FieldByName('CodCauInizio').Clear;
  if R180CarattereDef(T265.FieldByName('Fruizione_Familiari').AsString,1,'N') in ['S','D'] then
    T265.FieldByName('CodCauFruizione').Clear;
end;

procedure TA016FCausAssenzeMW.HMAssenzaGetText(Sender: TField; var Text: string; DisplayText: Boolean);
begin
  if Sender.IsNull then
    Text:=''
  else
    Text:=FormatDateTime('hh:nn',Sender.AsDateTime);
end;

procedure TA016FCausAssenzeMW.Competenza1Validate(Sender: TField);
{Controllo sui dati competenze: i giorno possono avere la parte dedcimale .5
 e le ore possono avere i minuti < 60}
begin
  if T265.FieldByName('UMisura').AsString = 'G' then
  begin
    if ((Copy(Sender.AsString,5,1) <> '5')) and ((Trim(Copy(Sender.AsString,5,1)) <> '')) then
      raise Exception.Create(A000MSG_ERR_DECIMALI_GIORNI);
  end
  else
    if (Copy(Sender.AsString,6,2) > '59') then
      raise Exception.Create(A000MSG_ERR_MINUTI);
end;

procedure TA016FCausAssenzeMW.GMCumuloValidate(Sender: TField);
{Controllo validita' giorno mese}
begin
  if Sender.IsNull then
    exit;
  try
    StrToDate(Sender.AsString + '/1996');
  except
    raise Exception.Create(A000MSG_ERR_GIORNO_MESE);
  end;
end;

procedure TA016FCausAssenzeMW.CodCauInizioValidate(Sender: TField);
{Non si può mettere la stessa causale il 'Codice' e 'Causale inizio cumulo'}
begin
  if (T265.FieldByName('Codice').AsString <> '')
  and (Sender.AsString = T265.FieldByName('Codice').AsString) then
    raise Exception.Create(A000MSG_A016_ERR_IMPOSSIBILE_CUMULARE);
end;

procedure TA016FCausAssenzeMW.HMaxUnitarioValidate(Sender: TField);
{Controllo Max unitario in Ore}
begin
  if (Copy(Sender.AsString,6,2) > '59') then
    raise Exception.Create(A000MSG_ERR_MINUTI);
end;

procedure TA016FCausAssenzeMW.GMaxUnitarioValidate(Sender: TField);
{Controllo Max unitario in Giorni}
begin
  if (Copy(Sender.AsString,6,1) <> '5') and (Trim(Copy(Sender.AsString,6,1)) <> '') then
    raise Exception.Create(A000MSG_ERR_DECIMALI_GIORNI);
end;

procedure TA016FCausAssenzeMW.ORESETTValidate(Sender: TField);
{Controllo Maturazione ore settimanale}
begin
  if (Copy(Sender.AsString,4,2) > '59') then
    raise Exception.Create(A000MSG_ERR_MINUTI);
end;

procedure TA016FCausAssenzeMW.FRUIZ_MINValidate(Sender: TField);
begin
  if Sender.IsNull then
    exit;
  R180OraValidate(Sender.AsString);
end;

procedure TA016FCausAssenzeMW.AllineaFieldTipoCumulo(Cod :Char);
begin
  if (T265.State in [dsInsert,dsEdit])
  and (Cod <> OldCod) then
  begin
    if Cod in ['D'] then
      T265.FieldByName('DurataCumulo').AsInteger:=1;
    if Cod in ['B','D','G'] then
      T265.FieldByName('UMCumulo').AsString:='A';
    if Cod in ['T'] then
      T265.FieldByName('UMCumulo').AsString:='M';
    (*Alberto 17/07/2018: non pulisco più i campi in modo che non si perdano le regole modificando il tipo cumulo
    if not(Cod in ['B','C','D','G','I','O']) then
      T265.FieldByName('DurataCumulo').Clear;
    if not (Cod in ['D']) then
      T265.FieldByName('GMCumulo').Clear;
    *)
    if not(Cod in ['F','G']) then
    begin
      T265.FieldByName('CodCauInizio').Clear;
      T265.FieldByName('Cumulo_Familiari').AsString:='N';
    end;
    if (Cod in ['N']) then
      T265.FieldByName('UMisura').AsString:='O';
  end;
  OldCod:=Cod;
end;

procedure TA016FCausAssenzeMW.CM_DEBSETTValidate(Sender: TField);
begin
  if not Sender.IsNull then
    OreMinutiValidate(Sender.AsString);
end;

procedure TA016FCausAssenzeMW.CaricaListaCausIncomp;
var i:Integer;
begin
  SetLength(D_Incomp_Caus,0);
  with Q265A do
  begin
    Refresh;
    First;
    while not Eof do
    begin
      SetLength(D_Incomp_Caus,Length(D_Incomp_Caus) + 1);
      i:=High(D_Incomp_Caus);
      D_Incomp_Caus[i].Item:=FieldByName('CODICE').AsString + ' - ' + FieldByName('DESCRIZIONE').AsString;
      D_Incomp_Caus[i].Value:=FieldByName('CODICE').AsString;
      Next;
    end;
  end;
end;

end.
