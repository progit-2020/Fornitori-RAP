unit A058UCoperturaSquadra;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, A058UPianifTurniDtm1, C180FunzioniGenerali, DB, OracleData;

type TSquadre = record
       Operatore:String;
       Squadra:String;
       MinFer:array[1..4] of Integer;
       MinFes:array[1..4] of Integer;
       MaxFer:array[1..4] of Integer;
       MaxFes:array[1..4] of Integer;
    end;
    TColMatrice = record
        Col:array[1..4] of string;
    end;

type
  TA058FCoperturaSquadra = class(TForm)
    SquadGriglia: TStringGrid;
    procedure FormShow(Sender: TObject);
    procedure SquadGrigliaDrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
  private
    { Private declarations }
    Indice:integer;
    AInizio,DataDa:TDateTime;
    VetSquadre:array of TSquadre;
    VetMatCol:array of TColMatrice;
    procedure GetSquadre(Squadra:String='';Oper:String='');
    function DaSquadre(Squad:String):Boolean;
    function GetNumSquadra(Turn,Squad:String;Oper:String=''):Integer;
    function ControlloAss(Dip,Gio:Integer):Boolean;        
  public
    { Public declarations }
  end;

var A058FCoperturaSquadra: TA058FCoperturaSquadra;

procedure OpenA058CoperturaSquadra(IndiceVista:Integer;Data:TDateTime);

implementation

uses A058UPianifTurni;

{$R *.dfm}

procedure OpenA058CoperturaSquadra(IndiceVista:Integer;Data:TDateTime);
begin
  A058FCoperturaSquadra:=TA058FCoperturaSquadra.Create(nil);
  A058FCoperturaSquadra.Indice:=IndiceVista;
  A058FCoperturaSquadra.DataDa:=Data;
  try
    A058FCoperturaSquadra.ShowModal;
  finally
    FreeAndNil(A058FCoperturaSquadra);
  end;
end;

function TA058FCoperturaSquadra.ControlloAss(Dip,Gio:Integer):Boolean;
var Ret:Boolean;
begin
  Ret:=False;
  if (TGiorno(TDipendente(A058FPianifTurniDtm1.Vista[Dip]).Giorni[Gio]).Ass1 <> '') or
     (TGiorno(TDipendente(A058FPianifTurniDtm1.Vista[Dip]).Giorni[Gio]).Ass2 <> '') then
    Ret:=True;
  Result:=Ret;
end;

function TA058FCoperturaSquadra.DaSquadre(Squad:String):Boolean;
var Ret:Boolean;
begin
  with A058FPianifTurniDtM1 do
  begin
    Ret:=True;
    if Not(selOperatori.Active) then
      selOperatori.Open;
    if Trim(VarToStr(selOperatori.Lookup('SQUADRA',Squad,'SQUADRA'))) <> '' then
      Ret:=False;
  end;
  Result:=Ret;
end;

function TA058FCoperturaSquadra.GetNumSquadra(Turn,Squad:String;Oper:String=''):Integer;
//Calcola il numero dei dipendenti presenti in un turno, in una squadra e in un
//determinato giorno(se Oper è valorizzato fa un ulteriore distinzione per operatore)
var IndGio,i,Ret:Integer;
    TempSquad,TempTurn1,TempTurn2:String;
//Se riconosce la presenza di più operatori all'interno della vista
//ritorna true
function PiuOperatori:Boolean;
var Ind:Integer;
    Operatore:String;
begin
  Result:=False;
  with A058FPianifTurniDtm1 do
  begin
    Operatore:=TGiorno(TDipendente(Vista[0]).Giorni[IndGio]).Oper;
    for Ind:=0 to Vista.Count - 1 do
      if TGiorno(TDipendente(Vista[Ind]).Giorni[IndGio]).Oper <> Operatore then
      begin
        Result:=True;
        Break;
      end;
  end;
end;

begin
  IndGio:=Indice;
  with A058FPianifTurniDtm1 do
  begin
    Ret:=0;
    Oper:=Trim(Oper);
    for i:=0 to Vista.Count-1 do
    begin
      TempTurn1:='NULL';
      if (TGiorno(TDipendente(Vista[i]).Giorni[IndGio]).T1EU <> 'U') then
        TempTurn1:=TGiorno(TDipendente(Vista[i]).Giorni[IndGio]).NumTurno1;

      TempTurn2:='NULL';
      if TGiorno(TDipendente(Vista[i]).Giorni[IndGio]).NumTurno2 <> '' then
        if (TGiorno(TDipendente(Vista[i]).Giorni[IndGio]).T2EU <> 'U') then
          TempTurn2:=TGiorno(TDipendente(Vista[i]).Giorni[IndGio]).NumTurno2;
                                                       
      TempSquad:=TGiorno(TDipendente(Vista[i]).Giorni[IndGio]).Squadra;
      if (Squad = TempSquad) and ((Turn = TempTurn1) or (Turn = TempTurn2)) and
         (TGiorno(TDipendente(Vista[i]).Giorni[IndGio]).Flag <> 'NT') and
         Not(ControlloAss(i,IndGio)) then
        if (Oper = TGiorno(TDipendente(Vista[i]).Giorni[IndGio]).Oper) or Not PiuOperatori then
          Inc(Ret);
    end;
  end;
  Result:=Ret;
end;

procedure TA058FCoperturaSquadra.FormShow(Sender: TObject);
var i,j,NumSquadra:Integer;
begin
  with A058FPianifTurni do
  begin
    with A058FPianifTurniDtM1 do
    begin
      if Not(SelT010.Active) then
      begin
        SelT010.Close;
        SelT010.SetVariable('PROGRESSIVO',TDipendente(Vista[0]).Prog);
        SelT010.SetVariable('DATA1',EncodeDate(R180Anno(DataDa),1,1));
        SelT010.SetVariable('DATA2',EncodeDate(R180Anno(DataDa),12,31));
        SelT010.Open;
      end;
      AInizio:=EncodeDate(R180Anno(DataInizio),1,1);
      GetSquadre;
      SquadGriglia.RowCount:=High(VetSquadre)+2;
      SetLength(VetMatCol,High(VetSquadre)+1);
      SquadGriglia.Cells[0,0]:='Squa(Oper)';
      for i:=1 to 4 do
        SquadGriglia.Cells[i,0]:='Turno ' + IntToStr(i);
      for i:=Low(VetSquadre) to High(VetSquadre) do
      begin
        SquadGriglia.Cells[0,i+1]:=VetSquadre[i].Squadra + '(' + VetSquadre[i].Operatore + ')';
        for j:=1 to 4 do
        begin
          NumSquadra:=GetNumSquadra(IntToStr(j),VetSquadre[i].Squadra,VetSquadre[i].Operatore);
          if VarToStr(A058FPianifTurniDtM1.SelT010.Lookup('DATA',DataDa,'FESTIVO')) = 'S' then
          begin
            if (NumSquadra < VetSquadre[i].MinFes[j]) or
               (NumSquadra > VetSquadre[i].MaxFes[j]) then
              VetMatCol[i].Col[j]:='E';
            SquadGriglia.Cells[j,i+1]:='(' + IntToStr(VetSquadre[i].MinFes[j]) + ' - ' + IntToStr(VetSquadre[i].MaxFes[j]) + ') ';
          end
          else
          begin
            if (NumSquadra < VetSquadre[i].MinFer[j]) or
               (NumSquadra > VetSquadre[i].MaxFer[j]) then
              VetMatCol[i].Col[j]:='E';
            SquadGriglia.Cells[j,i+1]:='(' + IntToStr(VetSquadre[i].MinFer[j]) + ' - ' + IntToStr(VetSquadre[i].MaxFer[j]) + ') ';
          end;
          SquadGriglia.Cells[j,i+1]:=SquadGriglia.Cells[j,i+1] + IntToStr(GetNumSquadra(IntToStr(j),VetSquadre[i].Squadra,VetSquadre[i].Operatore));
       end;
      end;
    end;
  end;
end;

procedure TA058FCoperturaSquadra.GetSquadre(Squadra:String='';Oper:String='');
//Prende le squadre del giorno designato con i loro relativi massimi e minimi
//NB:Prima di richiamarla ripulire il vettore "VetSquadre" = "SetLength(VetSquadre,0)"
var i,j,IndGio,k:Integer;
    TempSquadra,TempOper:String;
    Trovato:Boolean;
begin
  with A058FPianifTurni do
  begin
    with A058FPianifTurniDtM1 do
    begin
      IndGio:=Indice;
      for i:=0 to Vista.Count-1 do
      begin
        //Ricerca di valori già esistenti
        TempSquadra:=TGiorno(TDipendente(Vista[i]).Giorni[IndGio]).Squadra;
        TempOper:='';
        if Not(daSquadre(TempSquadra)) then
          TempOper:=TGiorno(TDipendente(Vista[i]).Giorni[IndGio]).Oper;

        if (TempSquadra <> '') then
        begin
          Trovato:=False;
          for k:=Low(VetSquadre) to High(VetSquadre) do
            if (VetSquadre[k].Squadra = TempSquadra) and (VetSquadre[k].Operatore = TempOper) then
              Trovato:=True;

          if Not(Trovato) then
          begin
            j:=High(VetSquadre);
            if j <= -1 then
              SetLength(VetSquadre,1)
            else
              SetLength(VetSquadre,High(VetSquadre)+2);

            j:=High(VetSquadre);
            //Carico Squadra e Operatore
            VetSquadre[j].Squadra:=TempSquadra;
            VetSquadre[j].Operatore:=TempOper;
            sel2T600.Close;
            if Squadra <> '' then
              TempSquadra:=Squadra;
            sel2T600.SetVariable('SQUADRA',TempSquadra);
            sel2T600.Open;
            //Caricamento dei limiti Max e Min a seconda se prendo dalle squadre
            //o dagli operatori
            if (daSquadre(TempSquadra)) or (TempOper = '') then
            begin
              for k:=1 to 4 do
              begin
                VetSquadre[j].MinFer[k]:=sel2T600.FieldByName('TOTMIN' + IntToStr(k)).AsInteger;
                VetSquadre[j].MaxFer[k]:=sel2T600.FieldByName('TOTMAX' + IntToStr(k)).AsInteger;
                if sel2T600.FieldByName('FESMIN' + IntToStr(k)).IsNull then
                  VetSquadre[j].MinFes[k]:=sel2T600.FieldByName('TOTMIN' + IntToStr(k)).AsInteger
                else
                  VetSquadre[j].MinFes[k]:=sel2T600.FieldByName('FESMIN' + IntToStr(k)).AsInteger;
                if sel2T600.FieldByName('FESMAX' + IntToStr(k)).IsNull then
                  VetSquadre[j].MaxFes[k]:=sel2T600.FieldByName('TOTMAX' + IntToStr(k)).AsInteger
                else
                  VetSquadre[j].MaxFes[k]:=sel2T600.FieldByName('FESMAX' + IntToStr(k)).AsInteger;
              end;
            end
            else
            begin
              if Oper <> '' then
                TempOper:=Oper;
              sel2T601.Close;
              sel2T601.SetVariable('SQUADRA',TempSquadra);
              sel2T601.SetVariable('OPERATORE',TempOper);
              sel2T601.Open;

              for k:=1 to 4 do
              begin
                VetSquadre[j].MinFer[k]:=sel2T601.FieldByName('MIN' + IntToStr(k)).AsInteger;
                VetSquadre[j].MaxFer[k]:=sel2T601.FieldByName('MAX' + IntToStr(k)).AsInteger;
                if sel2T601.FieldByName('FESMIN' + IntToStr(k)).IsNull then
                  VetSquadre[j].MinFes[k]:=sel2T601.FieldByName('MIN' + IntToStr(k)).AsInteger
                else
                  VetSquadre[j].MinFes[k]:=sel2T601.FieldByName('FESMIN' + IntToStr(k)).AsInteger;
                if sel2T601.FieldByName('FESMAX' + IntToStr(k)).IsNull then
                  VetSquadre[j].MaxFes[k]:=sel2T601.FieldByName('MAX' + IntToStr(k)).AsInteger
                else
                  VetSquadre[j].MaxFes[k]:=sel2T601.FieldByName('FESMAX' + IntToStr(k)).AsInteger;
              end;
            end;
          end;
        end;
        if (Squadra <> '') or (Oper <> '') then
          Break;
      end;
      sel2T600.Close;
      sel2T601.Close;
    end;
  end;
end;

procedure TA058FCoperturaSquadra.SquadGrigliaDrawCell(Sender: TObject; ACol,
 ARow: Integer; Rect: TRect; State: TGridDrawState);
begin
//--colore celle--//
  if (SquadGriglia.Cells[ACol,ARow] <> '') and
     (ARow > 0) and (ACol > 0) then
  begin
    if VetMatCol[ARow-1].Col[ACol] = 'E' then
      SquadGriglia.Canvas.Brush.Color:=clRed;
    SquadGriglia.Canvas.FillRect(Rect);
    SquadGriglia.Canvas.TextOut(Rect.Left,Rect.Top,SquadGriglia.Cells[ACol,ARow]);
  end;
end;

end.
