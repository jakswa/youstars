class HomeController < ApplicationController
  
  def index
  end
 
  #TODO: extract these configs out
  OPTS = {
    client_id: '567772731996.apps.googleusercontent.com',
    client_secret: 'q0rNVgfHakLn-xMuE_KAfy6I',
    redirect_uri: 'http://youstars.com/oauthed',
    grant_type: 'authorization_code'
  }
  def oauth
    url = 'https://accounts.google.com/o/oauth2/token'
    resp = HTTParty.post(url, body: OPTS.merge(code: params[:code]))
    # either this, or check content-type header for JSON
    valid_json = JSON.parse(resp.body) rescue false
    cookies[:ytauth] = valid_json.to_json if valid_json # storing as json string

    redirect_to :action => 'index'
  end
  def youtube_login
    redirect_to "https://accounts.google.com/o/oauth2/auth?access_type=offline&response_type=code&redirect_uri=#{OPTS[:redirect_uri]}&client_id=#{OPTS[:client_id]}&scope=https://www.googleapis.com/auth/youtube.readonly"
  end
end
