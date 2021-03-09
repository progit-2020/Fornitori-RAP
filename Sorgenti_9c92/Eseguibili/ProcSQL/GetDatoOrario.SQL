create or replace function GetDatoOrario(Cod in varchar2, Data in date, Fascia in Varchar2, Pos in integer, Dato in varchar2) return varchar2 is
  cursor c1 is
    select * from t021_fasceorari t021 
    where codice = Cod and 
          tipo_fascia = fascia and
          decorrenza = (select max(decorrenza) from t021_fasceorari where codice = t021.codice and decorrenza <= Data)
    order by entrata,uscita; 
  i integer;
begin
  i:=0;
  for t1 in c1 loop
    i:=i + 1;
    if i = Pos then
      if upper(Dato) = 'ENTRATA' then
        return(t1.entrata);
      elsif upper(Dato) = 'USCITA' then
        return(t1.uscita);
      elsif upper(Dato) = 'MMANTICIPO' then
        return(t1.mmanticipo);
      elsif upper(Dato) = 'MMANTICIPOU' then
        return(t1.mmanticipou);
      elsif upper(Dato) = 'TOLLERANZA' then
        return(t1.tolleranza);
      elsif upper(Dato) = 'TOLLERANZAU' then
        return(t1.tolleranzau);
      elsif upper(Dato) = 'ARRFLESFASC' then
        return(t1.arrflesfasc);
      elsif upper(Dato) = 'ARRFLESFASCU' then
        return(t1.arrflesfascu);
      elsif upper(Dato) = 'MMRITARDO' then
        return(t1.mmritardo);
      elsif upper(Dato) = 'MMRITARDOU' then
        return(t1.mmritardou);
      elsif upper(Dato) = 'MMARROTOND' then
        return(t1.mmarrotond);
      elsif upper(Dato) = 'MMARROTONDU' then
        return(t1.mmarrotondu);
      elsif upper(Dato) = 'ARRRITARDO' then
        return(t1.arrritardo);
      elsif upper(Dato) = 'ARRUSCANT' then
        return(t1.arruscant);
      elsif upper(Dato) = 'SCOST_PUNTI_NOMINALI_E' then
        return(t1.scost_punti_nominali_e);
      elsif upper(Dato) = 'SCOST_PUNTI_NOMINALI_U' then
        return(t1.scost_punti_nominali_u);
      elsif upper(Dato) = 'MMFLEX' then
        return(t1.mmflex);
      elsif upper(Dato) = 'ORETEOTUR' then
        return(t1.oreteotur);
      elsif upper(Dato) = 'SIGLATURNI' then
        return(t1.siglaturni);
      elsif upper(Dato) = 'NUMTURNO' then
        return(t1.numturno);
      elsif upper(Dato) = 'OREMINIME' then
        return(t1.oreminime);          
      end if;
    end if;
  end loop;
  return(Null);
end GetDatoOrario;
/
