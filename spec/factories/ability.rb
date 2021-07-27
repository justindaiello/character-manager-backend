FactoryBot.define do
  factory :ability do
    strength { rand(1..18) }
    dexterity { rand(1..18) }
    intelligence { rand(1..18) }
    constitution { rand(1..18) }
    wisdom { rand(1..18) }
    charisma { rand(1..18) }
    character
  end
end
