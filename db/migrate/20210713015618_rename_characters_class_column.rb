class RenameCharactersClassColumn < ActiveRecord::Migration[6.0]
  def change
    rename_column :characters, :class, :character_class
  end
end
