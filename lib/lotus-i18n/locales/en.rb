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
        if [:you, :he, :she, :e,  :ey, :Tho, :hu, :per, :thon, :jee,
            :ve,  :xe, :ze,  :zhe].include? activity[:person]
          object = Lotus::I18n.pronoun(activity[:person])
        elsif activity[:person]
          object = activity[:person]
        end

        if [:our,  :their, :his,  :her, :em,  :Thor, :your,
            :hum,  :per,   :thon, :jem, :ver, :xem,
            :zir,  :zem,   :hir,  :mer, :zhim].include? activity[:target_owner]
          target = Lotus::I18n.object(activity[:target])
          target_owner = Lotus::I18n.possessive_pronoun(activity[:target_owner])
          target = "#{target_owner} #{target}"
        elsif activity[:target_owner]
          target = Lotus::I18n.object(activity[:target])
          target = "#{activity[:target_owner]}'s #{target}"
        elsif activity[:target]
          target = Lotus::I18n.single_object(activity[:target])
        end

        if [:our,  :their, :his,  :her, :em,  :Thor, :your,
            :hum,  :per,   :thon, :jem, :ver, :xem,
            :zir,  :zem,   :hir,  :mer, :zhim].include? activity[:object_owner]
          object = Lotus::I18n.object(activity[:object])
          object = "#{activity[:object_owner]} #{object}"
        elsif activity[:object_owner]
          object = Lotus::I18n.object(activity[:object])
          object = "#{activity[:object_owner]}'s #{object}"
        elsif !activity[:person]
          object = Lotus::I18n.single_object(activity[:object])
        end

        if target
          "#{actor} #{verb} #{object} to #{target}".strip
        else
          "#{actor} #{verb} #{object}".strip
        end
      end
    end
  end
end
