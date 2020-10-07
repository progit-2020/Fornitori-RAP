unit A059UStampa;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  quickrpt, Qrctrls, ExtCtrls, C180FunzioniGenerali, StdCtrls, ComCtrls,
  OracleData, Variants, A000UInterfaccia, QRExport, QRWebFilt, QRPDFFilt;

type
  TA059FStampa = class(TForm)
    QRep: TQuickRep;
    DetailBand1: TQRBand;
    ColumnHeaderBand1: TQRBand;
    PageHeaderBand1: TQRBand;
    QRSysData1: TQRSysData;
    QRSysData2: TQRSysData;
    QRTitolo: TQRLabel;
    QRLabel6: TQRLabel;
    QRLabel7: TQRLabel;
    QRLabel18: TQRLabel;
    QRSquadra: TQRDBText;
    QRDSquadra: TQRDBText;
    QRSubDetail1: TQRSubDetail;
    QRLabel19: TQRLabel;
    QROperatore: TQRDBText;
    QRDBText1: TQRDBText;
    QRDBText2: TQRDBText;
    QRDBText4: TQRDBText;
    QRDBText5: TQRDBText;
    QRDBText7: TQRDBText;
    QRDBText8: TQRDBText;
    QRDBText10: TQRDBText;
    QRDBText11: TQRDBText;
    QRBand1: TQRBand;
    QRDBText13: TQRDBText;
    QRDBText14: TQRDBText;
    QRDBText16: TQRDBText;
    QRDBText17: TQRDBText;
    QRDBText19: TQRDBText;
    QRDBText20: TQRDBText;
    QRDBText22: TQRDBText;
    QRDBText23: TQRDBText;
    QRLabel2: TQRLabel;
    QRLabel3: TQRLabel;
    QRLabel4: TQRLabel;
    QRLabel5: TQRLabel;
    QRGiorni: TQRLabel;
    QRRange: TQRLabel;
    QRData: TQRLabel;
    QRMesi: TQRLabel;
    QRTurno1: TQRRichText;
    QRTurno2: TQRRichText;
    QRTurno3: TQRRichText;
    QRTurno4: TQRRichText;
    QRSquadra1: TQRRichText;
    QRSquadra2: TQRRichText;
    QRSquadra3: TQRRichText;
    QRSquadra4: TQRRichText;
    RichEdit2: TRichEdit;
    RichEdit3: TRichEdit;
    RichEdit4: TRichEdit;
    RichEdit1: TRichEdit;
    RE1: TRichEdit;
    RE2: TRichEdit;
    RE3: TRichEdit;
    RE4: TRichEdit;
    QRLabel1: TQRLabel;
    QRTextFilter1: TQRTextFilter;
    QRRTFFilter1: TQRRTFFilter;
    QRPDFFilter1: TQRPDFFilter;
    QRHTMLFilter1: TQRHTMLFilter;
    QRExcelFilter1: TQRExcelFilter;
    procedure DetailBand1BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure QRSubDetail1BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure QRBand1BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    Tot1,Tot2,Tot3,Tot4:Array [1..100] of Word;
    procedure ContaTurni(Data:TDateTime; QP,QG:TOracleDataSet; var T1,T2,T3,T4:Word);
    procedure GetDatiTurno(MyDataSet:TOracleDataSet; var NumTurno1,NumTurno2:string);
  public
    { Public declarations }
  end;

var
  A059FStampa: TA059FStampa;

implementation

uses A059UContSquadreDtM1, A059UContSquadre;

{$R *.DFM}

procedure TA059FStampa.DetailBand1BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  with A059FContSquadreDtM1 do
  begin
    Q601.Close;
    Q601.SetVariable('Squadra',Q600Squadre.FieldByName('Codice').AsString);
    Q601.Open;
    if Q601.RecordCount <= 0 then
      QRSubDetail1.DataSet:=Q600Squadre;
  end;
  FillChar(Tot1,SizeOf(Tot1),#0);
  FillChar(Tot2,SizeOf(Tot2),#0);
  FillChar(Tot3,SizeOf(Tot3),#0);
  FillChar(Tot4,SizeOf(Tot4),#0);
end;

procedure TA059FStampa.FormCreate(Sender: TObject);
begin
  QRep.useQR5Justification:=True;
end;

procedure TA059FStampa.QRSubDetail1BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
var Corr:TDateTime;
    QP,QG:TOracleDataSet;
    T1,T2,T3,T4,i,
    Mn1,Mn2,Mn3,Mn4,Mx1,Mx2,Mx3,Mx4:Word;
    Bold1,Bold2,Bold3,Bold4:Array [0..99] of Boolean;
begin
  PrintBand:=True;
  with A059FContSquadreDtM1,A059FContSquadre do
    begin
    //Pulisco e inizializzo i RichEdit
    RichEdit1.Lines.Clear;
    RichEdit2.Lines.Clear;
    RichEdit3.Lines.Clear;
    RichEdit4.Lines.Clear;
    RichEdit1.Lines.Add('');
    RichEdit2.Lines.Add('');
    RichEdit3.Lines.Add('');
    RichEdit4.Lines.Add('');
    //Imposto le Query a seconda che uso i dati operativi o non
    if RgpModalita.ItemIndex = 0 then
    begin
      QP:=Q080;
      QG:=Q040;
    end
    else
    begin
      QP:=Q081;
      QP.ClearVariables;
      with QP do
      begin
        if Parametri.CampiRiferimento.C11_PianifOrariProg = 'S' then
        //PIANIFICAZIONE PROGRESSIVA
        begin
          if RgpTipo.ItemIndex = 0 then //Iniziale
            SetVariable('FlagAgg',' AND FLAGAGG = ''I''')
          else if RgpTipo.ItemIndex = 1 then //Corrente
            SetVariable('FlagAgg',' AND FLAGAGG = ''C''');
        end
        else
          SetVariable('FlagAgg',' AND FLAGAGG = ''N''');
      end;
      QG:=Q041;
      QG.ClearVariables;
      with QG do
      begin
        if Parametri.CampiRiferimento.C11_PianifOrariProg = 'S' then
        //PIANIFICAZIONE PROGRESSIVA
        begin
          if RgpTipo.ItemIndex = 0 then //Iniziale
            SetVariable('FlagAgg',' AND FLAGAGG = ''I''')
          else if RgpTipo.ItemIndex = 1 then //Corrente
            SetVariable('FlagAgg',' AND FLAGAGG = ''C''');
        end
        else
          SetVariable('FlagAgg',' AND FLAGAGG = ''N''');
      end;
    end;
    //Imposto i parametri di squadra e tipo operatore
    QP.SetVariable('Squadra',Q600Squadre.FieldByName('Codice').AsString);

    if Q601.RecordCount > 0 then
      QP.SetVariable('TipoOpe','AND TIPOOPE = ''' + Q601.FieldByName('Codice').AsString + '''');

    Corr:=DataInizio;
    while Corr <= DataFine do
    begin
      T1:=0;
      T2:=0;
      T3:=0;
      T4:=0;
      //Leggo le pianificazioni del giorno corrente
      QP.SetVariable('Data',Corr);
      QP.Close;
      QP.Open;
      while not QP.Eof do
      begin
        //Conto i turni del giorno
        ContaTurni(Corr,QP,QG,T1,T2,T3,T4);
        QP.Next;
      end;
      //Incremento totali della squadra
      i:=Trunc(Corr - DataInizio) + 1;
      inc(Tot1[i],T1);
      inc(Tot2[i],T2);
      inc(Tot3[i],T3);
      inc(Tot4[i],T4);
      //Leggo i minimi e massimi registrati si T601
      Mn1:=StrToIntDef(Q601.FieldByName('MIN1').AsString,0);
      Mn2:=StrToIntDef(Q601.FieldByName('MIN2').AsString,0);
      Mn3:=StrToIntDef(Q601.FieldByName('MIN3').AsString,0);
      Mn4:=StrToIntDef(Q601.FieldByName('MIN4').AsString,0);
      Mx1:=StrToIntDef(Q601.FieldByName('MAX1').AsString,0);
      Mx2:=StrToIntDef(Q601.FieldByName('MAX2').AsString,0);
      Mx3:=StrToIntDef(Q601.FieldByName('MAX3').AsString,0);
      Mx4:=StrToIntDef(Q601.FieldByName('MAX4').AsString,0);
      //Scrivo i valori per tipo operatore
      RichEdit1.Lines[0]:=RichEdit1.Lines[0] + R180DimLung(IntToStr(T1),3);
      RichEdit2.Lines[0]:=RichEdit2.Lines[0] + R180DimLung(IntToStr(T2),3);
      RichEdit3.Lines[0]:=RichEdit3.Lines[0] + R180DimLung(IntToStr(T3),3);
      RichEdit4.Lines[0]:=RichEdit4.Lines[0] + R180DimLung(IntToStr(T4),3);
      //Stabilisco lo stile Grassetto
      Bold1[Trunc(Corr - DataInizio)]:=(T1 < Mn1) or (T1 > Mx1);
      Bold2[Trunc(Corr - DataInizio)]:=(T2 < Mn2) or (T2 > Mx2);
      Bold3[Trunc(Corr - DataInizio)]:=(T3 < Mn3) or (T3 > Mx3);
      Bold4[Trunc(Corr - DataInizio)]:=(T4 < Mn4) or (T4 > Mx4);
      Corr:=Corr + 1;
    end;
    Corr:=DataInizio;
    i:=0;
    while Corr <= DataFine do
    begin
      RichEdit1.SelStart:=i * 3;
      RichEdit1.SelLength:=3;
      RichEdit2.SelStart:=i * 3;
      RichEdit2.SelLength:=3;
      RichEdit3.SelStart:=i * 3;
      RichEdit3.SelLength:=3;
      RichEdit4.SelStart:=i * 3;
      RichEdit4.SelLength:=3;
      if Bold1[i] then
        RichEdit1.SelAttributes.Style:=[fsBold]
      else
        RichEdit1.SelAttributes.Style:=[];
      if Bold2[i] then
        RichEdit2.SelAttributes.Style:=[fsBold]
      else
        RichEdit2.SelAttributes.Style:=[];
      if Bold3[i] then
        RichEdit3.SelAttributes.Style:=[fsBold]
      else
        RichEdit3.SelAttributes.Style:=[];
      if Bold4[i] then
        RichEdit4.SelAttributes.Style:=[fsBold]
      else
        RichEdit4.SelAttributes.Style:=[];
      inc(i);
      Corr:=Corr + 1;
    end;
  end;
end;

procedure TA059FStampa.ContaTurni(Data:TDateTime; QP,QG:TOracleDataSet; var T1,T2,T3,T4:Word);
var A1,A2,A3,A4:Word;
    NumTurno1,NumTurno2:string;
begin
  A1:=0;
  A2:=0;
  A3:=0;
  A4:=0;
  GetDatiTurno(QP,NumTurno1,NumTurno2);
  if (NumTurno1 = '1') or (NumTurno2 = '1') then
    A1:=1;
  if (NumTurno1 = '2') or (NumTurno2 = '2') then
    A2:=1;
  if (NumTurno1 = '3') or (NumTurno2 = '3') then
    A3:=1;
  if (NumTurno1 = '4') or (NumTurno2 = '4') then
    A4:=1;
  if (A1 = 1) or (A2 = 1) or (A3 = 1) or (A4 = 1) then
  begin
    QG.Close;
    QG.SetVariable('Progressivo',QP.FieldByName('Progressivo').AsInteger);
    QG.SetVariable('Data',Data);
    QG.Open;
    if QG.Fields[0].AsInteger > 0 then
      exit;
    inc(T1,A1);
    inc(T2,A2);
    inc(T3,A3);
    inc(T4,A4);
  end;
end;

procedure TA059FStampa.GetDatiTurno(MyDataSet:TOracleDataSet; var NumTurno1,NumTurno2:string);
var n:integer;
    T1,T2,T1EU,T2EU:string;
begin
  with A059FContSquadreDtM1 do
  begin
    T1:=MyDataSet.FieldByName('TURNO1').asString;
    T2:=MyDataSet.FieldByName('TURNO2').asString;
    T1EU:=MyDataSet.FieldByName('TURNO1EU').asString;
    T2EU:=MyDataSet.FieldByName('TURNO2EU').asString;
    NumTurno1:='';
    NumTurno2:='';
    QT021.Filtered:=False;
    QT021.Filter:='CODICE = ''' + MyDataSet.FieldByName('Orario').asString + '''';
    QT021.Filtered:=True;
    try
      if (StrToInt(T1)>0) and (Trim(T1) <> '')then
      begin
        n:=1;
        QT021.First;
        If QT021.RecordCount >= StrtoInt(T1) then
        begin
          while n < StrtoInt(T1) do
          begin
            QT021.Next;
            n:=n+1;
          end;
          if Trim(QT021.FieldByName('NUMTURNO').AsString) <> '' then
            if (T1EU='') or (T1EU='E') then
              NumTurno1:=QT021.FieldByName('NUMTURNO').AsString;
        end;
      end;
    except
    end;
    try
      if (StrToInt(T2)>0) and (Trim(T2) <> '')then
      begin
        n:=1;
        QT021.First;
        If QT021.RecordCount >= StrtoInt(T2) then
        begin
          while n < StrtoInt(T2) do
          begin
            QT021.Next;
            n:=n+1;
          end;
          if Trim(QT021.FieldByName('NUMTURNO').AsString) <> '' then
            if (T2EU='') or (T2EU='E') then
              NumTurno2:=QT021.FieldByName('NUMTURNO').AsString;
        end;
      end;
    except
    end;
  end;
end;

procedure TA059FStampa.QRBand1BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
var Corr:TDateTime;
    Mn1,Mn2,Mn3,Mn4,Mx1,Mx2,Mx3,Mx4,i:Word;
    Bold1,Bold2,Bold3,Bold4:Array [1..100] of Boolean;
begin
  PrintBand:=True;
  RE1.Lines.Clear;
  RE2.Lines.Clear;
  RE3.Lines.Clear;
  RE4.Lines.Clear;
  RE1.Lines.Add('');
  RE2.Lines.Add('');
  RE3.Lines.Add('');
  RE4.Lines.Add('');
  with A059FContSquadre, A059FContSquadreDtM1 do
  begin
    Corr:=DataInizio;
    i:=1;
    while Corr <= DataFine do
    begin
      RE1.Lines[0]:=RE1.Lines[0] + R180DimLung(IntToStr(Tot1[i]),3);
      RE2.Lines[0]:=RE2.Lines[0] + R180DimLung(IntToStr(Tot2[i]),3);
      RE3.Lines[0]:=RE3.Lines[0] + R180DimLung(IntToStr(Tot3[i]),3);
      RE4.Lines[0]:=RE4.Lines[0] + R180DimLung(IntToStr(Tot4[i]),3);
      //Leggo i minimi e massimi per squadra
      Mn1:=StrToIntDef(Q600Squadre.FieldByName('TOTMIN1').AsString,0);
      Mn2:=StrToIntDef(Q600Squadre.FieldByName('TOTMIN2').AsString,0);
      Mn3:=StrToIntDef(Q600Squadre.FieldByName('TOTMIN3').AsString,0);
      Mn4:=StrToIntDef(Q600Squadre.FieldByName('TOTMIN4').AsString,0);
      Mx1:=StrToIntDef(Q600Squadre.FieldByName('TOTMAX1').AsString,0);
      Mx2:=StrToIntDef(Q600Squadre.FieldByName('TOTMAX2').AsString,0);
      Mx3:=StrToIntDef(Q600Squadre.FieldByName('TOTMAX3').AsString,0);
      Mx4:=StrToIntDef(Q600Squadre.FieldByName('TOTMAX4').AsString,0);
      //Stabilisco lo stile Grassetto
      Bold1[Trunc(Corr - DataInizio) + 1]:=(Tot1[i] < Mn1) or (Tot1[i] > Mx1);
      Bold2[Trunc(Corr - DataInizio) + 1]:=(Tot2[i] < Mn2) or (Tot2[i] > Mx2);
      Bold3[Trunc(Corr - DataInizio) + 1]:=(Tot3[i] < Mn3) or (Tot3[i] > Mx3);
      Bold4[Trunc(Corr - DataInizio) + 1]:=(Tot4[i] < Mn4) or (Tot4[i] > Mx4);
      Corr:=Corr + 1;
      inc(i);
    end;
    Corr:=DataInizio;
    i:=1;
    while Corr <= DataFine do
    begin
      RE1.SelStart:=(i - 1) * 3;
      RE1.SelLength:=3;
      RE2.SelStart:=(i - 1) * 3;
      RE2.SelLength:=3;
      RE3.SelStart:=(i - 1) * 3;
      RE3.SelLength:=3;
      RE4.SelStart:=(i - 1) * 3;
      RE4.SelLength:=3;
      if Bold1[i] then
        RE1.SelAttributes.Style:=[fsBold]
      else
        RE1.SelAttributes.Style:=[];
      if Bold2[i] then
        RE2.SelAttributes.Style:=[fsBold]
      else
        RE2.SelAttributes.Style:=[];
      if Bold3[i] then
        RE3.SelAttributes.Style:=[fsBold]
      else
        RE3.SelAttributes.Style:=[];
      if Bold4[i] then
        RE4.SelAttributes.Style:=[fsBold]
      else
        RE4.SelAttributes.Style:=[];
      inc(i);
      Corr:=Corr + 1;
    end;
  end;
end;

end.
