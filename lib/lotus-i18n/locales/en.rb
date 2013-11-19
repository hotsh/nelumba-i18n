module Lotus
  module Locales
    # English translation routines.
    module En
      # Yield an English sentence for the given hash representing an activity.
      # activity: Hash containing the following fields:
      #   :actor        => The display name of the actor.
      #   :verb         => The verb for the action.
      #   :author       => The display name of the author that created the object.
      #   :target       => The display name of the recipient of the object.
      #   :object       => The type of object of the action.
      #   :person       => Used in place of object. The name of the person the action
      #                    is done upon.
      #   :object_owner => The person that possesses the object.
      #   :target_owner => The person that possesses the target.
      def self.sentence(activity)
        actor = activity[:actor]
        verb = Lotus::I18n.verb(activity[:verb])
        if [:you].include? activity[:person]
          object = activity[:person]
        elsif activity[:person]
          object = activity[:person]
        end
        target = activity[:target]

        if [:our,  :their, :his,  :her, :em,  :Thor,
            :hum,  :per,   :thon, :jem, :ver, :xem,
            :zir,  :zem,   :hir,  :mer, :zhim].include? activity[:object_owner]
          object = Lotus::I18n.single_object(activity[:object])
          object = "#{activity[:object_owner]} #{object}"
        elsif activity[:object_owner]
          object = Lotus::I18n.object(activity[:object])
          object = "#{activity[:object_owner]}'s #{object}"
        elsif !activity[:person]
          object = Lotus::I18n.single_object(activity[:object])
        end

        if target
          "#{actor} #{verb} #{object} to #{target}"
        else
          "#{actor} #{verb} #{object}"
        end
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
