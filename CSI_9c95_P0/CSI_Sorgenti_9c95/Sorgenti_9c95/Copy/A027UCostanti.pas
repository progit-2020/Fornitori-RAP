unit A027UCostanti;

interface

uses Classes, Variants;

type TDett = record
       N:Word;       //Posizione in A027UCarMen.MatDettStampa
       W:Byte;       //Lunghezza di default
       F:Boolean;    //Fasce
       WW:Boolean;   //Word Wrap
       A:TAlignment; //Allineamento
       D:String;     //Descrizione del dato
     end;

     TRiep = record
       N:Word;   //Posizione in A027UCarMen.VetRiepStampa
       W:Byte;   //Lunghezza di default
       D:String; //Descrizione del dato
     end;

     TDatiDett = array[1..41] of TDett;
     TDatiRiep = array[1..164] of TRiep;

const
    C_GG1=1;  //Giorno del mese
    C_TI1=2;  //E0800
    C_TI2=3;  //E0800x
    C_TI3=4;  //E0800-x
    C_TI4=5;  //E0800-xxxxx
    C_TI5=6;  //E0800-rr
    C_TI6=7;  //E0800x-rr
    C_TI7=8;  //E0800-x-rr
    C_TI8=9;  //E0800-xxxxx-rr
    C_GI1=10; //Codice giustificativo
    C_GI2=11; //Descrizione giustificativo
    C_HL1=12; //Ore lavorate
    C_HL2=13; //Ore lavorate con totale
    C_HH1=14; //Ore lorde
    C_HH2=15; //Ore lorde con totale
    C_EC1=16; //Eccedenze in fasce
    C_EC2=17; //Eccedenze in fasce con totali
    C_SC1=18; //Scostamento giornaliero
    C_SC2=19; //Scostamento giornaliero con totale
    C_ORA=20; //Orario
    C_TR1=21; //Numero Turno
    C_FIL=22; //Filler
    C_TM1=23; //Timbratura di mensa
    C_TR2=24; //Sigla Turno
    C_ANM=25; //Anomalia bloccante
    C_SN1=26; //Scostamento negativo
    C_SN2=27; //Scostamento negativo con totale
    C_DG1=28; //Debito giornaliero
    C_DG2=29; //Debito giornaliero con totale
    C_SP1=30; //Scostamento positivo
    C_SP2=31; //Scostamento positivo con totale
    C_CM1=32; //Compensabile giornaliero
    C_CM2=33; //Compensabile giornaliero con totale
    C_LF1=34; //Ore lavorate in fasce
    C_LF2=35; //Ore lavorate in fasce con totale
    C_TRP=36; //Turni pianificati di reperibilità
    C_PRI1=37; //Ore in prolungamento inibite
    C_PRI2=38; //Ore in prolungamento inibite con totale
    C_PRN1=39; //Ore in prolungamento non causalizzate
    C_PRN2=40; //Ore in prolungamento non causalizzate con totale
    C_PRT1=41; //Ore in prolungamento non conteggiate complessive
    C_PRT2=42; //Ore in prolungamento non conteggiate complessive con totale
    C_PRU1=59; //Ore in prolungamento in uscita non causalizzate
    C_PRU2=60; //Ore in prolungamento in uscita non causalizzate con totale
    C_LPR=43; //Turni di libera professione
    C_CMNG1=44; //Compensabile + negativo
    C_CMNG2=45; //Compensabile + negativo con totale
    C_ESC1=46; //ore escluse dalle normali
    C_ESC2=47; //ore escluse dalle normali con totale
    C_OBR=48;  //Ore obbligatorie rese
    C_OBC=49;  //Ore obbligatorie carenti
    C_FAR=50;  //Ore facoltative rese
    C_FAC=51;  //Ore facoltative carenti
    C_FAS=52;  //Ore facoltative rese scostate dal (debito gg - fascia obbligatoria)
    C_PM1=53;  //Detrazione pausa mensa
    C_PM2=54;  //Detrazione pausa mensa con totale
    C_TRA=55;  //Turni pianificati di prestazione aggiuntiva  //LORENA 26/07/2004
    C_INDP1=56;  //Indennità presenza maturata  //LORENA 02/02/2005
    C_INDF1=57;  //Indennità festiva maturata  //LORENA 02/02/2005
    C_INDN1=58;  //Indennità notturna maturata  //LORENA 02/02/2005
    C_FENNG1=61; //Festività non godute
    C_FENNG2=62; //Festività non godute con totale
    C_PINT1=63; //Pasto intero
    C_PINT2=64; //Pasto intero con totale
    C_PCONV1=65; //Pasto convenzionato
    C_PCONV2=66; //Pasto convenzionato con totale
    C_CAU1=67; //Ore causalizzate
    C_CAU2=68; //Ore causalizzate con totale
    C_CMP=69; //Competenza mese successivo (per cartellino settimanale)
    C_IT1=70; //Ind.turno in fasce
    C_IT2=71; //Ind.turno in fasce con totale
    C_INDP2=72;  //Indennità presenza con totale
    C_INDF2=73;  //Indennità festiva con totale
    C_INDN2=74;  //Indennità notturna con totale
    C_NUMN1=75; //Num. notti
    C_NUMN2=76; //Num. notti con totale

    C_TOTALI_NO=[C_HL1,C_HH1,C_EC1,C_SC1,C_SN1,C_DG1,C_SP1,C_CM1,C_CMNG1,C_LF1,C_PRI1,C_PRN1,C_PRU1,C_PRT1,C_ESC1,C_PM1,C_FENNG1,C_PINT1,C_PCONV1,C_CAU1,C_IT1,C_INDP1,C_INDF1,C_INDN1,C_NUMN1];
    C_TOTALI_SI=[C_HL2,C_HH2,C_EC2,C_SC2,C_SN2,C_DG2,C_SP2,C_CM2,C_CMNG2,C_LF2,C_PRI2,C_PRN2,C_PRU2,C_PRT2,C_ESC2,C_PM2,C_FENNG2,C_PINT2,C_PCONV2,C_CAU2,C_IT2,C_INDP2,C_INDF2,C_INDN2,C_NUMN2];

    A027RPASS_I = 901;
    A027RPASS_F = 915;
    A027RPPRES_I = 951;
    A027RPPRES_F = 971;

    DatiDett:TDatiDett = ((N:C_GG1;  W:05;F:False;WW:False;A:taLeftJustify; D:'Giorno'),
                          (N:C_CMP;  W:04;F:False;WW:False;A:taLeftJustify; D:'Competenza istituti'),
                          (N:C_TI1;  W:24;F:False;WW:True ;A:taLeftJustify; D:'Timbrature'),
                          (N:C_GI1;  W:15;F:False;WW:True ;A:taLeftJustify; D:'Giustificativi'),
                          (N:C_HL1;  W:06;F:False;WW:False;A:taRightJustify;D:'Ore lavorate'),
                          (N:C_LF1;  W:24;F:True; WW:False;A:taLeftJustify; D:'Ore lavorate in fasce'),
                          (N:C_HH1;  W:06;F:False;WW:False;A:taRightJustify;D:'Ore lavorate lorde'),
                          (N:C_EC1;  W:24;F:True; WW:False;A:taLeftJustify; D:'Eccedenze in fasce'),
                          (N:C_SC1;  W:06;F:False;WW:False;A:taRightJustify;D:'Scostamento'),
                          (N:C_SN1;  W:06;F:False;WW:False;A:taRightJustify;D:'Scost.neg.'),
                          (N:C_SP1;  W:06;F:False;WW:False;A:taRightJustify;D:'Scost.pos.'),
                          (N:C_CM1;  W:06;F:False;WW:False;A:taRightJustify;D:'Compensabile'),
                          (N:C_CMNG1;W:06;F:False;WW:False;A:taRightJustify;D:'Compens. e negativo'),
                          (N:C_ESC1; W:06;F:False;WW:False;A:taRightJustify;D:'Ore escluse'),
                          (N:C_CAU1; W:06;F:False;WW:False;A:taRightJustify;D:'Ore causalizzate'),
                          (N:C_DG1;  W:06;F:False;WW:False;A:taRightJustify;D:'Debito'),
                          (N:C_ORA;  W:05;F:False;WW:False;A:taLeftJustify; D:'Orario'),
                          (N:C_TR1;  W:05;F:False;WW:False;A:taLeftJustify; D:'Turno'),
                          (N:C_TM1;  W:06;F:False;WW:False;A:taLeftJustify; D:'Timbrature di mensa'),
                          (N:C_PM1;  W:06;F:False;WW:False;A:taLeftJustify; D:'Detrazione mensa'),
                          (N:C_TRP;  W:05;F:False;WW:False;A:taLeftJustify; D:'Turni reperib./guardia'),
                          (N:C_TRA;  W:05;F:False;WW:False;A:taLeftJustify; D:'Turni prestaz.aggiuntive'),  //LORENA 26/07/2004
                          (N:C_LPR;  W:11;F:False;WW:False;A:taLeftJustify; D:'Libera professione'),
                          (N:C_PRI1; W:05;F:False;WW:False;A:taRightJustify;D:'Prol.inib.'),
                          (N:C_PRN1; W:05;F:False;WW:False;A:taRightJustify;D:'Prol.non caus.'),
                          (N:C_PRU1; W:05;F:False;WW:False;A:taRightJustify;D:'Prol.usc.non caus.'),
                          (N:C_PRT1; W:05;F:False;WW:False;A:taRightJustify;D:'Prol.non cont.'),
                          (N:C_OBR;  W:05;F:False;WW:False;A:taRightJustify;D:'Ore obbl.rese'),
                          (N:C_OBC;  W:05;F:False;WW:False;A:taRightJustify;D:'Ore obbl.carenti'),
                          (N:C_FAR;  W:05;F:False;WW:False;A:taRightJustify;D:'Ore facolt.rese'),
                          (N:C_FAC;  W:05;F:False;WW:False;A:taRightJustify;D:'Ore facolt.carenti'),
                          (N:C_FAS;  W:05;F:False;WW:False;A:taRightJustify;D:'Scost.ore facolt.'),
                          (N:C_INDP1; W:05;F:False;WW:False;A:taRightJustify;D:'Ind.presenza maturata'),  //LORENA 02/02/2005
                          (N:C_INDF1; W:05;F:False;WW:False;A:taRightJustify;D:'Ind.festiva maturata'),  //LORENA 02/02/2005
                          (N:C_INDN1; W:05;F:False;WW:False;A:taRightJustify;D:'Ind.notturna maturata'),  //LORENA 02/02/2005
                          (N:C_NUMN1; W:05;F:False;WW:False;A:taRightJustify;D:'Num.notti'),           //Numero notti
                          (N:C_IT1;  W:24;F:False;WW:False;A:taLeftJustify;D:'Ind.turno in fasce'),
                          (N:C_FIL;  W:06;F:False;WW:False;A:taLeftJustify; D:'Spazio'),
                          (N:C_FENNG1;W:05;F:False;WW:False;A:taRightJustify;D:'Festivita non goduta'),
                          (N:C_PINT1; W:06;F:False;WW:False;A:taRightJustify;D:'Pasto intero'),
                          (N:C_PCONV1;W:06;F:False;WW:False;A:taRightJustify;D:'Pasto convenzionato'));

    (*1..121 - Liberi: *)
    DatiRiep:TDatiRiep = ((N:001;W:25;D:'Debito mensile'),
                          (N:066;W:25;D:'Debito contrattuale'),
                          (N:067;W:25;D:'Debito aggiuntivo'),
                          (N:105;W:25;D:'Debito aggiuntivo annuo'),
                          (N:106;W:25;D:'Debito aggiuntivo residuo'),
                          (N:107;W:25;D:'Debito aggiuntivo reso mese'),
                          (N:108;W:25;D:'Debito aggiuntivo reso anno'),
                          (N:002;W:15;D:'Ore rese'),
                          (N:027;W:25;D:'Rese da assenza'),
                          (N:028;W:25;D:'Rese da presenza'),
                          (N:089;W:35;D:'Ore obbligatorie rese'),
                          (N:090;W:35;D:'Ore obbligatorie carenti'),
                          (N:091;W:35;D:'Ore facoltative rese'),
                          (N:092;W:35;D:'Ore facoltative carenti'),
                          (N:093;W:35;D:'Totale ore obbligatorie carenti'),
                          (N:094;W:35;D:'Scost. ore facoltative'),
                          (N:095;W:35;D:'Saldo ore facoltative'),
                          (N:032;W:31;D:'Straord.autorizzato anno'),
                          (N:082;W:31;D:'Straord.autorizzato mese'),
                          (N:026;W:34;D:'Ecced.residua autorizzata'),
                          (N:037;W:28;D:'Ore comp.anno prec.'),
                          (N:038;W:28;D:'Ore liq.anno prec.'),
                          (N:039;W:28;D:'Ore comp.anno att.'),
                          (N:040;W:28;D:'Ore liq.anno att.'),
                          (N:041;W:28;D:'Ore abbatt.anno prec.'),
                          (N:042;W:28;D:'Ore abbatt.anno att.'),
                          (N:043;W:28;D:'Comp+Liq anno prec.'),
                          (N:044;W:28;D:'Comp+Liq anno att.'),
                          (N:029;W:28;D:'Compensabile complessivo'),
                          (N:030;W:28;D:'Liquidabile complessivo'),
                          (N:081;W:28;D:'Ore perse periodiche'),
                          (N:019;W:28;D:'Ore troncate'),
                          (N:076;W:28;D:'Saldo anno liquidato'),
                          (N:083;W:28;D:'Variazioni saldo anno'),
                          (N:048;W:46;D:'Ore lavorate in fasce'),
                          (N:021;W:26;D:'Caus.Assestamento 1'),
                          (N:022;W:26;D:'Ore Assestamento 1'),
                          (N:023;W:26;D:'Caus.Assestamento 2'),
                          (N:024;W:26;D:'Ore Assestamento 2'),
                          (N:079;W:46;D:'Ore timbrate in fasce'),
                          (N:078;W:46;D:'Ore di turno in fasce'),
                          (N:077;W:25;D:'Ore di turno totali'),
                          (N:003;W:28;D:'Saldo mese liquid.'),
                          (N:018;W:28;D:'Saldo mese lordo'),
                          (N:045;W:28;D:'Saldo mese netto'),
                          (N:111;W:28;D:'Saldo mese netto con causali'),
                          (N:025;W:28;D:'Saldo al mese prec.'),
                          (N:049;W:28;D:'Saldo mese prec.netto'),
                          (N:072;W:28;D:'Liquidabile al mese prec.'),
                          (N:073;W:28;D:'Compensabile al mese prec.'),
                          (N:087;W:32;D:'Banca ore prec. al mese prec.'),
                          (N:084;W:32;D:'Banca ore att. al mese prec.'),
                          (N:074;W:32;D:'Banca ore al mese prec.'),
                          (N:110;W:46;D:'Banca ore maturata da inizio anno'),
                          (N:075;W:32;D:'Compensabile senza Banca ore al mese prec.'),
                          (N:116;W:28;D:'Ore permessi addebitate'),
                          (N:117;W:28;D:'Ore permessi da recuperare'),
                          (N:080;W:28;D:'Ore addebitate'),
                          (N:113;W:38;D:'Ore carenti oltre saldo neg.min.'),
                          (N:114;W:38;D:'Ore oltre saldo neg.min.recuperate'),
                          (N:088;W:28;D:'Ore escluse compensabili'),
                          (N:046;W:28;D:'Scost.neg.mese'),
                          (N:047;W:46;D:'Ecced. liquid. mese'),
                          (N:020;W:28;D:'Saldo anno precedente'),
                          (N:006;W:28;D:'Saldo complessivo'),
                          (N:050;W:28;D:'Saldo complessivo netto'),
                          (N:112;W:28;D:'Saldo annuale con causali'),
                          (N:004;W:46;D:'Liquidabile mensile'),
                          (N:005;W:46;D:'Liquidabile dell''anno'),
                          (N:007;W:46;D:'Liquidato nell''anno'),
                          (N:008;W:46;D:'Residuo liquidabile'),
                          (N:009;W:46;D:'Liquidato nel mese'),
                          (N:031;W:46;D:'Banca ore del mese'),
                          (N:033;W:32;D:'Banca ore liquidata nel mese'),
                          (N:070;W:32;D:'Banca ore recuperata nel mese'),
                          (N:034;W:32;D:'Banca ore liquidata nell''anno'),
                          (N:071;W:32;D:'Banca ore recuperata nell''anno'),
                          (N:085;W:32;D:'Banca ore residua prec.'),
                          (N:086;W:32;D:'Banca ore residua att.'),
                          (N:068;W:32;D:'Banca ore residua'),
                          (N:069;W:32;D:'Compensabile senza Banca ore'),
                          (N:115;W:46;D:'Banca ore da compensare del mese'),
                          (N:010;W:28;D:'Solo comp. del mese'),
                          (N:011;W:28;D:'Solo comp. dell''anno'),
                          (N:012;W:28;D:'Solo comp. residuo'),
                          (N:098;W:30;D:'Solo comp. mese residuo'),
                          (N:053;W:30;D:'Riposi comp. maturati'),
                          (N:054;W:30;D:'Riposi comp. abbattuti'),
                          (N:055;W:30;D:'Riposi comp. residui'),
                          (N:056;W:30;D:'Riposi comp. del mese'),
                          (N:060;W:30;D:'Riposi comp. mese prec.'),
                          (N:096;W:30;D:'Riposi non fruiti (gg)'),
                          (N:097;W:30;D:'Riposi non fruiti (ore)'),
                          (N:013;W:20;D:'Festività intere'),
                          (N:014;W:20;D:'Festività ridotte'),
                          (N:015;W:20;D:'Ind. notturna num.'),
                          (N:016;W:25;D:'Ind. notturna ore'),
                          (N:109;W:20;D:'Festivi non goduti'),
                          (N:118;W:30;D:'Rientri pomer. residui'),
                          (N:119;W:30;D:'Rientri pomer. dovuti'),
                          (N:120;W:30;D:'Rientri pomer. fatti'),
                          (N:121;W:30;D:'Rientri pomer. non fatti'),
                          (N:017;W:40;D:'Ind. presenza'),
                          (N:065;W:40;D:'Ore caus.a blocchi'),
                          //Buoni mensa & accessi mensa
                          (N:051;W:17;D:'Buoni pasto'),
                          (N:035;W:20;D:'Buoni acquistati'),
                          (N:052;W:20;D:'Ticket restaurant'),
                          (N:036;W:20;D:'Ticket acquistati'),
                          (N:099;W:20;D:'Buoni maturati totali'),
                          (N:100;W:20;D:'Ticket maturati totali'),
                          (N:101;W:20;D:'Buoni acquistati totali'),
                          (N:102;W:20;D:'Ticket acquistati totali'),
                          (N:103;W:20;D:'Buoni residui'),
                          (N:104;W:20;D:'Ticket residui'),
                          (N:057;W:23;D:'Accessi mensa'),
                          (N:058;W:23;D:'Pasti convenzionati'),
                          (N:059;W:23;D:'Pasti interi'),
                          //Turni di reperibilità
                          (N:061;W:32;D:'Turni reperibilità'),
                          (N:062;W:32;D:'Ore reperibilità'),
                          (N:063;W:32;D:'Ore magg.reperibilità'),
                          (N:064;W:32;D:'Ore non magg.reperibilità'),
                          //Dati di riepilogo assenze
                          (N:901;W:06;D:'Codice assenze'),
                          (N:908;W:15;D:'Descrizione assenze'),
                          (N:902;W:06;D:'Assenze del mese'),
                          (N:903;W:06;D:'Comp.totali'),
                          (N:904;W:06;D:'Comp.prec.'),
                          (N:905;W:06;D:'Comp.corr.'),
                          (N:906;W:06;D:'Fruito'),
                          (N:909;W:06;D:'Fruito prec.'),
                          (N:910;W:06;D:'Fruito corr.'),
                          (N:907;W:06;D:'Residuo'),
                          (N:916;W:06;D:'Residuo prec.'),
                          (N:917;W:06;D:'Residuo corr.'),
                          (N:911;W:06;D:'Comp.in gg'),
                          (N:912;W:06;D:'Fruito in gg'),
                          (N:913;W:06;D:'Resid.in gg'),
                          (N:914;W:06;D:'Comp.parziale'),
                          (N:915;W:06;D:'Resid.parziale'),
                          //Dati di riepilogo presenze
                          (N:951;W:06;D:'Codice presenze'),
                          (N:952;W:15;D:'Descrizione presenze'),
                          (N:955;W:05;D:'Sigla presenze'),
                          (N:953;W:46;D:'Presenze in fasce'),
                          (N:954;W:06;D:'Presenze complessive'),
                          (N:972;W:46;D:'Pres.persa in fasce'),
                          (N:973;W:06;D:'Pres.persa totale'),
                          (N:956;W:46;D:'Presenze annue in fasce'),
                          (N:957;W:06;D:'Presenze annue totali'),
                          (N:958;W:46;D:'Pres.liquidabile in fasce'),
                          (N:959;W:46;D:'Pres.liquidabile totale'),
                          (N:960;W:46;D:'Pres.liquidata in fasce'),
                          (N:961;W:06;D:'Pres.liquidata totale'),
                          (N:962;W:46;D:'Pres.liquid.annua in fasce'),
                          (N:963;W:06;D:'Pres.liquid.annua totale'),
                          (N:964;W:46;D:'Pres.residua in fasce'),
                          (N:965;W:06;D:'Pres.residua totale'),
                          (N:966;W:06;D:'Pres.comp.registrata'),
                          (N:967;W:06;D:'Pres.comp.effettiva'),
                          (N:968;W:06;D:'Pres.comp.annua registrata'),
                          (N:969;W:06;D:'Pres.comp.annua effettiva'),
                          (N:970;W:06;D:'Pres.recuperata nel mese'),
                          (N:971;W:06;D:'Pres.recuperata nell''anno'),
                          //Stringhe libere in fondo al cartellino
                          (N:1000;W:15;D:'Dato libero'),
                          //Stringhe libere nel riepilogo
                          (N:2000;W:15;D:'Dato libero 2'),
                          //Dati liberi SQL nel riepilogo
                          (N:2001;W:15;D:'Dato libero SQL')
                          );

function A027GetPosDett(X:Integer):Integer;
function A027GetIdxTotMese(X:Integer):Integer;

implementation

function A027GetPosDett(X:Integer):Integer;
{Restituisce la posizione del dato nella lista DatiDett}
var i:Integer;
begin
  case X of
    C_GG1..C_GG1:     X:=C_GG1;   //Giorno del mese
    C_TI1..C_TI8:     X:=C_TI1;   //Timbrature
    C_GI1..C_GI2:     X:=C_GI1;   //Giustificativi
    C_HL1..C_HL2:     X:=C_HL1;   //Ore Lavorate da conteggi
    C_HH1..C_HH2:     X:=C_HH1;   //Ore lorde
    C_LF1..C_LF2:     X:=C_LF1;   //Ore lavorate in fasce
    C_EC1..C_EC2:     X:=C_EC1;   //Eccedenze in fasce
    C_SC1..C_SC2:     X:=C_SC1;   //Scostamento giornaliero
    C_SN1..C_SN2:     X:=C_SN1;   //Scostamento negativo
    C_SP1..C_SP2:     X:=C_SP1;   //Scostamento positivo
    C_DG1..C_DG2:     X:=C_DG1;   //Debito giornaliero
    C_CM1..C_CM2:     X:=C_CM1;   //Eccedenza solo compensabile
    C_CMNG1..C_CMNG2: X:=C_CMNG1; //Eccedenza solo compensabile + negativo
    C_TR1,C_TR2:      X:=C_TR1;   //Turno
    C_PRI1..C_PRI2:   X:=C_PRI1;  //Prolungamento inibito
    C_PRN1..C_PRN2:   X:=C_PRN1;  //Prolungamento non causalizzato
    C_PRT1..C_PRT2:   X:=C_PRT1;  //Prolungamento complessivo
    C_ESC1..C_ESC2:   X:=C_ESC1;  //Prolungamento complessivo
    C_PM1..C_PM2:     X:=C_PM1;   //Prolungamento complessivo
    C_PRU1..C_PRU2:   X:=C_PRU1;  //Prolungamento in uscita non causalizzato
    C_CAU1..C_CAU2:   X:=C_CAU1;  //Ore causalizzate
    C_PINT1..C_PINT2: X:=C_PINT1;    //Pasti interi
    C_PCONV1..C_PCONV2: X:=C_PCONV1; //Pasti convenzionati
    C_FENNG1..C_FENNG2: X:=C_FENNG1; //Festività non godute
    C_INDP1,C_INDP2: X:=C_INDP1; //Ind.Presenza
    C_INDF1,C_INDF2: X:=C_INDF1; //Ind.Festiva
    C_INDN1,C_INDN2: X:=C_INDN1; //Ind.Notturna
    C_IT1..C_IT2:     X:=C_IT1;   //Indennità turno in fasce
    C_NUMN1..C_NUMN2: X:=C_NUMN1;   //Indennità turno in fasce
  end;
  Result:=0;
  for i:=1 to High(DatiDett) do
    if DatiDett[i].N = X then
    begin
      Result:=i;
      Break;
    end;
end;

function A027GetIdxTotMese(X:Integer):Integer;
begin
  case X of
    C_HL2:Result:=1;
    C_HH2:Result:=2;
    C_LF2:Result:=3;
    C_SC2:Result:=4;
    C_SN2:Result:=5;
    C_SP2:Result:=6;
    C_CM2:Result:=7;
    C_CMNG2:Result:=8;
    C_DG2:Result:=9;
    C_EC2:Result:=10;
    C_PRI2:Result:=11;
    C_PRN2:Result:=12;
    C_PRT2:Result:=13;
    C_PM2:Result:=14;
    C_ESC2:Result:=15;
    C_PRU2:Result:=16;
    C_PCONV2:Result:=17;
    C_PINT2:Result:=18;
    C_FENNG2:Result:=19;
    C_CAU2:Result:=20;
    C_IT2:Result:=21;
    C_INDP2:Result:=22;
    C_INDF2:Result:=23;
    C_INDN2:Result:=24;
    C_NUMN2:Result:=25;
  end;
end;

end.
