var wt = wt || {};

wt.posts = function($) {

  var pub = {};

  pub.on_ready = function( tag_counts) {

    console.log("Posts on ready");
    console.log( $(".tagedit"));
    
    var tags = [];
    $.each( tag_counts, function( tag, count) {
      tags.push( {id: tag, label: tag, value: tag});
    });

    
    $('.tagedit').each( function() {
      $(this).find('input').tagedit( {
        autocompleteOptions: {
          source: tags,
          change: function( event, ui) {
            console.log( 'autocomplete changed');
          }
          /*function( request, response) {
            return $.ui.autocomplete.filter( [request.term] + tags, request.term);
            }*/
        }
      });
    });

    $(document).delegate('.tagedit-input').blur( function() {
      console.log('form blur');
      console.log(this);
    });
  };

  return pub;
  
}(jQuery);