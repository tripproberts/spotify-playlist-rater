class CalculatorController < ApplicationController
  before_filter :ensure_spotify_authorized

  def index
  end

  def redirect
    redirect_to calculator_path
  end

end
