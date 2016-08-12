class Instagram
  include HTTParty
  base_uri 'https://api.instagram.com'

  def initialize(protocol, host, callback_path, access_token = nil)
    @redirect_uri   = protocol + host + callback_path
    @access_token   = access_token
    @version_prefix = '/v1'
    @client_id      = ENV['INSTAGRAM_CLIENT']
    @client_secret  = ENV["INSTAGRAM_SECRET"]
  end

  def recent_media_for_user(user_id, count = 10)
    return { error_type: :user_id }      unless user_id
    return { error_type: :access_token } unless @access_token
    endpoint = "/users/#{ user_id }/media/recent"
    params   = { access_token: @access_token, count: count.to_s }
    params[:sig] = signed_request(endpoint, params)
    response = self.class.get(@version_prefix + endpoint, query: params)

    return { error_type: :oauth }   if response['error_type'] == 'OAuthForbiddenException'
    return { error_type: :request } if response['meta']['error_type'] == "APINotFoundError"

    payload = response['data'].map do |datum|
      datum['images']['thumbnail']['url'].gsub('http:', '')
    end
    { payload: payload }
  end

  def user_search(username)
    return { error_type: :access_token } unless @access_token
    endpoint = '/users/search'
    params   = { access_token: @access_token, q: username }
    params[:sig] = signed_request(endpoint, params)
    self.class.get(@version_prefix + endpoint, query: params)
  end

  def request_access_token(code)
    # After the user authorizes instagram, an authorization code is sent back.
    # Use that to request an access token that will be stored in the session.
    result   = {}
    endpoint = '/oauth/access_token'
    params   = {
      client_id: @client_id, client_secret: @client_secret,
      code: code, grant_type: 'authorization_code', redirect_uri: @redirect_uri
    }
    response = self.class.post(endpoint, body: params)
    if response && response['access_token']
      result[:access_token] = response['access_token']
    else
      result[:error] = true
    end
    result
  end

  def authorization_url(options = {})
    # Build a url that will be rendered in a link for the user to authorize instagram.
    endpoint = '/oauth/authorize/'
    params   = "?client_id=#{ @client_id }"\
               "&redirect_uri=#{ @redirect_uri }&response_type=code"\
               '&scope=public_content'
    options.each { |k, v| params += "&#{ k.to_s }=#{ v.to_s }" }
    self.class.base_uri + endpoint + params
  end

  private

  def signed_request(endpoint, params)
    # Copied from Instagram API docs.
    sig = endpoint
    params.sort.map do |key, val|
      sig += '|%s=%s' % [key, val]
    end
    digest = OpenSSL::Digest::Digest.new('sha256')
    return OpenSSL::HMAC.hexdigest(digest, @client_secret, sig)
  end
end
