class PagesController < ApplicationController
  def index
    @pages = Page.all
  end

  def new
    @page = Page.new
  end

  def create
    @page = Page.new(page_params)
    if @page.save
      flash[:notice] = "The new page has been created for #{page_params[:controller]}##{page_params[:action]}"
      redirect_to pages_path
    else
      render "new"
    end
  end

  def edit
    @page = Page.find(params[:id])
    @contents = Content.all
    @graphics = Graphic.all
  end

  def update
    @page = Page.find(params[:id])
    if @page.update_attributes(page_params)
      flash[:notice] = "Page at #{@page.controller}##{@page.action} has been updated."
      redirect_to pages_path
    else
      render "edit"
    end
  end

  def destroy
    @page = Page.find(params[:id])
    controller = @page.controller
    action = @page.action
    if @page.destroy
      redirect_to pages_path, :notice => "Page at #{controller}##{action} has been deleted."
    else
      redirect_to pages_path, :notice => "Page at #{controller}##{action} could not be deleted."
    end
  end

  def add_content
    @page = Page.find(params[:pageId])
    @content = Content.find(params[:contentId])
    @errors = []
    if !@page.contents.exists? @content
      @page.contents << @content
    else
      @errors << "Page already contains that content."
    end
    respond_to do |format|
      format.js
    end
  end

  def remove_content
    @page = Page.find(params[:pageId])
    @page.contents.delete(params[:contentId])
    respond_to do |format|
      format.js
    end
  end

  def add_graphic
    @page = Page.find(params[:pageId])
    @graphic = Graphic.find(params[:graphicId])
    @errors = []
    if !@page.graphics.exists? @graphic
      @page.graphics << @graphic
    else
      @errors << "Page already contains that graphic."
    end
    respond_to do |format|
      format.js
    end
  end

  def remove_graphic
    @page = Page.find(params[:pageId])
    @page.graphics.delete(params[:graphicId])
    respond_to do |format|
      format.js
    end
  end

  private
  def page_params
    params.require(:page).permit(:title, :controller, :action)
  end
end
