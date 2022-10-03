unit A047UTimbMensaDtM1;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  DB, A000UCostanti, A000USessione,A000UInterfaccia, C700USelezioneAnagrafe, RegistrazioneLog,
  OracleData, Oracle, C180FunzioniGenerali,  (*Midaslib,*) Crtl, DBClient, Variants,
  A047UTimbMensaMW;

type
  TA047FTimbMensaDtM1 = class(TDataModule)
    QAnagraSt: TOracleDataSet;
    sel370Stampa: TOracleDataSet;
    TabellaStampa: TClientDataSet;
    selT040Stampa: TOracleDataSet;
    dsrI010: TDataSource;
    procedure A047FTimbMensaDtM1Create(Sender: TObject);
    procedure T100ORASetText(Sender: TField; const Text: string);
    procedure A047FTimbMensaDtM1Destroy(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    A047FTimbMensaMW:TA047FTimbMensaMW;
    procedure CreaTabellaStampa;
  end;

var
  A047FTimbMensaDtM1: TA047FTimbMensaDtM1;

implementation

uses A047UTimbMensa, A047UDialogStampa;

{$R *.DFM}

procedure TA047FTimbMensaDtM1.A047FTimbMensaDtM1Create(Sender: TObject);
{Preparo le query Mensili}
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
  A047FTimbMensaMW:=TA047FTimbMensaMW.Create(Self);
  dsrI010.DataSet:=A047FTimbMensaMW.selI010;
end;

procedure TA047FTimbMensaDtM1.T100ORASetText(Sender: TField;
  const Text: string);
begin
  {$I CampoOra}
end;

procedure TA047FTimbMensaDtM1.A047FTimbMensaDtM1Destroy(Sender: TObject);
var i:Integer;
begin
  for i:=0 to Self.ComponentCount - 1 do
    if Self.Components[i] is TDataSet then
      (Self.Components[i] as TDataSet).Close;
  FreeAndNil(A047FTimbMensaMW);
end;

procedure TA047FTimbMensaDtM1.CreaTabellaStampa;
var
  i:integer;
  IndGruppo:String;
begin
  TabellaStampa.Close;
  with TabellaStampa do
  begin
    if A047FDialogStampa.rgpTipoStampa.ItemIndex = 0 then
    begin
      FieldDefs.Clear;
      FieldDefs.Add('Rilevatore',ftString,2,False);
      FieldDefs.Add('Descrizione',ftString,50,False);
      FieldDefs.Add('Causale',ftString,5,False);
      FieldDefs.Add('Nome',ftString,60,False);
      FieldDefs.Add('Progressivo',ftInteger,0,False);
      FieldDefs.Add('Data',ftDateTime,0,False);
      FieldDefs.Add('Matricola',ftString,8,False);
      FieldDefs.Add('Badge',ftString,10,False);
      FieldDefs.Add('PastiCon',ftInteger,0,False);
      FieldDefs.Add('PastiInt',ftInteger,0,False);
      FieldDefs.Add('Accessi',ftInteger,0,False);
      FieldDefs.Add('TimbMensa',ftString,150,False);
      FieldDefs.Add('AnomMensa',ftString,150,False);
      FieldDefs.Add('TimbPresenza',ftString,150,False);
      FieldDefs.Add('AnomPresenza',ftString,150,False);
      FieldDefs.Add('Giustificativi',ftString,100,False);
      //FieldDefs.Add('Gruppo',ftString,100,False);  //Lorena 27/07/2005
      IndGruppo:='';
      with A047FDialogStampa do
        for i:=low(MyCampiRaggr) to High(MyCampiRaggr) do
        begin
          if IndGruppo <> '' then
            IndGruppo:=IndGruppo + ';';
          IndGruppo:=IndGruppo + 'GRUPPO' + IntToStr(i);
          FieldDefs.Add('GRUPPO' + IntToStr(i),ftString,100,False);
        end;
      if IndGruppo <> '' then
        Indgruppo:=IndGruppo + ';';
      IndexDefs.Clear;
      if A047FDialogstampa.chkNominativi.Checked then
        IndexDefs.Add('Primario',IndGruppo + 'Nome;Progressivo;Rilevatore;Causale;Data',[ixUnique])
      else
        IndexDefs.Add('Primario',IndGruppo + 'Rilevatore;Causale;Nome;Progressivo;Data',[ixUnique]);
    end
    else
    begin
      FieldDefs.Clear;
      FieldDefs.Add('Contatore',ftAutoInc,0,False);
      FieldDefs.Add('Data',ftDateTime,0,False);
      FieldDefs.Add('Causale',ftString,5,False);
      FieldDefs.Add('Pasti',ftInteger,0,False);
      FieldDefs.Add('PastiCena',ftInteger,0,False);
      IndexDefs.Clear;
      IndexDefs.Add('Primario','Contatore',[ixUnique]);
      IndexDefs.Add('A047_Causale','Data;Causale',[]);
    end;
    IndexName:='Primario';
    CreateDataSet;
    TabellaStampa.LogChanges:=False;
  end;
end;

end.
