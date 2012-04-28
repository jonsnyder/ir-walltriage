var wt = wt || {};

wt.compare = function( a, b) {
  return (a == b)? 0 : (a < b)? -1 : 1;
};

wt.insert = function(array, item, comparator) {
  var real_array = $.isFunction( array) ? array() : array;
  var low = 0, high = real_array.length - 1,
      i, comparison;
  comparator = comparator || wt.compare;
  while (low <= high) {
    i = Math.floor((low + high) / 2);
    comparison = comparator(real_array[i], item);
    if (comparison < 0) { low = i + 1; continue; };
    if (comparison > 0) { high = i - 1; continue; };
    return false;
  }
  i = Math.floor((low + high) / 2);
  array.splice( i+1, 0, item);
  return true;
};


wt.posts = function($) {

  var model = {};
  var pub = {};
  var params;
  var bulk_change = false;

  
  model.requests = ko.observableArray();
  
  var Request = function( status, error, params) {
    this.status = status;
    this.error_text = error;
    this.params = params;
    this.waiting = ko.observable( true);
    this.error = ko.observable('');
    this.request = $.ajax( $.extend( {}, params, {error: this.error, success: this.success, context: this}));
  };

  Request.prototype.close = function() {
    if( this.waiting()) {
      this.request.abort();
    }
    model.requests.remove( this);
  };

  Request.prototype.error = function() {
    this.waiting( false);
    this.error( error_text);
  };

  Request.prototype.success = function( data) {
    this.waiting( false);
    if( $.isFunction( this.params.success)) {
      if( this.params.context) {
        this.params.success.call( this.params.context, data);
      } else {
        this.params.success( data);
      }
    }
  };    

  var Tag = function( name, count) {
    this.name = ko.observable( name);
    this.count = ko.observable( count);
    this.filter_url = ko.computed( function() {
      return '?' + $.param( $.extend( {}, params, {tag: this.name(), page: 1}));
    }, this);
  };

  Tag.prototype.rename = function() {
    var old_name = this.name();
    var new_name = prompt('New Tag Name', this.name());
    var request = new Request(
      "Renaming tag...",
      "An error occurred.",
      {
        url: '/user_post_tags/' + old_name + '.json?dataset=' + params.dataset,
        type: 'PUT',
        data: { tag: new_name },
        success: function( tags) {
          refreshTagList( tags);
        }
      }
    );
    bulk_change = true;
    $.each( $('.tags'), function() {
      var input = $(this);
      if( input.tagExist( old_name)) {
        input.removeTag( old_name);
        if( !input.tagExist( new_name)) {
          input.addTag( new_name);
        }
      }
    });
    bulk_change = false;
    this.name( new_name);
  };

  Tag.prototype.remove = function() {
    var old_name = this.name();
    var request = new Request(
      "Removing tag...",
      "An error occurred.",
      {
        url: '/user_post_tags/' + old_name + '.json?dataset=' + params.dataset,
        type: 'DELETE'
      }
    );
    bulk_change = true;
    $.each( $('.tags'), function() {
      var input = $(this);
      if( input.tagExist( old_name)) {
        input.removeTag( old_name);
      }
    });
    bulk_change = false;
    model.tags.remove( this);
  };

  var tag_names = ko.observableArray();
  var tag_index = {};
  model.tags = ko.observableArray();
  function refreshTagList( tags) {
    tag_names.remove(function() { return true;});
    tag_index = {};
    model.tags.remove(function() { return true;});
    $.each( tags, function( name, count) {
      var tag = new Tag( name, count);
      model.tags.push( tag);
      tag_index[ name] = tag;
      tag_names.push( name);
    });
  }

  function tag_names_autocomplete( request, response ) {
	response( $.ui.autocomplete.filter(tag_names(), request.term) );
  };
  
  
  pub.on_ready = function( tags, base_params) {

    $("#tags_filter_all").tagsInput();
    $("#tags_filter_any").tagsInput();
    
    params = base_params;

    refreshTagList( tags);
    model.tags_filter_type = ko.observable( base_params['tags_filter_type'] || 'none');
    ko.applyBindings( model);
    
    $('.tags').each( function() {
      var input = $(this);
      var container = input.parent('.tag-container');

      var save_tags = function() {
        var input_value = input.val();
        
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
      };
      
      input.tagsInput(
        {
          autocomplete_url: tag_names_autocomplete,
          autocomplete: {
            autoFocus: true,
            delay: 0
          },
          onAddTag: function( name) {
            if( bulk_change) {
              return;
            }
            save_tags();
            if( tag_index.hasOwnProperty( name) ) {
              tag_index[ name].count( tag_index[ name].count() + 1);
            } else {
              var tag = new Tag( name, 1);
              wt.insert( model.tags, tag, function( a, b) { return wt.compare( a.name(), b.name()); } );
              tag_index[ name] = tag;
              wt.insert( tag_names, name);
            }
          },
          onRemoveTag: function( name) {
            if( bulk_change) {
              return;
            }
            save_tags();
            if( tag_index.hasOwnProperty( name)) {
              if( tag_index[ name].count() <= 1) {
                model.tags.remove( tag_index[ name]);
                delete tag_index[ name];
                tag_names.remove( name);
              } else {
                tag_index[ name].count( tag_index[ name].count() - 1);
              }
            }
          }
        });
    });


  };

  return pub;
  
}(jQuery);