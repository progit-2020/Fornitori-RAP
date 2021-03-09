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
    selT460: TOracleDataSet;
    procedure selT750ListaFilterRecord(DataSet: TDataSet; var Accept: Boolean);
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    IdT750:Integer;
    VisNonRend:Boolean;
  public
    Dal,Al:TDateTime;
    SLProgetti:TStringList;
    ListaProjSel:String;
    PartnerName: String;
    TipoTempo,SezGiustificaRitardi,SoloAttRend: Boolean;
    nAttMax,nProMax:Integer;
    R502ProDtM1:TR502ProDtM1;
    procedure CreaTabellaStampa;
    procedure ElaboraDipendente;
  end;

implementation

{$R *.dfm}

procedure TAc04FStampaRendiProjMW.DataModuleCreate(Sender: TObject);
begin
  inherited;
  TipoTempo:=False;
  SezGiustificaRitardi:=False;
  SoloAttRend:=False;
  VisNonRend:=False;
  SLProgetti:=TStringList.Create;
  SLProgetti.Sorted:=True;
  selT750.Open;
  selT751.Open;
  selT754.Open;
  selT756.Open;
  selT257.Open;
  nAttMax:=18;
  nProMax:=5;
end;

procedure TAc04FStampaRendiProjMW.DataModuleDestroy(Sender: TObject);
begin
  SLProgetti.Free;
  inherited;
end;

//per WebPJ OrdinaDettaglio a True
procedure TAc04FStampaRendiProjMW.CreaTabellaStampa;
var i:Integer;
begin
  VisNonRend:=nProMax > 0; //La colonna Other activities la gestisco solo se visualizzo almeno un altro progetto
  nAttMax:=18 - nProMax - IfThen(VisNonRend,1);
  with cdsStampaAnagrafico do
  begin
    Close;
    for i:=FieldDefs.Count - 1 downto 0 do
      if R180In(Copy(FieldDefs.Items[i].Name,1,Pos('_',FieldDefs.Items[i].Name) - 1),['ATTID','ATTCOD','ATTTOT','PROID','PROCOD','PROTOT']) then
        FieldDefs.Items[i].Destroy;
    for i:=1 to nAttMax do
    begin
      FieldDefs.Add('ATTID_' + IntToStr(i),ftInteger);
      FieldDefs.Add('ATTCOD_' + IntToStr(i),ftString,10);
      FieldDefs.Add('ATTTOT_' + IntToStr(i),ftInteger);
    end;
    for i:=1 to nProMax do
    begin
      FieldDefs.Add('PROID_' + IntToStr(i),ftInteger);
      FieldDefs.Add('PROCOD_' + IntToStr(i),ftString,20);
      FieldDefs.Add('PROTOT_' + IntToStr(i),ftInteger);
    end;
    CreateDataSet;
    LogChanges:=False;
  end;
  with cdsStampaDettaglio do
  begin
    Close;
    for i:=FieldDefs.Count - 1 downto 0 do
      if R180In(Copy(FieldDefs.Items[i].Name,1,Pos('_',FieldDefs.Items[i].Name) - 1),['ATTHH','PROHH']) then
        FieldDefs.Items[i].Destroy;
    for i:=1 to nAttMax do
      FieldDefs.Add('ATTHH_' + IntToStr(i),ftInteger);
    for i:=1 to nProMax do
      FieldDefs.Add('PROHH_' + IntToStr(i),ftInteger);
    CreateDataSet;
    LogChanges:=False;
    Filter:='';
    Filtered:=False;
  end;
end;

procedure TAc04FStampaRendiProjMW.ElaboraDipendente;
var sProj,NomeMese,NomeGiorno:String;
    i,n,IDAtt,IDProj:Integer;
    DalCorr,AlCorr,DCorr:TDateTime;
    OreRend,OreNonRend:Integer;
    bMalattie,bFestivita,bFerie,bAltre:Boolean;
    lstIDAtt,lstIDProj:TStringList;
begin
  lstIDAtt:=TStringList.Create;
  lstIDProj:=TStringList.Create;
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
    DalCorr:=Dal;
    AlCorr:=R180FineMese(DalCorr);
    while AlCorr <= Al do
    begin
      R502ProDtM1.PeriodoConteggi(DalCorr,AlCorr);
      R180SetVariable(selT750Lista,'PROGRESSIVO',selAnagrafe.FieldByName('PROGRESSIVO').AsInteger);
      R180SetVariable(selT750Lista,'DAL',DalCorr);
      R180SetVariable(selT750Lista,'AL',AlCorr);
      selT750Lista.Open;
      //Stampo solo se il dipendente è associato al progetto
      if not selT750Lista.SearchRecord('ID_T750',IdT750,[srFromBeginning]) then
      begin
        DalCorr:=AlCorr + 1;
        AlCorr:=R180FineMese(DalCorr);
        Continue;
      end;
      selT751.Filter:='ID_T750 = ' + IntToStr(IdT750);
      selT751.Filtered:=True;
      selT754.Filter:='ID_T750 = ' + IntToStr(IdT750);
      selT754.Filtered:=True;
      selT756.Filter:='ID_T750 = ' + IntToStr(IdT750);
      selT756.Filtered:=True;
      //Cerco le rendicontazioni del periodo, ordinate per codice progetto, codice attività e data
      selT755.Close;
      selT755.SetVariable('PROGRESSIVO',selAnagrafe.FieldByName('PROGRESSIVO').AsInteger);
      selT755.SetVariable('DAL',DalCorr);
      selT755.SetVariable('AL',AlCorr);
      selT755.Open;
      //Recupero il tipo part-time
      if TipoTempo then
      begin
        R180SetVariable(selT460,'PROGRESSIVO',selAnagrafe.FieldByName('PROGRESSIVO').AsInteger);
        R180SetVariable(selT460,'DATA',AlCorr);
        selT460.Open;
      end;
      //Per ogni dipendente/progetto scrivere un record su cdsStampaAnagrafico
      with cdsStampaAnagrafico do
      begin
        Append;
        FieldByName('PROGRESSIVO').AsInteger:=selAnagrafe.FieldByName('PROGRESSIVO').AsInteger;
        FieldByName('COGNOME_DIP').AsString:=selAnagrafe.FieldByName('COGNOME').AsString;
        FieldByName('NOME_DIP').AsString:=selAnagrafe.FieldByName('NOME').AsString;
        FieldByName('MATRICOLA_DIP').AsString:=selAnagrafe.FieldByName('MATRICOLA').AsString;
        FieldByName('PERIODO_STAMPA').AsDateTime:=AlCorr;
        NomeMese:=R180NomeMese(R180Mese(AlCorr));
        FieldByName('PERIODO_STAMPA_DESC').AsString:=IfThen(NomeMese = 'gennaio',    'January',
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
                                                     )))))))))))) + ' ' + IntToStr(R180Anno(AlCorr));
        FieldByName('ID_T750').AsInteger:=IdT750;
        selT756.First;
        while not selT756.Eof do
        begin
          if (AlCorr >= selT756.FieldByName('DECORRENZA').AsDateTime)
          and (AlCorr <= selT756.FieldByName('DECORRENZA_FINE').AsDateTime) then
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
        if TipoTempo then
          FieldByName('TIPO_TEMPO').AsString:=IfThen(R180In(selT460.FieldByName('TIPO_TEMPO').AsString,['','0','100']),'Full-time',Format('Part-time %s%%',[selT460.FieldByName('TIPO_TEMPO').AsString]));
        FieldByName('SERVIZIO').AsString:=VarToStr(selT754.Lookup('PROGRESSIVO',selAnagrafe.FieldByName('PROGRESSIVO').AsInteger,'SERVIZIO'));
        FieldByName('FUNZIONE').AsString:=VarToStr(selT754.Lookup('PROGRESSIVO',selAnagrafe.FieldByName('PROGRESSIVO').AsInteger,'FUNZIONE'));
        FieldByName('NOMINATIVO_RESP').AsString:=VarToStr(selT750.Lookup('ID',IdT750,'NOMINATIVO_RESP'));
        FieldByName('NON_REND_COD').AsString:=' OTHER activi-ties';
        FieldByName('TOT_ATT_MM').AsInteger:=0;
        FieldByName('TOT_PRO_MM').AsInteger:=0;
        FieldByName('TOT_MM').AsInteger:=0;
        //salvo gli id delle attività del progetto
        lstIDAtt.Clear;
        if SoloAttRend then //Solo attività rendicontate
        begin
          selT755.Filter:='ID_T750 = ' + IntToStr(IdT750);
          selT755.Filtered:=True;
          while not selT755.Eof do
          begin
            if lstIDAtt.IndexOf(selT755.FieldByName('ID_T751').AsString) = -1 then
            begin
              if lstIDAtt.Count < nAttMax then
                lstIDAtt.Add(selT755.FieldByName('ID_T751').AsString)
              else
              begin
                lstIDAtt[nAttMax - 1]:='-1'; //L'ultimo slot contiene i dati delle attività rimanenti
                Break; //inutile scorrere i record successivi, perché tanto ho finito gli slot disponibili e so già che nell'ultimo ci andranno le attività rimanenti
              end;
            end;
            selT755.Next;
          end;
        end
        else //Tutte le attività del progetto
        begin
          selT751.First;
          while not selT751.Eof do
          begin
            if lstIDAtt.Count < nAttMax then
              lstIDAtt.Add(selT751.FieldByName('ID').AsString)
            else
            begin
              lstIDAtt[nAttMax - 1]:='-1'; //L'ultimo slot contiene i dati delle attività rimanenti
              Break; //inutile scorrere i record successivi, perché tanto ho finito gli slot disponibili e so già che nell'ultimo ci andranno le attività rimanenti
            end;
            selT751.Next;
          end;
        end;
        for n:=1 to lstIDAtt.Count do
        begin
          IDAtt:=StrToInt(lstIDAtt[n - 1]);
          FieldByName('ATTID_' + IntToStr(n)).AsInteger:=IDAtt;
          if selT751.Locate('ID',IDAtt,[]) then
            FieldByName('ATTCOD_' + IntToStr(n)).AsString:=selT751.FieldByName('CODICE').AsString
          else
            FieldByName('ATTCOD_' + IntToStr(n)).AsString:='other'; //L'ultimo slot contiene i dati delle attività rimanenti
          FieldByName('ATTTOT_' + IntToStr(n)).AsInteger:=0;
        end;
        //salvo gli id degli altri progetti rendicontati
        lstIDProj.Clear;
        if nProMax > 0 then
        begin
          selT755.Filter:='ID_T750 <> ' + IntToStr(IdT750);
          selT755.Filtered:=True;
          while not selT755.Eof do
          begin
            if lstIDProj.IndexOf(selT755.FieldByName('ID_T750').AsString) = -1 then
            begin
              if lstIDProj.Count < nProMax then
                lstIDProj.Add(selT755.FieldByName('ID_T750').AsString)
              else
              begin
                lstIDProj[nProMax - 1]:='-1'; //L'ultimo slot contiene i dati dei progetti rimanenti
                Break; //inutile scorrere i record successivi, perché tanto ho finito gli slot disponibili e so già che nell'ultimo ci andranno i progetti rimanenti
              end;
            end;
            selT755.Next;
          end;
        end;
        for n:=1 to lstIDProj.Count do
        begin
          IDProj:=StrToInt(lstIDProj[n - 1]);
          FieldByName('PROID_' + IntToStr(n)).AsInteger:=IDProj;
          if selT750.Locate('ID',IDProj,[]) then
            FieldByName('PROCOD_' + IntToStr(n)).AsString:=selT750.FieldByName('DESCRIZIONE').AsString // Non bisognerebbe mettere il CODICE???
          else
            FieldByName('PROCOD_' + IntToStr(n)).AsString:='other'; //L'ultimo slot contiene i dati delle attività rimanenti
          FieldByName('PROTOT_' + IntToStr(n)).AsInteger:=0;
        end;
        Post;
        //Posizionamento sul record appena inserito per i successivi riferimenti
        Locate('PROGRESSIVO;ID_T750;PERIODO_STAMPA',VarArrayOf([selAnagrafe.FieldByName('PROGRESSIVO').AsInteger,IdT750,AlCorr]),[]);
      end;
      //Per ogni dipendente/progetto/giorno scrivere un record su cdsStampaDettaglio
      for i:=0 to Trunc(AlCorr - DalCorr) do
        with cdsStampaDettaglio do
        begin
          DCorr:=DalCorr + i;
          Append;
          FieldByName('PROGRESSIVO').AsInteger:=selAnagrafe.FieldByName('PROGRESSIVO').AsInteger;
          FieldByName('ID_T750').AsInteger:=IdT750;
          FieldByName('PERIODO_STAMPA').AsDateTime:=AlCorr;
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
          //rendicontazioni sul progetto principale
          selT755.Filter:='(ID_T750 = ' + IntToStr(IdT750) + ') and (DATA = ' + FloatToStr(DCorr) + ')';
          selT755.Filtered:=True;
          while not selT755.Eof do
          begin
            n:=lstIDAtt.IndexOf(selT755.FieldByName('ID_T751').AsString);
            if n = -1 then
              n:=nAttMax //L'ultimo slot contiene i dati delle attività rimanenti
            else
              n:=n + 1;
            OreRend:=selT755.FieldByName('ORE_RENDICONTATE').AsInteger;
            FieldByName('ATTHH_' + IntToStr(n)).AsInteger:=OreRend;
            FieldByName('TOT_ATT_GG').AsInteger:=FieldByName('TOT_ATT_GG').AsInteger + OreRend;
            //aggiorno i totali mensili
            cdsStampaAnagrafico.Edit;
            cdsStampaAnagrafico.FieldByName('ATTTOT_' + IntToStr(n)).AsInteger:=cdsStampaAnagrafico.FieldByName('ATTTOT_' + IntToStr(n)).AsInteger + OreRend;
            cdsStampaAnagrafico.FieldByName('TOT_ATT_MM').AsInteger:=cdsStampaAnagrafico.FieldByName('TOT_ATT_MM').AsInteger + OreRend;
            cdsStampaAnagrafico.Post;
            selT755.Next;
          end;
          //rendicontazioni su altri progetti
          if nProMax > 0 then
          begin
            selT755.Filter:='(ID_T750 <> ' + IntToStr(IdT750) + ') and (DATA = ' + FloatToStr(DCorr) + ')';
            selT755.Filtered:=True;
            while not selT755.Eof do
            begin
              n:=lstIDProj.IndexOf(selT755.FieldByName('ID_T750').AsString);
              if n = -1 then
                n:=nProMax //L'ultimo slot contiene i dati dei progetti rimanenti
              else
                n:=n + 1;
              OreRend:=selT755.FieldByName('ORE_RENDICONTATE').AsInteger;
              FieldByName('PROHH_' + IntToStr(n)).AsInteger:=FieldByName('PROHH_' + IntToStr(n)).AsInteger + OreRend;
              //aggiorno i totali mensili
              cdsStampaAnagrafico.Edit;
              cdsStampaAnagrafico.FieldByName('PROTOT_' + IntToStr(n)).AsInteger:=cdsStampaAnagrafico.FieldByName('PROTOT_' + IntToStr(n)).AsInteger + OreRend;
              cdsStampaAnagrafico.Post;
              selT755.Next;
            end;
          end;
          //TOTAL (ore rendicontabili)
          R502ProDtM1.Conteggi('Cartolina',selAnagrafe.FieldByName('PROGRESSIVO').AsInteger,DCorr);
          if R502ProDtM1.Blocca = 0 then
            FieldByName('TOT_GG').AsInteger:=R502ProDtM1.OreRendicontabili;
          //total other project (ore rendicontabili - progetto principale = altri progetti + ore non rendicontate)
          FieldByName('TOT_PRO_GG').AsInteger:=FieldByName('TOT_GG').AsInteger - FieldByName('TOT_ATT_GG').AsInteger;
          //other activities (total other project - altri progetti = ore non rendicontate)
          OreNonRend:=FieldByName('TOT_PRO_GG').AsInteger;
          for n:=1 to lstIDProj.Count do
            OreNonRend:=OreNonRend - FieldByName('PROHH_' + IntToStr(n)).AsInteger;
          if OreNonRend <> 0 then
            FieldByName('NON_REND_HH').AsInteger:=OreNonRend;
          //motivi di assenza (sick leave = malattie, public holidays = festività, annual holidays = ferie, other absence = altre)
          (*Nella colonne "sick leave", "annual holidays" devono essere indicate solo se la fruizione è a giornata intera.
            La colonna "public holiday" sono le festività nazionali. (Festivo = 'S' e Lavorativo = 'S')
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
            Tra l'altro questo era un modo per non segnalare le causali fittizie inserite sulla domenica a TORINO_COMUNE, per le quali doveva quindi essere attivato il parametro storicizzato RENDICONTA_PROGETTI
            Per essere certi di escluderle sempre, selT040 controlla la T020_ORARI, così da poter ignorare per tali causali il parametro storicizzato RENDICONTA_PROGETTI*)
          selT040.Filter:='(' + selT040.Filter + ') and (RENDICONTA_PROGETTI = ''N'')';
          selT040.Filtered:=False;
          selT040.Filtered:=True;
          bAltre:=not bFestivita and (bMalattie or bFerie or ((FieldByName('TOT_GG').AsInteger = 0) and (selT040.RecordCount > 0)));
          FieldByName('ASS_FESTIVITA').AsString:=IfThen(bFestivita,'X');
          FieldByName('ASS_ALTRE').AsString:=IfThen(bAltre,'X');
          Post;
          selT755.Filtered:=False;
          selT040.Filtered:=False;
          selT257.Filtered:=False;
          //Totali generali
          cdsStampaAnagrafico.Edit;
          if not FieldByName('NON_REND_HH').IsNull then
            cdsStampaAnagrafico.FieldByName('TOT_NON_REND').AsInteger:=cdsStampaAnagrafico.FieldByName('TOT_NON_REND').AsInteger + FieldByName('NON_REND_HH').AsInteger;
          cdsStampaAnagrafico.FieldByName('TOT_PRO_MM').AsInteger:=cdsStampaAnagrafico.FieldByName('TOT_PRO_MM').AsInteger + FieldByName('TOT_PRO_GG').AsInteger;
          cdsStampaAnagrafico.FieldByName('TOT_MM').AsInteger:=cdsStampaAnagrafico.FieldByName('TOT_MM').AsInteger + FieldByName('TOT_GG').AsInteger;
          cdsStampaAnagrafico.Post;
        end;
      selT751.Filtered:=False;
      selT754.Filtered:=False;
      selT756.Filtered:=False;
      DalCorr:=AlCorr + 1;
      AlCorr:=R180FineMese(DalCorr);
    end;
  end;
  FreeAndNil(lstIDAtt);
  FreeAndNil(lstIDProj);
end;

procedure TAc04FStampaRendiProjMW.selT750ListaFilterRecord(DataSet: TDataSet; var Accept: Boolean);
begin
  Accept:=A000FiltroDizionario('PROGETTI RENDICONTABILI',DataSet.FieldByName('ID_T750').AsString);
end;

end.
