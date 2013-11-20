require 'minitest/autorun'
require 'turn/autorun'

Turn.config do |c|
  c.natural = true
end

require "mocha/setup"

require 'lotus-i18n'

require 'yaml'

def language_yaml(lang, verb)
  @@files ||= {}
  @@files[lang] ||= {}
  @@files[lang][verb] ||= YAML::load_file("test/#{lang}/#{verb}/object.yml")

  @@files[lang][verb]
end
