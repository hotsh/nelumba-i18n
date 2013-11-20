# The main module for all Lotus related functionality.
module Lotus
end

require 'lotus-i18n/i18n'
require 'lotus-i18n/locales'

# Add lotus locales to the I18n load path
I18n.load_path += Dir[File.expand_path("../lotus-i18n/locales/**/lexicon.{yml}", __FILE__)]

Dir[File.join(File.dirname(__FILE__), "lotus-i18n", "locales", "*.rb")].each {|file| require file }
