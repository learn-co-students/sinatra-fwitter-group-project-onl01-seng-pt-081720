class TweetsController < ApplicationController


    get '/tweets' do
        @tweets = Tweet.all
        if self.logged_in?
            erb :'tweets/index'
        else
            redirect '/login'
        end
    end

    get '/tweets/new' do
        if self.logged_in?
            erb :'tweets/new'
        else
            redirect '/login'
        end
    end

    post '/tweets' do
        if !params[:content].empty?
            tweet = Tweet.create(content: params[:content], user_id: session[:user_id])
            redirect '/tweets'
        else
            redirect '/tweets/new'
        end
    end

    get '/tweets/:id' do
        if self.logged_in?
            @tweet = Tweet.find_by_id(params[:id])
            erb :'tweets/show'
        else
            redirect '/login'
        end
    end

    delete '/tweets/:id' do
        tweet = Tweet.find_by_id(params[:id])
        if tweet.user_id == session[:user_id]
            tweet.destroy
            redirect '/tweets'
        else
            redirect "/tweets/#{tweet.id}"
        end
    end

    get '/tweets/:id/edit' do
        @tweet = Tweet.find_by_id(params[:id])
        if self.logged_in? && session[:user_id] == @tweet.user_id
            erb :'tweets/edit'
        elsif self.logged_in?
            redirect "/tweets/#{@tweet.id}"
        else
            redirect '/login'
        end
    end

    patch '/tweets/:id' do
        tweet = Tweet.find_by_id(params[:id])
        if !params[:content].empty?
            tweet.content = params[:content]
            tweet.save
            redirect "/tweets/#{tweet.id}" 
        else
            redirect "/tweets/#{tweet.id}/edit"
        end
    end
end
