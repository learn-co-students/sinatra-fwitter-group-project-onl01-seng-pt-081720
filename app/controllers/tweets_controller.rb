
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
#New
get '/tweets/new' do
    if logged_in?
        erb :'tweets/new'
    else
        redirect to '/login'
end
end

post '/tweets' do
    if logged_in?
        if params[:content] == ""
            redirect to 'tweets/new'
        else
            tweet = Tweet.new(params)
            tweet.user_id = session[:user_id]
            tweet.save   
            redirect to '/tweets'
        end
    else redirect to '/login'
    end
end

    #Show
    get '/tweets/:id' do
        if logged_in?
        @tweet = Tweet.find_by_id(params[:id])
        erb :'tweets/show_tweet'
        else
            redirect to '/login'
        end
    end

    #Delete
    delete '/tweets/:id/delete' do
    tweet = Tweet.find_by_id(params[:id])
    if logged_in? && tweet.user == current_user
        tweet.destroy
        redirect to '/tweets'
    else 
        flash[:message] = "Action Not Allowed"
end
end

#Edit
 
  get '/tweets/:id/edit' do
    @tweet = Tweet.find_by_id(params[:id])
    if logged_in?
      erb :'tweets/edit_tweet'
    else
        redirect to '/login'
  end
end
    
patch '/tweets/:id' do
    tweet = Tweet.find_by_id(params[:id])
    if logged_in? && tweet.user == current_user
        if !params[:content].empty?
           tweet.update(content: params[:content])
           tweet.save
            redirect to '/tweets'
        else
        redirect to "tweets/#{tweet.id}/edit"
    end 
else 
    redirect to '/login'
end
end

end

    

