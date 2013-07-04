module Lotus
  module Locales
    # English translation routines.
    module En
      # Yield an English sentence for the given hash representing an activity.
      # activity: Hash containing the following fields:
      #   :actor  => The display name of the actor.
      #   :verb   => The verb for the action.
      #   :object => The type of object of the action.
      #   :author => The display name of the author that created the object.
      #   :target => The display name of the recipient of the object.
      def self.sentence(activity)
        actor = activity[:actor]
        verb = Lotus::I18n.verb(activity[:verb])
        object = Lotus::I18n.single_object(activity[:object])
        target = activity[:target]

        "#{actor} #{verb} #{object}"
      end

      # Reflects the given object when used as a singular.
      def self.single_object(object)
        article = "a"
        if ['a', 'e', 'i', 'o', 'u'].include? object[0]
          article = "an"
        end

        "#{article} #{object}"
      end

      # Reflects the given object when used as a plural.
      def self.plural_object(object)
        suffix = 's'
        if ['s'].include? object[-1]
          suffix = 'es'
        end

        "#{object}#{suffix}"
      end
    end
  end
end
