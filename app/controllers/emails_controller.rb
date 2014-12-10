class EmailsController < ApplicationController
  include EventsHelper

  def new
  end

  def create
    @subject = params[:subject]
    @text = params[:text]
    list = Contact.where("unsubscribed LIKE ?", false)
    list.each do |contact|
      CustomMailer.mass_email(@subject, @text, contact)
    end
    flash[:notice] = "Your email has been sent."
    redirect_to controls_path
  end

  def change
    @content = Content.find_by("identifier LIKE ?", "contact-info-content-main-email")
  end

  def event
    @events = Event.all
  end

  def send_event
    @event = Event.find(params[:event_id])
    @subject = params[:subject]
    @text = params[:text]
    list = Contact.where("unsubscribed LIKE ?", false)
    list.each do |contact|
      CustomMailer.send_event(@event, @subject, @text, contact)
    end
    flash[:notice] = "Your email for #{@event.title} has been sent."
    redirect_to controls_path
  end
end
