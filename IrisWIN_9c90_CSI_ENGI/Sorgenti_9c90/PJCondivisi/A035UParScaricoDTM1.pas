unit A035UParScaricoDTM1;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, A000UCostanti, A000USessione,A000UInterfaccia, RegistrazioneLog, OracleData, Oracle,
  C180FunzioniGenerali, Variants, USelI010,A000UMessaggi;

type
  TA035FParScaricoDTM1 = class(TDataModule)
    D192: TDataSource;
    Q191: TOracleDataSet;
    Q191CODICE: TStringField;
    Q191DESCRIZIONE: TStringField;
    Q191TIPOFILE: TStringField;
    Q191DEFAULTENTE: TStringField;
    Q191TABELLAENTE: TStringField;
    Q191CAMPOENTE: TStringField;
    Q191NOMEFILE: TStringField;
    Q191DATAFILE: TStringField;
    Q191MESEANNO: TStringField;
    Q191FORMATOORE: TStringField;
    Q191PRECISIONE: TStringField;
    Q191USERPAGHE: TStringField;
    Q192: TOracleDataSet;
    Q192CODICE: TStringField;
    Q192TIPO: TStringField;
    Q192D_TIPO: TStringField;
    Q192NOME: TStringField;
    Q192DEF: TStringField;
    Q192POS: TIntegerField;
    Q192LUNG: TIntegerField;
    Q191SALVATAGGIO_AUTOMATICO: TStringField;
    Q191SEPARATOREDECIMALI: TStringField;
    Q191TIPODATA_FILE: TStringField;
    Q191RICREAZIONE_AUTOMATICA: TStringField;
    Q191TIPO_PARAMETRIZZAZIONE: TStringField;
    Q192TIPO_PARAMETRIZZAZIONE: TStringField;
    procedure A035FParScaricoDTM1Create(Sender: TObject);
    procedure A035FParScaricoDTM1Destroy(Sender: TObject);
    procedure Q191AfterPost(DataSet: TDataSet);
    procedure Q191AfterCancel(DataSet: TDataSet);
    procedure Q191BeforePost(DataSet: TDataSet);
    procedure Q191AfterDelete(DataSet: TDataSet);
    procedure Q191AfterScroll(DataSet: TDataSet);
    procedure Q191AfterEdit(DataSet: TDataSet);
    procedure Q191NewRecord(DataSet: TDataSet);
    procedure Q191AfterInsert(DataSet: TDataSet);
    procedure Q192NewRecord(DataSet: TDataSet);
    procedure Q192CalcFields(DataSet: TDataSet);
    procedure BDEQ192TIPOValidate(Sender: TField);
    procedure Q191BeforeDelete(DataSet: TDataSet);
    procedure Q192AfterScroll(DataSet: TDataSet);
    procedure Q192BeforePost(DataSet: TDataSet);
  private
    { Private declarations }
    function ControllaParametriGriglia:Boolean;
  public
    selI010:TselI010;
    { Public declarations }
  end;

var
  A035FParScaricoDTM1: TA035FParScaricoDTM1;
const
  cParPaghe:string='PAGHE';
  cParContab:string='CONTAB';

implementation

uses A035UParScarico;

{$R *.DFM}

procedure TA035FParScaricoDTM1.A035FParScaricoDTM1Create(Sender: TObject);
var i:Integer;
begin
  if not(SessioneOracle.Connected) then
  begin
    Password(Application.Name);
    A000ParamDBOracle(SessioneOracle);
  end;
  for i:=0 to Self.ComponentCount - 1 do
    begin
    if Components[i] is TOracleQuery then
      (Components[i] as TOracleQuery).Session:=SessioneOracle;
    if Components[i] is TOracleDataSet then
      (Components[i] as TOracleDataSet).Session:=SessioneOracle;
    end;
  selI010:=TselI010.Create(Self);
  selI010.Apri(SessioneOracle,'',Parametri.Applicazione,'NOME_CAMPO,NOME_LOGICO','','NOME_LOGICO,NOME_CAMPO');
  Q191.SetVariable('TIPOPAR',A035FParScarico.VoceMenu);
  Q191.Open;
  A035FParScarico.DButton.DataSet:=Q191;
end;

procedure TA035FParScaricoDTM1.A035FParScaricoDTM1Destroy(Sender: TObject);
var i:Integer;
begin
  for i:=0 to Self.ComponentCount - 1 do
    if Self.Components[i] is TDataSet then
      (Self.Components[i] as TDataSet).Close;
  FreeAndNil(selI010);
end;

procedure TA035FParScaricoDTM1.Q191AfterPost(DataSet: TDataSet);
begin
  if  (A035FParScarico.VoceMenu = 'CONTAB')
  and (Q192.UpdatesPending)
  and (A035FParScaricoDTM1.Q191.FieldByName('TIPOFILE').AsString = 'T') then
    ShowMessage(A000MSG_A035_MSG_ALLINEA);
  try
    SessioneOracle.ApplyUpdates([Q191,Q192],True);
  except
    ShowMessage('Modifiche fallite: Più dati con la stessa posizione');
  end;
  RegistraLog.RegistraOperazione;
  Q192.ReadOnly:=True;
  SessioneOracle.Commit;
  Q191AfterScroll(Q191);
end;

procedure TA035FParScaricoDTM1.Q191AfterCancel(DataSet: TDataSet);
begin
  Q191.CancelUpdates;
  if Q192.CachedUpdates then
    Q192.CancelUpdates;
  Q192.ReadOnly:=True;
  Q191AfterScroll(Q191);
end;

procedure TA035FParScaricoDTM1.Q191BeforePost(DataSet: TDataSet);
{Copio i dati della griglia nei campi corrispondenti prima di confermare le modifiche}
var
  TrovImp,TrovDareAvere:Boolean;
  TrovImpDare,TrovImpAvere,TrovSegnoImpDare,TrovSegnoImpAvere:Boolean;
  TrovRigheDett1,TrovRigheDett2:Boolean;
begin
  if QueryPK1.EsisteChiave('T191_PARPAGHE',Q191.RowId,Q191.State,['CODICE'],[Q191Codice.AsString]) then
    raise Exception.Create('Codice già esistente!');
  if not ControllaParametriGriglia then
    if MessageDlg(A000MSG_A035_DLG_PAR_ERR,mtWarning,[mbYes,mbNo],0) = mrNo then
      Abort;
  case DataSet.State of
    dsInsert:RegistraLog.SettaProprieta('I',R180Query2NomeTabella(DataSet),Copy(Name,1,4),DataSet,True);
    dsEdit:RegistraLog.SettaProprieta('M',R180Query2NomeTabella(DataSet),Copy(Name,1,4),DataSet,True);
  end;
  if A035FParScarico.VoceMenu = cParContab then
  begin
    TrovRigheDett1:=VarToStr(Q192.Lookup('TIPO','4','TIPO'))='4';
    TrovRigheDett2:=VarToStr(Q192.Lookup('TIPO','5','TIPO'))='5';
    TrovImp:=VarToStr(Q192.Lookup('TIPO','9','TIPO'))='9';
    TrovDareAvere:=VarToStr(Q192.Lookup('TIPO','A','TIPO'))='A';
    TrovSegnoImpDare:=VarToStr(Q192.Lookup('TIPO','B','TIPO'))='B';
    TrovImpDare:=VarToStr(Q192.Lookup('TIPO','C','TIPO'))='C';
    TrovSegnoImpAvere:=VarToStr(Q192.Lookup('TIPO','D','TIPO'))='D';
    TrovImpAvere:=VarToStr(Q192.Lookup('TIPO','E','TIPO'))='E';
    if (TrovRigheDett1) and (TrovRigheDett2) then
    begin
      ShowMessage(A000MSG_A035_ERR_DARE_AVERE_RIGA);
      abort;
    end;
    if (TrovImp or TrovDareAvere) and (TrovSegnoImpDare or TrovImpDare or TrovSegnoImpAvere or TrovImpAvere) then
      raise exception.create(A000MSG_A035_ERR_DATI_DARE_AVERE);
    if TrovImp and not TrovDareAvere then
      raise exception.create(A000MSG_A035_ERR_IMPORTO_DARE_AVERE);
  end;
end;

function TA035FParScaricoDtM1.ControllaParametriGriglia:Boolean;
var i,j,NC : Integer;
    VInizio:array [1..100] of Integer;
    VFine:array [1..100] of Integer;
    VTipo:array [1..100] of String;
    VNome:array [1..100] of String;
begin
  Result:=True;
  Q192.DisableControls;
  for i:=Low(VInizio) to High(VInizio) do
  begin
    VInizio[i]:=0;
    VFine[i]:=0;
  end;
  NC:=0;
  try
    Q192.First;
    while not Q192.Eof do
    begin
      inc(NC);
      VInizio[NC]:=Q192.FieldByName('Pos').AsInteger;
      VFine[NC]:=VInizio[NC] + Q192.FieldByName('Lung').AsInteger - 1;
      VTipo[NC]:=Q192.FieldByName('Tipo').AsString;
      VNome[NC]:=Q192.FieldByName('Nome').AsString;
      Q192.Next;
    end;
    Q192.First;
  finally
    Q192.EnableControls;
  end;
  for i:=1 to NC do
  begin
    if VInizio[i] > VFine[i] then
    begin
      Result:=False;
      Break;
    end;
    if (Q191TipoFile.AsString = 'T') and (Trim(VNome[i]) = '') then
    begin
      Result:=False;
      Break;
    end;
    for j:=1 to NC do
    begin
      if i = j then Continue;
      if VInizio[j] > VFine[j] then
      begin
        Result:=False;
        Break;
      end;
      (*if (VTipo[i] <> '0') and (VTipo[i] <> 'H') and (VTipo[i] = VTipo[j]) then
      begin
        Result:=False;
        Break;
      end;*)
      if (Q191TipoFile.AsString = 'T') and (VNome[i] = VNome[j]) then
      begin
        Result:=False;
        Break;
      end;
      if (Q191TipoFile.AsString <> 'T') and
         (((VInizio[j] >= VInizio[i]) and (VInizio[j] <= VFine[i])) or
          ((VFine[j] >= VInizio[i]) and (VFine[j] <= VFine[i]))) then
      begin
        Result:=False;
        Break;
      end;
    end;
    if not Result then Break;
  end;
end;

procedure TA035FParScaricoDTM1.Q191AfterDelete(DataSet: TDataSet);
begin
  SessioneOracle.ApplyUpdates([Q191],True);
  RegistraLog.RegistraOperazione;
end;

procedure TA035FParScaricoDTM1.Q191AfterScroll(DataSet: TDataSet);
begin
  Q192.Close;
  Q192.SetVariable('Codice',Q191.FieldByName('Codice').AsString);
  Q192.SetVariable('TIPOPAR',A035FParScarico.VoceMenu);
  Q192.Open;
end;

procedure TA035FParScaricoDTM1.Q191AfterEdit(DataSet: TDataSet);
begin
  Q191.FieldByName('CODICE').ReadOnly:=True;
  Q192.ReadOnly:=False;
end;

procedure TA035FParScaricoDTM1.Q191NewRecord(DataSet: TDataSet);
begin
  Q191.FieldByName('TIPOFILE').AsString:='F';
  Q191.FieldByName('FORMATOORE').AsString:='0';
  Q191.FieldByName('precisione').AsString:='0';
  Q191.FieldByName('TIPO_PARAMETRIZZAZIONE').AsString:=A035FParScarico.VoceMenu;
end;

procedure TA035FParScaricoDTM1.Q191AfterInsert(DataSet: TDataSet);
begin
  Q191.FieldByName('CODICE').ReadOnly:=False;
end;

procedure TA035FParScaricoDTM1.Q192NewRecord(DataSet: TDataSet);
begin
  Q192.FieldByName('CODICE').AsString:=Q191.FieldByName('CODICE').AsString;
  Q192.FieldByName('TIPO').AsString:='0';
  Q192.FieldByName('TIPO_PARAMETRIZZAZIONE').AsString:=A035FParScarico.VoceMenu;
end;

procedure TA035FParScaricoDTM1.Q192CalcFields(DataSet: TDataSet);
begin
  with Q192 do
  begin
    if A035FParScarico.VoceMenu = cParPaghe then
    begin
      if FieldByName('TIPO').AsString = '0' then
        FieldByName('D_TIPO').AsString:='FILLER'
      else if FieldByName('TIPO').AsString = '1' then
        FieldByName('D_TIPO').AsString:='ENTE'
      else if FieldByName('TIPO').AsString = '2' then
        FieldByName('D_TIPO').AsString:='DATA'
      else if FieldByName('TIPO').AsString = '3' then
        FieldByName('D_TIPO').AsString:='MATRICOLA'
      else if FieldByName('TIPO').AsString = '4' then
        FieldByName('D_TIPO').AsString:='BADGE'
      else if FieldByName('TIPO').AsString = '5' then
        FieldByName('D_TIPO').AsString:='COD.INTERNO'
      else if FieldByName('TIPO').AsString = '6' then
        FieldByName('D_TIPO').AsString:='COD.PAGHE'
      else if FieldByName('TIPO').AsString = '7' then
        FieldByName('D_TIPO').AsString:='SEGNO'
      else if FieldByName('TIPO').AsString = '8' then
        FieldByName('D_TIPO').AsString:='VALORE'
      else if FieldByName('TIPO').AsString = '9' then
        FieldByName('D_TIPO').AsString:='MISURA'
      else if FieldByName('TIPO').AsString = 'A' then
        FieldByName('D_TIPO').AsString:='DA DATA'
      else if FieldByName('TIPO').AsString = 'B' then
        FieldByName('D_TIPO').AsString:='A DATA'
      else if FieldByName('TIPO').AsString = 'C' then
        FieldByName('D_TIPO').AsString:='RIFERIMENTO'
      else if FieldByName('TIPO').AsString = 'D' then
        FieldByName('D_TIPO').AsString:='DA ORE'
      else if FieldByName('TIPO').AsString = 'E' then
        FieldByName('D_TIPO').AsString:='A ORE'
      else if FieldByName('TIPO').AsString = 'F' then
        FieldByName('D_TIPO').AsString:='DATA DI CASSA'
      else if FieldByName('TIPO').AsString = 'G' then
        FieldByName('D_TIPO').AsString:='IMPORTO'
      else if FieldByName('TIPO').AsString = 'H' then
        FieldByName('D_TIPO').AsString:='DATO ANAGRAFICO'
      else
        FieldByName('D_TIPO').AsString:='';
    end
    else if A035FParScarico.VoceMenu = cParContab then
    begin
      if FieldByName('TIPO').AsString = '0' then
        FieldByName('D_TIPO').AsString:='FILLER'
      else if FieldByName('TIPO').AsString = '1' then
        FieldByName('D_TIPO').AsString:='DATA ELABORAZIONE'
      else if FieldByName('TIPO').AsString = '2' then
        FieldByName('D_TIPO').AsString:='TOTALE DARE'
      else if FieldByName('TIPO').AsString = '3' then
        FieldByName('D_TIPO').AsString:='TOTALE AVERE'
      else if FieldByName('TIPO').AsString = '4' then
        FieldByName('D_TIPO').AsString:='N. RIGHE DETT. D/A SU STESSA RIGA'
      else if FieldByName('TIPO').AsString = '5' then
        FieldByName('D_TIPO').AsString:='N. RIGHE DETT. D/A SU DUE RIGHE'
      else if FieldByName('TIPO').AsString = '6' then
        FieldByName('D_TIPO').AsString:='PROGRESSIVO RIGA'
      else if FieldByName('TIPO').AsString = '7' then
        FieldByName('D_TIPO').AsString:='ID-CONTO'
      else if FieldByName('TIPO').AsString = '8' then
        FieldByName('D_TIPO').AsString:='SEGNO IMPORTO'
      else if FieldByName('TIPO').AsString = '9' then
        FieldByName('D_TIPO').AsString:='IMPORTO'
      else if FieldByName('TIPO').AsString = 'A' then
        FieldByName('D_TIPO').AsString:='DARE_AVERE'
      else if FieldByName('TIPO').AsString = 'B' then
        FieldByName('D_TIPO').AsString:='SEGNO IMP. DARE'
      else if FieldByName('TIPO').AsString = 'C' then
        FieldByName('D_TIPO').AsString:='IMPORTO_DARE'
      else if FieldByName('TIPO').AsString = 'D' then
        FieldByName('D_TIPO').AsString:='SEGNO IMP. AVERE'
      else if FieldByName('TIPO').AsString = 'E' then
        FieldByName('D_TIPO').AsString:='IMPORTO_AVERE'
      else if FieldByName('TIPO').AsString = 'F' then
        FieldByName('D_TIPO').AsString:='DATA ESPORTAZIONE'
      else if FieldByName('TIPO').AsString = 'G' then
        FieldByName('D_TIPO').AsString:='DATA COMPETENZA'
      else if FieldByName('TIPO').AsString = 'H' then
        FieldByName('D_TIPO').AsString:='DESCRIZIONE CONTO'
      else
        FieldByName('D_TIPO').AsString:='';
    end;
  end;
end;

procedure TA035FParScaricoDTM1.BDEQ192TIPOValidate(Sender: TField);
  function Esiste(S:String):Boolean;
  var i:Integer;
  begin
    Result:=False;
    for i:=0 to A035FParScarico.DbGrid1.Columns[0].PickList.Count - 1 do
      begin
      if S = Trim(Copy(A035FParScarico.DbGrid1.Columns[0].PickList.Strings[i],1,Sender.Size)) then
        begin
        Result:=True;
        Break;
        end;
      end;
  end;
begin
  if (not Sender.IsNull) and (not Esiste(Sender.AsString)) then
    raise Exception.Create('Valore non valido!');
  if Trim(Q192Def.AsString) <> '' then exit;
  if A035FParScarico.VoceMenu = cParPaghe then
  begin
    if (Sender.AsString = '2') or
       (Sender.AsString = 'A') or
       (Sender.AsString = 'B') or
       (Sender.AsString = 'C') or
       (Sender.AsString = 'F') then
      Q192Def.AsString:='yymm';
    if (Sender.AsString = 'D') or
       (Sender.AsString = 'E') then
      Q192Def.AsString:='hhmm';
  end
  else if A035FParScarico.VoceMenu = cParContab then
  begin
    if (Sender.AsString = '1') then
      Q192Def.AsString:='yyyy';
    if (Sender.AsString = 'F')
    or (Sender.AsString = 'G') then
      Q192Def.AsString:='dd/mm/yyyy';
  end;
  Q192AfterScroll(nil);
end;

procedure TA035FParScaricoDTM1.Q191BeforeDelete(DataSet: TDataSet);
begin
  RegistraLog.SettaProprieta('C',R180Query2NomeTabella(DataSet),Copy(Name,1,4),DataSet,True);
end;

procedure TA035FParScaricoDTM1.Q192AfterScroll(DataSet: TDataSet);
var i:Integer;
begin
  with A035FParScarico.DBGrid1 do
    for i:=0 to Columns.Count - 1 do
      if Columns[i].FieldName = 'DEF' then
        if A035FParScarico.VoceMenu = cParPaghe then
        begin
          Columns[i].PickList.Clear;
          if (Q192TIPO.AsString = '2')
          or (Q192TIPO.AsString = 'A')
          or (Q192TIPO.AsString = 'B')
          or (Q192TIPO.AsString = 'C')
          or (Q192TIPO.AsString = 'F') then
          begin
            Columns[i].PickList.Add('mmyy');
            Columns[i].PickList.Add('mmyy');
            Columns[i].PickList.Add('yymm');
            Columns[i].PickList.Add('mmyyyy');
            Columns[i].PickList.Add('yyyymm');
            Columns[i].PickList.Add('ddmmyy');
            Columns[i].PickList.Add('yymmdd');
            Columns[i].PickList.Add('01mmyy');
            Columns[i].PickList.Add('31mmyy');
            Columns[i].PickList.Add('FRmmyy');
            Columns[i].PickList.Add('yymm01');
            Columns[i].PickList.Add('yymm31');
            Columns[i].PickList.Add('yymmFR');
          end
          else if (Q192TIPO.AsString = 'D')
               or (Q192TIPO.AsString = 'E') then
            Columns[i].PickList.Add('hhmm')
          else if (Q192TIPO.AsString = '8')
               or (Q192TIPO.AsString = 'G') then
            Columns[i].PickList.Add('ABS')
          else if Q192TIPO.AsString = '6' then
          begin
            Columns[i].PickList.Add('-<X/Y>vvv');
            Columns[i].PickList.Add('-vvv<X/Y>');
            Columns[i].PickList.Add('-DECODE');
          end
          else if Q192TIPO.AsString = 'H' then
          begin
            selI010.First;
            while not selI010.Eof do
            begin
              Columns[i].PickList.Add(selI010.FieldByName('NOME_LOGICO').AsString);
              selI010.Next;
            end;
          end;
          Break;
        end
        else if A035FParScarico.VoceMenu = cParContab then
        begin
          Columns[i].PickList.Clear;
          if (Q192TIPO.AsString = '1')
          or (Q192TIPO.AsString = 'F')
          or (Q192TIPO.AsString = 'G') then
          begin
            Columns[i].PickList.Add('ddmmyyyy');
            Columns[i].PickList.Add('dd/mm/yyyy');
            Columns[i].PickList.Add('01mmyyyy');
            Columns[i].PickList.Add('01/mm/yyyy');
            Columns[i].PickList.Add('31mmyyyy');
            Columns[i].PickList.Add('31/mm/yyyy');
            Columns[i].PickList.Add('yyyymmdd');
            Columns[i].PickList.Add('yyyy/mm/dd');
            Columns[i].PickList.Add('yyyymm01');
            Columns[i].PickList.Add('yyyy/mm/01');
            Columns[i].PickList.Add('yyyymm31');
            Columns[i].PickList.Add('yyyy/mm/31');
            Columns[i].PickList.Add('ddmmyy');
            Columns[i].PickList.Add('dd/mm/yy');
            Columns[i].PickList.Add('01mmyy');
            Columns[i].PickList.Add('01/mm/yy');
            Columns[i].PickList.Add('31mmyy');
            Columns[i].PickList.Add('31/mm/yy');
            Columns[i].PickList.Add('yymmdd');
            Columns[i].PickList.Add('yy/mm/dd');
            Columns[i].PickList.Add('yymm01');
            Columns[i].PickList.Add('yy/mm/01');
            Columns[i].PickList.Add('yymm31');
            Columns[i].PickList.Add('yy/mm/31');
            Columns[i].PickList.Add('mmyyyy');
            Columns[i].PickList.Add('mm/yyyy');
            Columns[i].PickList.Add('yyyymm');
            Columns[i].PickList.Add('yyyy/mm');
            Columns[i].PickList.Add('mmyy');
            Columns[i].PickList.Add('mm/yy');
            Columns[i].PickList.Add('yymm');
            Columns[i].PickList.Add('yy/mm');
          end
          else if (Q192TIPO.AsString = '2')
               or (Q192TIPO.AsString = '3')
               or (Q192TIPO.AsString = '9')
               or (Q192TIPO.AsString = 'C')
               or (Q192TIPO.AsString = 'E') then
            Columns[i].PickList.Add('ABS')
          else if (Q192TIPO.AsString = '8')
               or (Q192TIPO.AsString = 'B')
               or (Q192TIPO.AsString = 'D') then
            Columns[i].PickList.Add('+/-');
          Break;
        end;
end;

procedure TA035FParScaricoDTM1.Q192BeforePost(DataSet: TDataSet);
var ValDef, Errore:String;
    i, CVirgola:Integer;
begin
  if A035FParScarico.VoceMenu = cParPaghe then
  begin
    if (Q192.FieldByName('TIPO').AsString = 'H') and
       (not selI010.SearchRecord('NOME_LOGICO',Q192.FieldByName('DEF').AsString,[srFromBeginning])) then
      raise Exception.Create('Dato anagrafico inesistente!');
    {Verifico Correttezza formula "Segno"
      Controllo presenza di una sola virgola}
    if (Q192.FieldByName('TIPO').AsString = '7') then
    begin
      Errore:='';
      ValDef:=Q192.FieldByName('DEF').AsString;
      CVirgola:=0;
      for i:=1 to Length(ValDef) do
        if ValDef[i] = ',' then
          Inc(CVirgola);
      
      if CVirgola >= 2 then
        Errore:=A000MSG_A035_ERR_FORMULA;
      if Errore <> '' then
        raise Exception.Create(Errore);
    end;
  end;
end;

end.
