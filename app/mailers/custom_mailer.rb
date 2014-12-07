class CustomMailer < ActionMailer::Base
  default to: ["drew@noiseshift.com", "fireisborn@noiseshift.com", "teloaster@yahoo.com"]
  layout 'email'

  def mass_email(subject, text)
    @layout = Page.find_by("controller LIKE ? and action LIKE ?", "mailers", "template")
    @subject = subject || @layout.title
    @text = text || ""
    @layout_contents = @layout.get_contents
    @graphics = @layout.get_graphics
    @layout.graphics.each do |graphic|
      image_file = graphic.image.current_path.to_s
      attachments.inline[graphic.image.file.file] = File.read image_file
    end
    mail(subject: @subject, from: @layout_contents["contact-info-content-main-email"].text)
  end
end
