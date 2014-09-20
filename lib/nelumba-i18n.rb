# The main module for all Nelumba related functionality.
module Nelumba
end

require 'nelumba-i18n/i18n'
require 'nelumba-i18n/locales'

# Add nelumba locales to the I18n load path
I18n.load_path += Dir[File.expand_path("../nelumba-i18n/locales/**/lexicon.{yml}", __FILE__)]

Dir[File.join(File.dirname(__FILE__), "nelumba-i18n", "locales", "*.rb")].each {|file| require file }
