unit A073UAcquistoBuoniMW;

interface

uses
  Windows, Messages, SysUtils,StrUtils,Math, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, OracleData, DB, DBClient, A000UInterfaccia, C180FunzioniGenerali,
  DatiBloccati,R005UDataModuleMW, R350UCalcoloBuoniDtM;

type
  TA073FAcquistoBuoniMW = class(TR005FDataModuleMW)
    BuoniPasto: TClientDataSet;
    selT680: TOracleDataSet;
    selT690: TOracleDataSet;
    selT691: TOracleDataSet;
    selT690DataInizio: TOracleDataSet;
    selT690_IDBLOCCHETTI: TOracleDataSet;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    function  ControllaBlocchettiParziali:String;
    procedure GetMaturazione;
    procedure GetAcquisto;
    procedure CreaBuoniPasto;
  public
    BuoniPastoMaturati, Messaggio, TicketMaturati, BuoniPastoAcquistati, TicketAcquistati: String;
    Anomalie:boolean;
    Progressivo:LongInt;
    Q690: TOracleDataSet;
    selDatiBloccati:TDatiBloccati;
    Inizio,Fine,DataA:TDateTime;
    R350FCalcoloBuoniDtM:TR350FCalcoloBuoniDtM;
    procedure InizializzaQ690;
    procedure CalcolaRiepilogo;
    procedure CreaBuoniPastoCDS;
    procedure Q690AfterPost;
    function  Q690BeforePost:String;
    procedure Q690DATAValidate(Sender: TField);
    procedure Q690ID_BLOCCHETTIValidate(Sender: TField);
  end;


implementation

{$R *.dfm}

procedure TA073FAcquistoBuoniMW.DataModuleCreate(Sender: TObject);
begin
  inherited;
  selDatiBloccati:=TDatiBloccati.Create(Self);
  selDatiBloccati.TipoLog:='M';
  selT691.Open;
  R350FCalcoloBuoniDtM:=TR350FCalcoloBuoniDtM.Create(nil);
end;

procedure TA073FAcquistoBuoniMW.DataModuleDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(selDatiBloccati);
  FreeAndNil(R350FCalcoloBuoniDtM);
end;

procedure TA073FAcquistoBuoniMW.InizializzaQ690;
begin
  Q690.FieldByName('DATA_MAGAZZINO').Visible:=selT691.RecordCount > 0;
  Q690.FieldByName('ID_BLOCCHETTI').Visible:=False;
  while not selT691.Eof do
  begin
    if (not selT691.FieldByName('ID_DAL').IsNull) and (not selT691.FieldByName('ID_AL').IsNull) then
    begin
      Q690.FieldByName('ID_BLOCCHETTI').Visible:=True;
      Break;
    end;
    selT691.Next;
  end;
end;

procedure TA073FAcquistoBuoniMW.Q690AfterPost;
var D:TDateTime;
begin
  D:=Q690.FieldByName('Data').AsDateTime;
  Q690.Refresh;
  Q690.Locate('Data',D,[]);
end;

function TA073FAcquistoBuoniMW.Q690BeforePost:String;
var DS:TDateTime;
begin
  if (not Q690.FieldByName('DATA_MAGAZZINO').IsNull) then
  begin
    DS:=selT691.Lookup('DATA_ACQUISTO',Q690.FieldByName('DATA_MAGAZZINO').AsDateTime,'DATA_SCADENZA');
    DS:=IfThen(DS = EncodeDate(1900,12,30),EncodeDate(3999,12,31),DS);
    if not R180Between(Q690.FieldByName('DATA').AsDateTime,Q690.FieldByName('DATA_MAGAZZINO').AsDateTime,DS) then
      raise Exception.Create(Format('La data di acquisto deve essere compresa tra il %s e il %s!',[Q690.FieldByName('DATA_MAGAZZINO').AsString,DateToStr(DS)]));
  end;
  Q690ID_BLOCCHETTIValidate(Q690.FieldByName('ID_BLOCCHETTI'));
  if Q690.FieldByName('ID_BLOCCHETTI').IsNull and Q690.FieldByName('ID_BLOCCHETTI').Required then
    raise Exception.Create('Indicare un elenco valido di blocchetti!');
  Result:=ControllaBlocchettiParziali;
end;

procedure TA073FAcquistoBuoniMW.Q690DATAValidate(Sender: TField);
begin
  if (Q690.FieldByName('DATA_MAGAZZINO').IsNull) and (selT691.RecordCount > 0) then
  begin
    //selT691.Last;
    selT691.First;
    //while not selT691.Bof do
    while not selT691.Eof do
    begin
      if R180Between(Q690.FieldByName('DATA').AsDateTime,
                     selT691.FieldByName('DATA_ACQUISTO').AsDateTime,
                     IfThen(selT691.FieldByName('DATA_SCADENZA').IsNull,EncodeDate(3999,12,31),selT691.FieldByName('DATA_SCADENZA').AsDateTime))
      then
      begin
        Q690.FieldByName('DATA_MAGAZZINO').AsDateTime:=selT691.FieldByName('DATA_ACQUISTO').AsDateTime;
        Break;
      end
      else
        //selT691.Prior;
        selT691.Next;
    end;
  end;
end;

procedure TA073FAcquistoBuoniMW.Q690ID_BLOCCHETTIValidate(Sender: TField);
var lst:TStringList;
    i,j,id:Integer;
    Trovato:Boolean;
    Campo:String;
begin
  if (not Q690.FieldByName('ID_BLOCCHETTI').IsNull) and
     (Q690.FieldByName('ID_BLOCCHETTI').AsString <> '*') then
  begin
    lst:=TStringList.Create;
    try
      lst.CommaText:=Q690.FieldByName('ID_BLOCCHETTI').AsString;
      for i:=0 to lst.Count - 1 do
        if not TryStrToInt(Trim(lst[i]),id) then
          raise Exception.Create('Blocchetto non valido! Il dato deve essere numerico.')
        else
        begin
          if (not Q690.FieldByName('DATA_MAGAZZINO').IsNull) and (not selT691.SearchRecord('DATA_ACQUISTO',Q690.FieldByName('DATA_MAGAZZINO').AsDateTime,[srFromBeginning])) then
            raise Exception.Create('Fornitura non presente in magazzino!');
          Trovato:=Q690.FieldByName('DATA_MAGAZZINO').IsNull;
          if not Trovato then
            Trovato:=R180Between(id,selT691.FieldByName('ID_DAL').AsInteger,selT691.FieldByName('ID_AL').AsInteger);
          if not Trovato then
            raise Exception.Create(Format('Blocchetto %d non presente nella fornitura del %s (%d - %d)',[id,Q690.FieldByName('DATA_MAGAZZINO').AsString,selT691.FieldByName('ID_DAL').AsInteger,selT691.FieldByName('ID_AL').AsInteger]));
          for j:=i + 1 to lst.Count - 1 do
            if Trim(lst[i]) = Trim(lst[j]) then
              raise Exception.Create(Format('Blocchetto %d ripetuto!',[id]));
        end;
      if not Q690.FieldByName('DATA_MAGAZZINO').IsNull and (selT691.FieldByName('DIM_BLOCCHETTO').AsInteger > 0) then
      begin
        if selT691.FieldByName('BUONIPASTO').AsInteger > 0 then
          Campo:='BUONIPASTO'
        else
          Campo:='TICKET';
        if Q690.FieldByName(Campo).IsNull then
          Q690.FieldByName(Campo).AsInteger:=i * selT691.FieldByName('DIM_BLOCCHETTO').AsInteger;
      end;
    finally
      FreeAndNil(lst);
    end;
  end;
end;

function TA073FAcquistoBuoniMW.ControllaBlocchettiParziali:String;
var lst,lst2:TStringList;
    i,j,id,TotBuoni,TotBlocc:Integer;
    Campo,s,IdRighe:String;
begin
  Result:='';
  if not Q690.FieldByName('ID_BLOCCHETTI').IsNull then
  begin
    lst:=TStringList.Create;
    lst2:=TStringList.Create;
    IdRighe:='';
    TotBuoni:=0;
    try
      lst.CommaText:=Q690.FieldByName('ID_BLOCCHETTI').AsString;
      if (not Q690.FieldByName('DATA_MAGAZZINO').IsNull) and
         (selT691.SearchRecord('DATA_ACQUISTO',Q690.FieldByName('DATA_MAGAZZINO').AsDateTime,[srFromBeginning])) and
         (selT691.FieldByName('DIM_BLOCCHETTO').AsInteger > 0) then
      begin
        if selT691.FieldByName('BUONIPASTO').AsInteger > 0 then
          Campo:='BUONIPASTO'
        else
          Campo:='TICKET';
        lst2.Assign(lst);
        TotBuoni:=Q690.FieldByName(Campo).AsInteger;
      end;
      for i:=0 to lst.Count - 1 do
        if TryStrToInt(Trim(lst[i]),id) then
        begin
          selT690_IDBLOCCHETTI.Close;
          selT690_IDBLOCCHETTI.SetVariable('IDRIGA',IfThen(Q690.State = dsEdit,Q690.RowID,''));
          selT690_IDBLOCCHETTI.SetVariable('ID_BLOCCHETTO',IntToStr(id));
          selT690_IDBLOCCHETTI.Open;
          if selT690_IDBLOCCHETTI.RecordCount > 0 then
          begin
            s:='';
            while not selT690_IDBLOCCHETTI.Eof do
            begin
              s:=s + #13#10 + Format('%s %s (matricola %s) il %s - acquisto complessivo: %d',
                                     [selT690_IDBLOCCHETTI.FieldByName('COGNOME').AsString,
                                      selT690_IDBLOCCHETTI.FieldByName('NOME').AsString,
                                      selT690_IDBLOCCHETTI.FieldByName('MATRICOLA').AsString,
                                      selT690_IDBLOCCHETTI.FieldByName('DATA').AsString,
                                      selT690_IDBLOCCHETTI.FieldByName('BUONIPASTO').AsInteger + selT690_IDBLOCCHETTI.FieldByName('TICKET').AsInteger]);
              selT690_IDBLOCCHETTI.Next;
            end;
            Result:=Result + #13#10 + Format('Blocchetto %d già acquistato da:' + s + #13#10,[id]);
            //if R180MessageBox(Format('Blocchetto %d già acquistato da:' + s + #13#10 + 'Confermare?',[id]),'DOMANDA') = mrNo then
            //  Abort;

            selT690_IDBLOCCHETTI.First;
            while not selT690_IDBLOCCHETTI.Eof do
            begin
              if Pos(selT690_IDBLOCCHETTI.RowID,IdRighe) = 0 then
              begin
                IdRighe:=IdRighe + ',' + selT690_IDBLOCCHETTI.RowID;
                inc(TotBuoni,selT690_IDBLOCCHETTI.FieldByName(Campo).AsInteger);
                with TStringList.Create do
                try
                  CommaText:=Trim(selT690_IDBLOCCHETTI.FieldByName('ID_BLOCCHETTI').AsString);
                  for j:=0 to Count - 1 do
                    if lst2.IndexOf(Strings[j]) = -1 then
                      lst2.Add(Strings[j]);
                finally
                  Free;
                end;
              end;
              selT690_IDBLOCCHETTI.Next;
            end;
          end;
        end;
      TotBlocc:=lst2.Count;
      if TotBuoni > TotBlocc * selT691.FieldByName('DIM_BLOCCHETTO').AsInteger then
        raise Exception.Create(Format('Attenzione: risulta un''eccedenza di numero %d buoni acquistati rispetto a quelli disponibili.',[TotBuoni - TotBlocc * selT691.FieldByName('DIM_BLOCCHETTO').AsInteger]));
    finally
      FreeAndNil(lst);
    end;
  end;
end;

procedure TA073FAcquistoBuoniMW.CalcolaRiepilogo;
begin
  R350FCalcoloBuoniDtM.R502ProDtM1.PeriodoConteggi(Inizio,Fine);
  GetMaturazione;
  GetAcquisto;
end;

procedure TA073FAcquistoBuoniMW.GetAcquisto;
begin
  BuoniPastoAcquistati:='0';
  TicketAcquistati:='0';
  with R350FCalcoloBuoniDtM.Q690 do
  begin
    SetVariable('PROGRESSIVO',Progressivo);
    SetVariable('DATA1',Inizio);
    SetVariable('DATA2',Fine);
    Execute;
    BuoniPastoAcquistati:=VarToStr(GetVariable('BUONI'));
    TicketAcquistati:=VarToStr(GetVariable('TICKET'));
  end;
  with R350FCalcoloBuoniDtM.Q692 do
  begin
    Close;
    SetVariable('PROGRESSIVO',Progressivo);
    SetVariable('DATA',Fine);
    Open;
    if RecordCount > 0 then
    begin
      if FieldByName('BUONIPASTO').AsInteger <> 0 then
        BuoniPastoAcquistati:=BuoniPastoAcquistati + Format(' (%d)',[FieldByName('BUONIPASTO').AsInteger]);
      if FieldByName('TICKET').AsInteger <> 0 then
        TicketAcquistati:=TicketAcquistati + Format(' (%d)',[FieldByName('TICKET').AsInteger]);
    end;
  end;
end;

procedure TA073FAcquistoBuoniMW.GetMaturazione;
var DI,DF,DataCorr:TDateTime;
    NB,NT,B,T,i,j:Integer;
    A1,A2,M1,M2,G:Word;
    ObblSuppl,S:String;
begin
  DI:=Inizio;
  DF:=Fine;
  with R350FCalcoloBuoniDtM.selPeriodoServizio do
  begin
    Close;
    SetVariable('PROGRESSIVO',Progressivo);
    SetVariable('DATAINIZIO',Inizio);
    SetVariable('DATAFINE',Fine);
    Open;
    if FieldByName('INIZIO').AsDateTime > DI then
      DI:=FieldByName('INIZIO').AsDateTime;
    if FieldByName('FINE').AsDateTime < DF then
      DF:=FieldByName('FINE').AsDateTime;
    Close;
  end;
  Anomalie:=False;
  BuoniPastoMaturati:='0';
  TicketMaturati:='0';
  NB:=0;
  NT:=0;
  R350FCalcoloBuoniDtM.QSBuonoMensa.GetDatiStorici('T430' + Parametri.CampiRiferimento.C4_BuoniMensa,Progressivo,DI,DF);
  DataCorr:=DI;
  while DataCorr <= DF do
  begin
    R350FCalcoloBuoniDtM.CalcolaBuoni(Progressivo,DataCorr,B,T,ObblSuppl,S);
    if S <> '' then
      Anomalie:=True;
    inc(NB,B);
    inc(NT,T);
    DataCorr:=DataCorr + 1;
  end;
  BuoniPastoMaturati:=IntToStr(NB);
  TicketMaturati:=IntToStr(NT);
  //Lettura variazioni manuali
  NB:=0;
  NT:=0;
  DecodeDate(DI,A1,M1,G);
  if G > 1 then
  begin
    M1:=M1 + 1;
    if M1 = 13 then
    begin
      M1:=1;
      inc(A1);
    end;
  end;
  DecodeDate(DF,A2,M2,G);
  if G < R180GiorniMese(DF) then
  begin
    M2:=M2 - 1;
    if M2 = 0 then
    begin
      M2:=12;
      dec(A2);
    end;
  end;
  j:=M1;
  for i:=A1 to A2 do
    while True do
    begin
      if (i = A2) and (j > M2) then
        Break;
      R350FCalcoloBuoniDtM.GetVariazioni(Progressivo,i,j,B,T);
      inc(NB,B);
      inc(NT,T);
      inc(j);
      if j = 13 then
      begin
        j:=1;
        Break;
      end;
    end;
  if NB <> 0 then
  begin
    S:=IntToStr(NB);
    if NB > 0 then S:='+' + S;
    BuoniPastoMaturati:=BuoniPastoMaturati + '(' + S + ')';
  end;
  if NT <> 0 then
  begin
    S:=IntToStr(NT);
    if NT > 0 then S:='+' + S;
    TicketMaturati:=TicketMaturati + '(' + S + ')';
  end;
end;

procedure TA073FAcquistoBuoniMW.CreaBuoniPastoCDS;
var BuoniResidui,BuoniScaduti,BuoniUsati,BuoniAcquistati:Integer;
    OldData:TDateTime;
begin
  CreaBuoniPasto;
  SelAnagrafe.First;
  while not SelAnagrafe.EOF do
  begin
    selT690DataInizio.Close;
    selT690DataInizio.SetVariable('PROGRESSIVO',SelAnagrafe.FieldByName('Progressivo').AsInteger);
    selT690DataInizio.SetVariable('DATA',DataA);
    selT690DataInizio.Open;
    selT680.Close;
    selT680.SetVariable('PROGRESSIVO',SelAnagrafe.FieldByName('Progressivo').AsInteger);
    selT680.SetVariable('DATADAL',selT690DataInizio.FieldByName('DATA').AsDateTime);
    selT680.SetVariable('DATAAL',DataA);
    selT680.Open;
    selT690.Close;
    selT690.SetVariable('PROGRESSIVO',SelAnagrafe.FieldByName('Progressivo').AsInteger);
    selT690.SetVariable('DATA',DataA);
    selT690.Open;
    BuoniUsati:=0;
    BuoniScaduti:=0;
    BuoniAcquistati:=0;
    BuoniResidui:=0;
    while not selT680.Eof do
    begin
      BuoniUsati:=BuoniUsati + selT680.FieldByName('BUONIPASTO').AsInteger;
      while not selT690.Eof do
      begin
        if (selT680.FieldByName('DATA').AsDateTime <= OldData) then
        begin
          if BuoniResidui >= selT680.FieldByName('BUONIPASTO').AsInteger then
            break;
        end
        else
        begin
          BuoniScaduti:=BuoniScaduti + BuoniResidui;
          BuoniResidui:=0;
        end;
        OldData:=selT690.FieldByName('DATA_SCADENZA').AsDateTime;
        BuoniResidui:=BuoniResidui + selT690.FieldByName('BUONIPASTO').AsInteger;
        BuoniAcquistati:=BuoniAcquistati + selT690.FieldByName('BUONIPASTO').AsInteger;
        selT690.Next;
      end;
      if (selT680.FieldByName('DATA').AsDateTime > OldData) then
        break;
      BuoniResidui:=BuoniResidui - selT680.FieldByName('BUONIPASTO').AsInteger;
      selT680.Next;
    end;
    if OldData <  selT680.FieldByName('DATA').AsDateTime then
    begin
      BuoniScaduti:=BuoniScaduti + BuoniResidui;
      BuoniResidui:=0-selT680.FieldByName('BUONIPASTO').AsInteger;
    end;
    while not selT690.Eof do
    begin
      if selT690.FieldByName('DATA_SCADENZA').AsDateTime < DataA then
        BuoniScaduti:=BuoniScaduti + selT690.FieldByName('BUONIPASTO').AsInteger
      else
        BuoniResidui:=BuoniResidui + selT690.FieldByName('BUONIPASTO').AsInteger;
      BuoniAcquistati:=BuoniAcquistati + selT690.FieldByName('BUONIPASTO').AsInteger;
      selT690.Next;
    end;
    BuoniPasto.Append;
    BuoniPasto.FieldByName('MATRICOLA').AsString:=SelAnagrafe.FieldByName('MATRICOLA').AsString;
    BuoniPasto.FieldByName('COGNOME').AsString:=SelAnagrafe.FieldByName('COGNOME').AsString;
    BuoniPasto.FieldByName('NOME').AsString:=SelAnagrafe.FieldByName('NOME').AsString;
    BuoniPasto.FieldByName('BUONIRESIDUI').AsInteger:=BuoniResidui;
    BuoniPasto.FieldByName('BUONISCADUTI').AsInteger:=BuoniScaduti;
    BuoniPasto.FieldByName('BUONIACQUISTATI').AsInteger:=BuoniAcquistati;
    BuoniPasto.FieldByName('BUONIMATURATI').AsInteger:=BuoniUsati;
    BuoniPasto.Post;
    SelAnagrafe.Next;
  end;
end;

procedure TA073FAcquistoBuoniMW.CreaBuoniPasto;
begin
  BuoniPasto.Close;
  BuoniPasto.FieldDefs.Clear;
  BuoniPasto.FieldDefs.Add('Matricola',ftString,8,False);
  BuoniPasto.FieldDefs.Add('Cognome',ftString,60,False);
  BuoniPasto.FieldDefs.Add('Nome',ftString,60,False);
  BuoniPasto.FieldDefs.Add('BuoniResidui',ftInteger,0,False);
  BuoniPasto.FieldDefs.Add('BuoniScaduti',ftInteger,0,False);
  BuoniPasto.FieldDefs.Add('BuoniAcquistati',ftInteger,0,False);
  BuoniPasto.FieldDefs.Add('BuoniMaturati',ftInteger,0,False);
  BuoniPasto.IndexDefs.Clear;
  BuoniPasto.IndexDefs.Add('Primario',('Matricola'),[ixUnique]);
  BuoniPasto.IndexName:='Primario';
  BuoniPasto.CreateDataSet;
  BuoniPasto.LogChanges:=False;
end;

end.
