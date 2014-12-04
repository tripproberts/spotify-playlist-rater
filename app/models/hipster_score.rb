class HipsterScore < ActiveRecord::Base

  belongs_to :playlist
  belongs_to :user

  scope :recent, ->(num) { order('updated_at DESC').limit(num) }

  def self.top(num)
    score_list = []
    playlist_list = []
    sorted_scores = HipsterScore.order('score DESC').includes(:playlist)
    total_score_count = HipsterScore.count
    counter = 0
    num.times do
      current_score = sorted_scores[counter]
      while (counter < total_score_count &&
          playlist_list.include?(current_score.playlist))
        counter += 1
        current_score = sorted_scores[counter]
      end
      if (counter == total_score_count)
        return score_list
      end
      playlist_list << current_score.playlist
      score_list << current_score
    end
    score_list
  end

  def calculate_score
    RSpotify.authenticate(ENV["SPOTIFY_ID"], ENV["SPOTIFY_SECRET"])
    @r_playlist = RSpotify::Playlist.find(playlist.owner_id, playlist.spotify_id)
    @previous_score = playlist.hipster_scores.last(2)[0]
    if @previous_score == self ||
        @r_playlist.snapshot_id != @previous_score.playlist_snapshot_id
      self.update(score: Calculator.score_playlist(@r_playlist))
    else
      self.update(score: @previous_score.score)
    end
    self.update(playlist_snapshot_id: @r_playlist.snapshot_id)
  end

end
