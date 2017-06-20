class AddDeactivatedAtToPages < ActiveRecord::Migration[4.2]
  def change
    add_column :pages, :deactivated_at, :datetime
    add_index  :pages, :deactivated_at
  end
end
