class TweetsController < ApplicationController

    #Index
    get '/tweets' do
        if logged_in?
            @user = User.find_by(id: session[:user_id])
            @tweets = Tweet.all
        erb :'tweets/index'
        else 
            redirect to '/login'
        end
    end

    

end
