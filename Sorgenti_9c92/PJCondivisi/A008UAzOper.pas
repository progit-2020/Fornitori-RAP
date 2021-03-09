unit A008UAzOper;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  TABELLE99, StdCtrls, Buttons, DB, ExtCtrls, Grids, DBGrids, Menus,
  ComCtrls, A000UCostanti, A000USessione,A000UInterfaccia, OracleData, C180FunzioniGenerali,
  Oracle, Variants, ImgList, ActnList, ToolWin,RegolePassword,A000UMessaggi,
  System.Actions;

type
  TA008FAzOper = class(TFrmTabelle99)
    DBGrid1: TDBGrid;
    D070: TDataSource;
    actlstMenu: TActionList;
    actProfili: TAction;
    actAziende: TAction;
    actOperatori: TAction;
    actLoginDipendente: TAction;
    ImageList1: TImageList;
    ToolBar1: TToolBar;
    actAccessi: TAction;
    N2: TMenuItem;
    Aziende1: TMenuItem;
    Operatori1: TMenuItem;
    Profili1: TMenuItem;
    Logindipendente1: TMenuItem;
    Accessi1: TMenuItem;
    ToolButton1: TToolButton;
    ToolButton2: TToolButton;
    ToolButton3: TToolButton;
    ToolButton4: TToolButton;
    ToolButton5: TToolButton;
    procedure BitBtn2Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure BitBtn4Click(Sender: TObject);
    procedure actProfiliExecute(Sender: TObject);
    procedure actAziendeExecute(Sender: TObject);
    procedure actOperatoriExecute(Sender: TObject);
    procedure actLoginDipendenteExecute(Sender: TObject);
    procedure actAccessiExecute(Sender: TObject);
    procedure DBGrid1DblClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  A008FAzOper: TA008FAzOper;

procedure OpenA008Operatori;
//procedure OpenA008GestioneSicurezza(Sessione:TOracleSession; Abort:Boolean);

implementation

uses A008UOperatoriDtM1, A008UOperatori, A008UAziende, A008UProfili,
     A008ULoginDipendenti, A008UAccessi;

{$R *.DFM}

procedure OpenA008Operatori;
begin
  SolaLetturaOriginale:=SolaLettura;
  SolaLettura:=False;
  case A000GetInibizioni('Funzione','OpenA008Operatori') of
    'N':begin
        ShowMessage('Funzione non abilitata!');
        Exit;
        end;
    'R':SolaLettura:=True;
  end;
  Application.CreateForm(TA008FAzOper,A008FAzOper);
  Application.CreateForm(TA008FOperatoriDtM1,A008FOperatoriDtM1);
  with A008FAzOper do
  try
    ShowModal;
  finally
    SolaLettura:=SolaLetturaOriginale;
    A008FOperatoriDtM1.Free;
    Release;
  end;
end;

{
procedure OpenA008GestioneSicurezza(Sessione:TOracleSession; Abort:Boolean);
var MR:TModalResult;
    RegolePassword:TRegolePassword;
    S:String;
begin
  try
    A008FCambioPassword:=TA008FCambioPassword.Create(nil);
    A008FCambioPassword.BitBtn2.Visible:=Abort;
    while True do
    begin
      A008FCambioPassword.lblScadenza.Visible:=Parametri.RegolePassword.MesiValidita > 0;
      A008FCambioPassword.lblScadenza.Caption:='Scade il ' + DateToStr(R180AddMesi(Date,Parametri.RegolePassword.MesiValidita));
      MR:=A008FCambioPassword.ShowModal;
      if MR = mrAbort then Break;
      if MR <> mrOk then Continue;
      S:=Parametri.RegolePassword.PasswordValida(A008FCambioPassword.edtPasswordNew.Text);
      if A008FCambioPassword.edtPasswordOld.Text <> Parametri.PassOper then
        ShowMessage('Password attuale errata!')
      else if A008FCambioPassword.edtPasswordNew.Text <> A008FCambioPassword.edtPasswordConferma.Text then
        ShowMessage(A000MSG_A186_ERR_DLG_PWD)
      else if A008FCambioPassword.edtPasswordNew.Text = Parametri.PassOper then
        ShowMessage('La nuova password non può essere uguale alla precedente!')
      else if S <> '' then
      begin
        R180MessageBox(S,INFORMA);
        Continue;
      end
      else
        with TOracleQuery.Create(nil) do
        begin
          Session:=Sessione;
          SQL.Add('UPDATE MONDOEDP.I070_UTENTI SET PASSWD = ''' + R180CriptaI070(A008FCambioPassword.edtPasswordNew.Text) + '''');
          SQL.Add(',DATA_PW = TRUNC(SYSDATE)');
          SQL.Add('WHERE PROGRESSIVO = ' + IntToStr(Parametri.ProgOper));
          Execute;
          Sessione.Commit;
          Parametri.PassOper:=A008FCambioPassword.edtPasswordNew.Text;
          Break;
        end;
      (* Massimo 26/11/2012 : rimpiazzato dal codice riportato qua sopra
      if A008FCambioPassword.edtPasswordOld.Text <> Parametri.PassOper then
        ShowMessage('Password attuale errata!')
      else if A008FCambioPassword.edtPasswordNew.Text <> A008FCambioPassword.edtPasswordConferma.Text then
        ShowMessage('La nuova password non è stata confermata correttamente!')
      else if Length(A008FCambioPassword.edtPasswordNew.Text) < Parametri.LunghezzaPassword then
        ShowMessage(Format('La password deve essere di almeno %d caratteri!',[Parametri.LunghezzaPassword]))
      else if A008FCambioPassword.edtPasswordNew.Text = Parametri.PassOper then
        ShowMessage('La nuova password non può essere uguale alla precedente!')
      else
        with TOracleQuery.Create(nil) do
        begin
          Session:=Sessione;
          SQL.Add('UPDATE MONDOEDP.I070_UTENTI SET PASSWD = ''' + R180CriptaI070(A008FCambioPassword.edtPasswordNew.Text) + '''');
          SQL.Add(',DATA_PW = TRUNC(SYSDATE)');
          SQL.Add('WHERE PROGRESSIVO = ' + IntToStr(Parametri.ProgOper));
          Execute;
          Sessione.Commit;
          Parametri.PassOper:=A008FCambioPassword.edtPasswordNew.Text;
          Break;
        end;
        *)
    end;
  finally
    //FreeAndNil(RegolePassword);
    A008FCambioPassword.Release;
  end;
end;
}

procedure TA008FAzOper.FormCreate(Sender: TObject);
begin
  inherited;
  A008FAziende:=TA008FAziende.Create(nil);//Application.CreateForm(TA008FAziende,A008FAziende);
  A008FProfili:=TA008FProfili.Create(nil);//Application.CreateForm(TA008FProfili,A008FProfili);
end;

procedure TA008FAzOper.FormActivate(Sender: TObject);
begin
  D070.DataSet:=A008FOperatoriDtM1.QI070;
  A008FOperatoriDtM1.AziendaCorrente:=A008FOperatoriDtM1.QI070.FieldByName('AZIENDA').AsString;
  A008FOperatoriDtM1.AggiornaFiltroProfili;
end;

procedure TA008FAzOper.BitBtn1Click(Sender: TObject);
{Viusualizzo la form delle Aziende}
begin
  A008FAziende.ShowModal;
end;

procedure TA008FAzOper.BitBtn2Click(Sender: TObject);
{Viusualizzo la form degli operatori}
begin
  A008FOperatori:=TA008FOperatori.Create(nil);
  with A008FOperatori do
    try
      ShowModal;
    finally
      Release;
    end;
end;

procedure TA008FAzOper.BitBtn3Click(Sender: TObject);
begin
  A008FProfili.ShowModal;
end;

procedure TA008FAzOper.FormDestroy(Sender: TObject);
begin
  inherited;
  A008FAziende.Free;
  A008FProfili.Free;
end;

procedure TA008FAzOper.BitBtn4Click(Sender: TObject);
var SalvaColonneStruttura,SalvaTipiStruttura:TStringList;
begin
  SalvaColonneStruttura:=TStringList.Create;
  SalvaTipiStruttura:=TStringList.Create;
  SalvaColonneStruttura.Assign(Parametri.ColonneStruttura);
  SalvaTipiStruttura.Assign(Parametri.TipiStruttura);
  Parametri.ColonneStruttura.Clear;
  Parametri.TipiStruttura.Clear;
  A008FLoginDipendenti:=TA008FLoginDipendenti.Create(nil);
  with A008FLoginDipendenti do
    try
      ShowModal;
    finally
      FreeAndNil(A008FLoginDipendenti);
      Parametri.ColonneStruttura.Assign(SalvaColonneStruttura);
      Parametri.TipiStruttura.Assign(SalvaTipiStruttura);
      FreeAndNil(SalvaColonneStruttura);
      FreeAndNil(SalvaTipiStruttura);
    end;
end;

procedure TA008FAzOper.DBGrid1DblClick(Sender: TObject);
begin
  inherited;
  if DbGrid1.selectedIndex = 0 then
    actAziendeExecute(nil)
  else
    actOperatoriExecute(nil);
end;

procedure TA008FAzOper.actProfiliExecute(Sender: TObject);
var
  SalvaColonneStruttura,SalvaTipiStruttura:TStringList;
begin
  inherited;
  SalvaColonneStruttura:=TStringList.Create;
  SalvaTipiStruttura:=TStringList.Create;
  SalvaColonneStruttura.Assign(Parametri.ColonneStruttura);
  SalvaTipiStruttura.Assign(Parametri.TipiStruttura);
  Parametri.ColonneStruttura.Clear;
  Parametri.TipiStruttura.Clear;
  try
    A008FProfili.ShowModal;
  finally
    Parametri.ColonneStruttura.Assign(SalvaColonneStruttura);
    Parametri.TipiStruttura.Assign(SalvaTipiStruttura);
    FreeAndNil(SalvaColonneStruttura);
    FreeAndNil(SalvaTipiStruttura);
  end;
end;

procedure TA008FAzOper.actAziendeExecute(Sender: TObject);
begin
  inherited;
  A008FAziende.ShowModal;
end;

procedure TA008FAzOper.actOperatoriExecute(Sender: TObject);
begin
  inherited;
  A008FOperatori:=TA008FOperatori.Create(nil);
  try
    A008FOperatori.ShowModal;
  finally
    FreeAndNil(A008FOperatori);
  end;
end;

procedure TA008FAzOper.actLoginDipendenteExecute(Sender: TObject);
var SalvaColonneStruttura,SalvaTipiStruttura:TStringList;
    PrevSolaLettura:Boolean;
begin
  PrevSolaLettura:=SolaLettura;
  SolaLettura:=False;
  case A000GetInibizioni('Funzione','OpenA008LoginDipendente') of
    'N':begin
          ShowMessage('Funzione non abilitata!');
          SolaLettura:=PrevSolaLettura;
          Exit;
        end;
    'R':SolaLettura:=True;
  end;
  SalvaColonneStruttura:=TStringList.Create;
  SalvaTipiStruttura:=TStringList.Create;
  SalvaColonneStruttura.Assign(Parametri.ColonneStruttura);
  SalvaTipiStruttura.Assign(Parametri.TipiStruttura);
  Parametri.ColonneStruttura.Clear;
  Parametri.TipiStruttura.Clear;
  A008FLoginDipendenti:=TA008FLoginDipendenti.Create(nil);
  with A008FLoginDipendenti do
    try
      ShowModal;
    finally
      A008FOperatoriDtM1.AziendaCorrente:=A008FOperatoriDtM1.QI090.FieldByName('AZIENDA').AsString;
      A008FOperatoriDtM1.AggiornaFiltroProfili;
      FreeAndNil(A008FLoginDipendenti);
      Parametri.ColonneStruttura.Assign(SalvaColonneStruttura);
      Parametri.TipiStruttura.Assign(SalvaTipiStruttura);
      FreeAndNil(SalvaColonneStruttura);
      FreeAndNil(SalvaTipiStruttura);
      SolaLettura:=PrevSolaLettura;
    end;
end;

procedure TA008FAzOper.actAccessiExecute(Sender: TObject);
begin
  inherited;
  Application.CreateForm(TA008FAccessi,A008FAccessi);
  with A008FAccessi do
    try
      ShowModal;
    finally
      Release;
    end;
end;

end.
