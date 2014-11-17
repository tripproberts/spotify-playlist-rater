$('select#playlists').change(function() {

  $('select#playlists').prop('disabled', 'disabled');

  var option = $(this);

  var post = $.post("/hipster_scores",
                    {
                      owner_id: $(this).attr('data-owner-id'),
                      playlist_id: $(this).attr('data-id')
                    });

  post.done(function(data) {
    $('h1#score').html(option.text() + " - " + format_score(data["score"]));
    $('select#playlists').prop('disabled', false);
  });

});

var get = $.get("/user/playlists");

get.done(function(data) {
  $('option#disabled').append(" (" + data["total"] + " total)");
  $.each(data["playlists"], function(i, val) {
    $('select#playlists').append("<option data-id='"
                                 + val["id"]
                                 + "' data-owner-id='"
                                 + val["owner_id"]
                                 + "'> "
                                 + val["name"]
                                 + "</option>");
  });
  (function() {
    [].slice.call( document.querySelectorAll( 'select.cs-select' ) ).forEach( function(el) {
      new SelectFx(el);
    });
  })();
});

var pusher = new Pusher('550381c30d6f8b253513');
var channel = pusher.subscribe('hipster_scores');
channel.bind('new_score', function(data) {
  updateRecentList(data);
});

function updateRecentList(data) {
  var playlist_name = data.playlist_name;
  var owner_name = data.owner_name;
  var score = format_score(data.score);
  var spotify_url = data.spotify_url;
  if (spotify_url) {
    $('ul#recent').prepend(
      "<li>" +
      "<a target='_blank' href='" +
      spotify_url +
      "'>" +
      playlist_name +
      "</a>" +
      " by " +
      owner_name +
      " - " +
      score
    );
  } else {
    $('ul#recent').prepend(
      "<li>" +
      playlist_name +
      " by " +
      owner_name +
      " - " +
      score
    );
  }
}

function format_score(score) {
  return score.toFixed(2);
}
