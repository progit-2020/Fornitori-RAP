library L001PTabelle;

uses
  Forms, Dialogs, SysUtils, Db,
  L001UTabelle in 'L001UTabelle.pas' {L001FTabelle},
  L001UCampiAnagrafe in 'L001UCampiAnagrafe.pas' {L001FCampiAnagrafe},
  L001UStorici in 'L001UStorici.pas' {L001FStorici};

procedure Inserisci(var Griglia:TInserisciDLL);StdCall;
{Generica griglia per tabelle}
var i:integer;
begin
  L001FTabelle:=TL001FTabelle.create(nil);
  with L001FTabelle do
    try
    Caption:=Griglia.Titolo;
    Table1.Close;
    Table1.TableName:=Griglia.NomeTabella;
    Table1.Open;
    for i:=0 to Table1.FieldCount -1 do
      begin
      Table1.Fields[i].DisplayLabel:=Griglia.Display[i];
      Table1.Fields[i].DisplayWidth:=Griglia.Size[i];
    end;
    ShowModal;
    finally
    Release;
    end;
end;

procedure RidefAnag(DefCampi:TFieldDefs);StdCall;
{Ridefinizione campi anagrafe}
begin
  L001FCampiAnagrafe:=TL001FCampiAnagrafe.create(nil);
  with L001FCampiAnagrafe do
    try
    DefAnagrafe.Assign(DefCampi);
    I010.Open;
    ShowModal;
    finally
    Release;
    end;
end;

procedure DescrizStorici;StdCall;
{Descrizione dati storici}
begin
  L001FStorici:=TL001FStorici.create(nil);
  with L001FStorici do
    try
      ShowModal;
    finally
      Release;
    end;
end;

exports Inserisci,
        RidefAnag,
        DescrizStorici;

{$R *.RES}

begin
  Application.HelpFile:='.\Help\Iris.hlp';
end.
