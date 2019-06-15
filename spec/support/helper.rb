require 'support/helpers/js_helpers'
RSpec.configure do |config|
  config.include Features::JsHelpers, type: :feature
end
