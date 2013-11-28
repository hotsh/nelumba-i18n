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
      filename = self.grammar_path(options)

      @@grammar ||= {}
      @@grammar[filename] ||= YAML.load_file(filename)[self.locale(options)]
      @@grammar[filename]
    end

    # Returns the default locale for the system.
    def self.default_locale
      default = ::I18n.default_locale.to_s
    end

    # Returns the locale passed through options if that locale exists, otherwise
    # it returns the default locale.
    def self.locale(options = {})
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

      locale
    end

    # Returns the path to the grammar descriptions for the given locale or the
    # default locale if none is given or the given locale cannot be found.
    def self.grammar_path(options = {})
      File.join(File.dirname(__FILE__), 'locales', self.locale(options), 'grammar.yml')
    end

    # Returns the full list of rules for the given locale.
    def self.rules(options = {})
      locale  = self.locale(options)

      @@rules ||= {}
      return @@rules[locale] if @@rules[locale]

      grammar = self.grammar(options)

      rules = []
      grammar["rules"].each do |rule|
        if rule["match"] && rule["match"].count > 0 &&
                            !rule["match"][0].is_a?(Array)
          rule["match"] = [rule["match"]]
        end

        if rule["do"].match /\$([^\$]+)\$/
          patterns = rule["do"].split('$')
          patterns << "" if patterns.length.even?
          number_of_subrules = (patterns.length - 1)/2
          subrules = patterns.select.each_with_index { |_,i| i.odd? }

          subrules.map! do |subrule|
            grammar["subrules"][subrule]
          end

          subrules = subrules[0].product(*subrules[1..-1])

          subrules.each do |set|
            new_rule = {}
            new_rule["for"] = set.map{|subrule|(subrule["for"] || []).dup}.concat(rule["for"]||[]).flatten.uniq

            new_rule["match"] = set.map do |subrule|
              if subrule["match"] && subrule["match"].count > 0 &&
                                     !subrule["match"][0].is_a?(Array)
                subrule["match"] = [subrule["match"]]
              end
              (subrule["match"] || [[]]).dup
            end.inject(&:concat).concat(rule["match"]||[[]]).uniq.select{|e|!e.empty?}

            new_rule["do"] = ""
            patterns.each_with_index do |pattern, i|
              if i.even?
                new_rule["do"] << pattern
              else
                new_rule["do"] << set[(i-1)/2]["do"]
              end
            end
            rules << new_rule
          end
        else
          rule["for"] ||= []
          rule["match"] ||= [[]]
          rules << rule
        end
      end

      @@rules[locale] = rules
    end
  end
end
