class Instagram
  include HTTParty
  base_uri 'https://api.instagram.com'

  def initialize
    @options = { query: {
      client_id: ENV['INSTAGRAM_CLIENT'],
      sig: ENV["INSTAGRAM_SECRET"],
      redirect_uri: '//localhost',
      response_type: 'code' } }
  end

  def recent_media_for_user(user_id, count = 10)
    results = {}
    response = self.class.get("/v1/users/#{ user_id }/media/recent/",
                              @options.merge({ count: count.to_s }))
    if response['error_type'] == 'OAuthForbiddenException'
      results[:error_type] = :oauth
    else
      results[:payload] = []

      Rails.logger.debug "\n\n hello: #{ response }\n\n"
      
      response.body['data'].each do |datum|
        results[:payload] << datum['images']['thumbnail']['url'].gsub('http:', '')
      end
    end
    results
  end

  def authorization_url(redirect_uri = 'http://localhost')
    endpoint = "#{ self.class.base_uri }/oauth/authorize/"
    params   = "?client_id=#{ ENV['INSTAGRAM_CLIENT'] }" +
               "&redirect_uri=#{ redirect_uri }&response_type=code"
    endpoint + params
  end
end
