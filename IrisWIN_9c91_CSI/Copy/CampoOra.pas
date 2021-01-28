{Gestisce l'introduzione di un dato Ora in un campo Data+Ora aggiungendo
la data fittizia 01/01/1900}
if (Sender is TDateTimeField) then
  Sender.AsString:='01/01/1900 ' + Text
else
  Sender.AsString:=Text;

