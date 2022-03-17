unit W026URichiestaStrGGDM;

interface

uses
  C180FunzioniGenerali,
  SysUtils, Classes, DB, OracleData, Oracle, Math, StrUtils, DBClient;

type
  TW026FRichiestaStrGGDM = class(TDataModule)
    delT325: TOracleQuery;
    selT100B: TOracleDataSet;
    updT100: TOracleQuery;
    insUpdT100: TOracleQuery;
    insT320: TOracleQuery;
    delT320: TOracleQuery;
    selT325Vis: TOracleDataSet;
    cdsT325Vis: TClientDataSet;
    cdsT325VisEU: TClientDataSet;
    cdsT325VisEUD_AUTORIZZAZIONE_E: TStringField;
    cdsT325VisEUD_AUTORIZZAZIONE_U: TStringField;
    cdsT325VisID: TFloatField;
    cdsT325VisID_REVOCA: TFloatField;
    cdsT325VisID_REVOCATO: TFloatField;
    cdsT325VisPROGRESSIVO: TIntegerField;
    cdsT325VisNOMINATIVO: TStringField;
    cdsT325VisMATRICOLA: TStringField;
    cdsT325VisSESSO: TStringField;
    cdsT325VisCOD_ITER: TStringField;
    cdsT325VisTIPO_RICHIESTA: TStringField;
    cdsT325VisAUTORIZZ_AUTOMATICA: TStringField;
    cdsT325VisREVOCABILE: TStringField;
    cdsT325VisDATA_RICHIESTA: TDateTimeField;
    cdsT325VisLIVELLO_AUTORIZZAZIONE: TFloatField;
    cdsT325VisDATA_AUTORIZZAZIONE: TDateTimeField;
    cdsT325VisAUTORIZZAZIONE: TStringField;
    cdsT325VisNOMINATIVO_RESP: TStringField;
    cdsT325VisAUTORIZZ_AUTOM_PREV: TStringField;
    cdsT325VisAUTORIZZ_PREV: TStringField;
    cdsT325VisRESPONSABILE_PREV: TStringField;
    cdsT325VisAUTORIZZ_UTILE: TStringField;
    cdsT325VisAUTORIZZ_REVOCA: TStringField;
    cdsT325VisD_TIPO_RICHIESTA: TStringField;
    cdsT325VisD_RESPONSABILE: TStringField;
    cdsT325VisD_AUTORIZZAZIONE: TStringField;
    cdsT325VisID_T325: TFloatField;
    cdsT325VisDATA: TDateField;
    cdsT325VisTIMBRATURE: TStringField;
    cdsT325VisORE_LORDE: TStringField;
    cdsT325VisORE_CONTEGGIATE: TStringField;
    cdsT325VisC_SPEZ: TStringField;
    cdsT325VisC_SPEZ_MIN: TStringField;
    cdsT325VisC_SPEZ_REC: TStringField;
    cdsT325VisC_SPEZ_PAG: TStringField;
    cdsT325VisDEBITO: TStringField;
    cdsT325VisDETR_MENSA: TStringField;
    cdsT325VisRITARDO: TStringField;
    cdsT325VisTIPO: TStringField;
    cdsT325VisECCEDENZA: TStringField;
    cdsT325VisSPEZ: TStringField;
    cdsT325VisCAUS_ORIG: TStringField;
    cdsT325VisSPEZ_DALLE1: TStringField;
    cdsT325VisSPEZ_ALLE1: TStringField;
    cdsT325VisCAUS1: TStringField;
    cdsT325VisSPEZ_DALLE2: TStringField;
    cdsT325VisSPEZ_ALLE2: TStringField;
    cdsT325VisCAUS2: TStringField;
    cdsT325VisSPEZ_DALLE3: TStringField;
    cdsT325VisSPEZ_ALLE3: TStringField;
    cdsT325VisCAUS3: TStringField;
    cdsT325VisEUID: TFloatField;
    cdsT325VisEUID_REVOCA: TFloatField;
    cdsT325VisEUID_REVOCATO: TFloatField;
    cdsT325VisEUPROGRESSIVO: TIntegerField;
    cdsT325VisEUNOMINATIVO: TStringField;
    cdsT325VisEUMATRICOLA: TStringField;
    cdsT325VisEUSESSO: TStringField;
    cdsT325VisEUCOD_ITER: TStringField;
    cdsT325VisEUTIPO_RICHIESTA: TStringField;
    cdsT325VisEUAUTORIZZ_AUTOMATICA: TStringField;
    cdsT325VisEUREVOCABILE: TStringField;
    cdsT325VisEUDATA_RICHIESTA: TDateTimeField;
    cdsT325VisEULIVELLO_AUTORIZZAZIONE: TFloatField;
    cdsT325VisEUDATA_AUTORIZZAZIONE: TDateTimeField;
    cdsT325VisEUAUTORIZZAZIONE: TStringField;
    cdsT325VisEUNOMINATIVO_RESP: TStringField;
    cdsT325VisEUAUTORIZZ_AUTOM_PREV: TStringField;
    cdsT325VisEUAUTORIZZ_PREV: TStringField;
    cdsT325VisEURESPONSABILE_PREV: TStringField;
    cdsT325VisEUAUTORIZZ_UTILE: TStringField;
    cdsT325VisEUAUTORIZZ_REVOCA: TStringField;
    cdsT325VisEUD_TIPO_RICHIESTA: TStringField;
    cdsT325VisEUD_RESPONSABILE: TStringField;
    cdsT325VisEUD_AUTORIZZAZIONE: TStringField;
    cdsT325VisEUID_T325: TFloatField;
    cdsT325VisEUDATA: TDateField;
    cdsT325VisEUTIMBRATURE: TStringField;
    cdsT325VisEUORE_LORDE: TStringField;
    cdsT325VisEUORE_CONTEGGIATE: TStringField;
    cdsT325VisEUDEBITO: TStringField;
    cdsT325VisEUDETR_MENSA: TStringField;
    cdsT325VisEURITARDO: TStringField;
    cdsT325VisEUTIPO: TStringField;
    cdsT325VisEUCAUS_ORIG: TStringField;
    cdsT325VisTIPO_RIGA: TStringField;
    cdsT325VisRESPONSABILE: TStringField;
    cdsT325VisEUTIPO_RIGA: TStringField;
    cdsT325VisEURESPONSABILE: TStringField;
    cdsT325VisEUSPEZ_E: TStringField;
    cdsT325VisEUECCEDENZA_E: TStringField;
    cdsT325VisEUCAUS1_E: TStringField;
    cdsT325VisEUAUTORIZZAZIONE_E: TStringField;
    cdsT325VisEUSPEZ_U: TStringField;
    cdsT325VisEUECCEDENZA_U: TStringField;
    cdsT325VisEUCAUS1_U: TStringField;
    cdsT325VisEUAUTORIZZAZIONE_U: TStringField;
    cdsT325VisEUSPEZ_ALLE1_U: TStringField;
    cdsT325VisEUSPEZ_DALLE1_E: TStringField;
    cdsT325VisEUSPEZ_ALLE1_E: TStringField;
    cdsT325VisEUSPEZ_DALLE1_U: TStringField;
    selT325Search: TOracleDataSet;
    updT325Orig: TOracleQuery;
    selT325IdOrig: TOracleQuery;
    selT020Scorr: TOracleDataSet;
    selT221: TOracleDataSet;
    selT325: TOracleDataSet;
    FloatField1: TFloatField;
    IntegerField1: TIntegerField;
    DateTimeField1: TDateTimeField;
    StringField1: TStringField;
    StringField2: TStringField;
    StringField3: TStringField;
    StringField4: TStringField;
    StringField5: TStringField;
    StringField6: TStringField;
    selT326: TOracleDataSet;
    FloatField2: TFloatField;
    StringField7: TStringField;
    StringField8: TStringField;
    StringField9: TStringField;
    StringField10: TStringField;
    StringField11: TStringField;
    StringField12: TStringField;
    StringField13: TStringField;
    StringField14: TStringField;
    StringField15: TStringField;
    StringField16: TStringField;
    StringField17: TStringField;
    StringField18: TStringField;
    StringField19: TStringField;
    StringField20: TStringField;
    FloatField3: TFloatField;
    cdsT325VisEUDATA_SPEZ_E: TDateField;
    cdsT325VisEUDATA_SPEZ_U: TDateField;
    cdsT325VisDATA_SPEZ: TDateField;
    selRichiesteGiorno: TOracleQuery;
    selT326DATA_SPEZ: TDateTimeField;
    insT850Man: TOracleQuery;
    selTotAnno: TOracleQuery;
    selTotMese: TOracleQuery;
    selT106: TOracleDataSet;
    cdsT325VisMOTIVAZIONE: TStringField;
    cdsT325VisEUMOTIVAZIONE: TStringField;
    selT326MOTIVAZIONE: TStringField;
    cdsT325VisEUMOTIVAZIONE_E: TStringField;
    cdsT325VisEUMOTIVAZIONE_U: TStringField;
    procedure DataModuleCreate(Sender: TObject);
    procedure selT325AfterPost(DataSet: TDataSet);
    procedure selT325BeforePost(DataSet: TDataSet);
    procedure selT325VisAfterOpen(DataSet: TDataSet);
    procedure selT325VisCalcFields(DataSet: TDataSet);
    procedure selT326AfterPost(DataSet: TDataSet);
    procedure selT326BeforePost(DataSet: TDataSet);
    procedure cdsT325VisCalcFields(DataSet: TDataSet);
    procedure cdsT325VisAfterScroll(DataSet: TDataSet);
  public
    MaxArrotRiepGG: Integer;
  end;

implementation

uses A000UCostanti, A000USessione, A000UInterfaccia;

{$R *.dfm}

procedure TW026FRichiestaStrGGDM.DataModuleCreate(Sender: TObject);
var
  i: Integer;
begin
 try
  for i:=0 to Self.ComponentCount - 1 do
    if Components[i] is TOracleQuery then
      (Components[i] as TOracleQuery).Session:=SessioneOracle
    else if Components[i] is TOracleDataSet then
      (Components[i] as TOracleDataSet).Session:=SessioneOracle
    else if Components[i] is TOracleScript then
      (Components[i] as TOracleScript).Session:=SessioneOracle;

  // imposta costante QVistaOracle
  selT325Vis.SetVariable('QVISTAORACLE',QVistaOracle);
 except
 end;
end;

procedure TW026FRichiestaStrGGDM.cdsT325VisAfterScroll(DataSet: TDataSet);
begin
  // allineamento del TOracleDataset di riferimento (selT325Vis)
  selT325Vis.SearchRecord('ID',DataSet.FieldByName('ID').AsInteger,[srFromBeginning]);
end;

procedure TW026FRichiestaStrGGDM.cdsT325VisCalcFields(DataSet: TDataSet);
var
  DescResp,Aut,Campo,CampoDalle,CampoAlle,CampoCaus,Orario: String;
  i,DalleHMin,AlleHMin,Diff: Integer;
begin
  with TClientDataset(DataSet) do
  begin
    // D_RESPONSABILE: nominativo reale del responsabile oppure nome utente
    if Trim(FieldByName('NOMINATIVO_RESP').AsString) = '' then
      DescResp:=FieldByName('RESPONSABILE').AsString
    else
      DescResp:=FieldByName('NOMINATIVO_RESP').AsString;
    FieldByName('D_RESPONSABILE').AsString:=DescResp;

    // D_AUTORIZZ_E: descr. autorizzazione entrata
    if FindField('AUTORIZZAZIONE_E') <> nil then
    begin
      Aut:=FieldByName('AUTORIZZAZIONE_E').AsString;
      if Aut = 'S' then
        Aut:='Si'
      else if Aut = 'N' then
        Aut:='No'
      else
        Aut:='';
      FieldByName('D_AUTORIZZAZIONE_E').AsString:=Aut;
    end;

    // D_AUTORIZZ_U: descr. autorizzazione uscita
    if FindField('AUTORIZZAZIONE_U') <> nil then
    begin
      Aut:=FieldByName('AUTORIZZAZIONE_U').AsString;
      if Aut = 'S' then
        Aut:='Si'
      else if Aut = 'N' then
        Aut:='No'
      else
        Aut:='';
      FieldByName('D_AUTORIZZAZIONE_U').AsString:=Aut;
    end;

    // TORINO_COMUNE
    if Parametri.CampiRiferimento.C90_W026TipoStraord = 'A' then
    begin
      // D_AUTORIZZAZIONE: descr. autorizzazione
      if FieldByName('AUTORIZZAZIONE').AsString = 'S' then
        Aut:='Si'
      else if FieldByName('AUTORIZZAZIONE').AsString = 'N' then
        Aut:='No'
      else
        Aut:='';
      FieldByName('D_AUTORIZZAZIONE').AsString:=Aut;

      // C_SPEZ: totale ore arrotondato dello spezzone
      Orario:=FieldByName('SPEZ').AsString;
      DalleHMin:=R180OreMinutiExt(Copy(Orario,1,5));
      AlleHMin:=R180OreMinutiExt(Copy(Orario,7,5));
      // corregge periodo dalle - alle
      if AlleHMin < DalleHMin then
        AlleHMin:=AlleHMin + 1440;
      // determina arrotondamento
      Diff:=Trunc(R180Arrotonda(Max(AlleHMin - DalleHMin,0),MaxArrotRiepGG,'D'));
      FieldByName('C_SPEZ').AsString:=IfThen(Diff = 0,'',R180MinutiOre(Diff) + '[' + Orario + ']');

      // C_SPEZ_MIN (totale minuti spezzone arrotondato)
      FieldByName('C_SPEZ_MIN').AsInteger:=Diff;

      // C_SPEZ_REC e C_SPEZ_PAG: spezzoni di recupero / pagamento
      for i:=1 to 2 do
      begin
        Campo:=IfThen(i = 1,'C_SPEZ_REC','C_SPEZ_PAG');
        if FindField(Campo) <> nil then
        begin
          CampoDalle:=Format('SPEZ_DALLE%d',[i]);
          if FieldByName(CampoDalle).IsNull then
            FieldByName(Campo).AsString:=''
          else
          begin
            CampoAlle:=Format('SPEZ_ALLE%d',[i]);
            CampoCaus:=Format('CAUS%d',[i]);
            FieldByName(Campo).AsString:=R180MinutiOre(R180OreMinutiExt(FieldByName(CampoAlle).AsString) - R180OreMinutiExt(FieldByName(CampoDalle).AsString));
            if not FieldByName(CampoCaus).IsNull then
              FieldByName(Campo).AsString:=FieldByName(Campo).AsString +
                                           Format(' (%s)',[FieldByName(CampoCaus).AsString]);
          end;
        end;
      end; // end for
    end;
  end;
end;

procedure TW026FRichiestaStrGGDM.selT325AfterPost(DataSet: TDataSet);
begin
  RegistraLog.RegistraOperazione;
end;

procedure TW026FRichiestaStrGGDM.selT325BeforePost(DataSet: TDataSet);
begin
  RegistraLog.SettaProprieta(IfThen(DataSet.State = dsInsert,'I','M'),R180Query2NomeTabella(DataSet),'W026',DataSet,True);
end;

procedure TW026FRichiestaStrGGDM.selT325VisAfterOpen(DataSet: TDataSet);
begin
  TDateTimeField(selT325Vis.FieldByName('DATA_RICHIESTA')).DisplayFormat:='dd/mm/yyyy hhhh.nn';
end;

procedure TW026FRichiestaStrGGDM.selT325VisCalcFields(DataSet: TDataSet);
var
  DescResp,Aut,Campo,CampoDalle,CampoAlle,CampoCaus,Orario: String;
  i,DalleHMin,AlleHMin,Diff: Integer;
begin
  with selT325Vis do
  begin
    // D_RESPONSABILE: nominativo reale del responsabile oppure nome utente
    if Trim(FieldByName('NOMINATIVO_RESP').AsString) = '' then
      DescResp:=FieldByName('RESPONSABILE').AsString
    else
      DescResp:=FieldByName('NOMINATIVO_RESP').AsString;
    //C018//FieldByName('D_RESPONSABILE').AsString:=DescResp;

    // D_AUTORIZZ_E: descr. autorizzazione entrata
    if FindField('AUTORIZZAZIONE_E') <> nil then
    begin
      Aut:=selT325Vis.FieldByName('AUTORIZZAZIONE_E').AsString;
      if Aut = 'S' then
        Aut:='Si'
      else if Aut = 'N' then
        Aut:='No'
      else
        Aut:='';
      FieldByName('D_AUTORIZZAZIONE_E').AsString:=Aut;
    end;

    // D_AUTORIZZ_U: descr. autorizzazione uscita
    if FindField('AUTORIZZAZIONE_U') <> nil then
    begin
      Aut:=selT325Vis.FieldByName('AUTORIZZAZIONE_U').AsString;
      if Aut = 'S' then
        Aut:='Si'
      else if Aut = 'N' then
        Aut:='No'
      else
        Aut:='';
      FieldByName('D_AUTORIZZAZIONE_U').AsString:=Aut;
    end;

    // TORINO_COMUNE
    if Parametri.CampiRiferimento.C90_W026TipoStraord = 'A' then
    begin
      // D_AUTORIZZAZIONE: descr. autorizzazione
      if FieldByName('AUTORIZZAZIONE').AsString = 'S' then
        Aut:='Si'
      else if FieldByName('AUTORIZZAZIONE').AsString = 'N' then
        Aut:='No'
      else
        Aut:='';
      FieldByName('D_AUTORIZZAZIONE').AsString:=Aut;

      // C_SPEZ: totale ore arrotondato dello spezzone
      Orario:=FieldByName('SPEZ').AsString;
      DalleHMin:=R180OreMinutiExt(Copy(Orario,1,5));
      AlleHMin:=R180OreMinutiExt(Copy(Orario,7,5));
      // corregge periodo dalle - alle
      if AlleHMin < DalleHMin then
        AlleHMin:=AlleHMin + 1440;
      // determina arrotondamento
      Diff:=Trunc(R180Arrotonda(Max(AlleHMin - DalleHMin,0),MaxArrotRiepGG,'D'));
      FieldByName('C_SPEZ').AsString:=IfThen(Diff = 0,'',R180MinutiOre(Diff) + '[' + Orario + ']');

      // C_SPEZ_MIN (totale minuti spezzone arrotondato)
      FieldByName('C_SPEZ_MIN').AsInteger:=Diff;

      // C_SPEZ_REC e C_SPEZ_PAG: spezzoni di recupero / pagamento
      for i:=1 to 2 do
      begin
        Campo:=IfThen(i = 1,'C_SPEZ_REC','C_SPEZ_PAG');
        if FindField(Campo) <> nil then
        begin
          CampoDalle:=Format('SPEZ_DALLE%d',[i]);
          if FieldByName(CampoDalle).IsNull then
            FieldByName(Campo).AsString:=''
          else
          begin
            CampoAlle:=Format('SPEZ_ALLE%d',[i]);
            CampoCaus:=Format('CAUS%d',[i]);
            FieldByName(Campo).AsString:=R180MinutiOre(R180OreMinutiExt(FieldByName(CampoAlle).AsString) - R180OreMinutiExt(FieldByName(CampoDalle).AsString));
            if not FieldByName(CampoCaus).IsNull then
              FieldByName(Campo).AsString:=FieldByName(Campo).AsString +
                                           Format(' (%s)',[FieldByName(CampoCaus).AsString]);
          end;
        end;
      end; // end for
    end;
  end;
end;

procedure TW026FRichiestaStrGGDM.selT326AfterPost(DataSet: TDataSet);
begin
  RegistraLog.RegistraOperazione;
end;

procedure TW026FRichiestaStrGGDM.selT326BeforePost(DataSet: TDataSet);
begin
  RegistraLog.SettaProprieta(IfThen(DataSet.State = dsInsert,'I','M'),R180Query2NomeTabella(DataSet),'W026',DataSet,True);
end;

end.
