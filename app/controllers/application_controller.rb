require './config/environment'
require 'rack-flash'


class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "secret"
    use Rack::Flash
  end

  #Index

  get '/' do
    if !logged_in?
     erb :index
    else
      redirect to '/tweets'
  end
end

  
  helpers do
    def logged_in?
      !!session[:user_id]
    end

  def current_user 
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
end
  
end
