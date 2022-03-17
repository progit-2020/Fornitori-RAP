unit A013UCalendIndivDtM1;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  DB, A000UCostanti, A000USessione,A000UInterfaccia, RegistrazioneLog, OracleData, Oracle,
  C700USelezioneAnagrafe, Variants, C180FunzioniGenerali, A013UCalendIndivMW;

type
  TA013FCalendIndivDtM1 = class(TDataModule)
    procedure A013FCalendIndivDtM1Create(Sender: TObject);
    procedure A013FCalendIndivDtM1Destroy(Sender: TObject);
  private
    //mPasqua,gPasqua,mPasquetta,gPasquetta:word;
    //S_Anno,D_Anno,Erre,Erre1:word;
    //Ope,Ope1,VarCal,VarCal1,VarCal2,Anno0,Anno1,Anno2,Anno3,Anno4:word;
    //procedure CalcoloPasqua;
  public
    A013MW:TA013FCalendIndivMW;
  end;

var
  A013FCalendIndivDtM1: TA013FCalendIndivDtM1;

implementation

uses A013UCalendIndiv;

{$R *.DFM}

procedure TA013FCalendIndivDtM1.A013FCalendIndivDtM1Create(Sender: TObject);
{Registro il progressivo del dipendente}
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
  A013MW:=TA013FCalendIndivMW.Create(Self);
end;

procedure TA013FCalendIndivDtM1.A013FCalendIndivDtM1Destroy(Sender: TObject);
var i:Integer;
begin
  for i:=0 to Self.ComponentCount - 1 do
    if Self.Components[i] is TDataSet then
      (Self.Components[i] as TDataSet).Close;
end;


(*
procedure TA013FCalendIndivDtM1.CalcoloPasqua;
{Calcolo della Pasqua e Pasquetta}
var aaLeft,aaRight:String;
begin
  aaLeft:=Copy(IntToStr(Anno0),1,2);
  aaRight:=Copy(IntToStr(Anno0),3,2);
  S_Anno:=StrToInt(aaLeft);
  D_Anno:=StrToInt(aaRight);
  VarCal:=Anno0 div 19;
  Anno1:=Anno0 - VarCal * 19;
  VarCal:=S_Anno div 30;
  Anno2:=S_Anno - VarCal * 30;
  VarCal:=(S_Anno - 15) div 25;
  Anno3:=(S_Anno - 15) - VarCal * 25;
  VarCal:=S_Anno div 4;
  VarCal1:=Anno3 div 3;
  VarCal2:=(S_Anno - 15) div 25;
  Ope1:=30 + Anno1 * 11 - Anno2 + VarCal + VarCal2 * 8 + VarCal1;
  VarCal:=Ope1 div 30;
  Ope:=Ope1 - VarCal * 30;
  if Ope <> 11 then
    begin
    if Ope > 11 then
      begin
      VarCal:=Anno0 div 19;
      Anno4:=VarCal * 19;
      if (Ope = 12) and (Anno4 > 10) then Ope:=13;
      end
    else
      Ope:=Ope + 30;
    end
  else
    Ope:=12;
  VarCal:=S_Anno div 4;
  Anno4:=S_Anno - VarCal * 4;
  VarCal:=D_Anno div 4;
  Erre1:=D_Anno + VarCal + Anno4 * 5 + Ope * 6;
  VarCal:=Erre1 div 7;
  Erre:=Erre1 - VarCal * 7;
  gPasqua:=68 - Ope - Erre;
  mPasqua:=3;
  if gPasqua < 32 then
    begin
    if gPasqua < 31 then
      begin
      gPasquetta:=gPasqua+1;
      mPasquetta:=mPasqua;
      end
    else
      begin
      gPasquetta:=gPasqua + 1 - 31;
      mPasquetta:=4;
      end;
    end
  else
    begin
    gPasqua:=gPasqua - 31;
    mPasqua:=4;
    gPasquetta:=gPasqua+1;
    mPasquetta:=mPasqua;
    end;
end;
*)

end.
