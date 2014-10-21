ENV["RAILS_ENV"] ||= 'test'
require File.expand_path("../../config/environment", __FILE__)
Dir[Rails.root.join("spec/support/**/*.rb")].each { |f| require f }
ActiveRecord::Migration.maintain_test_schema!
require 'rspec/expectations'
$LOAD_PATH << "lib"
$LOAD_PATH << "app/models"
require 'environment'
require 'page'
require 'content'
require 'graphic'

Environment.environment = "test"

RSpec.configure do |config|
  config.after(:each) do
    if Environment.database_connection.table_exists? "pages"
      Page.delete_all
    else
      Environment.database_connection.create_table "pages"
    end
    if Environment.database_connection.table_exists? "contents"
      Content.delete_all
    else
      Environment.database_connection.create_table "contents"
    end
    if Environment.database_connection.table_exists? "graphics"
      Graphic.delete_all
    else
      Environment.database_connection.create_table "graphics"
    end
  end
  config.order = "random"
end
