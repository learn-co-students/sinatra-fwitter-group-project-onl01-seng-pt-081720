class UsersController < ApplicationController
    #loads the homepage
  get '/' do 
    erb :index
  end

  #loads signup page
  #sign up page cannot be viewed if logged in
  get '/signup' do
    if !logged_in?
        erb :'/users/signup'
    else
        redirect '/tweets'
    end
  end

  post '/signup' do
    user = User.new(params)

    #saves it to the database
    #checks that they inputed password b/c save method wouldn't work otherwise
    #checks that they inputed a username & email
    if user.save && user.username.length > 0 && user.email.length > 0
        #binding.pry
        session[:user_id] = user.id
        redirect '/tweets'
    else
        redirect '/signup'
    end
  end

  #loads login page
  get '/login' do
    if !logged_in?
        erb :'/users/login'
    else
        redirect '/tweets'
    end
  end

  post '/login' do
    @user = User.find_by(username: params[:username])

    if user && user.authenticate(params[:password])
        session[:user_id] = user.id
        redirect '/tweets'
    end
  end

  get '/logout' do
        if logged_in?
            session.clear
            erb :'/users/logout'
        else
            redirect '/index'
        end
    end
end
