create or replace function T040F_CONGPAR_COUNT(P_PROGRESSIVO in integer, P_CODINTERNO in varchar2, P_DATA1 in date, P_DATA2 in date) return integer as
  result integer;
begin
  select count(*) into result
  from T040_GIUSTIFICATIVI T040B, T265_CAUASSENZE T265B, T260_RAGGRASSENZE T260B where T040B.PROGRESSIVO = P_PROGRESSIVO
           and T040B.CAUSALE = T265B.CODICE and T265B.CODRAGGR = T260B.CODICE and (T260B.CODINTERNO = 'A' or instr(usr_const.cRMAFA,T260B.CODICE||',') > 0)
           and P_CODINTERNO = decode(T260B.CODINTERNO,'A','FERIE','MAT.FAC.')
           and T040B.DATA between P_DATA1 and P_DATA2;
  
  return result;
end;
/