$('select#playlists').on('click', 'option', function() {

  var option = $(this);

  var post = $.post("/hipster_scores",
                    {
                      owner_id: $(this).attr('data-owner-id'),
                      playlist_id: $(this).attr('data-id')
                    });

  post.done(function(data) {
    $('h1#score').html(option.text() + " - " + data["score"]);
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
