# The main module for all Lotus related functionality.
module Lotus
  # The internationalization and localization module.
  module I18n
    require 'i18n'

    # Translate the given token to the locale's translation.
    def self.translate(*args)
      ::I18n.t(*args)
    end

    # Translates the given verb for the current locale.
    def self.verb(*args)
      token = args.shift
      self.translate("verb.#{token}", *args)
    end

    # Translates the given object as a singular for the current locale.
    def self.single_object(*args)
      token = args.shift
      options = args.last if args.last.is_a? Hash
      self.translate("object.singular_#{token}", *args)
    end

    # Translates the given object as a plural for the current locale.
    def self.plural_object(*args)
      token = args.shift
      options = args.last if args.last.is_a? Hash
      self.translate("object.plural_#{token}", *args)
    end

    # Translates the given object for the current locale.
    def self.object(*args)
      token = args.shift
      self.translate("object.#{token}", *args)
    end

    # Translates the given pronoun for the current locale.
    def self.pronoun(*args)
      token = args.shift
      self.translate("pronoun.#{token}", *args)
    end

    # Translates the given possessive pronoun for the current locale.
    def self.possessive_pronoun(*args)
      token = args.shift
      self.translate("possessive_pronoun.#{token}", *args)
    end

    # Translates the given action for the current locale.
    def self.action(*args)
      token = args.shift
      self.translate("action.#{token}", *args)
    end

    # Translates the given category for the current locale.
    def self.category(*args)
      token = args.shift
      self.translate("category.#{token}", *args)
    end

    # Translates the given field for the current locale.
    def self.field(*args)
      token = args.shift
      self.translate("field.#{token}", *args)
    end

    # Localize the given object for the current locale.
    def self.localize(*args)
      ::I18n.l(*args)
    end

    # Produces a sentence describing the given Lotus::Activity.
    def self.sentence(options = {})
      options ||= {}

      components = {}

      if options[:actor].is_a? Symbol
        components[:actor_pronoun]  = options[:actor]
      else
        components[:actor]  = options[:actor]
      end

      if options[:actors].is_a? Symbol
        components[:actors_pronoun] = options[:actors]
      else
        components[:actors] = options[:actors]
      end

      if options[:object_owner].is_a? Symbol
        components[:object_owner_pronoun] = options[:object_owner]
      else
        components[:object_owner] = options[:object_owner]
      end

      if options[:object_owners].is_a? Symbol
        components[:object_owners_pronoun] = options[:object_owners]
      else
        components[:object_owners] = options[:object_owners]
      end

      if options[:target_owner].is_a? Symbol
        components[:target_owner_pronoun] = options[:target_owner]
      else
        components[:target_owner] = options[:target_owner]
      end

      if options[:target_owners].is_a? Symbol
        components[:target_owners_pronoun] = options[:target_owners]
      else
        components[:target_owners] = options[:target_owners]
      end

      components[:target]  = options[:target]
      components[:targets] = options[:targets]
      components[:object]  = options[:object]
      components[:objects] = options[:objects]
      components[:verb]    = options[:verb]
      components[:action]  = options[:action]
      components[:field]   = options[:field]

      components.keys.each do |key|
        if components[key].nil?
          components.delete key
        end
      end

      grammar = Lotus::Locales.rules(options)
      result = ""

      grammar.each do |hash|
        if components.keys.select{|e| !hash["for"].include?(e.to_s)}.empty? &&
           components.keys.count == hash["for"].count
          if hash["match"] && hash["match"].count > 0
            matches = hash["match"]

            violations = matches.select do |rule|
              if rule[0] && components[rule[0].intern]
                !components[rule[0].intern].match(Regexp.new(rule[1]))
              else
                false
              end
            end

            next unless violations.empty?
          end

          # Do the replacement rules for components
          if hash["replace"] && hash["replace"].count > 0
            replaces = hash["replace"]

            unless hash["replace"][0].is_a? Array
              replaces = [hash["replace"]]
            end

            replaces.each do |rule|
              components[rule[0].intern].gsub!(Regexp.new(rule[1]), rule[2])
            end
          end

          result = hash["do"]
          components.each do |component, value|
            if value.is_a? Symbol
              result = result.gsub /[\.a-zA-Z_]*%#{Regexp.escape(component.to_s)}%[\.a-zA-Z_]*/ do |match|
                self.translate(match.gsub("%#{component.to_s}%", value.to_s).strip, options)
              end
            else
              result = result.gsub("%#{component.to_s}%", value.to_s)
            end
          end
          break
        end
      end

      result
    end
  end
end
