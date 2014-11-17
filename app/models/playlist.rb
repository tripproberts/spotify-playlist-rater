class Playlist < ActiveRecord::Base
  belongs_to :user
  has_many :hipster_scores
end
