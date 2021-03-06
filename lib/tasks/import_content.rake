namespace :import do
  desc 'Import Site Content and Graphics'

  task :content => :environment do
    # Create the page views for the site.
    welcome_index_page = Page.create!(controller: 'welcome', action: 'index', title: 'Party Bassics')
    welcome_about_us_page = Page.create!(controller: 'welcome', action: 'about_us', title: 'Party Bassics')
    events_display_page = Page.create!(controller: 'events', action: 'display', title: 'Party Bassics')
    events_display_one_page = Page.create!(controller: 'events', action: 'display_one', title: 'Party Bassics')
    charges_new_page = Page.create!(controller: 'charges', action: 'new', title: 'Party Bassics')
    charges_create_page = Page.create!(controller: 'charges', action: 'create', title: 'Party Bassics')
    contacts_update_page = Page.create!(controller: 'contacts', action: 'update', title: 'Party Bassics')
    mailers_template_page = Page.create!(controller: 'mailers', action: 'template', title: 'Party Bassics')
    mailers_send_event_page = Page.create!(controller: 'mailers', action: 'send_event', title: 'Party Bassics')
    charge_mailers_purchase_confirmation_page = Page.create!(
      controller: 'charge_mailers', action: 'purchase_confirmation', title: 'Party Bassics'
    )

    # welcome#index

    welcome_index_page.contents.create!(identifier: 'heading-tagline', text: 'Dance Your Demons Out')
    welcome_index_page.contents.create!(identifier: 'three-column-button', text: 'About Us')
    welcome_index_page.contents.create!(identifier: 'panorama-column-button', text: 'Events')
    welcome_index_page.contents.create!(identifier: 'social-media-prompt', text: 'Follow Us')
    welcome_index_page.contents.create!(identifier: 'facebook-group-prompt', text: 'Join Us')
    welcome_index_page.contents.create!(identifier: 'like-website-prompt', text: 'Like This Site')
    welcome_index_page.contents.create!(identifier: 'admin-link', text: 'Login')
    welcome_index_page.contents.create!(identifier: 'welcome-page-email-list-subscribe-link', text: 'Join the Mailing List')
    welcome_index_page.contents.create!(
      identifier: 'website-author-link',
      text: 'Site by <a href="http://andrewwilliammoore.com" target="_blank">Drew Moore</a>'
    )
    welcome_index_page.graphics.create!(
      identifier: 'logo-image',
      image: File.open("#{Rails.root}/lib/assets/import_content/graphics/partybassics-logo.png")
    )

    # welcome#about_us

    welcome_about_us_page.contents.create!(identifier: 'instagram-panel-heading', text: 'Pics')
    welcome_about_us_page.contents.create!(identifier: 'main-info-panel-heading', text: 'Info')
    welcome_about_us_page.contents.create!(
      identifier: 'main-info-panel-text',
      text: 'Partybassics is based in Nashville, TN.'
    )
    welcome_about_us_page.contents.create!(identifier: 'contact-info-panel-heading', text: 'Stay in Touch')
    welcome_about_us_page.contents.create!(identifier: 'contact-info-content-heading', text: 'Contact Us')
    welcome_about_us_page.contents.create!(identifier: 'contact-info-content-main-email', text: 'Email')
    welcome_about_us_page.contents.create!(identifier: 'social-info-content-heading', text: 'Social')

    # events#display_one

    events_display_one_page.contents.create!(identifier: 'event-display-ticket-link', text: 'Get Tickets')
    events_display_one_page.contents.create!(identifier: 'event-display-facebook-link', text: 'Facebook Event')

    # charges#new

    charges_new_page.contents.create!(identifier: 'charges-new-price-label', text: 'Price')
    charges_new_page.contents.create!(identifier: 'charges-new-quantity-label', text: 'Quantity')
    charges_new_page.contents.create!(identifier: 'charges-new-purchase-button', text: 'Buy Tickets')

    # charges#create

    charges_create_page.contents.create!(identifier: 'charges-receipt-page-heading', text: 'Thank You')
    charges_create_page.contents.create!(identifier: 'charges-receipt-link-back', text: 'Back to Home')

    # contacts#update

    contacts_update_page.contents.create!(identifier: 'email-list-subscribe-link', text: 'Join Mailing List')

    # mailers#send_event

    mailers_send_event_page.contents.create!(identifier: 'email-event-display-ticket-link', text: 'New Event from Party Bassics')
    mailers_send_event_page.contents.create!(identifier: 'email-event-display-facebook-link', text: 'Facebook Event')
    email_graphic = mailers_send_event_page.graphics.create!(
      identifier: 'email-logo-image',
      image: File.open("#{Rails.root}/lib/assets/import_content/graphics/partybassics-logo.png")
    )

    # charge_mailer#purchase_confirmation

    charge_mailers_purchase_confirmation_page.contents.create!(
      identifier: 'email-ticket-confirmation-heading',
      text: 'Confirmation for Your Tickets with Party Bassics'
    )
    charge_mailers_purchase_confirmation_page.graphics << email_graphic
  end
end
