require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions 
    set :session_secret, "secure_password"
  end

  #loads the homepage
  get '/' do 
    erb :index
  end

  #loads signup page
  #sign up page cannot be viewed if logged in
  get '/signup' do
    if !logged_in?
      erb :'/users/create_user'
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
    if logged_in?
      redirect '/tweets'
    else
      erb :'/users/login'
    end
  end

  post '/login' do
    @user = User.find_by(username: params[:username])

    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect '/tweets'
    end
  end

  get '/logout' do
    if logged_in?
      session.clear
      redirect '/login'
    else
      redirect '/'
    end
  end

  get '/users/:slug' do
    @user = User.find_by_slug(params[:slug])
    erb :'/users/show'
  end

  #loads tweet index page
    #if user is not logged in, it will redirect to /login
    get '/tweets' do
        if logged_in?
            #to access current user and all tweets in the views folder
            @user = current_user
            @tweets = Tweet.all
        
            erb :'/tweets/tweets'
        else
            redirect '/login'
        end
    end

    #loads the create tweet form
    get '/tweets/new' do
        if logged_in?
            erb :'/tweets/new'
        else
            redirect '/login'
        end    
    end

    post '/tweet' do
      if logged_in? && !params[:content].empty?
        @tweet = Tweet.create(content: params[:content], user: current_user)
        redirect '/tweets'
      else
        redirect '/tweets/new'
      end
    end

  get '/tweets/:id' do
    if logged_in?
      @user = current_user
      @tweet = Tweet.find_by_id(params[:id])
      erb :'/tweets/show_tweet'
    else
      redirect to '/login'
    end
  end

  get '/tweets/:id/edit' do
    @tweet = Tweet.find_by_id(params[:id])
    if logged_in? && @tweet.user == current_user
      erb :'/tweets/edit_tweet'
    else
      redirect 'login'
    end
  end

  patch '/tweets/:id' do
    @tweet = Tweet.find_by_id(params[:id])
    if !params[:content].empty?
      @tweet.update(content: params[:content])
      @tweet.save
      redirect "tweets/#{params[:id]}"
    else
      redirect "tweets/#{params[:id]}/edit"
    end
  end

  post '/tweets/:id/delete' do
    @tweet = Tweet.find_by_id(params[:id])
    if current_user == @tweet.user
      @tweet.delete
      redirect to '/tweets'
    else
      redirect to "/tweets/#{params[:id]}"
    end
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
