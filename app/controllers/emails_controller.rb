class EmailsController < ApplicationController
  def new
  end

  def create
    @subject = params[:subject]
    @text = params[:text]
    CustomMailer.mass_email(@subject, @text).deliver
    flash[:notice] = "Your email has been sent."
    redirect_to controls_path
  end
end
