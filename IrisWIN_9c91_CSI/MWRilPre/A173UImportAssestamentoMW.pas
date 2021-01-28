unit A173UImportAssestamentoMW;

interface

uses R005UDataModuleMW, Forms, Classes, DB, OracleData, SysUtils, StrUtils, Math,
  R450, A000UInterfaccia, A000UMessaggi, A000USessione, C180FunzioniGenerali;

type
  TA173FImportAssestamentoMW = class(TR005FDataModuleMW)
    selT030: TOracleDataSet;
    selT305: TOracleDataSet;
    selT070: TOracleDataSet;
    selT071: TOracleDataSet;
    procedure DataModuleCreate(Sender: TObject);
  private
    R450DtM1:TR450DtM1;
  public
    nNumRiga,nTotRighe:integer;
    FIn: TextFile;
    procedure ApriFile(NomeFile: String);
    procedure RecuperaTotaleRigheFile;
    procedure ElaboraRiga(TipoElab:String);
  end;

implementation

{$R *.dfm}

procedure TA173FImportAssestamentoMW.DataModuleCreate(Sender: TObject);
begin
  if not(SessioneOracle.Connected) then
  begin
    Password(Application.Name);
    A000ParamDBOracle(SessioneOracle);
  end;
  inherited;
end;

procedure TA173FImportAssestamentoMW.ApriFile(NomeFile:String);
begin
  try
    AssignFile(FIn, NomeFile);
    Reset(FIn);
  except
    raise Exception.Create(Format(A000MSG_ERR_FMT_APRI_FILE,[NomeFile]));
  end;
end;

procedure TA173FImportAssestamentoMW.RecuperaTotaleRigheFile;
var sRigaIn: String;
    NSeparatori:Integer;
begin
  nTotRighe:=0;
  while not Eof(FIn) do
  begin
    Readln(FIn,sRigaIn);
    nTotRighe:=nTotRighe + 1;
    NSeparatori:=0;
    while Pos(';',sRigaIn) > 0 do
    begin
      inc(NSeparatori);
      sRigaIn:=Copy(sRigaIn,Pos(';',sRigaIn)+1);
    end;
    if NSeparatori <> 6 then
    begin
      CloseFile(FIn);
      raise exception.Create(A000MSG_A173_ERR_COLONNE_FILE);
    end;
  end;
  CloseFile(FIn);
end;

procedure TA173FImportAssestamentoMW.ElaboraRiga(TipoElab:String);
var
  sRigaIn,S2,Matricola,Segno,Ore,Minuti,Causale,Anno,Mese: String;
  AnnoW,MeseW: Word;
  DataMese: TDateTime;
  NumMinuti: Real;
  Progressivo: Integer;
  RigaVuota: Boolean;
  bCancAssest: boolean;
begin
  nNumRiga:=nNumRiga + 1;
  Readln(FIn,sRigaIn);
  sRigaIn:=sRigaIn + ';';
  //Se la riga è vuota, la salto
  S2:=sRigaIn;
  RigaVuota:=True;
  while Pos(';',S2) > 0 do
  begin
    if Trim(Copy(S2,1,Pos(';',S2) - 1)) <> '' then
    begin
      RigaVuota:=False;
      Break;
    end;
    S2:=Copy(S2,Pos(';',S2) + 1);
  end;
  if RigaVuota then
    Exit;
  //Prelevo i dati del record
  Matricola:=Trim(Copy(sRigaIn,1,Pos(';',sRigaIn)-1));
  sRigaIn:=Copy(sRigaIn,Pos(';',sRigaIn)+1);
  Anno:=Trim(Copy(sRigaIn,1,Pos(';',sRigaIn)-1));
  sRigaIn:=Copy(sRigaIn,Pos(';',sRigaIn)+1);
  Mese:=Format('%2.2d',[StrToInt(Trim(Copy(sRigaIn,1,Pos(';',sRigaIn)-1)))]);
  sRigaIn:=Copy(sRigaIn,Pos(';',sRigaIn)+1);
  Segno:=Trim(Copy(sRigaIn,1,Pos(';',sRigaIn)-1));
  if Segno <> '-' then
    Segno:='0';
  sRigaIn:=Copy(sRigaIn,Pos(';',sRigaIn)+1);
  Ore:=Format('%3.3d',[StrToInt(Trim(Copy(sRigaIn,1,Pos(';',sRigaIn)-1)))]);
  sRigaIn:=Copy(sRigaIn,Pos(';',sRigaIn)+1);
  Minuti:=Format('%2.2d',[StrToInt(Trim(Copy(sRigaIn,1,Pos(';',sRigaIn)-1)))]);
  sRigaIn:=Copy(sRigaIn,Pos(';',sRigaIn)+1);
  Causale:=Trim(Copy(sRigaIn,1,Pos(';',sRigaIn)-1));
  if (Anno < '1900') or (Anno > '3999') then
  begin
    RegistraMsg.InserisciMessaggio('A',Format(A000MSG_A173_ERR_FMT_ACQ_NO_ANNO,[inttostr(nNumRiga),Anno]));
    Exit;
  end;
  if (Mese < '01') or (Mese > '12') then
  begin
    RegistraMsg.InserisciMessaggio('A',Format(A000MSG_A173_ERR_FMT_ACQ_NO_MESE,[inttostr(nNumRiga),Mese]));
    Exit;
  end;
  if (Ore < '000') or (Ore > '999') then
  begin
    RegistraMsg.InserisciMessaggio('A',Format(A000MSG_A173_ERR_FMT_ACQ_NO_ORE,[inttostr(nNumRiga),Ore]));
    Exit;
  end;
  if (Minuti < '00') or (Minuti > '59') then
  begin
    RegistraMsg.InserisciMessaggio('A',Format(A000MSG_A173_ERR_FMT_ACQ_NO_MINUTI,[inttostr(nNumRiga),Minuti]));
    Exit;
  end;
  AnnoW:=StrToInt(Anno);
  MeseW:=StrToInt(Mese);
  DataMese:=R180InizioMese(EncodeDate(AnnoW,MeseW,1));
  //Recupero i dati mancanti
  Progressivo:=-1;
  selT305.Close;
  selT305.SetVariable('CAUSALE',Causale);
  selT305.Open;
  if selT305.Eof then
  begin
    RegistraMsg.InserisciMessaggio('A',Format(A000MSG_A173_ERR_FMT_ACQ_NO_CAUSALE,[inttostr(nNumRiga),Causale]));
    Exit;
  end;
  selT030.Close;
  selT030.SetVariable('MATRICOLA',Matricola);
  selT030.Open;
  if not selT030.Eof then
    Progressivo:=selT030.FieldByName('PROGRESSIVO').AsInteger
  else
  begin
    RegistraMsg.InserisciMessaggio('A',Format(A000MSG_A173_ERR_FMT_ACQ_NO_MATRICOLA,[inttostr(nNumRiga),Matricola]));
    Exit;
  end;
  NumMinuti:=R180OreMinutiExt(Ore + '.' + Minuti);
  selT070.Close;
  selT070.SetVariable('PROG',Progressivo);
  selT070.SetVariable('DATA',DataMese);
  selT070.Open;
  selT071.Close;
  selT071.SetVariable('PROG',Progressivo);
  selT071.SetVariable('DATA',DataMese);
  selT071.Open;
  if selT070.RecordCount > 0 then
  begin
    if TipoElab = 'I' then
    begin
      //Registrazione assestamento ore
      if (Trim(selT070.FieldByName('CAUSALE1MINASS').AsString) <> '') and
         (Trim(selT070.FieldByName('CAUSALE2MINASS').AsString) <> '') then
      begin
        //Anomalia bloccante
        RegistraMsg.InserisciMessaggio('A',Format(A000MSG_A173_ERR_FMT_ACQ_TROPPE_CAUSALI,[inttostr(nNumRiga),Matricola,Mese,Anno]),'',Progressivo);
        Exit;
      end
      else
      begin
        if Segno = '-' then
        begin
          if R450DtM1 = nil then
            R450DtM1:=TR450DtM1.Create(Self);
          R450DtM1.ConteggiMese('Generico',R180Anno(DataMese),R180Mese(DataMese),Progressivo);
          if (NumMinuti > R450DtM1.salannoatt) then
            //Anomalia supero saldo complessivo
            RegistraMsg.InserisciMessaggio('A',Format(A000MSG_A173_ERR_FMT_ACQ_SUPERO_SALDO_COMP,[inttostr(nNumRiga),Matricola,Mese,Anno]),'',Progressivo)
          else if (NumMinuti > R450DtM1.salcompannoatt + R450DtM1.salliqannoatt) then
            //Anomalia supero saldo anno corrente
            RegistraMsg.InserisciMessaggio('A',Format(A000MSG_A173_ERR_FMT_ACQ_SUPERO_SALDO_CORR,[inttostr(nNumRiga),Matricola,Mese,Anno]),'',Progressivo);
        end;
        if Trim(selT070.FieldByName('CAUSALE1MINASS').AsString) = '' then
        begin
          selT070.Edit;
          selT070.FieldByName('CAUSALE1MINASS').AsString:=Causale;
          RegistraLog.SettaProprieta('M','T070_SCHEDARIEPIL',NomeOwner,selT070,True);
          selT070.Post;
          RegistraLog.RegistraOperazione;
          selT071.Edit;
          selT071.FieldByName('ORE1ASSEST').AsString:=Segno + StringReplace(Format('%6s',[R180MinutiOre(Trunc(NumMinuti))]),' ','0',[rfReplaceAll]);
          RegistraLog.SettaProprieta('M','T071_SCHEDAFASCE',NomeOwner,selT071,True);
          selT071.Post;
          RegistraLog.RegistraOperazione;
        end
        else if Trim(selT070.FieldByName('CAUSALE2MINASS').AsString) = '' then
        begin
          selT070.Edit;
          selT070.FieldByName('CAUSALE2MINASS').AsString:=Causale;
          RegistraLog.SettaProprieta('M','T070_SCHEDARIEPIL',NomeOwner,selT070,True);
          selT070.Post;
          RegistraLog.RegistraOperazione;
          selT071.Edit;
          selT071.FieldByName('ORE2ASSEST').AsString:=Segno + StringReplace(Format('%6s',[R180MinutiOre(Trunc(NumMinuti))]),' ','0',[rfReplaceAll]);
          RegistraLog.SettaProprieta('M','T071_SCHEDAFASCE',NomeOwner,selT071,True);
          selT071.Post;
          RegistraLog.RegistraOperazione;
        end;
      end;
    end
    else
    begin
      //Cancellazione assestamento ore
      if (Trim(selT070.FieldByName('CAUSALE1MINASS').AsString) <> Causale) and
         (Trim(selT070.FieldByName('CAUSALE2MINASS').AsString) <> Causale) then
      begin
        //Anomalia bloccante in cancellazione per causale non corrispondente
        RegistraMsg.InserisciMessaggio('A',Format(A000MSG_A173_ERR_FMT_CANC_NO_CAUSALE,[inttostr(nNumRiga),Matricola,Mese,Anno]),'',Progressivo);
        Exit;
      end
      else
      begin
        bCancAssest:=False;
        if (Trim(selT070.FieldByName('CAUSALE2MINASS').AsString) = Causale) and
           (R180OreMinutiExt(selT071.FieldByName('ORE2ASSEST').AsString) = NumMinuti * IfThen(Segno = '-',-1,1)) then
        begin
          bCancAssest:=True;
          selT070.Edit;
          selT070.FieldByName('CAUSALE2MINASS').AsString:='';
          RegistraLog.SettaProprieta('C','T070_SCHEDARIEPIL',NomeOwner,selT070,True);
          selT070.Post;
          RegistraLog.RegistraOperazione;
          selT071.Edit;
          selT071.FieldByName('ORE2ASSEST').AsString:='00.00';
          RegistraLog.SettaProprieta('C','T071_SCHEDAFASCE',NomeOwner,selT071,True);
          selT071.Post;
          RegistraLog.RegistraOperazione;
        end
        else if (Trim(selT070.FieldByName('CAUSALE1MINASS').AsString) = Causale) and
                (R180OreMinutiExt(selT071.FieldByName('ORE1ASSEST').AsString) = NumMinuti * IfThen(Segno = '-',-1,1)) then
        begin
          bCancAssest:=True;
          selT070.Edit;
          selT070.FieldByName('CAUSALE1MINASS').AsString:='';
          RegistraLog.SettaProprieta('C','T070_SCHEDARIEPIL',NomeOwner,selT070,True);
          selT070.Post;
          RegistraLog.RegistraOperazione;
          selT071.Edit;
          selT071.FieldByName('ORE1ASSEST').AsString:='00.00';
          RegistraLog.SettaProprieta('C','T071_SCHEDAFASCE',NomeOwner,selT071,True);
          selT071.Post;
          RegistraLog.RegistraOperazione;
        end;
        if not bCancAssest then
        begin
          //Anomalia bloccante in cancellazione per ore non corrispondenti
          RegistraMsg.InserisciMessaggio('A',Format(A000MSG_A173_ERR_FMT_CANC_NO_ORE,[inttostr(nNumRiga),Matricola,Mese,Anno]),'',Progressivo);
          Exit;
        end;
      end;
    end;
  end
  else
  begin
    //Anomalia bloccante
    RegistraMsg.InserisciMessaggio('A',Format(A000MSG_A173_ERR_FMT_ACQ_NO_SCHEDA_RIEP,[inttostr(nNumRiga),Matricola,Mese,Anno]),'',Progressivo);
    Exit;
  end;
end;

end.
