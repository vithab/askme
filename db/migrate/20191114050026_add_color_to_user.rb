class AddColorToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :user_color, :string
  end
end
