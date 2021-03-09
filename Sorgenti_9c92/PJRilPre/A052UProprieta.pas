unit A052UProprieta;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, StrUtils,
  ExtCtrls, StdCtrls, Buttons, Mask, DBCtrls, C013UCheckList, R500Lin, Variants;

type
  TA052FProprieta = class(TForm)
    Totali: TCheckBox;
    GroupBox1: TGroupBox;
    Causale: TRadioGroup;
    Orologio: TCheckBox;
    Giustificativi: TRadioGroup;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    LAnomOrologio: TLabel;
    EAnomOrologio: TDBEdit;
    GiorniMese: TGroupBox;
    Turno: TRadioGroup;
    DBCheckBox1: TDBCheckBox;
    DBCheckBox2: TDBCheckBox;
    DBCheckBox3: TDBCheckBox;
    btnAnomalie2: TButton;
    btnANomalie3: TButton;
    gpbCauPresEscluse: TGroupBox;
    dedtCauPresEscluse: TDBEdit;
    sbtnCauPresEscluse: TSpeedButton;
    dchkTimbratureManuali: TDBCheckBox;
    procedure btnAnomalie2Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    CausaliDaVisualizzare:Boolean;
  end;

var
  A052FProprieta: TA052FProprieta;

implementation

uses A052UParCar, A052UParCarDtM1;

{$R *.DFM}

procedure TA052FProprieta.btnAnomalie2Click(Sender: TObject);
var i,j:Integer;
    S:String;
begin
  C013FCheckList:=TC013FCheckList.Create(nil);
  try
    C013FCheckList.Width:=400;
    if Sender = btnAnomalie2 then
    begin
      C013FCheckList.Caption:='Anomalie di 2° livello';
      for i:=1 to High(tdescanom2) do
        C013FCheckList.clbListaDati.Items.Add(tdescanom2[i].D);
    end
    else if Sender = btnAnomalie3 then
    begin
      C013FCheckList.Caption:='Anomalie di 3° livello';
      for i:=1 to High(tdescanom3) do
        c013FCheckList.clbListaDati.Items.Add(tdescanom3[i].D);
    end
    else if Sender = sbtnCauPresEscluse then
    begin
      C013FCheckList.Caption:=gpbCauPresEscluse.Caption;
      with A052FParCarDtM1.A052FParCarMW.selT275 do
      begin
        First;
        while not Eof do
        begin
          c013FCheckList.clbListaDati.Items.Add(Format('%-5s %-40s',[FieldByName('CODICE').AsString,FieldByName('DESCRIZIONE').AsString]));
          Next;
        end;
      end;
    end;
    with TStringList.Create do
    try
      if Sender = btnAnomalie2 then
        CommaText:=A052FParCarDtM1.selT950.FieldByName('ANOMALIE2').AsString
      else if Sender = btnAnomalie3 then
        CommaText:=A052FParCarDtM1.selT950.FieldByName('ANOMALIE3').AsString
      else if (Sender = sbtnCauPresEscluse) and CausaliDaVisualizzare then
        CommaText:=A052FParCarDtM1.selT950.FieldByName('CAUPRES').AsString
      else if (Sender = sbtnCauPresEscluse) and not CausaliDaVisualizzare then
        CommaText:=A052FParCarDtM1.selT950.FieldByName('CAUPRES_ESCLUSE').AsString;
      if (Sender = btnAnomalie2) or (Sender = btnAnomalie3) then
        for i:=0 to Count - 1 do
          try
            C013FCheckList.clbListaDati.Checked[StrToInt(Strings[i])]:=True;
          except
          end;
      if Sender = sbtnCauPresEscluse then
        for i:=0 to C013FCheckList.clbListaDati.Count - 1 do
          for j:=0 to Count - 1 do
            if Trim(Copy(C013FCheckList.clbListaDati.Items[i],1,5)) = Strings[j] then
            begin
              C013FCheckList.clbListaDati.Checked[i]:=True;
              Break;
            end;
    finally
      Free;
    end;
    if C013FCheckList.ShowModal = mrOK then
    begin
      S:='';
      for i:=0 to C013FCheckList.clbListaDati.Items.Count - 1 do
        if C013FCheckList.clbListaDati.Checked[i] then
        begin
          if S <> '' then S:=S + ',';
          if (Sender = btnAnomalie2) or (Sender = btnAnomalie3) then
            S:=S + IntToStr(i)
          else if Sender = sbtnCauPresEscluse then
            S:=S + Trim(Copy(C013FCheckList.clbListaDati.Items[i],1,5));
        end;
      if Sender = btnAnomalie2 then
        A052FParCarDtM1.selT950.FieldByName('ANOMALIE2').AsString:=S
      else if Sender = btnAnomalie3 then
        A052FParCarDtM1.selT950.FieldByName('ANOMALIE3').AsString:=S
      else if (Sender = sbtnCauPresEscluse) and CausaliDaVisualizzare then
        A052FParCarDtM1.selT950.FieldByName('CAUPRES').AsString:=S
      else if (Sender = sbtnCauPresEscluse) and not CausaliDaVisualizzare then
        A052FParCarDtM1.selT950.FieldByName('CAUPRES_ESCLUSE').AsString:=S;
    end;
  finally
    C013FCheckList.Release;
  end;
end;

procedure TA052FProprieta.FormShow(Sender: TObject);
begin
  gpbCauPresEscluse.Caption:=IfThen(CausaliDaVisualizzare,'Causali di presenza da visualizzare','Causali di presenza da non visualizzare');
  dedtCauPresEscluse.DataField:=IfThen(CausaliDaVisualizzare,'CAUPRES','CAUPRES_ESCLUSE');
end;

end.
