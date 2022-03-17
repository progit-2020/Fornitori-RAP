// ************************************************************************ //
// The types declared in this file were generated from data read from the
// WSDL File described below:
// WSDL     : Z:\Normativa\Condivisi\Flussi XML Legge 104\WS_RPL104.xml
//  >Import : Z:\Normativa\Condivisi\Flussi XML Legge 104\WS_RPL104.xml>0
//  >Import : Z:\Normativa\Condivisi\Flussi XML Legge 104\WS_RPL104.xml>1
// (23/06/2014 10:25:10 - - $Rev: 56641 $)
// ************************************************************************ //

unit A151UWSPermessiL104;

interface

uses InvokeRegistry, SOAPHTTPClient, Types, XSBuiltIns;

const
  IS_OPTN = $0001;
  IS_UNBD = $0002;
  IS_UNQL = $0008;
  IS_ATTR = $0010;
  IS_REF  = $0080;


type

  // ************************************************************************ //
  // The following types, referred to in the WSDL document are not being represented
  // in this file. They are either aliases[@] of other types represented or were referred
  // to but never[!] declared in the document. The types from the latter category
  // typically map to predefined/known XML or Embarcadero types; however, they could also 
  // indicate incorrect WSDL documents that failed to declare or import a schema type.
  // ************************************************************************ //
  // !:integer         - "http://www.w3.org/2001/XMLSchema"[Gbl]
  // !:positiveInteger - "http://www.w3.org/2001/XMLSchema"[Gbl]
  // !:boolean         - "http://www.w3.org/2001/XMLSchema"[Gbl]
  // !:long            - "http://www.w3.org/2001/XMLSchema"[Gbl]
  // !:date            - "http://www.w3.org/2001/XMLSchema"[Gbl]
  // !:int             - "http://www.w3.org/2001/XMLSchema"[Gbl]
  // !:string          - "http://www.w3.org/2001/XMLSchema"[Gbl]
  // !:decimal         - "http://www.w3.org/2001/XMLSchema"[Gbl]

  rilSeStesso          = class;                 { "http://com.accenture.perla.it/legge104_inserimentopermessi"[Cplx] }
  rilPerTerzi          = class;                 { "http://com.accenture.perla.it/legge104_inserimentopermessi"[Cplx] }
  inserimentoPermessi  = class;                 { "http://com.accenture.perla.it/legge104_inserimentopermessi"[GblElm] }
  permesso             = class;                 { "http://com.accenture.perla.it/legge104_inserimentopermessi"[GblElm] }
  dipendentePubblico   = class;                 { "http://com.accenture.perla.it/legge104_inserimentopermessi"[Cplx] }
  success              = class;                 { "http://com.accenture.perla.it/legge104_inserimentopermessi"[Cplx] }
  wsdlResponse         = class;                 { "http://com.accenture.perla.it/legge104_inserimentopermessi"[GblElm] }
  wsdlRequest          = class;                 { "http://com.accenture.perla.it/legge104_inserimentopermessi"[GblElm] }
  dipendente           = class;                 { "http://com.accenture.perla.it/legge104_inserimentopermessi"[Cplx] }
  nuovoPermesso_type   = class;                 { "http://com.accenture.perla.it/legge104_inserimentopermessi"[GblCplx] }
  datiContrattuali     = class;                 { "http://com.accenture.perla.it/legge104_inserimentopermessi"[Cplx] }
  dettaglio            = class;                 { "http://com.accenture.perla.it/legge104_inserimentopermessi"[Cplx] }
  esitoInserimentoPermessi = class;             { "http://com.accenture.perla.it/legge104_inserimentopermessi"[GblElm] }
  terzoGrado           = class;                 { "http://com.accenture.perla.it/legge104_inserimentopermessi"[GblElm] }
  assistito            = class;                 { "http://com.accenture.perla.it/legge104_inserimentopermessi"[GblElm] }
  seStesso             = class;                 { "http://com.accenture.perla.it/legge104_inserimentopermessi"[GblElm] }
  permessiTerzi        = class;                 { "http://com.accenture.perla.it/legge104_inserimentopermessi"[GblElm] }
  genitore             = class;                 { "http://com.accenture.perla.it/legge104_inserimentopermessi"[Cplx] }
  agevolazioni         = class;                 { "http://com.accenture.perla.it/legge104_inserimentopermessi"[Cplx] }
  trasformazioneFullTime = class;               { "http://com.accenture.perla.it/legge104_inserimentopermessi"[Cplx] }
  trasformazionePartTime = class;               { "http://com.accenture.perla.it/legge104_inserimentopermessi"[Cplx] }

  {$SCOPEDENUMS ON}
  { "http://com.accenture.perla.it/legge104_inserimentopermessi"[GblSmpl] }
  sesso_type = (M, F);

  { "http://com.accenture.perla.it/legge104_inserimentopermessi"[GblSmpl] }
  esito_type = (OK, KO);

  { "http://com.accenture.perla.it/legge104_inserimentopermessi"[GblSmpl] }
  yesNo_type = (Y, N);

  {$SCOPEDENUMS OFF}



  // ************************************************************************ //
  // XML       : rilSeStesso, <complexType>
  // Namespace : http://com.accenture.perla.it/legge104_inserimentopermessi
  // ************************************************************************ //
  rilSeStesso = class(TRemotable)
  private
    Fid_rilevazione: TXSDecimal;
  public
    destructor Destroy; override;
  published
    property id_rilevazione: TXSDecimal  Index (IS_ATTR) read Fid_rilevazione write Fid_rilevazione;
  end;

  Array_Of_assistito = array of assistito;      { "http://com.accenture.perla.it/legge104_inserimentopermessi"[GblUbnd] }
  Array_Of_permesso = array of permesso;        { "http://com.accenture.perla.it/legge104_inserimentopermessi"[GblUbnd] }
  Array_Of_rilPerTerzi = array of rilPerTerzi;   { "http://com.accenture.perla.it/legge104_inserimentopermessi"[Ubnd] }
  Array_Of_dettaglio = array of dettaglio;      { "http://com.accenture.perla.it/legge104_inserimentopermessi"[Ubnd] }


  // ************************************************************************ //
  // XML       : rilPerTerzi, <complexType>
  // Namespace : http://com.accenture.perla.it/legge104_inserimentopermessi
  // ************************************************************************ //
  rilPerTerzi = class(TRemotable)
  private
    Fid_rilevazione: TXSDecimal;
  public
    destructor Destroy; override;
  published
    property id_rilevazione: TXSDecimal  Index (IS_ATTR) read Fid_rilevazione write Fid_rilevazione;
  end;



  // ************************************************************************ //
  // XML       : inserimentoPermessi, global, <element>
  // Namespace : http://com.accenture.perla.it/legge104_inserimentopermessi
  // ************************************************************************ //
  inserimentoPermessi = class(TRemotable)
  private
    FcodiceEnte: Int64;
    FannoRiferimento: TXSDecimal;
    FnuovoPermesso: nuovoPermesso_type;
  public
    destructor Destroy; override;
  published
    property codiceEnte:      Int64               Index (IS_ATTR) read FcodiceEnte write FcodiceEnte;
    property annoRiferimento: TXSDecimal          Index (IS_ATTR) read FannoRiferimento write FannoRiferimento;
    property nuovoPermesso:   nuovoPermesso_type  read FnuovoPermesso write FnuovoPermesso;
  end;



  // ************************************************************************ //
  // XML       : permesso, global, <element>
  // Namespace : http://com.accenture.perla.it/legge104_inserimentopermessi
  // ************************************************************************ //
  permesso = class(TRemotable)
  private
    Fmese: Integer;
    Fdettaglio: Array_Of_dettaglio;
  public
    destructor Destroy; override;
  published
    property mese:      Integer             Index (IS_ATTR) read Fmese write Fmese;
    property dettaglio: Array_Of_dettaglio  Index (IS_UNBD) read Fdettaglio write Fdettaglio;
  end;



  // ************************************************************************ //
  // XML       : dipendentePubblico, <complexType>
  // Namespace : http://com.accenture.perla.it/legge104_inserimentopermessi
  // ************************************************************************ //
  dipendentePubblico = class(TRemotable)
  private
    Fdenominazione: string;
    Fdurata: Integer;
  published
    property denominazione: string   Index (IS_ATTR) read Fdenominazione write Fdenominazione;
    property durata:        Integer  Index (IS_ATTR) read Fdurata write Fdurata;
  end;



  // ************************************************************************ //
  // XML       : success, <complexType>
  // Namespace : http://com.accenture.perla.it/legge104_inserimentopermessi
  // ************************************************************************ //
  success = class(TRemotable)
  private
    Fdescrizione: string;
    FrilSeStesso: rilSeStesso;
    FrilSeStesso_Specified: boolean;
    FrilPerTerzi: Array_Of_rilPerTerzi;
    FrilPerTerzi_Specified: boolean;
    procedure SetrilSeStesso(Index: Integer; const ArilSeStesso: rilSeStesso);
    function  rilSeStesso_Specified(Index: Integer): boolean;
    procedure SetrilPerTerzi(Index: Integer; const AArray_Of_rilPerTerzi: Array_Of_rilPerTerzi);
    function  rilPerTerzi_Specified(Index: Integer): boolean;
  public
    destructor Destroy; override;
  published
    property descrizione: string                read Fdescrizione write Fdescrizione;
    property rilSeStesso: rilSeStesso           Index (IS_OPTN) read FrilSeStesso write SetrilSeStesso stored rilSeStesso_Specified;
    property rilPerTerzi: Array_Of_rilPerTerzi  Index (IS_OPTN or IS_UNBD) read FrilPerTerzi write SetrilPerTerzi stored rilPerTerzi_Specified;
  end;

  warning    = array of string;                 { "http://com.accenture.perla.it/legge104_inserimentopermessi"[Cplx] }
  errori     = array of string;                 { "http://com.accenture.perla.it/legge104_inserimentopermessi"[Cplx] }


  // ************************************************************************ //
  // XML       : wsdlResponse, global, <element>
  // Namespace : http://com.accenture.perla.it/legge104_inserimentopermessi
  // ************************************************************************ //
  wsdlResponse = class(TRemotable)
  private
    FesitoInserimentoPermessi: esitoInserimentoPermessi;
  public
    destructor Destroy; override;
  published
    property esitoInserimentoPermessi: esitoInserimentoPermessi  Index (IS_REF) read FesitoInserimentoPermessi write FesitoInserimentoPermessi;
  end;



  // ************************************************************************ //
  // XML       : wsdlRequest, global, <element>
  // Namespace : http://com.accenture.perla.it/legge104_inserimentopermessi
  // ************************************************************************ //
  wsdlRequest = class(TRemotable)
  private
    FuserName: string;
    Fpwd: string;
    FinserimentoPermessi: inserimentoPermessi;
  public
    destructor Destroy; override;
  published
    property userName:            string               read FuserName write FuserName;
    property pwd:                 string               read Fpwd write Fpwd;
    property inserimentoPermessi: inserimentoPermessi  Index (IS_REF) read FinserimentoPermessi write FinserimentoPermessi;
  end;



  // ************************************************************************ //
  // XML       : dipendente, <complexType>
  // Namespace : http://com.accenture.perla.it/legge104_inserimentopermessi
  // ************************************************************************ //
  dipendente = class(TRemotable)
  private
    FcodiceFiscale: string;
    Fcognome: string;
    Fnome: string;
    Fsesso: sesso_type;
    FdataNascita: TXSDate;
    FcomuneNascita: string;
    FcomuneResidenza: string;
  public
    destructor Destroy; override;
  published
    property codiceFiscale:   string      Index (IS_ATTR) read FcodiceFiscale write FcodiceFiscale;
    property cognome:         string      Index (IS_ATTR) read Fcognome write Fcognome;
    property nome:            string      Index (IS_ATTR) read Fnome write Fnome;
    property sesso:           sesso_type  Index (IS_ATTR) read Fsesso write Fsesso;
    property dataNascita:     TXSDate     Index (IS_ATTR) read FdataNascita write FdataNascita;
    property comuneNascita:   string      Index (IS_ATTR) read FcomuneNascita write FcomuneNascita;
    property comuneResidenza: string      Index (IS_ATTR) read FcomuneResidenza write FcomuneResidenza;
  end;



  // ************************************************************************ //
  // XML       : nuovoPermesso_type, global, <complexType>
  // Namespace : http://com.accenture.perla.it/legge104_inserimentopermessi
  // ************************************************************************ //
  nuovoPermesso_type = class(TRemotable)
  private
    Fdipendente: dipendente;
    FdatiContrattuali: datiContrattuali;
    Fagevolazioni: agevolazioni;
    FseStesso: seStesso;
    FseStesso_Specified: boolean;
    FpermessiTerzi: permessiTerzi;
    FpermessiTerzi_Specified: boolean;
    procedure SetseStesso(Index: Integer; const AseStesso: seStesso);
    function  seStesso_Specified(Index: Integer): boolean;
    procedure SetpermessiTerzi(Index: Integer; const ApermessiTerzi: permessiTerzi);
    function  permessiTerzi_Specified(Index: Integer): boolean;
  public
    destructor Destroy; override;
  published
    property dipendente:       dipendente        read Fdipendente write Fdipendente;
    property datiContrattuali: datiContrattuali  read FdatiContrattuali write FdatiContrattuali;
    property agevolazioni:     agevolazioni      read Fagevolazioni write Fagevolazioni;
    property seStesso:         seStesso          Index (IS_OPTN or IS_REF) read FseStesso write SetseStesso stored seStesso_Specified;
    property permessiTerzi:    permessiTerzi     Index (IS_OPTN or IS_REF) read FpermessiTerzi write SetpermessiTerzi stored permessiTerzi_Specified;
  end;



  // ************************************************************************ //
  // XML       : datiContrattuali, <complexType>
  // Namespace : http://com.accenture.perla.it/legge104_inserimentopermessi
  // ************************************************************************ //
  datiContrattuali = class(TRemotable)
  private
    Finquadramento: Integer;
    FdataEntrata: TXSDate;
    Fdurata: Integer;
    FtipoContratto: Integer;
    FtipoPartTime: Integer;
    FtipoPartTime_Specified: boolean;
    FpercentualePartTime: TXSDecimal;
    FpercentualePartTime_Specified: boolean;
    procedure SettipoPartTime(Index: Integer; const AInteger: Integer);
    function  tipoPartTime_Specified(Index: Integer): boolean;
    procedure SetpercentualePartTime(Index: Integer; const ATXSDecimal: TXSDecimal);
    function  percentualePartTime_Specified(Index: Integer): boolean;
  public
    destructor Destroy; override;
  published
    property inquadramento:       Integer     Index (IS_ATTR) read Finquadramento write Finquadramento;
    property dataEntrata:         TXSDate     Index (IS_ATTR) read FdataEntrata write FdataEntrata;
    property durata:              Integer     Index (IS_ATTR) read Fdurata write Fdurata;
    property tipoContratto:       Integer     Index (IS_ATTR) read FtipoContratto write FtipoContratto;
    property tipoPartTime:        Integer     Index (IS_ATTR or IS_OPTN) read FtipoPartTime write SettipoPartTime stored tipoPartTime_Specified;
    property percentualePartTime: TXSDecimal  Index (IS_ATTR or IS_OPTN) read FpercentualePartTime write SetpercentualePartTime stored percentualePartTime_Specified;
  end;



  // ************************************************************************ //
  // XML       : dettaglio, <complexType>
  // Namespace : http://com.accenture.perla.it/legge104_inserimentopermessi
  // ************************************************************************ //
  dettaglio = class(TRemotable)
  private
    Fgiorno: Integer;
    Fgiornata: Boolean;
    Fore: TXSDecimal;
  public
    destructor Destroy; override;
  published
    property giorno:   Integer     Index (IS_ATTR) read Fgiorno write Fgiorno;
    property giornata: Boolean     Index (IS_ATTR) read Fgiornata write Fgiornata;
    property ore:      TXSDecimal  Index (IS_ATTR) read Fore write Fore;
  end;



  // ************************************************************************ //
  // XML       : esitoInserimentoPermessi, global, <element>
  // Namespace : http://com.accenture.perla.it/legge104_inserimentopermessi
  // ************************************************************************ //
  esitoInserimentoPermessi = class(TRemotable)
  private
    Fesito: esito_type;
    Ferrori: errori;
    Ferrori_Specified: boolean;
    Fwarning: warning;
    Fwarning_Specified: boolean;
    Fsuccess: success;
    Fsuccess_Specified: boolean;
    procedure Seterrori(Index: Integer; const Aerrori: errori);
    function  errori_Specified(Index: Integer): boolean;
    procedure Setwarning(Index: Integer; const Awarning: warning);
    function  warning_Specified(Index: Integer): boolean;
    procedure Setsuccess(Index: Integer; const Asuccess: success);
    function  success_Specified(Index: Integer): boolean;
  public
    destructor Destroy; override;
  published
    property esito:   esito_type  Index (IS_ATTR) read Fesito write Fesito;
    property errori:  errori      Index (IS_OPTN) read Ferrori write Seterrori stored errori_Specified;
    property warning: warning     Index (IS_OPTN) read Fwarning write Setwarning stored warning_Specified;
    property success: success     Index (IS_OPTN) read Fsuccess write Setsuccess stored success_Specified;
  end;



  // ************************************************************************ //
  // XML       : terzoGrado, global, <element>
  // Namespace : http://com.accenture.perla.it/legge104_inserimentopermessi
  // ************************************************************************ //
  terzoGrado = class(TRemotable)
  private
    Fmotivo: Integer;
  published
    property motivo: Integer  Index (IS_ATTR) read Fmotivo write Fmotivo;
  end;



  // ************************************************************************ //
  // XML       : assistito, global, <element>
  // Namespace : http://com.accenture.perla.it/legge104_inserimentopermessi
  // ************************************************************************ //
  assistito = class(TRemotable)
  private
    FcodiceFiscale: string;
    Fcognome: string;
    Fnome: string;
    Fsesso: sesso_type;
    FdataNascita: TXSDate;
    FcomuneNascita: string;
    FcomuneNascita_Specified: boolean;
    FcomuneResidenza: string;
    FparentelaDipendente: Integer;
    FtipoDisabilita: Integer;
    FannoRevisione: string;
    FannoRevisione_Specified: boolean;
    FterzoGrado: terzoGrado;
    FterzoGrado_Specified: boolean;
    Fgenitore: genitore;
    Fgenitore_Specified: boolean;
    FdipendentePubblico: dipendentePubblico;
    FdipendentePubblico_Specified: boolean;
    Fpermesso: Array_Of_permesso;
    procedure SetcomuneNascita(Index: Integer; const Astring: string);
    function  comuneNascita_Specified(Index: Integer): boolean;
    procedure SetannoRevisione(Index: Integer; const Astring: string);
    function  annoRevisione_Specified(Index: Integer): boolean;
    procedure SetterzoGrado(Index: Integer; const AterzoGrado: terzoGrado);
    function  terzoGrado_Specified(Index: Integer): boolean;
    procedure Setgenitore(Index: Integer; const Agenitore: genitore);
    function  genitore_Specified(Index: Integer): boolean;
    procedure SetdipendentePubblico(Index: Integer; const AdipendentePubblico: dipendentePubblico);
    function  dipendentePubblico_Specified(Index: Integer): boolean;
  public
    destructor Destroy; override;
  published
    property codiceFiscale:       string              Index (IS_ATTR) read FcodiceFiscale write FcodiceFiscale;
    property cognome:             string              Index (IS_ATTR) read Fcognome write Fcognome;
    property nome:                string              Index (IS_ATTR) read Fnome write Fnome;
    property sesso:               sesso_type          Index (IS_ATTR) read Fsesso write Fsesso;
    property dataNascita:         TXSDate             Index (IS_ATTR) read FdataNascita write FdataNascita;
    property comuneNascita:       string              Index (IS_ATTR or IS_OPTN) read FcomuneNascita write SetcomuneNascita stored comuneNascita_Specified;
    property comuneResidenza:     string              Index (IS_ATTR) read FcomuneResidenza write FcomuneResidenza;
    property parentelaDipendente: Integer             Index (IS_ATTR) read FparentelaDipendente write FparentelaDipendente;
    property tipoDisabilita:      Integer             Index (IS_ATTR) read FtipoDisabilita write FtipoDisabilita;
    property annoRevisione:       string              Index (IS_ATTR or IS_OPTN) read FannoRevisione write SetannoRevisione stored annoRevisione_Specified;
    property terzoGrado:          terzoGrado          Index (IS_OPTN or IS_REF) read FterzoGrado write SetterzoGrado stored terzoGrado_Specified;
    property genitore:            genitore            Index (IS_OPTN) read Fgenitore write Setgenitore stored genitore_Specified;
    property dipendentePubblico:  dipendentePubblico  Index (IS_OPTN) read FdipendentePubblico write SetdipendentePubblico stored dipendentePubblico_Specified;
    property permesso:            Array_Of_permesso   Index (IS_UNBD or IS_REF) read Fpermesso write Fpermesso;
  end;



  // ************************************************************************ //
  // XML       : seStesso, global, <element>
  // Namespace : http://com.accenture.perla.it/legge104_inserimentopermessi
  // ************************************************************************ //
  seStesso = class(TRemotable)
  private
    FtipoDisabilita: Integer;
    FannoRevisione: string;
    FannoRevisione_Specified: boolean;
    Fpermesso: Array_Of_permesso;
    procedure SetannoRevisione(Index: Integer; const Astring: string);
    function  annoRevisione_Specified(Index: Integer): boolean;
  public
    destructor Destroy; override;
  published
    property tipoDisabilita: Integer            Index (IS_ATTR) read FtipoDisabilita write FtipoDisabilita;
    property annoRevisione:  string             Index (IS_ATTR or IS_OPTN) read FannoRevisione write SetannoRevisione stored annoRevisione_Specified;
    property permesso:       Array_Of_permesso  Index (IS_UNBD or IS_REF) read Fpermesso write Fpermesso;
  end;



  // ************************************************************************ //
  // XML       : permessiTerzi, global, <element>
  // Namespace : http://com.accenture.perla.it/legge104_inserimentopermessi
  // ************************************************************************ //
  permessiTerzi = class(TRemotable)
  private
    FavvicinamentoAltriSede: yesNo_type;
    FavvicinamentoAltriAnno: string;
    FavvicinamentoAltriAnno_Specified: boolean;
    Fassistito: Array_Of_assistito;
    procedure SetavvicinamentoAltriAnno(Index: Integer; const Astring: string);
    function  avvicinamentoAltriAnno_Specified(Index: Integer): boolean;
  public
    destructor Destroy; override;
  published
    property avvicinamentoAltriSede: yesNo_type          Index (IS_ATTR) read FavvicinamentoAltriSede write FavvicinamentoAltriSede;
    property avvicinamentoAltriAnno: string              Index (IS_ATTR or IS_OPTN) read FavvicinamentoAltriAnno write SetavvicinamentoAltriAnno stored avvicinamentoAltriAnno_Specified;
    property assistito:              Array_Of_assistito  Index (IS_UNBD or IS_REF) read Fassistito write Fassistito;
  end;



  // ************************************************************************ //
  // XML       : genitore, <complexType>
  // Namespace : http://com.accenture.perla.it/legge104_inserimentopermessi
  // ************************************************************************ //
  genitore = class(TRemotable)
  private
    FfiglioFinoTreAnni: yesNo_type;
    Falternativa: Int64;
    FalternativaDipendentePubblico: yesNo_type;
    FalternativaDipendentePubblico_Specified: boolean;
    FalternativaDenominazionePA: string;
    FalternativaDenominazionePA_Specified: boolean;
    FterzoGrado: terzoGrado;
    FterzoGrado_Specified: boolean;
    procedure SetalternativaDipendentePubblico(Index: Integer; const AyesNo_type: yesNo_type);
    function  alternativaDipendentePubblico_Specified(Index: Integer): boolean;
    procedure SetalternativaDenominazionePA(Index: Integer; const Astring: string);
    function  alternativaDenominazionePA_Specified(Index: Integer): boolean;
    procedure SetterzoGrado(Index: Integer; const AterzoGrado: terzoGrado);
    function  terzoGrado_Specified(Index: Integer): boolean;
  public
    destructor Destroy; override;
  published
    property figlioFinoTreAnni:             yesNo_type  Index (IS_ATTR) read FfiglioFinoTreAnni write FfiglioFinoTreAnni;
    property alternativa:                   Int64       Index (IS_ATTR) read Falternativa write Falternativa;
    property alternativaDipendentePubblico: yesNo_type  Index (IS_ATTR or IS_OPTN) read FalternativaDipendentePubblico write SetalternativaDipendentePubblico stored alternativaDipendentePubblico_Specified;
    property alternativaDenominazionePA:    string      Index (IS_ATTR or IS_OPTN) read FalternativaDenominazionePA write SetalternativaDenominazionePA stored alternativaDenominazionePA_Specified;
    property terzoGrado:                    terzoGrado  Index (IS_OPTN or IS_REF) read FterzoGrado write SetterzoGrado stored terzoGrado_Specified;
  end;



  // ************************************************************************ //
  // XML       : agevolazioni, <complexType>
  // Namespace : http://com.accenture.perla.it/legge104_inserimentopermessi
  // ************************************************************************ //
  agevolazioni = class(TRemotable)
  private
    FavvicinamentoSede: yesNo_type;
    FavvicinamentoAnno: string;
    FavvicinamentoAnno_Specified: boolean;
    FtrasformazionePartTime: trasformazionePartTime;
    FtrasformazionePartTime_Specified: boolean;
    FtrasformazioneFullTime: trasformazioneFullTime;
    FtrasformazioneFullTime_Specified: boolean;
    procedure SetavvicinamentoAnno(Index: Integer; const Astring: string);
    function  avvicinamentoAnno_Specified(Index: Integer): boolean;
    procedure SettrasformazionePartTime(Index: Integer; const AtrasformazionePartTime: trasformazionePartTime);
    function  trasformazionePartTime_Specified(Index: Integer): boolean;
    procedure SettrasformazioneFullTime(Index: Integer; const AtrasformazioneFullTime: trasformazioneFullTime);
    function  trasformazioneFullTime_Specified(Index: Integer): boolean;
  public
    destructor Destroy; override;
  published
    property avvicinamentoSede:      yesNo_type              Index (IS_ATTR) read FavvicinamentoSede write FavvicinamentoSede;
    property avvicinamentoAnno:      string                  Index (IS_ATTR or IS_OPTN) read FavvicinamentoAnno write SetavvicinamentoAnno stored avvicinamentoAnno_Specified;
    property trasformazionePartTime: trasformazionePartTime  Index (IS_OPTN) read FtrasformazionePartTime write SettrasformazionePartTime stored trasformazionePartTime_Specified;
    property trasformazioneFullTime: trasformazioneFullTime  Index (IS_OPTN) read FtrasformazioneFullTime write SettrasformazioneFullTime stored trasformazioneFullTime_Specified;
  end;



  // ************************************************************************ //
  // XML       : trasformazioneFullTime, <complexType>
  // Namespace : http://com.accenture.perla.it/legge104_inserimentopermessi
  // ************************************************************************ //
  trasformazioneFullTime = class(TRemotable)
  private
    Fdal: TXSDate;
    Fal: TXSDate;
    Fal_Specified: boolean;
    FtipoTrasformazione: Integer;
    Fpercentuale: TXSDecimal;
    procedure Setal(Index: Integer; const ATXSDate: TXSDate);
    function  al_Specified(Index: Integer): boolean;
  public
    destructor Destroy; override;
  published
    property dal:                TXSDate     Index (IS_ATTR) read Fdal write Fdal;
    property al:                 TXSDate     Index (IS_ATTR or IS_OPTN) read Fal write Setal stored al_Specified;
    property tipoTrasformazione: Integer     Index (IS_ATTR) read FtipoTrasformazione write FtipoTrasformazione;
    property percentuale:        TXSDecimal  Index (IS_ATTR) read Fpercentuale write Fpercentuale;
  end;



  // ************************************************************************ //
  // XML       : trasformazionePartTime, <complexType>
  // Namespace : http://com.accenture.perla.it/legge104_inserimentopermessi
  // ************************************************************************ //
  trasformazionePartTime = class(TRemotable)
  private
    Fdal: TXSDate;
    Fal: TXSDate;
    Fal_Specified: boolean;
    FtipoTrasformazione: Integer;
    Fpercentuale: TXSDecimal;
    procedure Setal(Index: Integer; const ATXSDate: TXSDate);
    function  al_Specified(Index: Integer): boolean;
  public
    destructor Destroy; override;
  published
    property dal:                TXSDate     Index (IS_ATTR) read Fdal write Fdal;
    property al:                 TXSDate     Index (IS_ATTR or IS_OPTN) read Fal write Setal stored al_Specified;
    property tipoTrasformazione: Integer     Index (IS_ATTR) read FtipoTrasformazione write FtipoTrasformazione;
    property percentuale:        TXSDecimal  Index (IS_ATTR) read Fpercentuale write Fpercentuale;
  end;


  // ************************************************************************ //
  // Namespace : http://com.accenture.perla.it/legge104
  // soapAction: InserimentoPermessi
  // transport : http://schemas.xmlsoap.org/soap/http
  // style     : document
  // use       : literal
  // binding   : Legge104Binding
  // service   : Legge104Service
  // port      : Legge104InterfaceEndpoint
  // URL       : http://10.4.5.5:8180/Legge104/1
  // ************************************************************************ //
  Legge104 = interface(IInvokable)
  ['{19605DE4-521E-1B0A-B9E4-98FC58016434}']
    function  InserimentoPermessi(const wsdlRequest: wsdlRequest): wsdlResponse; stdcall;
  end;

function GetLegge104(UseWSDL: Boolean=System.False; Addr: string=''; HTTPRIO: THTTPRIO = nil): Legge104;


implementation
  uses SysUtils;

function GetLegge104(UseWSDL: Boolean; Addr: string; HTTPRIO: THTTPRIO): Legge104;
const
  defWSDL = 'Z:\Normativa\Condivisi\Flussi XML Legge 104\WS_RPL104.xml';
  defURL  = 'http://10.4.5.5:8180/Legge104/1';
  defSvc  = 'Legge104Service';
  defPrt  = 'Legge104InterfaceEndpoint';
var
  RIO: THTTPRIO;
begin
  Result := nil;
  if (Addr = '') then
  begin
    if UseWSDL then
      Addr := defWSDL
    else
      Addr := defURL;
  end;
  if HTTPRIO = nil then
    RIO := THTTPRIO.Create(nil)
  else
    RIO := HTTPRIO;
  try
    Result := (RIO as Legge104);
    if UseWSDL then
    begin
      RIO.WSDLLocation := Addr;
      RIO.Service := defSvc;
      RIO.Port := defPrt;
    end else
      RIO.URL := Addr;
  finally
    if (Result = nil) and (HTTPRIO = nil) then
      RIO.Free;
  end;
end;


destructor rilSeStesso.Destroy;
begin
  SysUtils.FreeAndNil(Fid_rilevazione);
  inherited Destroy;
end;

destructor rilPerTerzi.Destroy;
begin
  SysUtils.FreeAndNil(Fid_rilevazione);
  inherited Destroy;
end;

destructor inserimentoPermessi.Destroy;
begin
  SysUtils.FreeAndNil(FannoRiferimento);
  SysUtils.FreeAndNil(FnuovoPermesso);
  inherited Destroy;
end;

destructor permesso.Destroy;
var
  I: Integer;
begin
  for I := 0 to System.Length(Fdettaglio)-1 do
    SysUtils.FreeAndNil(Fdettaglio[I]);
  System.SetLength(Fdettaglio, 0);
  inherited Destroy;
end;

destructor success.Destroy;
var
  I: Integer;
begin
  for I := 0 to System.Length(FrilPerTerzi)-1 do
    SysUtils.FreeAndNil(FrilPerTerzi[I]);
  System.SetLength(FrilPerTerzi, 0);
  SysUtils.FreeAndNil(FrilSeStesso);
  inherited Destroy;
end;

procedure success.SetrilSeStesso(Index: Integer; const ArilSeStesso: rilSeStesso);
begin
  FrilSeStesso := ArilSeStesso;
  FrilSeStesso_Specified := True;
end;

function success.rilSeStesso_Specified(Index: Integer): boolean;
begin
  Result := FrilSeStesso_Specified;
end;

procedure success.SetrilPerTerzi(Index: Integer; const AArray_Of_rilPerTerzi: Array_Of_rilPerTerzi);
begin
  FrilPerTerzi := AArray_Of_rilPerTerzi;
  FrilPerTerzi_Specified := True;
end;

function success.rilPerTerzi_Specified(Index: Integer): boolean;
begin
  Result := FrilPerTerzi_Specified;
end;

destructor wsdlResponse.Destroy;
begin
  SysUtils.FreeAndNil(FesitoInserimentoPermessi);
  inherited Destroy;
end;

destructor wsdlRequest.Destroy;
begin
  SysUtils.FreeAndNil(FinserimentoPermessi);
  inherited Destroy;
end;

destructor dipendente.Destroy;
begin
  SysUtils.FreeAndNil(FdataNascita);
  inherited Destroy;
end;

destructor nuovoPermesso_type.Destroy;
begin
  SysUtils.FreeAndNil(Fdipendente);
  SysUtils.FreeAndNil(FdatiContrattuali);
  SysUtils.FreeAndNil(Fagevolazioni);
  SysUtils.FreeAndNil(FseStesso);
  SysUtils.FreeAndNil(FpermessiTerzi);
  inherited Destroy;
end;

procedure nuovoPermesso_type.SetseStesso(Index: Integer; const AseStesso: seStesso);
begin
  FseStesso := AseStesso;
  FseStesso_Specified := True;
end;

function nuovoPermesso_type.seStesso_Specified(Index: Integer): boolean;
begin
  Result := FseStesso_Specified;
end;

procedure nuovoPermesso_type.SetpermessiTerzi(Index: Integer; const ApermessiTerzi: permessiTerzi);
begin
  FpermessiTerzi := ApermessiTerzi;
  FpermessiTerzi_Specified := True;
end;

function nuovoPermesso_type.permessiTerzi_Specified(Index: Integer): boolean;
begin
  Result := FpermessiTerzi_Specified;
end;

destructor datiContrattuali.Destroy;
begin
  SysUtils.FreeAndNil(FdataEntrata);
  SysUtils.FreeAndNil(FpercentualePartTime);
  inherited Destroy;
end;

procedure datiContrattuali.SettipoPartTime(Index: Integer; const AInteger: Integer);
begin
  FtipoPartTime := AInteger;
  FtipoPartTime_Specified := True;
end;

function datiContrattuali.tipoPartTime_Specified(Index: Integer): boolean;
begin
  Result := FtipoPartTime_Specified;
end;

procedure datiContrattuali.SetpercentualePartTime(Index: Integer; const ATXSDecimal: TXSDecimal);
begin
  FpercentualePartTime := ATXSDecimal;
  FpercentualePartTime_Specified := True;
end;

function datiContrattuali.percentualePartTime_Specified(Index: Integer): boolean;
begin
  Result := FpercentualePartTime_Specified;
end;

destructor dettaglio.Destroy;
begin
  SysUtils.FreeAndNil(Fore);
  inherited Destroy;
end;

destructor esitoInserimentoPermessi.Destroy;
begin
  SysUtils.FreeAndNil(Fsuccess);
  inherited Destroy;
end;

procedure esitoInserimentoPermessi.Seterrori(Index: Integer; const Aerrori: errori);
begin
  Ferrori := Aerrori;
  Ferrori_Specified := True;
end;

function esitoInserimentoPermessi.errori_Specified(Index: Integer): boolean;
begin
  Result := Ferrori_Specified;
end;

procedure esitoInserimentoPermessi.Setwarning(Index: Integer; const Awarning: warning);
begin
  Fwarning := Awarning;
  Fwarning_Specified := True;
end;

function esitoInserimentoPermessi.warning_Specified(Index: Integer): boolean;
begin
  Result := Fwarning_Specified;
end;

procedure esitoInserimentoPermessi.Setsuccess(Index: Integer; const Asuccess: success);
begin
  Fsuccess := Asuccess;
  Fsuccess_Specified := True;
end;

function esitoInserimentoPermessi.success_Specified(Index: Integer): boolean;
begin
  Result := Fsuccess_Specified;
end;

destructor assistito.Destroy;
var
  I: Integer;
begin
  for I := 0 to System.Length(Fpermesso)-1 do
    SysUtils.FreeAndNil(Fpermesso[I]);
  System.SetLength(Fpermesso, 0);
  SysUtils.FreeAndNil(FdataNascita);
  SysUtils.FreeAndNil(FterzoGrado);
  SysUtils.FreeAndNil(Fgenitore);
  SysUtils.FreeAndNil(FdipendentePubblico);
  inherited Destroy;
end;

procedure assistito.SetcomuneNascita(Index: Integer; const Astring: string);
begin
  FcomuneNascita := Astring;
  FcomuneNascita_Specified := True;
end;

function assistito.comuneNascita_Specified(Index: Integer): boolean;
begin
  Result := FcomuneNascita_Specified;
end;

procedure assistito.SetannoRevisione(Index: Integer; const Astring: string);
begin
  FannoRevisione := Astring;
  FannoRevisione_Specified := True;
end;

function assistito.annoRevisione_Specified(Index: Integer): boolean;
begin
  Result := FannoRevisione_Specified;
end;

procedure assistito.SetterzoGrado(Index: Integer; const AterzoGrado: terzoGrado);
begin
  FterzoGrado := AterzoGrado;
  FterzoGrado_Specified := True;
end;

function assistito.terzoGrado_Specified(Index: Integer): boolean;
begin
  Result := FterzoGrado_Specified;
end;

procedure assistito.Setgenitore(Index: Integer; const Agenitore: genitore);
begin
  Fgenitore := Agenitore;
  Fgenitore_Specified := True;
end;

function assistito.genitore_Specified(Index: Integer): boolean;
begin
  Result := Fgenitore_Specified;
end;

procedure assistito.SetdipendentePubblico(Index: Integer; const AdipendentePubblico: dipendentePubblico);
begin
  FdipendentePubblico := AdipendentePubblico;
  FdipendentePubblico_Specified := True;
end;

function assistito.dipendentePubblico_Specified(Index: Integer): boolean;
begin
  Result := FdipendentePubblico_Specified;
end;

destructor seStesso.Destroy;
var
  I: Integer;
begin
  for I := 0 to System.Length(Fpermesso)-1 do
    SysUtils.FreeAndNil(Fpermesso[I]);
  System.SetLength(Fpermesso, 0);
  inherited Destroy;
end;

procedure seStesso.SetannoRevisione(Index: Integer; const Astring: string);
begin
  FannoRevisione := Astring;
  FannoRevisione_Specified := True;
end;

function seStesso.annoRevisione_Specified(Index: Integer): boolean;
begin
  Result := FannoRevisione_Specified;
end;

destructor permessiTerzi.Destroy;
var
  I: Integer;
begin
  for I := 0 to System.Length(Fassistito)-1 do
    SysUtils.FreeAndNil(Fassistito[I]);
  System.SetLength(Fassistito, 0);
  inherited Destroy;
end;

procedure permessiTerzi.SetavvicinamentoAltriAnno(Index: Integer; const Astring: string);
begin
  FavvicinamentoAltriAnno := Astring;
  FavvicinamentoAltriAnno_Specified := True;
end;

function permessiTerzi.avvicinamentoAltriAnno_Specified(Index: Integer): boolean;
begin
  Result := FavvicinamentoAltriAnno_Specified;
end;

destructor genitore.Destroy;
begin
  SysUtils.FreeAndNil(FterzoGrado);
  inherited Destroy;
end;

procedure genitore.SetalternativaDipendentePubblico(Index: Integer; const AyesNo_type: yesNo_type);
begin
  FalternativaDipendentePubblico := AyesNo_type;
  FalternativaDipendentePubblico_Specified := True;
end;

function genitore.alternativaDipendentePubblico_Specified(Index: Integer): boolean;
begin
  Result := FalternativaDipendentePubblico_Specified;
end;

procedure genitore.SetalternativaDenominazionePA(Index: Integer; const Astring: string);
begin
  FalternativaDenominazionePA := Astring;
  FalternativaDenominazionePA_Specified := True;
end;

function genitore.alternativaDenominazionePA_Specified(Index: Integer): boolean;
begin
  Result := FalternativaDenominazionePA_Specified;
end;

procedure genitore.SetterzoGrado(Index: Integer; const AterzoGrado: terzoGrado);
begin
  FterzoGrado := AterzoGrado;
  FterzoGrado_Specified := True;
end;

function genitore.terzoGrado_Specified(Index: Integer): boolean;
begin
  Result := FterzoGrado_Specified;
end;

destructor agevolazioni.Destroy;
begin
  SysUtils.FreeAndNil(FtrasformazionePartTime);
  SysUtils.FreeAndNil(FtrasformazioneFullTime);
  inherited Destroy;
end;

procedure agevolazioni.SetavvicinamentoAnno(Index: Integer; const Astring: string);
begin
  FavvicinamentoAnno := Astring;
  FavvicinamentoAnno_Specified := True;
end;

function agevolazioni.avvicinamentoAnno_Specified(Index: Integer): boolean;
begin
  Result := FavvicinamentoAnno_Specified;
end;

procedure agevolazioni.SettrasformazionePartTime(Index: Integer; const AtrasformazionePartTime: trasformazionePartTime);
begin
  FtrasformazionePartTime := AtrasformazionePartTime;
  FtrasformazionePartTime_Specified := True;
end;

function agevolazioni.trasformazionePartTime_Specified(Index: Integer): boolean;
begin
  Result := FtrasformazionePartTime_Specified;
end;

procedure agevolazioni.SettrasformazioneFullTime(Index: Integer; const AtrasformazioneFullTime: trasformazioneFullTime);
begin
  FtrasformazioneFullTime := AtrasformazioneFullTime;
  FtrasformazioneFullTime_Specified := True;
end;

function agevolazioni.trasformazioneFullTime_Specified(Index: Integer): boolean;
begin
  Result := FtrasformazioneFullTime_Specified;
end;

destructor trasformazioneFullTime.Destroy;
begin
  SysUtils.FreeAndNil(Fdal);
  SysUtils.FreeAndNil(Fal);
  SysUtils.FreeAndNil(Fpercentuale);
  inherited Destroy;
end;

procedure trasformazioneFullTime.Setal(Index: Integer; const ATXSDate: TXSDate);
begin
  Fal := ATXSDate;
  Fal_Specified := True;
end;

function trasformazioneFullTime.al_Specified(Index: Integer): boolean;
begin
  Result := Fal_Specified;
end;

destructor trasformazionePartTime.Destroy;
begin
  SysUtils.FreeAndNil(Fdal);
  SysUtils.FreeAndNil(Fal);
  SysUtils.FreeAndNil(Fpercentuale);
  inherited Destroy;
end;

procedure trasformazionePartTime.Setal(Index: Integer; const ATXSDate: TXSDate);
begin
  Fal := ATXSDate;
  Fal_Specified := True;
end;

function trasformazionePartTime.al_Specified(Index: Integer): boolean;
begin
  Result := Fal_Specified;
end;

initialization
  { Legge104 }
  InvRegistry.RegisterInterface(TypeInfo(Legge104), 'http://com.accenture.perla.it/legge104', '');
  InvRegistry.RegisterDefaultSOAPAction(TypeInfo(Legge104), 'InserimentoPermessi');
  InvRegistry.RegisterInvokeOptions(TypeInfo(Legge104), ioDocument);
  { Legge104.InserimentoPermessi }
  InvRegistry.RegisterMethodInfo(TypeInfo(Legge104), 'InserimentoPermessi', '',
                                 '[ReturnName="wsdlResponse"]', IS_OPTN or IS_REF);
  InvRegistry.RegisterParamInfo(TypeInfo(Legge104), 'InserimentoPermessi', 'wsdlRequest', '',
                                '[Namespace="http://com.accenture.perla.it/legge104_inserimentopermessi"]', IS_REF);
  InvRegistry.RegisterParamInfo(TypeInfo(Legge104), 'InserimentoPermessi', 'wsdlResponse', '',
                                '[Namespace="http://com.accenture.perla.it/legge104_inserimentopermessi"]', IS_REF);
  RemClassRegistry.RegisterXSClass(rilSeStesso, 'http://com.accenture.perla.it/legge104_inserimentopermessi', 'rilSeStesso');
  RemClassRegistry.RegisterXSInfo(TypeInfo(Array_Of_assistito), 'http://com.accenture.perla.it/legge104_inserimentopermessi', 'Array_Of_assistito');
  RemClassRegistry.RegisterXSInfo(TypeInfo(Array_Of_permesso), 'http://com.accenture.perla.it/legge104_inserimentopermessi', 'Array_Of_permesso');
  RemClassRegistry.RegisterXSInfo(TypeInfo(Array_Of_rilPerTerzi), 'http://com.accenture.perla.it/legge104_inserimentopermessi', 'Array_Of_rilPerTerzi');
  RemClassRegistry.RegisterXSInfo(TypeInfo(Array_Of_dettaglio), 'http://com.accenture.perla.it/legge104_inserimentopermessi', 'Array_Of_dettaglio');
  RemClassRegistry.RegisterXSClass(rilPerTerzi, 'http://com.accenture.perla.it/legge104_inserimentopermessi', 'rilPerTerzi');
  RemClassRegistry.RegisterXSClass(inserimentoPermessi, 'http://com.accenture.perla.it/legge104_inserimentopermessi', 'inserimentoPermessi');
  RemClassRegistry.RegisterXSInfo(TypeInfo(sesso_type), 'http://com.accenture.perla.it/legge104_inserimentopermessi', 'sesso_type');
  RemClassRegistry.RegisterXSClass(permesso, 'http://com.accenture.perla.it/legge104_inserimentopermessi', 'permesso');
  RemClassRegistry.RegisterXSClass(dipendentePubblico, 'http://com.accenture.perla.it/legge104_inserimentopermessi', 'dipendentePubblico');
  RemClassRegistry.RegisterXSClass(success, 'http://com.accenture.perla.it/legge104_inserimentopermessi', 'success');
  RemClassRegistry.RegisterXSInfo(TypeInfo(warning), 'http://com.accenture.perla.it/legge104_inserimentopermessi', 'warning');
  RemClassRegistry.RegisterXSInfo(TypeInfo(errori), 'http://com.accenture.perla.it/legge104_inserimentopermessi', 'errori');
  RemClassRegistry.RegisterXSClass(wsdlResponse, 'http://com.accenture.perla.it/legge104_inserimentopermessi', 'wsdlResponse');
  RemClassRegistry.RegisterXSClass(wsdlRequest, 'http://com.accenture.perla.it/legge104_inserimentopermessi', 'wsdlRequest');
  RemClassRegistry.RegisterXSClass(dipendente, 'http://com.accenture.perla.it/legge104_inserimentopermessi', 'dipendente');
  RemClassRegistry.RegisterXSClass(nuovoPermesso_type, 'http://com.accenture.perla.it/legge104_inserimentopermessi', 'nuovoPermesso_type');
  RemClassRegistry.RegisterXSClass(datiContrattuali, 'http://com.accenture.perla.it/legge104_inserimentopermessi', 'datiContrattuali');
  RemClassRegistry.RegisterXSClass(dettaglio, 'http://com.accenture.perla.it/legge104_inserimentopermessi', 'dettaglio');
  RemClassRegistry.RegisterXSInfo(TypeInfo(esito_type), 'http://com.accenture.perla.it/legge104_inserimentopermessi', 'esito_type');
  RemClassRegistry.RegisterXSClass(esitoInserimentoPermessi, 'http://com.accenture.perla.it/legge104_inserimentopermessi', 'esitoInserimentoPermessi');
  RemClassRegistry.RegisterExternalPropName(TypeInfo(esitoInserimentoPermessi), 'errori', '[ArrayItemName="descrizione"]');
  RemClassRegistry.RegisterExternalPropName(TypeInfo(esitoInserimentoPermessi), 'warning', '[ArrayItemName="descrizione"]');
  RemClassRegistry.RegisterXSClass(terzoGrado, 'http://com.accenture.perla.it/legge104_inserimentopermessi', 'terzoGrado');
  RemClassRegistry.RegisterXSClass(assistito, 'http://com.accenture.perla.it/legge104_inserimentopermessi', 'assistito');
  RemClassRegistry.RegisterXSClass(seStesso, 'http://com.accenture.perla.it/legge104_inserimentopermessi', 'seStesso');
  RemClassRegistry.RegisterXSInfo(TypeInfo(yesNo_type), 'http://com.accenture.perla.it/legge104_inserimentopermessi', 'yesNo_type');
  RemClassRegistry.RegisterXSClass(permessiTerzi, 'http://com.accenture.perla.it/legge104_inserimentopermessi', 'permessiTerzi');
  RemClassRegistry.RegisterXSClass(genitore, 'http://com.accenture.perla.it/legge104_inserimentopermessi', 'genitore');
  RemClassRegistry.RegisterXSClass(agevolazioni, 'http://com.accenture.perla.it/legge104_inserimentopermessi', 'agevolazioni');
  RemClassRegistry.RegisterXSClass(trasformazioneFullTime, 'http://com.accenture.perla.it/legge104_inserimentopermessi', 'trasformazioneFullTime');
  RemClassRegistry.RegisterXSClass(trasformazionePartTime, 'http://com.accenture.perla.it/legge104_inserimentopermessi', 'trasformazionePartTime');

end.