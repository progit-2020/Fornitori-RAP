unit A005UTabelle;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  R001UGESTTAB, DB, OracleData, ExtCtrls, Menus, Buttons, ComCtrls, Grids, DBGrids,
   ActnList, ImgList, ToolWin, A000UCostanti, A000USessione,A000UInterfaccia, C180FunzioniGenerali, Variants,
   A000UMessaggi, Oracle, System.Actions, System.ImageList;

type
  TTabelleDatiLiberi = record
    NomeTabelle:String;
    Accesso:String;
  end;

  TA005FTabelle = class(TR001FGestTab)
    TabControl1: TTabControl;
    DBGrid1: TDBGrid;
    procedure Stampa1Click(Sender: TObject);
    procedure TGommaClick(Sender: TObject);
    procedure TRegisClick(Sender: TObject);
    procedure TAnnullaClick(Sender: TObject);
    procedure TCancClick(Sender: TObject);
    procedure TModifClick(Sender: TObject);
    procedure TInserClick(Sender: TObject);
    procedure actRefreshExecute(Sender: TObject);
    procedure TPrimoClick(Sender: TObject);
    procedure TCercaClick(Sender: TObject);
    procedure TabControl1Changing(Sender: TObject;
      var AllowChange: Boolean);
    procedure TabControl1Change(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure DBGrid1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    { Private declarations }
    A005SolaLettura:Boolean;
  public
    { Public declarations }
    TabelleDatiLiberi:array of TTabelleDatiLiberi;
    NCNuovoElemento,CodNuovoElemento: String;
    chiudi: boolean;
  end;

var
  A005FTabelle: TA005FTabelle;

procedure OpenA005Tabelle(NomeCampo,Cod:String);

implementation

uses A005UTabelleDtM1;

{$R *.DFM}

procedure OpenA005Tabelle(NomeCampo,Cod:String);
begin
  SolaLetturaOriginale:=SolaLettura;
  SolaLettura:=False;
  case A000GetInibizioni('Funzione','OpenA005Tabelle') of
    'N':begin
        ShowMessage('Funzione non abilitata!');
        Exit;
        end;
    'R':SolaLettura:=True;
  end;
  Screen.Cursor:=crHourglass;
  Application.CreateForm(TA005FTabelle,A005FTabelle);
  Application.CreateForm(TA005FTabelleDtM1,A005FTabelleDtM1);
  A005FTabelle.NCNuovoElemento:=NomeCampo;
  A005FTabelle.CodNuovoElemento:=Cod;
  A005FTabelle.A005SolaLettura:=SolaLettura;
  try
    Screen.Cursor:=crDefault;
    A005FTabelle.ShowModal;
  finally
    SolaLettura:=SolaLetturaOriginale;
    A005FTabelle.Free;
    A005FTabelleDtM1.Free;
  end;
end;

procedure TA005FTabelle.FormCreate(Sender: TObject);
begin
  inherited;
  IntestazioneR001:='Rilevazione presenze';
end;

procedure TA005FTabelle.DBGrid1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;
  if (Shift = [ssCtrl]) and (Key = 46) and
     (not SolaLettura) and (actCancella.Visible) and (actCancella.Enabled) and
     (not DBGrid1.ReadOnly) and (DButton.State = dsBrowse) and
     (DButton.DataSet is TOracleDataSet) and (not (DButton.DataSet as TOracleDataSet).ReadOnly)
  then
  begin
    Key:=0;
    actCancella.Execute;
  end;
end;

procedure TA005FTabelle.FormActivate(Sender: TObject);
var
  i: Integer;
begin
  TabControl1.TabIndex:=0;
  SetLength(TabelleDatiLiberi,0);
  i:=0;
  with A005FTabelleDtM1.Q500 do
  begin
    Close;
    SetVariable('Nome',Parametri.Layout);
    Open;
    while not Eof do
    begin
      SetLength(TabelleDatiLiberi,i + 1);
      TabelleDatiLiberi[i].NomeTabelle:='I501' + FieldByName('NOMECAMPO').AsString;
      TabelleDatiLiberi[i].Accesso:=FieldByName('ACCESSO').AsString;
      A005FTabelle.TabControl1.Tabs.Add(FieldByName('CAPTION').AsString);
      if FieldByName('NOMECAMPO').AsString = NCNuovoElemento then
        TabControl1.TabIndex:=i;
      i:=i + 1;
      Next;
    end;
  end;
  chiudi:=i = 0;
  if chiudi then
  begin
    R180MessageBox(A000MSG_A005_ERR_NO_DATI, ERRORE);
    exit;
  end;
  DButton.DataSet:=A005FTabelleDtM1.Tabella;
  TabControl1Change(nil);
end;

procedure TA005FTabelle.TabControl1Changing(Sender: TObject;
  var AllowChange: Boolean);
begin
  AllowChange:=not (DButton.State in [dsInsert, dsEdit]);
  if AllowChange then
    begin
    A005FTabelleDtM1.Tabella.Close;
    end;
end;

procedure TA005FTabelle.TabControl1Change(Sender: TObject);
var
  i: Integer;
begin
  with A005FTabelleDtM1 do
  begin
    Tabella.Close;
    Tabella.SQL.Clear;
    Tabella.SQL.Add('SELECT T.*,T.ROWID FROM ' + TabelleDatiLiberi[TabControl1.TabIndex].NomeTabelle + ' T ');
    Tabella.SQL.Add('ORDER BY CODICE');
    Tabella.ReadBuffer:=1000;
    if (TabelleDatiLiberi[TabControl1.TabIndex].Accesso = 'R') or A005SolaLettura then
    begin
      SolaLettura:=True;
      Tabella.ReadOnly:=True;
    end
    else
    begin
      SolaLettura:=False;
      Tabella.ReadOnly:=False;
    end;
    Tabella.Open;
    Tabella.SearchRecord('CODICE',CodNuovoElemento,[srFromBeginning]);
    for i:=0 to Tabella.Fields.Count - 1 do
      Tabella.Fields[i].Visible:=(Tabella.Fields[i].DisplayLabel = 'CODICE') or (Tabella.Fields[i].DisplayLabel = 'DESCRIZIONE');
  end;
  NumRecords;
end;

procedure TA005FTabelle.TCercaClick(Sender: TObject);
begin
  if chiudi then
  begin
    R180MessageBox('Non ci sono dati liberi storicizzati che l''operatore è autorizzato a gestire', ERRORE);
    Self.Close;
  end
  else
    inherited;
end;

procedure TA005FTabelle.TPrimoClick(Sender: TObject);
begin
  if chiudi then
  begin
    R180MessageBox('Non ci sono dati liberi storicizzati che l''operatore è autorizzato a gestire', ERRORE);
    Self.Close;
  end
  else
    inherited;
end;

procedure TA005FTabelle.actRefreshExecute(Sender: TObject);
begin
  if chiudi then
  begin
    R180MessageBox('Non ci sono dati liberi storicizzati che l''operatore è autorizzato a gestire', ERRORE);
    Self.Close;
  end
  else
    inherited;
end;

procedure TA005FTabelle.TInserClick(Sender: TObject);
begin
  if chiudi then
  begin
    R180MessageBox('Non ci sono dati liberi storicizzati che l''operatore è autorizzato a gestire', ERRORE);
    Self.Close;
  end
  else
    inherited;
end;

procedure TA005FTabelle.TModifClick(Sender: TObject);
begin
  if chiudi then
  begin
    R180MessageBox('Non ci sono dati liberi storicizzati che l''operatore è autorizzato a gestire', ERRORE);
    Self.Close;
  end
  else
    inherited;
end;

procedure TA005FTabelle.TCancClick(Sender: TObject);
begin
  if chiudi then
  begin
    R180MessageBox('Non ci sono dati liberi storicizzati che l''operatore è autorizzato a gestire', ERRORE);
    Self.Close;
  end
  else
    inherited;
end;

procedure TA005FTabelle.TAnnullaClick(Sender: TObject);
begin
  if chiudi then
  begin
    R180MessageBox('Non ci sono dati liberi storicizzati che l''operatore è autorizzato a gestire', ERRORE);
    Self.Close;
  end
  else
    inherited;
end;

procedure TA005FTabelle.TRegisClick(Sender: TObject);
begin
  if chiudi then
  begin
    R180MessageBox('Non ci sono dati liberi storicizzati che l''operatore è autorizzato a gestire', ERRORE);
    Self.Close;
  end
  else
    inherited;
end;

procedure TA005FTabelle.TGommaClick(Sender: TObject);
begin
  if chiudi then
  begin
    R180MessageBox('Non ci sono dati liberi storicizzati che l''operatore è autorizzato a gestire', ERRORE);
    Self.Close;
  end
  else
    inherited;
end;

procedure TA005FTabelle.Stampa1Click(Sender: TObject);
begin
  if chiudi then
  begin
    R180MessageBox('Non ci sono dati liberi storicizzati che l''operatore è autorizzato a gestire', ERRORE);
    Self.Close;
  end
  else
    inherited;
end;

end.
