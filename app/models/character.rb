class Character < ApplicationRecord
  has_one :ability, dependent: :destroy

  belongs_to :user

  accepts_nested_attributes_for :ability

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

  validates :name, presence: true

  validates :level, presence: true

  validates :race, presence: true, inclusion: {
    in: RACE_TYPES,
    message: 'Invalid race type'
  }

  validates :character_class, presence: true, inclusion: {
    in: CHARACTER_CLASS_TYPES,
    message: 'Invalid class type'
  }
end
