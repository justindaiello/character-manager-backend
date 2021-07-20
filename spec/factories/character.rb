CHARACTER_CLASS_TYPES = %w[
  barbarian
  bard
  cleric
  druid
  fighter
  monk
  paladin
  ranger
  rogue
  sorcerer
  warlock
  wizard
].freeze

RACE_TYPES = %w[
  dragonborn
  dwarf
  elf
  gnome
  half_elf
  halfling
  half_orc
  human
  tiefling
].freeze

FactoryBot.define do
  factory :character do
    name  { Faker::Name.unique.name }
    level { Faker::Number.number(digits: 2) }
    race { RACE_TYPES.sample }
    character_class { CHARACTER_CLASS_TYPES.sample }
  end
end
