unit A000Versione;

interface

(*
const VersIris = '3.0.6';    DataIris = '10/05/1999';
const VersIris = '3.0.7';    DataIris = '13/05/1999'; ScriptSQL = 'S990513.SQL';
const VersIris = '3.0.8';    DataIris = '21/05/1999'; ScriptSQL = 'S990513.SQL';
const VersIris = '3.0.9';    DataIris = '27/05/1999'; ScriptSQL = 'S990525.SQL';
const VersIris = '3.1.0';    DataIris = '03/06/1999'; ScriptSQL = 'S990602.SQL';
const VersIris = '3.1.1';    DataIris = '01/07/1999'; ScriptSQL = 'S990708.SQL';
const VersIris = '3.1.2';    DataIris = '26/07/1999'; ScriptSQL = 'S990721.SQL';
const VersIris = '3.1.3(b)'; DataIris = '06/09/1999'; ScriptSQL = 'S990823.SQL';
const VersIris = '3.1.4(b)'; DataIris = '06/09/1999'; ScriptSQL = 'S990909.SQL';
const VersIris = '3.1.5(b)'; DataIris = '22/09/1999'; ScriptSQL = 'S990909.SQL';
const VersIris = '3.1.6(b)'; DataIris = '30/09/1999'; ScriptSQL = 'S990909.SQL';
const VersIris = '3.1.7(b)'; DataIris = '07/10/1999'; ScriptSQL = 'S990909.SQL';
const VersIris = '3.5.1(b)'; DataIris = '14/10/1999'; ScriptSQL = 'S990909.SQL';
const VersIris = '3.5.2(b)'; DataIris = '28/10/1999'; ScriptSQL = 'S990909.SQL';
const VersIris = '3.5.3(b)'; DataIris = '29/10/1999'; ScriptSQL = 'S990909.SQL';
const VersIris = '3.5.4(b)'; DataIris = '02/11/1999'; ScriptSQL = 'S990909.SQL';
const VersIris = '3.6.0(b)'; DataIris = '05/11/1999'; ScriptSQL = 'S991102.SQL';
const VersIris = '3.7.0(b)'; DataIris = '16/11/1999'; ScriptSQL = 'S991102.SQL';
const VersIris = '3.7.1(b)'; DataIris = '26/11/1999'; ScriptSQL = 'S991102.SQL';
const VersIris = '3.8.0(b)'; DataIris = '01/12/1999'; ScriptSQL = 'S991201.SQL';
const VersIris = '3.8.1(b)'; DataIris = '05/12/1999'; ScriptSQL = 'S991201.SQL';
const VersIris = '3.9.0(b)'; DataIris = '10/12/1999'; ScriptSQL = 'S991208.SQL';
const VersIris = '3.9.1(b)'; DataIris = '15/12/1999'; ScriptSQL = 'S991215.SQL';
const VersIris = '3.9.2(b)'; DataIris = '04/01/2000'; ScriptSQL = 'S991215.SQL';
const VersIris = '3.9.3(b)'; DataIris = '12/01/2000'; ScriptSQL = 'SQ000107.SQL';
const VersIris = '3.9.4(b)'; DataIris = '18/01/2000'; ScriptSQL = 'SQ000117.SQL'
const VersIris = '4.0.0(b)'; DataIris = '01/02/2000'; ScriptSQL = 'SQ000320.SQL';
const VersIris = '4.0.1(b)'; DataIris = '10/04/2000'; ScriptSQL = 'SQ000320.SQL';
const VersIris = '4.0.2(b)'; DataIris = '11/04/2000'; ScriptSQL = 'SQ000320.SQL';
const VersIris = '4.0.3(b)'; DataIris = '17/04/2000'; ScriptSQL = 'SQ000320.SQL';
const VersIris = '4.0.4(b)'; DataIris = '18/04/2000'; ScriptSQL = 'SQ000320.SQL';
const VersIris = '4.0.5(b)'; DataIris = '06/05/2000'; ScriptSQL = 'SQ000508.SQL';
const VersIris = '4.0.6(b)'; DataIris = '11/05/2000'; ScriptSQL = 'SQ000511.SQL';
const VersIris = '4.0.7(b)'; DataIris = '23/05/2000'; ScriptSQL = 'SQ000523.SQL';
const VersIris = '4.1.1(b)'; DataIris = '09/06/2000'; ScriptSQL = 'SQ000523.SQL';
const VersIris = '4.1.2(b)'; DataIris = '19/06/2000'; ScriptSQL = 'SQ000523.SQL';
const VersIris = '4.1.3(b)'; DataIris = '21/06/2000'; ScriptSQL = 'SQ000523.SQL';
const VersIris = '4.1.4(b)'; DataIris = '27/06/2000'; ScriptSQL = 'SQ000627.SQL';
const VersIris = '4.1.5(b)'; DataIris = '17/07/2000'; ScriptSQL = 'SQ000627.SQL';
const VersIris = '4.1.6(b)'; DataIris = '24/07/2000'; ScriptSQL = 'SQ000627.SQL';
const VersIris = '4.1.7(b)'; DataIris = '01/08/2000'; ScriptSQL = 'SQ000803.SQL';
const VersIris = '4.2.1(b)'; DataIris = '18/09/2000'; ScriptSQL = 'SQ000803.SQL';
const VersIris = '4.2.2(b)'; DataIris = '19/09/2000'; ScriptSQL = 'SQ000803.SQL';
const VersIris = '4.2.3(b)'; DataIris = '05/10/2000'; ScriptSQL = 'SQ000803.SQL';
const VersIris = '4.2.4(b)'; DataIris = '09/10/2000'; ScriptSQL = 'SQ000803.SQL';
const VersIris = '5.0.1(b)'; DataIris = '29/11/2000'; ScriptSQL = 'SQ001130.SQL';
const VersIris = '5.0.2(b)'; DataIris = '18/12/2000'; ScriptSQL = 'SQ001220.SQL';
const VersIris = '5.0.3(b)'; DataIris = '02/01/2001'; ScriptSQL = 'SQ010108.SQL';
const VersIris = '5.0.4(b)'; DataIris = '15/01/2001'; ScriptSQL = 'SQ010115.SQL';
const VersIris = '5.1.1(b)'; DataIris = '07/02/2001'; ScriptSQL = 'SQ010212.SQL';
const VersIris = '5.1.2(b)'; DataIris = '14/02/2001'; ScriptSQL = 'SQ010212.SQL';
const VersIris = '5.1.4(b)'; DataIris = '05/03/2001'; ScriptSQL = 'SQ010215.SQL';
const VersIris = '5.1.5(b)'; DataIris = '12/03/2001'; ScriptSQL = 'SQ010316.SQL';
const VersIris = '5.1.6(b)'; DataIris = '20/03/2001'; ScriptSQL = 'SQ010316.SQL';
const VersIris = '5.1.7(b)'; DataIris = '30/03/2001'; ScriptSQL = 'SQ010409.SQL';
const VersIris = '5.1.8(b)'; DataIris = '22/05/2001'; ScriptSQL = 'SQ010523.SQL';
const VersIris = '5.1.9(b)'; DataIris = '22/05/2001'; ScriptSQL = 'SQ010528.SQL';
const VersIris = '5.2.0(b)'; DataIris = '22/05/2001'; ScriptSQL = 'SQ010607.SQL';
const VersIris = '5.2.1(b)'; DataIris = '28/06/2001'; ScriptSQL = 'SQ010628.SQL';
const VersIris = '5.2.2(b)'; DataIris = '06/07/2001'; ScriptSQL = 'SQ010628.SQL';
const VersIris = '5.2.4(b)'; DataIris = '24/07/2001'; ScriptSQL = 'SQ010724.SQL';
const VersIris = '5.3.1(b)'; DataIris = '13/08/2001'; ScriptSQL = 'SQ010724.SQL';
const VersIris = '5.3.2(b)'; DataIris = '24/08/2001'; ScriptSQL = 'SQ010724.SQL';
const VersIris = '5.3.3(b)'; DataIris = '07/09/2001'; ScriptSQL = 'SQ010813.SQL';
const VersIris = '5.3.4(b)'; DataIris = '19/09/2001'; ScriptSQL = 'SQ010924.SQL';
const VersIris = '5.3.5(b)'; DataIris = '05/10/2001'; ScriptSQL = 'SQ011024.SQL';
const VersIris = '5.3.6(b)'; DataIris = '31/10/2001'; ScriptSQL = 'SQ011024.SQL';
const VersIris = '5.3.7(b)'; DataIris = '20/11/2001'; ScriptSQL = 'SQ011114.SQL';
const VersIris = '5.3.8(b)'; DataIris = '05/12/2001'; ScriptSQL = 'SQ011114.SQL';
const VersIris = '5.3.9(b)'; DataIris = '14/12/2001'; ScriptSQL = 'SQ020102.SQL';
const VersIris = '5.4.0(b)'; DataIris = '07/01/2002'; ScriptSQL = 'SQ020102.SQL';
const VersIris = '5.4.1'; DataIris = '05/02/2002'; ScriptSQL = 'SQ020108.SQL';
const VersIris = '5.4.2'; DataIris = '21/03/2002'; ScriptSQL = 'SQ020204.SQL';
const VersIris = '5.4.3'; DataIris = '21/05/2002'; ScriptSQL = 'SQ020528.SQL';
const VersIris = '5.4.4'; DataIris = '11/08/2002'; ScriptSQL = 'SQ020805.SQL';
const VersIris = '5.4.5'; DataIris = '12/09/2002'; ScriptSQL = 'SQ020912.SQL';
const VersIris = '5.4.6'; DataIris = '06/11/2002'; ScriptSQL = 'SQ021106.SQL';
const VersIris = '5.4.7'; DataIris = '29/01/2003'; ScriptSQL = 'SQ021220.SQL';
const VersIris = '5.4.8'; DataIris = '29/01/2003'; ScriptSQL = 'SQ030129.SQL';
const VersIris = '5.4.9'; DataIris = '26/02/2003'; ScriptSQL = 'SQ030226.SQL';
const VersIris = '5.5.0'; DataIris = '29/04/2003'; ScriptSQL = 'SQ030429.SQL';
const VersIris = '5.5.1'; DataIris = '16/06/2003'; ScriptSQL = 'SQ030616.SQL';
const VersIris = '5.5.2'; DataIris = '01/08/2003'; ScriptSQL = 'SQ030801.SQL';
const VersIris = '5.5.3'; DataIris = '09/10/2003'; ScriptSQL = 'SQ031007.SQL';
const VersIris = '5.5.4'; DataIris = '06/02/2004'; ScriptSQL = 'SQ040205.SQL';
const VersIris = '5.5.5'; DataIris = '07/02/2004'; ScriptSQL = 'SQ040207.SQL';
const VersIris = '5.5.6'; DataIris = '28/04/2004'; ScriptSQL = 'SQ040421.SQL';
const VersIris = '5.5.7'; DataIris = '28/04/2004'; ScriptSQL = 'SQ040428.SQL';
const VersIris = '5.5.8'; DataIris = '10/06/2004'; ScriptSQL = 'SQ040610.SQL';
const VersIris = '5.5.9'; DataIris = '04/08/2004'; ScriptSQL = 'SQ040804.SQL';
const VersIris = '6.0.0'; DataIris = '26/11/2004'; ScriptSQL = 'SQ040908.SQL';
const VersIris = '6.0.1'; DataIris = '01/03/2005'; ScriptSQL = 'SQ041126.SQL';
const VersIris = '6.0.2'; DataIris = '01/03/2005'; ScriptSQL = 'SQ050301.SQL';
const VersionePA = '6.0.3'; DataPA = '26/07/2005'; ScriptSQLPA = 'SQ050629.SQL'; BuildPA = '0';
const VersionePA = '6.0.4'; DataPA = '11/11/2005'; ScriptSQLPA = 'SQ050928.SQL'; BuildPA = '0';
const VersionePA = '6.0.5'; DataPA = '11/11/2005'; ScriptSQLPA = 'SQ051115.SQL'; BuildPA = '0';
const VersionePA = '6.0.6'; DataPA = '24/02/2006'; ScriptSQLPA = 'SQ060224.SQL'; BuildPA = '0';
const VersionePA = '6.0.7'; DataPA = '26/06/2006'; ScriptSQLPA = 'SQ060626.SQL'; BuildPA = '0';
const VersionePA = '6.0.8'; DataPA = '08/11/2006'; ScriptSQLPA = 'SQ061108.SQL'; BuildPA = '0';
const VersionePA = '6.9'; DataPA = '26/02/2007'; ScriptSQLPA = 'SQ070226.SQL'; BuildPA = '0';
const VersionePA = '7.0'; DataPA = '29/06/2007'; ScriptSQLPA = 'SQ070629.SQL'; BuildPA = '0';
const VersionePA = '7.1'; DataPA = '02/10/2007'; ScriptSQLPA = 'SQ071002.SQL'; BuildPA = '0';
const VersionePA = '7.2'; DataPA = '20/06/2008'; ScriptSQLPA = 'SQ080311.SQL'; BuildPA = '0';
const VersionePA = '7.3'; DataPA = '01/12/2008'; ScriptSQLPA = 'SQ080620.SQL'; BuildPA = '0';
const VersionePA = '7.4'; DataPA = '01/03/2009'; ScriptSQLPA = 'SQ081201.SQL'; BuildPA = '0';
const VersionePA = '7.5'; DataPA = '26/06/2009'; ScriptSQLPA = 'SQ090301.SQL'; BuildPA = '0';
const VersionePA = '7.6'; DataPA = '26/06/2009'; ScriptSQLPA = 'SQ090625.SQL'; BuildPA = '0';
const VersionePA = '7.7'; DataPA = '20/01/2010'; ScriptSQLPA = 'SQ090928.SQL'; BuildPA = '0';
const VersionePA = '7.8'; DataPA = '30/04/2010'; ScriptSQLPA = 'SQ100120.SQL'; BuildPA = '0';
const VersionePA = '8.0'; DataPA = '31/01/2011'; ScriptSQLPA = 'SQ100922.SQL'; BuildPA = '0';
const VersionePA = '8.1'; DataPA = '01/06/2011'; ScriptSQLPA = 'SQ110131.SQL'; BuildPA = '0';
const VersionePA = '8.2'; DataPA = '19/09/2011'; ScriptSQLPA = 'SQ110601.SQL'; BuildPA = '0';
const VersionePA = '8.3'; DataPA = '23/12/2011'; ScriptSQLPA = 'SQ110919.SQL'; BuildPA = '0';
const VersionePA = '8.4'; DataPA = '02/04/2012'; ScriptSQLPA = 'SQ111223.SQL'; BuildPA = '0';
const VersionePA = '8.5'; DataPA = '31/08/2012'; ScriptSQLPA = 'SQ120402.SQL'; BuildPA = '0';
const VersionePA = '8.6'; DataPA = '09/01/2013'; ScriptSQLPA = 'SQ120831.SQL'; BuildPA = '0';
const VersionePA = '8.7'; DataPA = '23/05/2013'; ScriptSQLPA = 'SQ130109.SQL'; BuildPA = '0';
const VersionePA = '9.0'; DataPA = '21/10/2013'; ScriptSQLPA = 'SQ130523.SQL'; BuildPA = '0';
const VersionePA = '9.1'; DataPA = '17/02/2014'; ScriptSQLPA = 'SQ131021.SQL'; BuildPA = '0';
const VersionePA = '9.2'; DataPA = '14/05/2014'; ScriptSQLPA = 'SQ140215.SQL'; BuildPA = '0';
const VersionePA = '9.3'; DataPA = '22/10/2014'; ScriptSQLPA = 'SQ141022.SQL'; BuildPA = '0';
const VersionePA = '9c.7'; DataPA = '11/07/2016'; ScriptSQLPA = 'SQ150707_7.SQL'; BuildPA = '0';
const VersionePA = '9c.7'; DataPA = '08/05/2017'; ScriptSQLPA = 'SQ160929_1.SQL'; BuildPA = '2';
const VersionePA = '9c.7'; DataPA = '19/03/2018'; ScriptSQLPA = 'SQ160929_5.SQL'; BuildPA = '5';
const VersionePA = '9c.8'; DataPA = '20/06/2018'; ScriptSQLPA = 'SQ180612.SQL'; BuildPA = '0';
const VersionePA = '9c.8'; DataPA = '06/02/2019'; ScriptSQLPA = 'SQ180612_3.SQL'; BuildPA = '3';
const VersionePA = '9c.8'; DataPA = '04/03/2019'; ScriptSQLPA = 'SQ180612_4.SQL'; BuildPA = '4a';
const VersionePA = '9c.8'; DataPA = '03/05/2019'; ScriptSQLPA = 'SQ180612_5.SQL'; BuildPA = '5a';
const VersionePA = '9c.8'; DataPA = '05/02/2020'; ScriptSQLPA = 'SQ191112.SQL'; BuildPA = '9';
const VersionePA = '9c.9'; DataPA = '06/07/2020'; ScriptSQLPA = 'SQ200706.SQL'; BuildPA = '0';
const VersionePA = '9c.9'; DataPA = '10/12/2020'; ScriptSQLPA = 'SQ201210.SQL'; BuildPA = '1';
const VersionePA = '9c.9'; DataPA = '05/03/2021'; ScriptSQLPA = 'SQ210305.SQL'; BuildPA = '2';*)
const VersionePA = '9c.9'; DataPA = '02/07/2021'; ScriptSQLPA = 'SQ210702.SQL'; BuildPA = '3';

implementation

end.
