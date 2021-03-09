unit A000UGestioneTimbraGiustMW;

interface

uses
  Variants,System.SysUtils, System.Classes, R005UDataModuleMW, R500Lin,
  OracleData,A000UInterfaccia,A000USessione,A000UCostanti,C180FunzioniGenerali;

type
  TA000FGestioneTimbraGiustMW = class(TR005FDataModuleMW)
  private
    procedure Abblenca(Tabella, Col, Row: Byte);
    procedure Sort(Day: Byte);
    procedure InserisciTimbraturaArray(Day: Integer);
  public
    QTimbrature: TOracleDataset;
    QGiustificativi: TOracleDataset;
    FTimbrature: Array [1..31,1..MaxTimbrature] of TTimbrature;
    FNumTimbrature: Array[1..31] of Byte;
    FGiustificativi:Array [1..31,1..MaxGiustif] of TGiustificativi;
    FNumGiustif:Array[1..31] of Byte;
    StatoTimb: (stModifica,stInserimento);
    EU:Char;
    procedure CaricaArrayGiustificativi(Q265CauAss,Q031Tipo1: TOracleDataset);
    procedure CaricaArrayTimbrature;
    function FormGiust(C, R: Byte): String;
    procedure AzzeraTabelle;
    function TimbraturaModificata(Day, Col: Integer): Boolean;
    procedure EseguiInserisciTimbratura(Data: TDateTime);
    procedure EseguiModificaTimbratura(Data: TDateTime; Day, Col: Integer);
    procedure EseguiCancellaTimbratura(Day, Col: Integer);
  end;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure TA000FGestioneTimbraGiustMW.Abblenca(Tabella,Col,Row:Byte);
{Abblenca il singolo elemento della Tabella}
begin
  case Tabella of
    0:
      begin
        FTimbrature[Col,Row].Ora:=Null;
        FTimbrature[Col,Row].Verso:='';
        FTimbrature[Col,Row].Flag:='';
        FTimbrature[Col,Row].Rilevatore:='';
        FTimbrature[Col,Row].Causale:='';
      end;
    1:
      begin
        FGiustificativi[Col,Row].Causale:='';
        FGiustificativi[Col,Row].DataNas:=0;
        FGiustificativi[Col,Row].ProgCaus:=0;
        FGiustificativi[Col,Row].Tipo:='';
        // ALESSANDRIA_COMUNE - commessa 2015/214 SVILUPPO#1.ini
        FGiustificativi[Col,Row].CSITipoMG:='';
        // ALESSANDRIA_COMUNE - commessa 2015/214 SVILUPPO#1.fine
        FGiustificativi[Col,Row].DaOre:=0;
        FGiustificativi[Col,Row].AOre:=0;
        FGiustificativi[Col,Row].NuovoPeriodo:=False;
        FGiustificativi[Col,Row].Validata:='';
        FGiustificativi[Col,Row].Note:='';
      end;
  end;
end;

procedure TA000FGestioneTimbraGiustMW.AzzeraTabelle;
{Azzero i vettori e abblenco i grid}
var i,j:Byte;
    xx:Integer;
begin
  for xx:=Low(FNumTimbrature) to High(FNumTimbrature) do FNumTimbrature[xx]:=0;
  for xx:=Low(FNumGiustif) to High(FNumGiustif) do FNumGiustif[xx]:=0;
  for i:=1 to 31 do
    for j:=1 to MaxGiustif do
      Abblenca(1,i,j);
  for i:=1 to 31 do
    for j:=1 to MaxTimbrature do
      Abblenca(0,i,j);
end;

procedure TA000FGestioneTimbraGiustMW.CaricaArrayTimbrature;
var
  i,j: Integer;
begin
  i:=0;
  j:=0;
  QTimbrature.First;
  while not QTimbrature.Eof do
  begin
    if R180Giorno(QTimbrature.FieldByName('Data').AsDateTime) <> i then
    begin
      i:=R180Giorno(QTimbrature.FieldByName('Data').AsDateTime);
      j:=0;
    end;
    if j < MaxTimbrature then
    begin
      inc(j);
      FNumTimbrature[i]:=j;
      FTimbrature[i,j].Ora:=QTimbrature.FieldByName('Ora').AsDateTime;
      FTimbrature[i,j].Verso:=QTimbrature.FieldByName('Verso').AsString;
      FTimbrature[i,j].Flag:=QTimbrature.FieldByName('Flag').AsString;
      FTimbrature[i,j].Rilevatore:=QTimbrature.FieldByName('Rilevatore').AsString;
      FTimbrature[i,j].Causale:=QTimbrature.FieldByName('Causale').AsString;
    end;
    QTimbrature.Next;
  end;
end;

procedure TA000FGestioneTimbraGiustMW.CaricaArrayGiustificativi(Q265CauAss,Q031Tipo1: TOracleDataset);
var
  i,j: Integer;
  Validaz:String;
begin
  i:=0;
  j:=0;
  QGiustificativi.First;
  while not QGiustificativi.Eof do
  begin
    if not A000FiltroDizionario('CAUSALI SUL CARTELLINO',QGiustificativi.FieldByName('Causale').AsString) then
    begin
      QGiustificativi.Next;
      Continue;
    end;
    if R180Giorno(QGiustificativi.FieldByName('Data').AsDateTime) <> i then
    begin
      i:=R180Giorno(QGiustificativi.FieldByName('Data').AsDateTime);
      j:=0;
    end;
    if j < MaxGiustif then
    begin
      inc(j);
      FNumGiustif[i]:=j;
      FGiustificativi[i,j].Causale:=QGiustificativi.FieldByName('Causale').AsString;
      FGiustificativi[i,j].DataNas:=QGiustificativi.FieldByName('DataNas').AsDateTime;
      FGiustificativi[i,j].ProgCaus:=QGiustificativi.FieldByName('ProgrCausale').AsInteger;
      FGiustificativi[i,j].Tipo:=QGiustificativi.FieldByName('TipoGiust').AsString;
      // ALESSANDRIA_COMUNE - commessa 2015/214 SVILUPPO#1.ini
      FGiustificativi[i,j].CSITipoMG:=QGiustificativi.FieldByName('CSI_TIPO_MG').AsString;
      // ALESSANDRIA_COMUNE - commessa 2015/214 SVILUPPO#1.fine
      FGiustificativi[i,j].DaOre:=QGiustificativi.FieldByName('DaOre').AsDateTime;
      FGiustificativi[i,j].AOre:=QGiustificativi.FieldByName('AOre').AsDateTime;
      FGiustificativi[i,j].Note:=QGiustificativi.FieldByName('Note').AsString;
      if Q265CauAss <> nil then
      begin
        Validaz:=VarToStr(Q265CauAss.Lookup('CODICE',QGiustificativi.FieldByName('Causale').AsString,'VALIDAZIONE'));
        if (Validaz <> '') and (Validaz <> 'N') then
          if QGiustificativi.FieldByName('SCHEDA').AsString = 'V' then
            FGiustificativi[i,j].Validata:='S'
          else
            FGiustificativi[i,j].Validata:='N';
      end;
       if Q031Tipo1 <> nil then
         FGiustificativi[i,j].NuovoPeriodo:=Q031Tipo1.SearchRecord('DATA',QGiustificativi.FieldByName('Data').AsDateTime,[srFromBeginning])
                                         and (FGiustificativi[i,j].Tipo = 'I');
    end;
    QGiustificativi.Next;
  end;
end;

//Formattazione testo giustificativo per win (A047, A023)
function TA000FGestioneTimbraGiustMW.FormGiust(C,R:Byte):String;
{Costruisco descrizione giustificativo}
var Tipo:Char;
    S:String;
begin
  Tipo:=R180CarattereDef(FGiustificativi[C,R].Tipo,1,#0);
  case Tipo of
    'I':Result:=' Giornata';
    'M':begin
        Result:=' 1/2GG';
        S:=FGiustificativi[C,R].CSITipoMG;
        if FGiustificativi[C,R].DaOre <> 0 then
          S:=S + FormatDateTime('hh:mm',FGiustificativi[C,R].DaOre);
        if S <> '' then
          Result:=Result + '(' + S + ')';
        end;
    'N':Result:=' '+FormatDateTime('hh:mm',FGiustificativi[C,R].DaOre)+' Ore';
    'D':Result:=
        ' Da '+FormatDateTime('hh:mm',FGiustificativi[C,R].DaOre)+
        ' a ' +FormatDateTime('hh:mm',FGiustificativi[C,R].AOre);
  end;
end;

procedure TA000FGestioneTimbraGiustMW.Sort(Day:Byte);
{Implementeazione Quick Sort per ordinamento timbrature}
  procedure QuickSort(iLo, iHi: Integer);
  var
    Lo, Hi: Integer;
    Mid:TDateTime;
    T:TTimbrature;
  begin
    Lo:=iLo;
    Hi:=iHi;
    Mid:=VarToDateTime(FTimbrature[Day,(Lo + Hi) div 2].Ora);
    repeat
      while VarToDateTime(FTimbrature[Day,Lo].Ora) < Mid do Inc(Lo);
      while VarToDateTime(FTimbrature[Day,Hi].Ora) > Mid do Dec(Hi);
      if Lo <= Hi then
      begin
        T:=FTimbrature[Day,Lo];
        FTimbrature[Day,Lo]:=FTimbrature[Day,Hi];
        FTimbrature[Day,Hi]:=T;
        Inc(Lo);
        Dec(Hi);
      end;
    until Lo > Hi;
    if Hi > iLo then QuickSort(iLo, Hi);
    if Lo < iHi then QuickSort(Lo, iHi);
  end;

begin
  if FNumTimbrature[Day] > 0 then
    QuickSort(1,FNumTimbrature[Day]);
end;

function TA000FGestioneTimbraGiustMW.TimbraturaModificata(Day,Col: Integer): Boolean;
begin
  Result:=False;
  //CARATTO 18/07/2013 with A023FTimbrature.FTimbrature[Day,Col],A023FTimbratureDtM1.Q100 do
  with FTimbrature[Day,Col] do
  begin
    if (VarIsNull(Ora)) or
       (VarToDateTime(Ora) <> QTimbrature.FieldByName('Ora').AsDateTime) then Result:=True;
    if Verso <> QTimbrature.FieldByName('Verso').AsString then Result:=True;
    if Rilevatore <> QTimbrature.FieldByName('Rilevatore').AsString then Result:=True;
    if Causale <> QTimbrature.FieldByName('Causale').AsString then Result:=True;
  end;
end;

procedure TA000FGestioneTimbraGiustMW.InserisciTimbraturaArray(Day:Integer);
begin
  Inc(FNumTimbrature[Day]);
  with FTimbrature[Day,FNumTimbrature[Day]] do
  begin
    Ora:=QTimbrature.FieldByName('Ora').AsDateTime;
    Verso:=QTimbrature.FieldByName('Verso').AsString;
    Flag:='I';
    Rilevatore:=QTimbrature.FieldByName('Rilevatore').AsString;
    Causale:=QTimbrature.FieldByName('Causale').AsString;
  end;
  Sort(Day);
end;

{aggiorno FTimbrature e mi posiziono su nuova timbratura}
procedure TA000FGestioneTimbraGiustMW.EseguiInserisciTimbratura(Data:TDateTime);
begin
  QTimbrature.FieldByName('Data').Value:=Data;
  QTimbrature.Post;
  SessioneOracle.Commit;
  InserisciTimbraturaArray(R180Giorno(Data));
end;

procedure TA000FGestioneTimbraGiustMW.EseguiModificaTimbratura(Data:TDateTime;Day,Col:Integer);
begin
  if FTimbrature[day,col].Flag = 'I' then
    QTimbrature.Post
  else if (FTimbrature[day,col].Ora = QTimbrature.FieldByName('Ora').AsDateTime) and
          (FTimbrature[day,col].Rilevatore = QTimbrature.FieldByName('Rilevatore').AsString) and
          ((FTimbrature[day,col].Verso = QTimbrature.FieldByName('Verso').AsString) or (Parametri.TimbOrig_Verso = 'S')) and
          ((FTimbrature[day,col].Causale = QTimbrature.FieldByName('Causale').AsString) or (Parametri.TimbOrig_Causale = 'S')) then
    QTimbrature.Post
  else
  begin
    //salvo valori nuovi
    FTimbrature[day,col].Ora:=QTimbrature.FieldByName('Ora').AsDateTime;
    FTimbrature[day,col].Verso:=QTimbrature.FieldByName('Verso').AsString;
    FTimbrature[day,col].Rilevatore:=QTimbrature.FieldByName('Rilevatore').AsString;
    FTimbrature[day,col].Causale:=QTimbrature.FieldByName('Causale').AsString;
    //Annullo modifiche e registro la timb.originale con flag 'M'
    QTimbrature.Cancel;
    QTimbrature.Edit;
    QTimbrature.FieldByName('Flag').AsString:='M';
    QTimbrature.Post;
    //Inserisco la timbratura con i nuovi valori e flag 'I'
    QTimbrature.Append;
    QTimbrature.FieldByName('Ora').AsDateTime:=FTimbrature[day,col].Ora;
    QTimbrature.FieldByName('Verso').AsString:=FTimbrature[day,col].Verso;
    QTimbrature.FieldByName('Rilevatore').AsString:=FTimbrature[day,col].Rilevatore;
    QTimbrature.FieldByName('Causale').AsString:=FTimbrature[day,col].Causale;
    QTimbrature.FieldByName('Data').AsDateTime:=Data;
    QTimbrature.Post;
  end;
  FTimbrature[day,col].Ora:=QTimbrature.FieldByName('Ora').AsDateTime;
  FTimbrature[day,col].Verso:=QTimbrature.FieldByName('Verso').AsString;
  FTimbrature[day,col].Rilevatore:=QTimbrature.FieldByName('Rilevatore').AsString;
  FTimbrature[day,col].Causale:=QTimbrature.FieldByName('Causale').AsString;
  FTimbrature[day,col].Flag:=QTimbrature.FieldByName('Flag').AsString;
  Sort(Day);
  SessioneOracle.Commit;
end;

procedure TA000FGestioneTimbraGiustMW.EseguiCancellaTimbratura(Day,Col:Integer);
var i: Integer;
begin
  if QTimbrature.FieldByName('Flag').AsString = 'O' then
  begin
    QTimbrature.Edit;
    QTimbrature.FieldByName('Flag').AsString:='C';
    QTimbrature.Post;
  end
  else
    QTimbrature.Delete;

  for i:=Col+1 to FNumTimbrature[Day] do
    FTimbrature[Day,i-1]:=FTimbrature[Day,i];

  Abblenca(0,Day,FNumTimbrature[Day]);
  FNumTimbrature[Day]:=FNumTimbrature[Day]-1;
  SessioneOracle.Commit;
end;

end.

