unit A023UTimbMese;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ComCtrls, Menus,DB,ExtCtrls,C180FunzioniGenerali, Buttons,
  C700USelezioneAnagrafe, Variants, OracleData, A023UTimbratureDtm1;

type
  TA023FTimbMese = class(TForm)
    RichEdit1: TRichEdit;
    Panel1: TPanel;
    BitBtn1: TBitBtn;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    G: TLabel;
    lblTMensa: TLabel;
    procedure BitBtn1Click(Sender: TObject);
  private
    { Private declarations }
    procedure FiltroQ100(Data : TDateTime);
    procedure FiltroQ040(Data : TDateTime);
    procedure FiltroT370(Data : TDateTime);    
    function  GetGiorno(Data : TDateTime) : String;
  public
    { Public declarations }
    Anno,Mese : Word;
    Progressivo:Integer;
    SN : String;
    Q040,Q100,Q275,Q305:TOracleDataSet;
    procedure CaricaEdit;
  end;

var
  A023FTimbMese: TA023FTimbMese;

implementation

{$R *.DFM}

procedure TA023FTimbMese.FiltroT370(Data : TDateTime);
begin
  with A023FTimbratureDtM1 do
  begin
    selT370.Filtered:=False;
    selT370.Filter:='DATA = ' + FloatToStr(Data);
    selT370.Filtered:=True;
  end;
end;

procedure TA023FTimbMese.FiltroQ100(Data : TDateTime);
var DataStr : String;
begin
  DataStr := FormatDateTime('dd/mm/yyyy',Data);
  Q100.Filtered := False;
  Q100.Filter := concat('(Data = ','''',DataStr,'''',')');
  Q100.Filtered := True;
end;

procedure TA023FTimbMese.FiltroQ040(Data : TDateTime);
var DataStr : String;
begin
  DataStr := FormatDateTime('dd/mm/yyyy',Data);
  Q040.Filtered := False;
  Q040.Filter := concat('(Data = ','''',DataStr,'''',')');
  Q040.Filtered := True;
end;

function TA023FTimbMese.GetGiorno(Data : TDateTime) : String;
begin
  Result := '';
  case DayOfWeek(Data) of
    1:Result := 'Do';
    2:Result := 'Lu';
    3:Result := 'Ma';
    4:Result := 'Me';
    5:Result := 'Gi';
    6:Result := 'Ve';
    7:Result := 'Sa';
  end;
  Result := Result + ' ' +FormatDateTime('dd',Data);
end;

procedure TA023FTimbMese.CaricaEdit;
var DataCorr,DataF:TDateTime;
    I:Integer;
    App,Verso,Ril,Ora,Flag,Cau,Tipo,Durata:String;
    Book:TBookMark;
begin
  if A023FTimbratureDtM1 <> nil then
    with A023FTimbratureDtM1 do
    begin
      selT370.SetVariable('ANNO',IntToStr(Anno));
      selT370.SetVariable('MESE',IntToStr(Mese));
      selT370.SetVariable('PROGR',Progressivo);
      selT370.Close;
      selT370.Open;
    end;
  SN:=Format('%-8s %s %s',[C700SelAnagrafe.FieldByname('MATRICOLA').AsString,C700SelAnagrafe.FieldByname('COGNOME').AsString,C700SelAnagrafe.FieldByname('NOME').AsString]);
  DataCorr := EnCodeDate(Anno,Mese,01);
  DataF := EnCodeDate(Anno,Mese,R180GiorniMese(DataCorr));
  Caption:=SN + ' - Timbrature di ' + FormatDateTime('mmmm yyyy',DataF);
  RichEdit1.Lines.Clear;
  RichEdit1.SelAttributes.Color := clBlack;
  RichEdit1.Lines.Add(Caption);
  Book:=Q100.GetBookmark;
  { TODO : TEST IW 15 }
  try
    I:=1;
    while (DataCorr <= DataF) do
    begin
      FiltroQ100(DataCorr);
      //------------   timbraure  ----------------------------------------------------
      App := GetGiorno(DataCorr)+' ';
      RichEdit1.Lines.Add('');
      RichEdit1.SelAttributes.Color := clBlack;
      RichEdit1.Lines[I] := App;
      if Q100.RecordCount > 0 then
        Q100.First
      else
      begin
        RichEdit1.SelAttributes.Color := clBlack;
        RichEdit1.SelText := '--- Nessuna timbratura ---';
      end;
      while not(Q100.EOF) do
      begin
        Verso := Q100.FieldByName('Verso').AsString;
        Ora := FormatDateTime('hh.mm',Q100.FieldByName('Ora').Value);
        Ril := Format('%-2.2s',[Q100.FieldByName('Rilevatore').Value]);
        Cau := Format('%-5.5s',[Q100.FieldByName('Causale').Value]);
        Flag := Q100.FieldByName('Flag').Value;
        if Verso = 'E' then
          RichEdit1.SelAttributes.Color := clGreen
        else
          RichEdit1.SelAttributes.Color := clBlue;
        RichEdit1.SelText := Verso;
        if (Flag='O') then
          RichEdit1.SelAttributes.Color := clRed
        else
          RichEdit1.SelAttributes.Color := clBlack;
        RichEdit1.SelText := Ora;
        RichEdit1.SelAttributes.Color := clBlack;
        RichEdit1.SelText := ' '+Ril;
        //Presenza = clGreen; Giustificativo = clBlue
        if Q275.Locate('Codice',Cau,[]) then
          RichEdit1.SelAttributes.Color:=clGreen
        else
          if Q305.Locate('Codice',Cau,[]) then
            RichEdit1.SelAttributes.Color:=clBlue;
        RichEdit1.SelText := ' '+Cau+' ';
        Q100.Next;
      end;
      //------------   giustificativi ------------------------------------------------
      FiltroQ040(DataCorr);
      if Q040.RecordCount > 0 then
      begin
        RichEdit1.Lines.Add('');
        inc(I,1);
        RichEdit1.Lines[I] := '      ';
        Q100.First;
        while not(Q040.EOF) do
        begin
          Tipo := Q040.FieldbyName('TipoGiust').AsString;
          case Tipo[1] of
            'I':Durata := 'GIORNATA INTERA ';
            'M':Durata := 'MEZZA GIORNATA  ';
            'N':Durata := FormatDateTime('hh.mm',Q040.FieldByName('DaOre').Value) + ' Ore       ';
            'D':Durata := 'Da '+ FormatDateTime('hh.mm ',Q040.FieldByName('DaOre').Value)+'a '+FormatDateTime('hh.mm',Q040.FieldByName('AOre').Value);
          end;
          Cau := Format('%-5.5s',[Q040.FieldByName('Causale').Value]);
          RichEdit1.SelAttributes.Color := clRed;
          RichEdit1.SelText := Durata;
          RichEdit1.SelText := ' '+Cau+' ';
          Q040.Next;
        end;
      end;
      if A023FTimbratureDtM1 <> nil then
      begin
        //------------ Timbrature di Mensa ------------
        FiltroT370(DataCorr);
        with A023FTimbratureDtM1 do
          if selT370.RecordCount > 0 then
          begin
            RichEdit1.Lines.Add('');
            inc(I,1);
            RichEdit1.Lines[i]:='      ';
            RichEdit1.SelAttributes.Style:=[fsItalic];
            RichEdit1.SelText:='T.M.: ';
            selT370.First;
            while Not selT370.Eof do
            begin
              Verso:=selT370.FieldByName('Verso').AsString;
              Ora:=FormatDateTime('hh.mm',selT370.FieldByName('Ora').Value);
              Ril:=Format('%-2.2s',[selT370.FieldByName('Rilevatore').Value]);
              Cau:=Format('%-5.5s',[selT370.FieldByName('Causale').Value]);
              Flag:=selT370.FieldByName('Flag').Value;
              RichEdit1.SelAttributes.Style:=[fsItalic];
              if Verso = 'E' then
                RichEdit1.SelAttributes.Color:=clGreen
              else
                RichEdit1.SelAttributes.Color:=clBlue;
              RichEdit1.SelText:=Verso;
              if (Flag='O') then
                RichEdit1.SelAttributes.Color:=clRed
              else
                RichEdit1.SelAttributes.Color:=clBlack;
              RichEdit1.SelText:=Ora;
              RichEdit1.SelAttributes.Color:=clBlack;
              RichEdit1.SelText:=' '+Ril;
              if Q275.Locate('Codice',Cau,[]) then
                RichEdit1.SelAttributes.Color:=clGreen
              else
                if Q305.Locate('Codice',Cau,[]) then
                  RichEdit1.SelAttributes.Color:=clBlue;
              RichEdit1.SelText:=' '+Cau+' ';
              selT370.Next;
            end;
          end;
      end;
      DataCorr:=DataCorr + 1;
      inc(I,1);
    end;
    Q040.Filtered := False;
    Q100.Filtered := False;
    Q100.GotoBookMark(Book);
  finally
    Q100.FreeBookMark(Book);
  end;
end;

procedure TA023FTimbMese.BitBtn1Click(Sender: TObject);
begin
  RichEdit1.Print(Caption);
end;

end.
