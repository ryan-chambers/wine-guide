class ApplicationController < ActionController::Base
  USERS = {ENV['WINE_GUIDE_USERNAME'] => ENV['WINE_GUIDE_PASSWORD']}
  
  protect_from_forgery

  protected
    def authenticate
      authenticate_or_request_with_http_digest do |username|
        USERS[username]
      end
    end
end
