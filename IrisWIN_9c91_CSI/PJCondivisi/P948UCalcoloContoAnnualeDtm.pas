unit P948UCalcoloContoAnnualeDtm;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, Math,
  R004UGESTSTORICODTM, Db, OracleData, C180FUNZIONIGENERALI, Oracle,
  P999UGenerale, A000UInterfaccia, Crtl, DBClient, Variants;

type
  TDatiInpP948 = record
    Progressivo, ID_CONTANN:Integer;
    AnnoElaborazione:String;
    DataInizioElaborazione, DataFineElaborazione: TDateTime;
    CodTabella, DescTabella, TipoTabellaRighe,ValoreCostante:String;
    ElaboraDatiCONTANN: Boolean;
    ElaboraRiepiloghi: Boolean;
    StatoCedolini: String;
  end;
  TDatiOutP948 = record
    Blocca:String;
    NoBlocca:String;
  end;

  TP948FCalcoloContoAnnualeDtm = class(TR004FGestStoricoDtM)
    selP552: TOracleDataSet;
    selP552a: TOracleDataSet;
    selT430: TOracleDataSet;
    OperSql: TOracleDataSet;
    scrP555: TOracleQuery;
    selP552b: TOracleDataSet;
    selP552c: TOracleDataSet;
  private
    { Private declarations }
    //Variabili di scambio con il calcolo
    DatiInpCONTANN:TDatiInpP948;
    procedure MacroRoutine;
    procedure ImpostazioniIniziali;
    procedure CalcoloDatiQueryCol;
    procedure CalcoloDatiQueryRig;
    procedure ImpostaQueryCalcolo;
    function DeterminaArretrati(sAnnoMeseComp,sAnnoMeseRetr:String):String;
    procedure InserimentoDati(sCodArrotondamento, sDatoLibero, sCodTabella, sColonna, sRiga :String; rDato :Real);
  public
    { Public declarations }
    DatiOut:TDatiOutP948;
    procedure Calcolo(DatiInp:TDatiInpP948);
  end;

const
  //Codice Speciale Base
  CodVoceSpecialeBase = 'BASE';
  BloccaP948:array[1..11] of String =
  (*001*)  ('Manca il dato anagrafico di riferimento del dipendente nel periodo di elaborazione',
  (*002*)   'Non esistono le regole di calcolo valide per il periodo di elaborazione',
  (*003*)   'Manca la definizione della data di modalità accorpamento per la regola di calcolo  ',
  (*004*)   'Non trovata in tabella la riga corrispondente al valore ',
  (*005*)   'Non esiste l'' arrotondamento previsto dalla regola del dato ',
  (*006*)   'Query non valida tabella ',
  (*007*)   '',
  (*008*)   '',
  (*009*)   '',
  (*010*)   'Non esiste la regola di calcolo per l''anno del quale è stata richiesta l''elaborazione del numero dato: ',
  (*011*)   ''
  );
  NoBloccaP948:array[1..2] of String =
  (*001*)  ('',
  (*002*)   ''
  );

var
  P948FCalcoloContoAnnualeDtm: TP948FCalcoloContoAnnualeDtm;

implementation

uses P554UElaborazioneContoAnnuale;

{$R *.DFM}

procedure TP948FCalcoloContoAnnualeDtm.Calcolo(DatiInp:TDatiInpP948);
begin
  DatiInpCONTANN:=DatiInp;
  DatiOut.Blocca:='';
  DatiOut.NoBlocca:='';
  //Chiamata alle routine principali
  try
    MacroRoutine;
    if DatiOut.Blocca = '' then
      SessioneOracle.Commit
    else
      SessioneOracle.Rollback;
  except
    SessioneOracle.Rollback;
    raise;
  end;
end;

procedure TP948FCalcoloContoAnnualeDtm.MacroRoutine;
//Chiamata alle routine principali
begin
  if DatiInpCONTANN.ElaboraDatiCONTANN then
  begin
    //Impostazioni iniziali
    ImpostazioniIniziali;
    //Calcolo i dati derivanti da query per tabelle con qualif.minist., altro dato libero o funzione Oracle
    if (DatiInpCONTANN.TipoTabellaRighe = '0') or (DatiInpCONTANN.TipoTabellaRighe = '1') then
      CalcoloDatiQueryCol;
    if DatiOut.Blocca <> '' then
      exit;
    //Calcolo i dati derivanti da query per tabelle con tipologia righe Accorpamento voci
    if DatiInpCONTANN.TipoTabellaRighe = '2' then
      CalcoloDatiQueryRig;
    if DatiOut.Blocca <> '' then
      exit;
  end;
end;

procedure TP948FCalcoloContoAnnualeDtm.ImpostazioniIniziali;
//Impostazioni iniziali
begin
  //Apertura query per estrarre i dati per le query di ogni tabella
  if (selP552.GetVariable('AnnoElaborazione') <> DatiInpCONTANN.AnnoElaborazione)
     or (selP552.GetVariable('CodTabella') <> DatiInpCONTANN.CodTabella)
     or (selP552.GetVariable('TipoTabellaRighe') <> DatiInpCONTANN.TipoTabellaRighe) then
  begin
    selP552.SetVariable('AnnoElaborazione',DatiInpCONTANN.AnnoElaborazione);
    selP552.SetVariable('CodTabella',DatiInpCONTANN.CodTabella);
    selP552.SetVariable('TipoTabellaRighe',DatiInpCONTANN.TipoTabellaRighe);
    selP552.Close;
    selP552.Open;
  end;
  //Apertura query per estrarre i dati utili per risalire al numero di riga nel caso di tabelle con tipologia righe qualif.minist., altro dato libero o funzione Oracle
  if (DatiInpCONTANN.TipoTabellaRighe = '0') or (DatiInpCONTANN.TipoTabellaRighe = '1') then
  begin
    if (selP552a.GetVariable('AnnoElaborazione') <> DatiInpCONTANN.AnnoElaborazione)
       or (selP552a.GetVariable('CodTabella') <> DatiInpCONTANN.CodTabella) then
    begin
      selP552a.SetVariable('AnnoElaborazione',DatiInpCONTANN.AnnoElaborazione);
      selP552a.SetVariable('CodTabella',DatiInpCONTANN.CodTabella);
      selP552a.Close;
      selP552a.Open;
    end;
  end;
  //Apertura query per estrarre i codici arrotondamento per tutte le tabelle dell'anno
  if (selP552b.GetVariable('AnnoElaborazione') <> DatiInpCONTANN.AnnoElaborazione) then
  begin
    selP552b.SetVariable('AnnoElaborazione',DatiInpCONTANN.AnnoElaborazione);
    selP552b.Close;
    selP552b.Open;
  end;
  //Apertura query per estrarre Filtro dipendenti
  if (selP552c.GetVariable('AnnoElaborazione') <> DatiInpCONTANN.AnnoElaborazione)
     or (selP552c.GetVariable('CodTabella') <> DatiInpCONTANN.CodTabella) then
  begin
    selP552c.SetVariable('AnnoElaborazione',DatiInpCONTANN.AnnoElaborazione);
    selP552c.SetVariable('CodTabella',DatiInpCONTANN.CodTabella);
    selP552c.Close;
    selP552c.Open;
  end;
end;

procedure TP948FCalcoloContoAnnualeDtm.CalcoloDatiQueryCol;
//Calcolo i dati derivanti da query impostate per le colonne
var
  sDatoLibero, sCodTab, sCol, sCodArr: String;
  rDato, rDato13ACorr, rDato13APrec, rDatoArrCorr, rDatoArrPrec: Real;

//Imposta suddivisione dati per spostamenti di colonne e richiama registrazione sul dipendente
procedure ImpostaInserimentoDati;
begin
  //Se non è gestita la modalità di accorpamento salto la suddivisione nei campi sostitutivi
  if selP552.FieldByName('DATA_ACCORPAMENTO').AsString <> 'NA' then
  begin
    sCodArr:='';
    //Registrazione della ripartizione del dato relativa alla 13A Anno Corr.
    sCodTab:=Copy(selP552.FieldByName('NUMERO_TREDCORR').AsString,1,Pos('.',selP552.FieldByName('NUMERO_TREDCORR').AsString)-1);
    sCol:=Trim(Copy(selP552.FieldByName('NUMERO_TREDCORR').AsString,Pos('.',selP552.FieldByName('NUMERO_TREDCORR').AsString)+1,3));
    InserimentoDati(selP552.FieldByName('COD_ARROTONDAMENTO').AsString, sDatoLibero, sCodTab, sCol, '', rDato13ACorr);
    if DatiOut.Blocca <> '' then
      exit;
    //Registrazione della ripartizione del dato relativa alla 13A Anno Prec.
    sCodTab:=Copy(selP552.FieldByName('NUMERO_TREDPREC').AsString,1,Pos('.',selP552.FieldByName('NUMERO_TREDPREC').AsString)-1);
    sCol:=Trim(Copy(selP552.FieldByName('NUMERO_TREDPREC').AsString,Pos('.',selP552.FieldByName('NUMERO_TREDPREC').AsString)+1,3));
    InserimentoDati(selP552.FieldByName('COD_ARROTONDAMENTO').AsString, sDatoLibero, sCodTab, sCol, '', rDato13APrec);
    if DatiOut.Blocca <> '' then
      exit;
    //Registrazione della ripartizione del dato relativa all'Acconto Anno Corr.
    sCodTab:=Copy(selP552.FieldByName('NUMERO_ARRCORR').AsString,1,Pos('.',selP552.FieldByName('NUMERO_ARRCORR').AsString)-1);
    sCol:=Trim(Copy(selP552.FieldByName('NUMERO_ARRCORR').AsString,Pos('.',selP552.FieldByName('NUMERO_ARRCORR').AsString)+1,3));
    InserimentoDati(selP552.FieldByName('COD_ARROTONDAMENTO').AsString, sDatoLibero, sCodTab, sCol, '', rDatoArrCorr);
    if DatiOut.Blocca <> '' then
      exit;
    //Registrazione della ripartizione del dato relativa all'Acconto Anno Prec.
    sCodTab:=Copy(selP552.FieldByName('NUMERO_ARRPREC').AsString,1,Pos('.',selP552.FieldByName('NUMERO_ARRPREC').AsString)-1);
    sCol:=Trim(Copy(selP552.FieldByName('NUMERO_ARRPREC').AsString,Pos('.',selP552.FieldByName('NUMERO_ARRPREC').AsString)+1,3));
    InserimentoDati(selP552.FieldByName('COD_ARROTONDAMENTO').AsString, sDatoLibero, sCodTab, sCol, '', rDatoArrPrec);
    if DatiOut.Blocca <> '' then
      exit;
  end;
  //Registrazione del dato da non ripartire sul dipendente
  InserimentoDati(selP552.FieldByName('COD_ARROTONDAMENTO').AsString, sDatoLibero, DatiInpCONTANN.CodTabella, selP552.FieldByName('COLONNA').AsString, '', rDato);
  if DatiOut.Blocca <> '' then
    exit;
  sDatoLibero:=OperSql.FieldByName('DATO_LIBERO').AsString;
  rDato:=0;
  rDato13ACorr:=0;
  rDato13APrec:=0;
  rDatoArrCorr:=0;
  rDatoArrPrec:=0;
end;

//Procedura principale di calcolo
begin
  //Scorrimento sulla query delle regole di calcolo
  selP552.First;
  if not selP552.Eof then
  begin
    while not selP552.Eof do
    begin
      if not(selP552.FieldByName('REGOLA_CALCOLO_MANUALE').IsNull) then
      begin
        rDato:=0;
        rDato13ACorr:=0;
        rDato13APrec:=0;
        rDatoArrCorr:=0;
        rDatoArrPrec:=0;
        sDatoLibero:='';
        OperSql.SQL.Text:=selP552.FieldByName('REGOLA_CALCOLO_MANUALE').AsString;
        //Imposta variabili per la query di calcolo
        ImpostaQueryCalcolo;
        if DatiOut.Blocca <> '' then
          exit;
        while not OperSql.Eof do
        begin
          if sDatoLibero = '' then
            sDatoLibero:=OperSql.FieldByName('DATO_LIBERO').AsString;
          if sDatoLibero <> OperSql.FieldByName('DATO_LIBERO').AsString then
          begin
            //Imposta dati e richiama registrazione sul dipendente
            ImpostaInserimentoDati;
            sDatoLibero:=OperSql.FieldByName('DATO_LIBERO').AsString;
          end;
          rDato:=rDato + StrToFloatDef(OperSql.FieldByName('DATO').AsString,0);
          //Gestione 13A Anno Corrente
          if not selP552.FieldByName('NUMERO_TREDCORR').IsNull and (OperSql.FieldByName('VOCE_BASE_TRED').AsString = 'TRED')
                 and (Copy(OperSql.FieldByName('MESE_COMPETENZA').AsString,1,4) = DatiInpCONTANN.AnnoElaborazione) then
          begin
            rDato:=rDato - StrToFloatDef(OperSql.FieldByName('DATO').AsString,0);
            if selP552.FieldByName('NUMERO_TREDCORR').AsString <> 'NC' then
              rDato13ACorr:=rDato13ACorr + StrToFloatDef(OperSql.FieldByName('DATO').AsString,0);
          end;
          //Gestione 13A Anno Precendente
          if not selP552.FieldByName('NUMERO_TREDPREC').IsNull and (OperSql.FieldByName('VOCE_BASE_TRED').AsString = 'TRED')
                 and (Copy(OperSql.FieldByName('MESE_COMPETENZA').AsString,1,4) < DatiInpCONTANN.AnnoElaborazione) then
          begin
            rDato:=rDato - StrToFloatDef(OperSql.FieldByName('DATO').AsString,0);
            if selP552.FieldByName('NUMERO_TREDPREC').AsString <> 'NC' then
              rDato13APrec:=rDato13APrec + StrToFloatDef(OperSql.FieldByName('DATO').AsString,0);
          end;
          //Gestione Arretrati Anno Corrente
          if not selP552.FieldByName('NUMERO_ARRCORR').IsNull and (OperSql.FieldByName('VOCE_BASE_TRED').AsString <> 'TRED')
            and (DeterminaArretrati(OperSql.FieldByName('MESE_COMPETENZA').AsString,OperSql.FieldByName('MESE_RETRIBUZIONE').AsString) = 'ArrAnnoCorr') then
          begin
            rDato:=rDato - StrToFloatDef(OperSql.FieldByName('DATO').AsString,0);
            if selP552.FieldByName('NUMERO_ARRCORR').AsString <> 'NC' then
              rDatoArrCorr:=rDatoArrCorr + StrToFloatDef(OperSql.FieldByName('DATO').AsString,0);
          end;
          //Gestione Arretrati Anno Precedente
          if not selP552.FieldByName('NUMERO_ARRPREC').IsNull and (OperSql.FieldByName('VOCE_BASE_TRED').AsString <> 'TRED')
            and (DeterminaArretrati(OperSql.FieldByName('MESE_COMPETENZA').AsString,OperSql.FieldByName('MESE_RETRIBUZIONE').AsString) = 'ArrAnniPrec') then
          begin
            rDato:=rDato - StrToFloatDef(OperSql.FieldByName('DATO').AsString,0);
            if selP552.FieldByName('NUMERO_ARRPREC').AsString <> 'NC' then
              rDatoArrPrec:=rDatoArrPrec + StrToFloatDef(OperSql.FieldByName('DATO').AsString,0);
          end;
          OperSql.Next;
        end;
        //Imposta dati e richiama registrazione sul dipendente, per gestire dati calcolati non ancora registrati
        ImpostaInserimentoDati
      end;
      selP552.Next;
    end;
  end
  else
    DatiOut.Blocca:=BloccaP948[2];
end;


procedure TP948FCalcoloContoAnnualeDtm.CalcoloDatiQueryRig;
//Calcolo i dati derivanti da query impostate per le righe
var
  sCodTab, sRig, sCodArr: String;
  rDato, rDato13ACorr, rDato13APrec, rDatoArrCorr, rDatoArrPrec: Real;

//Imposta suddivisione dati per spostamente di righe e richiama registrazione sul dipendente
procedure ImpostaInserimentoDati;
begin
  //Se non è gestita la modalità di accorpamento salto la suddivisione nei campi sostitutivi
  if selP552.FieldByName('DATA_ACCORPAMENTO').AsString <> 'NA' then
  begin
    sCodArr:='';
    //Registrazione della ripartizione del dato relativa alla 13A Anno Corr.
    sCodTab:=Copy(selP552.FieldByName('NUMERO_TREDCORR').AsString,1,Pos('.',selP552.FieldByName('NUMERO_TREDCORR').AsString)-1);
    sRig:=Trim(Copy(selP552.FieldByName('NUMERO_TREDCORR').AsString,Pos('.',selP552.FieldByName('NUMERO_TREDCORR').AsString)+1,3));
    InserimentoDati(selP552.FieldByName('COD_ARROTONDAMENTO').AsString, '', sCodTab, '1', sRig, rDato13ACorr);
    //Registrazione della ripartizione del dato relativa alla 13A Anno Prec.
    sCodTab:=Copy(selP552.FieldByName('NUMERO_TREDPREC').AsString,1,Pos('.',selP552.FieldByName('NUMERO_TREDPREC').AsString)-1);
    sRig:=Trim(Copy(selP552.FieldByName('NUMERO_TREDPREC').AsString,Pos('.',selP552.FieldByName('NUMERO_TREDPREC').AsString)+1,3));
    InserimentoDati(selP552.FieldByName('COD_ARROTONDAMENTO').AsString, '', sCodTab, '1', sRig, rDato13APrec);
    //Registrazione della ripartizione del dato relativa all'Acconto Anno Corr.
    sCodTab:=Copy(selP552.FieldByName('NUMERO_ARRCORR').AsString,1,Pos('.',selP552.FieldByName('NUMERO_ARRCORR').AsString)-1);
    sRig:=Trim(Copy(selP552.FieldByName('NUMERO_ARRCORR').AsString,Pos('.',selP552.FieldByName('NUMERO_ARRCORR').AsString)+1,3));
    InserimentoDati(selP552.FieldByName('COD_ARROTONDAMENTO').AsString, '', sCodTab, '1', sRig, rDatoArrCorr);
    //Registrazione della ripartizione del dato relativa all'Acconto Anno Prec.
    sCodTab:=Copy(selP552.FieldByName('NUMERO_ARRPREC').AsString,1,Pos('.',selP552.FieldByName('NUMERO_ARRPREC').AsString)-1);
    sRig:=Trim(Copy(selP552.FieldByName('NUMERO_ARRPREC').AsString,Pos('.',selP552.FieldByName('NUMERO_ARRPREC').AsString)+1,3));
    InserimentoDati(selP552.FieldByName('COD_ARROTONDAMENTO').AsString, '', sCodTab, '1', sRig, rDatoArrPrec);
  end;
  //Registrazione del dato da non ripartire sul dipendente
  sCodTab:='';
  sRig:='';
  InserimentoDati(selP552.FieldByName('COD_ARROTONDAMENTO').AsString, '', sCodTab, '1', sRig, rDato);
end;

//Procedura principale di calcolo
begin
  //Scorrimento sulla query delle regole di calcolo
  selP552.First;
  if not selP552.Eof then
  begin
    while not selP552.Eof do
    begin
      if not(selP552.FieldByName('REGOLA_CALCOLO_MANUALE').IsNull) then
      begin
        OperSql.SQL.Text:=selP552.FieldByName('REGOLA_CALCOLO_MANUALE').AsString;
        //Imposta variabili per la query di calcolo
        ImpostaQueryCalcolo;
        if DatiOut.Blocca <> '' then
          exit;
        while not OperSql.Eof do
        begin
          rDato:=StrToFloatDef(OperSql.FieldByName('DATO').AsString,0);
          if selP552.FieldByName('DATA_ACCORPAMENTO').AsString <> 'NA' then
          begin
            //Gestione 13A Anno Corrente
            if not selP552.FieldByName('NUMERO_TREDCORR').IsNull and (OperSql.FieldByName('VOCE_BASE_TRED').AsString = 'TRED')
                   and (Copy(OperSql.FieldByName('MESE_COMPETENZA').AsString,1,4) = DatiInpCONTANN.AnnoElaborazione) then
            begin
              rDato:=rDato - StrToFloatDef(OperSql.FieldByName('DATO').AsString,0);
              if selP552.FieldByName('NUMERO_TREDCORR').AsString <> 'NC' then
                rDato13ACorr:=StrToFloatDef(OperSql.FieldByName('DATO').AsString,0);
            end;
            //Gestione 13A Anno Precendente
            if not selP552.FieldByName('NUMERO_TREDPREC').IsNull and (OperSql.FieldByName('VOCE_BASE_TRED').AsString = 'TRED')
                   and (Copy(OperSql.FieldByName('MESE_COMPETENZA').AsString,1,4) < DatiInpCONTANN.AnnoElaborazione) then
            begin
              rDato:=rDato - StrToFloatDef(OperSql.FieldByName('DATO').AsString,0);
              if selP552.FieldByName('NUMERO_TREDPREC').AsString <> 'NC' then
                rDato13APrec:=StrToFloatDef(OperSql.FieldByName('DATO').AsString,0);
            end;
            //Gestione Arretrati Anno Corrente
            if not selP552.FieldByName('NUMERO_ARRCORR').IsNull and (OperSql.FieldByName('VOCE_BASE_TRED').AsString <> 'TRED')
              and (DeterminaArretrati(OperSql.FieldByName('MESE_COMPETENZA').AsString,OperSql.FieldByName('MESE_RETRIBUZIONE').AsString) = 'ArrAnnoCorr') then
            begin
              rDato:=rDato - StrToFloatDef(OperSql.FieldByName('DATO').AsString,0);
              if selP552.FieldByName('NUMERO_ARRCORR').AsString <> 'NC' then
                rDatoArrCorr:=StrToFloatDef(OperSql.FieldByName('DATO').AsString,0);
            end;
            //Gestione Arretrati Anno Precedente
            if not selP552.FieldByName('NUMERO_ARRPREC').IsNull and (OperSql.FieldByName('VOCE_BASE_TRED').AsString <> 'TRED')
              and (DeterminaArretrati(OperSql.FieldByName('MESE_COMPETENZA').AsString,OperSql.FieldByName('MESE_RETRIBUZIONE').AsString) = 'ArrAnniPrec') then
            begin
              rDato:=rDato - StrToFloatDef(OperSql.FieldByName('DATO').AsString,0);
              if selP552.FieldByName('NUMERO_ARRPREC').AsString <> 'NC' then
                rDatoArrPrec:=StrToFloatDef(OperSql.FieldByName('DATO').AsString,0);
            end;
          end;
          //Imposta suddivisione dati e richiama registrazione sul dipendente
          ImpostaInserimentoDati;
          OperSql.Next;
        end;
      end;
      selP552.Next;
    end;
  end
  else
    DatiOut.Blocca:=BloccaP948[2];
end;

procedure TP948FCalcoloContoAnnualeDtm.ImpostaQueryCalcolo;
//Imposta variabili per la query di calcolo
begin
  OperSql.DeleteVariables;
  OperSql.Close;
  if Pos(':Progressivo',OperSql.SQL.Text) > 0 then
  begin
    OperSql.DeclareVariable('Progressivo',otInteger);
    OperSql.SetVariable('Progressivo',DatiInpCONTANN.Progressivo);
  end;
  if Pos(':AnnoElaborazione',OperSql.SQL.Text) > 0 then
  begin
    OperSql.DeclareVariable('AnnoElaborazione',otString);
    OperSql.SetVariable('AnnoElaborazione',DatiInpCONTANN.AnnoElaborazione);
  end;
  if Pos(':DataInizioElaborazione',OperSql.SQL.Text) > 0 then
  begin
    OperSql.DeclareVariable('DataInizioElaborazione',otDate);
    OperSql.SetVariable('DataInizioElaborazione',DatiInpCONTANN.DataInizioElaborazione);
  end;
  if Pos(':DataFineElaborazione',OperSql.SQL.Text) > 0 then
  begin
    OperSql.DeclareVariable('DataFineElaborazione',otDate);
    OperSql.SetVariable('DataFineElaborazione',R180FineMese(DatiInpCONTANN.DataFineElaborazione));
  end;
  if Pos(':StatoCedolini',OperSql.SQL.Text) > 0 then
  begin
    OperSql.DeclareVariable('StatoCedolini',otSubst);
    OperSql.SetVariable('StatoCedolini',DatiInpCONTANN.StatoCedolini);
  end;
  if Pos(':Parametro',OperSql.SQL.Text) > 0 then
  begin
    OperSql.DeclareVariable('Parametro',otSubst);
    if (DatiInpCONTANN.TipoTabellaRighe = '0') or (DatiInpCONTANN.TipoTabellaRighe = '1') then
      OperSql.SetVariable('Parametro',selP552.FieldByName('VALORE_COSTANTE').AsString)
    else
    if DatiInpCONTANN.TipoTabellaRighe = '2' then
      OperSql.SetVariable('Parametro',selP552.FieldByName('CODICI_ACCORPAMENTOVOCI').AsString);
  end;
  if Pos(':FiltroDipendenti',OperSql.SQL.Text) > 0 then
  begin
    OperSql.DeclareVariable(':FiltroDipendenti',otSubst);
    if Trim(selP552c.FieldByName('FILTRO_DIPENDENTI').AsString) = '' then
      OperSql.SetVariable(':FiltroDipendenti','1 = 1')
    else
      OperSql.SetVariable(':FiltroDipendenti',selP552c.FieldByName('FILTRO_DIPENDENTI').AsString);
  end;
  if Pos(':TipologiaRighe',OperSql.SQL.Text) > 0 then
  begin
    OperSql.DeclareVariable('TipologiaRighe',otSubst);
    OperSql.SetVariable('TipologiaRighe',DatiInpCONTANN.ValoreCostante);
  end;
  if Pos(':DataAccorpamento',OperSql.SQL.Text) > 0 then
  begin
    OperSql.DeclareVariable('DataAccorpamento',otSubst);
    if selP552.FieldByName('DATA_ACCORPAMENTO').AsString = 'DC' then
      OperSql.SetVariable('DataAccorpamento','DATA_CEDOLINO')
    else if selP552.FieldByName('DATA_ACCORPAMENTO').AsString = 'DR' then
      OperSql.SetVariable('DataAccorpamento','DATA_RETRIBUZIONE')
    else if selP552.FieldByName('DATA_ACCORPAMENTO').AsString = 'CM' then
      OperSql.SetVariable('DataAccorpamento','DATA_COMPETENZA_A')
    else
    begin
      DatiOut.Blocca:=BloccaP948[3] + ' Colonna = ' + selP552.FieldByName('COLONNA').AsString;
      exit;
    end;
  end;
  try
    OperSql.Open;
  except
    DatiOut.Blocca:=BloccaP948[6] + DatiInpCONTANN.CodTabella + ' testo query ' + OperSql.SQL.Text;
  end;
end;

function TP948FCalcoloContoAnnualeDtm.DeterminaArretrati(sAnnoMeseComp,sAnnoMeseRetr:String):String;
//Gestione Arretrati Anno Corrente
begin
  Result:='Normale';
  if DatiInpCONTANN.AnnoElaborazione = Copy(sAnnoMeseRetr,1,4) then
  begin
    if (Copy(sAnnoMeseComp,1,4) = Copy(sAnnoMeseRetr,1,4)) and (Copy(sAnnoMeseComp,5,2) < Copy(sAnnoMeseRetr,5,2)) then
      Result:='ArrAnnoCorr';
    if Copy(sAnnoMeseComp,1,4) < Copy(sAnnoMeseRetr,1,4) then
      Result:='ArrAnniPrec';
  end
  else
  begin
    if Copy(sAnnoMeseComp,1,4) = DatiInpCONTANN.AnnoElaborazione then
      Result:='ArrAnnoCorr';
    if Copy(sAnnoMeseComp,1,4) < DatiInpCONTANN.AnnoElaborazione then
      Result:='ArrAnniPrec';
  end;
end;

procedure TP948FCalcoloContoAnnualeDtm.InserimentoDati(sCodArrotondamento, sDatoLibero, sCodTabella, sColonna, sRiga :String; rDato :Real);
//Registrazione dati sul dipendente
var
  iIdContoAnnuale, iRiga: Integer;
begin
  //Se il dato è a zero non effettuo registrazioni per evitare valori infinitesimali testo abs < 0,0001
  if Abs(rDato) < 0.0001
    then exit;
  //Nel caso di tabelle con tipologia righe qualifica ministeriale se il dato è Nullo do anomalia
  if DatiInpCONTANN.TipoTabellaRighe = '0' then
  begin
    if (selT430.GetVariable('AnnoElaborazione') <> DatiInpCONTANN.AnnoElaborazione)
      or (selT430.GetVariable('Progressivo') <> DatiInpCONTANN.Progressivo)
      or (selT430.GetVariable('Dato_Libero') <> DatiInpCONTANN.ValoreCostante) then
    begin
      selT430.SetVariable('AnnoElaborazione',DatiInpCONTANN.AnnoElaborazione);
      selT430.SetVariable('Progressivo',DatiInpCONTANN.Progressivo);
      selT430.SetVariable('Dato_Libero',DatiInpCONTANN.ValoreCostante);
      selT430.Close;
      selT430.Open;
    end;
    if selT430.Eof then
    begin
      DatiOut.Blocca:=BloccaP948[1] + ' Campo = ' + DatiInpCONTANN.ValoreCostante + ' ' + sDatoLibero;
      exit;
    end;
  end;
  //Nel caso di tabelle con tipologia righe altro dato libero o funzione Oracle, se il dato è Nullo do anomalia
  if DatiInpCONTANN.TipoTabellaRighe = '1' then
  begin
    if sDatoLibero = '' then
    begin
      DatiOut.Blocca:=BloccaP948[1] + ' Campo = ' + DatiInpCONTANN.ValoreCostante + ' ' + sDatoLibero;
      exit;
    end;
  end;
  if sCodTabella = '' then
    sCodTabella:=DatiInpCONTANN.CodTabella;
  if sColonna = '' then
    sColonna:=selP552.FieldByName('COLONNA').AsString;
  if sRiga = '' then
    sRiga:=selP552.FieldByName('RIGA').AsString;
  //Se il dato libero è valorizzato, devo ricercare la riga su cui registrare il dato
  if sDatoLibero <> '' then
  begin
    if not selP552a.SearchRecord('VALORE_COSTANTE',VarArrayOf([sDatoLibero]),[srFromBeginning]) then
    begin
      //Non esiste la riga per il dato libero
      DatiOut.Blocca:=BloccaP948[4] + ' ' + sDatoLibero + ' del campo ' + DatiInpCONTANN.ValoreCostante;
      exit;
    end
    else
      iRiga:=selP552a.FieldByName('RIGA').AsInteger;
  end
  else
    iRiga:=StrToInt(sRiga);
  //Se cambia tabella o colonna o riga ricerco l'arrotondamento da applicare al dato destinazione
  //Nel caso di tabelle con dati registrati su colonne diverse verifico cambio colonne
  if (DatiInpCONTANN.TipoTabellaRighe = '0') or (DatiInpCONTANN.TipoTabellaRighe = '1') then
  begin
    if ((sCodTabella <> DatiInpCONTANN.CodTabella) or (sColonna <> selP552.FieldByName('COLONNA').AsString))
      and (selP552b.SearchRecord('COD_TABELLA;COLONNA',VarArrayOf([sCodTabella,sColonna]),[srFromBeginning])) then
    sCodArrotondamento:=selP552b.FieldByName('COD_ARROTONDAMENTO').AsString;
  end
  else
    //Nel caso di tabelle con dati registrati su righe diverse verifico cambio righe
    if ((sCodTabella <> DatiInpCONTANN.CodTabella) or (sRiga <> selP552.FieldByName('RIGA').AsString))
        and (selP552b.SearchRecord('COD_TABELLA;RIGA',VarArrayOf([sCodTabella,sRiga]),[srFromBeginning])) then
      sCodArrotondamento:=selP552b.FieldByName('COD_ARROTONDAMENTO').AsString;
  iIdContoAnnuale:=DatiInpCONTANN.Id_CONTANN;
  //Se cambia tabella ricerco l'id su cui registrare il dato
  if sCodTabella <> DatiInpCONTANN.CodTabella then
    //Leggo la testata per impostare Id_FLUSSO_Aperto
    iIdContoAnnuale:=P554FElaborazioneContoAnnuale.TestataCONTANN(sCodTabella);
  if DatiOut.Blocca <> '' then
  begin
    DatiOut.Blocca:=DatiOut.Blocca + ' Colonna ' + sColonna;
    exit;
  end;
  //Nella fase di registrazione viene gestito l'update con il valore in somma algebrica se esisteva già
  scrP555.SetVariable('IdCONTANN',iIdContoAnnuale);
  scrP555.SetVariable('Progressivo',DatiInpCONTANN.Progressivo);
  scrP555.SetVariable('Riga',iRiga);
  scrP555.SetVariable('Colonna',StrToInt(sColonna));
  scrP555.SetVariable('Valore',rDato);
  scrP555.Execute;
end;

end.

