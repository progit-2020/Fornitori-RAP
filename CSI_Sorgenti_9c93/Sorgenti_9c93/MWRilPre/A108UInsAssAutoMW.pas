unit A108UInsAssAutoMW;

interface

uses
  System.SysUtils, System.Classes, Forms, Oracle, Data.DB, OracleData, Math,
  R005UDataModuleMW, A000UInterfaccia, A000UMessaggi, A000USessione,
  R500Lin, Rp502Pro, R600, C180FunzioniGenerali;

type
  TA108FInsAssAutoMW = class(TR005FDataModuleMW)
    selT045: TOracleDataSet;
    insT040: TOracleQuery;
    delT040: TOracleQuery;
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
  public
    Mese:TDateTime;
    R502ProDtM:TR502ProDtM1;
    R600DtM:TR600DtM1;
    procedure ResetCompensazione(DataRif:TDateTime);
    procedure CompensazioneGiornalieraAutomatica(DataRif:TDateTime);
    function Riposo: Boolean;
    function CalcoloMinutiMancanti:Integer;
    procedure InserimentoMinutiMancanti(Data:TDateTime; Minuti:Integer);
  end;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure TA108FInsAssAutoMW.DataModuleCreate(Sender: TObject);
begin
  if not(SessioneOracle.Connected) then
  begin
    Password(Application.Name);
    A000ParamDBOracle(SessioneOracle);
  end;
  inherited;
  selT045.Open;
end;

procedure TA108FInsAssAutoMW.ResetCompensazione(DataRif:TDateTime);
begin
  //Eliminazione dei giustificativi preesistenti: permesso solo se CAUSALI contiene solo un codice unico
  if selT045.FieldByName('ELIMINA_GIUSTIFICATIVI').AsString = 'S' then
  begin
    delT040.SetVariable('PROGRESSIVO',SelAnagrafe.FieldByName('Progressivo').AsInteger);
    delT040.SetVariable('DATA',R180InizioMese(DataRif));
    delT040.SetVariable('CAUSALE',selT045.FieldByName('CAUSALI').AsString);
    delT040.Execute;
    SessioneOracle.Commit;
  end;
end;

procedure TA108FInsAssAutoMW.CompensazioneGiornalieraAutomatica(DataRif:TDateTime);
var Minuti:Integer;
begin
  R502ProDtM.Conteggi('Cartolina',SelAnagrafe.FieldByName('Progressivo').AsInteger,DataRif);
  if (R502ProDtM.Blocca = 0) and
     (((R502ProDtM.ggvuoto = 0) and (not Riposo)) or
      (selT045.FieldByName('GIORNI_VUOTI').AsString = 'S')) then
  begin
    Minuti:=CalcoloMinutiMancanti;
    if Minuti > 0 then
    begin
      Minuti:=Min(Minuti,R180OreMinutiExt(selT045.FieldByName('ORE_MAX').AsString));
      InserimentoMinutiMancanti(DataRif,Minuti);
    end;
  end;
end;

function TA108FInsAssAutoMW.Riposo:Boolean;
begin
  with R502ProDtM do
  begin
    Result:=(n_timbrdip = 0) and (n_riepasse = 1) and (triepgiusasse[1].tggasse = 1) and
            ((ValStrT265[triepgiusasse[1].tcausasse,'CODINTERNO'] = traggrcausas[5].C) or
             (ValStrT265[triepgiusasse[1].tcausasse,'CODINTERNO'] = traggrcausas[8].C));
    if not Result then
      Result:=(n_timbrdip = 1) and (ttimbraturedip[1].tminutid_e = 0) and
              (n_riepasse = 1) and (triepgiusasse[1].tggasse = 1) and
              ((ValStrT265[triepgiusasse[1].tcausasse,'CODINTERNO'] = traggrcausas[5].C) or
               (ValStrT265[triepgiusasse[1].tcausasse,'CODINTERNO'] = traggrcausas[8].C));
  end;
end;

function TA108FInsAssAutoMW.CalcoloMinutiMancanti:Integer;
var i,j:Integer;
begin
  Result:=0;
  if selT045.FieldByName('DEBITO').AsString = 'A' then
    Result:=R502ProDtM.debitogg - R502ProDtM.totlav
  else if selT045.FieldByName('DEBITO').AsString = 'B' then
    with R502ProDtM do
    begin
      for i:=1 to n_timbrnom do
        for j:=1 to n_timbrdip do
          if ttimbraturedip[j].tpuntnomin = i then
          begin
            //Prima timbratura di quel punto nominale
            if (j = 1) or (ttimbraturedip[j - 1].tpuntnomin <> i) then
              if ttimbraturedip[j].tminutid_e > (ttimbraturenom[i].tminutin_e + ttimbraturenom[i].Flex) then
                inc(Result,ttimbraturedip[j].tminutid_e - (ttimbraturenom[i].tminutin_e + ttimbraturenom[i].Flex));
            //Ultima timbratura di quel punto nominale
            if (j = n_timbrdip) or (ttimbraturedip[j + 1].tpuntnomin <> i) then
              if ttimbraturedip[j].tminutid_u < (ttimbraturenom[i].tminutin_u - ttimbraturenom[i].Flex) then
                inc(Result,(ttimbraturenom[i].tminutin_u  - ttimbraturenom[i].Flex) - ttimbraturedip[j].tminutid_u);
            //Timbrature intermedie per quel punto nominale
            if ttimbraturedip[j + 1].tpuntnomin = i then
              inc(Result,ttimbraturedip[j + 1].tminutid_e - ttimbraturedip[j].tminutid_u);
          end;
    end;
end;

procedure TA108FInsAssAutoMW.InserimentoMinutiMancanti(Data:TDateTime; Minuti:Integer);
var mmInseriti,Residuo,i:Integer;
    G:TGiustificativo;
  function EsisteGiustificativo:Boolean;
  var j:Integer;
  begin
    Result:=False;
    for j:=1 to R502ProDtM.n_giusore do
      if (R502ProDtM.tgius_min[j].tmin = mmInseriti) and (R502ProDtM.tgius_min[j].tcausore = G.Causale) then
      begin
        Result:=True;
        Break;
      end;
  end;
begin
  with TStringList.Create do
  try
    CommaText:=selT045.FieldByName('CAUSALI').AsString;
    for i:=0 to Count - 1 do
    begin
      if Minuti = 0 then Break;
      G.Causale:=Strings[i];
      G.Inserimento:=False;
      G.Modo:='I';
      R600DtM.GetAssenze(SelAnagrafe.FieldByName('Progressivo').AsInteger,Data,R180FineMese(Data),Date,G);
      if R600DtM.TipoCumulo = 'H' then
        mmInseriti:=Minuti
      else
      begin
        Residuo:=0;
        if R600DtM.UMisura = 'O' then
          Residuo:=R180OreMinutiExt(R600DtM.GetResiduo)
        else if R600DtM.ValenzaGiornaliera > 0 then
          Residuo:=Trunc(StrToFloat(R600DtM.GetResiduo) * R600DtM.ValenzaGiornaliera);
        mmInseriti:=Min(Residuo,Minuti);
      end;
      if (mmInseriti > 0) and (not EsisteGiustificativo) then
        with insT040 do
        begin
          SetVariable('PROGRESSIVO',SelAnagrafe.FieldByName('Progressivo').AsInteger);
          SetVariable('DATA',Data);
          SetVariable('CAUSALE',G.Causale);
          SetVariable('DAORE',mmInseriti);
          try
            Execute;
            RegistraLog.SettaProprieta('I','T040_GIUSTIFICATIVI',NomeOwner,nil,True);
            RegistraLog.InserisciDato('PROGRESSIVO','',IntToStr(SelAnagrafe.FieldByName('Progressivo').AsInteger));
            RegistraLog.InserisciDato('CAUSALE','',G.Causale);
            RegistraLog.InserisciDato('DATA','',DateToStr(Data));
            RegistraLog.InserisciDato('MODO','',Format('N %s',[R180MinutiOre(mmInseriti)]));
            RegistraLog.RegistraOperazione{(False)};
            dec(Minuti,mmInseriti);
          except
            on E:Exception do
              RegistraMsg.InserisciMessaggio('A',Format(A000MSG_A108_ERR_FMT_INSERIMENTO,[DateToStr(Data),E.Message]),'',SelAnagrafe.FieldByName('Progressivo').AsInteger);
          end;
        end;
    end;
    SessioneOracle.Commit;
    if Minuti > 0 then
      RegistraMsg.InserisciMessaggio('A',Format(A000MSG_A108_ERR_FMT_ORE_SCOPERTE,[DateToStr(Data),R180MinutiOre(Minuti)]),'',SelAnagrafe.FieldByName('Progressivo').AsInteger);
  finally
    Free;
  end;
end;

end.
