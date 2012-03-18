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

    
    $('.tags').each( function() {
      var input = $(this);
      var container = input.parent('.tag-container');
      var input_value = input.val();
      
      input.tagsInput();
      $("#" + this.id + "_tag").blur( function() {

        if( input.val() !== input_value) {
          input_value = input.val();
        
          container.find(".saved").hide();
          container.find(".error").hide();
          container.find(".spinner").show();
          $.ajax( {
            url: '/posts/' + input.attr('id') + '.json',
            type: 'PUT',
            data: { "tags[]": input_value.split(',') },
            success: function() {
              container.find(".spinner").hide();
              container.find(".saved").show();
              setTimeout( function() {
                container.find(".saved").fadeOut();
              }, 500);
            },
            error: function() {
              container.find(".spinner").hide();
              container.find(".error").show();
            }
          });
        }
      });
    });


      /*each( function() {
      $(this).find('input').tagedit( {
        autocompleteOptions: {
          source: tags,
          change: function( event, ui) {
            console.log( 'autocomplete changed');
          }
          /*function( request, response) {
            return $.ui.autocomplete.filter( [request.term] + tags, request.term);
            }
        }
      });
});*/

  };

  return pub;
  
}(jQuery);