class ContentsController < ApplicationController
  def index
    @contents = Content.all
  end

  def new
    @content = Content.new
  end

  def create
    @content = Content.new(content_params)
    if @content.save
      flash[:notice] = "Your new content has been created."
      redirect_to contents_path
    else
      render "new"
    end
  end

  def edit
    @content = Content.find(params[:id])
  end

  def update
    @content = Content.find(params[:id])
    if @content.update_attributes(content_params)
      flash[:notice] = "Your content has been updated."
      redirect_to contents_path
    else
      render "edit"
    end
  end

  def destroy
    @content = Content.find(params[:id])
    if @content.destroy
      redirect_to contents_path, :notice => "The content has been deleted."
    else
      redirect_to contents_path, :notice => "The content could not be deleted."
    end
  end

  private

  def content_params
    params.require(:content).permit(:text, :identifier)
  end
end
