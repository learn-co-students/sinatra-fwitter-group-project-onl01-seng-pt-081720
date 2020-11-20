class TweetsController < ApplicationController
    
    get "/tweets" do
        if logged_in?
            @user = User.find_by(id: session[:user_id])
            @tweets = Tweet.all
            erb :"/tweets/index"
        else
            redirect to "/login"
        end
    end

    get "/tweets/new" do
        if logged_in?
            erb :"/tweets/new"
        else
            redirect to "/login"
        end
    end

    post "/tweets/new" do
        if logged_in?
            @tweet = Tweet.new(params)
            @tweet.user_id = session[:user_id]
            @tweet.save
        else
            redirect to "/login"
        end
    end

    get "/tweets/:id" do 
        if logged_in?
            @tweet = Tweet.find_by(id: params[:id])
            erb :"/tweets/show_tweet"
        else
            redirect to "/login"
        end
    end

    get "/tweets/:id/edit" do
        @tweet = Tweet.find_by(id: params[:id])
        if logged_in? && @tweet.user[:id] == session[:user_id]
            erb :"/tweets/edit"
        else
            redirect to "/login"
        end
    end
    
    patch "/tweets/:id/edit" do
        @tweet = Tweet.find_by(id: params[:id])
        if logged_in? && @tweet.user[:id] == session[:user_id]
            @tweet.content = params[:content]
            @tweet.save
        else
            redirect to "/login"
        end
    end

    delete "/tweets/:id/delete" do
        tweet = Tweet.find_by(id: params[:id])
        if logged_in? && tweet.user[:id] == session[:user_id]
            tweet.destroy
        else
            redirect to "/login"
        end
        redirect to "/tweets"
    end
end
