class HipsterCalculator

  def self.score_playlists_for(user_id)
    user = RSpotify::User.find(user_id)
    scores = []
    playlists = user.playlists
    playlists.each do |playlist|
      if playlist.owner.id == user_id && playlist.public
        score = {
          name: playlist.name,
          score: score_playlist(user_id, playlist.id)
        }
        scores << score
      end
    end
    return scores
  end

  def self.score_playlist(user, playlist_id)
    playlist = RSpotify::Playlist.find(user, playlist_id)
    score = 0
    track_count = playlist.tracks.count
    if track_count > 0
      playlist.tracks.each do |track|
        if !track.available_markets.blank?
          score += ((0.5) * track.popularity) + ((0.5) * score_artists(track.artists))
        else
          --track_count
        end
      end
      return score / playlist.tracks.count
    else
      raise HipsterCalculatorError.new("Can't calculate hipster score for empty playlist")
    end
  end

  def self.score_track(track_id)
    if track_id !=nil
      track = RSpotify::Track.find(track_id)
      track_score = track.popularity
      artists_score = score_artists(track.artists)
      return (0.5) * track_score + (0.5) * artists_score
    else
      raise HipsterCalculatorError.new("Can't calculate hipster score for nil track")
    end
  end

  def self.score_artists(artists)
    if artists != nil
      score = 0
      artists.each do |artist|
        score += score_artist(artist.id)
      end
      return score / artists.length
    else
      raise HipsterCalculatorError.new("Can't calculate hipster score for nil artist")
    end
  end

  def self.score_artist(artist_id)
    artist = RSpotify::Artist.find(artist_id)
    artist.popularity
  end

end
