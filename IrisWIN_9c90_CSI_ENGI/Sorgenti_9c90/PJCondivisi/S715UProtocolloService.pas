// ************************************************************************ //
// The types declared in this file were generated from data read from the
// WSDL File described below:
// WSDL     : Y:\Aosta_Regione\Valutazioni\protocolloService.xml
//  >Import : Y:\Aosta_Regione\Valutazioni\protocolloService.xml>0
//  >Import : Y:\Aosta_Regione\Valutazioni\protocolloService.xml>1
//  >Import : Y:\Aosta_Regione\Valutazioni\protocolloService.xml>2
//  >Import : Y:\Aosta_Regione\Valutazioni\protocolloService.xml>3
//  >Import : Y:\Aosta_Regione\Valutazioni\protocolloService.xml>4
// Encoding : UTF-8
// Version  : 1.0
// (08/11/2013 12.53.12 - - $Rev: 56641 $)
// ************************************************************************ //

unit S715UProtocolloService;

interface

uses InvokeRegistry, SOAPHTTPClient, Types, XSBuiltIns;

const
  IS_OPTN = $0001;
  IS_UNBD = $0002;
  IS_ATTR = $0010;


type

  // ************************************************************************ //
  // The following types, referred to in the WSDL document are not being represented
  // in this file. They are either aliases[@] of other types represented or were referred
  // to but never[!] declared in the document. The types from the latter category
  // typically map to predefined/known XML or Embarcadero types; however, they could also 
  // indicate incorrect WSDL documents that failed to declare or import a schema type.
  // ************************************************************************ //
  // !:base64Binary    - "http://www.w3.org/2001/XMLSchema"[Gbl]
  // !:long            - "http://www.w3.org/2001/XMLSchema"[Gbl]
  // !:string          - "http://www.w3.org/2001/XMLSchema"[Gbl]
  // !:dateTime        - "http://www.w3.org/2001/XMLSchema"[Gbl]
  // !:int             - "http://www.w3.org/2001/XMLSchema"[Gbl]
  // !:boolean         - "http://www.w3.org/2001/XMLSchema"[Gbl]

  filingRequest        = class;                 { "http://insielmercato.it/protocollo-ws/data/filing"[Lit][GblCplx] }
  anagraficRequest     = class;                 { "http://insielmercato.it/protocollo-ws/data/anagrafic"[Lit][GblCplx] }
  anagraficList        = class;                 { "http://insielmercato.it/protocollo-ws/services/protocolloService"[Lit][GblElm] }
  filingList           = class;                 { "http://insielmercato.it/protocollo-ws/services/protocolloService"[Lit][GblElm] }
  mnemonic             = class;                 { "http://insielmercato.it/protocollo-ws/data/common"[GblCplx] }
  user                 = class;                 { "http://insielmercato.it/protocollo-ws/data/common"[GblCplx] }
  recordIdentifier     = class;                 { "http://insielmercato.it/protocollo-ws/data/common"[GblCplx] }
  level                = class;                 { "http://insielmercato.it/protocollo-ws/data/common"[GblCplx] }
  protocolListRequest  = class;                 { "http://insielmercato.it/protocollo-ws/data/protocol"[Lit][GblCplx] }
  protocolList         = class;                 { "http://insielmercato.it/protocollo-ws/services/protocolloService"[Lit][GblElm] }
  protocolDetail2      = class;                 { "http://insielmercato.it/protocollo-ws/data/common"[GblCplx] }
  mnemonicLevel        = class;                 { "http://insielmercato.it/protocollo-ws/data/common"[GblCplx] }
  protocolUpdateRequest = class;                { "http://insielmercato.it/protocollo-ws/data/protocol"[Lit][GblCplx] }
  protocolUpdate       = class;                 { "http://insielmercato.it/protocollo-ws/services/protocolloService"[Lit][GblElm] }
  previous             = class;                 { "http://insielmercato.it/protocollo-ws/data/common"[GblCplx] }
  filing               = class;                 { "http://insielmercato.it/protocollo-ws/data/common"[GblCplx] }
  document             = class;                 { "http://insielmercato.it/protocollo-ws/data/common"[GblCplx] }
  externalDocument     = class;                 { "http://insielmercato.it/protocollo-ws/data/common"[GblCplx] }
  anagraficResponse    = class;                 { "http://insielmercato.it/protocollo-ws/data/anagrafic"[Lit][GblCplx] }
  anagraficListResponse = class;                { "http://insielmercato.it/protocollo-ws/services/protocolloService"[Lit][GblElm] }
  anagrafic            = class;                 { "http://insielmercato.it/protocollo-ws/data/common"[GblCplx] }
  correspondent        = class;                 { "http://insielmercato.it/protocollo-ws/data/common"[GblCplx] }
  office               = class;                 { "http://insielmercato.it/protocollo-ws/data/common"[GblCplx] }
  filingResponse       = class;                 { "http://insielmercato.it/protocollo-ws/data/filing"[Lit][GblCplx] }
  filingListResponse   = class;                 { "http://insielmercato.it/protocollo-ws/services/protocolloService"[Lit][GblElm] }
  registry             = class;                 { "http://insielmercato.it/protocollo-ws/data/common"[GblCplx] }
  officeBasicInformation = class;               { "http://insielmercato.it/protocollo-ws/data/common"[GblCplx] }
  documentDetails      = class;                 { "http://insielmercato.it/protocollo-ws/data/common"[GblCplx] }
  measureDetails       = class;                 { "http://insielmercato.it/protocollo-ws/data/common"[GblCplx] }
  dossier              = class;                 { "http://insielmercato.it/protocollo-ws/data/common"[GblCplx] }
  recipient            = class;                 { "http://insielmercato.it/protocollo-ws/data/common"[GblCplx] }
  protocolDetailRequest = class;                { "http://insielmercato.it/protocollo-ws/data/protocol"[Lit][GblCplx] }
  protocolDetail       = class;                 { "http://insielmercato.it/protocollo-ws/services/protocolloService"[Lit][GblElm] }
  protocolDetailResponse2 = class;              { "http://insielmercato.it/protocollo-ws/data/protocol"[Lit][GblCplx] }
  protocolDetailResponse = class;               { "http://insielmercato.it/protocollo-ws/services/protocolloService"[Lit][GblElm] }
  availableOfficesAndRegistriesRequest = class;   { "http://insielmercato.it/protocollo-ws/data/protocol"[Lit][GblCplx] }
  availableOfficesAndRegistries = class;        { "http://insielmercato.it/protocollo-ws/services/protocolloService"[Lit][GblElm] }
  protocolResponse     = class;                 { "http://insielmercato.it/protocollo-ws/data/protocol"[Lit][GblCplx] }
  protocolListResponse = class;                 { "http://insielmercato.it/protocollo-ws/services/protocolloService"[Lit][GblElm] }
  protocolUpdateResponse = class;               { "http://insielmercato.it/protocollo-ws/services/protocolloService"[Lit][GblElm] }
  protocolInsertResponse = class;               { "http://insielmercato.it/protocollo-ws/services/protocolloService"[Lit][GblElm] }
  error                = class;                 { "http://insielmercato.it/protocollo-ws/data/common"[GblCplx] }
  availableOfficesAndRegistriesResponse2 = class;   { "http://insielmercato.it/protocollo-ws/data/protocol"[Lit][GblCplx] }
  availableOfficesAndRegistriesResponse = class;   { "http://insielmercato.it/protocollo-ws/services/protocolloService"[Lit][GblElm] }
  sender               = class;                 { "http://insielmercato.it/protocollo-ws/data/common"[GblCplx] }
  operatingOfficeBasicInformation = class;      { "http://insielmercato.it/protocollo-ws/data/common"[GblCplx] }
  protocolInsertRequest = class;                { "http://insielmercato.it/protocollo-ws/data/protocol"[Lit][GblCplx] }
  protocolInsert       = class;                 { "http://insielmercato.it/protocollo-ws/services/protocolloService"[Lit][GblElm] }

  {$SCOPEDENUMS ON}
  { "http://insielmercato.it/protocollo-ws/data/common"[GblSmpl] }
  direction = (A, P);

  { "http://insielmercato.it/protocollo-ws/data/anagrafic"[GblSmpl] }
  emailAccreditation = (PEC, ADE, IPA);

  { "http://insielmercato.it/protocollo-ws/data/protocol"[GblSmpl] }
  direction2 = (A, P);

  {$SCOPEDENUMS OFF}

  registryList = array of registry;             { "http://insielmercato.it/protocollo-ws/data/common"[Cplx] }
  officeList = array of officeBasicInformation;   { "http://insielmercato.it/protocollo-ws/data/common"[Cplx] }
  mnemonicLevelList = array of mnemonicLevel;   { "http://insielmercato.it/protocollo-ws/data/common"[Cplx] }
  documentList = array of document;             { "http://insielmercato.it/protocollo-ws/data/common"[Cplx] }
  externalDocumentList = array of externalDocument;   { "http://insielmercato.it/protocollo-ws/data/common"[Cplx] }
  officeList2 = array of office;                { "http://insielmercato.it/protocollo-ws/data/common"[Cplx] }
  senderList = array of sender;                 { "http://insielmercato.it/protocollo-ws/data/common"[Cplx] }
  recipientList = array of recipient;           { "http://insielmercato.it/protocollo-ws/data/common"[Cplx] }
  filingList2 = array of filing;                { "http://insielmercato.it/protocollo-ws/data/filing"[Cplx] }


  // ************************************************************************ //
  // XML       : filingRequest, global, <complexType>
  // Namespace : http://insielmercato.it/protocollo-ws/data/filing
  // Serializtn: [xoLiteralParam]
  // Info      : Wrapper
  // ************************************************************************ //
  filingRequest = class(TRemotable)
  private
    Fuser: user;
    Ffiling: filing;
    Ffiling_Specified: boolean;
    procedure Setfiling(Index: Integer; const Afiling: filing);
    function  filing_Specified(Index: Integer): boolean;
  public
    constructor Create; override;
    destructor Destroy; override;
  published
    property user:   user    read Fuser write Fuser;
    property filing: filing  Index (IS_OPTN) read Ffiling write Setfiling stored filing_Specified;
  end;

  levelList  = array of level;                  { "http://insielmercato.it/protocollo-ws/data/common"[Cplx] }
  filingList3 = array of filing;                { "http://insielmercato.it/protocollo-ws/data/common"[Cplx] }
  dossierList = array of dossier;               { "http://insielmercato.it/protocollo-ws/data/common"[Cplx] }
  mnemonicList = array of mnemonic;             { "http://insielmercato.it/protocollo-ws/data/common"[Cplx] }
  previousList = array of previous;             { "http://insielmercato.it/protocollo-ws/data/common"[Cplx] }


  // ************************************************************************ //
  // XML       : anagraficRequest, global, <complexType>
  // Namespace : http://insielmercato.it/protocollo-ws/data/anagrafic
  // Serializtn: [xoLiteralParam]
  // Info      : Wrapper
  // ************************************************************************ //
  anagraficRequest = class(TRemotable)
  private
    Fuser: user;
    Fanagrafic: anagrafic;
    Fanagrafic_Specified: boolean;
    FemailAccreditation: emailAccreditation;
    FemailAccreditation_Specified: boolean;
    procedure Setanagrafic(Index: Integer; const Aanagrafic: anagrafic);
    function  anagrafic_Specified(Index: Integer): boolean;
    procedure SetemailAccreditation(Index: Integer; const AemailAccreditation: emailAccreditation);
    function  emailAccreditation_Specified(Index: Integer): boolean;
  public
    constructor Create; override;
    destructor Destroy; override;
  published
    property user:               user                read Fuser write Fuser;
    property anagrafic:          anagrafic           Index (IS_OPTN) read Fanagrafic write Setanagrafic stored anagrafic_Specified;
    property emailAccreditation: emailAccreditation  Index (IS_OPTN) read FemailAccreditation write SetemailAccreditation stored emailAccreditation_Specified;
  end;



  // ************************************************************************ //
  // XML       : anagraficList, global, <element>
  // Namespace : http://insielmercato.it/protocollo-ws/services/protocolloService
  // Info      : Wrapper
  // ************************************************************************ //
  anagraficList = class(anagraficRequest)
  private
  published
  end;



  // ************************************************************************ //
  // XML       : filingList, global, <element>
  // Namespace : http://insielmercato.it/protocollo-ws/services/protocolloService
  // Info      : Wrapper
  // ************************************************************************ //
  filingList = class(filingRequest)
  private
  published
  end;

  anagraficList2 = array of anagrafic;          { "http://insielmercato.it/protocollo-ws/data/anagrafic"[Cplx] }
  filingList4 = array of filing;                { "http://insielmercato.it/protocollo-ws/data/protocol"[Cplx] }
  externalDocumentList2 = array of externalDocument;   { "http://insielmercato.it/protocollo-ws/data/protocol"[Cplx] }
  documentList2 = array of document;            { "http://insielmercato.it/protocollo-ws/data/protocol"[Cplx] }
  dossierList2 = array of dossier;              { "http://insielmercato.it/protocollo-ws/data/protocol"[Cplx] }
  previousList2 = array of previous;            { "http://insielmercato.it/protocollo-ws/data/protocol"[Cplx] }
  mnemonicList2 = array of mnemonic;            { "http://insielmercato.it/protocollo-ws/data/protocol"[Cplx] }


  // ************************************************************************ //
  // XML       : mnemonic, global, <complexType>
  // Namespace : http://insielmercato.it/protocollo-ws/data/common
  // ************************************************************************ //
  mnemonic = class(TRemotable)
  private
    Fcode: string;
    Fcode_Specified: boolean;
    FtypeCode: string;
    FtypeCode_Specified: boolean;
    FmnemonicLevelList: mnemonicLevelList;
    FmnemonicLevelList_Specified: boolean;
    procedure Setcode(Index: Integer; const Astring: string);
    function  code_Specified(Index: Integer): boolean;
    procedure SettypeCode(Index: Integer; const Astring: string);
    function  typeCode_Specified(Index: Integer): boolean;
    procedure SetmnemonicLevelList(Index: Integer; const AmnemonicLevelList: mnemonicLevelList);
    function  mnemonicLevelList_Specified(Index: Integer): boolean;
  public
    destructor Destroy; override;
  published
    property code:              string             Index (IS_OPTN) read Fcode write Setcode stored code_Specified;
    property typeCode:          string             Index (IS_OPTN) read FtypeCode write SettypeCode stored typeCode_Specified;
    property mnemonicLevelList: mnemonicLevelList  Index (IS_OPTN) read FmnemonicLevelList write SetmnemonicLevelList stored mnemonicLevelList_Specified;
  end;



  // ************************************************************************ //
  // XML       : user, global, <complexType>
  // Namespace : http://insielmercato.it/protocollo-ws/data/common
  // ************************************************************************ //
  user = class(TRemotable)
  private
    Fcode: string;
    Fpassword: string;
    Ftoken: string;
    Ftoken_Specified: boolean;
    procedure Settoken(Index: Integer; const Astring: string);
    function  token_Specified(Index: Integer): boolean;
  published
    property code:     string  read Fcode write Fcode;
    property password: string  read Fpassword write Fpassword;
    property token:    string  Index (IS_OPTN) read Ftoken write Settoken stored token_Specified;
  end;



  // ************************************************************************ //
  // XML       : recordIdentifier, global, <complexType>
  // Namespace : http://insielmercato.it/protocollo-ws/data/common
  // ************************************************************************ //
  recordIdentifier = class(TRemotable)
  private
    FanagraficProgR: Int64;
    FanagraficProgR_Specified: boolean;
    Fdirection: direction;
    Fdirection_Specified: boolean;
    FdocumentProg: Int64;
    FdocumentProg_Specified: boolean;
    FmoveProg: Integer;
    FmoveProg_Specified: boolean;
    Fnumber: Integer;
    Fnumber_Specified: boolean;
    FofficeCode: string;
    FofficeCode_Specified: boolean;
    FregistrationDate: TXSDateTime;
    FregistrationDate_Specified: boolean;
    FregistryCode: string;
    FregistryCode_Specified: boolean;
    Fyear: Integer;
    Fyear_Specified: boolean;
    procedure SetanagraficProgR(Index: Integer; const AInt64: Int64);
    function  anagraficProgR_Specified(Index: Integer): boolean;
    procedure Setdirection(Index: Integer; const Adirection: direction);
    function  direction_Specified(Index: Integer): boolean;
    procedure SetdocumentProg(Index: Integer; const AInt64: Int64);
    function  documentProg_Specified(Index: Integer): boolean;
    procedure SetmoveProg(Index: Integer; const AInteger: Integer);
    function  moveProg_Specified(Index: Integer): boolean;
    procedure Setnumber(Index: Integer; const AInteger: Integer);
    function  number_Specified(Index: Integer): boolean;
    procedure SetofficeCode(Index: Integer; const Astring: string);
    function  officeCode_Specified(Index: Integer): boolean;
    procedure SetregistrationDate(Index: Integer; const ATXSDateTime: TXSDateTime);
    function  registrationDate_Specified(Index: Integer): boolean;
    procedure SetregistryCode(Index: Integer; const Astring: string);
    function  registryCode_Specified(Index: Integer): boolean;
    procedure Setyear(Index: Integer; const AInteger: Integer);
    function  year_Specified(Index: Integer): boolean;
  public
    destructor Destroy; override;
  published
    property anagraficProgR:   Int64        Index (IS_OPTN) read FanagraficProgR write SetanagraficProgR stored anagraficProgR_Specified;
    property direction:        direction    Index (IS_OPTN) read Fdirection write Setdirection stored direction_Specified;
    property documentProg:     Int64        Index (IS_OPTN) read FdocumentProg write SetdocumentProg stored documentProg_Specified;
    property moveProg:         Integer      Index (IS_OPTN) read FmoveProg write SetmoveProg stored moveProg_Specified;
    property number:           Integer      Index (IS_OPTN) read Fnumber write Setnumber stored number_Specified;
    property officeCode:       string       Index (IS_OPTN) read FofficeCode write SetofficeCode stored officeCode_Specified;
    property registrationDate: TXSDateTime  Index (IS_OPTN) read FregistrationDate write SetregistrationDate stored registrationDate_Specified;
    property registryCode:     string       Index (IS_OPTN) read FregistryCode write SetregistryCode stored registryCode_Specified;
    property year:             Integer      Index (IS_OPTN) read Fyear write Setyear stored year_Specified;
  end;



  // ************************************************************************ //
  // XML       : level, global, <complexType>
  // Namespace : http://insielmercato.it/protocollo-ws/data/common
  // ************************************************************************ //
  level = class(TRemotable)
  private
    Findex_: Integer;
    Fvalue: string;
  published
    property index_: Integer  read Findex_ write Findex_;
    property value:  string   read Fvalue write Fvalue;
  end;



  // ************************************************************************ //
  // XML       : protocolListRequest, global, <complexType>
  // Namespace : http://insielmercato.it/protocollo-ws/data/protocol
  // Serializtn: [xoLiteralParam]
  // Info      : Wrapper
  // ************************************************************************ //
  protocolListRequest = class(TRemotable)
  private
    Fuser: user;
    FofficeCode: string;
    FregisterCode: string;
    FintervalYearBegin: Integer;
    FintervalYearBegin_Specified: boolean;
    FintervalYearEnd: Integer;
    FintervalYearEnd_Specified: boolean;
    FintervalNumberBegin: Integer;
    FintervalNumberBegin_Specified: boolean;
    FintervalNumberEnd: Integer;
    FintervalNumberEnd_Specified: boolean;
    FintervalDateBegin: TXSDateTime;
    FintervalDateBegin_Specified: boolean;
    FintervalDateEnd: TXSDateTime;
    FintervalDateEnd_Specified: boolean;
    procedure SetintervalYearBegin(Index: Integer; const AInteger: Integer);
    function  intervalYearBegin_Specified(Index: Integer): boolean;
    procedure SetintervalYearEnd(Index: Integer; const AInteger: Integer);
    function  intervalYearEnd_Specified(Index: Integer): boolean;
    procedure SetintervalNumberBegin(Index: Integer; const AInteger: Integer);
    function  intervalNumberBegin_Specified(Index: Integer): boolean;
    procedure SetintervalNumberEnd(Index: Integer; const AInteger: Integer);
    function  intervalNumberEnd_Specified(Index: Integer): boolean;
    procedure SetintervalDateBegin(Index: Integer; const ATXSDateTime: TXSDateTime);
    function  intervalDateBegin_Specified(Index: Integer): boolean;
    procedure SetintervalDateEnd(Index: Integer; const ATXSDateTime: TXSDateTime);
    function  intervalDateEnd_Specified(Index: Integer): boolean;
  public
    constructor Create; override;
    destructor Destroy; override;
  published
    property user:                user         read Fuser write Fuser;
    property officeCode:          string       read FofficeCode write FofficeCode;
    property registerCode:        string       read FregisterCode write FregisterCode;
    property intervalYearBegin:   Integer      Index (IS_OPTN) read FintervalYearBegin write SetintervalYearBegin stored intervalYearBegin_Specified;
    property intervalYearEnd:     Integer      Index (IS_OPTN) read FintervalYearEnd write SetintervalYearEnd stored intervalYearEnd_Specified;
    property intervalNumberBegin: Integer      Index (IS_OPTN) read FintervalNumberBegin write SetintervalNumberBegin stored intervalNumberBegin_Specified;
    property intervalNumberEnd:   Integer      Index (IS_OPTN) read FintervalNumberEnd write SetintervalNumberEnd stored intervalNumberEnd_Specified;
    property intervalDateBegin:   TXSDateTime  Index (IS_OPTN) read FintervalDateBegin write SetintervalDateBegin stored intervalDateBegin_Specified;
    property intervalDateEnd:     TXSDateTime  Index (IS_OPTN) read FintervalDateEnd write SetintervalDateEnd stored intervalDateEnd_Specified;
  end;



  // ************************************************************************ //
  // XML       : protocolList, global, <element>
  // Namespace : http://insielmercato.it/protocollo-ws/services/protocolloService
  // Info      : Wrapper
  // ************************************************************************ //
  protocolList = class(protocolListRequest)
  private
  published
  end;



  // ************************************************************************ //
  // XML       : protocolDetail, global, <complexType>
  // Namespace : http://insielmercato.it/protocollo-ws/data/common
  // ************************************************************************ //
  protocolDetail2 = class(TRemotable)
  private
    FrecordIdentifier: recordIdentifier;
    FsubjectDocument: string;
    FsubjectDocument_Specified: boolean;
    FsubjectProtocol: string;
    FsubjectProtocol_Specified: boolean;
    FreceptionSendingDate: TXSDateTime;
    FreceptionSendingDate_Specified: boolean;
    FtypeSenderMail: Integer;
    FtypeSenderMail_Specified: boolean;
    FmeasureDetails: measureDetails;
    FmeasureDetails_Specified: boolean;
    FsenderList: senderList;
    FsenderList_Specified: boolean;
    FrecipientList: recipientList;
    FrecipientList_Specified: boolean;
    FofficeList: officeList2;
    FofficeList_Specified: boolean;
    FdocumentList: documentList;
    FdocumentList_Specified: boolean;
    FexternalDocumentList: externalDocumentList;
    FexternalDocumentList_Specified: boolean;
    FfilingList: filingList3;
    FfilingList_Specified: boolean;
    FmnemonicList: mnemonicList;
    FmnemonicList_Specified: boolean;
    FpreviousList: previousList;
    FpreviousList_Specified: boolean;
    FdossierList: dossierList;
    FdossierList_Specified: boolean;
    procedure SetsubjectDocument(Index: Integer; const Astring: string);
    function  subjectDocument_Specified(Index: Integer): boolean;
    procedure SetsubjectProtocol(Index: Integer; const Astring: string);
    function  subjectProtocol_Specified(Index: Integer): boolean;
    procedure SetreceptionSendingDate(Index: Integer; const ATXSDateTime: TXSDateTime);
    function  receptionSendingDate_Specified(Index: Integer): boolean;
    procedure SettypeSenderMail(Index: Integer; const AInteger: Integer);
    function  typeSenderMail_Specified(Index: Integer): boolean;
    procedure SetmeasureDetails(Index: Integer; const AmeasureDetails: measureDetails);
    function  measureDetails_Specified(Index: Integer): boolean;
    procedure SetsenderList(Index: Integer; const AsenderList: senderList);
    function  senderList_Specified(Index: Integer): boolean;
    procedure SetrecipientList(Index: Integer; const ArecipientList: recipientList);
    function  recipientList_Specified(Index: Integer): boolean;
    procedure SetofficeList(Index: Integer; const AofficeList2: officeList2);
    function  officeList_Specified(Index: Integer): boolean;
    procedure SetdocumentList(Index: Integer; const AdocumentList: documentList);
    function  documentList_Specified(Index: Integer): boolean;
    procedure SetexternalDocumentList(Index: Integer; const AexternalDocumentList: externalDocumentList);
    function  externalDocumentList_Specified(Index: Integer): boolean;
    procedure SetfilingList(Index: Integer; const AfilingList3: filingList3);
    function  filingList_Specified(Index: Integer): boolean;
    procedure SetmnemonicList(Index: Integer; const AmnemonicList: mnemonicList);
    function  mnemonicList_Specified(Index: Integer): boolean;
    procedure SetpreviousList(Index: Integer; const ApreviousList: previousList);
    function  previousList_Specified(Index: Integer): boolean;
    procedure SetdossierList(Index: Integer; const AdossierList: dossierList);
    function  dossierList_Specified(Index: Integer): boolean;
  public
    destructor Destroy; override;
  published
    property recordIdentifier:     recordIdentifier      read FrecordIdentifier write FrecordIdentifier;
    property subjectDocument:      string                Index (IS_OPTN) read FsubjectDocument write SetsubjectDocument stored subjectDocument_Specified;
    property subjectProtocol:      string                Index (IS_OPTN) read FsubjectProtocol write SetsubjectProtocol stored subjectProtocol_Specified;
    property receptionSendingDate: TXSDateTime           Index (IS_OPTN) read FreceptionSendingDate write SetreceptionSendingDate stored receptionSendingDate_Specified;
    property typeSenderMail:       Integer               Index (IS_OPTN) read FtypeSenderMail write SettypeSenderMail stored typeSenderMail_Specified;
    property measureDetails:       measureDetails        Index (IS_OPTN) read FmeasureDetails write SetmeasureDetails stored measureDetails_Specified;
    property senderList:           senderList            Index (IS_OPTN) read FsenderList write SetsenderList stored senderList_Specified;
    property recipientList:        recipientList         Index (IS_OPTN) read FrecipientList write SetrecipientList stored recipientList_Specified;
    property officeList:           officeList2           Index (IS_OPTN) read FofficeList write SetofficeList stored officeList_Specified;
    property documentList:         documentList          Index (IS_OPTN) read FdocumentList write SetdocumentList stored documentList_Specified;
    property externalDocumentList: externalDocumentList  Index (IS_OPTN) read FexternalDocumentList write SetexternalDocumentList stored externalDocumentList_Specified;
    property filingList:           filingList3           Index (IS_OPTN) read FfilingList write SetfilingList stored filingList_Specified;
    property mnemonicList:         mnemonicList          Index (IS_OPTN) read FmnemonicList write SetmnemonicList stored mnemonicList_Specified;
    property previousList:         previousList          Index (IS_OPTN) read FpreviousList write SetpreviousList stored previousList_Specified;
    property dossierList:          dossierList           Index (IS_OPTN) read FdossierList write SetdossierList stored dossierList_Specified;
  end;



  // ************************************************************************ //
  // XML       : mnemonicLevel, global, <complexType>
  // Namespace : http://insielmercato.it/protocollo-ws/data/common
  // ************************************************************************ //
  mnemonicLevel = class(TRemotable)
  private
    Findex_: Integer;
    Fvalue: string;
  published
    property index_: Integer  read Findex_ write Findex_;
    property value:  string   read Fvalue write Fvalue;
  end;

  officeList3 = array of office;                { "http://insielmercato.it/protocollo-ws/data/protocol"[Cplx] }


  // ************************************************************************ //
  // XML       : protocolUpdateRequest, global, <complexType>
  // Namespace : http://insielmercato.it/protocollo-ws/data/protocol
  // Serializtn: [xoLiteralParam]
  // Info      : Wrapper
  // ************************************************************************ //
  protocolUpdateRequest = class(TRemotable)
  private
    Fuser: user;
    FrecordIdentifier: recordIdentifier;
    FsubjectProtocol: string;
    FsubjectProtocol_Specified: boolean;
    FreceptionSendingDate: TXSDateTime;
    FreceptionSendingDate_Specified: boolean;
    FtypeSenderMail: Integer;
    FtypeSenderMail_Specified: boolean;
    FdocumentDetails: documentDetails;
    FdocumentDetails_Specified: boolean;
    FmeasureDetails: measureDetails;
    FmeasureDetails_Specified: boolean;
    FofficePartialUpdate: Boolean;
    FofficePartialUpdate_Specified: boolean;
    FmnemonicPartialUpdate: Boolean;
    FmnemonicPartialUpdate_Specified: boolean;
    FpreviousPartialUpdate: Boolean;
    FpreviousPartialUpdate_Specified: boolean;
    FfilingPartialUpdate: Boolean;
    FfilingPartialUpdate_Specified: boolean;
    FdocumentPartialUpdate: Boolean;
    FdocumentPartialUpdate_Specified: boolean;
    FdossierPartialUpdate: Boolean;
    FdossierPartialUpdate_Specified: boolean;
    FofficeList: officeList3;
    FofficeList_Specified: boolean;
    FdocumentList: documentList2;
    FdocumentList_Specified: boolean;
    FexternalDocumentList: externalDocumentList2;
    FexternalDocumentList_Specified: boolean;
    FfilingList: filingList4;
    FfilingList_Specified: boolean;
    FmnemonicList: mnemonicList2;
    FmnemonicList_Specified: boolean;
    FpreviousList: previousList2;
    FpreviousList_Specified: boolean;
    FdossierList: dossierList2;
    FdossierList_Specified: boolean;
    procedure SetsubjectProtocol(Index: Integer; const Astring: string);
    function  subjectProtocol_Specified(Index: Integer): boolean;
    procedure SetreceptionSendingDate(Index: Integer; const ATXSDateTime: TXSDateTime);
    function  receptionSendingDate_Specified(Index: Integer): boolean;
    procedure SettypeSenderMail(Index: Integer; const AInteger: Integer);
    function  typeSenderMail_Specified(Index: Integer): boolean;
    procedure SetdocumentDetails(Index: Integer; const AdocumentDetails: documentDetails);
    function  documentDetails_Specified(Index: Integer): boolean;
    procedure SetmeasureDetails(Index: Integer; const AmeasureDetails: measureDetails);
    function  measureDetails_Specified(Index: Integer): boolean;
    procedure SetofficePartialUpdate(Index: Integer; const ABoolean: Boolean);
    function  officePartialUpdate_Specified(Index: Integer): boolean;
    procedure SetmnemonicPartialUpdate(Index: Integer; const ABoolean: Boolean);
    function  mnemonicPartialUpdate_Specified(Index: Integer): boolean;
    procedure SetpreviousPartialUpdate(Index: Integer; const ABoolean: Boolean);
    function  previousPartialUpdate_Specified(Index: Integer): boolean;
    procedure SetfilingPartialUpdate(Index: Integer; const ABoolean: Boolean);
    function  filingPartialUpdate_Specified(Index: Integer): boolean;
    procedure SetdocumentPartialUpdate(Index: Integer; const ABoolean: Boolean);
    function  documentPartialUpdate_Specified(Index: Integer): boolean;
    procedure SetdossierPartialUpdate(Index: Integer; const ABoolean: Boolean);
    function  dossierPartialUpdate_Specified(Index: Integer): boolean;
    procedure SetofficeList(Index: Integer; const AofficeList3: officeList3);
    function  officeList_Specified(Index: Integer): boolean;
    procedure SetdocumentList(Index: Integer; const AdocumentList2: documentList2);
    function  documentList_Specified(Index: Integer): boolean;
    procedure SetexternalDocumentList(Index: Integer; const AexternalDocumentList2: externalDocumentList2);
    function  externalDocumentList_Specified(Index: Integer): boolean;
    procedure SetfilingList(Index: Integer; const AfilingList4: filingList4);
    function  filingList_Specified(Index: Integer): boolean;
    procedure SetmnemonicList(Index: Integer; const AmnemonicList2: mnemonicList2);
    function  mnemonicList_Specified(Index: Integer): boolean;
    procedure SetpreviousList(Index: Integer; const ApreviousList2: previousList2);
    function  previousList_Specified(Index: Integer): boolean;
    procedure SetdossierList(Index: Integer; const AdossierList2: dossierList2);
    function  dossierList_Specified(Index: Integer): boolean;
  public
    constructor Create; override;
    destructor Destroy; override;
  published
    property user:                  user                   read Fuser write Fuser;
    property recordIdentifier:      recordIdentifier       read FrecordIdentifier write FrecordIdentifier;
    property subjectProtocol:       string                 Index (IS_OPTN) read FsubjectProtocol write SetsubjectProtocol stored subjectProtocol_Specified;
    property receptionSendingDate:  TXSDateTime            Index (IS_OPTN) read FreceptionSendingDate write SetreceptionSendingDate stored receptionSendingDate_Specified;
    property typeSenderMail:        Integer                Index (IS_OPTN) read FtypeSenderMail write SettypeSenderMail stored typeSenderMail_Specified;
    property documentDetails:       documentDetails        Index (IS_OPTN) read FdocumentDetails write SetdocumentDetails stored documentDetails_Specified;
    property measureDetails:        measureDetails         Index (IS_OPTN) read FmeasureDetails write SetmeasureDetails stored measureDetails_Specified;
    property officePartialUpdate:   Boolean                Index (IS_OPTN) read FofficePartialUpdate write SetofficePartialUpdate stored officePartialUpdate_Specified;
    property mnemonicPartialUpdate: Boolean                Index (IS_OPTN) read FmnemonicPartialUpdate write SetmnemonicPartialUpdate stored mnemonicPartialUpdate_Specified;
    property previousPartialUpdate: Boolean                Index (IS_OPTN) read FpreviousPartialUpdate write SetpreviousPartialUpdate stored previousPartialUpdate_Specified;
    property filingPartialUpdate:   Boolean                Index (IS_OPTN) read FfilingPartialUpdate write SetfilingPartialUpdate stored filingPartialUpdate_Specified;
    property documentPartialUpdate: Boolean                Index (IS_OPTN) read FdocumentPartialUpdate write SetdocumentPartialUpdate stored documentPartialUpdate_Specified;
    property dossierPartialUpdate:  Boolean                Index (IS_OPTN) read FdossierPartialUpdate write SetdossierPartialUpdate stored dossierPartialUpdate_Specified;
    property officeList:            officeList3            Index (IS_OPTN) read FofficeList write SetofficeList stored officeList_Specified;
    property documentList:          documentList2          Index (IS_OPTN) read FdocumentList write SetdocumentList stored documentList_Specified;
    property externalDocumentList:  externalDocumentList2  Index (IS_OPTN) read FexternalDocumentList write SetexternalDocumentList stored externalDocumentList_Specified;
    property filingList:            filingList4            Index (IS_OPTN) read FfilingList write SetfilingList stored filingList_Specified;
    property mnemonicList:          mnemonicList2          Index (IS_OPTN) read FmnemonicList write SetmnemonicList stored mnemonicList_Specified;
    property previousList:          previousList2          Index (IS_OPTN) read FpreviousList write SetpreviousList stored previousList_Specified;
    property dossierList:           dossierList2           Index (IS_OPTN) read FdossierList write SetdossierList stored dossierList_Specified;
  end;



  // ************************************************************************ //
  // XML       : protocolUpdate, global, <element>
  // Namespace : http://insielmercato.it/protocollo-ws/services/protocolloService
  // Info      : Wrapper
  // ************************************************************************ //
  protocolUpdate = class(protocolUpdateRequest)
  private
  published
  end;



  // ************************************************************************ //
  // XML       : previous, global, <complexType>
  // Namespace : http://insielmercato.it/protocollo-ws/data/common
  // ************************************************************************ //
  previous = class(recordIdentifier)
  private
    FlinkType: string;
    FlinkType_Specified: boolean;
    Fremove: Boolean;
    Fremove_Specified: boolean;
    procedure SetlinkType(Index: Integer; const Astring: string);
    function  linkType_Specified(Index: Integer): boolean;
    procedure Setremove(Index: Integer; const ABoolean: Boolean);
    function  remove_Specified(Index: Integer): boolean;
  published
    property linkType: string   Index (IS_OPTN) read FlinkType write SetlinkType stored linkType_Specified;
    property remove:   Boolean  Index (IS_OPTN) read Fremove write Setremove stored remove_Specified;
  end;



  // ************************************************************************ //
  // XML       : filing, global, <complexType>
  // Namespace : http://insielmercato.it/protocollo-ws/data/common
  // ************************************************************************ //
  filing = class(TRemotable)
  private
    Fcode: string;
    Fcode_Specified: boolean;
    Fdescription: string;
    Fdescription_Specified: boolean;
    Fdisabled: Boolean;
    Fdisabled_Specified: boolean;
    FcodeParent: string;
    FcodeParent_Specified: boolean;
    Fremove: Boolean;
    Fremove_Specified: boolean;
    FlevelList: levelList;
    FlevelList_Specified: boolean;
    procedure Setcode(Index: Integer; const Astring: string);
    function  code_Specified(Index: Integer): boolean;
    procedure Setdescription(Index: Integer; const Astring: string);
    function  description_Specified(Index: Integer): boolean;
    procedure Setdisabled(Index: Integer; const ABoolean: Boolean);
    function  disabled_Specified(Index: Integer): boolean;
    procedure SetcodeParent(Index: Integer; const Astring: string);
    function  codeParent_Specified(Index: Integer): boolean;
    procedure Setremove(Index: Integer; const ABoolean: Boolean);
    function  remove_Specified(Index: Integer): boolean;
    procedure SetlevelList(Index: Integer; const AlevelList: levelList);
    function  levelList_Specified(Index: Integer): boolean;
  public
    destructor Destroy; override;
  published
    property code:        string     Index (IS_OPTN) read Fcode write Setcode stored code_Specified;
    property description: string     Index (IS_OPTN) read Fdescription write Setdescription stored description_Specified;
    property disabled:    Boolean    Index (IS_OPTN) read Fdisabled write Setdisabled stored disabled_Specified;
    property codeParent:  string     Index (IS_OPTN) read FcodeParent write SetcodeParent stored codeParent_Specified;
    property remove:      Boolean    Index (IS_OPTN) read Fremove write Setremove stored remove_Specified;
    property levelList:   levelList  Index (IS_OPTN) read FlevelList write SetlevelList stored levelList_Specified;
  end;



  // ************************************************************************ //
  // XML       : document, global, <complexType>
  // Namespace : http://insielmercato.it/protocollo-ws/data/common
  // ************************************************************************ //
  document = class(TRemotable)
  private
    Fname_: string;
    Fname__Specified: boolean;
    Fprimary: Boolean;
    Fprimary_Specified: boolean;
    FdocumentRepositoryId: Int64;
    FdocumentRepositoryId_Specified: boolean;
    Fremove: Boolean;
    Fremove_Specified: boolean;
    Fmirror: Boolean;
    Fmirror_Specified: boolean;
    Ffile_: TByteDynArray;
    Ffile__Specified: boolean;
    procedure Setname_(Index: Integer; const Astring: string);
    function  name__Specified(Index: Integer): boolean;
    procedure Setprimary(Index: Integer; const ABoolean: Boolean);
    function  primary_Specified(Index: Integer): boolean;
    procedure SetdocumentRepositoryId(Index: Integer; const AInt64: Int64);
    function  documentRepositoryId_Specified(Index: Integer): boolean;
    procedure Setremove(Index: Integer; const ABoolean: Boolean);
    function  remove_Specified(Index: Integer): boolean;
    procedure Setmirror(Index: Integer; const ABoolean: Boolean);
    function  mirror_Specified(Index: Integer): boolean;
    procedure Setfile_(Index: Integer; const ATByteDynArray: TByteDynArray);
    function  file__Specified(Index: Integer): boolean;
  published
    property name_:                string         Index (IS_OPTN) read Fname_ write Setname_ stored name__Specified;
    property primary:              Boolean        Index (IS_OPTN) read Fprimary write Setprimary stored primary_Specified;
    property documentRepositoryId: Int64          Index (IS_OPTN) read FdocumentRepositoryId write SetdocumentRepositoryId stored documentRepositoryId_Specified;
    property remove:               Boolean        Index (IS_OPTN) read Fremove write Setremove stored remove_Specified;
    property mirror:               Boolean        Index (IS_OPTN) read Fmirror write Setmirror stored mirror_Specified;
    property file_:                TByteDynArray  Index (IS_OPTN) read Ffile_ write Setfile_ stored file__Specified;
  end;



  // ************************************************************************ //
  // XML       : externalDocument, global, <complexType>
  // Namespace : http://insielmercato.it/protocollo-ws/data/common
  // ************************************************************************ //
  externalDocument = class(TRemotable)
  private
    Fname_: string;
    Fname__Specified: boolean;
    Fprimary: Boolean;
    Fprimary_Specified: boolean;
    FdocumentRepositoryId: string;
    FdocumentRepositoryId_Specified: boolean;
    FdocumentRepositoryPath: string;
    FdocumentRepositoryPath_Specified: boolean;
    Fremove: Boolean;
    Fremove_Specified: boolean;
    Fmirror: Boolean;
    Fmirror_Specified: boolean;
    procedure Setname_(Index: Integer; const Astring: string);
    function  name__Specified(Index: Integer): boolean;
    procedure Setprimary(Index: Integer; const ABoolean: Boolean);
    function  primary_Specified(Index: Integer): boolean;
    procedure SetdocumentRepositoryId(Index: Integer; const Astring: string);
    function  documentRepositoryId_Specified(Index: Integer): boolean;
    procedure SetdocumentRepositoryPath(Index: Integer; const Astring: string);
    function  documentRepositoryPath_Specified(Index: Integer): boolean;
    procedure Setremove(Index: Integer; const ABoolean: Boolean);
    function  remove_Specified(Index: Integer): boolean;
    procedure Setmirror(Index: Integer; const ABoolean: Boolean);
    function  mirror_Specified(Index: Integer): boolean;
  published
    property name_:                  string   Index (IS_OPTN) read Fname_ write Setname_ stored name__Specified;
    property primary:                Boolean  Index (IS_OPTN) read Fprimary write Setprimary stored primary_Specified;
    property documentRepositoryId:   string   Index (IS_OPTN) read FdocumentRepositoryId write SetdocumentRepositoryId stored documentRepositoryId_Specified;
    property documentRepositoryPath: string   Index (IS_OPTN) read FdocumentRepositoryPath write SetdocumentRepositoryPath stored documentRepositoryPath_Specified;
    property remove:                 Boolean  Index (IS_OPTN) read Fremove write Setremove stored remove_Specified;
    property mirror:                 Boolean  Index (IS_OPTN) read Fmirror write Setmirror stored mirror_Specified;
  end;



  // ************************************************************************ //
  // XML       : anagraficResponse, global, <complexType>
  // Namespace : http://insielmercato.it/protocollo-ws/data/anagrafic
  // Serializtn: [xoLiteralParam]
  // Info      : Wrapper
  // ************************************************************************ //
  anagraficResponse = class(TRemotable)
  private
    Fresult: Boolean;
    Ferror: error;
    Ferror_Specified: boolean;
    FanagraficList: anagraficList2;
    FanagraficList_Specified: boolean;
    procedure Seterror(Index: Integer; const Aerror: error);
    function  error_Specified(Index: Integer): boolean;
    procedure SetanagraficList(Index: Integer; const AanagraficList2: anagraficList2);
    function  anagraficList_Specified(Index: Integer): boolean;
  public
    constructor Create; override;
    destructor Destroy; override;
  published
    property result:        Boolean         read Fresult write Fresult;
    property error:         error           Index (IS_OPTN) read Ferror write Seterror stored error_Specified;
    property anagraficList: anagraficList2  Index (IS_OPTN) read FanagraficList write SetanagraficList stored anagraficList_Specified;
  end;



  // ************************************************************************ //
  // XML       : anagraficListResponse, global, <element>
  // Namespace : http://insielmercato.it/protocollo-ws/services/protocolloService
  // Info      : Wrapper
  // ************************************************************************ //
  anagraficListResponse = class(anagraficResponse)
  private
  published
  end;



  // ************************************************************************ //
  // XML       : anagrafic, global, <complexType>
  // Namespace : http://insielmercato.it/protocollo-ws/data/common
  // ************************************************************************ //
  anagrafic = class(TRemotable)
  private
    Faddress: string;
    Faddress_Specified: boolean;
    Falias: string;
    Falias_Specified: boolean;
    FanagraficAggCode: string;
    FanagraficAggCode_Specified: boolean;
    FanagraficAggDescription: string;
    FanagraficAggDescription_Specified: boolean;
    FanagraficCode: string;
    FanagraficCode_Specified: boolean;
    FanagraficDescription: string;
    FanagraficDescription_Specified: boolean;
    FanagraficDescription2: string;
    FanagraficDescription2_Specified: boolean;
    FanagraficTypeCode: string;
    FanagraficTypeCode_Specified: boolean;
    FanagraficTypologyCode: string;
    FanagraficTypologyCode_Specified: boolean;
    FbirthDate: TXSDateTime;
    FbirthDate_Specified: boolean;
    FbirthPlace: string;
    FbirthPlace_Specified: boolean;
    FbirthProvince: string;
    FbirthProvince_Specified: boolean;
    Fcap: Integer;
    Fcap_Specified: boolean;
    Fcf: string;
    Fcf_Specified: boolean;
    Fdisabled: Boolean;
    Fdisabled_Specified: boolean;
    Femail: string;
    Femail_Specified: boolean;
    Fgender: string;
    Fgender_Specified: boolean;
    FimportGd: Boolean;
    FimportGd_Specified: boolean;
    Finitials: string;
    Finitials_Specified: boolean;
    FlivAbil: Boolean;
    FlivAbil_Specified: boolean;
    Flocality: string;
    Flocality_Specified: boolean;
    Fname_: string;
    Fname__Specified: boolean;
    FnoTree: Boolean;
    FnoTree_Specified: boolean;
    Fpiva: Int64;
    Fpiva_Specified: boolean;
    Fprovince: string;
    Fprovince_Specified: boolean;
    FqualifyEmployeeCode: string;
    FqualifyEmployeeCode_Specified: boolean;
    Fstate: string;
    Fstate_Specified: boolean;
    Fsurname: string;
    Fsurname_Specified: boolean;
    Ftitle: string;
    Ftitle_Specified: boolean;
    FuseProt: Boolean;
    FuseProt_Specified: boolean;
    procedure Setaddress(Index: Integer; const Astring: string);
    function  address_Specified(Index: Integer): boolean;
    procedure Setalias(Index: Integer; const Astring: string);
    function  alias_Specified(Index: Integer): boolean;
    procedure SetanagraficAggCode(Index: Integer; const Astring: string);
    function  anagraficAggCode_Specified(Index: Integer): boolean;
    procedure SetanagraficAggDescription(Index: Integer; const Astring: string);
    function  anagraficAggDescription_Specified(Index: Integer): boolean;
    procedure SetanagraficCode(Index: Integer; const Astring: string);
    function  anagraficCode_Specified(Index: Integer): boolean;
    procedure SetanagraficDescription(Index: Integer; const Astring: string);
    function  anagraficDescription_Specified(Index: Integer): boolean;
    procedure SetanagraficDescription2(Index: Integer; const Astring: string);
    function  anagraficDescription2_Specified(Index: Integer): boolean;
    procedure SetanagraficTypeCode(Index: Integer; const Astring: string);
    function  anagraficTypeCode_Specified(Index: Integer): boolean;
    procedure SetanagraficTypologyCode(Index: Integer; const Astring: string);
    function  anagraficTypologyCode_Specified(Index: Integer): boolean;
    procedure SetbirthDate(Index: Integer; const ATXSDateTime: TXSDateTime);
    function  birthDate_Specified(Index: Integer): boolean;
    procedure SetbirthPlace(Index: Integer; const Astring: string);
    function  birthPlace_Specified(Index: Integer): boolean;
    procedure SetbirthProvince(Index: Integer; const Astring: string);
    function  birthProvince_Specified(Index: Integer): boolean;
    procedure Setcap(Index: Integer; const AInteger: Integer);
    function  cap_Specified(Index: Integer): boolean;
    procedure Setcf(Index: Integer; const Astring: string);
    function  cf_Specified(Index: Integer): boolean;
    procedure Setdisabled(Index: Integer; const ABoolean: Boolean);
    function  disabled_Specified(Index: Integer): boolean;
    procedure Setemail(Index: Integer; const Astring: string);
    function  email_Specified(Index: Integer): boolean;
    procedure Setgender(Index: Integer; const Astring: string);
    function  gender_Specified(Index: Integer): boolean;
    procedure SetimportGd(Index: Integer; const ABoolean: Boolean);
    function  importGd_Specified(Index: Integer): boolean;
    procedure Setinitials(Index: Integer; const Astring: string);
    function  initials_Specified(Index: Integer): boolean;
    procedure SetlivAbil(Index: Integer; const ABoolean: Boolean);
    function  livAbil_Specified(Index: Integer): boolean;
    procedure Setlocality(Index: Integer; const Astring: string);
    function  locality_Specified(Index: Integer): boolean;
    procedure Setname_(Index: Integer; const Astring: string);
    function  name__Specified(Index: Integer): boolean;
    procedure SetnoTree(Index: Integer; const ABoolean: Boolean);
    function  noTree_Specified(Index: Integer): boolean;
    procedure Setpiva(Index: Integer; const AInt64: Int64);
    function  piva_Specified(Index: Integer): boolean;
    procedure Setprovince(Index: Integer; const Astring: string);
    function  province_Specified(Index: Integer): boolean;
    procedure SetqualifyEmployeeCode(Index: Integer; const Astring: string);
    function  qualifyEmployeeCode_Specified(Index: Integer): boolean;
    procedure Setstate(Index: Integer; const Astring: string);
    function  state_Specified(Index: Integer): boolean;
    procedure Setsurname(Index: Integer; const Astring: string);
    function  surname_Specified(Index: Integer): boolean;
    procedure Settitle(Index: Integer; const Astring: string);
    function  title_Specified(Index: Integer): boolean;
    procedure SetuseProt(Index: Integer; const ABoolean: Boolean);
    function  useProt_Specified(Index: Integer): boolean;
  public
    destructor Destroy; override;
  published
    property address:                 string       Index (IS_OPTN) read Faddress write Setaddress stored address_Specified;
    property alias:                   string       Index (IS_OPTN) read Falias write Setalias stored alias_Specified;
    property anagraficAggCode:        string       Index (IS_OPTN) read FanagraficAggCode write SetanagraficAggCode stored anagraficAggCode_Specified;
    property anagraficAggDescription: string       Index (IS_OPTN) read FanagraficAggDescription write SetanagraficAggDescription stored anagraficAggDescription_Specified;
    property anagraficCode:           string       Index (IS_OPTN) read FanagraficCode write SetanagraficCode stored anagraficCode_Specified;
    property anagraficDescription:    string       Index (IS_OPTN) read FanagraficDescription write SetanagraficDescription stored anagraficDescription_Specified;
    property anagraficDescription2:   string       Index (IS_OPTN) read FanagraficDescription2 write SetanagraficDescription2 stored anagraficDescription2_Specified;
    property anagraficTypeCode:       string       Index (IS_OPTN) read FanagraficTypeCode write SetanagraficTypeCode stored anagraficTypeCode_Specified;
    property anagraficTypologyCode:   string       Index (IS_OPTN) read FanagraficTypologyCode write SetanagraficTypologyCode stored anagraficTypologyCode_Specified;
    property birthDate:               TXSDateTime  Index (IS_OPTN) read FbirthDate write SetbirthDate stored birthDate_Specified;
    property birthPlace:              string       Index (IS_OPTN) read FbirthPlace write SetbirthPlace stored birthPlace_Specified;
    property birthProvince:           string       Index (IS_OPTN) read FbirthProvince write SetbirthProvince stored birthProvince_Specified;
    property cap:                     Integer      Index (IS_OPTN) read Fcap write Setcap stored cap_Specified;
    property cf:                      string       Index (IS_OPTN) read Fcf write Setcf stored cf_Specified;
    property disabled:                Boolean      Index (IS_OPTN) read Fdisabled write Setdisabled stored disabled_Specified;
    property email:                   string       Index (IS_OPTN) read Femail write Setemail stored email_Specified;
    property gender:                  string       Index (IS_OPTN) read Fgender write Setgender stored gender_Specified;
    property importGd:                Boolean      Index (IS_OPTN) read FimportGd write SetimportGd stored importGd_Specified;
    property initials:                string       Index (IS_OPTN) read Finitials write Setinitials stored initials_Specified;
    property livAbil:                 Boolean      Index (IS_OPTN) read FlivAbil write SetlivAbil stored livAbil_Specified;
    property locality:                string       Index (IS_OPTN) read Flocality write Setlocality stored locality_Specified;
    property name_:                   string       Index (IS_OPTN) read Fname_ write Setname_ stored name__Specified;
    property noTree:                  Boolean      Index (IS_OPTN) read FnoTree write SetnoTree stored noTree_Specified;
    property piva:                    Int64        Index (IS_OPTN) read Fpiva write Setpiva stored piva_Specified;
    property province:                string       Index (IS_OPTN) read Fprovince write Setprovince stored province_Specified;
    property qualifyEmployeeCode:     string       Index (IS_OPTN) read FqualifyEmployeeCode write SetqualifyEmployeeCode stored qualifyEmployeeCode_Specified;
    property state:                   string       Index (IS_OPTN) read Fstate write Setstate stored state_Specified;
    property surname:                 string       Index (IS_OPTN) read Fsurname write Setsurname stored surname_Specified;
    property title:                   string       Index (IS_OPTN) read Ftitle write Settitle stored title_Specified;
    property useProt:                 Boolean      Index (IS_OPTN) read FuseProt write SetuseProt stored useProt_Specified;
  end;



  // ************************************************************************ //
  // XML       : correspondent, global, <complexType>
  // Namespace : http://insielmercato.it/protocollo-ws/data/common
  // ************************************************************************ //
  correspondent = class(TRemotable)
  private
    Fcode: string;
    Fcode_Specified: boolean;
    Fdescription: string;
    Fdescription_Specified: boolean;
    FreferenceDate: TXSDateTime;
    FreferenceDate_Specified: boolean;
    FreferenceNumber: string;
    FreferenceNumber_Specified: boolean;
    Fnote: string;
    Fnote_Specified: boolean;
    FtransmissionMode: string;
    FtransmissionMode_Specified: boolean;
    FtypeCode: string;
    FtypeCode_Specified: boolean;
    FtypeDesc: string;
    FtypeDesc_Specified: boolean;
    Fremove: Boolean;
    Fremove_Specified: boolean;
    procedure Setcode(Index: Integer; const Astring: string);
    function  code_Specified(Index: Integer): boolean;
    procedure Setdescription(Index: Integer; const Astring: string);
    function  description_Specified(Index: Integer): boolean;
    procedure SetreferenceDate(Index: Integer; const ATXSDateTime: TXSDateTime);
    function  referenceDate_Specified(Index: Integer): boolean;
    procedure SetreferenceNumber(Index: Integer; const Astring: string);
    function  referenceNumber_Specified(Index: Integer): boolean;
    procedure Setnote(Index: Integer; const Astring: string);
    function  note_Specified(Index: Integer): boolean;
    procedure SettransmissionMode(Index: Integer; const Astring: string);
    function  transmissionMode_Specified(Index: Integer): boolean;
    procedure SettypeCode(Index: Integer; const Astring: string);
    function  typeCode_Specified(Index: Integer): boolean;
    procedure SettypeDesc(Index: Integer; const Astring: string);
    function  typeDesc_Specified(Index: Integer): boolean;
    procedure Setremove(Index: Integer; const ABoolean: Boolean);
    function  remove_Specified(Index: Integer): boolean;
  public
    destructor Destroy; override;
  published
    property code:             string       Index (IS_OPTN) read Fcode write Setcode stored code_Specified;
    property description:      string       Index (IS_OPTN) read Fdescription write Setdescription stored description_Specified;
    property referenceDate:    TXSDateTime  Index (IS_OPTN) read FreferenceDate write SetreferenceDate stored referenceDate_Specified;
    property referenceNumber:  string       Index (IS_OPTN) read FreferenceNumber write SetreferenceNumber stored referenceNumber_Specified;
    property note:             string       Index (IS_OPTN) read Fnote write Setnote stored note_Specified;
    property transmissionMode: string       Index (IS_OPTN) read FtransmissionMode write SettransmissionMode stored transmissionMode_Specified;
    property typeCode:         string       Index (IS_OPTN) read FtypeCode write SettypeCode stored typeCode_Specified;
    property typeDesc:         string       Index (IS_OPTN) read FtypeDesc write SettypeDesc stored typeDesc_Specified;
    property remove:           Boolean      Index (IS_OPTN) read Fremove write Setremove stored remove_Specified;
  end;



  // ************************************************************************ //
  // XML       : office, global, <complexType>
  // Namespace : http://insielmercato.it/protocollo-ws/data/common
  // ************************************************************************ //
  office = class(correspondent)
  private
    FmailSend: Boolean;
    FmailSend_Specified: boolean;
    FmailAttachment: Boolean;
    FmailAttachment_Specified: boolean;
    FmailCarbonCopy: Boolean;
    FmailCarbonCopy_Specified: boolean;
    FmailConfirmationReceipt: Boolean;
    FmailConfirmationReceipt_Specified: boolean;
    procedure SetmailSend(Index: Integer; const ABoolean: Boolean);
    function  mailSend_Specified(Index: Integer): boolean;
    procedure SetmailAttachment(Index: Integer; const ABoolean: Boolean);
    function  mailAttachment_Specified(Index: Integer): boolean;
    procedure SetmailCarbonCopy(Index: Integer; const ABoolean: Boolean);
    function  mailCarbonCopy_Specified(Index: Integer): boolean;
    procedure SetmailConfirmationReceipt(Index: Integer; const ABoolean: Boolean);
    function  mailConfirmationReceipt_Specified(Index: Integer): boolean;
  published
    property mailSend:                Boolean  Index (IS_OPTN) read FmailSend write SetmailSend stored mailSend_Specified;
    property mailAttachment:          Boolean  Index (IS_OPTN) read FmailAttachment write SetmailAttachment stored mailAttachment_Specified;
    property mailCarbonCopy:          Boolean  Index (IS_OPTN) read FmailCarbonCopy write SetmailCarbonCopy stored mailCarbonCopy_Specified;
    property mailConfirmationReceipt: Boolean  Index (IS_OPTN) read FmailConfirmationReceipt write SetmailConfirmationReceipt stored mailConfirmationReceipt_Specified;
  end;



  // ************************************************************************ //
  // XML       : filingResponse, global, <complexType>
  // Namespace : http://insielmercato.it/protocollo-ws/data/filing
  // Serializtn: [xoLiteralParam]
  // Info      : Wrapper
  // ************************************************************************ //
  filingResponse = class(TRemotable)
  private
    Fresult: Boolean;
    Ferror: error;
    Ferror_Specified: boolean;
    FfilingList: filingList2;
    FfilingList_Specified: boolean;
    procedure Seterror(Index: Integer; const Aerror: error);
    function  error_Specified(Index: Integer): boolean;
    procedure SetfilingList(Index: Integer; const AfilingList2: filingList2);
    function  filingList_Specified(Index: Integer): boolean;
  public
    constructor Create; override;
    destructor Destroy; override;
  published
    property result:     Boolean      read Fresult write Fresult;
    property error:      error        Index (IS_OPTN) read Ferror write Seterror stored error_Specified;
    property filingList: filingList2  Index (IS_OPTN) read FfilingList write SetfilingList stored filingList_Specified;
  end;



  // ************************************************************************ //
  // XML       : filingListResponse, global, <element>
  // Namespace : http://insielmercato.it/protocollo-ws/services/protocolloService
  // Info      : Wrapper
  // ************************************************************************ //
  filingListResponse = class(filingResponse)
  private
  published
  end;



  // ************************************************************************ //
  // XML       : registry, global, <complexType>
  // Namespace : http://insielmercato.it/protocollo-ws/data/common
  // ************************************************************************ //
  registry = class(TRemotable)
  private
    FdefaultRegistry: Boolean;
    Fcode: string;
    Fcode_Specified: boolean;
    Fdescription: string;
    Fdescription_Specified: boolean;
    procedure Setcode(Index: Integer; const Astring: string);
    function  code_Specified(Index: Integer): boolean;
    procedure Setdescription(Index: Integer; const Astring: string);
    function  description_Specified(Index: Integer): boolean;
  published
    property defaultRegistry: Boolean  Index (IS_ATTR) read FdefaultRegistry write FdefaultRegistry;
    property code:            string   Index (IS_OPTN) read Fcode write Setcode stored code_Specified;
    property description:     string   Index (IS_OPTN) read Fdescription write Setdescription stored description_Specified;
  end;



  // ************************************************************************ //
  // XML       : officeBasicInformation, global, <complexType>
  // Namespace : http://insielmercato.it/protocollo-ws/data/common
  // ************************************************************************ //
  officeBasicInformation = class(TRemotable)
  private
    FdefaultOffice: Boolean;
    Fcode: string;
    Fdescription: string;
    FregistryList: registryList;
    FregistryList_Specified: boolean;
    procedure SetregistryList(Index: Integer; const AregistryList: registryList);
    function  registryList_Specified(Index: Integer): boolean;
  public
    destructor Destroy; override;
  published
    property defaultOffice: Boolean       Index (IS_ATTR) read FdefaultOffice write FdefaultOffice;
    property code:          string        read Fcode write Fcode;
    property description:   string        read Fdescription write Fdescription;
    property registryList:  registryList  Index (IS_OPTN) read FregistryList write SetregistryList stored registryList_Specified;
  end;



  // ************************************************************************ //
  // XML       : documentDetails, global, <complexType>
  // Namespace : http://insielmercato.it/protocollo-ws/data/common
  // ************************************************************************ //
  documentDetails = class(TRemotable)
  private
    Fnumber: string;
    Fnumber_Specified: boolean;
    Fdate: TXSDateTime;
    Fdate_Specified: boolean;
    Fyear: Integer;
    Fyear_Specified: boolean;
    FdocumentTypeCode: string;
    FdocumentTypeCode_Specified: boolean;
    procedure Setnumber(Index: Integer; const Astring: string);
    function  number_Specified(Index: Integer): boolean;
    procedure Setdate(Index: Integer; const ATXSDateTime: TXSDateTime);
    function  date_Specified(Index: Integer): boolean;
    procedure Setyear(Index: Integer; const AInteger: Integer);
    function  year_Specified(Index: Integer): boolean;
    procedure SetdocumentTypeCode(Index: Integer; const Astring: string);
    function  documentTypeCode_Specified(Index: Integer): boolean;
  public
    destructor Destroy; override;
  published
    property number:           string       Index (IS_OPTN) read Fnumber write Setnumber stored number_Specified;
    property date:             TXSDateTime  Index (IS_OPTN) read Fdate write Setdate stored date_Specified;
    property year:             Integer      Index (IS_OPTN) read Fyear write Setyear stored year_Specified;
    property documentTypeCode: string       Index (IS_OPTN) read FdocumentTypeCode write SetdocumentTypeCode stored documentTypeCode_Specified;
  end;



  // ************************************************************************ //
  // XML       : measureDetails, global, <complexType>
  // Namespace : http://insielmercato.it/protocollo-ws/data/common
  // ************************************************************************ //
  measureDetails = class(TRemotable)
  private
    Fdate: TXSDateTime;
    Fdate_Specified: boolean;
    Fdetails: string;
    Fdetails_Specified: boolean;
    Fcause: string;
    Fcause_Specified: boolean;
    procedure Setdate(Index: Integer; const ATXSDateTime: TXSDateTime);
    function  date_Specified(Index: Integer): boolean;
    procedure Setdetails(Index: Integer; const Astring: string);
    function  details_Specified(Index: Integer): boolean;
    procedure Setcause(Index: Integer; const Astring: string);
    function  cause_Specified(Index: Integer): boolean;
  public
    destructor Destroy; override;
  published
    property date:    TXSDateTime  Index (IS_OPTN) read Fdate write Setdate stored date_Specified;
    property details: string       Index (IS_OPTN) read Fdetails write Setdetails stored details_Specified;
    property cause:   string       Index (IS_OPTN) read Fcause write Setcause stored cause_Specified;
  end;



  // ************************************************************************ //
  // XML       : dossier, global, <complexType>
  // Namespace : http://insielmercato.it/protocollo-ws/data/common
  // ************************************************************************ //
  dossier = class(recordIdentifier)
  private
    Fremove: Boolean;
    Fremove_Specified: boolean;
    procedure Setremove(Index: Integer; const ABoolean: Boolean);
    function  remove_Specified(Index: Integer): boolean;
  published
    property remove: Boolean  Index (IS_OPTN) read Fremove write Setremove stored remove_Specified;
  end;

  documentList3 = array of document;            { "http://insielmercato.it/protocollo-ws/data/protocol"[Cplx] }
  externalDocumentList3 = array of externalDocument;   { "http://insielmercato.it/protocollo-ws/data/protocol"[Cplx] }
  officeList4 = array of office;                { "http://insielmercato.it/protocollo-ws/data/protocol"[Cplx] }
  recipientList2 = array of recipient;          { "http://insielmercato.it/protocollo-ws/data/protocol"[Cplx] }


  // ************************************************************************ //
  // XML       : recipient, global, <complexType>
  // Namespace : http://insielmercato.it/protocollo-ws/data/common
  // ************************************************************************ //
  recipient = class(correspondent)
  private
    FiopSend: Boolean;
    FiopSend_Specified: boolean;
    FiopUpdateNotification: Boolean;
    FiopUpdateNotification_Specified: boolean;
    FiopConfirmationReceipt: Boolean;
    FiopConfirmationReceipt_Specified: boolean;
    FmailSend: Boolean;
    FmailSend_Specified: boolean;
    FmailAttachment: Boolean;
    FmailAttachment_Specified: boolean;
    FmailCarbonCopy: Boolean;
    FmailCarbonCopy_Specified: boolean;
    FmailConfirmationReceipt: Boolean;
    FmailConfirmationReceipt_Specified: boolean;
    procedure SetiopSend(Index: Integer; const ABoolean: Boolean);
    function  iopSend_Specified(Index: Integer): boolean;
    procedure SetiopUpdateNotification(Index: Integer; const ABoolean: Boolean);
    function  iopUpdateNotification_Specified(Index: Integer): boolean;
    procedure SetiopConfirmationReceipt(Index: Integer; const ABoolean: Boolean);
    function  iopConfirmationReceipt_Specified(Index: Integer): boolean;
    procedure SetmailSend(Index: Integer; const ABoolean: Boolean);
    function  mailSend_Specified(Index: Integer): boolean;
    procedure SetmailAttachment(Index: Integer; const ABoolean: Boolean);
    function  mailAttachment_Specified(Index: Integer): boolean;
    procedure SetmailCarbonCopy(Index: Integer; const ABoolean: Boolean);
    function  mailCarbonCopy_Specified(Index: Integer): boolean;
    procedure SetmailConfirmationReceipt(Index: Integer; const ABoolean: Boolean);
    function  mailConfirmationReceipt_Specified(Index: Integer): boolean;
  published
    property iopSend:                 Boolean  Index (IS_OPTN) read FiopSend write SetiopSend stored iopSend_Specified;
    property iopUpdateNotification:   Boolean  Index (IS_OPTN) read FiopUpdateNotification write SetiopUpdateNotification stored iopUpdateNotification_Specified;
    property iopConfirmationReceipt:  Boolean  Index (IS_OPTN) read FiopConfirmationReceipt write SetiopConfirmationReceipt stored iopConfirmationReceipt_Specified;
    property mailSend:                Boolean  Index (IS_OPTN) read FmailSend write SetmailSend stored mailSend_Specified;
    property mailAttachment:          Boolean  Index (IS_OPTN) read FmailAttachment write SetmailAttachment stored mailAttachment_Specified;
    property mailCarbonCopy:          Boolean  Index (IS_OPTN) read FmailCarbonCopy write SetmailCarbonCopy stored mailCarbonCopy_Specified;
    property mailConfirmationReceipt: Boolean  Index (IS_OPTN) read FmailConfirmationReceipt write SetmailConfirmationReceipt stored mailConfirmationReceipt_Specified;
  end;

  filingList5 = array of filing;                { "http://insielmercato.it/protocollo-ws/data/protocol"[Cplx] }


  // ************************************************************************ //
  // XML       : protocolDetailRequest, global, <complexType>
  // Namespace : http://insielmercato.it/protocollo-ws/data/protocol
  // Serializtn: [xoLiteralParam]
  // Info      : Wrapper
  // ************************************************************************ //
  protocolDetailRequest = class(TRemotable)
  private
    Fuser: user;
    FrecordIdentifier: recordIdentifier;
  public
    constructor Create; override;
    destructor Destroy; override;
  published
    property user:             user              read Fuser write Fuser;
    property recordIdentifier: recordIdentifier  read FrecordIdentifier write FrecordIdentifier;
  end;



  // ************************************************************************ //
  // XML       : protocolDetail, global, <element>
  // Namespace : http://insielmercato.it/protocollo-ws/services/protocolloService
  // Info      : Wrapper
  // ************************************************************************ //
  protocolDetail = class(protocolDetailRequest)
  private
  published
  end;



  // ************************************************************************ //
  // XML       : protocolDetailResponse, global, <complexType>
  // Namespace : http://insielmercato.it/protocollo-ws/data/protocol
  // Serializtn: [xoLiteralParam]
  // Info      : Wrapper
  // ************************************************************************ //
  protocolDetailResponse2 = class(TRemotable)
  private
    Fresult: Boolean;
    Ferror: error;
    Ferror_Specified: boolean;
    FprotocolDetail: protocolDetail2;
    procedure Seterror(Index: Integer; const Aerror: error);
    function  error_Specified(Index: Integer): boolean;
  public
    constructor Create; override;
    destructor Destroy; override;
  published
    property result:         Boolean          read Fresult write Fresult;
    property error:          error            Index (IS_OPTN) read Ferror write Seterror stored error_Specified;
    property protocolDetail: protocolDetail2  read FprotocolDetail write FprotocolDetail;
  end;



  // ************************************************************************ //
  // XML       : protocolDetailResponse, global, <element>
  // Namespace : http://insielmercato.it/protocollo-ws/services/protocolloService
  // Info      : Wrapper
  // ************************************************************************ //
  protocolDetailResponse = class(protocolDetailResponse2)
  private
  published
  end;

  dossierList3 = array of dossier;              { "http://insielmercato.it/protocollo-ws/data/protocol"[Cplx] }
  mnemonicList3 = array of mnemonic;            { "http://insielmercato.it/protocollo-ws/data/protocol"[Cplx] }
  previousList3 = array of previous;            { "http://insielmercato.it/protocollo-ws/data/protocol"[Cplx] }


  // ************************************************************************ //
  // XML       : availableOfficesAndRegistriesRequest, global, <complexType>
  // Namespace : http://insielmercato.it/protocollo-ws/data/protocol
  // Serializtn: [xoLiteralParam]
  // Info      : Wrapper
  // ************************************************************************ //
  availableOfficesAndRegistriesRequest = class(TRemotable)
  private
    Fuser: user;
  public
    constructor Create; override;
    destructor Destroy; override;
  published
    property user: user  read Fuser write Fuser;
  end;



  // ************************************************************************ //
  // XML       : availableOfficesAndRegistries, global, <element>
  // Namespace : http://insielmercato.it/protocollo-ws/services/protocolloService
  // Info      : Wrapper
  // ************************************************************************ //
  availableOfficesAndRegistries = class(availableOfficesAndRegistriesRequest)
  private
  published
  end;

  recordIdentifierList = array of recordIdentifier;   { "http://insielmercato.it/protocollo-ws/data/protocol"[Cplx] }


  // ************************************************************************ //
  // XML       : protocolResponse, global, <complexType>
  // Namespace : http://insielmercato.it/protocollo-ws/data/protocol
  // Serializtn: [xoLiteralParam]
  // Info      : Wrapper
  // ************************************************************************ //
  protocolResponse = class(TRemotable)
  private
    Fresult: Boolean;
    Ferror: error;
    Ferror_Specified: boolean;
    FrecordIdentifierList: recordIdentifierList;
    FrecordIdentifierList_Specified: boolean;
    procedure Seterror(Index: Integer; const Aerror: error);
    function  error_Specified(Index: Integer): boolean;
    procedure SetrecordIdentifierList(Index: Integer; const ArecordIdentifierList: recordIdentifierList);
    function  recordIdentifierList_Specified(Index: Integer): boolean;
  public
    constructor Create; override;
    destructor Destroy; override;
  published
    property result:               Boolean               read Fresult write Fresult;
    property error:                error                 Index (IS_OPTN) read Ferror write Seterror stored error_Specified;
    property recordIdentifierList: recordIdentifierList  Index (IS_OPTN) read FrecordIdentifierList write SetrecordIdentifierList stored recordIdentifierList_Specified;
  end;



  // ************************************************************************ //
  // XML       : protocolListResponse, global, <element>
  // Namespace : http://insielmercato.it/protocollo-ws/services/protocolloService
  // Info      : Wrapper
  // ************************************************************************ //
  protocolListResponse = class(protocolResponse)
  private
  published
  end;



  // ************************************************************************ //
  // XML       : protocolUpdateResponse, global, <element>
  // Namespace : http://insielmercato.it/protocollo-ws/services/protocolloService
  // Info      : Wrapper
  // ************************************************************************ //
  protocolUpdateResponse = class(protocolResponse)
  private
  published
  end;



  // ************************************************************************ //
  // XML       : protocolInsertResponse, global, <element>
  // Namespace : http://insielmercato.it/protocollo-ws/services/protocolloService
  // Info      : Wrapper
  // ************************************************************************ //
  protocolInsertResponse = class(protocolResponse)
  private
  published
  end;



  // ************************************************************************ //
  // XML       : error, global, <complexType>
  // Namespace : http://insielmercato.it/protocollo-ws/data/common
  // ************************************************************************ //
  error = class(TRemotable)
  private
    Fcode: string;
    Fcode_Specified: boolean;
    Fdescription: string;
    Fdescription_Specified: boolean;
    procedure Setcode(Index: Integer; const Astring: string);
    function  code_Specified(Index: Integer): boolean;
    procedure Setdescription(Index: Integer; const Astring: string);
    function  description_Specified(Index: Integer): boolean;
  published
    property code:        string  Index (IS_OPTN) read Fcode write Setcode stored code_Specified;
    property description: string  Index (IS_OPTN) read Fdescription write Setdescription stored description_Specified;
  end;

  operatingOfficeList = array of operatingOfficeBasicInformation;   { "http://insielmercato.it/protocollo-ws/data/protocol"[Cplx] }


  // ************************************************************************ //
  // XML       : availableOfficesAndRegistriesResponse, global, <complexType>
  // Namespace : http://insielmercato.it/protocollo-ws/data/protocol
  // Serializtn: [xoLiteralParam]
  // Info      : Wrapper
  // ************************************************************************ //
  availableOfficesAndRegistriesResponse2 = class(TRemotable)
  private
    Fuser: user;
    Fresult: Boolean;
    Fresult_Specified: boolean;
    Ferror: error;
    Ferror_Specified: boolean;
    FoperatingOfficeList: operatingOfficeList;
    FoperatingOfficeList_Specified: boolean;
    procedure Setresult(Index: Integer; const ABoolean: Boolean);
    function  result_Specified(Index: Integer): boolean;
    procedure Seterror(Index: Integer; const Aerror: error);
    function  error_Specified(Index: Integer): boolean;
    procedure SetoperatingOfficeList(Index: Integer; const AoperatingOfficeList: operatingOfficeList);
    function  operatingOfficeList_Specified(Index: Integer): boolean;
  public
    constructor Create; override;
    destructor Destroy; override;
  published
    property user:                user                 read Fuser write Fuser;
    property result:              Boolean              Index (IS_OPTN) read Fresult write Setresult stored result_Specified;
    property error:               error                Index (IS_OPTN) read Ferror write Seterror stored error_Specified;
    property operatingOfficeList: operatingOfficeList  Index (IS_OPTN) read FoperatingOfficeList write SetoperatingOfficeList stored operatingOfficeList_Specified;
  end;



  // ************************************************************************ //
  // XML       : availableOfficesAndRegistriesResponse, global, <element>
  // Namespace : http://insielmercato.it/protocollo-ws/services/protocolloService
  // Info      : Wrapper
  // ************************************************************************ //
  availableOfficesAndRegistriesResponse = class(availableOfficesAndRegistriesResponse2)
  private
  published
  end;

  senderList2 = array of sender;                { "http://insielmercato.it/protocollo-ws/data/protocol"[Cplx] }


  // ************************************************************************ //
  // XML       : sender, global, <complexType>
  // Namespace : http://insielmercato.it/protocollo-ws/data/common
  // ************************************************************************ //
  sender = class(correspondent)
  private
  published
  end;



  // ************************************************************************ //
  // XML       : operatingOfficeBasicInformation, global, <complexType>
  // Namespace : http://insielmercato.it/protocollo-ws/data/common
  // ************************************************************************ //
  operatingOfficeBasicInformation = class(TRemotable)
  private
    Fcode: string;
    Fdescription: string;
    FofficeList: officeList;
    FofficeList_Specified: boolean;
    procedure SetofficeList(Index: Integer; const AofficeList: officeList);
    function  officeList_Specified(Index: Integer): boolean;
  public
    destructor Destroy; override;
  published
    property code:        string      read Fcode write Fcode;
    property description: string      read Fdescription write Fdescription;
    property officeList:  officeList  Index (IS_OPTN) read FofficeList write SetofficeList stored officeList_Specified;
  end;



  // ************************************************************************ //
  // XML       : protocolInsertRequest, global, <complexType>
  // Namespace : http://insielmercato.it/protocollo-ws/data/protocol
  // Serializtn: [xoLiteralParam]
  // Info      : Wrapper
  // ************************************************************************ //
  protocolInsertRequest = class(TRemotable)
  private
    Fuser: user;
    FoperatingOfficeCode: string;
    FofficeCode: string;
    FregisterCode: string;
    Fdirection: direction2;
    FsequenceCode: string;
    FsubjectDocument: string;
    FsubjectDocument_Specified: boolean;
    FsubjectProtocol: string;
    FsubjectProtocol_Specified: boolean;
    FreceptionSendingDate: TXSDateTime;
    FreceptionSendingDate_Specified: boolean;
    FtypeSenderMail: Integer;
    FtypeSenderMail_Specified: boolean;
    FdocumentDetails: documentDetails;
    FdocumentDetails_Specified: boolean;
    FprocessAct: Boolean;
    FprocessAct_Specified: boolean;
    FretrieveAttachments: recordIdentifier;
    FretrieveAttachments_Specified: boolean;
    FsenderList: senderList2;
    FsenderList_Specified: boolean;
    FrecipientList: recipientList2;
    FrecipientList_Specified: boolean;
    FofficeList: officeList4;
    FofficeList_Specified: boolean;
    FdocumentList: documentList3;
    FdocumentList_Specified: boolean;
    FexternalDocumentList: externalDocumentList3;
    FexternalDocumentList_Specified: boolean;
    FfilingList: filingList5;
    FfilingList_Specified: boolean;
    FmnemonicList: mnemonicList3;
    FmnemonicList_Specified: boolean;
    FpreviousList: previousList3;
    FpreviousList_Specified: boolean;
    FdossierList: dossierList3;
    FdossierList_Specified: boolean;
    procedure SetsubjectDocument(Index: Integer; const Astring: string);
    function  subjectDocument_Specified(Index: Integer): boolean;
    procedure SetsubjectProtocol(Index: Integer; const Astring: string);
    function  subjectProtocol_Specified(Index: Integer): boolean;
    procedure SetreceptionSendingDate(Index: Integer; const ATXSDateTime: TXSDateTime);
    function  receptionSendingDate_Specified(Index: Integer): boolean;
    procedure SettypeSenderMail(Index: Integer; const AInteger: Integer);
    function  typeSenderMail_Specified(Index: Integer): boolean;
    procedure SetdocumentDetails(Index: Integer; const AdocumentDetails: documentDetails);
    function  documentDetails_Specified(Index: Integer): boolean;
    procedure SetprocessAct(Index: Integer; const ABoolean: Boolean);
    function  processAct_Specified(Index: Integer): boolean;
    procedure SetretrieveAttachments(Index: Integer; const ArecordIdentifier: recordIdentifier);
    function  retrieveAttachments_Specified(Index: Integer): boolean;
    procedure SetsenderList(Index: Integer; const AsenderList2: senderList2);
    function  senderList_Specified(Index: Integer): boolean;
    procedure SetrecipientList(Index: Integer; const ArecipientList2: recipientList2);
    function  recipientList_Specified(Index: Integer): boolean;
    procedure SetofficeList(Index: Integer; const AofficeList4: officeList4);
    function  officeList_Specified(Index: Integer): boolean;
    procedure SetdocumentList(Index: Integer; const AdocumentList3: documentList3);
    function  documentList_Specified(Index: Integer): boolean;
    procedure SetexternalDocumentList(Index: Integer; const AexternalDocumentList3: externalDocumentList3);
    function  externalDocumentList_Specified(Index: Integer): boolean;
    procedure SetfilingList(Index: Integer; const AfilingList5: filingList5);
    function  filingList_Specified(Index: Integer): boolean;
    procedure SetmnemonicList(Index: Integer; const AmnemonicList3: mnemonicList3);
    function  mnemonicList_Specified(Index: Integer): boolean;
    procedure SetpreviousList(Index: Integer; const ApreviousList3: previousList3);
    function  previousList_Specified(Index: Integer): boolean;
    procedure SetdossierList(Index: Integer; const AdossierList3: dossierList3);
    function  dossierList_Specified(Index: Integer): boolean;
  public
    constructor Create; override;
    destructor Destroy; override;
  published
    property user:                 user                   read Fuser write Fuser;
    property operatingOfficeCode:  string                 read FoperatingOfficeCode write FoperatingOfficeCode;
    property officeCode:           string                 read FofficeCode write FofficeCode;
    property registerCode:         string                 read FregisterCode write FregisterCode;
    property direction:            direction2             read Fdirection write Fdirection;
    property sequenceCode:         string                 read FsequenceCode write FsequenceCode;
    property subjectDocument:      string                 Index (IS_OPTN) read FsubjectDocument write SetsubjectDocument stored subjectDocument_Specified;
    property subjectProtocol:      string                 Index (IS_OPTN) read FsubjectProtocol write SetsubjectProtocol stored subjectProtocol_Specified;
    property receptionSendingDate: TXSDateTime            Index (IS_OPTN) read FreceptionSendingDate write SetreceptionSendingDate stored receptionSendingDate_Specified;
    property typeSenderMail:       Integer                Index (IS_OPTN) read FtypeSenderMail write SettypeSenderMail stored typeSenderMail_Specified;
    property documentDetails:      documentDetails        Index (IS_OPTN) read FdocumentDetails write SetdocumentDetails stored documentDetails_Specified;
    property processAct:           Boolean                Index (IS_OPTN) read FprocessAct write SetprocessAct stored processAct_Specified;
    property retrieveAttachments:  recordIdentifier       Index (IS_OPTN) read FretrieveAttachments write SetretrieveAttachments stored retrieveAttachments_Specified;
    property senderList:           senderList2            Index (IS_OPTN) read FsenderList write SetsenderList stored senderList_Specified;
    property recipientList:        recipientList2         Index (IS_OPTN) read FrecipientList write SetrecipientList stored recipientList_Specified;
    property officeList:           officeList4            Index (IS_OPTN) read FofficeList write SetofficeList stored officeList_Specified;
    property documentList:         documentList3          Index (IS_OPTN) read FdocumentList write SetdocumentList stored documentList_Specified;
    property externalDocumentList: externalDocumentList3  Index (IS_OPTN) read FexternalDocumentList write SetexternalDocumentList stored externalDocumentList_Specified;
    property filingList:           filingList5            Index (IS_OPTN) read FfilingList write SetfilingList stored filingList_Specified;
    property mnemonicList:         mnemonicList3          Index (IS_OPTN) read FmnemonicList write SetmnemonicList stored mnemonicList_Specified;
    property previousList:         previousList3          Index (IS_OPTN) read FpreviousList write SetpreviousList stored previousList_Specified;
    property dossierList:          dossierList3           Index (IS_OPTN) read FdossierList write SetdossierList stored dossierList_Specified;
  end;



  // ************************************************************************ //
  // XML       : protocolInsert, global, <element>
  // Namespace : http://insielmercato.it/protocollo-ws/services/protocolloService
  // Info      : Wrapper
  // ************************************************************************ //
  protocolInsert = class(protocolInsertRequest)
  private
  published
  end;


  // ************************************************************************ //
  // Namespace : http://insielmercato.it/protocollo-ws/services/protocolloService
  // soapAction: ProtocolloServicePortType#%operationName%
  // transport : http://schemas.xmlsoap.org/soap/http
  // style     : document
  // use       : literal
  // binding   : protocolloServiceSoapBinding
  // service   : protocolloService
  // port      : protocollo
  // URL       : http://172.16.12.190:8080/InsielProtocolloWS1.10/wsdl_protocollo/protocolloService
  // ************************************************************************ //
  ProtocolloServicePortType = interface(IInvokable)
  ['{5098494A-78F6-3630-A213-9322C1DC267E}']

    // Cannot unwrap: 
    //     - More than one strictly out element was found
    function  filingList(const filingList: filingList): filingListResponse; stdcall;

    // Cannot unwrap: 
    //     - More than one strictly out element was found
    function  protocolUpdate(const protocolUpdate: protocolUpdate): protocolUpdateResponse; stdcall;

    // Cannot unwrap: 
    //     - More than one strictly out element was found
    function  availableOfficesAndRegistries(const availableOfficesAndRegistries: availableOfficesAndRegistries): availableOfficesAndRegistriesResponse; stdcall;

    // Cannot unwrap: 
    //     - More than one strictly out element was found
    function  protocolInsert(const protocolInsert: protocolInsert): protocolInsertResponse; stdcall;

    // Cannot unwrap: 
    //     - More than one strictly out element was found
    function  protocolDetail(const protocolDetail: protocolDetail): protocolDetailResponse; stdcall;

    // Cannot unwrap: 
    //     - More than one strictly out element was found
    function  anagraficList(const anagraficList: anagraficList): anagraficListResponse; stdcall;

    // Cannot unwrap: 
    //     - More than one strictly out element was found
    function  protocolList(const protocolList: protocolList): protocolListResponse; stdcall;
  end;

function GetProtocolloServicePortType(UseWSDL: Boolean=System.False; Addr: string=''; HTTPRIO: THTTPRIO = nil): ProtocolloServicePortType;


implementation
  uses SysUtils;

function GetProtocolloServicePortType(UseWSDL: Boolean; Addr: string; HTTPRIO: THTTPRIO): ProtocolloServicePortType;
const
  defWSDL = 'Y:\Aosta_Regione\Valutazioni\protocolloService.xml';
  defURL  = 'http://172.16.12.190:8080/InsielProtocolloWS1.10/wsdl_protocollo/protocolloService';
  defSvc  = 'protocolloService';
  defPrt  = 'protocollo';
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
    Result := (RIO as ProtocolloServicePortType);
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


constructor filingRequest.Create;
begin
  inherited Create;
  FSerializationOptions := [xoLiteralParam];
end;

destructor filingRequest.Destroy;
begin
  SysUtils.FreeAndNil(Fuser);
  SysUtils.FreeAndNil(Ffiling);
  inherited Destroy;
end;

procedure filingRequest.Setfiling(Index: Integer; const Afiling: filing);
begin
  Ffiling := Afiling;
  Ffiling_Specified := True;
end;

function filingRequest.filing_Specified(Index: Integer): boolean;
begin
  Result := Ffiling_Specified;
end;

constructor anagraficRequest.Create;
begin
  inherited Create;
  FSerializationOptions := [xoLiteralParam];
end;

destructor anagraficRequest.Destroy;
begin
  SysUtils.FreeAndNil(Fuser);
  SysUtils.FreeAndNil(Fanagrafic);
  inherited Destroy;
end;

procedure anagraficRequest.Setanagrafic(Index: Integer; const Aanagrafic: anagrafic);
begin
  Fanagrafic := Aanagrafic;
  Fanagrafic_Specified := True;
end;

function anagraficRequest.anagrafic_Specified(Index: Integer): boolean;
begin
  Result := Fanagrafic_Specified;
end;

procedure anagraficRequest.SetemailAccreditation(Index: Integer; const AemailAccreditation: emailAccreditation);
begin
  FemailAccreditation := AemailAccreditation;
  FemailAccreditation_Specified := True;
end;

function anagraficRequest.emailAccreditation_Specified(Index: Integer): boolean;
begin
  Result := FemailAccreditation_Specified;
end;

destructor mnemonic.Destroy;
var
  I: Integer;
begin
  for I := 0 to System.Length(FmnemonicLevelList)-1 do
    SysUtils.FreeAndNil(FmnemonicLevelList[I]);
  System.SetLength(FmnemonicLevelList, 0);
  inherited Destroy;
end;

procedure mnemonic.Setcode(Index: Integer; const Astring: string);
begin
  Fcode := Astring;
  Fcode_Specified := True;
end;

function mnemonic.code_Specified(Index: Integer): boolean;
begin
  Result := Fcode_Specified;
end;

procedure mnemonic.SettypeCode(Index: Integer; const Astring: string);
begin
  FtypeCode := Astring;
  FtypeCode_Specified := True;
end;

function mnemonic.typeCode_Specified(Index: Integer): boolean;
begin
  Result := FtypeCode_Specified;
end;

procedure mnemonic.SetmnemonicLevelList(Index: Integer; const AmnemonicLevelList: mnemonicLevelList);
begin
  FmnemonicLevelList := AmnemonicLevelList;
  FmnemonicLevelList_Specified := True;
end;

function mnemonic.mnemonicLevelList_Specified(Index: Integer): boolean;
begin
  Result := FmnemonicLevelList_Specified;
end;

procedure user.Settoken(Index: Integer; const Astring: string);
begin
  Ftoken := Astring;
  Ftoken_Specified := True;
end;

function user.token_Specified(Index: Integer): boolean;
begin
  Result := Ftoken_Specified;
end;

destructor recordIdentifier.Destroy;
begin
  SysUtils.FreeAndNil(FregistrationDate);
  inherited Destroy;
end;

procedure recordIdentifier.SetanagraficProgR(Index: Integer; const AInt64: Int64);
begin
  FanagraficProgR := AInt64;
  FanagraficProgR_Specified := True;
end;

function recordIdentifier.anagraficProgR_Specified(Index: Integer): boolean;
begin
  Result := FanagraficProgR_Specified;
end;

procedure recordIdentifier.Setdirection(Index: Integer; const Adirection: direction);
begin
  Fdirection := Adirection;
  Fdirection_Specified := True;
end;

function recordIdentifier.direction_Specified(Index: Integer): boolean;
begin
  Result := Fdirection_Specified;
end;

procedure recordIdentifier.SetdocumentProg(Index: Integer; const AInt64: Int64);
begin
  FdocumentProg := AInt64;
  FdocumentProg_Specified := True;
end;

function recordIdentifier.documentProg_Specified(Index: Integer): boolean;
begin
  Result := FdocumentProg_Specified;
end;

procedure recordIdentifier.SetmoveProg(Index: Integer; const AInteger: Integer);
begin
  FmoveProg := AInteger;
  FmoveProg_Specified := True;
end;

function recordIdentifier.moveProg_Specified(Index: Integer): boolean;
begin
  Result := FmoveProg_Specified;
end;

procedure recordIdentifier.Setnumber(Index: Integer; const AInteger: Integer);
begin
  Fnumber := AInteger;
  Fnumber_Specified := True;
end;

function recordIdentifier.number_Specified(Index: Integer): boolean;
begin
  Result := Fnumber_Specified;
end;

procedure recordIdentifier.SetofficeCode(Index: Integer; const Astring: string);
begin
  FofficeCode := Astring;
  FofficeCode_Specified := True;
end;

function recordIdentifier.officeCode_Specified(Index: Integer): boolean;
begin
  Result := FofficeCode_Specified;
end;

procedure recordIdentifier.SetregistrationDate(Index: Integer; const ATXSDateTime: TXSDateTime);
begin
  FregistrationDate := ATXSDateTime;
  FregistrationDate_Specified := True;
end;

function recordIdentifier.registrationDate_Specified(Index: Integer): boolean;
begin
  Result := FregistrationDate_Specified;
end;

procedure recordIdentifier.SetregistryCode(Index: Integer; const Astring: string);
begin
  FregistryCode := Astring;
  FregistryCode_Specified := True;
end;

function recordIdentifier.registryCode_Specified(Index: Integer): boolean;
begin
  Result := FregistryCode_Specified;
end;

procedure recordIdentifier.Setyear(Index: Integer; const AInteger: Integer);
begin
  Fyear := AInteger;
  Fyear_Specified := True;
end;

function recordIdentifier.year_Specified(Index: Integer): boolean;
begin
  Result := Fyear_Specified;
end;

constructor protocolListRequest.Create;
begin
  inherited Create;
  FSerializationOptions := [xoLiteralParam];
end;

destructor protocolListRequest.Destroy;
begin
  SysUtils.FreeAndNil(Fuser);
  SysUtils.FreeAndNil(FintervalDateBegin);
  SysUtils.FreeAndNil(FintervalDateEnd);
  inherited Destroy;
end;

procedure protocolListRequest.SetintervalYearBegin(Index: Integer; const AInteger: Integer);
begin
  FintervalYearBegin := AInteger;
  FintervalYearBegin_Specified := True;
end;

function protocolListRequest.intervalYearBegin_Specified(Index: Integer): boolean;
begin
  Result := FintervalYearBegin_Specified;
end;

procedure protocolListRequest.SetintervalYearEnd(Index: Integer; const AInteger: Integer);
begin
  FintervalYearEnd := AInteger;
  FintervalYearEnd_Specified := True;
end;

function protocolListRequest.intervalYearEnd_Specified(Index: Integer): boolean;
begin
  Result := FintervalYearEnd_Specified;
end;

procedure protocolListRequest.SetintervalNumberBegin(Index: Integer; const AInteger: Integer);
begin
  FintervalNumberBegin := AInteger;
  FintervalNumberBegin_Specified := True;
end;

function protocolListRequest.intervalNumberBegin_Specified(Index: Integer): boolean;
begin
  Result := FintervalNumberBegin_Specified;
end;

procedure protocolListRequest.SetintervalNumberEnd(Index: Integer; const AInteger: Integer);
begin
  FintervalNumberEnd := AInteger;
  FintervalNumberEnd_Specified := True;
end;

function protocolListRequest.intervalNumberEnd_Specified(Index: Integer): boolean;
begin
  Result := FintervalNumberEnd_Specified;
end;

procedure protocolListRequest.SetintervalDateBegin(Index: Integer; const ATXSDateTime: TXSDateTime);
begin
  FintervalDateBegin := ATXSDateTime;
  FintervalDateBegin_Specified := True;
end;

function protocolListRequest.intervalDateBegin_Specified(Index: Integer): boolean;
begin
  Result := FintervalDateBegin_Specified;
end;

procedure protocolListRequest.SetintervalDateEnd(Index: Integer; const ATXSDateTime: TXSDateTime);
begin
  FintervalDateEnd := ATXSDateTime;
  FintervalDateEnd_Specified := True;
end;

function protocolListRequest.intervalDateEnd_Specified(Index: Integer): boolean;
begin
  Result := FintervalDateEnd_Specified;
end;

destructor protocolDetail2.Destroy;
var
  I: Integer;
begin
  for I := 0 to System.Length(FsenderList)-1 do
    SysUtils.FreeAndNil(FsenderList[I]);
  System.SetLength(FsenderList, 0);
  for I := 0 to System.Length(FrecipientList)-1 do
    SysUtils.FreeAndNil(FrecipientList[I]);
  System.SetLength(FrecipientList, 0);
  for I := 0 to System.Length(FofficeList)-1 do
    SysUtils.FreeAndNil(FofficeList[I]);
  System.SetLength(FofficeList, 0);
  for I := 0 to System.Length(FdocumentList)-1 do
    SysUtils.FreeAndNil(FdocumentList[I]);
  System.SetLength(FdocumentList, 0);
  for I := 0 to System.Length(FexternalDocumentList)-1 do
    SysUtils.FreeAndNil(FexternalDocumentList[I]);
  System.SetLength(FexternalDocumentList, 0);
  for I := 0 to System.Length(FfilingList)-1 do
    SysUtils.FreeAndNil(FfilingList[I]);
  System.SetLength(FfilingList, 0);
  for I := 0 to System.Length(FmnemonicList)-1 do
    SysUtils.FreeAndNil(FmnemonicList[I]);
  System.SetLength(FmnemonicList, 0);
  for I := 0 to System.Length(FpreviousList)-1 do
    SysUtils.FreeAndNil(FpreviousList[I]);
  System.SetLength(FpreviousList, 0);
  for I := 0 to System.Length(FdossierList)-1 do
    SysUtils.FreeAndNil(FdossierList[I]);
  System.SetLength(FdossierList, 0);
  SysUtils.FreeAndNil(FrecordIdentifier);
  SysUtils.FreeAndNil(FreceptionSendingDate);
  SysUtils.FreeAndNil(FmeasureDetails);
  inherited Destroy;
end;

procedure protocolDetail2.SetsubjectDocument(Index: Integer; const Astring: string);
begin
  FsubjectDocument := Astring;
  FsubjectDocument_Specified := True;
end;

function protocolDetail2.subjectDocument_Specified(Index: Integer): boolean;
begin
  Result := FsubjectDocument_Specified;
end;

procedure protocolDetail2.SetsubjectProtocol(Index: Integer; const Astring: string);
begin
  FsubjectProtocol := Astring;
  FsubjectProtocol_Specified := True;
end;

function protocolDetail2.subjectProtocol_Specified(Index: Integer): boolean;
begin
  Result := FsubjectProtocol_Specified;
end;

procedure protocolDetail2.SetreceptionSendingDate(Index: Integer; const ATXSDateTime: TXSDateTime);
begin
  FreceptionSendingDate := ATXSDateTime;
  FreceptionSendingDate_Specified := True;
end;

function protocolDetail2.receptionSendingDate_Specified(Index: Integer): boolean;
begin
  Result := FreceptionSendingDate_Specified;
end;

procedure protocolDetail2.SettypeSenderMail(Index: Integer; const AInteger: Integer);
begin
  FtypeSenderMail := AInteger;
  FtypeSenderMail_Specified := True;
end;

function protocolDetail2.typeSenderMail_Specified(Index: Integer): boolean;
begin
  Result := FtypeSenderMail_Specified;
end;

procedure protocolDetail2.SetmeasureDetails(Index: Integer; const AmeasureDetails: measureDetails);
begin
  FmeasureDetails := AmeasureDetails;
  FmeasureDetails_Specified := True;
end;

function protocolDetail2.measureDetails_Specified(Index: Integer): boolean;
begin
  Result := FmeasureDetails_Specified;
end;

procedure protocolDetail2.SetsenderList(Index: Integer; const AsenderList: senderList);
begin
  FsenderList := AsenderList;
  FsenderList_Specified := True;
end;

function protocolDetail2.senderList_Specified(Index: Integer): boolean;
begin
  Result := FsenderList_Specified;
end;

procedure protocolDetail2.SetrecipientList(Index: Integer; const ArecipientList: recipientList);
begin
  FrecipientList := ArecipientList;
  FrecipientList_Specified := True;
end;

function protocolDetail2.recipientList_Specified(Index: Integer): boolean;
begin
  Result := FrecipientList_Specified;
end;

procedure protocolDetail2.SetofficeList(Index: Integer; const AofficeList2: officeList2);
begin
  FofficeList := AofficeList2;
  FofficeList_Specified := True;
end;

function protocolDetail2.officeList_Specified(Index: Integer): boolean;
begin
  Result := FofficeList_Specified;
end;

procedure protocolDetail2.SetdocumentList(Index: Integer; const AdocumentList: documentList);
begin
  FdocumentList := AdocumentList;
  FdocumentList_Specified := True;
end;

function protocolDetail2.documentList_Specified(Index: Integer): boolean;
begin
  Result := FdocumentList_Specified;
end;

procedure protocolDetail2.SetexternalDocumentList(Index: Integer; const AexternalDocumentList: externalDocumentList);
begin
  FexternalDocumentList := AexternalDocumentList;
  FexternalDocumentList_Specified := True;
end;

function protocolDetail2.externalDocumentList_Specified(Index: Integer): boolean;
begin
  Result := FexternalDocumentList_Specified;
end;

procedure protocolDetail2.SetfilingList(Index: Integer; const AfilingList3: filingList3);
begin
  FfilingList := AfilingList3;
  FfilingList_Specified := True;
end;

function protocolDetail2.filingList_Specified(Index: Integer): boolean;
begin
  Result := FfilingList_Specified;
end;

procedure protocolDetail2.SetmnemonicList(Index: Integer; const AmnemonicList: mnemonicList);
begin
  FmnemonicList := AmnemonicList;
  FmnemonicList_Specified := True;
end;

function protocolDetail2.mnemonicList_Specified(Index: Integer): boolean;
begin
  Result := FmnemonicList_Specified;
end;

procedure protocolDetail2.SetpreviousList(Index: Integer; const ApreviousList: previousList);
begin
  FpreviousList := ApreviousList;
  FpreviousList_Specified := True;
end;

function protocolDetail2.previousList_Specified(Index: Integer): boolean;
begin
  Result := FpreviousList_Specified;
end;

procedure protocolDetail2.SetdossierList(Index: Integer; const AdossierList: dossierList);
begin
  FdossierList := AdossierList;
  FdossierList_Specified := True;
end;

function protocolDetail2.dossierList_Specified(Index: Integer): boolean;
begin
  Result := FdossierList_Specified;
end;

constructor protocolUpdateRequest.Create;
begin
  inherited Create;
  FSerializationOptions := [xoLiteralParam];
end;

destructor protocolUpdateRequest.Destroy;
var
  I: Integer;
begin
  for I := 0 to System.Length(FofficeList)-1 do
    SysUtils.FreeAndNil(FofficeList[I]);
  System.SetLength(FofficeList, 0);
  for I := 0 to System.Length(FdocumentList)-1 do
    SysUtils.FreeAndNil(FdocumentList[I]);
  System.SetLength(FdocumentList, 0);
  for I := 0 to System.Length(FexternalDocumentList)-1 do
    SysUtils.FreeAndNil(FexternalDocumentList[I]);
  System.SetLength(FexternalDocumentList, 0);
  for I := 0 to System.Length(FfilingList)-1 do
    SysUtils.FreeAndNil(FfilingList[I]);
  System.SetLength(FfilingList, 0);
  for I := 0 to System.Length(FmnemonicList)-1 do
    SysUtils.FreeAndNil(FmnemonicList[I]);
  System.SetLength(FmnemonicList, 0);
  for I := 0 to System.Length(FpreviousList)-1 do
    SysUtils.FreeAndNil(FpreviousList[I]);
  System.SetLength(FpreviousList, 0);
  for I := 0 to System.Length(FdossierList)-1 do
    SysUtils.FreeAndNil(FdossierList[I]);
  System.SetLength(FdossierList, 0);
  SysUtils.FreeAndNil(Fuser);
  SysUtils.FreeAndNil(FrecordIdentifier);
  SysUtils.FreeAndNil(FreceptionSendingDate);
  SysUtils.FreeAndNil(FdocumentDetails);
  SysUtils.FreeAndNil(FmeasureDetails);
  inherited Destroy;
end;

procedure protocolUpdateRequest.SetsubjectProtocol(Index: Integer; const Astring: string);
begin
  FsubjectProtocol := Astring;
  FsubjectProtocol_Specified := True;
end;

function protocolUpdateRequest.subjectProtocol_Specified(Index: Integer): boolean;
begin
  Result := FsubjectProtocol_Specified;
end;

procedure protocolUpdateRequest.SetreceptionSendingDate(Index: Integer; const ATXSDateTime: TXSDateTime);
begin
  FreceptionSendingDate := ATXSDateTime;
  FreceptionSendingDate_Specified := True;
end;

function protocolUpdateRequest.receptionSendingDate_Specified(Index: Integer): boolean;
begin
  Result := FreceptionSendingDate_Specified;
end;

procedure protocolUpdateRequest.SettypeSenderMail(Index: Integer; const AInteger: Integer);
begin
  FtypeSenderMail := AInteger;
  FtypeSenderMail_Specified := True;
end;

function protocolUpdateRequest.typeSenderMail_Specified(Index: Integer): boolean;
begin
  Result := FtypeSenderMail_Specified;
end;

procedure protocolUpdateRequest.SetdocumentDetails(Index: Integer; const AdocumentDetails: documentDetails);
begin
  FdocumentDetails := AdocumentDetails;
  FdocumentDetails_Specified := True;
end;

function protocolUpdateRequest.documentDetails_Specified(Index: Integer): boolean;
begin
  Result := FdocumentDetails_Specified;
end;

procedure protocolUpdateRequest.SetmeasureDetails(Index: Integer; const AmeasureDetails: measureDetails);
begin
  FmeasureDetails := AmeasureDetails;
  FmeasureDetails_Specified := True;
end;

function protocolUpdateRequest.measureDetails_Specified(Index: Integer): boolean;
begin
  Result := FmeasureDetails_Specified;
end;

procedure protocolUpdateRequest.SetofficePartialUpdate(Index: Integer; const ABoolean: Boolean);
begin
  FofficePartialUpdate := ABoolean;
  FofficePartialUpdate_Specified := True;
end;

function protocolUpdateRequest.officePartialUpdate_Specified(Index: Integer): boolean;
begin
  Result := FofficePartialUpdate_Specified;
end;

procedure protocolUpdateRequest.SetmnemonicPartialUpdate(Index: Integer; const ABoolean: Boolean);
begin
  FmnemonicPartialUpdate := ABoolean;
  FmnemonicPartialUpdate_Specified := True;
end;

function protocolUpdateRequest.mnemonicPartialUpdate_Specified(Index: Integer): boolean;
begin
  Result := FmnemonicPartialUpdate_Specified;
end;

procedure protocolUpdateRequest.SetpreviousPartialUpdate(Index: Integer; const ABoolean: Boolean);
begin
  FpreviousPartialUpdate := ABoolean;
  FpreviousPartialUpdate_Specified := True;
end;

function protocolUpdateRequest.previousPartialUpdate_Specified(Index: Integer): boolean;
begin
  Result := FpreviousPartialUpdate_Specified;
end;

procedure protocolUpdateRequest.SetfilingPartialUpdate(Index: Integer; const ABoolean: Boolean);
begin
  FfilingPartialUpdate := ABoolean;
  FfilingPartialUpdate_Specified := True;
end;

function protocolUpdateRequest.filingPartialUpdate_Specified(Index: Integer): boolean;
begin
  Result := FfilingPartialUpdate_Specified;
end;

procedure protocolUpdateRequest.SetdocumentPartialUpdate(Index: Integer; const ABoolean: Boolean);
begin
  FdocumentPartialUpdate := ABoolean;
  FdocumentPartialUpdate_Specified := True;
end;

function protocolUpdateRequest.documentPartialUpdate_Specified(Index: Integer): boolean;
begin
  Result := FdocumentPartialUpdate_Specified;
end;

procedure protocolUpdateRequest.SetdossierPartialUpdate(Index: Integer; const ABoolean: Boolean);
begin
  FdossierPartialUpdate := ABoolean;
  FdossierPartialUpdate_Specified := True;
end;

function protocolUpdateRequest.dossierPartialUpdate_Specified(Index: Integer): boolean;
begin
  Result := FdossierPartialUpdate_Specified;
end;

procedure protocolUpdateRequest.SetofficeList(Index: Integer; const AofficeList3: officeList3);
begin
  FofficeList := AofficeList3;
  FofficeList_Specified := True;
end;

function protocolUpdateRequest.officeList_Specified(Index: Integer): boolean;
begin
  Result := FofficeList_Specified;
end;

procedure protocolUpdateRequest.SetdocumentList(Index: Integer; const AdocumentList2: documentList2);
begin
  FdocumentList := AdocumentList2;
  FdocumentList_Specified := True;
end;

function protocolUpdateRequest.documentList_Specified(Index: Integer): boolean;
begin
  Result := FdocumentList_Specified;
end;

procedure protocolUpdateRequest.SetexternalDocumentList(Index: Integer; const AexternalDocumentList2: externalDocumentList2);
begin
  FexternalDocumentList := AexternalDocumentList2;
  FexternalDocumentList_Specified := True;
end;

function protocolUpdateRequest.externalDocumentList_Specified(Index: Integer): boolean;
begin
  Result := FexternalDocumentList_Specified;
end;

procedure protocolUpdateRequest.SetfilingList(Index: Integer; const AfilingList4: filingList4);
begin
  FfilingList := AfilingList4;
  FfilingList_Specified := True;
end;

function protocolUpdateRequest.filingList_Specified(Index: Integer): boolean;
begin
  Result := FfilingList_Specified;
end;

procedure protocolUpdateRequest.SetmnemonicList(Index: Integer; const AmnemonicList2: mnemonicList2);
begin
  FmnemonicList := AmnemonicList2;
  FmnemonicList_Specified := True;
end;

function protocolUpdateRequest.mnemonicList_Specified(Index: Integer): boolean;
begin
  Result := FmnemonicList_Specified;
end;

procedure protocolUpdateRequest.SetpreviousList(Index: Integer; const ApreviousList2: previousList2);
begin
  FpreviousList := ApreviousList2;
  FpreviousList_Specified := True;
end;

function protocolUpdateRequest.previousList_Specified(Index: Integer): boolean;
begin
  Result := FpreviousList_Specified;
end;

procedure protocolUpdateRequest.SetdossierList(Index: Integer; const AdossierList2: dossierList2);
begin
  FdossierList := AdossierList2;
  FdossierList_Specified := True;
end;

function protocolUpdateRequest.dossierList_Specified(Index: Integer): boolean;
begin
  Result := FdossierList_Specified;
end;

procedure previous.SetlinkType(Index: Integer; const Astring: string);
begin
  FlinkType := Astring;
  FlinkType_Specified := True;
end;

function previous.linkType_Specified(Index: Integer): boolean;
begin
  Result := FlinkType_Specified;
end;

procedure previous.Setremove(Index: Integer; const ABoolean: Boolean);
begin
  Fremove := ABoolean;
  Fremove_Specified := True;
end;

function previous.remove_Specified(Index: Integer): boolean;
begin
  Result := Fremove_Specified;
end;

destructor filing.Destroy;
var
  I: Integer;
begin
  for I := 0 to System.Length(FlevelList)-1 do
    SysUtils.FreeAndNil(FlevelList[I]);
  System.SetLength(FlevelList, 0);
  inherited Destroy;
end;

procedure filing.Setcode(Index: Integer; const Astring: string);
begin
  Fcode := Astring;
  Fcode_Specified := True;
end;

function filing.code_Specified(Index: Integer): boolean;
begin
  Result := Fcode_Specified;
end;

procedure filing.Setdescription(Index: Integer; const Astring: string);
begin
  Fdescription := Astring;
  Fdescription_Specified := True;
end;

function filing.description_Specified(Index: Integer): boolean;
begin
  Result := Fdescription_Specified;
end;

procedure filing.Setdisabled(Index: Integer; const ABoolean: Boolean);
begin
  Fdisabled := ABoolean;
  Fdisabled_Specified := True;
end;

function filing.disabled_Specified(Index: Integer): boolean;
begin
  Result := Fdisabled_Specified;
end;

procedure filing.SetcodeParent(Index: Integer; const Astring: string);
begin
  FcodeParent := Astring;
  FcodeParent_Specified := True;
end;

function filing.codeParent_Specified(Index: Integer): boolean;
begin
  Result := FcodeParent_Specified;
end;

procedure filing.Setremove(Index: Integer; const ABoolean: Boolean);
begin
  Fremove := ABoolean;
  Fremove_Specified := True;
end;

function filing.remove_Specified(Index: Integer): boolean;
begin
  Result := Fremove_Specified;
end;

procedure filing.SetlevelList(Index: Integer; const AlevelList: levelList);
begin
  FlevelList := AlevelList;
  FlevelList_Specified := True;
end;

function filing.levelList_Specified(Index: Integer): boolean;
begin
  Result := FlevelList_Specified;
end;

procedure document.Setname_(Index: Integer; const Astring: string);
begin
  Fname_ := Astring;
  Fname__Specified := True;
end;

function document.name__Specified(Index: Integer): boolean;
begin
  Result := Fname__Specified;
end;

procedure document.Setprimary(Index: Integer; const ABoolean: Boolean);
begin
  Fprimary := ABoolean;
  Fprimary_Specified := True;
end;

function document.primary_Specified(Index: Integer): boolean;
begin
  Result := Fprimary_Specified;
end;

procedure document.SetdocumentRepositoryId(Index: Integer; const AInt64: Int64);
begin
  FdocumentRepositoryId := AInt64;
  FdocumentRepositoryId_Specified := True;
end;

function document.documentRepositoryId_Specified(Index: Integer): boolean;
begin
  Result := FdocumentRepositoryId_Specified;
end;

procedure document.Setremove(Index: Integer; const ABoolean: Boolean);
begin
  Fremove := ABoolean;
  Fremove_Specified := True;
end;

function document.remove_Specified(Index: Integer): boolean;
begin
  Result := Fremove_Specified;
end;

procedure document.Setmirror(Index: Integer; const ABoolean: Boolean);
begin
  Fmirror := ABoolean;
  Fmirror_Specified := True;
end;

function document.mirror_Specified(Index: Integer): boolean;
begin
  Result := Fmirror_Specified;
end;

procedure document.Setfile_(Index: Integer; const ATByteDynArray: TByteDynArray);
begin
  Ffile_ := ATByteDynArray;
  Ffile__Specified := True;
end;

function document.file__Specified(Index: Integer): boolean;
begin
  Result := Ffile__Specified;
end;

procedure externalDocument.Setname_(Index: Integer; const Astring: string);
begin
  Fname_ := Astring;
  Fname__Specified := True;
end;

function externalDocument.name__Specified(Index: Integer): boolean;
begin
  Result := Fname__Specified;
end;

procedure externalDocument.Setprimary(Index: Integer; const ABoolean: Boolean);
begin
  Fprimary := ABoolean;
  Fprimary_Specified := True;
end;

function externalDocument.primary_Specified(Index: Integer): boolean;
begin
  Result := Fprimary_Specified;
end;

procedure externalDocument.SetdocumentRepositoryId(Index: Integer; const Astring: string);
begin
  FdocumentRepositoryId := Astring;
  FdocumentRepositoryId_Specified := True;
end;

function externalDocument.documentRepositoryId_Specified(Index: Integer): boolean;
begin
  Result := FdocumentRepositoryId_Specified;
end;

procedure externalDocument.SetdocumentRepositoryPath(Index: Integer; const Astring: string);
begin
  FdocumentRepositoryPath := Astring;
  FdocumentRepositoryPath_Specified := True;
end;

function externalDocument.documentRepositoryPath_Specified(Index: Integer): boolean;
begin
  Result := FdocumentRepositoryPath_Specified;
end;

procedure externalDocument.Setremove(Index: Integer; const ABoolean: Boolean);
begin
  Fremove := ABoolean;
  Fremove_Specified := True;
end;

function externalDocument.remove_Specified(Index: Integer): boolean;
begin
  Result := Fremove_Specified;
end;

procedure externalDocument.Setmirror(Index: Integer; const ABoolean: Boolean);
begin
  Fmirror := ABoolean;
  Fmirror_Specified := True;
end;

function externalDocument.mirror_Specified(Index: Integer): boolean;
begin
  Result := Fmirror_Specified;
end;

constructor anagraficResponse.Create;
begin
  inherited Create;
  FSerializationOptions := [xoLiteralParam];
end;

destructor anagraficResponse.Destroy;
var
  I: Integer;
begin
  for I := 0 to System.Length(FanagraficList)-1 do
    SysUtils.FreeAndNil(FanagraficList[I]);
  System.SetLength(FanagraficList, 0);
  SysUtils.FreeAndNil(Ferror);
  inherited Destroy;
end;

procedure anagraficResponse.Seterror(Index: Integer; const Aerror: error);
begin
  Ferror := Aerror;
  Ferror_Specified := True;
end;

function anagraficResponse.error_Specified(Index: Integer): boolean;
begin
  Result := Ferror_Specified;
end;

procedure anagraficResponse.SetanagraficList(Index: Integer; const AanagraficList2: anagraficList2);
begin
  FanagraficList := AanagraficList2;
  FanagraficList_Specified := True;
end;

function anagraficResponse.anagraficList_Specified(Index: Integer): boolean;
begin
  Result := FanagraficList_Specified;
end;

destructor anagrafic.Destroy;
begin
  SysUtils.FreeAndNil(FbirthDate);
  inherited Destroy;
end;

procedure anagrafic.Setaddress(Index: Integer; const Astring: string);
begin
  Faddress := Astring;
  Faddress_Specified := True;
end;

function anagrafic.address_Specified(Index: Integer): boolean;
begin
  Result := Faddress_Specified;
end;

procedure anagrafic.Setalias(Index: Integer; const Astring: string);
begin
  Falias := Astring;
  Falias_Specified := True;
end;

function anagrafic.alias_Specified(Index: Integer): boolean;
begin
  Result := Falias_Specified;
end;

procedure anagrafic.SetanagraficAggCode(Index: Integer; const Astring: string);
begin
  FanagraficAggCode := Astring;
  FanagraficAggCode_Specified := True;
end;

function anagrafic.anagraficAggCode_Specified(Index: Integer): boolean;
begin
  Result := FanagraficAggCode_Specified;
end;

procedure anagrafic.SetanagraficAggDescription(Index: Integer; const Astring: string);
begin
  FanagraficAggDescription := Astring;
  FanagraficAggDescription_Specified := True;
end;

function anagrafic.anagraficAggDescription_Specified(Index: Integer): boolean;
begin
  Result := FanagraficAggDescription_Specified;
end;

procedure anagrafic.SetanagraficCode(Index: Integer; const Astring: string);
begin
  FanagraficCode := Astring;
  FanagraficCode_Specified := True;
end;

function anagrafic.anagraficCode_Specified(Index: Integer): boolean;
begin
  Result := FanagraficCode_Specified;
end;

procedure anagrafic.SetanagraficDescription(Index: Integer; const Astring: string);
begin
  FanagraficDescription := Astring;
  FanagraficDescription_Specified := True;
end;

function anagrafic.anagraficDescription_Specified(Index: Integer): boolean;
begin
  Result := FanagraficDescription_Specified;
end;

procedure anagrafic.SetanagraficDescription2(Index: Integer; const Astring: string);
begin
  FanagraficDescription2 := Astring;
  FanagraficDescription2_Specified := True;
end;

function anagrafic.anagraficDescription2_Specified(Index: Integer): boolean;
begin
  Result := FanagraficDescription2_Specified;
end;

procedure anagrafic.SetanagraficTypeCode(Index: Integer; const Astring: string);
begin
  FanagraficTypeCode := Astring;
  FanagraficTypeCode_Specified := True;
end;

function anagrafic.anagraficTypeCode_Specified(Index: Integer): boolean;
begin
  Result := FanagraficTypeCode_Specified;
end;

procedure anagrafic.SetanagraficTypologyCode(Index: Integer; const Astring: string);
begin
  FanagraficTypologyCode := Astring;
  FanagraficTypologyCode_Specified := True;
end;

function anagrafic.anagraficTypologyCode_Specified(Index: Integer): boolean;
begin
  Result := FanagraficTypologyCode_Specified;
end;

procedure anagrafic.SetbirthDate(Index: Integer; const ATXSDateTime: TXSDateTime);
begin
  FbirthDate := ATXSDateTime;
  FbirthDate_Specified := True;
end;

function anagrafic.birthDate_Specified(Index: Integer): boolean;
begin
  Result := FbirthDate_Specified;
end;

procedure anagrafic.SetbirthPlace(Index: Integer; const Astring: string);
begin
  FbirthPlace := Astring;
  FbirthPlace_Specified := True;
end;

function anagrafic.birthPlace_Specified(Index: Integer): boolean;
begin
  Result := FbirthPlace_Specified;
end;

procedure anagrafic.SetbirthProvince(Index: Integer; const Astring: string);
begin
  FbirthProvince := Astring;
  FbirthProvince_Specified := True;
end;

function anagrafic.birthProvince_Specified(Index: Integer): boolean;
begin
  Result := FbirthProvince_Specified;
end;

procedure anagrafic.Setcap(Index: Integer; const AInteger: Integer);
begin
  Fcap := AInteger;
  Fcap_Specified := True;
end;

function anagrafic.cap_Specified(Index: Integer): boolean;
begin
  Result := Fcap_Specified;
end;

procedure anagrafic.Setcf(Index: Integer; const Astring: string);
begin
  Fcf := Astring;
  Fcf_Specified := True;
end;

function anagrafic.cf_Specified(Index: Integer): boolean;
begin
  Result := Fcf_Specified;
end;

procedure anagrafic.Setdisabled(Index: Integer; const ABoolean: Boolean);
begin
  Fdisabled := ABoolean;
  Fdisabled_Specified := True;
end;

function anagrafic.disabled_Specified(Index: Integer): boolean;
begin
  Result := Fdisabled_Specified;
end;

procedure anagrafic.Setemail(Index: Integer; const Astring: string);
begin
  Femail := Astring;
  Femail_Specified := True;
end;

function anagrafic.email_Specified(Index: Integer): boolean;
begin
  Result := Femail_Specified;
end;

procedure anagrafic.Setgender(Index: Integer; const Astring: string);
begin
  Fgender := Astring;
  Fgender_Specified := True;
end;

function anagrafic.gender_Specified(Index: Integer): boolean;
begin
  Result := Fgender_Specified;
end;

procedure anagrafic.SetimportGd(Index: Integer; const ABoolean: Boolean);
begin
  FimportGd := ABoolean;
  FimportGd_Specified := True;
end;

function anagrafic.importGd_Specified(Index: Integer): boolean;
begin
  Result := FimportGd_Specified;
end;

procedure anagrafic.Setinitials(Index: Integer; const Astring: string);
begin
  Finitials := Astring;
  Finitials_Specified := True;
end;

function anagrafic.initials_Specified(Index: Integer): boolean;
begin
  Result := Finitials_Specified;
end;

procedure anagrafic.SetlivAbil(Index: Integer; const ABoolean: Boolean);
begin
  FlivAbil := ABoolean;
  FlivAbil_Specified := True;
end;

function anagrafic.livAbil_Specified(Index: Integer): boolean;
begin
  Result := FlivAbil_Specified;
end;

procedure anagrafic.Setlocality(Index: Integer; const Astring: string);
begin
  Flocality := Astring;
  Flocality_Specified := True;
end;

function anagrafic.locality_Specified(Index: Integer): boolean;
begin
  Result := Flocality_Specified;
end;

procedure anagrafic.Setname_(Index: Integer; const Astring: string);
begin
  Fname_ := Astring;
  Fname__Specified := True;
end;

function anagrafic.name__Specified(Index: Integer): boolean;
begin
  Result := Fname__Specified;
end;

procedure anagrafic.SetnoTree(Index: Integer; const ABoolean: Boolean);
begin
  FnoTree := ABoolean;
  FnoTree_Specified := True;
end;

function anagrafic.noTree_Specified(Index: Integer): boolean;
begin
  Result := FnoTree_Specified;
end;

procedure anagrafic.Setpiva(Index: Integer; const AInt64: Int64);
begin
  Fpiva := AInt64;
  Fpiva_Specified := True;
end;

function anagrafic.piva_Specified(Index: Integer): boolean;
begin
  Result := Fpiva_Specified;
end;

procedure anagrafic.Setprovince(Index: Integer; const Astring: string);
begin
  Fprovince := Astring;
  Fprovince_Specified := True;
end;

function anagrafic.province_Specified(Index: Integer): boolean;
begin
  Result := Fprovince_Specified;
end;

procedure anagrafic.SetqualifyEmployeeCode(Index: Integer; const Astring: string);
begin
  FqualifyEmployeeCode := Astring;
  FqualifyEmployeeCode_Specified := True;
end;

function anagrafic.qualifyEmployeeCode_Specified(Index: Integer): boolean;
begin
  Result := FqualifyEmployeeCode_Specified;
end;

procedure anagrafic.Setstate(Index: Integer; const Astring: string);
begin
  Fstate := Astring;
  Fstate_Specified := True;
end;

function anagrafic.state_Specified(Index: Integer): boolean;
begin
  Result := Fstate_Specified;
end;

procedure anagrafic.Setsurname(Index: Integer; const Astring: string);
begin
  Fsurname := Astring;
  Fsurname_Specified := True;
end;

function anagrafic.surname_Specified(Index: Integer): boolean;
begin
  Result := Fsurname_Specified;
end;

procedure anagrafic.Settitle(Index: Integer; const Astring: string);
begin
  Ftitle := Astring;
  Ftitle_Specified := True;
end;

function anagrafic.title_Specified(Index: Integer): boolean;
begin
  Result := Ftitle_Specified;
end;

procedure anagrafic.SetuseProt(Index: Integer; const ABoolean: Boolean);
begin
  FuseProt := ABoolean;
  FuseProt_Specified := True;
end;

function anagrafic.useProt_Specified(Index: Integer): boolean;
begin
  Result := FuseProt_Specified;
end;

destructor correspondent.Destroy;
begin
  SysUtils.FreeAndNil(FreferenceDate);
  inherited Destroy;
end;

procedure correspondent.Setcode(Index: Integer; const Astring: string);
begin
  Fcode := Astring;
  Fcode_Specified := True;
end;

function correspondent.code_Specified(Index: Integer): boolean;
begin
  Result := Fcode_Specified;
end;

procedure correspondent.Setdescription(Index: Integer; const Astring: string);
begin
  Fdescription := Astring;
  Fdescription_Specified := True;
end;

function correspondent.description_Specified(Index: Integer): boolean;
begin
  Result := Fdescription_Specified;
end;

procedure correspondent.SetreferenceDate(Index: Integer; const ATXSDateTime: TXSDateTime);
begin
  FreferenceDate := ATXSDateTime;
  FreferenceDate_Specified := True;
end;

function correspondent.referenceDate_Specified(Index: Integer): boolean;
begin
  Result := FreferenceDate_Specified;
end;

procedure correspondent.SetreferenceNumber(Index: Integer; const Astring: string);
begin
  FreferenceNumber := Astring;
  FreferenceNumber_Specified := True;
end;

function correspondent.referenceNumber_Specified(Index: Integer): boolean;
begin
  Result := FreferenceNumber_Specified;
end;

procedure correspondent.Setnote(Index: Integer; const Astring: string);
begin
  Fnote := Astring;
  Fnote_Specified := True;
end;

function correspondent.note_Specified(Index: Integer): boolean;
begin
  Result := Fnote_Specified;
end;

procedure correspondent.SettransmissionMode(Index: Integer; const Astring: string);
begin
  FtransmissionMode := Astring;
  FtransmissionMode_Specified := True;
end;

function correspondent.transmissionMode_Specified(Index: Integer): boolean;
begin
  Result := FtransmissionMode_Specified;
end;

procedure correspondent.SettypeCode(Index: Integer; const Astring: string);
begin
  FtypeCode := Astring;
  FtypeCode_Specified := True;
end;

function correspondent.typeCode_Specified(Index: Integer): boolean;
begin
  Result := FtypeCode_Specified;
end;

procedure correspondent.SettypeDesc(Index: Integer; const Astring: string);
begin
  FtypeDesc := Astring;
  FtypeDesc_Specified := True;
end;

function correspondent.typeDesc_Specified(Index: Integer): boolean;
begin
  Result := FtypeDesc_Specified;
end;

procedure correspondent.Setremove(Index: Integer; const ABoolean: Boolean);
begin
  Fremove := ABoolean;
  Fremove_Specified := True;
end;

function correspondent.remove_Specified(Index: Integer): boolean;
begin
  Result := Fremove_Specified;
end;

procedure office.SetmailSend(Index: Integer; const ABoolean: Boolean);
begin
  FmailSend := ABoolean;
  FmailSend_Specified := True;
end;

function office.mailSend_Specified(Index: Integer): boolean;
begin
  Result := FmailSend_Specified;
end;

procedure office.SetmailAttachment(Index: Integer; const ABoolean: Boolean);
begin
  FmailAttachment := ABoolean;
  FmailAttachment_Specified := True;
end;

function office.mailAttachment_Specified(Index: Integer): boolean;
begin
  Result := FmailAttachment_Specified;
end;

procedure office.SetmailCarbonCopy(Index: Integer; const ABoolean: Boolean);
begin
  FmailCarbonCopy := ABoolean;
  FmailCarbonCopy_Specified := True;
end;

function office.mailCarbonCopy_Specified(Index: Integer): boolean;
begin
  Result := FmailCarbonCopy_Specified;
end;

procedure office.SetmailConfirmationReceipt(Index: Integer; const ABoolean: Boolean);
begin
  FmailConfirmationReceipt := ABoolean;
  FmailConfirmationReceipt_Specified := True;
end;

function office.mailConfirmationReceipt_Specified(Index: Integer): boolean;
begin
  Result := FmailConfirmationReceipt_Specified;
end;

constructor filingResponse.Create;
begin
  inherited Create;
  FSerializationOptions := [xoLiteralParam];
end;

destructor filingResponse.Destroy;
var
  I: Integer;
begin
  for I := 0 to System.Length(FfilingList)-1 do
    SysUtils.FreeAndNil(FfilingList[I]);
  System.SetLength(FfilingList, 0);
  SysUtils.FreeAndNil(Ferror);
  inherited Destroy;
end;

procedure filingResponse.Seterror(Index: Integer; const Aerror: error);
begin
  Ferror := Aerror;
  Ferror_Specified := True;
end;

function filingResponse.error_Specified(Index: Integer): boolean;
begin
  Result := Ferror_Specified;
end;

procedure filingResponse.SetfilingList(Index: Integer; const AfilingList2: filingList2);
begin
  FfilingList := AfilingList2;
  FfilingList_Specified := True;
end;

function filingResponse.filingList_Specified(Index: Integer): boolean;
begin
  Result := FfilingList_Specified;
end;

procedure registry.Setcode(Index: Integer; const Astring: string);
begin
  Fcode := Astring;
  Fcode_Specified := True;
end;

function registry.code_Specified(Index: Integer): boolean;
begin
  Result := Fcode_Specified;
end;

procedure registry.Setdescription(Index: Integer; const Astring: string);
begin
  Fdescription := Astring;
  Fdescription_Specified := True;
end;

function registry.description_Specified(Index: Integer): boolean;
begin
  Result := Fdescription_Specified;
end;

destructor officeBasicInformation.Destroy;
var
  I: Integer;
begin
  for I := 0 to System.Length(FregistryList)-1 do
    SysUtils.FreeAndNil(FregistryList[I]);
  System.SetLength(FregistryList, 0);
  inherited Destroy;
end;

procedure officeBasicInformation.SetregistryList(Index: Integer; const AregistryList: registryList);
begin
  FregistryList := AregistryList;
  FregistryList_Specified := True;
end;

function officeBasicInformation.registryList_Specified(Index: Integer): boolean;
begin
  Result := FregistryList_Specified;
end;

destructor documentDetails.Destroy;
begin
  SysUtils.FreeAndNil(Fdate);
  inherited Destroy;
end;

procedure documentDetails.Setnumber(Index: Integer; const Astring: string);
begin
  Fnumber := Astring;
  Fnumber_Specified := True;
end;

function documentDetails.number_Specified(Index: Integer): boolean;
begin
  Result := Fnumber_Specified;
end;

procedure documentDetails.Setdate(Index: Integer; const ATXSDateTime: TXSDateTime);
begin
  Fdate := ATXSDateTime;
  Fdate_Specified := True;
end;

function documentDetails.date_Specified(Index: Integer): boolean;
begin
  Result := Fdate_Specified;
end;

procedure documentDetails.Setyear(Index: Integer; const AInteger: Integer);
begin
  Fyear := AInteger;
  Fyear_Specified := True;
end;

function documentDetails.year_Specified(Index: Integer): boolean;
begin
  Result := Fyear_Specified;
end;

procedure documentDetails.SetdocumentTypeCode(Index: Integer; const Astring: string);
begin
  FdocumentTypeCode := Astring;
  FdocumentTypeCode_Specified := True;
end;

function documentDetails.documentTypeCode_Specified(Index: Integer): boolean;
begin
  Result := FdocumentTypeCode_Specified;
end;

destructor measureDetails.Destroy;
begin
  SysUtils.FreeAndNil(Fdate);
  inherited Destroy;
end;

procedure measureDetails.Setdate(Index: Integer; const ATXSDateTime: TXSDateTime);
begin
  Fdate := ATXSDateTime;
  Fdate_Specified := True;
end;

function measureDetails.date_Specified(Index: Integer): boolean;
begin
  Result := Fdate_Specified;
end;

procedure measureDetails.Setdetails(Index: Integer; const Astring: string);
begin
  Fdetails := Astring;
  Fdetails_Specified := True;
end;

function measureDetails.details_Specified(Index: Integer): boolean;
begin
  Result := Fdetails_Specified;
end;

procedure measureDetails.Setcause(Index: Integer; const Astring: string);
begin
  Fcause := Astring;
  Fcause_Specified := True;
end;

function measureDetails.cause_Specified(Index: Integer): boolean;
begin
  Result := Fcause_Specified;
end;

procedure dossier.Setremove(Index: Integer; const ABoolean: Boolean);
begin
  Fremove := ABoolean;
  Fremove_Specified := True;
end;

function dossier.remove_Specified(Index: Integer): boolean;
begin
  Result := Fremove_Specified;
end;

procedure recipient.SetiopSend(Index: Integer; const ABoolean: Boolean);
begin
  FiopSend := ABoolean;
  FiopSend_Specified := True;
end;

function recipient.iopSend_Specified(Index: Integer): boolean;
begin
  Result := FiopSend_Specified;
end;

procedure recipient.SetiopUpdateNotification(Index: Integer; const ABoolean: Boolean);
begin
  FiopUpdateNotification := ABoolean;
  FiopUpdateNotification_Specified := True;
end;

function recipient.iopUpdateNotification_Specified(Index: Integer): boolean;
begin
  Result := FiopUpdateNotification_Specified;
end;

procedure recipient.SetiopConfirmationReceipt(Index: Integer; const ABoolean: Boolean);
begin
  FiopConfirmationReceipt := ABoolean;
  FiopConfirmationReceipt_Specified := True;
end;

function recipient.iopConfirmationReceipt_Specified(Index: Integer): boolean;
begin
  Result := FiopConfirmationReceipt_Specified;
end;

procedure recipient.SetmailSend(Index: Integer; const ABoolean: Boolean);
begin
  FmailSend := ABoolean;
  FmailSend_Specified := True;
end;

function recipient.mailSend_Specified(Index: Integer): boolean;
begin
  Result := FmailSend_Specified;
end;

procedure recipient.SetmailAttachment(Index: Integer; const ABoolean: Boolean);
begin
  FmailAttachment := ABoolean;
  FmailAttachment_Specified := True;
end;

function recipient.mailAttachment_Specified(Index: Integer): boolean;
begin
  Result := FmailAttachment_Specified;
end;

procedure recipient.SetmailCarbonCopy(Index: Integer; const ABoolean: Boolean);
begin
  FmailCarbonCopy := ABoolean;
  FmailCarbonCopy_Specified := True;
end;

function recipient.mailCarbonCopy_Specified(Index: Integer): boolean;
begin
  Result := FmailCarbonCopy_Specified;
end;

procedure recipient.SetmailConfirmationReceipt(Index: Integer; const ABoolean: Boolean);
begin
  FmailConfirmationReceipt := ABoolean;
  FmailConfirmationReceipt_Specified := True;
end;

function recipient.mailConfirmationReceipt_Specified(Index: Integer): boolean;
begin
  Result := FmailConfirmationReceipt_Specified;
end;

constructor protocolDetailRequest.Create;
begin
  inherited Create;
  FSerializationOptions := [xoLiteralParam];
end;

destructor protocolDetailRequest.Destroy;
begin
  SysUtils.FreeAndNil(Fuser);
  SysUtils.FreeAndNil(FrecordIdentifier);
  inherited Destroy;
end;

constructor protocolDetailResponse2.Create;
begin
  inherited Create;
  FSerializationOptions := [xoLiteralParam];
end;

destructor protocolDetailResponse2.Destroy;
begin
  SysUtils.FreeAndNil(Ferror);
  SysUtils.FreeAndNil(FprotocolDetail);
  inherited Destroy;
end;

procedure protocolDetailResponse2.Seterror(Index: Integer; const Aerror: error);
begin
  Ferror := Aerror;
  Ferror_Specified := True;
end;

function protocolDetailResponse2.error_Specified(Index: Integer): boolean;
begin
  Result := Ferror_Specified;
end;

constructor availableOfficesAndRegistriesRequest.Create;
begin
  inherited Create;
  FSerializationOptions := [xoLiteralParam];
end;

destructor availableOfficesAndRegistriesRequest.Destroy;
begin
  SysUtils.FreeAndNil(Fuser);
  inherited Destroy;
end;

constructor protocolResponse.Create;
begin
  inherited Create;
  FSerializationOptions := [xoLiteralParam];
end;

destructor protocolResponse.Destroy;
var
  I: Integer;
begin
  for I := 0 to System.Length(FrecordIdentifierList)-1 do
    SysUtils.FreeAndNil(FrecordIdentifierList[I]);
  System.SetLength(FrecordIdentifierList, 0);
  SysUtils.FreeAndNil(Ferror);
  inherited Destroy;
end;

procedure protocolResponse.Seterror(Index: Integer; const Aerror: error);
begin
  Ferror := Aerror;
  Ferror_Specified := True;
end;

function protocolResponse.error_Specified(Index: Integer): boolean;
begin
  Result := Ferror_Specified;
end;

procedure protocolResponse.SetrecordIdentifierList(Index: Integer; const ArecordIdentifierList: recordIdentifierList);
begin
  FrecordIdentifierList := ArecordIdentifierList;
  FrecordIdentifierList_Specified := True;
end;

function protocolResponse.recordIdentifierList_Specified(Index: Integer): boolean;
begin
  Result := FrecordIdentifierList_Specified;
end;

procedure error.Setcode(Index: Integer; const Astring: string);
begin
  Fcode := Astring;
  Fcode_Specified := True;
end;

function error.code_Specified(Index: Integer): boolean;
begin
  Result := Fcode_Specified;
end;

procedure error.Setdescription(Index: Integer; const Astring: string);
begin
  Fdescription := Astring;
  Fdescription_Specified := True;
end;

function error.description_Specified(Index: Integer): boolean;
begin
  Result := Fdescription_Specified;
end;

constructor availableOfficesAndRegistriesResponse2.Create;
begin
  inherited Create;
  FSerializationOptions := [xoLiteralParam];
end;

destructor availableOfficesAndRegistriesResponse2.Destroy;
var
  I: Integer;
begin
  for I := 0 to System.Length(FoperatingOfficeList)-1 do
    SysUtils.FreeAndNil(FoperatingOfficeList[I]);
  System.SetLength(FoperatingOfficeList, 0);
  SysUtils.FreeAndNil(Fuser);
  SysUtils.FreeAndNil(Ferror);
  inherited Destroy;
end;

procedure availableOfficesAndRegistriesResponse2.Setresult(Index: Integer; const ABoolean: Boolean);
begin
  Fresult := ABoolean;
  Fresult_Specified := True;
end;

function availableOfficesAndRegistriesResponse2.result_Specified(Index: Integer): boolean;
begin
  Result := Fresult_Specified;
end;

procedure availableOfficesAndRegistriesResponse2.Seterror(Index: Integer; const Aerror: error);
begin
  Ferror := Aerror;
  Ferror_Specified := True;
end;

function availableOfficesAndRegistriesResponse2.error_Specified(Index: Integer): boolean;
begin
  Result := Ferror_Specified;
end;

procedure availableOfficesAndRegistriesResponse2.SetoperatingOfficeList(Index: Integer; const AoperatingOfficeList: operatingOfficeList);
begin
  FoperatingOfficeList := AoperatingOfficeList;
  FoperatingOfficeList_Specified := True;
end;

function availableOfficesAndRegistriesResponse2.operatingOfficeList_Specified(Index: Integer): boolean;
begin
  Result := FoperatingOfficeList_Specified;
end;

destructor operatingOfficeBasicInformation.Destroy;
var
  I: Integer;
begin
  for I := 0 to System.Length(FofficeList)-1 do
    SysUtils.FreeAndNil(FofficeList[I]);
  System.SetLength(FofficeList, 0);
  inherited Destroy;
end;

procedure operatingOfficeBasicInformation.SetofficeList(Index: Integer; const AofficeList: officeList);
begin
  FofficeList := AofficeList;
  FofficeList_Specified := True;
end;

function operatingOfficeBasicInformation.officeList_Specified(Index: Integer): boolean;
begin
  Result := FofficeList_Specified;
end;

constructor protocolInsertRequest.Create;
begin
  inherited Create;
  FSerializationOptions := [xoLiteralParam];
end;

destructor protocolInsertRequest.Destroy;
var
  I: Integer;
begin
  for I := 0 to System.Length(FsenderList)-1 do
    SysUtils.FreeAndNil(FsenderList[I]);
  System.SetLength(FsenderList, 0);
  for I := 0 to System.Length(FrecipientList)-1 do
    SysUtils.FreeAndNil(FrecipientList[I]);
  System.SetLength(FrecipientList, 0);
  for I := 0 to System.Length(FofficeList)-1 do
    SysUtils.FreeAndNil(FofficeList[I]);
  System.SetLength(FofficeList, 0);
  for I := 0 to System.Length(FdocumentList)-1 do
    SysUtils.FreeAndNil(FdocumentList[I]);
  System.SetLength(FdocumentList, 0);
  for I := 0 to System.Length(FexternalDocumentList)-1 do
    SysUtils.FreeAndNil(FexternalDocumentList[I]);
  System.SetLength(FexternalDocumentList, 0);
  for I := 0 to System.Length(FfilingList)-1 do
    SysUtils.FreeAndNil(FfilingList[I]);
  System.SetLength(FfilingList, 0);
  for I := 0 to System.Length(FmnemonicList)-1 do
    SysUtils.FreeAndNil(FmnemonicList[I]);
  System.SetLength(FmnemonicList, 0);
  for I := 0 to System.Length(FpreviousList)-1 do
    SysUtils.FreeAndNil(FpreviousList[I]);
  System.SetLength(FpreviousList, 0);
  for I := 0 to System.Length(FdossierList)-1 do
    SysUtils.FreeAndNil(FdossierList[I]);
  System.SetLength(FdossierList, 0);
  SysUtils.FreeAndNil(Fuser);
  SysUtils.FreeAndNil(FreceptionSendingDate);
  SysUtils.FreeAndNil(FdocumentDetails);
  SysUtils.FreeAndNil(FretrieveAttachments);
  inherited Destroy;
end;

procedure protocolInsertRequest.SetsubjectDocument(Index: Integer; const Astring: string);
begin
  FsubjectDocument := Astring;
  FsubjectDocument_Specified := True;
end;

function protocolInsertRequest.subjectDocument_Specified(Index: Integer): boolean;
begin
  Result := FsubjectDocument_Specified;
end;

procedure protocolInsertRequest.SetsubjectProtocol(Index: Integer; const Astring: string);
begin
  FsubjectProtocol := Astring;
  FsubjectProtocol_Specified := True;
end;

function protocolInsertRequest.subjectProtocol_Specified(Index: Integer): boolean;
begin
  Result := FsubjectProtocol_Specified;
end;

procedure protocolInsertRequest.SetreceptionSendingDate(Index: Integer; const ATXSDateTime: TXSDateTime);
begin
  FreceptionSendingDate := ATXSDateTime;
  FreceptionSendingDate_Specified := True;
end;

function protocolInsertRequest.receptionSendingDate_Specified(Index: Integer): boolean;
begin
  Result := FreceptionSendingDate_Specified;
end;

procedure protocolInsertRequest.SettypeSenderMail(Index: Integer; const AInteger: Integer);
begin
  FtypeSenderMail := AInteger;
  FtypeSenderMail_Specified := True;
end;

function protocolInsertRequest.typeSenderMail_Specified(Index: Integer): boolean;
begin
  Result := FtypeSenderMail_Specified;
end;

procedure protocolInsertRequest.SetdocumentDetails(Index: Integer; const AdocumentDetails: documentDetails);
begin
  FdocumentDetails := AdocumentDetails;
  FdocumentDetails_Specified := True;
end;

function protocolInsertRequest.documentDetails_Specified(Index: Integer): boolean;
begin
  Result := FdocumentDetails_Specified;
end;

procedure protocolInsertRequest.SetprocessAct(Index: Integer; const ABoolean: Boolean);
begin
  FprocessAct := ABoolean;
  FprocessAct_Specified := True;
end;

function protocolInsertRequest.processAct_Specified(Index: Integer): boolean;
begin
  Result := FprocessAct_Specified;
end;

procedure protocolInsertRequest.SetretrieveAttachments(Index: Integer; const ArecordIdentifier: recordIdentifier);
begin
  FretrieveAttachments := ArecordIdentifier;
  FretrieveAttachments_Specified := True;
end;

function protocolInsertRequest.retrieveAttachments_Specified(Index: Integer): boolean;
begin
  Result := FretrieveAttachments_Specified;
end;

procedure protocolInsertRequest.SetsenderList(Index: Integer; const AsenderList2: senderList2);
begin
  FsenderList := AsenderList2;
  FsenderList_Specified := True;
end;

function protocolInsertRequest.senderList_Specified(Index: Integer): boolean;
begin
  Result := FsenderList_Specified;
end;

procedure protocolInsertRequest.SetrecipientList(Index: Integer; const ArecipientList2: recipientList2);
begin
  FrecipientList := ArecipientList2;
  FrecipientList_Specified := True;
end;

function protocolInsertRequest.recipientList_Specified(Index: Integer): boolean;
begin
  Result := FrecipientList_Specified;
end;

procedure protocolInsertRequest.SetofficeList(Index: Integer; const AofficeList4: officeList4);
begin
  FofficeList := AofficeList4;
  FofficeList_Specified := True;
end;

function protocolInsertRequest.officeList_Specified(Index: Integer): boolean;
begin
  Result := FofficeList_Specified;
end;

procedure protocolInsertRequest.SetdocumentList(Index: Integer; const AdocumentList3: documentList3);
begin
  FdocumentList := AdocumentList3;
  FdocumentList_Specified := True;
end;

function protocolInsertRequest.documentList_Specified(Index: Integer): boolean;
begin
  Result := FdocumentList_Specified;
end;

procedure protocolInsertRequest.SetexternalDocumentList(Index: Integer; const AexternalDocumentList3: externalDocumentList3);
begin
  FexternalDocumentList := AexternalDocumentList3;
  FexternalDocumentList_Specified := True;
end;

function protocolInsertRequest.externalDocumentList_Specified(Index: Integer): boolean;
begin
  Result := FexternalDocumentList_Specified;
end;

procedure protocolInsertRequest.SetfilingList(Index: Integer; const AfilingList5: filingList5);
begin
  FfilingList := AfilingList5;
  FfilingList_Specified := True;
end;

function protocolInsertRequest.filingList_Specified(Index: Integer): boolean;
begin
  Result := FfilingList_Specified;
end;

procedure protocolInsertRequest.SetmnemonicList(Index: Integer; const AmnemonicList3: mnemonicList3);
begin
  FmnemonicList := AmnemonicList3;
  FmnemonicList_Specified := True;
end;

function protocolInsertRequest.mnemonicList_Specified(Index: Integer): boolean;
begin
  Result := FmnemonicList_Specified;
end;

procedure protocolInsertRequest.SetpreviousList(Index: Integer; const ApreviousList3: previousList3);
begin
  FpreviousList := ApreviousList3;
  FpreviousList_Specified := True;
end;

function protocolInsertRequest.previousList_Specified(Index: Integer): boolean;
begin
  Result := FpreviousList_Specified;
end;

procedure protocolInsertRequest.SetdossierList(Index: Integer; const AdossierList3: dossierList3);
begin
  FdossierList := AdossierList3;
  FdossierList_Specified := True;
end;

function protocolInsertRequest.dossierList_Specified(Index: Integer): boolean;
begin
  Result := FdossierList_Specified;
end;

initialization
  { ProtocolloServicePortType }
  InvRegistry.RegisterInterface(TypeInfo(ProtocolloServicePortType), 'http://insielmercato.it/protocollo-ws/services/protocolloService', 'UTF-8');
  InvRegistry.RegisterDefaultSOAPAction(TypeInfo(ProtocolloServicePortType), 'ProtocolloServicePortType#%operationName%');
  InvRegistry.RegisterInvokeOptions(TypeInfo(ProtocolloServicePortType), ioDocument);
  InvRegistry.RegisterInvokeOptions(TypeInfo(ProtocolloServicePortType), ioLiteral);
  RemClassRegistry.RegisterXSInfo(TypeInfo(registryList), 'http://insielmercato.it/protocollo-ws/data/common', 'registryList');
  RemClassRegistry.RegisterXSInfo(TypeInfo(officeList), 'http://insielmercato.it/protocollo-ws/data/common', 'officeList');
  RemClassRegistry.RegisterXSInfo(TypeInfo(mnemonicLevelList), 'http://insielmercato.it/protocollo-ws/data/common', 'mnemonicLevelList');
  RemClassRegistry.RegisterXSInfo(TypeInfo(documentList), 'http://insielmercato.it/protocollo-ws/data/common', 'documentList');
  RemClassRegistry.RegisterXSInfo(TypeInfo(externalDocumentList), 'http://insielmercato.it/protocollo-ws/data/common', 'externalDocumentList');
  RemClassRegistry.RegisterXSInfo(TypeInfo(officeList2), 'http://insielmercato.it/protocollo-ws/data/common', 'officeList2', 'officeList');
  RemClassRegistry.RegisterXSInfo(TypeInfo(senderList), 'http://insielmercato.it/protocollo-ws/data/common', 'senderList');
  RemClassRegistry.RegisterXSInfo(TypeInfo(recipientList), 'http://insielmercato.it/protocollo-ws/data/common', 'recipientList');
  RemClassRegistry.RegisterXSInfo(TypeInfo(filingList2), 'http://insielmercato.it/protocollo-ws/data/filing', 'filingList2', 'filingList');
  RemClassRegistry.RegisterXSClass(filingRequest, 'http://insielmercato.it/protocollo-ws/data/filing', 'filingRequest');
  RemClassRegistry.RegisterSerializeOptions(filingRequest, [xoLiteralParam]);
  RemClassRegistry.RegisterXSInfo(TypeInfo(levelList), 'http://insielmercato.it/protocollo-ws/data/common', 'levelList');
  RemClassRegistry.RegisterXSInfo(TypeInfo(direction), 'http://insielmercato.it/protocollo-ws/data/common', 'direction');
  RemClassRegistry.RegisterXSInfo(TypeInfo(filingList3), 'http://insielmercato.it/protocollo-ws/data/common', 'filingList3', 'filingList');
  RemClassRegistry.RegisterXSInfo(TypeInfo(dossierList), 'http://insielmercato.it/protocollo-ws/data/common', 'dossierList');
  RemClassRegistry.RegisterXSInfo(TypeInfo(mnemonicList), 'http://insielmercato.it/protocollo-ws/data/common', 'mnemonicList');
  RemClassRegistry.RegisterXSInfo(TypeInfo(previousList), 'http://insielmercato.it/protocollo-ws/data/common', 'previousList');
  RemClassRegistry.RegisterXSInfo(TypeInfo(emailAccreditation), 'http://insielmercato.it/protocollo-ws/data/anagrafic', 'emailAccreditation');
  RemClassRegistry.RegisterXSClass(anagraficRequest, 'http://insielmercato.it/protocollo-ws/data/anagrafic', 'anagraficRequest');
  RemClassRegistry.RegisterSerializeOptions(anagraficRequest, [xoLiteralParam]);
  RemClassRegistry.RegisterXSClass(anagraficList, 'http://insielmercato.it/protocollo-ws/services/protocolloService', 'anagraficList');
  RemClassRegistry.RegisterXSClass(filingList, 'http://insielmercato.it/protocollo-ws/services/protocolloService', 'filingList');
  RemClassRegistry.RegisterXSInfo(TypeInfo(anagraficList2), 'http://insielmercato.it/protocollo-ws/data/anagrafic', 'anagraficList2', 'anagraficList');
  RemClassRegistry.RegisterXSInfo(TypeInfo(filingList4), 'http://insielmercato.it/protocollo-ws/data/protocol', 'filingList4', 'filingList');
  RemClassRegistry.RegisterXSInfo(TypeInfo(externalDocumentList2), 'http://insielmercato.it/protocollo-ws/data/protocol', 'externalDocumentList2', 'externalDocumentList');
  RemClassRegistry.RegisterXSInfo(TypeInfo(documentList2), 'http://insielmercato.it/protocollo-ws/data/protocol', 'documentList2', 'documentList');
  RemClassRegistry.RegisterXSInfo(TypeInfo(dossierList2), 'http://insielmercato.it/protocollo-ws/data/protocol', 'dossierList2', 'dossierList');
  RemClassRegistry.RegisterXSInfo(TypeInfo(previousList2), 'http://insielmercato.it/protocollo-ws/data/protocol', 'previousList2', 'previousList');
  RemClassRegistry.RegisterXSInfo(TypeInfo(mnemonicList2), 'http://insielmercato.it/protocollo-ws/data/protocol', 'mnemonicList2', 'mnemonicList');
  RemClassRegistry.RegisterXSClass(mnemonic, 'http://insielmercato.it/protocollo-ws/data/common', 'mnemonic');
  RemClassRegistry.RegisterExternalPropName(TypeInfo(mnemonic), 'mnemonicLevelList', '[ArrayItemName="mnemonicLevel"]');
  RemClassRegistry.RegisterXSClass(user, 'http://insielmercato.it/protocollo-ws/data/common', 'user');
  RemClassRegistry.RegisterXSClass(recordIdentifier, 'http://insielmercato.it/protocollo-ws/data/common', 'recordIdentifier');
  RemClassRegistry.RegisterXSClass(level, 'http://insielmercato.it/protocollo-ws/data/common', 'level');
  RemClassRegistry.RegisterExternalPropName(TypeInfo(level), 'index_', '[ExtName="index"]');
  RemClassRegistry.RegisterXSClass(protocolListRequest, 'http://insielmercato.it/protocollo-ws/data/protocol', 'protocolListRequest');
  RemClassRegistry.RegisterSerializeOptions(protocolListRequest, [xoLiteralParam]);
  RemClassRegistry.RegisterXSClass(protocolList, 'http://insielmercato.it/protocollo-ws/services/protocolloService', 'protocolList');
  RemClassRegistry.RegisterXSClass(protocolDetail2, 'http://insielmercato.it/protocollo-ws/data/common', 'protocolDetail2', 'protocolDetail');
  RemClassRegistry.RegisterExternalPropName(TypeInfo(protocolDetail2), 'senderList', '[ArrayItemName="sender"]');
  RemClassRegistry.RegisterExternalPropName(TypeInfo(protocolDetail2), 'recipientList', '[ArrayItemName="recipient"]');
  RemClassRegistry.RegisterExternalPropName(TypeInfo(protocolDetail2), 'officeList', '[ArrayItemName="office"]');
  RemClassRegistry.RegisterExternalPropName(TypeInfo(protocolDetail2), 'documentList', '[ArrayItemName="document"]');
  RemClassRegistry.RegisterExternalPropName(TypeInfo(protocolDetail2), 'externalDocumentList', '[ArrayItemName="externalDocument"]');
  RemClassRegistry.RegisterExternalPropName(TypeInfo(protocolDetail2), 'filingList', '[ArrayItemName="filing"]');
  RemClassRegistry.RegisterExternalPropName(TypeInfo(protocolDetail2), 'mnemonicList', '[ArrayItemName="mnemonic"]');
  RemClassRegistry.RegisterExternalPropName(TypeInfo(protocolDetail2), 'previousList', '[ArrayItemName="previous"]');
  RemClassRegistry.RegisterExternalPropName(TypeInfo(protocolDetail2), 'dossierList', '[ArrayItemName="dossier"]');
  RemClassRegistry.RegisterXSClass(mnemonicLevel, 'http://insielmercato.it/protocollo-ws/data/common', 'mnemonicLevel');
  RemClassRegistry.RegisterExternalPropName(TypeInfo(mnemonicLevel), 'index_', '[ExtName="index"]');
  RemClassRegistry.RegisterXSInfo(TypeInfo(officeList3), 'http://insielmercato.it/protocollo-ws/data/protocol', 'officeList3', 'officeList');
  RemClassRegistry.RegisterXSClass(protocolUpdateRequest, 'http://insielmercato.it/protocollo-ws/data/protocol', 'protocolUpdateRequest');
  RemClassRegistry.RegisterExternalPropName(TypeInfo(protocolUpdateRequest), 'officeList', '[ArrayItemName="office"]');
  RemClassRegistry.RegisterExternalPropName(TypeInfo(protocolUpdateRequest), 'documentList', '[ArrayItemName="document"]');
  RemClassRegistry.RegisterExternalPropName(TypeInfo(protocolUpdateRequest), 'externalDocumentList', '[ArrayItemName="externalDocument"]');
  RemClassRegistry.RegisterExternalPropName(TypeInfo(protocolUpdateRequest), 'filingList', '[ArrayItemName="filing"]');
  RemClassRegistry.RegisterExternalPropName(TypeInfo(protocolUpdateRequest), 'mnemonicList', '[ArrayItemName="mnemonic"]');
  RemClassRegistry.RegisterExternalPropName(TypeInfo(protocolUpdateRequest), 'previousList', '[ArrayItemName="previous"]');
  RemClassRegistry.RegisterExternalPropName(TypeInfo(protocolUpdateRequest), 'dossierList', '[ArrayItemName="dossier"]');
  RemClassRegistry.RegisterSerializeOptions(protocolUpdateRequest, [xoLiteralParam]);
  RemClassRegistry.RegisterXSClass(protocolUpdate, 'http://insielmercato.it/protocollo-ws/services/protocolloService', 'protocolUpdate');
  RemClassRegistry.RegisterXSClass(previous, 'http://insielmercato.it/protocollo-ws/data/common', 'previous');
  RemClassRegistry.RegisterXSClass(filing, 'http://insielmercato.it/protocollo-ws/data/common', 'filing');
  RemClassRegistry.RegisterExternalPropName(TypeInfo(filing), 'levelList', '[ArrayItemName="level"]');
  RemClassRegistry.RegisterXSClass(document, 'http://insielmercato.it/protocollo-ws/data/common', 'document');
  RemClassRegistry.RegisterExternalPropName(TypeInfo(document), 'name_', '[ExtName="name"]');
  RemClassRegistry.RegisterExternalPropName(TypeInfo(document), 'file_', '[ExtName="file"]');
  RemClassRegistry.RegisterXSClass(externalDocument, 'http://insielmercato.it/protocollo-ws/data/common', 'externalDocument');
  RemClassRegistry.RegisterExternalPropName(TypeInfo(externalDocument), 'name_', '[ExtName="name"]');
  RemClassRegistry.RegisterXSClass(anagraficResponse, 'http://insielmercato.it/protocollo-ws/data/anagrafic', 'anagraficResponse');
  RemClassRegistry.RegisterExternalPropName(TypeInfo(anagraficResponse), 'anagraficList', '[ArrayItemName="anagrafic"]');
  RemClassRegistry.RegisterSerializeOptions(anagraficResponse, [xoLiteralParam]);
  RemClassRegistry.RegisterXSClass(anagraficListResponse, 'http://insielmercato.it/protocollo-ws/services/protocolloService', 'anagraficListResponse');
  RemClassRegistry.RegisterXSClass(anagrafic, 'http://insielmercato.it/protocollo-ws/data/common', 'anagrafic');
  RemClassRegistry.RegisterExternalPropName(TypeInfo(anagrafic), 'name_', '[ExtName="name"]');
  RemClassRegistry.RegisterXSClass(correspondent, 'http://insielmercato.it/protocollo-ws/data/common', 'correspondent');
  RemClassRegistry.RegisterXSClass(office, 'http://insielmercato.it/protocollo-ws/data/common', 'office');
  RemClassRegistry.RegisterXSClass(filingResponse, 'http://insielmercato.it/protocollo-ws/data/filing', 'filingResponse');
  RemClassRegistry.RegisterExternalPropName(TypeInfo(filingResponse), 'filingList', '[ArrayItemName="filing"]');
  RemClassRegistry.RegisterSerializeOptions(filingResponse, [xoLiteralParam]);
  RemClassRegistry.RegisterXSClass(filingListResponse, 'http://insielmercato.it/protocollo-ws/services/protocolloService', 'filingListResponse');
  RemClassRegistry.RegisterXSClass(registry, 'http://insielmercato.it/protocollo-ws/data/common', 'registry');
  RemClassRegistry.RegisterXSClass(officeBasicInformation, 'http://insielmercato.it/protocollo-ws/data/common', 'officeBasicInformation');
  RemClassRegistry.RegisterExternalPropName(TypeInfo(officeBasicInformation), 'registryList', '[ArrayItemName="registry"]');
  RemClassRegistry.RegisterXSClass(documentDetails, 'http://insielmercato.it/protocollo-ws/data/common', 'documentDetails');
  RemClassRegistry.RegisterXSClass(measureDetails, 'http://insielmercato.it/protocollo-ws/data/common', 'measureDetails');
  RemClassRegistry.RegisterXSClass(dossier, 'http://insielmercato.it/protocollo-ws/data/common', 'dossier');
  RemClassRegistry.RegisterXSInfo(TypeInfo(documentList3), 'http://insielmercato.it/protocollo-ws/data/protocol', 'documentList3', 'documentList');
  RemClassRegistry.RegisterXSInfo(TypeInfo(externalDocumentList3), 'http://insielmercato.it/protocollo-ws/data/protocol', 'externalDocumentList3', 'externalDocumentList');
  RemClassRegistry.RegisterXSInfo(TypeInfo(officeList4), 'http://insielmercato.it/protocollo-ws/data/protocol', 'officeList4', 'officeList');
  RemClassRegistry.RegisterXSInfo(TypeInfo(recipientList2), 'http://insielmercato.it/protocollo-ws/data/protocol', 'recipientList2', 'recipientList');
  RemClassRegistry.RegisterXSClass(recipient, 'http://insielmercato.it/protocollo-ws/data/common', 'recipient');
  RemClassRegistry.RegisterXSInfo(TypeInfo(filingList5), 'http://insielmercato.it/protocollo-ws/data/protocol', 'filingList5', 'filingList');
  RemClassRegistry.RegisterXSClass(protocolDetailRequest, 'http://insielmercato.it/protocollo-ws/data/protocol', 'protocolDetailRequest');
  RemClassRegistry.RegisterSerializeOptions(protocolDetailRequest, [xoLiteralParam]);
  RemClassRegistry.RegisterXSClass(protocolDetail, 'http://insielmercato.it/protocollo-ws/services/protocolloService', 'protocolDetail');
  RemClassRegistry.RegisterXSClass(protocolDetailResponse2, 'http://insielmercato.it/protocollo-ws/data/protocol', 'protocolDetailResponse2', 'protocolDetailResponse');
  RemClassRegistry.RegisterSerializeOptions(protocolDetailResponse2, [xoLiteralParam]);
  RemClassRegistry.RegisterXSClass(protocolDetailResponse, 'http://insielmercato.it/protocollo-ws/services/protocolloService', 'protocolDetailResponse');
  RemClassRegistry.RegisterXSInfo(TypeInfo(dossierList3), 'http://insielmercato.it/protocollo-ws/data/protocol', 'dossierList3', 'dossierList');
  RemClassRegistry.RegisterXSInfo(TypeInfo(mnemonicList3), 'http://insielmercato.it/protocollo-ws/data/protocol', 'mnemonicList3', 'mnemonicList');
  RemClassRegistry.RegisterXSInfo(TypeInfo(previousList3), 'http://insielmercato.it/protocollo-ws/data/protocol', 'previousList3', 'previousList');
  RemClassRegistry.RegisterXSClass(availableOfficesAndRegistriesRequest, 'http://insielmercato.it/protocollo-ws/data/protocol', 'availableOfficesAndRegistriesRequest');
  RemClassRegistry.RegisterSerializeOptions(availableOfficesAndRegistriesRequest, [xoLiteralParam]);
  RemClassRegistry.RegisterXSClass(availableOfficesAndRegistries, 'http://insielmercato.it/protocollo-ws/services/protocolloService', 'availableOfficesAndRegistries');
  RemClassRegistry.RegisterXSInfo(TypeInfo(recordIdentifierList), 'http://insielmercato.it/protocollo-ws/data/protocol', 'recordIdentifierList');
  RemClassRegistry.RegisterXSClass(protocolResponse, 'http://insielmercato.it/protocollo-ws/data/protocol', 'protocolResponse');
  RemClassRegistry.RegisterExternalPropName(TypeInfo(protocolResponse), 'recordIdentifierList', '[ArrayItemName="recordIdentifier"]');
  RemClassRegistry.RegisterSerializeOptions(protocolResponse, [xoLiteralParam]);
  RemClassRegistry.RegisterXSClass(protocolListResponse, 'http://insielmercato.it/protocollo-ws/services/protocolloService', 'protocolListResponse');
  RemClassRegistry.RegisterXSClass(protocolUpdateResponse, 'http://insielmercato.it/protocollo-ws/services/protocolloService', 'protocolUpdateResponse');
  RemClassRegistry.RegisterXSClass(protocolInsertResponse, 'http://insielmercato.it/protocollo-ws/services/protocolloService', 'protocolInsertResponse');
  RemClassRegistry.RegisterXSClass(error, 'http://insielmercato.it/protocollo-ws/data/common', 'error');
  RemClassRegistry.RegisterXSInfo(TypeInfo(operatingOfficeList), 'http://insielmercato.it/protocollo-ws/data/protocol', 'operatingOfficeList');
  RemClassRegistry.RegisterXSClass(availableOfficesAndRegistriesResponse2, 'http://insielmercato.it/protocollo-ws/data/protocol', 'availableOfficesAndRegistriesResponse2', 'availableOfficesAndRegistriesResponse');
  RemClassRegistry.RegisterExternalPropName(TypeInfo(availableOfficesAndRegistriesResponse2), 'operatingOfficeList', '[ArrayItemName="operatingOffice"]');
  RemClassRegistry.RegisterSerializeOptions(availableOfficesAndRegistriesResponse2, [xoLiteralParam]);
  RemClassRegistry.RegisterXSClass(availableOfficesAndRegistriesResponse, 'http://insielmercato.it/protocollo-ws/services/protocolloService', 'availableOfficesAndRegistriesResponse');
  RemClassRegistry.RegisterXSInfo(TypeInfo(senderList2), 'http://insielmercato.it/protocollo-ws/data/protocol', 'senderList2', 'senderList');
  RemClassRegistry.RegisterXSClass(sender, 'http://insielmercato.it/protocollo-ws/data/common', 'sender');
  RemClassRegistry.RegisterXSInfo(TypeInfo(direction2), 'http://insielmercato.it/protocollo-ws/data/protocol', 'direction2', 'direction');
  RemClassRegistry.RegisterXSClass(operatingOfficeBasicInformation, 'http://insielmercato.it/protocollo-ws/data/common', 'operatingOfficeBasicInformation');
  RemClassRegistry.RegisterExternalPropName(TypeInfo(operatingOfficeBasicInformation), 'officeList', '[ArrayItemName="office"]');
  RemClassRegistry.RegisterXSClass(protocolInsertRequest, 'http://insielmercato.it/protocollo-ws/data/protocol', 'protocolInsertRequest');
  RemClassRegistry.RegisterExternalPropName(TypeInfo(protocolInsertRequest), 'senderList', '[ArrayItemName="sender"]');
  RemClassRegistry.RegisterExternalPropName(TypeInfo(protocolInsertRequest), 'recipientList', '[ArrayItemName="recipient"]');
  RemClassRegistry.RegisterExternalPropName(TypeInfo(protocolInsertRequest), 'officeList', '[ArrayItemName="office"]');
  RemClassRegistry.RegisterExternalPropName(TypeInfo(protocolInsertRequest), 'documentList', '[ArrayItemName="document"]');
  RemClassRegistry.RegisterExternalPropName(TypeInfo(protocolInsertRequest), 'externalDocumentList', '[ArrayItemName="externalDocument"]');
  RemClassRegistry.RegisterExternalPropName(TypeInfo(protocolInsertRequest), 'filingList', '[ArrayItemName="filing"]');
  RemClassRegistry.RegisterExternalPropName(TypeInfo(protocolInsertRequest), 'mnemonicList', '[ArrayItemName="mnemonic"]');
  RemClassRegistry.RegisterExternalPropName(TypeInfo(protocolInsertRequest), 'previousList', '[ArrayItemName="previous"]');
  RemClassRegistry.RegisterExternalPropName(TypeInfo(protocolInsertRequest), 'dossierList', '[ArrayItemName="dossier"]');
  RemClassRegistry.RegisterSerializeOptions(protocolInsertRequest, [xoLiteralParam]);
  RemClassRegistry.RegisterXSClass(protocolInsert, 'http://insielmercato.it/protocollo-ws/services/protocolloService', 'protocolInsert');

end.