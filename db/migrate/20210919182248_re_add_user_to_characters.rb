class ReAddUserToCharacters < ActiveRecord::Migration[6.0]
  def change
    add_reference :characters, :user, foreign_key: true, type: :uuid
  end
end
