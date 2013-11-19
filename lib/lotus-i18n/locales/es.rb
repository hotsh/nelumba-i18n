module Lotus
  module Locales
    # English translation routines.
    module Es
      # Yield an English sentence for the given hash representing an activity.
      # activity: Hash containing the following fields:
      #   :actor  => The display name of the actor.
      #   :verb   => The verb for the action.
      #   :author => The display name of the author that created the object.
      #   :target => The display name of the recipient of the object.
      #   :object => The type of object of the action.
      #   :person => Used in place of object. The name of the person the action
      #              is done upon.
      def self.sentence(activity)
        actor = activity[:actor]
        verb = Lotus::I18n.verb(activity[:verb], activity)
        if activity[:person]
          object = activity[:person]
        else
          object = Lotus::I18n.single_object(activity[:object])
        end
        target = activity[:target]

        if target
          if target.start_with? "el "
            target = "al #{target[3..-1]}"
          else
            target = "a #{target}"
          end
          "#{actor} #{verb} #{object} #{target}"
        else
          "#{actor} #{verb} #{object}"
        end
      end
    end
  end
end
