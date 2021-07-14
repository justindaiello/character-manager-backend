class CreateCharacters < ActiveRecord::Migration[6.0]
  def change
    create_table :characters do |t|
      t.string :name
      t.integer :level
      t.string :class
      t.string :race

      t.timestamps
    end
  end
end
