require_relative '../helper.rb'

describe Lotus::Locales::En do
  describe "sentence" do
    describe "for post objects" do
      describe "with just objects" do
        language_yaml(:en, :post)["object"].each do |k,v|
          hash = {:verb   => :post,
                  :object => k.intern}
          it "should translate #{hash} to '#{v}'" do
            Lotus::Locales::En.sentence(hash).must_equal v
          end
        end
      end

      describe "with objects and actors" do
        language_yaml(:en, :post)["actor_object"].each do |k,v|
          hash = {:verb => :post,
                  :actor => "wilkie",
                  :object => k.intern}
          it "should translate #{hash} to '#{v}'" do
            Lotus::Locales::En.sentence(hash).must_equal v
          end
        end
      end

      describe "with objects and object owners and actors" do
        language_yaml(:en, :post)["actor_owner_object"].each do |k,v|
          hash = {:verb => :post,
                  :actor => "wilkie",
                  :object_owner => "carol",
                  :object => k.intern}
          it "should translate #{hash} to '#{v}'" do
            Lotus::Locales::En.sentence(hash).must_equal v
          end
        end
      end

      describe "with objects and object owner pronouns and actors" do
        language_yaml(:en, :post)["actor_owner_pronoun_object"].each do |pronoun, hash_1|
          pronoun = pronoun.intern
          hash_1.each do |k, v|
            hash = {:verb => :post,
                    :actor => "wilkie",
                    :object_owner => pronoun,
                    :object => k.intern}
            it "should translate #{hash} to '#{v}'" do
              Lotus::Locales::En.sentence(hash).must_equal v
            end
          end
        end
      end

      describe "with objects and actors with pronouns" do
        language_yaml(:en, :post)["actor_pronoun_object"].each do |pronoun, hash_1|
          pronoun = pronoun.intern
          hash_1.each do |k, v|
            hash = {:verb   => :post,
                    :actor  => pronoun,
                    :object => k.intern}
            it "should translate #{hash} to '#{v}'" do
              Lotus::Locales::En.sentence(hash).must_equal v
            end
          end
        end
      end

      describe "with objects and targets" do
        language_yaml(:en, :post)["object_target"].each do |target, hash_1|
          target = target.intern
          hash_1.each do |k, v|
            hash = {:verb   => :post,
                    :target => target,
                    :object => k.intern}
            it "should translate #{hash} to '#{v}'" do
              Lotus::Locales::En.sentence(hash).must_equal v
            end
          end
        end
      end

      describe "actors with objects and targets" do
        language_yaml(:en, :post)["actor_object_target"].each do |target, hash_1|
          target = target.intern
          hash_1.each do |k, v|
          hash = {:verb   => :post,
                  :actor  => "wilkie",
                  :target => target,
                  :object => k.intern}
            it "should translate #{hash} to '#{v}'" do
              Lotus::Locales::En.sentence(hash).must_equal v
            end
          end
        end
      end

      describe "with objects and target owner pronouns" do
        language_yaml(:en, :post)["object_target_owner_pronoun"].each do |target, hash_1|
          target = target.intern
          hash_1.each do |pronoun, hash_2|
            pronoun = pronoun.intern
            hash_2.each do |k, v|
            hash = {:verb   => :post,
                    :target => target,
                    :target_owner => pronoun,
                    :object => k.intern}
              it "should translate #{hash} to '#{v}'" do
                Lotus::Locales::En.sentence(hash).must_equal v
              end
            end
          end
        end
      end

      describe "actors with objects and target owner pronouns" do
        language_yaml(:en, :post)["actor_object_target_owner_pronoun"].each do |target, hash_1|
          target = target.intern
          hash_1.each do |pronoun, hash_2|
            pronoun = pronoun.intern
            hash_2.each do |k, v|
              hash = {:verb   => :post,
                      :actor  => "wilkie",
                      :target => target,
                      :target_owner => pronoun,
                      :object => k.intern}
              it "should translate #{hash} to '#{v}'" do
                Lotus::Locales::En.sentence(hash).must_equal v
              end
            end
          end
        end
      end
    end
  end
end
