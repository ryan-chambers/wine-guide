class TweetsController < ApplicationController
  before_filter :authenticate, :except => [:bottle]

  class_attribute :app_config
  self.app_config = WineGuide::Application.config

  def bottle
#    p "#{params[:bottle_id]}"
    @bottle = Bottle.find(params[:bottle_id])
#    p "#{@bottle.to_tweet}"
    if @bottle.can_tweet
      respond_to do |format|
        format.json { render :json => {:msg => @bottle.to_tweet }.to_json }
      end
    else
      respond_to do |format|
        format.json { render :json => ''}
      end
    end
  end

  def tweet_bottle
    begin
      t = self.app_config.twitter_client
      p "Sending tweet #{params[:message]}"
      t.update(params[:message])
      p "Tweeting finished"
    rescue Exception => e
      p "Message #{params[:message]} failed to be tweeted."
      p "#{e.message}"
      p "#{e.backtrace.inspect}"
    end

    @wine = Wine.find(params[:wine_id])
    redirect_to wine_path(@wine), :flash => {:tweeted => true}
  end
end
