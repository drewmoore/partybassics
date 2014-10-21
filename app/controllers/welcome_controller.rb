class WelcomeController < ApplicationController
  def index
    @page = Page.find_by(controller: params[:controller], action: params[:action])
    @contents = get_contents @page
    @graphics = get_graphics @page
  end

  def trivia
    @page = Page.find_by(controller: params[:controller], action: params[:action])
    @contents = get_contents @page
    @graphics = get_graphics @page
  end

end
