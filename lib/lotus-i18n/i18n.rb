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

    def self.category(*args)
      token = args.shift
      self.translate("category.#{token}", *args)
    end

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
      Lotus::Locales.engine(options).sentence(options)
    end
  end
end
