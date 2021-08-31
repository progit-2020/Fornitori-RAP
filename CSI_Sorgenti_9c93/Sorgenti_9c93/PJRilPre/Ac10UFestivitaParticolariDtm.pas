unit Ac10UFestivitaParticolariDtm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, R004UGestStoricoDTM, Data.DB,
  OracleData, Ac10UFestivitaParticolariMW, Vcl.ComCtrls, Datasnap.DBClient,
  C180FunzioniGenerali, Oracle, A000UCostanti, A000UInterfaccia;

type
  TAc10FFestivitaParticolariDtm = class(TR004FGestStoricoDtM)
    selCSI010Master: TOracleDataSet;
    selCSI010MasterTIPO_FESTIVITA: TStringField;
    selCSI010MasterFILTRO_ANAGRA: TStringField;
    selCSI010MasterTIPO_RECORD: TStringField;
    selCSI010MasterCODIZIONE_APPLIC: TStringField;
    selCSI010MasterINIZIO_SCELTA: TDateTimeField;
    selCSI010MasterDATA_FESTIVITA: TDateTimeField;
    selCSI010MasterFINE_SCELTA: TDateTimeField;
    selCSI010MasterFLAG_SCELTA: TStringField;
    selCSI010MasterSCELTE_POSSIBILI: TStringField;
    selCSI010MasterSCELTA_EFFETTUATA: TStringField;
    selCSI010MasterCOMP_NOSCELTA: TStringField;
    selCSI010MasterCAUS_INSERT: TStringField;
    selCSI010MasterCAUS_INCOMP: TStringField;
    selCSI010MasterCAUS_SOSTIT: TStringField;
    selCSI010MasterCOMP_CAUSSOST: TStringField;
    selCSI010MasterPROGRESSIVO: TFloatField;
    selCSI010Detail: TOracleDataSet;
    selCSI010DetailPROGRESSIVO: TFloatField;
    selCSI010DetailDATA_FESTIVITA: TDateTimeField;
    selCSI010DetailTIPO_FESTIVITA: TStringField;
    selCSI010DetailFILTRO_ANAGRA: TStringField;
    selCSI010DetailTIPO_RECORD: TStringField;
    selCSI010DetailCONDIZIONE_APPLIC: TStringField;
    selCSI010DetailDATA_SCELTA: TDateTimeField;
    selCSI010DetailINIZIO_SCELTA: TDateTimeField;
    selCSI010DetailFINE_SCELTA: TDateTimeField;
    selCSI010DetailFLAG_SCELTA: TStringField;
    selCSI010DetailSCELTE_POSSIBILI: TStringField;
    selCSI010DetailSCELTA_EFFETTUATA: TStringField;
    selCSI010DetailCOMP_NOSCELTA: TStringField;
    selCSI010DetailCAUS_INSERT: TStringField;
    selCSI010DetailCAUS_INCOMP: TStringField;
    selCSI010DetailCAUS_SOSTIT: TStringField;
    selCSI010DetailCOMP_CAUSSOST: TStringField;
    dsrSelCSI10Detail: TDataSource;
    selCSI010DetailMATRICOLA: TStringField;
    selCSI010DetailCOGNOME: TStringField;
    selCSI010DetailNOME: TStringField;
    selCSI010DetailSCELTA_DEFINITIVA: TStringField;
    procedure DataModuleCreate(Sender: TObject);
    procedure BeforePostNoStorico(DataSet: TDataSet); override;
    procedure DataModuleDestroy(Sender: TObject);
    procedure selCSI010MasterAfterScroll(DataSet: TDataSet);
    procedure selCSI010MasterAfterInsert(DataSet: TDataSet);
    procedure selCSI010DetailBeforeInsert(DataSet: TDataSet);
    procedure selCSI010DetailBeforeDelete(DataSet: TDataSet);
  private
    { Private declarations }
    ModificaCancella:Boolean;
  public
    { Public declarations }
    Ac10MW:TAc10FFestivitaParticolariMW;
    function OpenSelCSI010Detail(dData:TDateTime;TipoFest,TipoRecord,sFiltro:string):integer;
    procedure FiltraCSI010Detail;
    procedure AbilitazioniSelCSI010Master;
    procedure AbilitazioniTFest(Inibisci:Boolean);
  end;

var
  Ac10FFestivitaParticolariDtm: TAc10FFestivitaParticolariDtm;

implementation

uses
  Ac10UFestivitaParticolari;

{$R *.dfm}

procedure TAc10FFestivitaParticolariDtm.DataModuleCreate(Sender: TObject);
begin
  inherited;
  ModificaCancella:=False;
  InizializzaDataSet(selCSI010Master,[evBeforePostNoStorico]);
  Ac10MW:=TAc10FFestivitaParticolariMW.Create(Self);
  selCSI010Master.Open;
  Ac10MW.OpenSelT265Ins('','');
  FiltraCSI010Detail;
end;

procedure TAc10FFestivitaParticolariDtm.DataModuleDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(Ac10MW);
end;

procedure TAc10FFestivitaParticolariDtm.AbilitazioniTFest(Inibisci:Boolean);
begin
  Ac10FFestivitaParticolari.dCmbCausInserimento.Enabled:=not Inibisci and (selCSI010Master.State in [dsInsert,dsEdit]);;
  //Ac10FFestivitaParticolari.dCmbCompCausSost.Enabled:=not Inibisci and (selCSI010Master.State in [dsInsert,dsEdit]);
  Ac10FFestivitaParticolari.btnCausInComp.Enabled:=not Inibisci and (selCSI010Master.State in [dsInsert,dsEdit]);
  //Ac10FFestivitaParticolari.btnCausSostituzione.Enabled:=not Inibisci and (selCSI010Master.State in [dsInsert,dsEdit]);
  if Inibisci then
  begin
    selCSI010Master.FieldByName('CAUS_INSERT').Clear;
    //selCSI010Master.FieldByName('COMP_CAUSSOST').Clear;
    selCSI010Master.FieldByName('CAUS_INCOMP').Clear;
    //selCSI010Master.FieldByName('CAUS_SOSTIT').Clear;
  end;
end;

procedure TAc10FFestivitaParticolariDtm.AbilitazioniSelCSI010Master;
begin
  Ac10FFestivitaParticolari.actCancella.Enabled:=ModificaCancella and (selCSI010Master.State in [dsBrowse]);
  selCSI010Master.FieldByName('DATA_FESTIVITA').ReadOnly:=not ModificaCancella;
  selCSI010Master.FieldByName('FILTRO_ANAGRA').ReadOnly:=not ModificaCancella;
  selCSI010Master.FieldByName('TIPO_FESTIVITA').ReadOnly:=not ModificaCancella;
end;

function TAc10FFestivitaParticolariDtm.OpenSelCSI010Detail(dData:TDateTime;TipoFest,TipoRecord,sFiltro:string):integer;
var
  SQL:string;
begin
  {Inizializzazione query e veriabili di default}
  selCSI010Detail.DeleteVariables;
  selCSI010Detail.SQL.Clear;
  selCSI010Detail.SQL.Add('select T030.COGNOME, T030.NOME, T030.MATRICOLA, CSI010.*, CSI010.rowid');
  selCSI010Detail.SQL.Add('  from CSI010_FESTIVITA_PARTICOLARI CSI010, T030_ANAGRAFICO T030');
  selCSI010Detail.SQL.Add(' where T030.PROGRESSIVO = CSI010.PROGRESSIVO');
  selCSI010Detail.SQL.Add('       :FILTRO');
  selCSI010Detail.SQL.Add(' order by T030.COGNOME, T030.NOME, T030.MATRICOLA desc');
  selCSI010Detail.DeclareVariable('FILTRO',otSubst);
  {Filtro selezione progressivi assegnati}
  SQL:='and CSI010.PROGRESSIVO > 0';
  {Filtro selezione anagrafe}
  SQL:=SQL + ' and CSI010.FILTRO_ANAGRA = :FILTRO_ANAGRA';
  selCSI010Detail.DeclareAndSet('FILTRO_ANAGRA',otString,sFiltro);
  {Filtro per data festività}
  SQL:=SQL + ' and CSI010.DATA_FESTIVITA = :DATA_FESTIVITA';
  selCSI010Detail.DeclareAndSet('DATA_FESTIVITA',otDate,dData);
  {Filtro per tipo festivtà}
  SQL:=SQL + ' and CSI010.TIPO_FESTIVITA = :TIPO_FESTIVITA';
  selCSI010Detail.DeclareAndSet('TIPO_FESTIVITA',otString,TipoFest);
  {Filtro sulla tipologia del record A(automatico),M(Manuale)}
  if not TipoRecord.IsEmpty then
  begin
    SQL:=SQL + ' and CSI010.TIPO_RECORD = :TIPO_RECORD';
    selCSI010Detail.DeclareAndSet('TIPO_RECORD',otString,TipoRecord);
  end;
  selCSI010Detail.SetVariable('FILTRO',SQL);
  //selCSI010Detail.Debug:=DebugHook <> 0;
  selCSI010Detail.Close;
  selCSI010Detail.Open;
  Result:=selCSI010Detail.RecordCount;
end;

procedure TAc10FFestivitaParticolariDtm.FiltraCSI010Detail;
var
  TipoRecord:string;
begin
  TipoRecord:='';
  if Ac10FFestivitaParticolari <> nil then
  begin
    if Ac10FFestivitaParticolari.drgpFiltro.Items[Ac10FFestivitaParticolari.drgpFiltro.ItemIndex] = 'Manuali' then
      TipoRecord:='M'
    else if Ac10FFestivitaParticolari.drgpFiltro.Items[Ac10FFestivitaParticolari.drgpFiltro.ItemIndex] = 'Automatici' then
      TipoRecord:='A';
    selCSI010Detail.ReadOnly:=TipoRecord <> 'M';
  end;
  {Gestione abilitazioni:
    -se DataSet di dettaglio è vuoto permetto la modifica della chiave e la cancellazione del record
    -se contiene almeno un record di tipo 'A' inibisco la modifica della chiave e la cancellazione del record}
  ModificaCancella:=OpenSelCSI010Detail(selCSI010Master.FieldByName('DATA_FESTIVITA').AsDateTime,
                                        selCSI010Master.FieldByName('TIPO_FESTIVITA').AsString,
                                        'A',selCSI010Master.FieldByName('FILTRO_ANAGRA').AsString) <= 0;
  AbilitazioniSelCSI010Master;
  Ac10FFestivitaParticolari.StatusBar.Panels[2].Text:=
    'Numero record dettaglio: ' + OpenSelCSI010Detail(selCSI010Master.FieldByName('DATA_FESTIVITA').AsDateTime,
                                                      Ac10FFestivitaParticolari.dcmbTipoFestivita.Items[Ac10FFestivitaParticolari.dcmbTipoFestivita.ItemIndex],
                                                      TipoRecord,selCSI010Master.FieldByName('FILTRO_ANAGRA').AsString).ToString;
end;

procedure TAc10FFestivitaParticolariDtm.selCSI010DetailBeforeDelete(DataSet: TDataSet);
begin
  inherited;
  Abort;
end;

procedure TAc10FFestivitaParticolariDtm.selCSI010DetailBeforeInsert(DataSet: TDataSet);
begin
  Abort;
  inherited;
end;

procedure TAc10FFestivitaParticolariDtm.selCSI010MasterAfterInsert(
  DataSet: TDataSet);
begin
  inherited;
  ModificaCancella:=True;
  AbilitazioniSelCSI010Master;
end;

procedure TAc10FFestivitaParticolariDtm.selCSI010MasterAfterScroll(DataSet: TDataSet);
begin
  inherited;
  FiltraCSI010Detail;
  Ac10MW.OpenSelT265Ins(selCSI010Master.FieldByName('CAUS_INCOMP').AsString,
                        selCSI010Master.FieldByName('CAUS_SOSTIT').AsString);
end;

procedure TAc10FFestivitaParticolariDtm.BeforePostNoStorico(DataSet: TDataSet);
begin
  inherited;
  {Se tipo festività è diversa da sento patrono:
    - tra le scelte possibili e il "comportamento non scelta" non deve essere presente l'opzione fruizione}
  if (selCSI010Master.FieldByName('TIPO_FESTIVITA').AsString <> 'A') then
  begin
    if selCSI010Master.FieldByName('COMP_NOSCELTA').AsString = 'A' then
      raise Exception.Create(Format('Tipo festività "%s" è incompatibile con l''opzione "Fruizione" nel comportamento no scelta.',[R180ValueToItem(TO_CSI_D_TipoFestivita,selCSI010Master.FieldByName('TIPO_FESTIVITA').AsString)]));
    if pos(',A,',',' + selCSI010Master.FieldByName('SCELTE_POSSIBILI').AsString + ',') > 0 then
      raise Exception.Create(Format('Tipo festività "%s" è incompatibile con l''opzione "Fruizione" tra le scelte possibili.',[R180ValueToItem(TO_CSI_D_TipoFestivita,selCSI010Master.FieldByName('TIPO_FESTIVITA').AsString)]));
  end;

  if (pos(',A,',',' + selCSI010Master.FieldByName('SCELTE_POSSIBILI').AsString + ',') > 0) and
     (selCSI010Master.FieldByName('CAUS_INSERT').isNull) then
    raise Exception.Create('Quando tra le scelte possibili è prevista la fruizione è necessario indicare la causale da inserire nel giorno di fruizione.');
  if selCSI010Master.FieldByName('TIPO_FESTIVITA').IsNull then
    raise Exception.Create('Tipo festività non può essere nulla.');
  //Inizio scelta
  if selCSI010Master.FieldByName('INIZIO_SCELTA').IsNull then
    raise Exception.Create('La data inizio scelta non può essere nulla.');
  if (selCSI010Master.State in [dsInsert]) and (selCSI010Master.FieldByName('INIZIO_SCELTA').AsDateTime < Parametri.DataLavoro) then
    raise Exception.Create('La data inizio scelta non può essere minore dalla data lavoro.');
  if selCSI010Master.FieldByName('FINE_SCELTA').IsNull then
    raise Exception.Create('La data fine scelta non può essere nulla.');
  if selCSI010Master.FieldByName('FINE_SCELTA').AsDateTime < selCSI010Master.FieldByName('INIZIO_SCELTA').AsDateTime then
    raise Exception.Create('La data fine scelta dev''essere maggiore di data inizio scelta.');
  if selCSI010Master.FieldByName('FILTRO_ANAGRA').IsNull or
     (selCSI010Master.FieldByName('FILTRO_ANAGRA').AsString = '*') then
    raise Exception.Create('Il filtro anagrafe non può essere nullo.');
  if (selCSI010Master.FieldByName('FLAG_SCELTA').AsString <> 'N') and (selCSI010Master.FieldByName('SCELTE_POSSIBILI').IsNull) then
    raise Exception.Create('E’ necessario indicare almeno una scelta possibile.');
  if selCSI010Master.FieldByName('COMP_NOSCELTA').IsNull then
    raise Exception.Create('Il comportamento no scelta non può essere nullo.');
  selCSI010Master.FieldByName('TIPO_RECORD').AsString:='A';
  if selCSI010Master.FieldByName('FLAG_SCELTA').AsString = 'N' then
    selCSI010Master.FieldByName('SCELTE_POSSIBILI').Clear;
end;

end.
