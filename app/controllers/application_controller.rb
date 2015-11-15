class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :get_pages, :get_blank_contact, :set_visitor
  layout :layout_by_resource
  before_filter :update_sanitized_params, if: :devise_controller?

  include Mobvious::Rails::Controller

  def after_sign_in_path_for user
    controls_path
  end

  def after_account_update_path_for user
    controls_path
  end

  def get_pages
    if session
      @pages = Page.all
    end
    @page = Page.find_by(controller: params[:controller], action: params[:action])
    @contents = get_contents @page
    @graphics = get_graphics @page
  end

  def get_blank_contact
    @contact = Contact.new
  end

  def set_visitor
    ip = request.env["HTTP_X_FORWARDED_FOR"]
    @visitor = Visitor.find_by(ip: ip)
    if @visitor
      if params[:controller] === "welcome" and params[:action] === "index"
        @visitor.visits += 1
        @visitor.save
      end
    else
      @visitor = Visitor.create(ip: ip)
    end
    return @visitor
  end

  def avg(top, bottom)
    if bottom.to_f > 0
      return ((top.to_f / bottom.to_f) * 100).to_i.to_f / 100.0
    else
      return 0
    end
  end

  def percent(part, collection)
    part = part.to_f
    collection = collection.to_f
    if collection > 0
      return ((part / collection) * 100).round
    else
      return 0
    end
  end

  private

  def get_contents page
    contents = {}
    if page
      page.contents.each do |c|
        contents[c.identifier] = c
      end
    end
    return contents
  end

  def get_graphics page
    graphics = {}
    if page
      page.graphics.each do |g|
        graphics[g.identifier] = g
      end
    end
    return graphics
  end

  protected

  def layout_by_resource
    if devise_controller?
      "users_custom"
    else
      "application"
    end
  end

  def update_sanitized_params
    devise_parameter_sanitizer.for(:account_update) << :role
  end

end
