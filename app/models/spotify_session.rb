class SpotifySession < ActiveRecord::Base

  CLIENT_ID = ENV["SPOTIFY_ID"]
  CLIENT_SECRET = ENV["SPOTIFY_SECRET"]

  attr_accessor :access_token

  def self.authorize_url
    redirect_uri = "http://accounts.spotify.com/api/token"
    scopes = "playlist-read-private%20user-read-private"
    params = "?client_id=#{CLIENT_ID}&response_type=code&redirect_uri=#{redirect_uri}&scope=#{scopes}"
    url = "https://accounts.spotify.com/authorize"
    (url + params)
  end

  def initialize_tokens(code)
    url = "https://accounts.spotify.com/"
    uri = URI.parse(url)
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE
    req = Net::HTTP::Post.new("/api/token")
    req.form_data = {
      "grant_type" => "authorization_code",
      "code" => code,
      "redirect_uri" => "http://localhost:3000",
      "client_id" => CLIENT_ID,
      "client_secret" => CLIENT_SECRET
    }
    response = http.request(req)
    if response.code.to_i == 200
      json = JSON.parse(response)
      @access_token = json["access_token"]
      self.update(refresh_token: json["refresh_token"])
    else
      raise Exceptions::SpotifySessionError.new("Didn't get 200 response from Spotify. Response: " + response.body)
    end
  end

  def refresh_access_token
    url = "https://accounts.spotify.com/"
    uri = URI.parse(url)
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE
    req = Net::HTTP::Post.new("/api/token")
    req.form_data = {
      "grant_type" => "refresh_token",
      "refresh_token" => refresh_token,
    }
    req.basic_auth(CLIENT_ID, CLIENT_SECRET)
    response = http.request(req)
    if response.code.to_i == 200
      json = JSON.parse(response)
      @access_token = json["access_token"]
    else
      raise Exceptions::SpotifySessionError.new("Didn't get 200 response from Spotify. Response: " + response.body)
    end
  end

end
