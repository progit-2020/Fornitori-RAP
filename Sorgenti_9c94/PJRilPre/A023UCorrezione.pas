unit A023UCorrezione;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ExtCtrls,R500Lin, A000UCostanti, A000USessione,A000UInterfaccia, C700USelezioneAnagrafe,
  C180FunzioniGenerali, Variants, ComCtrls;

type
  TA023FCorrezione = class(TForm)
    BtnAvvio: TBitBtn;
    btnSuccessivo: TBitBtn;
    BtnCorreggi: TBitBtn;
    BtnClose: TBitBtn;
    btnPrecedente: TBitBtn;
    rcedtAnomalia: TRichEdit;
    procedure BtnAvvioClick(Sender: TObject);
    procedure btnSuccessivoClick(Sender: TObject);
    procedure BtnCorreggiClick(Sender: TObject);
    procedure BtnCloseClick(Sender: TObject);
  private
    { Private declarations }
    Prog,Livello:Integer;
    Data,DataOriginale:TDateTime;
    Anomalia:String;
    SB,SN:String;
    TotAnom,AnomCorr:Integer;
    procedure DeleteRecord;
    procedure Inizio;
    procedure ScorriQuery(Avanti:Boolean);
    procedure Fine;
  public
    { Public declarations }
    function CalcolaGiorno(GG:Integer):Integer;
  end;

var
  A023FCorrezione: TA023FCorrezione;

implementation

uses A023UTimbratureDtM1, A023UTimbrature, SelAnagrafe;

{$R *.DFM}

procedure TA023FCorrezione.BtnAvvioClick(Sender: TObject);
begin
  DataOriginale:=EncodeDate(A023FTimbrature.EAnno.Value,A023FTimbrature.EMese.Value,A023FTimbrature.Giorno);
  Inizio;
  BtnAvvio.Enabled:=False;
  ScorriQuery(True);
end;

procedure TA023FCorrezione.Inizio;
begin
  rcedtAnomalia.Text:='';
  BtnAvvio.Enabled:=True;
  btnSuccessivo.Enabled:=False;
  btnPrecedente.Enabled:=False;
  BtnCorreggi.Enabled:=False;
  TotAnom:=0;
  AnomCorr:= 0;
  A023FTimbratureDtM1.A023FTimbratureMW.SetProgOperAnomale;
end;

procedure TA023FCorrezione.ScorriQuery(Avanti:Boolean);
var
  sTimbGior  :String;
  vTimbMan: array of String;
  iTimbMan, iPosMan, i : Integer;
begin
  with A023FTimbratureDtM1.A023FTimbratureMW do
  begin
    if Avanti then
    begin
     if Q101.Active then
       Q101.Next
     else
     begin
       Screen.Cursor:=crHourGlass;
       Q101.Open;
       Screen.Cursor:=crDefault;
     end;
     if Q101.Eof then
     begin
       Fine;
       exit;
     end;
    end
    else
    begin
      Q101.Prior;
      if Q101.Bof then
        exit;
    end;
    btnSuccessivo.Enabled:=Q101.RecordCount > 0;
    btnPrecedente.Enabled:=Q101.RecordCount > 0;
    btnCorreggi.Enabled:=Q101.RecordCount > 0;
    TotAnom:=Q101.RecNo;
    Prog:=Q101.FieldByName('Progressivo').Value;
    Data:=Q101.FieldByName('Data').Value;
    Livello:=Q101.FieldByName('Livello').AsInteger;
    Anomalia:=Q101.FieldByName('Anomalia').Value;
    A023FTimbrature.frmSelAnagrafe.SelezionaProgressivo(Prog);
    SB:=C700SelAnagrafe.FieldByname('T430BADGE').AsString;
    SN:=C700SelAnagrafe.FieldByname('COGNOME').AsString + ' ' + C700SelAnagrafe.FieldByname('NOME').AsString;
    rcedtAnomalia.Lines.Clear;
    rcedtAnomalia.Lines.Add('Matricola:' + C700SelAnagrafe.FieldByname('MATRICOLA').AsString + ' Badge:' + SB + ' ' + SN);
    rcedtAnomalia.Lines.Add('Data:' + FormatDateTime('dd/mm/yyyy',Data));
    rcedtAnomalia.Lines.Add(Format('Anomalia di %d° livello',[Livello]));
    rcedtAnomalia.Lines.Add(Anomalia);
    selT100.Close;
    selT100.SetVariable('Progressivo',Q101.FieldByName('Progressivo').AsInteger);
    selT100.SetVariable('Data',Q101.FieldByName('Data').AsDateTime);
    selT100.Open;
    sTimbGior:='';
    iTimbMan:=0;
    SetLength(vTimbMan,0);
    while not selT100.Eof do
    begin
      //selT100.FieldByName('Causale').AsString;
      sTimbGior:=sTimbGior + selT100.FieldByName('Verso').AsString;
      sTimbGior:=sTimbGior + FormatDateTime('hh:mm',selT100.FieldByName('Ora').AsDateTime);
      //Registro le timbrature originali per metterle poi in rosso
      if selT100.FieldByName('Flag').AsString = 'O' then
      begin
        inc(iTimbMan);
        SetLength(vTimbMan,iTimbMan + 1);
        vTimbMan[iTimbMan]:=selT100.FieldByName('Verso').AsString +
          FormatDateTime('hh:mm',selT100.FieldByName('Ora').AsDateTime);
      end;
      sTimbGior:=sTimbGior + ' ';
      selT100.Next;
    end;
    rcedtAnomalia.Lines.Add(sTimbGior);
    for i:=1 to High(vTimbMan) do
    begin
      iPosMan:=rcedtAnomalia.FindText(vTimbMan[i], 0, Length(rcedtAnomalia.Text), [stMatchCase]);
      rcedtAnomalia.SelStart:=iPosMan;
      rcedtAnomalia.SelLength:=6;
      rcedtAnomalia.SelAttributes.Color:=clRed;
    end;
    rcedtAnomalia.SelLength:=0;
  end;
end;

procedure TA023FCorrezione.btnSuccessivoClick(Sender: TObject);
begin
  ScorriQuery(Sender = btnSuccessivo);
end;

function TA023FCorrezione.CalcolaGiorno(GG:Integer):Integer;
begin
  case GG of
   1..6:Result:=1;
   7..12:Result:=7;
   13..18:Result:=13;
   19..24:Result:=19;
   25..30:Result:=25;
  else
   Result:=31;
  end;
end;

procedure TA023FCorrezione.BtnCorreggiClick(Sender: TObject);
var YY,MM:Word;
begin
  with A023FTimbrature do
  begin
    Screen.Cursor:=crHourGlass;
    inc(AnomCorr,1);
    BtnCorreggi.Enabled:=False;
    DecodeDate(Data,YY,MM,Giorno);
    Giorno:=CalcolaGiorno(Giorno);
    DeleteRecord;
    EMese.Value:=MM;
    EAnno.Value:=YY;
    CaricaGriglie;
    A023FTimbrature.SetFocus;
    Screen.Cursor:=crDefault;
  end;
end;

procedure TA023FCorrezione.DeleteRecord;
begin
  with A023FTimbratureDtM1.A023FTimbratureMW do
    begin
      Q101Delete.SetVariable('Progressivo',Prog);
      Q101Delete.SetVariable('Data',Data);
      Q101Delete.SetVariable('Livello',Livello);
      Q101Delete.SetVariable('Anomalia',Anomalia);
      Q101Delete.SetVariable('Operatore',Parametri.ProgOper);
      try
       Q101Delete.Execute;
       SessioneOracle.Commit;
      except
      end;
    end;
end;

procedure TA023FCorrezione.Fine;
begin
  rcedtAnomalia.Lines.Clear;
  rcedtAnomalia.Lines.Add('Correzione terminata.');
  rcedtAnomalia.Lines.Add('Totale anomalie riscontrate:'+inttostr(TotAnom));
  rcedtAnomalia.Lines.Add('Numero anomalie corrette:'+inttostr(AnomCorr));
  rcedtAnomalia.Lines.Add('Numero anomalie ignorate:'+inttostr(TotAnom - AnomCorr));
  BtnAvvio.Enabled:=True;
  btnSuccessivo.Enabled:=False;
  btnPrecedente.Enabled:=False;
  BtnCorreggi.Enabled:=False;
end;

procedure TA023FCorrezione.BtnCloseClick(Sender: TObject);
begin
  C700OldProgressivo:=0;
  A023FTimbrature.frmSelAnagrafe.RipristinaC00SelAnagrafe(A023FTimbratureDtM1.A023FTimbratureMW);
  A023FTimbrature.Giorno:=CalcolaGiorno(R180Giorno(DataOriginale));
  A023FTimbrature.EMese.Value:=R180Mese(DataOriginale);
  A023FTimbrature.EAnno.Value:=R180Anno(DataOriginale);
  A023FTimbrature.CaricaGriglie;
  Inizio;
  Close;
end;

end.
