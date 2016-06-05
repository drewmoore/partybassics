# Seed pages from heroku.
[
  {:title=>"Party Bassics", :controller=>"welcome", :action=>"index"}, {:title=>"Party Bassics", :controller=>"welcome", :action=>"about_us"}, {:title=>"Party Bassics", :controller=>"events", :action=>"display"}, {:title=>"Party Bassics", :controller=>"events", :action=>"display_one"}, {:title=>"Party Bassics", :controller=>"charges", :action=>"new"}, {:title=>"Party Bassics", :controller=>"charges", :action=>"create"}, {:title=>"Party Bassics", :controller=>"contacts", :action=>"update"}, {:title=>"Party Bassics", :controller=>"mailers", :action=>"template"}, {:title=>"Party Bassics", :controller=>"mailers", :action=>"send_event"}, {:title=>"Party Bassics", :controller=>"charge_mailers", :action=>"purchase_confirmation"}
].each do |page|
  next if Page.find_by(controller: page[:controller], action: page[:action])
  Page.create!(page)
end

# Seed contents from heroku.
[
  {:text=>"Dance Your Demons Out", :identifier=>"heading-tagline"}, {:text=>"About Us", :identifier=>"three-column-button"}, {:text=>"Events", :identifier=>"panorama-column-button"}, {:text=>"Follow Us", :identifier=>"social-media-prompt"}, {:text=>"Join Us", :identifier=>"facebook-group-prompt"}, {:text=>"Like This Site", :identifier=>"like-website-prompt"}, {:text=>"Login", :identifier=>"admin-link"}, {:text=>"Join the Mailing List", :identifier=>"welcome-page-email-list-subscribe-link"}, {:text=>"Site by <a href=\"http://andrewwilliammoore.com\" target=\"_blank\">Drew Moore</a>", :identifier=>"website-author-link"}, {:text=>"Pics", :identifier=>"instagram-panel-heading"}, {:text=>"Info", :identifier=>"main-info-panel-heading"}, {:text=>"Partybassics is based in Nashville, TN.", :identifier=>"main-info-panel-text"}, {:text=>"Stay in Touch", :identifier=>"contact-info-panel-heading"}, {:text=>"Contact Us", :identifier=>"contact-info-content-heading"}, {:text=>"Email", :identifier=>"contact-info-content-main-email"}, {:text=>"Social", :identifier=>"social-info-content-heading"}, {:text=>"Get Tickets", :identifier=>"event-display-ticket-link"}, {:text=>"Facebook Event", :identifier=>"event-display-facebook-link"}, {:text=>"Price", :identifier=>"charges-new-price-label"}, {:text=>"Quantity", :identifier=>"charges-new-quantity-label"}, {:text=>"Buy Tickets", :identifier=>"charges-new-purchase-button"}, {:text=>"Thank You", :identifier=>"charges-receipt-page-heading"}, {:text=>"Back to Home", :identifier=>"charges-receipt-link-back"}, {:text=>"Join Mailing List", :identifier=>"email-list-subscribe-link"}, {:text=>"New Event from Party Bassics", :identifier=>"email-event-display-ticket-link"}, {:text=>"Facebook Event", :identifier=>"email-event-display-facebook-link"}, {:text=>"Confirmation for Your Tickets with Party Bassics", :identifier=>"email-ticket-confirmation-heading"}
].each do |content|
  next if Content.find_by(identifier: content[:identifier])
  Content.create!(content)
end

# Seed graphics from heroku.
[
  {:identifier=>"logo-image"}, {:identifier=>"email-logo-image"}
].each do |graphic|
  next if Graphic.find_by(identifier: graphic[:identifier])
  Graphic.create!(graphic)
end

# Associate contents and pages
[
  {:identifier=>"heading-tagline", :pages=>[{:action=>"index", :controller=>"welcome"}]}, {:identifier=>"three-column-button", :pages=>[{:action=>"index", :controller=>"welcome"}]}, {:identifier=>"panorama-column-button", :pages=>[{:action=>"index", :controller=>"welcome"}]}, {:identifier=>"social-media-prompt", :pages=>[{:action=>"index", :controller=>"welcome"}]}, {:identifier=>"facebook-group-prompt", :pages=>[{:action=>"index", :controller=>"welcome"}]}, {:identifier=>"like-website-prompt", :pages=>[{:action=>"index", :controller=>"welcome"}]}, {:identifier=>"admin-link", :pages=>[{:action=>"index", :controller=>"welcome"}]}, {:identifier=>"welcome-page-email-list-subscribe-link", :pages=>[{:action=>"index", :controller=>"welcome"}]}, {:identifier=>"website-author-link", :pages=>[{:action=>"index", :controller=>"welcome"}]}, {:identifier=>"instagram-panel-heading", :pages=>[{:action=>"about_us", :controller=>"welcome"}]}, {:identifier=>"main-info-panel-heading", :pages=>[{:action=>"about_us", :controller=>"welcome"}]}, {:identifier=>"main-info-panel-text", :pages=>[{:action=>"about_us", :controller=>"welcome"}]}, {:identifier=>"contact-info-panel-heading", :pages=>[{:action=>"about_us", :controller=>"welcome"}]}, {:identifier=>"contact-info-content-heading", :pages=>[{:action=>"about_us", :controller=>"welcome"}]}, {:identifier=>"contact-info-content-main-email", :pages=>[{:action=>"about_us", :controller=>"welcome"}]}, {:identifier=>"social-info-content-heading", :pages=>[{:action=>"about_us", :controller=>"welcome"}]}, {:identifier=>"event-display-ticket-link", :pages=>[{:action=>"display_one", :controller=>"events"}]}, {:identifier=>"event-display-facebook-link", :pages=>[{:action=>"display_one", :controller=>"events"}]}, {:identifier=>"charges-new-price-label", :pages=>[{:action=>"new", :controller=>"charges"}]}, {:identifier=>"charges-new-quantity-label", :pages=>[{:action=>"new", :controller=>"charges"}]}, {:identifier=>"charges-new-purchase-button", :pages=>[{:action=>"new", :controller=>"charges"}]}, {:identifier=>"charges-receipt-page-heading", :pages=>[{:action=>"create", :controller=>"charges"}]}, {:identifier=>"charges-receipt-link-back", :pages=>[{:action=>"create", :controller=>"charges"}]}, {:identifier=>"email-list-subscribe-link", :pages=>[{:action=>"update", :controller=>"contacts"}]}, {:identifier=>"email-event-display-ticket-link", :pages=>[{:action=>"send_event", :controller=>"mailers"}]}, {:identifier=>"email-event-display-facebook-link", :pages=>[{:action=>"send_event", :controller=>"mailers"}]}, {:identifier=>"email-ticket-confirmation-heading", :pages=>[{:action=>"purchase_confirmation", :controller=>"charge_mailers"}]}
].each do |content_hash|
  content = Content.find_by!(identifier: content_hash[:identifier])
  content_hash[:pages].each do |page_hash|
    page = Page.find_by!(page_hash)
    content.pages << page unless content.pages.include?(page)
  end
end

# Associate graphics and pages
[
  {:identifier=>"logo-image", :pages=>[{:action=>"index", :controller=>"welcome"}]}, {:identifier=>"email-logo-image", :pages=>[{:action=>"send_event", :controller=>"mailers"}, {:action=>"purchase_confirmation", :controller=>"charge_mailers"}]}
].each do |graphic_hash|
  graphic = Graphic.find_by!(identifier: graphic_hash[:identifier])
  graphic_hash[:pages].each do |page_hash|
    page = Page.find_by!(page_hash)
    graphic.pages << page unless graphic.pages.include?(page)
  end
end

# Update and associate contents that had previously been missing:
content = Content.find_by!(identifier: 'contact-info-content-main-email')
content.update_attributes(text: 'info@partybassics.com')
content.pages << Page.find_by!(controller: 'mailers', action: 'template')

# Associate graphics that had previously been missing:
graphic = Graphic.find_by!(identifier: 'email-logo-image')
graphic.pages << Page.find_by!(controller: 'mailers', action: 'template')

# Assign default image file to graphics.
Graphic.all.each do |graphic|
  next if graphic.image.file
  graphic.image = File.open("#{Rails.root}/db/seed_assets/old_logo.png")
  graphic.save!
end
