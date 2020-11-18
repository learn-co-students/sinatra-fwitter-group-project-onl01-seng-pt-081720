class TweetsController < ApplicationController
    
    get "/tweets" do
        @tweets = Tweet.all
        erb :"index"
    end

end
