create table TAB_BANNER
(
  COD_CARATTERE VARCHAR2(1) not null,
  RIGA_1        VARCHAR2(12),
  RIGA_2        VARCHAR2(12),
  RIGA_3        VARCHAR2(12),
  RIGA_4        VARCHAR2(12),
  RIGA_5        VARCHAR2(12),
  RIGA_6        VARCHAR2(12),
  RIGA_7        VARCHAR2(12),
  RIGA_8        VARCHAR2(12),
  RIGA_9        VARCHAR2(12),
  RIGA_10       VARCHAR2(12),
  RIGA_11       VARCHAR2(12),
  RIGA_12       VARCHAR2(12)
)
tablespace LAVORO
  pctfree 10
  pctused 40
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    minextents 1
  );
alter table TAB_BANNER
  add constraint PK_TAB_BANNER primary key (COD_CARATTERE)
  using index 
  tablespace INDICI
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    minextents 1
  );


create table TAB_BANNER_OUT
(
  RIGA    NUMBER(2),
  STRINGA VARCHAR2(132)
)
tablespace LAVORO
  pctfree 10
  pctused 40
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    minextents 1
  );


insert into TAB_BANNER (COD_CARATTERE, RIGA_1, RIGA_2, RIGA_3, RIGA_4, RIGA_5, RIGA_6, RIGA_7, RIGA_8, RIGA_9, RIGA_10, RIGA_11, RIGA_12)
values ('1', '     11     ', '    111     ', '   1111     ', '     11     ', '     11     ', '     11     ', '     11     ', '     11     ', '     11     ', '     11     ', '111111111111', '111111111111');
insert into TAB_BANNER (COD_CARATTERE, RIGA_1, RIGA_2, RIGA_3, RIGA_4, RIGA_5, RIGA_6, RIGA_7, RIGA_8, RIGA_9, RIGA_10, RIGA_11, RIGA_12)
values ('2', '  222222222 ', ' 22222222222', '22        22', '          22', '          22', '          22', '        22  ', '      22    ', '    22      ', '  22        ', '222222222222', '222222222222');
insert into TAB_BANNER (COD_CARATTERE, RIGA_1, RIGA_2, RIGA_3, RIGA_4, RIGA_5, RIGA_6, RIGA_7, RIGA_8, RIGA_9, RIGA_10, RIGA_11, RIGA_12)
values ('3', ' 3333333333 ', '333333333333', '33        33', '          33', '          33', '       3333 ', '       3333 ', '          33', '          33', '33        33', '333333333333', ' 3333333333 ');
insert into TAB_BANNER (COD_CARATTERE, RIGA_1, RIGA_2, RIGA_3, RIGA_4, RIGA_5, RIGA_6, RIGA_7, RIGA_8, RIGA_9, RIGA_10, RIGA_11, RIGA_12)
values ('4', '      444   ', '     4444   ', '    44 44   ', '   44  44   ', '  44   44   ', ' 44    44   ', '44     44   ', '444444444444', '       44   ', '       44   ', '       44   ', '       44   ');
insert into TAB_BANNER (COD_CARATTERE, RIGA_1, RIGA_2, RIGA_3, RIGA_4, RIGA_5, RIGA_6, RIGA_7, RIGA_8, RIGA_9, RIGA_10, RIGA_11, RIGA_12)
values ('5', '555555555555', '555555555555', '55          ', '55          ', '55          ', '555555555   ', '5555555555  ', '         55 ', '          55', '          55', '555555555555', '55555555555 ');
insert into TAB_BANNER (COD_CARATTERE, RIGA_1, RIGA_2, RIGA_3, RIGA_4, RIGA_5, RIGA_6, RIGA_7, RIGA_8, RIGA_9, RIGA_10, RIGA_11, RIGA_12)
values ('6', ' 6666666666 ', '666666666666', '66        66', '66          ', '66          ', '666666666666', '666666666666', '66        66', '66        66', '66        66', '666666666666', ' 6666666666 ');
insert into TAB_BANNER (COD_CARATTERE, RIGA_1, RIGA_2, RIGA_3, RIGA_4, RIGA_5, RIGA_6, RIGA_7, RIGA_8, RIGA_9, RIGA_10, RIGA_11, RIGA_12)
values ('7', '777777777777', '777777777777', '          77', '         77 ', '        77  ', '       77   ', '    777777  ', '     77     ', '    77      ', '   77       ', '  77        ', ' 77         ');
insert into TAB_BANNER (COD_CARATTERE, RIGA_1, RIGA_2, RIGA_3, RIGA_4, RIGA_5, RIGA_6, RIGA_7, RIGA_8, RIGA_9, RIGA_10, RIGA_11, RIGA_12)
values ('8', ' 8888888888 ', '888888888888', '88        88', '88        88', ' 88      88 ', '  88888888  ', '  88888888  ', ' 88      88 ', '88        88', '88        88', '888888888888', ' 8888888888 ');
insert into TAB_BANNER (COD_CARATTERE, RIGA_1, RIGA_2, RIGA_3, RIGA_4, RIGA_5, RIGA_6, RIGA_7, RIGA_8, RIGA_9, RIGA_10, RIGA_11, RIGA_12)
values ('9', ' 9999999999 ', '999999999999', '99        99', '99        99', '99        99', '999999999999', '999999999999', '          99', '          99', '99        99', '999999999999', ' 9999999999 ');
insert into TAB_BANNER (COD_CARATTERE, RIGA_1, RIGA_2, RIGA_3, RIGA_4, RIGA_5, RIGA_6, RIGA_7, RIGA_8, RIGA_9, RIGA_10, RIGA_11, RIGA_12)
values ('0', '  00000000  ', ' 0000000000 ', '00        00', '00        00', '00        00', '00        00', '00        00', '00        00', '00        00', '00        00', ' 0000000000 ', '  00000000  ');
insert into TAB_BANNER (COD_CARATTERE, RIGA_1, RIGA_2, RIGA_3, RIGA_4, RIGA_5, RIGA_6, RIGA_7, RIGA_8, RIGA_9, RIGA_10, RIGA_11, RIGA_12)
values ('A', ' AAAAAAAAAA ', 'AAAAAAAAAAAA', 'AA        AA', 'AA        AA', 'AA        AA', 'AAAAAAAAAAAA', 'AAAAAAAAAAAA', 'AA        AA', 'AA        AA', 'AA        AA', 'AA        AA', 'AA        AA');
insert into TAB_BANNER (COD_CARATTERE, RIGA_1, RIGA_2, RIGA_3, RIGA_4, RIGA_5, RIGA_6, RIGA_7, RIGA_8, RIGA_9, RIGA_10, RIGA_11, RIGA_12)
values ('Z', 'ZZZZZZZZZZZZ', 'ZZZZZZZZZZZZ', '         ZZ', '        ZZ', '       ZZ', '      ZZ', '     ZZ', '    ZZ', '   ZZ', '  ZZ', ' ZZZZZZZZZZZ', 'ZZZZZZZZZZZZ');
insert into TAB_BANNER (COD_CARATTERE, RIGA_1, RIGA_2, RIGA_3, RIGA_4, RIGA_5, RIGA_6, RIGA_7, RIGA_8, RIGA_9, RIGA_10, RIGA_11, RIGA_12)
values ('I', ' IIIIIIIIII', ' IIIIIIIIII', '     II', '     II', '     II', '     II', '     II', '     II', '     II', '     II', ' IIIIIIIIII', ' IIIIIIIIII');
insert into TAB_BANNER (COD_CARATTERE, RIGA_1, RIGA_2, RIGA_3, RIGA_4, RIGA_5, RIGA_6, RIGA_7, RIGA_8, RIGA_9, RIGA_10, RIGA_11, RIGA_12)
values ('T', 'TTTTTTTTTTTT', 'TTTTTTTTTTTT', '     TT', '     TT', '     TT', '     TT', '     TT', '     TT', '     TT', '     TT', '     TT', '     TT');
insert into TAB_BANNER (COD_CARATTERE, RIGA_1, RIGA_2, RIGA_3, RIGA_4, RIGA_5, RIGA_6, RIGA_7, RIGA_8, RIGA_9, RIGA_10, RIGA_11, RIGA_12)
values ('D', 'DDDDDDDDD', 'DDDDDDDDDD', 'DD       DD', 'DD        DD', 'DD        DD', 'DD        DD', 'DD        DD', 'DD        DD', 'DD        DD', 'DD       DD', 'DDDDDDDDDD', 'DDDDDDDDD');
insert into TAB_BANNER (COD_CARATTERE, RIGA_1, RIGA_2, RIGA_3, RIGA_4, RIGA_5, RIGA_6, RIGA_7, RIGA_8, RIGA_9, RIGA_10, RIGA_11, RIGA_12)
values ('S', ' SSSSSSSSSS', 'SSSSSSSSSSSS', 'SS        SS', 'SS', 'SSS', ' SSSSSSSSSS', '  SSSSSSSSSS', '         SSS', '          SS', 'SS        SS', 'SSSSSSSSSSSS', ' SSSSSSSSSS');
insert into TAB_BANNER (COD_CARATTERE, RIGA_1, RIGA_2, RIGA_3, RIGA_4, RIGA_5, RIGA_6, RIGA_7, RIGA_8, RIGA_9, RIGA_10, RIGA_11, RIGA_12)
values ('R', 'RRRRRRRRRRR', 'RRRRRRRRRRRR', 'RR        RR', 'RR        RR', 'RR        RR', 'RRRRRRRRRRRR', 'RRRRRRRRRRR', 'RR    RR', 'RR     RR', 'RR      RR', 'RR       RR', 'RR        RR');
insert into TAB_BANNER (COD_CARATTERE, RIGA_1, RIGA_2, RIGA_3, RIGA_4, RIGA_5, RIGA_6, RIGA_7, RIGA_8, RIGA_9, RIGA_10, RIGA_11, RIGA_12)
values ('E', 'EEEEEEEEEEEE', 'EEEEEEEEEEEE', 'EE', 'EE', 'EE', 'EEEEEEEE', 'EEEEEEEE', 'EE', 'EE', 'EE', 'EEEEEEEEEEEE', 'EEEEEEEEEEEE');
insert into TAB_BANNER (COD_CARATTERE, RIGA_1, RIGA_2, RIGA_3, RIGA_4, RIGA_5, RIGA_6, RIGA_7, RIGA_8, RIGA_9, RIGA_10, RIGA_11, RIGA_12)
values ('G', ' GGGGGGGGGG ', 'GGGGGGGGGGGG', 'GG        GG', 'GG', 'GG', 'GG', 'GG     GGGGG', 'GG     GGGGG', 'GG        GG', 'GG        GG', 'GGGGGGGGGGGG', ' GGGGGGGGGG');
insert into TAB_BANNER (COD_CARATTERE, RIGA_1, RIGA_2, RIGA_3, RIGA_4, RIGA_5, RIGA_6, RIGA_7, RIGA_8, RIGA_9, RIGA_10, RIGA_11, RIGA_12)
values ('O', 'OOOOOOOOOOOO', 'OOOOOOOOOOOO', 'OO        OO', 'OO        OO', 'OO        OO', 'OO        OO', 'OO        OO', 'OO        OO', 'OO        OO', 'OO        OO', 'OOOOOOOOOOOO', 'OOOOOOOOOOOO');
insert into TAB_BANNER (COD_CARATTERE, RIGA_1, RIGA_2, RIGA_3, RIGA_4, RIGA_5, RIGA_6, RIGA_7, RIGA_8, RIGA_9, RIGA_10, RIGA_11, RIGA_12)
values ('N', 'NN        NN', 'NNN       NN', 'NNNN      NN', 'NN NN     NN', 'NN  NN    NN', 'NN   NN   NN', 'NN    NN  NN', 'NN     NN NN', 'NN      NNNN', 'NN       NNN', 'NN        NN', 'NN         N');
insert into TAB_BANNER (COD_CARATTERE, RIGA_1, RIGA_2, RIGA_3, RIGA_4, RIGA_5, RIGA_6, RIGA_7, RIGA_8, RIGA_9, RIGA_10, RIGA_11, RIGA_12)
values ('C', ' CCCCCCCCCC', 'CCCCCCCCCCCC', 'CC        CC', 'CC', 'CC', 'CC', 'CC', 'CC', 'CC        ', 'CC        CC', 'CCCCCCCCCCCC', ' CCCCCCCCCC');
insert into TAB_BANNER (COD_CARATTERE, RIGA_1, RIGA_2, RIGA_3, RIGA_4, RIGA_5, RIGA_6, RIGA_7, RIGA_8, RIGA_9, RIGA_10, RIGA_11, RIGA_12)
values ('F', 'FFFFFFFFFFFF', 'FFFFFFFFFFFF', 'FF', 'FF', 'FF', 'FFFFFFFF', 'FFFFFFFF', 'FF', 'FF', 'FF', 'FF', 'FF');
insert into TAB_BANNER (COD_CARATTERE, RIGA_1, RIGA_2, RIGA_3, RIGA_4, RIGA_5, RIGA_6, RIGA_7, RIGA_8, RIGA_9, RIGA_10, RIGA_11, RIGA_12)
values ('M', 'MM        MM', 'MMM      MMM', 'MMMM    MMMM', 'MM MM  MM MM', 'MM  MMMM  MM', 'MM   MM   MM', 'MM        MM', 'MM        MM', 'MM        MM', 'MM        MM', 'MM        MM', 'MM        MM');
insert into TAB_BANNER (COD_CARATTERE, RIGA_1, RIGA_2, RIGA_3, RIGA_4, RIGA_5, RIGA_6, RIGA_7, RIGA_8, RIGA_9, RIGA_10, RIGA_11, RIGA_12)
values (' ', '            ', '            ', '            ', '            ', '            ', '            ', '            ', '            ', '            ', '            ', '            ', '            ');
insert into TAB_BANNER (COD_CARATTERE, RIGA_1, RIGA_2, RIGA_3, RIGA_4, RIGA_5, RIGA_6, RIGA_7, RIGA_8, RIGA_9, RIGA_10, RIGA_11, RIGA_12)
values ('B', null, null, null, null, null, null, null, null, null, null, null, null);
insert into TAB_BANNER (COD_CARATTERE, RIGA_1, RIGA_2, RIGA_3, RIGA_4, RIGA_5, RIGA_6, RIGA_7, RIGA_8, RIGA_9, RIGA_10, RIGA_11, RIGA_12)
values ('H', null, null, null, null, null, null, null, null, null, null, null, null);
insert into TAB_BANNER (COD_CARATTERE, RIGA_1, RIGA_2, RIGA_3, RIGA_4, RIGA_5, RIGA_6, RIGA_7, RIGA_8, RIGA_9, RIGA_10, RIGA_11, RIGA_12)
values ('L', null, null, null, null, null, null, null, null, null, null, null, null);
insert into TAB_BANNER (COD_CARATTERE, RIGA_1, RIGA_2, RIGA_3, RIGA_4, RIGA_5, RIGA_6, RIGA_7, RIGA_8, RIGA_9, RIGA_10, RIGA_11, RIGA_12)
values ('P', null, null, null, null, null, null, null, null, null, null, null, null);
insert into TAB_BANNER (COD_CARATTERE, RIGA_1, RIGA_2, RIGA_3, RIGA_4, RIGA_5, RIGA_6, RIGA_7, RIGA_8, RIGA_9, RIGA_10, RIGA_11, RIGA_12)
values ('Q', null, null, null, null, null, null, null, null, null, null, null, null);
insert into TAB_BANNER (COD_CARATTERE, RIGA_1, RIGA_2, RIGA_3, RIGA_4, RIGA_5, RIGA_6, RIGA_7, RIGA_8, RIGA_9, RIGA_10, RIGA_11, RIGA_12)
values ('U', null, null, null, null, null, null, null, null, null, null, null, null);
insert into TAB_BANNER (COD_CARATTERE, RIGA_1, RIGA_2, RIGA_3, RIGA_4, RIGA_5, RIGA_6, RIGA_7, RIGA_8, RIGA_9, RIGA_10, RIGA_11, RIGA_12)
values ('V', null, null, null, null, null, null, null, null, null, null, null, null);
insert into TAB_BANNER (COD_CARATTERE, RIGA_1, RIGA_2, RIGA_3, RIGA_4, RIGA_5, RIGA_6, RIGA_7, RIGA_8, RIGA_9, RIGA_10, RIGA_11, RIGA_12)
values ('W', null, null, null, null, null, null, null, null, null, null, null, null);
insert into TAB_BANNER (COD_CARATTERE, RIGA_1, RIGA_2, RIGA_3, RIGA_4, RIGA_5, RIGA_6, RIGA_7, RIGA_8, RIGA_9, RIGA_10, RIGA_11, RIGA_12)
values ('X', null, null, null, null, null, null, null, null, null, null, null, null);
insert into TAB_BANNER (COD_CARATTERE, RIGA_1, RIGA_2, RIGA_3, RIGA_4, RIGA_5, RIGA_6, RIGA_7, RIGA_8, RIGA_9, RIGA_10, RIGA_11, RIGA_12)
values ('Y', null, null, null, null, null, null, null, null, null, null, null, null);
insert into TAB_BANNER (COD_CARATTERE, RIGA_1, RIGA_2, RIGA_3, RIGA_4, RIGA_5, RIGA_6, RIGA_7, RIGA_8, RIGA_9, RIGA_10, RIGA_11, RIGA_12)
values ('*', null, null, null, null, null, null, null, null, null, null, null, null);

commit;

CREATE OR REPLACE PROCEDURE PG_STAMPA_BANNER_MONDOEDP
(
par_stringa1_in  IN VARCHAR2,
par_stringa2_in  IN VARCHAR2
)
IS
----------------------------------------------------------------------------------------------------------
-- Procedure per la stampa del banner del tabulato SAFM120C .
----------------------------------------------------------------------------------------------------------
-- Variabili MondoEDP
carattere varchar2(30);
riga varchar2(132);
i integer;
parole integer;
parola varchar2(8);
-- Variabili di comodo
spazio_4		varchar2(50) := '    ';
spazio_9		varchar2(50) := '         ';
spazio_8		varchar2(50) := '        ';
spazio_24		varchar2(50) := '                        ';
spazio_44		varchar2(50) := '                                            ';

BEGIN
	-- Preparazione della Stampa del banner AZ + cod_azienda_1 + cod_azienda_2
 delete from TAB_BANNER_OUT;
   
 for parole in 1..2 loop
   if parole = 1 then
     parola:=substr(par_stringa1_in,1,8);
   else
     parola:=substr(par_stringa2_in,1,8);
     if (rtrim(ltrim(parola)) is null) /*or (ltrim(rtrim(parola)) = '')*/ then
       exit;
     end if;
     insert into TAB_BANNER_OUT values(13,'');   
     insert into TAB_BANNER_OUT values(14,'');   
   end if;
 	 -- Prima RIGA
   riga:=null;
   for i in 1..length(PAROLA) loop
	   select SPAZIO_4||rpad(bn.RIGA_1,12)
  	 into carattere
	   from TAB_BANNER bn
   	 where bn.COD_CARATTERE like substr(PAROLA,i,1);
     riga:=riga||carattere;
   end loop;
   insert into TAB_BANNER_OUT values((parole-1)*14+1,riga);
 	 -- Seconda RIGA
   riga:=null;
   for i in 1..length(PAROLA) loop
	   select SPAZIO_4||rpad(bn.RIGA_2,12)
  	 into carattere
	   from TAB_BANNER bn
   	 where bn.COD_CARATTERE like substr(PAROLA,i,1);
     riga:=riga||carattere;
   end loop;
   insert into TAB_BANNER_OUT values((parole-1)*14+2,riga);
 	 -- Terza RIGA
   riga:=null;
   for i in 1..length(PAROLA) loop
	   select SPAZIO_4||rpad(bn.RIGA_3,12)
  	 into carattere
	   from TAB_BANNER bn
   	 where bn.COD_CARATTERE like substr(PAROLA,i,1);
     riga:=riga||carattere;
   end loop;
   insert into TAB_BANNER_OUT values((parole-1)*14+3,riga);
 	 -- Quarta RIGA
   riga:=null;
   for i in 1..length(PAROLA) loop
	   select SPAZIO_4||rpad(bn.RIGA_4,12)
  	 into carattere
	   from TAB_BANNER bn
   	 where bn.COD_CARATTERE like substr(PAROLA,i,1);
     riga:=riga||carattere;
   end loop;
   insert into TAB_BANNER_OUT values((parole-1)*14+4,riga);
 	 -- Cinque RIGA
   riga:=null;
   for i in 1..length(PAROLA) loop
	   select SPAZIO_4||rpad(bn.RIGA_5,12)
  	 into carattere
	   from TAB_BANNER bn
   	 where bn.COD_CARATTERE like substr(PAROLA,i,1);
     riga:=riga||carattere;
   end loop;
   insert into TAB_BANNER_OUT values((parole-1)*14+5,riga);
 	 -- Sesta RIGA
   riga:=null;
   for i in 1..length(PAROLA) loop
	   select SPAZIO_4||rpad(bn.RIGA_6,12)
  	 into carattere
	   from TAB_BANNER bn
   	 where bn.COD_CARATTERE like substr(PAROLA,i,1);
     riga:=riga||carattere;
   end loop;
   insert into TAB_BANNER_OUT values((parole-1)*14+6,riga);
 	 -- Settima RIGA
   riga:=null;
   for i in 1..length(PAROLA) loop
	   select SPAZIO_4||rpad(bn.RIGA_7,12)
  	 into carattere
	   from TAB_BANNER bn
   	 where bn.COD_CARATTERE like substr(PAROLA,i,1);
     riga:=riga||carattere;
   end loop;
   insert into TAB_BANNER_OUT values((parole-1)*14+7,riga);
 	 -- Ottava RIGA
   riga:=null;
   for i in 1..length(PAROLA) loop
	   select SPAZIO_4||rpad(bn.RIGA_8,12)
  	 into carattere
	   from TAB_BANNER bn
   	 where bn.COD_CARATTERE like substr(PAROLA,i,1);
     riga:=riga||carattere;
   end loop;
   insert into TAB_BANNER_OUT values((parole-1)*14+8,riga);
 	 -- Nona RIGA
   riga:=null;
   for i in 1..length(PAROLA) loop
	   select SPAZIO_4||rpad(bn.RIGA_9,12)
  	 into carattere
	   from TAB_BANNER bn
   	 where bn.COD_CARATTERE like substr(PAROLA,i,1);
     riga:=riga||carattere;
   end loop;
   insert into TAB_BANNER_OUT values((parole-1)*14+9,riga);
 	 -- Decima RIGA
   riga:=null;
   for i in 1..length(PAROLA) loop
	   select SPAZIO_4||rpad(bn.RIGA_10,12)
  	 into carattere
	   from TAB_BANNER bn
   	 where bn.COD_CARATTERE like substr(PAROLA,i,1);
     riga:=riga||carattere;
   end loop;
   insert into TAB_BANNER_OUT values((parole-1)*14+10,riga);
 	 -- Undicesima RIGA
   riga:=null;
   for i in 1..length(PAROLA) loop
	   select SPAZIO_4||rpad(bn.RIGA_11,12)
  	 into carattere
	   from TAB_BANNER bn
   	 where bn.COD_CARATTERE like substr(PAROLA,i,1);
     riga:=riga||carattere;
   end loop;
   insert into TAB_BANNER_OUT values((parole-1)*14+11,riga);
 	 -- Dodicesima RIGA
   riga:=null;
   for i in 1..length(PAROLA) loop
	   select SPAZIO_4||rpad(bn.RIGA_12,12)
  	 into carattere
	   from TAB_BANNER bn
   	 where bn.COD_CARATTERE like substr(PAROLA,i,1);
     riga:=riga||carattere;
   end loop;
   insert into TAB_BANNER_OUT values((parole-1)*14+12,riga);
 end loop;
END PG_STAMPA_BANNER_MONDOEDP;
/
