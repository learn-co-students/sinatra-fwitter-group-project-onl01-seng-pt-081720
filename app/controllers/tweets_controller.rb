class TweetsController < ApplicationController
    #loads tweet index page
    #if user is not logged in, it will redirect to /login
    get '/tweets' do
        if logged_in?
            #to access current user and all tweets in the views folder
            @user = current_user
            @tweets = Tweet.all
        
            erb :'/tweets/index'
        else
            redirect '/login'
        end
    end

    #loads the create tweet form
    get '/tweets/new' do
        if logged_in?
            @user = current_user
            erb :'/tweets/new'
        else
            redirect '/login'
        end    
    end

    post '/tweets' do
    
    end
end
