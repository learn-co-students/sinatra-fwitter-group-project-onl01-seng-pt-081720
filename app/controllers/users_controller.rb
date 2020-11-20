class UsersController < ApplicationController

    get "/signup" do
        if session[:id] == nil
          erb :"signup"  
        else
          redirect to "/tweets/tweets"
        end
    end
    
    post '/signup' do
        if params[:username].empty? || params[:email].empty? || params[:password].empty?
          redirect to :signup
        else  
          @user = User.create(username: params[:username], email: params[:email], password: params[:password])
          session[:id] = @user.id
          redirect to "/tweets"
        end
    end

    get "/login" do
        if  logged_in?
           # @users = User.all
            redirect to "/tweets"
        else
            erb :"/login"
        end
    end

    post "/login" do
        @user = User.find_by(username: params[:username])
        if @user && @user.authenticate(params[:password])
            session[:user_id] = @user.id
            redirect to "/tweets"   
        else
            redirect to "/login"   
        end
    end

    get "/logout" do
        session.clear
        redirect to "/login"
    end

    get "/users/:slug" do
        @user = User.find_by_slug(params[:slug])
        erb :"/users/show"
    end

end
