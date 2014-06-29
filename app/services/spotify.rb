class Spotify

  CLIENT_ID = ENV["SPOTIFY_ID"]
  CLIENT_SECRET = ENV["SPOTIFY_SECRET"]

  attr_accessor :refresh_token, :access_token

  def authorize
    redirect_uri = "http://accounts.spotify.com/api/token"
    scopes = "playlist-read-private%20user-read-private"
    params = "?client_id=#{CLIENT_ID}&response_type=code&redirect_uri=#{redirect_uri}&scope=#{scopes}"
    url = "https://accounts.spotify.com/authorize"
    redirect_to (url + params)
  end

  def get_token(code)
    url = "https://accounts.spotify.com/api/token"
    uri = URI.parse(url)
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE
    req = Net::HTTP::Post.new("/login/")
    req.form_data = {
      "grant_type" => "authorization_code",
      "code" => code,
      "redirect_uri" => "http://localhost:3000",
      "client_id" => CLIENT_ID,
      "client_secret" => CLIENT_SECRET
    }
    response = http.request(req)
    json = JSON.parse(response)
    self.access_token = json["access_token"]
    self.refresh_token = json["refresh_token"]
  end

end
