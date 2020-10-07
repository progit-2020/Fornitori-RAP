unit A065UStampaBudgetDtM;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, R004UGESTSTORICODTM, DB, DBClient, Oracle, OracleData, CheckLst,
  Math, StrUtils, A000UCostanti, A000USessione, A000UInterfaccia, C180FunzioniGenerali,
  A029UBudgetDtM1;

type
  TA065FStampaBudgetDtM = class(TR004FGestStoricoDtM)
    selT071: TOracleDataSet;
    Q730: TOracleDataSet;
    selT713: TOracleDataSet;
    selT714: TOracleDataSet;
    selT275: TOracleDataSet;
    selT275CODICE: TStringField;
    selT275DESCRIZIONE: TStringField;
    selT275ORDINE: TStringField;
    dsrT275: TDataSource;
    cdsApp: TClientDataSet;
    dsrApp: TDataSource;
    selV430: TOracleDataSet;
    selaV430: TOracleDataSet;
    cdsStampa: TClientDataSet;
    selbV430: TOracleDataSet;
    selT074: TOracleDataSet;
    updT714: TOracleQuery;
    procedure DataModuleCreate(Sender: TObject);
    procedure dsrAppDataChange(Sender: TObject; Field: TField);
    procedure DataModuleDestroy(Sender: TObject);
  private
    { Private declarations }
    A029FBudgetDtM1: TA029FBudgetDtM1;
  public
    { Public declarations }
    procedure EseguiFiltroAnagrafeUtente(pAnno,pDaMese,pAMese:Integer);
    procedure StruttureDisponibili(pAnno,pDaMese,pAMese:Integer;TipoBS:String;ListaGruppi:TCheckListBox);
    procedure CreaQueryStampa;
  end;

var
  A065FStampaBudgetDtM: TA065FStampaBudgetDtM;

implementation

{$R *.dfm}

uses A065UStampaBudget;


procedure TA065FStampaBudgetDtM.DataModuleCreate(Sender: TObject);
begin
  inherited;
  cdsApp.CreateDataSet;
  cdsStampa.CreateDataSet;
  selT275.Open;
  A029FBudgetDtM1:=TA029FBudgetDtM1.Create(nil);
end;

procedure TA065FStampaBudgetDtM.DataModuleDestroy(Sender: TObject);
begin
  inherited;
  A029FBudgetDtM1.Free;
end;

procedure TA065FStampaBudgetDtM.dsrAppDataChange(Sender: TObject;
  Field: TField);
begin
  with A065FStampaBudget do
  begin
    if selT275.Active then
      lblDescTipo.Caption:=selT275.FieldByName('DESCRIZIONE').AsString;
    if (VarToStr(dcmbTipo.KeyValue) = '#ECC#') and (cmbDaMese.ItemIndex <> 0) then
    begin
      cmbDaMese.ItemIndex:=0;
      cmbAMeseChange(nil);
    end;
    StruttureDisponibili(Anno,DaMese,AMese,VarToStr(dcmbTipo.KeyValue),clbGruppi);
    AbilitaComponenti;
  end;
end;

procedure TA065FStampaBudgetDtM.EseguiFiltroAnagrafeUtente(pAnno,pDaMese,pAMese:Integer);
var S:String;
begin
  if Trim(Parametri.Inibizioni.Text) <> '' then
  begin
    Screen.Cursor:=crHourGlass;
    if (pAnno > 0) and (pDaMese > 0) and (pAMese > 0) and
       (   (selV430.GetVariable('C700DATADAL') <> EncodeDate(pAnno,pDaMese,1))
        or (selV430.GetVariable('DATALAVORO') <> R180FineMese(EncodeDate(pAnno,pAMese,1)))) then
    begin
      selV430.Close;
      S:=StringReplace(QVistaOracle,
                       ':DataLavoro BETWEEN V430.T430DataDecorrenza AND V430.T430DataFine',
                       ':DATALAVORO >= T430DATADECORRENZA AND :C700DATADAL <= T430DATAFINE',
                       [rfIgnoreCase]);
      S:=StringReplace(S,
                       ':DATALAVORO BETWEEN NVL(P430DECORRENZA,:DATALAVORO) AND NVL(P430DECORRENZA_FINE,:DATALAVORO)',
                       ':DATALAVORO >= NVL(P430DECORRENZA,:DATALAVORO) AND :C700DATADAL <= NVL(P430DECORRENZA_FINE,:C700DATADAL)',
                       [rfIgnoreCase]);
      selV430.SetVariable('QVISTAORACLE',S + #10#13 + QVistaInServizioPeriodica);
      selV430.SetVariable('C700DATADAL',EncodeDate(pAnno,pDaMese,1));
      selV430.SetVariable('DATALAVORO',R180FineMese(EncodeDate(pAnno,pAMese,1)));
      selV430.SetVariable('FILTRO',Parametri.Inibizioni.Text);
      if Pos(':NOME_UTENTE',Parametri.Inibizioni.Text) > 0  then
      begin
        try
          selV430.DeleteVariable('NOME_UTENTE');
        except
        end;
        selV430.DeclareVariable('NOME_UTENTE',otString);
        selV430.SetVariable('NOME_UTENTE',Parametri.Operatore);
      end;
      selV430.Open;
    end;
    Screen.Cursor:=crDefault;
  end;
end;

procedure TA065FStampaBudgetDtM.StruttureDisponibili(pAnno,pDaMese,pAMese:Integer;TipoBS:String;ListaGruppi:TCheckListBox);
//Estrazione delle strutture disponibili per l'operatore (FiltroAnagrafe e anno)
var
  i: Integer;
  FiltroOk: Boolean;
  s,s2,FiltroOld: String;
begin
  if (pAnno > 0) and (pDaMese > 0) and (pAMese > 0) and
     (   (selT713.GetVariable('TIPO') <> TipoBS)
      or (selT713.GetVariable('DADATA') <> EncodeDate(pAnno,pDaMese,1))
      or (selT713.GetVariable('ADATA') <> R180FineMese(EncodeDate(pAnno,pAMese,1)))) then
  begin
    Screen.Cursor:=crHourGlass;
    for i:=0 to ListaGruppi.Items.Count - 1 do
    begin
      if ListaGruppi.Checked[i] then
        s2:=s2 + IfThen(s2 <> '',',') + Copy(ListaGruppi.Items[i],1,22);
    end;
    s2:=',' + s2 + ',';
    selT713.Close;
    selT713.SetVariable('ANNO',pAnno);
    selT713.SetVariable('TIPO',TipoBS);
    selT713.SetVariable('DADATA',EncodeDate(pAnno,pDaMese,1));
    selT713.SetVariable('ADATA',R180FineMese(EncodeDate(pAnno,pAMese,1)));
    selT713.Open;
    ListaGruppi.Items.Clear;
    FiltroOld:='*';
    while not selT713.Eof do
    begin
      FiltroOk:=False;
      if (Trim(Parametri.Inibizioni.Text) <> '')
      and (selT713.FieldByName('FILTRO_ANAGRAFE').AsString <> FiltroOld) then
      begin
        if selV430.Active and (selV430.RecordCount > 0) then
        begin
          selaV430.Close;
          S:=StringReplace(QVistaOracle,
                           ':DataLavoro BETWEEN V430.T430DataDecorrenza AND V430.T430DataFine',
                           ':DATALAVORO >= T430DATADECORRENZA AND :C700DATADAL <= T430DATAFINE',
                           [rfIgnoreCase]);
          S:=StringReplace(S,
                           ':DATALAVORO BETWEEN NVL(P430DECORRENZA,:DATALAVORO) AND NVL(P430DECORRENZA_FINE,:DATALAVORO)',
                           ':DATALAVORO >= NVL(P430DECORRENZA,:DATALAVORO) AND :C700DATADAL <= NVL(P430DECORRENZA_FINE,:C700DATADAL)',
                           [rfIgnoreCase]);
          selaV430.SetVariable('QVISTAORACLE',S + #10#13 + QVistaInServizioPeriodica);
          selaV430.SetVariable('C700DATADAL',EncodeDate(pAnno,pDaMese,1));
          selaV430.SetVariable('DATALAVORO',R180FineMese(EncodeDate(pAnno,pAMese,1)));
          selaV430.SetVariable('FILTRO',selT713.FieldByName('FILTRO_ANAGRAFE').AsString);
          selaV430.Open;
          while not selaV430.Eof do
          begin
            if selV430.SearchRecord('PROGRESSIVO',selaV430.FieldByName('PROGRESSIVO').AsInteger,[srFromBeginning]) then
            begin
              FiltroOk:=True;
              Break;
            end;
            selaV430.Next;
          end;
        end;
        FiltroOld:=selT713.FieldByName('FILTRO_ANAGRAFE').AsString;
      end
      else
        FiltroOk:=True;
      if FiltroOk then
        ListaGruppi.Items.Add(Format('%-10s %-5s %10s %-100s',[selT713.FieldByName('CODGRUPPO').AsString, selT713.FieldByName('TIPO').AsString, FormatDateTime('mm',selT713.FieldByName('DECORRENZA').AsDateTime) + '-' + FormatDateTime('mm/yyyy',selT713.FieldByName('DECORRENZA_FINE').AsDateTime), selT713.FieldByName('DESCRIZIONE').AsString]));
      selT713.Next;
    end;
    for i:=0 to ListaGruppi.Items.Count - 1 do
      ListaGruppi.Checked[i]:=Pos(',' + Copy(ListaGruppi.Items[i],1,22) + ',',s2) > 0;
    Screen.Cursor:=crDefault;
  end;
end;

procedure TA065FStampaBudgetDtM.CreaQueryStampa;
var i,n,RigaMese,MesiPeriodo,OreDiff,OreDiffEcc:Integer;
    CodGruppo,Tipo,OreMese:String;
    Decorrenza,Data,DataMin,DataMax:TDateTime;
    AggOre:Boolean;
begin
  n:=0;
  with A065FStampaBudget.clbGruppi do
    for i:=0 to Count - 1 do
      if Checked[i] then
        inc(n);
  if n = 0 then
  begin
    Screen.Cursor:=crDefault;
    raise exception.create('Selezionare almeno un gruppo!');
  end;
  A065FStampaBudget.ProgressBar1.Max:=n;
  with A065FStampaBudget.clbGruppi do
    for i:=0 to Count - 1 do
    begin
      if Checked[i] then
      begin
        A065FStampaBudget.ProgressBar1.StepBy(1);
        //Prelevo i dati della chiave
        CodGruppo:=Trim(Copy(Items[i],1,10));
        Tipo:=Trim(Copy(Items[i],12,5));
        Decorrenza:=EncodeDate(StrToInt(Trim(Copy(Items[i],24,4))),StrToInt(Trim(Copy(Items[i],18,2))),1);
        if selT713.SearchRecord('CODGRUPPO;TIPO;DECORRENZA',VarArrayOf([CodGruppo,Tipo,Decorrenza]),[srFromBeginning]) then
          with selT714 do
          begin
            if A065FStampaBudget.chkAggiornaFruito.Checked then
            begin
              //Calcolo del fruito
              DataMin:=EncodeDate(A065FStampaBudget.sedtAnno.Value,A065FStampaBudget.DaMese,1);
              DataMax:=EncodeDate(A065FStampaBudget.sedtAnno.Value,A065FStampaBudget.AMese,1);
              Data:=DataMin;
              while Data <= DataMax do
              begin
                A029FBudgetDtM1.AggiornaFruitoBudget(Data,
                                                     Tipo,
                                                     CodGruppo,
                                                     selT713.FieldByName('FILTRO_ANAGRAFE').AsString,
                                                     'O',
                                                     False);
                Data:=R180FineMese(Data) + 1;
              end;
              //Riporto del residuo
              if Tipo = '#ECC#' then
              begin
                DataMax:=EncodeDate(A065FStampaBudget.sedtAnno.Value,12,1);
                Data:=DataMin;
                while Data <= DataMax do
                begin
                  OreDiff:=0;
                  Close;
                  SetVariable('CODGRUPPO',CodGruppo);
                  SetVariable('TIPO',Tipo);
                  SetVariable('DECORRENZA',Decorrenza);
                  SetVariable('MESEDA',R180Mese(selT713.FieldByName('DECORRENZA').AsDateTime));
                  SetVariable('MESEA',R180Mese(selT713.FieldByName('DECORRENZA_FINE').AsDateTime));
                  Open;
                  while not Eof do
                  begin
                    if (EncodeDate(A065FStampaBudget.sedtAnno.Value,selT714.FieldByName('MESE').AsInteger,1) = Data)
                    and (RecNo <> RecordCount) then
                    begin
                      AggOre:=R180OreMinutiExt(FieldByName('ORE_FRUITO').AsString) <> 0;
                      OreDiff:=R180OreMinutiExt(selT713.FieldByName('ORE').AsString) - R180OreMinutiExt(FieldByName('ORE_FRUITO').AsString);
                      OreDiffEcc:=0;
                    end
                    else if (EncodeDate(A065FStampaBudget.sedtAnno.Value,FieldByName('MESE').AsInteger,1) > Data) then
                    begin
                      if RecNo = RecordCount then
                        OreDiffEcc:=OreDiff
                      else
                        OreDiffEcc:=(OreDiff div (R180Mese(selT713.FieldByName('DECORRENZA_FINE').AsDateTime) - R180Mese(Data))) * (FieldByName('MESE').AsInteger - R180Mese(Data));
                      updT714.SetVariable('CODGRUPPO',CodGruppo);
                      updT714.SetVariable('TIPO',Tipo);
                      updT714.SetVariable('DECORRENZA',Decorrenza);
                      updT714.SetVariable('MESE',FieldByName('MESE').AsInteger);
                      updT714.SetVariable('ORE',IfThen(AggOre,QuotedStr(R180MinutiOre(OreDiffEcc)),'ORE'));
                      updT714.SetVariable('IMPORTO','IMPORTO');
                      updT714.Execute;
                    end;
                    Next;
                  end;
                  Data:=R180FineMese(Data) + 1;
                end;
              end;
              SessioneOracle.Commit;
            end;
            MesiPeriodo:=R180Mese(selT713.FieldByName('DECORRENZA_FINE').AsDateTime) - R180Mese(selT713.FieldByName('DECORRENZA').AsDateTime) + 1;
            Close;
            SetVariable('CODGRUPPO',CodGruppo);
            SetVariable('TIPO',Tipo);
            SetVariable('DECORRENZA',Decorrenza);
            SetVariable('MESEDA',A065FStampaBudget.DaMese);
            SetVariable('MESEA',A065FStampaBudget.AMese);
            Open;
            while not Eof do
            begin
              cdsStampa.Append;
              cdsStampa.FieldByName('CODGRUPPO').AsString:=FieldByName('CODGRUPPO').AsString;
              cdsStampa.FieldByName('DECORRENZA').AsString:=FieldByName('DECORRENZA').AsString;
              cdsStampa.FieldByName('MESE').AsString:=FieldByName('MESE').AsString;
              if A065FStampaBudget.rgpTipoBudget.ItemIndex = 0 then
                cdsStampa.FieldByName('ORE').AsString:=FieldByName('ORE').AsString
              else
              begin
                RigaMese:=FieldByName('MESE').AsInteger - R180Mese(selT713.FieldByName('DECORRENZA').AsDateTime) + 1;
                OreMese:=R180MinutiOre(R180OreMinutiExt(selT713.FieldByName('ORE').AsString) div MesiPeriodo);
                if RigaMese = MesiPeriodo then
                begin
                  if FieldByName('TIPO').AsString = '#ECC#' then
                    OreMese:=selT713.FieldByName('ORE').AsString
                  else
                    OreMese:=R180MinutiOre(R180OreMinutiExt(selT713.FieldByName('ORE').AsString) - (R180OreMinutiExt(OreMese) * (MesiPeriodo - 1)));
                end
                else if selT714.FieldByName('TIPO').AsString = '#ECC#' then
                  OreMese:=R180MinutiOre(R180OreMinutiExt(OreMese) * RigaMese);
                cdsStampa.FieldByName('ORE').AsString:=OreMese;
              end;
              cdsStampa.FieldByName('ORE_FRUITO').AsString:=FieldByName('ORE_FRUITO').AsString;
              cdsStampa.FieldByName('ORE_RESIDUO').AsString:=R180MinutiOre(R180OreMinutiExt(cdsStampa.FieldByName('ORE').AsString) - R180OreMinutiExt(cdsStampa.FieldByName('ORE_FRUITO').AsString));
              cdsStampa.Post;
              Next;
            end;
          end;
      end;
    end;
end;

end.
