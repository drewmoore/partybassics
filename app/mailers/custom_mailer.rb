class CustomMailer < ActionMailer::Base
  helper 'application'
  helper 'events'
  layout 'email'

  def mass_email(subject, text, contact)
    @layout = Page.find_by("controller LIKE ? and action LIKE ?", "mailers", "template")
    @subject = subject || @layout.title
    @text = text || ""
    @contact = contact
    @layout_contents = @layout.get_contents
    @graphics = @layout.get_graphics
    @layout.graphics.each do |graphic|
      image_file = graphic.image.current_path.to_s
      attachments.inline[graphic.image.file.file] = File.read image_file
    end
    main_email = @layout_contents["contact-info-content-main-email"].text
    mail(subject: @subject, to: @contact.email, from: main_email).deliver
  end

  def send_event(event, subject, text, contact)
    @event = event
    @layout = Page.find_by("controller LIKE ? and action LIKE ?", "mailers", "template")
    @page = Page.find_by("controller LIKE ? and action LIKE ?", "mailers", "send_event")
    @subject = subject || @layout.title
    @text = text || ""
    @contact = contact
    @layout_contents = @layout.get_contents
    @contents = @page.get_contents
    @graphics = @layout.get_graphics
    @layout.graphics.each do |graphic|
      image_file = graphic.image.current_path.to_s
      attachments.inline[graphic.image.file.file] = File.read image_file
    end
    if File.exists? event.flyer.versions[:portrait].display.path
      image_file = @event.flyer.versions[:portrait].display.current_path.to_s
      attachments.inline["flyer.jpg"] = File.read image_file
    elsif File.exists? event.flyer.versions[:landscape].display.path
      image_file = @event.flyer.versions[:landscape].display.current_path.to_s
      attachments.inline["flyer.jpg"] = File.read image_file
    end
    main_email = @layout_contents["contact-info-content-main-email"].text
    mail(subject: @subject, to: @contact.email, from: main_email).deliver
  end
end
