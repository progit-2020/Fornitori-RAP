/* jqTabs */
jQuery.root = jQuery(document);
$elem = jQuery.root.find(".ui-tabs");
if ($elem.length) {
  $elem.each(function( index ) {
    var CookieName = this.id + "%s" + "Cookie";
    var valore = $.cookie(CookieName);
    if(valore >= 0) {
      $(this).tabs({
        active: valore,
        activate: function( event, ui ) {
          var active = $(this).tabs( "option", "active" );
          $.cookie(CookieName, "", { expires: -1 });
          $.cookie(CookieName, active, { expires: 10 });
         }
      });
    }
    else{
      $(this).tabs({
        active: 0,
        activate: function( event, ui ) {
          var active = $(this).tabs( "option", "active" );
          $.cookie(CookieName, "", { expires: -1 });
          $.cookie(CookieName, active, { expires: 10 });
        }
      });
    }
  });
}