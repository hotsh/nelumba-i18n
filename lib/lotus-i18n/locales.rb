module Lotus
  # Modules that will generate sentences dependent on the locale.
  module Locales
    # Returns the metadata used to build grammatical structures for the given
    #   locale.
    #
    # options:
    #   :locale => The locale to use. Defaults to :en (English).
    #
    # Returns: an array of grammar rules. Each rule is a hash described below:
    # "for"   => gives an array of strings for components that must be available
    #            in order to generate this sentence.
    # "do"    => gives the string that serves as the grammatical structure.
    # "match" => an array of patterns to match against component values. if
    #            the component does not match, then this rule is not used.
    #            For instance, a rule that looks for an 's' at the end of
    #            a word so as to decide between a rule that add "'s" or "'"
    #            to the end of a word to make it possessive. You would have
    #            a rule that matches that component against "s$". The patterns
    #            are regular expression strings.
    def self.grammar(options = {})
      options ||= {}

      locale = options[:locale].to_s || ::I18n.locale.to_s

      default = ::I18n.default_locale.to_s

      # Use the system default locale and then English as fallback
      filename = File.join(File.dirname(__FILE__), 'locales', locale, 'grammar.yml')
      unless File.exist? filename
        locale = default
        filename = File.join(File.dirname(__FILE__), 'locales', locale, 'grammar.yml')
        unless File.exist? filename
          locale = "en"
        end
      end

      filename = File.join(File.dirname(__FILE__), 'locales', locale, 'grammar.yml')
      @@grammar ||= {}
      @@grammar[filename] ||= YAML.load_file(filename)[locale]
      @@grammar[filename]
    end
  end
end
