require 'phantomjs'
require 'pry'

RSpec.configure do |config|
  config.after(:each) do
    Phantomjs.configure { |cfg| cfg.phantomjs_path = 'phantomjs' }
  end
end
