class RemoveReferenceFromCharacter < ActiveRecord::Migration[6.0]
  def change
    remove_reference :characters, :user, foreign_key: true
  end
end
