unit Ac04UStampaRendiProjMW;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, OracleData, DBClient, Oracle, Math, StrUtils, R005UDataModuleMW,
  A000UInterfaccia, A000USessione, C180FunzioniGenerali, Rp502Pro;

type
  TAc04FStampaRendiProjMW = class(TR005FDataModuleMW)
    cdsStampaAnagrafico: TClientDataSet;
    cdsStampaDettaglio: TClientDataSet;
    selT750Lista: TOracleDataSet;
    selT750: TOracleDataSet;
    selT751: TOracleDataSet;
    selT755: TOracleDataSet;
    selT754: TOracleDataSet;
    selT257: TOracleDataSet;
    selT040: TOracleDataSet;
    selFestivita: TOracleQuery;
    selT756: TOracleDataSet;
    procedure selT750ListaFilterRecord(DataSet: TDataSet; var Accept: Boolean);
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    IdT750:Integer;
  public
    Dal,Al:TDateTime;
    SLProgetti:TStringList;
    ListaProjSel:String;
    PartnerName: String;
    R502ProDtM1:TR502ProDtM1;
    procedure CreaTabellaStampa;
    procedure ElaboraDipendente;
  end;

implementation

{$R *.dfm}

procedure TAc04FStampaRendiProjMW.DataModuleCreate(Sender: TObject);
begin
  inherited;
  SLProgetti:=TStringList.Create;
  SLProgetti.Sorted:=True;
  selT750.Open;
  selT751.Open;
  selT754.Open;
  selT756.Open;
  selT257.Open;
end;

procedure TAc04FStampaRendiProjMW.DataModuleDestroy(Sender: TObject);
begin
  SLProgetti.Free;
  inherited;
end;

//per WebPJ OrdinaDettaglio a True
procedure TAc04FStampaRendiProjMW.CreaTabellaStampa;
begin
  cdsStampaAnagrafico.Close;
  cdsStampaAnagrafico.CreateDataSet;
  cdsStampaAnagrafico.LogChanges:=False;

  cdsStampaDettaglio.Close;
  cdsStampaDettaglio.CreateDataSet;
  cdsStampaDettaglio.LogChanges:=False;
  cdsStampaDettaglio.Filter:='';
  cdsStampaDettaglio.Filtered:=False;
end;

procedure TAc04FStampaRendiProjMW.ElaboraDipendente;
var sProj,NomeMese,NomeGiorno:String;
    i,n:Integer;
    DCorr:TDateTime;
    OreRend,OreNonRend:Integer;
    bMalattie,bFestivita,bFerie,bAltre:Boolean;
begin
  R502ProDtM1.ResettaProg;
  R180SetVariable(selT750Lista,'PROGRESSIVO',selAnagrafe.FieldByName('PROGRESSIVO').AsInteger);
  R180SetVariable(selT750Lista,'DAL',Dal);
  R180SetVariable(selT750Lista,'AL',Al);
  selT750Lista.Open;
  selT755.Close;
  selT755.SetVariable('PROGRESSIVO',selAnagrafe.FieldByName('PROGRESSIVO').AsInteger);
  selT755.SetVariable('DAL',Dal);
  selT755.SetVariable('AL',Al);
  selT755.Open;
  selT040.Close;
  selT040.SetVariable('PROGRESSIVO',selAnagrafe.FieldByName('PROGRESSIVO').AsInteger);
  selT040.SetVariable('DAL',Dal);
  selT040.SetVariable('AL',Al);
  selT040.Open;
  sProj:=ListaProjSel + ',';
  while sProj <> '' do
  begin
    IdT750:=StrToInt(Copy(sProj,1,Pos(',',sProj) - 1));
    sProj:=Copy(sProj,Pos(',',sProj) + 1);//Lasciare prima del Continue, altrimenti duplicare l'istruzione
    //Stampo solo se il dipendente è associato al progetto
    if not selT750Lista.SearchRecord('ID_T750',IdT750,[srFromBeginning]) then
      Continue;
    selT751.Filter:='ID_T750 = ' + IntToStr(IdT750);
    selT751.Filtered:=True;
    selT754.Filter:='ID_T750 = ' + IntToStr(IdT750);
    selT754.Filtered:=True;
    selT756.Filter:='ID_T750 = ' + IntToStr(IdT750);
    selT756.Filtered:=True;
    //Per ogni dipendente/progetto scrivere un record su cdsStampaAnagrafico
    with cdsStampaAnagrafico do
    begin
      Append;
      FieldByName('PROGRESSIVO').AsInteger:=selAnagrafe.FieldByName('PROGRESSIVO').AsInteger;
      FieldByName('COGNOME_DIP').AsString:=selAnagrafe.FieldByName('COGNOME').AsString;
      FieldByName('NOME_DIP').AsString:=selAnagrafe.FieldByName('NOME').AsString;
      FieldByName('MATRICOLA_DIP').AsString:=selAnagrafe.FieldByName('MATRICOLA').AsString;
      NomeMese:=R180NomeMese(R180Mese(Al));
      FieldByName('PERIODO_STAMPA').AsString:=IfThen(NomeMese = 'gennaio',    'January',
                                              IfThen(NomeMese = 'febbraio',   'February',
                                              IfThen(NomeMese = 'marzo',      'March',
                                              IfThen(NomeMese = 'aprile',     'April',
                                              IfThen(NomeMese = 'maggio',     'May',
                                              IfThen(NomeMese = 'giugno',     'June',
                                              IfThen(NomeMese = 'luglio',     'July',
                                              IfThen(NomeMese = 'agosto',     'August',
                                              IfThen(NomeMese = 'settembre',  'September',
                                              IfThen(NomeMese = 'ottobre',    'October',
                                              IfThen(NomeMese = 'novembre',   'November',
                                              IfThen(NomeMese = 'dicembre',   'December'
                                              )))))))))))) + ' ' + IntToStr(R180Anno(Al));
      FieldByName('ID_T750').AsInteger:=IdT750;
      selT756.First;
      while not selT756.Eof do
      begin
        if (Al >= selT756.FieldByName('DECORRENZA').AsDateTime)
        and (Al <= selT756.FieldByName('DECORRENZA_FINE').AsDateTime) then
        begin
          FieldByName('REPORTING_PERIOD').AsString:=selT756.FieldByName('CODICE').AsString;
          Break;
        end;
        selT756.Next;
      end;
      FieldByName('COD_PROGETTO').AsString:=VarToStr(selT750.Lookup('ID',IdT750,'CODICE'));
      FieldByName('DESC_PROGETTO').AsString:=VarToStr(selT750.Lookup('ID',IdT750,'DESCRIZIONE'));
      FieldByName('PARTNER_NAME').AsString:=PartnerName;//'Municipality of Torino';
      FieldByName('PARTNER_NUMBER').AsString:=VarToStr(selT750.Lookup('ID',IdT750,'PARTNER_NUMBER'));
      FieldByName('NOMINATIVO_DIP').AsString:=FieldByName('NOME_DIP').AsString + ' ' + FieldByName('COGNOME_DIP').AsString;
      FieldByName('SERVIZIO').AsString:=VarToStr(selT754.Lookup('PROGRESSIVO',selAnagrafe.FieldByName('PROGRESSIVO').AsInteger,'SERVIZIO'));
      FieldByName('FUNZIONE').AsString:=VarToStr(selT754.Lookup('PROGRESSIVO',selAnagrafe.FieldByName('PROGRESSIVO').AsInteger,'FUNZIONE'));
      FieldByName('NOMINATIVO_RESP').AsString:=VarToStr(selT750.Lookup('ID',IdT750,'NOMINATIVO_RESP'));
      //salvo gli id delle attività del progetto
      n:=0;
      while not selT751.Eof do
      begin
        n:=selT751.RecNo;
        if (n < 10) or (selT751.RecordCount = 10) then
        begin
          FieldByName('ATT' + IntToStr(n) + '_ID').AsInteger:=selT751.FieldByName('ID').AsInteger;
          FieldByName('ATT' + IntToStr(n) + '_COD').AsString:=selT751.FieldByName('CODICE').AsString;
          FieldByName('TOT_ATT' + IntToStr(n)).AsInteger:=0;
        end
        else
        begin
          FieldByName('ATT10_ID').AsInteger:=-1;//cumulo insieme tutte le attività del progetto che non rientrano tra le prime 9
          FieldByName('ATT10_COD').AsString:='other';
          FieldByName('TOT_ATT10').AsInteger:=0;
        end;
        selT751.Next;
      end;
      FieldByName('TOT_ATT_MM').AsInteger:=0;
      FieldByName('TOT_PRO_MM').AsInteger:=0;
      FieldByName('TOT_MM').AsInteger:=0;
      Post;
      Locate('PROGRESSIVO;ID_T750',VarArrayOf([selAnagrafe.FieldByName('PROGRESSIVO').AsInteger,IdT750]),[]);
    end;
    //Per ogni dipendente/progetto/giorno scrivere un record su cdsStampaDettaglio
    for i:=0 to Trunc(Al - Dal) do
      with cdsStampaDettaglio do
      begin
        DCorr:=Dal + i;
        Append;
        FieldByName('PROGRESSIVO').AsInteger:=selAnagrafe.FieldByName('PROGRESSIVO').AsInteger;
        FieldByName('ID_T750').AsInteger:=IdT750;
        FieldByName('GIORNO').AsDateTime:=DCorr;
        NomeGiorno:=R180NomeGiorno(DCorr);
        FieldByName('DESC_GIORNO').AsString:=IfThen(NomeGiorno = 'lunedì',    'Monday',
                                             IfThen(NomeGiorno = 'martedì',   'Tuesday',
                                             IfThen(NomeGiorno = 'mercoledì', 'Wednesday',
                                             IfThen(NomeGiorno = 'giovedì',   'Thursday',
                                             IfThen(NomeGiorno = 'venerdì',   'Friday',
                                             IfThen(NomeGiorno = 'sabato',    'Saturday',
                                             IfThen(NomeGiorno = 'domenica',  'Sunday'
                                             )))))));
        FieldByName('DESC_GIORNO').AsString:=Copy(FieldByName('DESC_GIORNO').AsString,1,3);
        FieldByName('TOT_ATT_GG').AsInteger:=0;
        FieldByName('TOT_PRO_GG').AsInteger:=0;
        FieldByName('TOT_GG').AsInteger:=0;
        R502ProDtM1.Conteggi('Cartolina',selAnagrafe.FieldByName('PROGRESSIVO').AsInteger,DCorr);
        if R502ProDtM1.Blocca = 0 then
          FieldByName('TOT_GG').AsInteger:=R502ProDtM1.OreRendicontabili;

        //rendicontazioni sul progetto principale
        selT755.Filter:='(ID_T750 = ' + IntToStr(IdT750) + ') and (DATA = ' + FloatToStr(DCorr) + ')';
        selT755.Filtered:=True;
        while not selT755.Eof do
        begin
          n:=0;
          if selT751.Locate('ID',selT755.FieldByName('ID_T751').AsInteger,[]) then
            n:=selT751.RecNo;
          if (n = 0) //non dovrebbe capitare
          or (n > 10) then
            n:=10;
          OreRend:=selT755.FieldByName('ORE_RENDICONTATE').AsInteger;
          FieldByName('ATT' + IntToStr(n) + '_HH').AsInteger:=OreRend;
          FieldByName('TOT_ATT_GG').AsInteger:=FieldByName('TOT_ATT_GG').AsInteger + OreRend;
          //aggiorno i totali mensili
          cdsStampaAnagrafico.Edit;
          cdsStampaAnagrafico.FieldByName('TOT_ATT' + IntToStr(n)).AsInteger:=cdsStampaAnagrafico.FieldByName('TOT_ATT' + IntToStr(n)).AsInteger + OreRend;
          cdsStampaAnagrafico.FieldByName('TOT_ATT_MM').AsInteger:=cdsStampaAnagrafico.FieldByName('TOT_ATT_MM').AsInteger + OreRend;
          cdsStampaAnagrafico.Post;
          selT755.Next;
        end;
        //total other project (ore rendicontabili - progetto principale = altri progetti + ore non rendicontate)
        FieldByName('TOT_PRO_GG').AsInteger:=FieldByName('TOT_GG').AsInteger -
                                              FieldByName('TOT_ATT_GG').AsInteger;
        //rendicontazioni su altri progetti
        selT755.Filter:='(ID_T750 <> ' + IntToStr(IdT750) + ') and (DATA = ' + FloatToStr(DCorr) + ')';
        selT755.Filtered:=True;
        while not selT755.Eof do
        begin
          for n:=1 to 5 do
            //id progetto già registrato
            if cdsStampaAnagrafico.FieldByName('PRO' + IntToStr(n) + '_ID').AsInteger = selT755.FieldByName('ID_T750').AsInteger then
              Break
            //id progetto da registrare
            else if cdsStampaAnagrafico.FieldByName('PRO' + IntToStr(n) + '_ID').IsNull then
            begin
              cdsStampaAnagrafico.Edit;
              cdsStampaAnagrafico.FieldByName('PRO' + IntToStr(n) + '_ID').AsInteger:=selT755.FieldByName('ID_T750').AsInteger;
              cdsStampaAnagrafico.FieldByName('PRO' + IntToStr(n) + '_COD').AsString:=VarToStr(selT750.Lookup('ID',selT755.FieldByName('ID_T750').AsInteger,'DESCRIZIONE'));
              cdsStampaAnagrafico.FieldByName('TOT_PRO' + IntToStr(n)).AsInteger:=0;
              cdsStampaAnagrafico.Post;
              Break;
            end
            //id progetto da registrare ma tutti gli spazi sono stati occupati
            else if (n = 5) and (cdsStampaAnagrafico.FieldByName('PRO5_ID').AsInteger <> -1) then
            begin
              cdsStampaAnagrafico.Edit;
              cdsStampaAnagrafico.FieldByName('PRO5_ID').AsInteger:=-1;
              cdsStampaAnagrafico.FieldByName('PRO5_COD').AsString:='other';
              cdsStampaAnagrafico.Post;
            end;
          if (n < 1) or (n > 5) then //se ha completato il ciclo senza break
            n:=5;
          OreRend:=selT755.FieldByName('ORE_RENDICONTATE').AsInteger;
          FieldByName('PRO' + IntToStr(n) + '_HH').AsInteger:=FieldByName('PRO' + IntToStr(n) + '_HH').AsInteger + OreRend;
          //aggiorno i totali mensili
          cdsStampaAnagrafico.Edit;
          cdsStampaAnagrafico.FieldByName('TOT_PRO' + IntToStr(n)).AsInteger:=cdsStampaAnagrafico.FieldByName('TOT_PRO' + IntToStr(n)).AsInteger + OreRend;
          cdsStampaAnagrafico.Post;
          selT755.Next;
        end;
        selT755.Filtered:=False;
        //other activities (total other project - altri progetti = ore non rendicontate)
        OreNonRend:=FieldByName('TOT_PRO_GG').AsInteger;
        for n:=1 to 5 do
          OreNonRend:=OreNonRend - FieldByName('PRO' + IntToStr(n) + '_HH').AsInteger;
        if OreNonRend <> 0 then
          FieldByName('NON_REND_HH').AsInteger:=OreNonRend;
        //motivi di assenza (sick leave = malattie, public holidays = festività, annual holidays = ferie, other absence = altre)
        (*Nella colonne "stick leave", "annual holidays" devono essere indicate solo se la fruizione è a giornata intera.
          La colonna "piubblic holiday" sono  le festività nazionali. (Festivo = 'S' E Lavorativo = S)
          La colonna altre assenze è valorizzata quando il totale delle ore rendicontabili è zero e l'assenza è diversa da ferie, malattia.
          il tipo accorpamento è meglio renderlo un generico Ac01. Gli accorpamenti fissi (perché la stampa li prevede) saranno SL e AH. Le causali sono personalizzabili*)
        selFestivita.SetVariable('PROGRESSIVO',selAnagrafe.FieldByName('PROGRESSIVO').AsInteger);
        selFestivita.SetVariable('DATA',DCorr);
        selFestivita.Execute;
        bFestivita:=(VarToStr(selFestivita.GetVariable('FESTIVO')) = 'S') and (VarToStr(selFestivita.GetVariable('LAVORATIVO')) = 'S');
        selT257.Filter:='(DECORRENZA <= ' + FloatToStr(DCorr) + ') and (DECORRENZA_FINE >= ' + FloatToStr(DCorr) + ')';
        selT257.Filtered:=True;
        selT040.Filter:='DATA = ' + FloatToStr(DCorr);
        selT040.Filtered:=True;
        bMalattie:=False;
        bFerie:=False;
        bAltre:=False;
        while not selT040.Eof do
        begin
          if selT040.FieldByName('TIPOGIUST').AsString = 'I' then
          begin
            if VarToStr(selT257.Lookup('COD_CAUSALE',selT040.FieldByName('CAUSALE').AsString,'COD_CODICIACCORPCAUSALI')) = 'SL' then
              bMalattie:=True
            else if VarToStr(selT257.Lookup('COD_CAUSALE',selT040.FieldByName('CAUSALE').AsString,'COD_CODICIACCORPCAUSALI')) = 'AH' then
              bFerie:=True;
          end;
          selT040.Next;
        end;
        (*Tra le ASS_ALTRE non segnalo la presenza di causali che aumenterebbero le ore rendicontabili anche se per qualche motivo le ore rendicontabili rimangono a 0.
          Tra l'altro questo era un modo per non segnalare le causali fittizie inserite sulla domenica a TORINO_COMUNE, che dovevano quindi essere elencate in T750_PROGETTI_RENDICONTO.CAUASSPRES_INCLUSE
          Per essere certi di escluderle sempre, selT040 controlla la T020_ORARI, così da poter togliere tali causali da T750_PROGETTI_RENDICONTO.CAUASSPRES_INCLUSE*)
        selT040.Filter:='(' + selT040.Filter + ') and (CAU_INCLUSA = ''N'')';
        selT040.Filtered:=False;
        selT040.Filtered:=True;
        bAltre:=not bFestivita and not bMalattie and not bFerie and (FieldByName('TOT_GG').AsInteger = 0) and (selT040.RecordCount > 0);
        FieldByName('ASS_MALATTIE').AsString:=IfThen(bMalattie,'X');
        FieldByName('ASS_FESTIVITA').AsString:=IfThen(bFestivita,'X');
        FieldByName('ASS_FERIE').AsString:=IfThen(bFerie,'X');
        FieldByName('ASS_ALTRE').AsString:=IfThen(bAltre,'X');
        //Totali generali
        cdsStampaAnagrafico.Edit;
        cdsStampaAnagrafico.FieldByName('TOT_NON_REND').AsInteger:=cdsStampaAnagrafico.FieldByName('TOT_NON_REND').AsInteger + FieldByName('NON_REND_HH').AsInteger;
        cdsStampaAnagrafico.FieldByName('TOT_PRO_MM').AsInteger:=cdsStampaAnagrafico.FieldByName('TOT_PRO_MM').AsInteger + FieldByName('TOT_PRO_GG').AsInteger;
        cdsStampaAnagrafico.FieldByName('TOT_MM').AsInteger:=cdsStampaAnagrafico.FieldByName('TOT_MM').AsInteger + FieldByName('TOT_GG').AsInteger;
        cdsStampaAnagrafico.Post;
        selT040.Filtered:=False;
        selT257.Filtered:=False;
        Post;
      end;
    selT751.Filtered:=False;
    selT754.Filtered:=False;
    selT756.Filtered:=False;
  end;
end;

procedure TAc04FStampaRendiProjMW.selT750ListaFilterRecord(DataSet: TDataSet; var Accept: Boolean);
begin
  Accept:=A000FiltroDizionario('PROGETTI RENDICONTABILI',DataSet.FieldByName('ID_T750').AsString);
end;

end.
