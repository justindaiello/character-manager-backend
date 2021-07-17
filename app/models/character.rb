class Character < ApplicationRecord
  CHARACTER_CLASS_TYPES = %w[
    fighter
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
