function split( val ) {
  return val.split( /,\s*/ );
}
function extractLast( term ) {
  return split( term ).pop();
}

$(function(){
  $('#checklist_tag_list').autocomplete({
    source: function(request, response){
      var term = extractLast(request.term)
      var url = $('#checklist_tag_list').data('autocomplete-source')
      $.get(url, {term: term}, function(data){
          console.log(data)
          response(data)
      })
    },
    select: function( event, ui ) {
      var terms = split( this.value );
      // remove the current input
      terms.pop();
      // add the selected item
      terms.push( ui.item.value );
      // add placeholder to get the comma-and-space at the end
      terms.push( "" );
      this.value = terms.join( ", " );
      return false;
    }
  })
})

