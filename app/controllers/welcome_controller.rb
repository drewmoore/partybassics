class WelcomeController < ApplicationController
  def index
  end

  def about_us
    instagram = Instagram.new
    @pictures = instagram.recent_media_for_user(ENV['INSTAGRAM_USER_ID'])
    if @pictures[:error_type] == :oauth
      redirect_uri = request.url.remove(":#{ request.port.to_s }")
      @pictures[:authorization_url] = instagram.authorization_url(redirect_uri)
    end


=begin
    url = "https://api.instagram.com/v1/users/1125041972/media/recent/?count=10&client_id=#{ENV["INSTAGRAM_CLIENT"]}&sig=#{ENV["INSTAGRAM_SECRET"]}&redirect_uri=//localhost&response_type=code"
    @pictures = []

    binding.pry

    begin
      response = Unirest::get url
      response.body["data"].each do |datum|
        @pictures << datum["images"]["thumbnail"]["url"].gsub("http:", "")
      end
    rescue
    end
=end
    respond_to do |format|
      format.js
    end
  end

  def privacy
  end
end
