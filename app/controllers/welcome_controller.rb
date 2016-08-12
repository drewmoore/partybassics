class WelcomeController < ApplicationController
  def index
    @redirect_path = session[:redirect_path]
    session.delete(:redirect_path)
  end

  def about_us
    instagram = Instagram.new(
      request.protocol, request.host, instagram_callback_path,
      session[:instagram_access_token]
    )
    
    @pictures = instagram.recent_media_for_user(ENV['INSTAGRAM_USER_ID'])
    if @pictures[:error_type]
      @pictures[:authorization_url] = instagram.authorization_url(state: request.path)
    end

    respond_to do |format|
      format.js
    end
  end

  def instagram_callback
    session[:redirect_path] = params[:state]
    code = params[:code]
    if code.present?
      instagram = Instagram.new(request.protocol, request.host, instagram_callback_path)
      response = instagram.request_access_token(code)
      session[:instagram_access_token] = response[:access_token] unless response[:error]
    end
    redirect_to action: :index
  end

  def privacy
  end
end
