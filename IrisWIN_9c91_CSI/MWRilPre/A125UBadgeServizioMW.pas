unit A125UBadgeServizioMW;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, Dialogs,
  R005UDataModuleMW, DB, OracleData, RegistrazioneLog, C180FunzioniGenerali, A000UCostanti, A000UInterfaccia;

type
  TA125FBadgeServizioMW = class(TR005FDataModuleMW)
    selT435: TOracleDataSet;
    selI090_GruppoBadge: TOracleDataSet;
  private
    { Private declarations }
  public
    Q435:TOracleDataSet;
    procedure Q435AfterPost;
    procedure Q435BeforePost;
  end;


implementation

{$R *.dfm}

procedure TA125FBadgeServizioMW.Q435AfterPost;
begin
  Q435.Refresh;
  Q435.First;
end;

procedure TA125FBadgeServizioMW.Q435BeforePost;
var D1,D2,sAzienda,Mex: String;
    iProgressivo: Integer;
begin
  if (Q435.FieldByName('DECORRENZA').AsDateTime >= Q435.FieldByName('SCADENZA').AsDateTime) and
     (not Q435.FieldByName('SCADENZA').IsNull) then
    raise Exception.Create('La data di decorrenza deve essere inferiore alla data di scadenza!');
  Mex:='';
  with selI090_GruppoBadge do
  begin
    Close;
    SetVariable('UTENTE',Parametri.Username);
    SetVariable('AZIENDA',Parametri.Azienda);
    SetVariable('GRUPPO',Parametri.GruppoBadge);
    Open;
  end;
  while not selI090_GruppoBadge.Eof do
  begin
    //Se cerco il badge sull'azienda corrente...
    if Parametri.Azienda = selI090_GruppoBadge.FieldByName('AZIENDA').AsString then
    begin
      sAzienda:='';
      iProgressivo:=Q435.FieldByName('PROGRESSIVO').AsInteger;
    end
    else //se cerco il badge su un'azienda diversa da quella corrente...
    begin
      sAzienda:='Azienda: ' + selI090_GruppoBadge.FieldByName('AZIENDA').AsString + '. ';
      iProgressivo:=0;
    end;
    with selT435 do
    begin
      Close;
      SetVariable('Badge',Q435.FieldByName('BADGESERV').AsFloat);
      SetVariable('Progressivo',Q435.FieldByName('PROGRESSIVO').AsInteger);
      SetVariable('Progressivo_ext',iProgressivo);
      SetVariable('Decorrenza',Q435.FieldByName('DECORRENZA').AsDateTime);
      if Q435.FieldByName('SCADENZA').IsNull then
        SetVariable('Scadenza',EncodeDate(3999,12,31))
      else
        SetVariable('Scadenza',Q435.FieldByName('SCADENZA').AsDateTime);
      SetVariable('Utente',selI090_GruppoBadge.FieldByName('UTENTE').AsString);
      Open;
      while not Eof do
      begin
        D1:=FieldByName('DATADECORRENZA').AsString;
        if Copy(FieldByName('DATAFINE').AsString,1,10) = '31/12/3999' then
          D2:='Corrente'
        else
          D2:=FieldByName('DATAFINE').AsString;
        Mex:=Mex + CRLF + sAzienda +
             Format('%s %s %s (%s) dal %s al %s',
                    [FieldByName('TIPOBADGE').AsString,FieldByName('COGNOME').AsString,FieldByName('NOME').AsString,FieldByName('MATRICOLA').AsString,D1,D2]);
        Next;
      end;
    end;
    selI090_GruppoBadge.Next;
  end;
  if Mex <> '' then
    raise Exception.Create('Attenzione!' + CRLF + 'Il badge risulta essere assegnato a:' + Mex);
end;

end.
