unit A185UFiltroDizionarioMW;

interface

uses
  System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, R005UDataModuleMW, Data.DB,
  OracleData, Oracle, A000UInterfaccia;

type
  TA185FFiltroDizionarioMW = class(TR005FDataModuleMW)
    selI074After: TOracleDataSet;
    selI074Before: TOracleDataSet;
  private
    { Private declarations }
  public
    { Public declarations }
    procedure GetI074(var DS:TOracleDataSet; Azienda,Profilo,Tabella:string);
    procedure ConfrontaFiltroDizionario;
  end;

var
  A185FFiltroDizionarioMW: TA185FFiltroDizionarioMW;

implementation

{$R *.dfm}

procedure TA185FFiltroDizionarioMW.GetI074(var DS:TOracleDataSet; Azienda,Profilo,Tabella:string);
begin
  DS.Close;
  DS.SQL.Clear;
  DS.SQL.Add('select I074.AZIENDA, I074.PROFILO, I074.TABELLA, I074.CODICE, I074.ABILITATO');
  DS.SQL.Add('  from MONDOEDP.I074_FILTRODIZIONARIO I074');
  DS.SQL.Add(' where I074.AZIENDA = :AZIENDA');
  DS.SQL.Add('   and I074.PROFILO = :PROFILO');
  DS.SQL.Add('   and I074.TABELLA = :TABELLA');
  DS.SQL.Add(' order by I074.TABELLA, I074.CODICE');
  DS.DeclareAndSet('AZIENDA',otString,Azienda);
  DS.DeclareAndSet('PROFILO',otString,Profilo);
  DS.DeclareAndSet('TABELLA',otString,Tabella);
  DS.Open;
end;

procedure TA185FFiltroDizionarioMW.ConfrontaFiltroDizionario;
begin
  //Gestione log inserimenti
  selI074After.First;
  while not selI074After.Eof do
  begin
    if not selI074Before.SearchRecord('CODICE',selI074After.FieldByName('CODICE').AsString,[srFromBeginning]) then
      begin
        RegistraLog.SettaProprieta('I','I074_FILTRODIZIONARIO','A008',nil,True);
        RegistraLog.InserisciDato('AZIENDA','',selI074After.FieldByName('AZIENDA').AsString);
        RegistraLog.InserisciDato('PROFILO','',selI074After.FieldByName('PROFILO').AsString);
        RegistraLog.InserisciDato('TABELLA','',selI074After.FieldByName('TABELLA').AsString);
        RegistraLog.InserisciDato('CODICE','',selI074After.FieldByName('CODICE').AsString);
        RegistraLog.InserisciDato('STATO','',selI074After.FieldByName('ABILITATO').AsString);
        RegistraLog.RegistraOperazione;
      end;
    selI074After.Next;
  end;
  //Gestione log cancellazioni
  selI074Before.First;
  while not selI074Before.Eof do
  begin
    if not selI074After.SearchRecord('CODICE',selI074Before.FieldByName('CODICE').AsString,[srFromBeginning]) then
    begin
      RegistraLog.SettaProprieta('C','I074_FILTRODIZIONARIO','A008',nil,True);
      RegistraLog.InserisciDato('AZIENDA',selI074Before.FieldByName('AZIENDA').AsString,'');
      RegistraLog.InserisciDato('PROFILO',selI074Before.FieldByName('PROFILO').AsString,'');
      RegistraLog.InserisciDato('TABELLA',selI074Before.FieldByName('TABELLA').AsString,'');
      RegistraLog.InserisciDato('CODICE',selI074Before.FieldByName('CODICE').AsString,'');
      RegistraLog.InserisciDato('STATO',selI074Before.FieldByName('ABILITATO').AsString,'');
      RegistraLog.RegistraOperazione;
    end;
    selI074Before.Next;
  end;
  //Gestione log modifiche
  selI074Before.First;
  while not selI074Before.Eof do
  begin
    if selI074After.SearchRecord('CODICE',selI074Before.FieldByName('CODICE').AsString,[srFromBeginning]) then
    begin
      if selI074Before.FieldByName('ABILITATO').AsString <> selI074After.FieldByName('ABILITATO').AsString then
      begin
        RegistraLog.SettaProprieta('M','I074_FILTRODIZIONARIO','A008',nil,True);
        RegistraLog.InserisciDato('AZIENDA',selI074Before.FieldByName('AZIENDA').AsString,'');
        RegistraLog.InserisciDato('PROFILO',selI074Before.FieldByName('PROFILO').AsString,'');
        RegistraLog.InserisciDato('TABELLA',selI074Before.FieldByName('TABELLA').AsString,'');
        RegistraLog.InserisciDato('CODICE',selI074Before.FieldByName('CODICE').AsString,'');
        RegistraLog.InserisciDato('STATO',selI074Before.FieldByName('ABILITATO').AsString,selI074After.FieldByName('ABILITATO').AsString);
        RegistraLog.RegistraOperazione;
      end;
    end;
    selI074Before.Next;
  end;
end;

end.
