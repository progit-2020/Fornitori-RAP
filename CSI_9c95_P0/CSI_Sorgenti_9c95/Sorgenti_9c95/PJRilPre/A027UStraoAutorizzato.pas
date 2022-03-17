unit A027UStraoAutorizzato;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Grids, Vcl.DBGrids, Vcl.ComCtrls, Vcl.Menus, Vcl.ExtCtrls,
  C180FunzioniGenerali, DB, OracleData, Vcl.StdCtrls;

type
  TA027FStraoAutorizzato = class(TForm)
    dgrdT065: TDBGrid;
    Panel1: TPanel;
    PopupMenu1: TPopupMenu;
    StatusBar: TStatusBar;
    CopiainExcel1: TMenuItem;
    rgpDestinazione: TRadioGroup;
    lblMeseStrao: TLabel;
    N1: TMenuItem;
    Eseguiliquidazione1: TMenuItem;
    Annullaliquidazione1: TMenuItem;
    Annulladestinazione1: TMenuItem;
    Tagliobancaore1: TMenuItem;
    Eseguitagliobancaoreliquidazione1: TMenuItem;
    Annullatagliobancaore1: TMenuItem;
    Anteprima1: TMenuItem;
    PopupMenu2: TPopupMenu;
    Liquidaorenotturne1: TMenuItem;
    Annullaliquidazioneorenotturne1: TMenuItem;
    N2: TMenuItem;
    Anteprima2: TMenuItem;
    Copiainexcel2: TMenuItem;
    rgpTipoElaborazione: TRadioGroup;
    PopupMenu3: TPopupMenu;
    MenuItem5: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure CopiainExcel1Click(Sender: TObject);
    procedure rgpDestinazioneClick(Sender: TObject);
    procedure Eseguiliquidazione1Click(Sender: TObject);
    procedure Annullaliquidazione1Click(Sender: TObject);
    procedure Annulladestinazione1Click(Sender: TObject);
    procedure PopupMenu1Popup(Sender: TObject);
    procedure Tagliobancaore1Click(Sender: TObject);
    procedure Eseguitagliobancaoreliquidazione1Click(Sender: TObject);
    procedure Annullatagliobancaore1Click(Sender: TObject);
    procedure Anteprima1Click(Sender: TObject);
    procedure Liquidaorenotturne1Click(Sender: TObject);
    procedure PopupMenu2Popup(Sender: TObject);
    procedure Annullaliquidazioneorenotturne1Click(Sender: TObject);
    procedure Copiainexcel2Click(Sender: TObject);
    procedure Anteprima2Click(Sender: TObject);
    procedure rgpTipoElaborazioneClick(Sender: TObject);
  private
    { Private declarations }
    FMeseStrao:TDateTime;
    FElaborazioneCollettiva:Boolean;
    function  ChekData(D:TDateTime):Boolean;
    procedure PutMeseStrao(Value:TDateTime);
    procedure OpenSelT065;
    procedure OpenSelT102;
  public
    { Public declarations }
    property MeseStrao:TDateTime read FMeseStrao write PutMeseStrao;
  end;

var
  A027FStraoAutorizzato: TA027FStraoAutorizzato;

implementation

uses A027UCarMenDtM, A027UCarMen;

{$R *.dfm}

procedure TA027FStraoAutorizzato.FormCreate(Sender: TObject);
begin
  dgrdT065.DataSource:=A027FCarMenDtM.dsrT065;
  FElaborazioneCollettiva:=False;
end;

function TA027FStraoAutorizzato.ChekData(D:TDateTime):Boolean;
begin
  Result:=R180In(A027FCarMenDtM.FiltroDestinazione,['L','D']) or (D = MeseStrao);
end;

procedure TA027FStraoAutorizzato.PopupMenu1Popup(Sender: TObject);
begin
  with dgrdT065.DataSource.DataSet do
  begin
    Annulladestinazione1.Visible:=R180In(FieldByName('ORE_DESTINATE').AsString,['S','D']) and (FieldByName('TIPO_RICHIESTA').AsString = 'S');//(FieldByName('ID').AsInteger >= 0);
    Annullaliquidazione1.Visible:=R180In(FieldByName('ORE_DESTINATE').AsString,['L','D']) and (FieldByName('TIPO_RICHIESTA').AsString = 'L');//(FieldByName('ID').AsInteger >= 0);
    Annullatagliobancaore1.Visible:=(FieldByName('ORE_DESTINATE').AsString <> 'L') and (FieldByName('ID').AsInteger >= 0);
    Eseguiliquidazione1.Visible:=(FieldByName('ORE_DESTINATE').AsString <> 'L') and (FieldByName('TIPO_RICHIESTA').AsString = 'S');//(FieldByName('ID').AsInteger >= 0);
    Tagliobancaore1.Visible:=(FieldByName('ORE_DESTINATE').AsString <> 'L') and (FieldByName('ID').AsInteger >= 0);
    Eseguitagliobancaoreliquidazione1.Visible:=(FieldByName('ORE_DESTINATE').AsString <> 'L') and (FieldByName('ID').AsInteger >= 0);
  end;
end;

procedure TA027FStraoAutorizzato.PopupMenu2Popup(Sender: TObject);
begin
  Liquidaorenotturne1.Visible:=dgrdT065.DataSource.DataSet.FieldByName('LIQUIDATO').AsString = 'N';
  Annullaliquidazioneorenotturne1.Visible:=dgrdT065.DataSource.DataSet.FieldByName('LIQUIDATO').AsString = 'S';
end;

procedure TA027FStraoAutorizzato.PutMeseStrao(Value:TDateTime);
begin
  FMeseStrao:=Value;
  lblMeseStrao.Caption:='Straordinari nel mese di ' + FormatDateTime('mmmm yyyy',FMeseStrao);
  OpenSelT065;
  OpenSelT102;
  if rgpDestinazione.ItemIndex = 5 then
    StatusBar.SimpleText:=Format('Num.records:%d',[A027FCarMenDtM.selT102OreNotturne.RecordCount])
  else
    StatusBar.SimpleText:=Format('Num.records:%d',[A027FCarMenDtM.selT065.RecordCount]);
end;

procedure TA027FStraoAutorizzato.OpenSelT065;
begin
  with A027FCarMenDtM.selT065 do
  begin
    Close;
    SetVariable('DATA',MeseStrao);
    Open;
  end;
end;

procedure TA027FStraoAutorizzato.OpenSelT102;
begin
  with A027FCarMenDtM.selT102OreNotturne do
  begin
    Close;
    SetVariable('MESE_RIEPILOGO',MeseStrao);
    Open;
  end;
end;

procedure TA027FStraoAutorizzato.rgpDestinazioneClick(Sender: TObject);
begin
  if rgpDestinazione.ItemIndex = 5 then
  begin
    dgrdT065.DataSource:=A027FCarMenDtM.dsrT102;
    dgrdT065.PopupMenu:=PopupMenu2;
  end
  else if rgpDestinazione.ItemIndex in [6,7] then
  begin
    if rgpDestinazione.ItemIndex = 6 then
      A027FCarMenDtM.SettaSelQryT002('SRV_ANOM_AUTST_MESE',FMeseStrao)
    else if rgpDestinazione.ItemIndex = 7 then
      A027FCarMenDtM.SettaSelQryT002('SRV_VERIFICA_STESC_AUTST',FMeseStrao);
    dgrdT065.DataSource:=A027FCarMenDtM.dsrQryT002;
    dgrdT065.PopupMenu:=PopupMenu3;
  end
  else
  begin
    dgrdT065.DataSource:=A027FCarMenDtM.dsrT065;
    dgrdT065.PopupMenu:=PopupMenu1;
  end;

  case rgpDestinazione.ItemIndex of
    0:A027FCarMenDtM.FiltroDestinazione:='S';
    1:A027FCarMenDtM.FiltroDestinazione:='N';
    2:A027FCarMenDtM.FiltroDestinazione:='E';
    3:A027FCarMenDtM.FiltroDestinazione:='L';
    4:A027FCarMenDtM.FiltroDestinazione:='D';
  end;

  A027FCarMenDtM.selT065.FieldByName('COD_ITER').Visible:=A027FCarMenDtM.FiltroDestinazione = 'L';
  A027FCarMenDtM.selT065.FieldByName('DATA').Visible:=R180In(A027FCarMenDtM.FiltroDestinazione,['D','S','N','E','L']);
  A027FCarMenDtM.selT065.FieldByName('TIPO_RICHIESTA').Visible:=A027FCarMenDtM.FiltroDestinazione = 'D';
  A027FCarMenDtM.selT065.FieldByName('C_ANOMALIA').Visible:=R180In(A027FCarMenDtM.FiltroDestinazione,['D','N']);
  StatusBar.SimpleText:=Format('Num.records:%d',[dgrdT065.DataSource.DataSet.RecordCount]);
end;

procedure TA027FStraoAutorizzato.rgpTipoElaborazioneClick(Sender: TObject);
begin
  FElaborazioneCollettiva:=rgpTipoElaborazione.ItemIndex = 1;
end;

procedure TA027FStraoAutorizzato.CopiainExcel1Click(Sender: TObject);
begin
  R180DBGridCopyToClipboard(dgrdT065, True, False, True, True);
end;

procedure TA027FStraoAutorizzato.Copiainexcel2Click(Sender: TObject);
begin
  R180DBGridCopyToClipboard(dgrdT065, True, False, True, True);
end;

procedure TA027FStraoAutorizzato.Anteprima1Click(Sender: TObject);
var Dal,Al:TDateTime;
    DS:TDataSet;
begin
  DS:=dgrdT065.DataSource.DataSet;
  if DS.RecordCount > 0 then
  begin
    Dal:=A027FCarMen.frmInputPeriodo.DataInizio;
    Al:=A027FCarMen.frmInputPeriodo.DataFine;
    A027FCarMen.ProgressivoSingolo:=DS.FieldByName('PROGRESSIVO').AsInteger;
    A027FCarMen.frmInputPeriodo.DataInizio:= DS.FieldByName('DATA').AsDateTime;
    A027FCarMen.frmInputPeriodo.DataFine:= R180FineMese(DS.FieldByName('DATA').AsDateTime);
    try
      A027FCarMen.BitBtn1Click(A027FCarMen.BitBtn3);
    finally
      A027FCarMen.ProgressivoSingolo:=-1;
      A027FCarMen.frmInputPeriodo.DataInizio:=Dal;
      A027FCarMen.frmInputPeriodo.DataFine:=Al;
    end;
  end;
end;

procedure TA027FStraoAutorizzato.Anteprima2Click(Sender: TObject);
begin
  if dgrdT065.DataSource.DataSet.RecordCount > 0 then
  begin
    A027FCarMen.ProgressivoSingolo:=dgrdT065.DataSource.DataSet.FieldByName('PROGRESSIVO').AsInteger;
    try
      A027FCarMen.BitBtn1Click(A027FCarMen.BitBtn3);
    finally
      A027FCarMen.ProgressivoSingolo:=-1;
    end;
  end;
end;

procedure TA027FStraoAutorizzato.Tagliobancaore1Click(Sender: TObject);
var msg:String;
    ResConfirm,Progressivo:Integer;
    DS:TDataSet;
begin
  DS:=dgrdT065.DataSource.DataSet;
  if FElaborazioneCollettiva then
    DS.First;
  if not FElaborazioneCollettiva then
  begin
    if not ChekData(DS.FieldByName('DATA').AsDateTime) then
      raise Exception.Create('Il movimento si riferisce ad un mese diverso da quello correntemente in elaborazione!');
    ResConfirm:=MessageDlg('Eseguire il taglio banca ore per l''autorizzazione corrente?',mtConfirmation,[mbYes,mbNo],0);
  end
  else
    ResConfirm:=MessageDlg('Eseguire il taglio banca ore per tutta la selezione?',mtConfirmation,[mbYes,mbNo],0);
  if ResConfirm = mrYes then
  begin
    try
      Screen.Cursor:=crHourGlass;
      while not DS.Eof do
      begin
        Progressivo:=DS.FieldByName('PROGRESSIVO').AsInteger;
        if not ChekData(DS.FieldByName('DATA').AsDateTime) then
        begin
          DS.Next;
          Continue;
        end;
        if not (DS.FieldByName('ORE_DESTINATE').AsString <> 'L') and (DS.FieldByName('ID').AsInteger >= 0) then
        begin
          DS.Next;
          Continue;
        end;
        //Taglio banca ore
        msg:=A027FCarMen.CartellinoSingolo(Progressivo,False,True);
        if msg = '' then
          //aggiornamento scheda (per registrazione dati gg su T102)
          msg:=A027FCarMen.CartellinoSingolo(Progressivo,True,False);
        if FElaborazioneCollettiva then
          DS.Next
        else
          Break;
      end;
      DS.Refresh;
      if not FElaborazioneCollettiva then
        DS.Locate('PROGRESSIVO',Progressivo,[]);
    finally
      Screen.Cursor:=crDefault;
    end;
    ShowMessage('Taglio banca ore effettuato!' + msg);
  end;
end;

procedure TA027FStraoAutorizzato.Annulladestinazione1Click(Sender: TObject);
var msg:String;
    ResConfirm,Progressivo:Integer;
    DS:TDataSet;
begin
  DS:=dgrdT065.DataSource.DataSet;
  if FElaborazioneCollettiva then
    DS.First;
  if (FElaborazioneCollettiva and (DS.RecordCount > 0)) or
     R180In(DS.FieldByName('ORE_DESTINATE').AsString,['S','D']) then
  begin
    if not FElaborazioneCollettiva then
    begin
      if not ChekData(DS.FieldByName('DATA').AsDateTime) then
        raise Exception.Create('Il movimento si riferisce ad un mese diverso da quello correntemente in elaborazione!');
      ResConfirm:=MessageDlg('Annullare la destinazione per l''autorizzazione corrente?',mtConfirmation,[mbYes,mbNo],0);
    end
    else
      ResConfirm:=MessageDlg('Annullare la destinazione per tutta la selezione?',mtConfirmation,[mbYes,mbNo],0);
    if ResConfirm = mrYes then
    begin
      try
        Screen.Cursor:=crHourGlass;
        while not DS.Eof do
        begin
          Progressivo:=DS.FieldByName('PROGRESSIVO').AsInteger;
          if not ChekData(DS.FieldByName('DATA').AsDateTime) then
          begin
            DS.Next;
            Continue;
          end;
          if FElaborazioneCollettiva and (not (R180In(DS.FieldByName('ORE_DESTINATE').AsString,['S','D']) and
                                               (DS.FieldByName('TIPO_RICHIESTA').AsString = 'S')))
          then
          begin
            DS.Next;
            Continue;
          end;
          A027FCarMenDtM.AnnullaDestinazione(DS.FieldByName('ID').AsInteger);
          //aggiornamento scheda
          if DS.FieldByName('ID').AsInteger >= 0 then
            msg:=A027FCarMen.CartellinoSingolo(Progressivo,True,False);
          if FElaborazioneCollettiva then
            DS.Next
          else
            Break;
        end;
        DS.Refresh;
        if not FElaborazioneCollettiva then
          DS.Locate('PROGRESSIVO',Progressivo,[]);
      finally
        Screen.Cursor:=crDefault;
      end;
      ShowMessage('Destinazione annullata!' + msg);
    end;
  end
  else
    ShowMessage('Non esiste destinazione da annullare!');
end;

procedure TA027FStraoAutorizzato.Annullaliquidazione1Click(Sender: TObject);
var msg:String;
    ResConfirm,Progressivo:Integer;
    DS:TDataSet;
begin
  DS:=dgrdT065.DataSource.DataSet;
  if FElaborazioneCollettiva then
    DS.First;
  if (FElaborazioneCollettiva and (DS.RecordCount > 0)) or
     R180In(DS.FieldByName('ORE_DESTINATE').AsString,['L','D']) then
  begin
    if not FElaborazioneCollettiva then
      ResConfirm:=MessageDlg('Annullare la liquidazione per l''autorizzazione corrente?',mtConfirmation,[mbYes,mbNo],0)
    else
      ResConfirm:=MessageDlg('Annullare la liquidazione per tutta la selezione?',mtConfirmation,[mbYes,mbNo],0);
    if ResConfirm = mrYes then
    begin
      try
        Screen.Cursor:=crHourGlass;
        while not DS.Eof do
        begin
          Progressivo:=DS.FieldByName('PROGRESSIVO').AsInteger;
          if FElaborazioneCollettiva and (not (R180In(DS.FieldByName('ORE_DESTINATE').AsString,['L','D']) and
                                               (DS.FieldByName('TIPO_RICHIESTA').AsString = 'L')))
          then
          begin
            DS.Next;
            Continue;
          end;
          A027FCarMenDtM.AnnullaLiquidazione(DS.FieldByName('ID').AsInteger);
          //aggiornamento scheda
          msg:=A027FCarMen.CartellinoSingolo(Progressivo,True,False);
          DS.Locate('PROGRESSIVO',Progressivo,[]);
          if FElaborazioneCollettiva then
            DS.Next
          else
            Break;
        end;
        DS.Refresh;
        if not FElaborazioneCollettiva then
          DS.Locate('PROGRESSIVO',Progressivo,[]);
      finally
        Screen.Cursor:=crDefault;
      end;
      ShowMessage('Liquidazione annullata!' + msg);
    end;
  end
  else
    ShowMessage('Non esiste liquidazione da annullare!');
end;

procedure TA027FStraoAutorizzato.Annullatagliobancaore1Click(Sender: TObject);
var ResConfirm,Progressivo:Integer;
    DS:TDataSet;
begin
  DS:=dgrdT065.DataSource.DataSet;
  if FElaborazioneCollettiva then
    DS.First;
  if (FElaborazioneCollettiva and (DS.RecordCount > 0)) or
     (DS.FieldByName('ORE_DESTINATE').AsString <> 'L') then
  begin
    if not FElaborazioneCollettiva then
    begin
      if not ChekData(DS.FieldByName('DATA').AsDateTime) then
        raise Exception.Create('Il movimento si riferisce ad un mese diverso da quello correntemente in elaborazione!');
      ResConfirm:=MessageDlg('Annullare il taglio Banca Ore per l''autorizzazione corrente?',mtConfirmation,[mbYes,mbNo],0);
    end
    else
      ResConfirm:=MessageDlg('Annullare il taglio Banca Ore per tutta la selezione?',mtConfirmation,[mbYes,mbNo],0);
    if ResConfirm = mrYes then
    begin
      try
        Screen.Cursor:=crHourGlass;
        while not DS.Eof do
        begin
          Progressivo:=DS.FieldByName('PROGRESSIVO').AsInteger;
          if not ChekData(DS.FieldByName('DATA').AsDateTime) then
          begin
            DS.Next;
            Continue;
          end;
          if FElaborazioneCollettiva and not ((DS.FieldByName('ORE_DESTINATE').AsString <> 'L') and
                                              (DS.FieldByName('ID').AsInteger >= 0))
          then
          begin
            DS.Next;
            Continue;
          end;
          A027FCarMenDtM.AnnullaTaglioBancaOre(DS.FieldByName('ID').AsInteger);
          if FElaborazioneCollettiva then
            DS.Next
          else
            Break;
        end;
        DS.Refresh;
        if not FElaborazioneCollettiva then
          DS.Locate('PROGRESSIVO',Progressivo,[]);
      finally
        Screen.Cursor:=crDefault;
      end;
      ShowMessage('Taglio banca ore annullato!');
    end;
  end
  else
    ShowMessage('Liquidazione già esistente!');
end;

procedure TA027FStraoAutorizzato.Eseguiliquidazione1Click(Sender: TObject);
var msg:String;
    ResConfirm,Progressivo:Integer;
    DS:TDataSet;
begin
  DS:=dgrdT065.DataSource.DataSet;
  if FElaborazioneCollettiva then
    DS.First;
  if (FElaborazioneCollettiva and (DS.RecordCount > 0)) or
     (DS.FieldByName('ORE_DESTINATE').AsString <> 'L') then
  begin
    if not FElaborazioneCollettiva then
    begin
      if not ChekData(DS.FieldByName('DATA').AsDateTime) then
        raise Exception.Create('Il movimento si riferisce ad un mese diverso da quello correntemente in elaborazione!');
      ResConfirm:=MessageDlg('Eseguire liquidazione per l''autorizzazione corrente?',mtConfirmation,[mbYes,mbNo],0);
    end
    else
      ResConfirm:=MessageDlg('Eseguire liquidazione per tutta la selezione?',mtConfirmation,[mbYes,mbNo],0);
    if ResConfirm = mrYes then
    begin
      try
        Screen.Cursor:=crHourGlass;
        while not DS.Eof do
        begin
          Progressivo:=DS.FieldByName('PROGRESSIVO').AsInteger;
          if not ChekData(DS.FieldByName('DATA').AsDateTime) then
          begin
            DS.Next;
            Continue;
          end;
          if FElaborazioneCollettiva and not ((DS.FieldByName('ORE_DESTINATE').AsString <> 'L') and
                                              (DS.FieldByName('TIPO_RICHIESTA').AsString = 'S'))
          then
          begin
            DS.Next;
            Continue;
          end;
          A027FCarMenDtM.EseguiLiquidazione(DS.FieldByName('ID').AsInteger);
          //aggiornamento scheda
          msg:=A027FCarMen.CartellinoSingolo(Progressivo,True,False);
          if FElaborazioneCollettiva then
            DS.Next
          else
            Break;
        end;
        DS.Refresh;
        if not FElaborazioneCollettiva then
          DS.Locate('PROGRESSIVO',Progressivo,[]);
      finally
        Screen.Cursor:=crDefault;
      end;
      ShowMessage('Liquidazione effettuata!' + msg);
    end;
  end
  else
    ShowMessage('Liquidazione già esistente!');
end;

procedure TA027FStraoAutorizzato.Eseguitagliobancaoreliquidazione1Click(Sender: TObject);
var msg:String;
    ResConfirm,Progressivo:Integer;
    DS:TDataSet;
begin
  DS:=dgrdT065.DataSource.DataSet;
  if FElaborazioneCollettiva then
    DS.First;
  if not FElaborazioneCollettiva then
  begin
    if not ChekData(DS.FieldByName('DATA').AsDateTime) then
      raise Exception.Create('Il movimento si riferisce ad un mese diverso da quello correntemente in elaborazione!');
    ResConfirm:=MessageDlg('Eseguire il taglio banca ore e la liquidazione per l''autorizzazione corrente?',mtConfirmation,[mbYes,mbNo],0);
  end
  else
    ResConfirm:=MessageDlg('Eseguire il taglio banca ore e la liquidazione per tutta la selezione?',mtConfirmation,[mbYes,mbNo],0);
  if ResConfirm = mrYes then
  begin
    try
      Screen.Cursor:=crHourGlass;
      while not DS.Eof do
      begin
        Progressivo:=DS.FieldByName('PROGRESSIVO').AsInteger;
        if not ChekData(DS.FieldByName('DATA').AsDateTime) then
        begin
          DS.Next;
          Continue;
        end;
        if not ((DS.FieldByName('ORE_DESTINATE').AsString <> 'L') and (DS.FieldByName('ID').AsInteger >= 0)) then
        begin
          DS.Next;
          Continue;
        end;
        //Taglio banca ore
        msg:=A027FCarMen.CartellinoSingolo(Progressivo,False,True);
        if msg = '' then
        begin
          //aggiornamento scheda (per registrazione dati gg su T102)
          msg:=A027FCarMen.CartellinoSingolo(Progressivo,True,False);
          //Rileggo il dataset: l'ID può cambiare se le ore non sono state destinate in precedenza!
          DS.Refresh;
          DS.Locate('PROGRESSIVO',Progressivo,[]);
          //liquidazione
          A027FCarMenDtM.EseguiLiquidazione(DS.FieldByName('ID').AsInteger);
          //aggiornamento scheda definitiva
          msg:=A027FCarMen.CartellinoSingolo(Progressivo,True,False);
        end;
        if FElaborazioneCollettiva then
          DS.Next
        else
          Break;
      end;
      DS.Refresh;
      if not FElaborazioneCollettiva then
        DS.Locate('PROGRESSIVO',Progressivo,[]);
    finally
      Screen.Cursor:=crDefault;
    end;
    ShowMessage('Taglio banca ore e liquidazione effettuati!' + msg);
  end;
end;

procedure TA027FStraoAutorizzato.Liquidaorenotturne1Click(Sender: TObject);
var msg:String;
    ResConfirm,Progressivo:Integer;
    DS:TDataSet;
begin
  DS:=dgrdT065.DataSource.DataSet;
  if FElaborazioneCollettiva then
    DS.First;
  if not FElaborazioneCollettiva then
    ResConfirm:=MessageDlg('Eseguire liquidazione delle ore notturne?',mtConfirmation,[mbYes,mbNo],0)
  else
    ResConfirm:=MessageDlg('Eseguire liquidazione delle ore notturne per rurra la selezione?',mtConfirmation,[mbYes,mbNo],0);
  if ResConfirm = mrYes then
  begin
    try
      Screen.Cursor:=crHourGlass;
      while not DS.Eof do
      begin
        Progressivo:=DS.FieldByName('PROGRESSIVO').AsInteger;
        if not (DS.FieldByName('LIQUIDATO').AsString = 'N') then
        begin
          DS.Next;
          Continue;
        end;
        A027FCarMenDtM.GestioneMaggNott(Progressivo,MeseStrao);
        //aggiornamento scheda
        msg:=A027FCarMen.CartellinoSingolo(Progressivo,True,False);
        if FElaborazioneCollettiva then
          DS.Next
        else
          Break;
      end;
      DS.Refresh;
      if not FElaborazioneCollettiva then
        DS.Locate('PROGRESSIVO',Progressivo,[]);
    finally
      Screen.Cursor:=crDefault;
    end;
    ShowMessage('Liquidazione effettuata!' + msg);
  end;
end;

procedure TA027FStraoAutorizzato.Annullaliquidazioneorenotturne1Click(Sender: TObject);
var msg:String;
    ResConfirm,Progressivo:Integer;
    DS:TDataSet;
begin
  DS:=dgrdT065.DataSource.DataSet;
  if FElaborazioneCollettiva then
    DS.First;
  if not FElaborazioneCollettiva then
    ResConfirm:=MessageDlg('Annullare la liquidazione delle ore notturne?',mtConfirmation,[mbYes,mbNo],0)
  else
    ResConfirm:=MessageDlg('Annullare la liquidazione per tutta la selezione?',mtConfirmation,[mbYes,mbNo],0);
  if ResConfirm = mrYes then
  begin
    try
      Screen.Cursor:=crHourGlass;
      while not DS.Eof do
      begin
        Progressivo:=DS.FieldByName('PROGRESSIVO').AsInteger;
        if not (DS.FieldByName('LIQUIDATO').AsString = 'S') then
        begin
          DS.Next;
          Continue;
        end;
        A027FCarMenDtM.AnnullaLiquidazioneOreNott(Progressivo,MeseStrao);
        //aggiornamento scheda
        msg:=A027FCarMen.CartellinoSingolo(Progressivo,True,False);
        if FElaborazioneCollettiva then
          DS.Next
        else
          Break;
      end;
      DS.Refresh;
      if not FElaborazioneCollettiva then
        DS.Locate('PROGRESSIVO',Progressivo,[]);
    finally
      Screen.Cursor:=crDefault;
    end;
    ShowMessage('Liquidazione annullata!' + msg);
  end;
end;

end.
