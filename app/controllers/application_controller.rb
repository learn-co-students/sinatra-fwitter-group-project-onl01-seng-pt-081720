require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions 
    set :session_secret, "secure_password"
  end

  helpers do 
    
    #use user_id from session to find the user in the database & return that user
    def current_user
      User.find(session[:user_id])
    end

    #should return true if user_id is in the session
    def logged_in?
      !!session[:user_id]
    end
  end
end
