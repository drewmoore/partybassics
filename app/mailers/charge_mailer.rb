class ChargeMailer < ActionMailer::Base
  layout 'email'
  add_template_helper(EventsHelper)

  def purchase_confirmation(purchase, event)
    @purchase = purchase
    @contact = Contact.find_by("id", @purchase.email) || Contact.create(email: @purchase.email)
    @event = event
    @layout = Page.find_by(controller: 'mailers', action: 'template')
    @page = Page.find_by(controller: 'charge_mailers', action: 'purchase_confirmation')
    @graphics = @layout.get_graphics
    @contents = @page.get_contents
    @layout_contents = @layout.get_contents
    @layout.graphics.each do |graphic|
      image_file = graphic.image.current_path.to_s
      attachments.inline[graphic.image.file.file] = File.read image_file
    end
    mail(to: @purchase.email, subject: @page.title, from: @layout_contents["contact-info-content-main-email"].text)
  end
end
