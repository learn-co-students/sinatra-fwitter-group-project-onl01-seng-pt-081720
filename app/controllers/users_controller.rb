class UsersController < ApplicationController

    #Sign Up

    get '/signup' do
        erb :signup
    end

    post '/signup' do
        #does not let user login without a username
        #log the user in and add the user_id to the session hash
        redirect to "/tweets"
    end
end
