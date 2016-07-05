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
    main_email = @layout_contents["contact-info-content-main-email"].text
    mail(subject: @subject, to: @contact.email, from: main_email).deliver
  end
end
