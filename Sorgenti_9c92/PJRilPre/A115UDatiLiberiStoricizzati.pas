unit A115UDatiLiberiStoricizzati;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, Menus, StdCtrls, Mask, DBCtrls, Buttons, ExtCtrls, ComCtrls,
  R004UGestStorico, R004UGestStoricoDtM, ImgList, ToolWin, ActnList, OracleData,
  A000UCostanti, A000USessione,A000UInterfaccia, C180FUNZIONIGENERALI, Grids, DBGrids, Variants,
  System.Actions, System.ImageList, Oracle;

type
  TTabelleDatiStorici = record
    NomeTabelle:String;
    NomeCampo:String;
    Accesso:String;
    Scadenza:String;
  end;

  TA115FDatiLiberiStoricizzati = class(TR004FGestStorico)
    tbcMain: TTabControl;
    pnlPrincipale: TPanel;
    lblCodice: TLabel;
    lblDescrizione: TLabel;
    dedtCodice: TDBEdit;
    dedtDescrizione: TDBEdit;
    dgrdDati: TDBGrid;
    procedure FormShow(Sender: TObject);
    procedure Stampa1Click(Sender: TObject);
    procedure TGommaClick(Sender: TObject);
    procedure TRegisClick(Sender: TObject);
    procedure TAnnullaClick(Sender: TObject);
    procedure TCancClick(Sender: TObject);
    procedure TModifClick(Sender: TObject);
    procedure TInserClick(Sender: TObject);
    procedure btnStoricoSuccClick(Sender: TObject);
    procedure btnStoricoPrecClick(Sender: TObject);
    procedure actRefreshExecute(Sender: TObject);
    procedure TPrimoClick(Sender: TObject);
    procedure TCercaClick(Sender: TObject);
    procedure tbcMainChanging(Sender: TObject; var AllowChange: Boolean);
    procedure tbcMainChange(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnStoricizzaClick(Sender: TObject);
    procedure dgrdDatiKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    { Private declarations }
    sSolaLetturaForm: boolean;
  public
    { Public declarations }
    TabelleDatiStorici:array of TTabelleDatiStorici;
    NCNuovoElemento,CodNuovoElemento: String;
    bStoricizza, chiudi: boolean;
  end;

var
  A115FDatiLiberiStoricizzati: TA115FDatiLiberiStoricizzati;

procedure OpenA115DatiLiberiStoricizzati(NomeCampo,Cod:String);

implementation

uses A115UDatiLiberiStoricizzatiDtM;

{$R *.DFM}

procedure OpenA115DatiLiberiStoricizzati(NomeCampo,Cod:String);
begin
  SolaLetturaOriginale:=SolaLettura;
  SolaLettura:=False;
  case A000GetInibizioni('Funzione','OpenA115DatiLiberiStoricizzati') of
    'N':begin
        ShowMessage('Funzione non abilitata!');
        Exit;
        end;
    'R':SolaLettura:=True;
  end;
  Screen.Cursor:=crHourglass;
  Application.CreateForm(TA115FDatiLiberiStoricizzati,A115FDatiLiberiStoricizzati);
  Application.CreateForm(TA115FDatiLiberiStoricizzatiDtM,A115FDatiLiberiStoricizzatiDtM);
  A115FDatiLiberiStoricizzati.NCNuovoElemento:=NomeCampo;
  A115FDatiLiberiStoricizzati.CodNuovoElemento:=Cod;
  A115FDatiLiberiStoricizzati.sSolaLetturaForm:=SolaLettura;
  try
    Screen.Cursor:=crDefault;
    A115FDatiLiberiStoricizzati.ShowModal;
  finally
    SolaLettura:=SolaLetturaOriginale;
    A115FDatiLiberiStoricizzati.Free;
    A115FDatiLiberiStoricizzatiDtM.Free;
  end;
end;

procedure TA115FDatiLiberiStoricizzati.FormShow(Sender: TObject);
var i: Integer;
begin
  A115FDatiLiberiStoricizzatiDtM.bVariazioneDati:=False;
  SetLength(TabelleDatiStorici,0);
  tbcMain.TabIndex:=0;
  with A115FDatiLiberiStoricizzatiDtM do
  begin
    selI500.Close;
    selI500.SetVariable('Nome',Parametri.Layout);
    selI500.Open;
    i:=0;
    while not selI500.Eof do
    begin
      SetLength(TabelleDatiStorici,i + 1);
      TabelleDatiStorici[i].NomeTabelle:='I501' + selI500.FieldByName('NOMECAMPO').AsString;
      TabelleDatiStorici[i].NomeCampo:=selI500.FieldByName('NOMECAMPO').AsString;
      TabelleDatiStorici[i].Accesso:=selI500.FieldByName('ACCESSO').AsString;
      // gestione scadenza
      TabelleDatiStorici[i].Scadenza:=selI500.FieldByName('SCADENZA').AsString;
      tbcMain.Tabs.Add(selI500.FieldByName('CAPTION').AsString);
      if selI500.FieldByName('NOMECAMPO').AsString = NCNuovoElemento then
        tbcMain.TabIndex:=i;
      i:=i + 1;
      selI500.Next;
    end;
  end;
  chiudi:=i = 0;
  if chiudi then
    R180MessageBox('Non ci sono dati liberi storicizzati che l''operatore è autorizzato a gestire', ERRORE)
  else
    tbcMainChange(nil);
  bStoricizza:=False;
  inherited;
end;

procedure TA115FDatiLiberiStoricizzati.tbcMainChanging(Sender: TObject;
  var AllowChange: Boolean);
begin
  AllowChange:=not (DButton.State in [dsInsert, dsEdit]);
  if AllowChange then
  begin
    A115FDatiLiberiStoricizzatiDtM.selI501.Close;
  end;
end;

procedure TA115FDatiLiberiStoricizzati.tbcMainChange(Sender: TObject);
var
  i: integer;
  VC:Boolean;
begin
  with A115FDatiLiberiStoricizzatiDtM do
  begin
    VC:=actVisioneCorrente.Checked;
    if VC then
      actVisioneCorrente.Checked:=False;

    selI501.Close;
    selI501.SQL.Clear;
    selI501.SQL.Add('SELECT I501.*,I501.ROWID FROM ' + TabelleDatiStorici[tbcMain.TabIndex].NomeTabelle + ' I501');
    selI501.SQL.Add('WHERE CODICE <> ''*''');
    selI501.SQL.Add('ORDER BY CODICE, DECORRENZA');
    selI501.ReadBuffer:=1000;

    SolaLettura:=TabelleDatiStorici[tbcMain.TabIndex].Accesso = 'R';
    //Se tutta la funzione è in sola lettura impongo questa condizione indipendentemente dal tipo dato
    if sSolaLetturaForm then
      SolaLettura:=sSolaLetturaForm;
    selI501.ReadOnly:=SolaLettura;
    InterfacciaR004.AliasNomeTabella:='<I501>';
    // gestione scadenza
    InterfacciaR004.AllineaSoloDecorrenzeIntersecanti:=TabelleDatiStorici[tbcMain.TabIndex].Scadenza = 'S';
    InizializzaDButton;
    if VC then
      selI501.DeleteVariable('DECORRENZA');
    selI501.Open;
    if VC then
      Visionecorrente1Click(nil);

    selI501.SearchRecord('CODICE',CodNuovoElemento,[srFromBeginning]);
    CercaStoricoCorrente;
  end;
  NumRecords;
  for i:= 0 to dgrdDati.Columns.Count - 1 do
    if dgrdDati.Columns[i].Width > 300 then
      dgrdDati.Columns[i].Width:=300;

end;

procedure TA115FDatiLiberiStoricizzati.FormClose(Sender: TObject;
  var Action: TCloseAction);
//Esecuzione dell'allineamento dei periodi storici in uscita
begin
  //Se si è verificata almeno una variazione di dati
  with A115FDatiLiberiStoricizzatiDtM do
  begin
    if bVariazioneDati then
    begin
      SetPanelMessage('Attendere: aggiornamento di ' + IntToStr(tabT430.RecordCount) + ' dip. in corso');
      A115FDatiLiberiStoricizzati.Repaint;
      Screen.Cursor:=crHourglass;
      //Disabilito il trigger T430_AFTERUPDINS
      OperSQL.SQL.Clear;
      OperSQL.SQL.Add('ALTER TRIGGER T430_AFTERUPDINS DISABLE');
      try
        OperSQL.Execute;
      except
      end;
      //Eseguo procedura di allineamento periodi storici per tutti i progressivi variati
      tabT430.First;
      while not tabT430.Eof do
      begin
        scrT430.SetVariable('Progressivo',tabT430.FieldByName('PROGRESSIVO').Value);
        scrT430.Execute;
        tabT430.Next;
      end;
      //Riabilito il trigger T430_AFTERUPDINS
      OperSQL.SQL.Clear;
      OperSQL.SQL.Add('ALTER TRIGGER T430_AFTERUPDINS ENABLE');
      try
        OperSQL.Execute;
      except
      end;
      Screen.Cursor:=crDefault;
    end;
  end;
end;

procedure TA115FDatiLiberiStoricizzati.btnStoricizzaClick(Sender: TObject);
begin
  if chiudi then
  begin
    R180MessageBox('Non ci sono dati liberi storicizzati che l''operatore è autorizzato a gestire', ERRORE);
    Self.Close;
  end
  else
  begin
    bStoricizza:=True;
    try
      TDateTimeField(DButton.DataSet.FieldByName('DECORRENZA')).DisplayFormat:='dd/mm/yyyy';
      DButton.DataSet.FieldByName('DECORRENZA').EditMask:='!00/00/0000;1;_';
      DButton.DataSet.FieldByName('DECORRENZA_FINE').EditMask:='!00/00/0000;1;_'; // gestione scadenza
    except
    end;
    inherited;
  end;
end;

procedure TA115FDatiLiberiStoricizzati.TCercaClick(Sender: TObject);
begin
  if chiudi then
  begin
    R180MessageBox('Non ci sono dati liberi storicizzati che l''operatore è autorizzato a gestire', ERRORE);
    Self.Close;
  end
  else
    inherited;
end;

procedure TA115FDatiLiberiStoricizzati.TPrimoClick(Sender: TObject);
begin
  if chiudi then
  begin
    R180MessageBox('Non ci sono dati liberi storicizzati che l''operatore è autorizzato a gestire', ERRORE);
    Self.Close;
  end
  else
    inherited;
end;

procedure TA115FDatiLiberiStoricizzati.actRefreshExecute(Sender: TObject);
begin
  if chiudi then
  begin
    R180MessageBox('Non ci sono dati liberi storicizzati che l''operatore è autorizzato a gestire', ERRORE);
    Self.Close;
  end
  else
    inherited;
end;

procedure TA115FDatiLiberiStoricizzati.btnStoricoPrecClick(Sender: TObject);
begin
  if chiudi then
  begin
    R180MessageBox('Non ci sono dati liberi storicizzati che l''operatore è autorizzato a gestire', ERRORE);
    Self.Close;
  end
  else
    inherited;
end;

procedure TA115FDatiLiberiStoricizzati.btnStoricoSuccClick(Sender: TObject);
begin
  if chiudi then
  begin
    R180MessageBox('Non ci sono dati liberi storicizzati che l''operatore è autorizzato a gestire', ERRORE);
    Self.Close;
  end
  else
    inherited;
end;

procedure TA115FDatiLiberiStoricizzati.dgrdDatiKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;
  if (Shift = [ssCtrl]) and (Key = 46) and
     (not SolaLettura) and (actCancella.Visible) and (actCancella.Enabled) and
     (not dgrdDati.ReadOnly) and (DButton.State = dsBrowse) and
     (DButton.DataSet is TOracleDataSet) and (not (DButton.DataSet as TOracleDataSet).ReadOnly)
  then
  begin
    Key:=0;
    actCancella.Execute;
  end;
end;

procedure TA115FDatiLiberiStoricizzati.TInserClick(Sender: TObject);
begin
  if chiudi then
  begin
    R180MessageBox('Non ci sono dati liberi storicizzati che l''operatore è autorizzato a gestire', ERRORE);
    Self.Close;
  end
  else
    inherited;
end;

procedure TA115FDatiLiberiStoricizzati.TModifClick(Sender: TObject);
begin
  if chiudi then
  begin
    R180MessageBox('Non ci sono dati liberi storicizzati che l''operatore è autorizzato a gestire', ERRORE);
    Self.Close;
  end
  else
    inherited;
end;

procedure TA115FDatiLiberiStoricizzati.TCancClick(Sender: TObject);
begin
  if chiudi then
  begin
    R180MessageBox('Non ci sono dati liberi storicizzati che l''operatore è autorizzato a gestire', ERRORE);
    Self.Close;
  end
  else
    inherited;
end;

procedure TA115FDatiLiberiStoricizzati.TAnnullaClick(Sender: TObject);
begin
  if chiudi then
  begin
    R180MessageBox('Non ci sono dati liberi storicizzati che l''operatore è autorizzato a gestire', ERRORE);
    Self.Close;
  end
  else
    inherited;
end;

procedure TA115FDatiLiberiStoricizzati.TRegisClick(Sender: TObject);
begin
  if chiudi then
  begin
    R180MessageBox('Non ci sono dati liberi storicizzati che l''operatore è autorizzato a gestire', ERRORE);
    Self.Close;
  end
  else
    inherited;
end;

procedure TA115FDatiLiberiStoricizzati.TGommaClick(Sender: TObject);
begin
  if chiudi then
  begin
    R180MessageBox('Non ci sono dati liberi storicizzati che l''operatore è autorizzato a gestire', ERRORE);
    Self.Close;
  end
  else
    inherited;
end;

procedure TA115FDatiLiberiStoricizzati.Stampa1Click(Sender: TObject);
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
