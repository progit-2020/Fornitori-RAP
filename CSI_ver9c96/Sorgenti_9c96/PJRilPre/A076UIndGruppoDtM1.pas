unit A076UIndGruppoDtM1;

interface

uses
  Windows, Messages, SysUtils, Math, Classes, Graphics, Controls, Forms, Dialogs,
  R004UGESTSTORICODTM, Db, Oracle, OracleData, Variants,
  A000UCostanti, A000USessione, A000UInterfaccia, A000UMessaggi, C180FunzioniGenerali,
  A076UIndGruppoMW;

type
  TA076FIndGruppoDtM1 = class(TR004FGestStoricoDtM)
    Q161: TOracleDataSet;
    DselT161: TDataSource;
    selaT161: TOracleDataSet;
    selaT161CODICE: TStringField;
    selaT161CODICE2: TStringField;
    selaT161INDENNITA: TStringField;
    selaT161DESCRIZIONE: TStringField;
    selaT161DECORRENZA: TDateTimeField;
    _updT161: TOracleQuery;
    _insT161: TOracleQuery;
    Q161CODICE: TStringField;
    Q161CODICE2: TStringField;
    Q161INDENNITA: TStringField;
    Q161D_INDENNITA: TStringField;
    Q161DECORRENZA: TDateTimeField;
    Q161D_DescCodice: TStringField;
    Q161D_DescCodice2: TStringField;
    Q161D_CodiceInd: TStringField;
    procedure BDEQ161INDENNITAValidate(Sender: TField);
    procedure DataModuleCreate(Sender: TObject);
    procedure Q161CODICEValidate(Sender: TField);
  private
    { Private declarations }
  public
    A076MW:TA076FIndGruppoMW;
  end;

var
  A076FIndGruppoDtM1: TA076FIndGruppoDtM1;

implementation

uses A076UIndGruppo;

{$R *.DFM}

procedure TA076FIndGruppoDtM1.DataModuleCreate(Sender: TObject);
begin
  inherited;
  A076MW:=TA076FIndGruppoMW.Create(Self);
  A076MW.Q161:=Q161;
  InterfacciaR004:=A076FIndGruppo.InterfacciaR004;
  InizializzaDataSet(Q161,[evBeforeEdit,
                           evBeforeInsert,
                           evBeforePost,
                           evBeforeDelete,
                           evAfterDelete,
                           evAfterPost,
                           evOnNewRecord,
                           evOnTranslateMessage]);
  A076MW.InizializzaTabella;
  Q161.Open;
end;

procedure TA076FIndGruppoDtM1.Q161CODICEValidate(Sender: TField);
begin
  inherited;
  A076MW.Q161CODICEValidate(Sender);
end;

procedure TA076FIndGruppoDtM1.BDEQ161INDENNITAValidate(Sender: TField);
begin
  A076MW.BDEQ161INDENNITAValidate(Sender);
end;

end.
