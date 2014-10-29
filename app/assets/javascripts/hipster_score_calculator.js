$('select#playlists').on('click', 'option', function() {

  var option = $(this);

  var get = $.get("/hipster_scores?owner_id=" + $(this).attr('data-owner-id') + "&playlist_id=" + $(this).attr('data-id'));

  get.done(function(data) {
    $.each(data, function(i, val) {
      $('ul#tracks').append('<li>' + option.text() + " - " + val["score"] + '</li>');
    });
  });

});

var get = $.get("/user/playlists");

get.done(function(data) {
  $('h4#count').html(data["total"] + " playlists");
  $.each(data["playlists"], function(i, val) {
    $('select#playlists').append("<option data-id='"
                                 + val["id"]
                                 + "' data-owner-id='"
                                 + val["owner_id"]
                                 + "'> "
                                 + val["name"]
                                 + "</option>");
  });
});
