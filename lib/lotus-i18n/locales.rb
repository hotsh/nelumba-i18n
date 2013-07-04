module Lotus
  # Modules that will generate sentences dependent on the locale.
  module Locales
    def self.engine(options = {})
      options ||= {}

      locale = options[:locale] || ::I18n.locale
      locale = locale.to_s.capitalize

      default = ::I18n.default_locale.to_s.capitalize

      # Use the system default locale and then English as fallback
      locale = default if !Lotus::Locales.const_defined? locale
      locale = "En" if !Lotus::Locales.const_defined? locale

      Lotus::Locales.const_get(locale)
    end
  end
end
