unit A058UStampaRiepTimb;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, QuickRpt, qrpBaseCtrls, QRCtrls, DB, DBClient,
  A058UPianifTurniDtM1, OracleData, Generics.Collections;

type
  TA058FStampaRiepTimb = class(TForm)
    QRRiepTimb: TQRPQuickrep;
    QRBandTitolo: TQRBand;
    QRlblRiepTimb: TQRLabel;
    QRDett: TQRBand;
    QrEdtOra: TQRDBText;
    QREdtData: TQRDBText;
    QREdtNome: TQRDBText;
    QREdtMatricola: TQRDBText;
    QrLblTimbrature: TQRLabel;
    QrLblNominativo: TQRLabel;
    QrLblMatricola: TQRLabel;
    procedure QRBandTitoloBeforePrint(Sender: TQRCustomBand; var PrintBand: Boolean);
    procedure QRRiepTimbBeforePrint(Sender: TCustomQuickRep; var PrintReport: Boolean);
    procedure FormCreate(Sender: TObject);
    procedure QREdtMatricolaPrint(sender: TObject; var Value: string);
    procedure QREdtNomePrint(sender: TObject; var Value: string);
    procedure QRDettBeforePrint(Sender: TQRCustomBand; var PrintBand: Boolean);
  private
    { Private declarations }
    TabellaStampaTimb:TClientDataSet;
    MyVista:TList<TDipendente>;
    UltimoNome,UltimaMatricola:String;
    procedure SetImpStampa;
    procedure CreaTabellaStampaTimb;
    procedure CaricaTabellaStampaTimb;
  public
    { Public declarations }
    procedure StampaRiepTimb(var Temp:TList<TDipendente>);
  end;

var
  A058FStampaRiepTimb: TA058FStampaRiepTimb;

implementation

{$R *.dfm}

procedure TA058FStampaRiepTimb.SetImpStampa;
begin
  with A058FPianifTurniDtm1 do
    QRRiepTimb.Font.Size:=selT082.FieldByName('DIMENSIONE_FONT').AsInteger;
end;

procedure TA058FStampaRiepTimb.CaricaTabellaStampaTimb;
var
  i,j:Integer;
  Str:String;
begin
  with A058FPianifTurniDtm1 do
    for i:=0 to MyVista.Count - 1 do
    begin
      OpenSelT100(TDipendente(MyVista[i]).Prog,DataInizio,DataFine);
      for j:=0 to TDipendente(MyVista[i]).Giorni.Count - 1 do
        if TGiorno(TDipendente(MyVista[i]).Giorni[j]).NTimbTurno > 0 then
        begin
          TabellaStampaTimb.Insert;
          TabellaStampaTimb.FieldByName('PROGR').AsInteger:=TDipendente(MyVista[i]).Prog;
          TabellaStampaTimb.FieldByName('DATA').AsDateTime:=TGiorno(TDipendente(MyVista[i]).Giorni[j]).Data;
          TabellaStampaTimb.FieldByName('NOMINATIVO').AsString:=TDipendente(MyVista[i]).Cognome + ' ' + TDipendente(MyVista[i]).Nome;
          TabellaStampaTimb.FieldByName('MATRICOLA').AsString:=TDipendente(MyVista[i]).Matricola;
          Str:='';
          if selT100.SearchRecord('DATA',TGiorno(TDipendente(MyVista[i]).Giorni[j]).Data,[srFromBeginning]) then
            repeat
              if Trim(Str) <> '' then
                Str:=Str + '  -  ';
              Str:=Str + selT100.FieldByName('ORA').AsString + selT100.FieldByName('VERSO').AsString;
              if Not selT100.FieldByName('CAUSALE').IsNull then
                Str:=Str + '(' + selT100.FieldByName('CAUSALE').AsString + ')';
            until Not selT100.SearchRecord('DATA',TGiorno(TDipendente(MyVista[i]).Giorni[j]).Data,[srForward]);
          TabellaStampaTimb.FieldByName('TIMBRATURE').AsString:=Str;
          TabellaStampaTimb.Post;
        end;
    end;
end;

procedure TA058FStampaRiepTimb.CreaTabellaStampaTimb;
begin
  TabellaStampaTimb:=TClientDataSet.Create(Self);
  with TabellaStampaTimb do
  begin
    FieldDefs.Add('PROGR',ftInteger);
    FieldDefs.Add('DATA',ftDateTime);
    FieldDefs.Add('MATRICOLA',ftString,8);
    FieldDefs.Add('NOMINATIVO',ftString,50);
    FieldDefs.Add('TIMBRATURE',ftString,100);
    IndexDefs.Clear;
    IndexDefs.Add('PK','NOMINATIVO;DATA;TIMBRATURE',[]);
    IndexName:='PK';
    CreateDataSet;
    Open;
  end;
end;

procedure TA058FStampaRiepTimb.FormCreate(Sender: TObject);
begin
  QRRiepTimb.useQR5Justification:=True;
  UltimaMatricola:='';
  UltimoNome:='';
end;

procedure TA058FStampaRiepTimb.QRBandTitoloBeforePrint(Sender: TQRCustomBand; var PrintBand: Boolean);
begin
  QRlblRiepTimb.Left:=(QRBandTitolo.Width div 2) - (QRlblRiepTimb.width div 2)
end;

procedure TA058FStampaRiepTimb.QRDettBeforePrint(Sender: TQRCustomBand; var PrintBand: Boolean);
begin
  QRDett.Frame.DrawBottom:=A058FPianifTurniDtm1.selT082.FieldByName('SEPARATORE_RIGHE').AsString = 'S';
end;

procedure TA058FStampaRiepTimb.QREdtMatricolaPrint(sender: TObject; var Value: string);
begin
  if UltimaMatricola = Value then
    Value:='';
  UltimaMatricola:=TQRDBText(Sender).DataSet.FieldByName('MATRICOLA').AsString;
end;

procedure TA058FStampaRiepTimb.QREdtNomePrint(sender: TObject; var Value: string);
begin
  if UltimoNome = Value then
    Value:='';
  UltimoNome:=TQRDBText(Sender).DataSet.FieldByName('NOMINATIVO').AsString;
end;

procedure TA058FStampaRiepTimb.QRRiepTimbBeforePrint(Sender: TCustomQuickRep; var PrintReport: Boolean);
begin
  QRRiepTimb.NewPage;
end;

procedure TA058FStampaRiepTimb.StampaRiepTimb(var Temp:TList<TDipendente>);
begin
  MyVista:=Temp;
  CreaTabellaStampaTimb;
  SetImpStampa;
  QRRiepTimb.DataSet:=TabellaStampaTimb;
  QrEdtOra.DataSet:=TabellaStampaTimb;
  QrEdtOra.DataField:='TIMBRATURE';
  QrEdtNome.DataSet:=TabellaStampaTimb;
  QrEdtNome.DataField:='NOMINATIVO';
  QrEdtData.DataSet:=TabellaStampaTimb;
  QrEdtData.DataField:='DATA';
  QrEdtMatricola.DataSet:=TabellaStampaTimb;
  QrEdtMatricola.DataField:='MATRICOLA';
  CaricaTabellaStampaTimb;
end;

end.
