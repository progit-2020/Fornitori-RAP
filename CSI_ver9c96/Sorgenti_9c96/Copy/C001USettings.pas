unit C001USettings;

interface
uses Classes,Graphics,SysUtils,C001StampaLib,C180FunzioniGenerali, Variants;

const CAMPOTAB = '**';
      CONSTSTAMPA = '$$';
      OGGETTO = '@@';
      PARANAG = '??';
      FONTDEF = '[[';
      CLINEAREC = '((';
      CLINEAINF = '))';
      CLINEASUP = '__';
      CBANDAAB = '--';
      NUMBANDEGRUPPO = '::';
      CPAGINESEP = '##';
      FONTBGRUPPO = '++';
      //Modalità di stampa (Elenco, Scheda, Gruppo)
      CMODALITA = '&&';

  procedure CreaListaSettaggi;
  procedure DistruggiListaSettaggi;
  procedure EliminaElementi(Tipo : String);
  procedure SettaTitoloStampa(Value : String);
  procedure SettaParametriAnagrafico(Value : String);
  procedure SalvaDefaultFont(DefaultFont : TFont);
  function FontStyleToString(FontStyle : TFontStyles) : String;
  function StringToFontStyle(FontStyle : String) : TFontStyles;
  procedure SalvaLinea(Tipo : String;Values : TRec_Linea);
  procedure SalvaBanda(Tipo : String);
  procedure SalvaModalita(Tipo : String);
  procedure SalvaNumBandeGruppo(Tipo : String;Value : Integer);
  procedure SalvaFontBandeGruppo(Tipo : String;NumeroBande : Integer);
  procedure SalvaPagineSeparate(Tipo : String;Value : Boolean);

var ListaSettaggi : TStringList;
    CODINT : String;

implementation

//------------------------------------------------------------------------------
function FontStyleToString(FontStyle : TFontStyles) : String;
begin
  Result := '';
  if fsBold in FontStyle then
    Result := Result + 'B';
  if fsItalic in FontStyle then
    Result := Result + 'I';
  if fsUnderline in FontStyle then
    Result := Result + 'U';
  if fsStrikeOut in FontStyle then
    Result := Result + 'S';
end;

//------------------------------------------------------------------------------
function StringToFontStyle(FontStyle : String) : TFontStyles;
begin
  Result := [];
  if pos('B',FontStyle) <> 0 then
    Result := Result + [fsBold];
  if pos('I',FontStyle) <> 0 then
    Result := Result + [fsItalic];
  if pos('U',FontStyle) <> 0 then
    Result := Result + [fsUnderline];
  if pos('S',FontStyle) <> 0 then
    Result := Result + [fsStrikeOut];
end;


//------------------------------------------------------------------------------
procedure CreaListaSettaggi;
begin
  ListaSettaggi := TStringList.Create;
  ListaSettaggi.Clear;
end;

//------------------------------------------------------------------------------
procedure DistruggiListaSettaggi;
begin
  ListaSettaggi.Free;
end;

//------------------------------------------------------------------------------
procedure EliminaElementi(Tipo : String);
var I: Integer;
begin
  if ListaSettaggi <> nil then
    begin
      for I := ListaSettaggi.Count - 1 downto 0 do
         begin
           if Copy(ListaSettaggi[I],1,2) = Tipo then
             ListaSettaggi.Delete(I);
         end;
    end;
end;

//------------------------------------------------------------------------------
procedure SettaTitoloStampa(Value : String);
begin
  if ListaSettaggi <> nil then
    begin
      EliminaElementi(CONSTSTAMPA);
      ListaSettaggi.Add(CONSTSTAMPA + ';'+Value+';');
    end;
end;

//------------------------------------------------------------------------------
procedure SettaParametriAnagrafico(Value : String);
begin
  if ListaSettaggi <> nil then
    begin
      EliminaElementi(PARANAG);
      ListaSettaggi.Add(PARANAG + ';'+Value+';');
    end;
end;

//------------------------------------------------------------------------------
procedure SalvaDefaultFont(DefaultFont : TFont);
var App : String;
begin
  App := IntToStr(DefaultFont.Color);
  App := App + ';'+ Inttostr(DefaultFont.Height);
  App := App + ';'+ Inttostr(DefaultFont.Size);
  App := App + ';'+ DefaultFont.Name;
  App := App + ';'+ FloatToStr(Variant(DefaultFont.Pitch));
  App := App + ';'+ FontStyleToString(DefaultFont.Style);  // fontstyle
  if ListaSettaggi <> nil then
    begin
      EliminaElementi(FONTDEF);
      ListaSettaggi.Add(FONTDEF + ';'+App+';');
    end;
end;

//------------------------------------------------------------------------------
procedure SalvaLinea(Tipo : String;Values : TRec_Linea);
var S : String;
begin
  if ListaSettaggi <> nil then
    begin
      EliminaElementi(Tipo);
      S := Tipo + ';' + inttostr(Values.Altezza);
      S := S + ';'+inttostr(Values.Larghezza);
      S := S + ';' + inttostr(Values.Allineamento);
      S := S + ';' + inttostr(Values.Tratteggio);
      if Values.Enabled then
        S := S + ';' + 'S'+';'
      else
        S := S + ';' + 'N'+';';
      ListaSettaggi.Add(S);
    end;
end;

//------------------------------------------------------------------------------
procedure SalvaBanda(Tipo : String);
var S : String;
begin
  if ListaSettaggi <> nil then
    begin
      EliminaElementi(Tipo);
      if InterLineaAbilitata then
        S := Tipo + ';' + 'S'
      else
        S := Tipo + ';' + 'N';
      S := S + ';' + inttostr(AltezzaInterLinea)+';';
      ListaSettaggi.Add(S);
    end;
end;

//------------------------------------------------------------------------------
//Salva modalità di stampa (Elenco, Scheda, Gruppo)
procedure SalvaModalita(Tipo : String);
var S : String;
begin
  if ListaSettaggi <> nil then
  begin
    EliminaElementi(Tipo);
    if Modalita = Elenco then
      S := Tipo + ';' + 'Elenco'
    else
      S := Tipo + ';' + 'Scheda';
    ListaSettaggi.Add(S);
  end;
end;

//------------------------------------------------------------------------------
procedure SalvaNumBandeGruppo(Tipo : String;Value : Integer);
var S : String;
begin
  if ListaSettaggi <> nil then
    begin
      EliminaElementi(Tipo);
      S := Tipo + ';' + inttostr(Value)+';';
      ListaSettaggi.Add(S);
    end;
end;

//------------------------------------------------------------------------------
procedure SalvaFontBandeGruppo(Tipo : String;NumeroBande : Integer);
var S : String;
    I : Integer;
begin
  if ListaSettaggi <> nil then
    begin
      EliminaElementi(Tipo);
      for I:=1 to NumeroBande do
         begin
           S := Tipo;
           S := S + ';'+ IntToStr(FontGruppo[I].Color);
           S := S + ';'+ Inttostr(FontGruppo[I].Height);
           S := S + ';'+ Inttostr(FontGruppo[I].Size);
           S := S + ';'+ FontGruppo[I].Name;
           S := S + ';'+ FloatToStr(Variant(FontGruppo[I].Pitch));
           S := S + ';'+ FontStyleToString(FontGruppo[I].Style)+';';  // fontstyle
           ListaSettaggi.Add(S);
         end;
    end;
end;


//------------------------------------------------------------------------------
procedure SalvaPagineSeparate(Tipo : String;Value : Boolean);
var S : String;
begin
  if ListaSettaggi <> nil then
    begin
      EliminaElementi(Tipo);
      if Value then
        S := Tipo + ';' + 'S' +';'
      else
        S := Tipo + ';' + 'N' +';';
      ListaSettaggi.Add(S);
    end;
end;


end.
