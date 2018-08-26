class RemovePasswordToAuthor < ActiveRecord::Migration[5.1]
  def change
    remove_column :authors, :password, :string
  end
end
