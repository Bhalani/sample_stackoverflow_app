ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)

require 'rails/test_help'
require 'capybara/rspec'
require 'rspec/rails'
require 'shoulda/matchers'

Dir[Rails.root.join('spec/support/**/*.rb')].each { |f| require f }

ActiveRecord::Migration.maintain_test_schema!

Capybara.register_driver :selenium do |app|
  chrome_options = Selenium::WebDriver::Chrome::Options.new
  chrome_options.add_preference(:download,
    prompt_for_download: false,
    directory_upgrade: true,
    default_directory: "./"
  )
  Capybara::Selenium::Driver.new(app, browser: :chrome, options: chrome_options)
end

Capybara.register_driver :headless_chromium do |app|
  chrome_options = Selenium::WebDriver::Chrome::Options.new
  ['headless', 'use-fake-ui-for-media-stream', 'use-fake-device-for-media-stream', 'no-sandbox', 'disable-gpu', 'disable-infobars', 'disable-extensions', 'window-size=1920x1080'].each do |option|
    chrome_options.add_argument("--#{option}")
  end

  Capybara::Selenium::Driver.new(
    app,
    browser: :chrome,
    options: chrome_options
  ).tap do |driver|
    bridge = driver.browser.send(:bridge)
    bridge.http.call(:post, "/session/#{bridge.session_id}/chromium/send_command",
      cmd: 'Page.setDownloadBehavior',
      params: {
        behavior: 'allow',
        downloadPath: "./"
      }
    )
  end
end

Capybara.javascript_driver = :selenium_chrome_headless

RSpec.configure do |config|

  # Remove this line if you're not using ActiveRecord or ActiveRecord fixtures
  config.fixture_path = "#{::Rails.root}/spec/fixtures"
  config.include Rails.application.routes.url_helpers
  # If you're not using ActiveRecord, or you'd prefer not to run each of your
  # examples within a transaction, remove the following line or assign false
  # instead of true.
  config.use_transactional_fixtures = false

  config.include Warden::Test::Helpers
  Warden.test_mode!

  config.after(:each) do
    Warden.test_reset!
  end

  config.infer_spec_type_from_file_location!

  config.include(Shoulda::Matchers::ActiveModel, type: :model)
  config.include(Shoulda::Matchers::ActiveRecord, type: :model)
end
