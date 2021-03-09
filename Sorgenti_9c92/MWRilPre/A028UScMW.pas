unit A028UScMW;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, R005UDataModuleMW, Rp502Pro, StrUtils, DB, DBClient,R500Lin, C180FunzioniGenerali;

type
  TA028FScMW = class(TR005FDataModuleMW)
    dsrConteggi: TDataSource;
    cdsConteggi: TClientDataSet;
    cdsConteggiDato: TStringField;
    cdsConteggiValore: TStringField;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    procedure AddDato(Dato, Valore: String);
  public
    R502ProDtM1:TR502ProDtM1;
    procedure ResettaConteggi;
    procedure SettaConteggi(DataInizio, DataFine: TDateTime;RichiesteWeb: Boolean);
    procedure EseguiConteggi(Progressivo: Integer; Data: TDateTime);
    procedure InzializzaCdsConteggi;
    function getAnomalia: String;
    function getCausMgAss: String;
    function getCausGGAss: String;
    function GetDescFasce: String;
    procedure CaricaCdsConteggi;
end;

implementation

{$R *.dfm}

procedure TA028FScMW.DataModuleCreate(Sender: TObject);
begin
  inherited;
  R502ProDtM1:=TR502ProDtM1.Create(nil);
end;

procedure TA028FScMW.DataModuleDestroy(Sender: TObject);
begin
  FreeAndNil(R502ProDtM1);
  inherited;
end;

procedure TA028FScMW.ResettaConteggi;
begin
  R502ProDtM1.Resetta;
  R502ProDtM1.ResettaProg;
end;

procedure TA028FScMW.SettaConteggi(DataInizio,DataFine: TDateTime; RichiesteWeb: Boolean);
begin
  R502ProDtM1.PeriodoConteggi(DataInizio,DataFine);
  R502ProDtM1.ConsideraRichiesteWeb:=RichiesteWeb;
end;

procedure TA028FScMW.EseguiConteggi(Progressivo:Integer; Data: TDateTime);
begin
  R502ProDtM1.Conteggi('Servizio',Progressivo,Data);
end;

procedure TA028FScMW.InzializzaCdsConteggi;
begin
  cdsConteggi.EmptyDataSet;
  cdsConteggi.LogChanges:=False;
end;

function TA028FScMW.getAnomalia: String;
begin
  Result:='';
  if R502ProDtM1.blocca <> 0 then
    Result:='Anomalia bloccante: ' + tdescanom1[R502ProDtM1.Blocca].D;
end;

function TA028FScMW.getCausMgAss: String;
var i: Integer;
begin
  Result:='';
  for i:=1 to R502ProDtM1.n_giusmga do
      if i > 2 then break
      else Result:=Result + R502ProDtM1.tgius_mgass[i].tcausmgass + ' ';
end;

function TA028FScMW.getCausGGAss: String;
var i: Integer;
begin
  Result:='';
  for i:=1 to R502ProDtM1.n_giusgga do
    if i > 2 then break
    else Result:=Result+ R502ProDtM1.tgius_ggass[i].tcausggass + ' ';
end;

function TA028FScMW.GetDescFasce: String;
begin
  if R502ProDtM1.tipofasc = 1 then
    Result:='Fasce orarie FERIALI'
  else if R502ProDtM1.tipofasc = 2 then
    Result:='Fasce orarie FESTIVE'
  else if R502ProDtM1.tipofasc = 3 then
    Result:='Fasce orarie SABATO';

  Result:=Result + '(' + IntToStr(R502ProDtM1.tipofasc) + ')' +
                   ' Numero fasce ' + IntToStr(R502ProDtM1.n_fasce);
end;

procedure TA028FScMW.AddDato(Dato,Valore:String);
begin
  with cdsConteggi do
  begin
    Append;
    FieldByName('DATO').AsString:=Dato;
    FieldByName('VALORE').AsString:=Valore;
    Post;
  end;
end;

procedure TA028FScMW.CaricaCdsConteggi;
begin
  with R502ProDtM1 do
  begin
    AddDato('Dipendente in servizio',dipinser);
    AddDato('Giorno della settimana',IntToStr(giorsett));
    AddDato('Giorno lavorativo',gglav);
    AddDato('Giorno festivo',tipogg);
    AddDato('Monte ore settimanale',R180MinutiOre(minmonteore));
    AddDato('GG lavorativi settimanali',IntToStr(giornlav));
    if OraLegaleSolare.Cambio then
    begin
      AddDato('*** ORA LEGALE/SOLARE ***','si');
      AddDato('Ora vecchia',R180MinutiOre(OraLegaleSolare.OraVecchia));
      AddDato('Ora nuova',R180MinutiOre(OraLegaleSolare.OraNuova));
    end;
    AddDato('*** ORARIO - TURNI ***','');
    AddDato('Turnista',Q430.FieldByName('TGestione').AsString);
    AddDato('Pianificato',pianif);
    AddDato('Codice orario',c_orario + ' - ' + R180MinutiOre(oreteoturni));
    if cdsT020.Active then AddDato('XParam',cdsT020.FieldByName('XPARAM').AsString)
    else                   AddDato('XParam','');
    AddDato('Fless. totale',R180MinutiOre(FlessibilitaTot));
    AddDato('Fless. per ritardo',R180MinutiOre(FlessibilitaRit));
    AddDato('Fless. per PM',R180MinutiOre(FlessibilitaPM));
    if (Q430.FieldByName('TGestione').AsString = '1') and (TipoOrario = 'E') and (PeriodoLavorativo ='T1') then
    begin
      if cdsT020.Active then AddDato('Frazionamento debito',cdsT020.FieldByName('FrazDeb').AsString)
      else                   AddDato('Frazionamento debito','');
    end;
    AddDato('Turni fatti',Format('%d,%d',[r_turno1,r_turno2]));
    AddDato('Turni riepilogati',Format('%d,%d',[n_turno1,n_turno2]));
    AddDato('Ultima timb. E',ultimt_e);
    AddDato('Prima  timb. U',primat_u);
    if estimbprec = 'si' then
      AddDato('Timbr. prec.',verso_pre + R180MinutiOre(minuti_pre))
    else
      AddDato('Timbr. prec.','no');
    if estimbsucc = 'si' then
      AddDato('Timbr. succ.',verso_suc + R180MinutiOre(minuti_suc))
    else
      AddDato('Timbr. succ.','no');

    AddDato('*** PAUSA MENSA ***','');
    AddDato('Pausa mensa gestita',paumenges);
    AddDato('Tipo detrazione',TipoDetPaumen);
    AddDato('Detrazione',IntToStr(paumendet));
    AddDato('Recupero psico/fisico',IntToStr(rec_psicofisico));

    AddDato('*** TURNI REPERIBILITA''/GUARDIA ***','');
    AddDato('Reperibilità pianificata',TurniExtraPianificatiDalleAlle['C']);
    AddDato('Guardia pianificata',TurniExtraPianificatiDalleAlle['D']);

    AddDato('*** DEBITO GIORNALIERO ***','');
    AddDato('Debito Giorno',R180MinutiOre(DebitoGG));
    AddDato('Debito Riepilogo',R180MinutiOre(debitorp));
    AddDato('Debito Plus Orario (' + IfThen(tipogespo <> #0,tipogespo) + ')',R180MinutiOre(debitopo));

    AddDato('Ore da assenze',R180MinutiOre(minassenze));
    AddDato('Copertura carenza automatica',R180MinutiOre(CoperturaCarenza));

    AddDato('*** STRAORDINARI/ECCEDENZE ***','');
    AddDato('Scostamento',R180MinutiOre(scost));
    AddDato('Scost. in fascia',R180MinutiOre(scostfascia));
    AddDato('Totale straord. giornaliero',R180MinutiOre(R180SommaArray(tminstrgio)));
    AddDato('Abbattimento straord.liq.',R180MinutiOre(minabbstr));
    AddDato('Detrazioni per arrotondamento straord.',IntToStr(strarrdet));
    AddDato('Ore escluse da normali',R180MinutiOre(minlavesc));
    AddDato('Ore escluse da normali su U-E',R180MinutiOre(mintipoAesc));
    AddDato('Compensaz. debito gg con ore escl. da normali',R180MinutiOre(CompDebitoCausEscluse));
    AddDato('Ecc. solo compensabile',R180MinutiOre(eccsolocomp));
    AddDato('Prolung.inibito.',R180MinutiOre(ProlungamentoInibito['']));
    AddDato('Prolung.non caus.',R180MinutiOre(ProlungamentoNonCausalizzato['']));

    if ValStrT021['ENTRATA',TF_OBBLIGATORIA,1] <> '' then
    begin
      AddDato('*** FASCE OBBLIGATORIE/FACOLTATIVE ***','');
      AddDato('Fascia obbligatoria coperta',R180MinutiOre(PresenzaObbligatoria));
      AddDato('Fascia obbligatoria scoperta',R180MinutiOre(-CarenzaObbligatoria));
      AddDato('Fascia facoltativa - saldo',R180MinutiOre(ScostFacoltativa));
      AddDato('Fascia facoltativa coperta',R180MinutiOre(PresenzaFacoltativa));
      AddDato('Fascia facoltativa scoperta',R180MinutiOre(CarenzaFacoltativa));
    end
    else
    begin
      AddDato('*** FASCE OBBLIGATORIE/FACOLTATIVE ***','VUOTA');
    end;
    AddDato('*** RIPOSO COMPENSATIVO ***','');
    AddDato('Maturazione',R180MinutiOre(RipCom));
    AddDato('Abbattimento',R180MinutiOre(AbbRipCom));

    AddDato('*** INDENNITA'' FESTIVA ***','');
    AddDato('Debito',R180MinutiOre(debitoindfes));
    AddDato('Ore rese',R180MinutiOre(minlavfes));
    AddDato('Ore rese gg.prec.',R180MinutiOre(minlavfes_nottecompletaPrec));
    AddDato('Ore rese gg.corr.',R180MinutiOre(minlavfes_nottecompletaCorr));
    AddDato('Ore rese gg.succ.',R180MinutiOre(minlavfes_nottecompletaSucc));
    AddDato('Maturazione ind.intera',FloatToStr(indfesint));
    AddDato('Maturazione ind.ridotta',FloatToStr(indfesrid));
    AddDato('*** INDENNITA'' TURNO/NOTTURNA ***','');
    AddDato('Maturazione ind.turno gg',IntToStr(indnotgg));
    AddDato('Maturazione ind.turno hhmm',R180MinutiOre(IndNotMin));
    AddDato('*** INDENNITA'' PRESENZA ***','');
    AddDato('Debito ind.pres. ieri',R180MinutiOre(mmminpresieriint) + '/' + R180MinutiOre(mmminpresierimez));
    AddDato('Debito ind.pres. oggi',R180MinutiOre(mmminpresoggiint) + '/' + R180MinutiOre(mmminpresoggimez));
    AddDato('Ore rese per ind.pres. ieri',R180MinutiOre(minlavpresieri));
    AddDato('Ore rese per ind.pres. oggi',R180MinutiOre(minlavpresoggi));
    AddDato('Maturazione ind.pres. ieri (Comp.=E)',IfThen(indprescalcieri = 'no','no',FloatToStr(tindennitapresenza[1].tindpres)));
    AddDato('Maturazione ind.pres. oggi (Comp.=U)',FloatToStr(tindennitapresenza[2].tindpres));
    AddDato('Maturazione ind.pres. finale',FloatToStr(tindennitapresenza[3].tindpres));

    AddDato('*** RIENTRO POMERIDIANO ***','');
    AddDato('Riconoscimento rientro',IfThen(RientroPomeridiano.Obbl > 0,'Obbligatorio',IfThen(RientroPomeridiano.Suppl > 0,'Supplementare','No')));
    AddDato('Diritto maturazione buono pasto',IfThen(RientroPomeridiano.BuonoPastoObbl > 0,'Obbligatorio',IfThen(RientroPomeridiano.BuonoPastoSuppl > 0,'Supplementare','No')));
  end;
end;

end.
