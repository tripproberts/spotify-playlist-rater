$('section#intro h1#playlist-score').hide();
$('section#intro .cs-select').hide();
var opts = {
  lines: 9, // The number of lines to draw
  length: 0, // The length of each line
  width: 7, // The line thickness
  radius: 13, // The radius of the inner circle
  corners: 1, // Corner roundness (0..1)
  rotate: 0, // The rotation offset
  direction: 1, // 1: clockwise, -1: counterclockwise
  color: '#FFF', // #rgb or #rrggbb or array of colors
  speed: 1, // Rounds per second
  trail: 36, // Afterglow percentage
  shadow: false, // Whether to render a shadow
  hwaccel: false, // Whether to use hardware acceleration
  className: 'spinner', // The CSS class to assign to the spinner
  zIndex: 2e9, // The z-index (defaults to 2000000000)
  top: '50%', // Top position relative to parent
  left: '50%' // Left position relative to parent
};
var spinner = new Spinner(opts).spin();
$('section#intro #spinner').append(spinner.el);

$('section#intro h1#playlist-name').html("Loading Playlists...");

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
  spinner.stop();
  $('section#intro h1#playlist-name').html("Your Playlist");
  $('section#intro h1#playlist-score').show();
  $('section#intro div.cs-select').show();
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
  $('section#recent table tbody tr:last').remove();
  var html = "<tr>" +
    "<td class='scale'><div class='progress'><div class='progress-bar' style='width:" +
    score +
    "%'></div></div></td>" +
    "<td class='score'><h3>" + score + "</h3></td>"
  if (spotify_url) {
    html += "<td class='playlist-name'>" +
      "<a target='_blank' href='" + spotify_url + "'><h3>" +
      playlist_name +
      "</h3>" +
      "</a>" +
      ""
  } else {
    html += "<td class='playlist-name'><h3>" +
      playlist_name +
      "</h3>"
  }
  if (owner_name != null) {
    html += "<p>" + owner_name + "</p>"
  }
  html += "</td></tr>"
  $('section#recent table tbody').prepend(html);
}

function format_score(score) {
  return score.toFixed(2);
}

function score_playlist(name, id, owner_id) {

  $('h1#playlist-name').html("Calculating " + name + "...");
  $('section#intro h1#playlist-score').hide();
  $('.cs-placeholder').hide('slow');
  spinner.spin();

  var option = $(this);

  var post = $.post("/scores", {
    owner_id: owner_id,
    id: id
  });

  post.done(function(data) {
    $('h1#playlist-name').html(name);
    $('section#intro h1#playlist-score').show();
    $('h1#playlist-score b').html(format_score(data["score"]));
    $('.cs-placeholder').show('slow');
  });

};

