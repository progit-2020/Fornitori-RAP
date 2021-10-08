$.fn.uppercase = function() {
  $(this).keypress(function(e) {
    if (e.target.createTextRange) {
      var r = document.selection.createRange().duplicate();
      r.moveEnd('character', e.target.value.length);
      if (r.text == '') mstart = e.target.value.length;
      else mstart = e.target.value.lastIndexOf(r.text);
      r.moveStart('character', -e.target.value.length);
      mend = r.text.length;
    } else {
      mstart = e.target.selectionStart;
      mend = e.target.selectionEnd;
    }
    // a-z -> A-Z
    if(e.which > 96 && e.which < 123) {
      e.preventDefault();
      e.stopPropagation();
      z = $(e.target).val();
      front = z.substring(0, mstart);
      back = z.substring(mend);
      $(e.target).val(front+String.fromCharCode(e.which - 32) + back);

      if(e.target.createTextRange) { 
          var range = e.target.createTextRange(); 
          range.move("character", mend+1); 
          range.select(); 
      } else if(e.target.selectionStart) { 
          e.target.focus(); 
          e.target.setSelectionRange(mend+1, mend+1); 
      }  
    }
  });
}

$.fn.lowercase = function() {
  $(this).keypress(function(e) {
    if (e.target.createTextRange) {
      var r = document.selection.createRange().duplicate();
      r.moveEnd('character', e.target.value.length);
      if (r.text == '') mstart = e.target.value.length;
      else mstart = e.target.value.lastIndexOf(r.text);
      r.moveStart('character', -e.target.value.length);
      mend = r.text.length;
    } else {
      mstart = e.target.selectionStart;
      mend = e.target.selectionEnd;
    }
    // A-Z -> a-z
    if(e.which > 64 && e.which < 91) {
      e.preventDefault();
      e.stopPropagation();
      z = $(e.target).val();
      front = z.substring(0, mstart);
      back = z.substring(mend);
      $(e.target).val(front+String.fromCharCode(e.which + 32) + back);

      if(e.target.createTextRange) { 
          var range = e.target.createTextRange(); 
          range.move("character", mend+1); 
          range.select(); 
      } else if(e.target.selectionStart) { 
          e.target.focus(); 
          e.target.setSelectionRange(mend+1, mend+1); 
      }  
    }
  });
}