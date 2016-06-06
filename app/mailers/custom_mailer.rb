class CustomMailer < ActionMailer::Base
  helper 'application'
  helper 'events'
  layout 'email'

  def mass_email(subject, text, contact)
    @layout = Page.find_by(controller: 'mailers', action: 'template')
    @subject = subject || @layout.title
    @text = text || ""
    @contact = contact
    @layout_contents = @layout.get_contents
    @graphics = @layout.get_graphics
    main_email = @layout_contents["contact-info-content-main-email"].text
    mail(subject: @subject, to: @contact.email, from: main_email).deliver
  end

  def send_event(event, subject, text, contact)
    @event = event
    @layout = Page.find_by(controller: 'mailers', action: 'template')
    @page = Page.find_by(controller: 'mailers', action: 'send_event')
    @subject = subject || @layout.title
    @text = text || ""
    @contact = contact
    @layout_contents = @layout.get_contents
    @contents = @page.get_contents
    @graphics = @layout.get_graphics
    if File.exists? event.flyer.versions[:portrait].display.path
      image_file = @event.flyer.versions[:portrait].display.current_path.to_s
    elsif File.exists? event.flyer.versions[:landscape].display.path
      image_file = @event.flyer.versions[:landscape].display.current_path.to_s
    end
    main_email = @layout_contents["contact-info-content-main-email"].text
    mail(subject: @subject, to: @contact.email, from: main_email).deliver
  end
end
