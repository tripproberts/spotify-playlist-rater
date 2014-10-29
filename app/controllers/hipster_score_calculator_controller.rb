class HipsterScoreCalculatorController < ApplicationController
  before_filter :ensure_spotify_authorized

  def index
  end

  def redirect
    redirect_to hipster_score_calculator_path
  end

end
