class UsersController < ApplicationController

    get '/signup' do
        if self.logged_in?
            redirect '/tweets'
        else
            erb :'users/new'
        end
    end

    post '/signup' do
        if User.new(params).valid?
            user = User.create(params)
            session[:user_id] = user.id
            redirect '/tweets'
        else
            redirect '/signup'
        end
    end

    get '/login' do
        if self.logged_in?
            redirect '/tweets'
        else
            erb :'users/login'
        end
    end

    post '/login' do
        @user = User.find_by(username: params[:username])
        if @user && @user.authenticate(params[:password])
            session[:user_id] = @user.id
            redirect '/tweets'
        else
            redirect '/login'
        end
    end

    get '/logout' do
        !!session[:user_id] = nil
        redirect '/login'
    end

    get '/users/:id' do
        @user = User.find_by(username: params[:id])

        erb :'users/show'
    end

    
end
