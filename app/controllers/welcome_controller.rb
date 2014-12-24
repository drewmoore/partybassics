class WelcomeController < ApplicationController
  def index
  end

  def about_us
    url = "https://api.instagram.com/v1/users/1125041972/media/recent/?count=10&client_id=#{ENV["INSTA_CLIENT"]}&redirect_uri=//localhost:3000&response_type=code"
    @pictures = []
    begin
      response = Unirest::get url
      response.body["data"].each do |datum|
        @pictures << datum["images"]["thumbnail"]["url"].gsub("http:", "")
      end
    rescue
      @pictures = []
    end
    respond_to do |format|
      format.js
    end
  end

  def privacy
  end
end
