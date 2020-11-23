class TweetsController < ApplicationController

    #Index
    get '/tweets' do
        erb :'tweets/index'
    end

end
