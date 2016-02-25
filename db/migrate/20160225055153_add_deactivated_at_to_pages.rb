class AddDeactivatedAtToPages < ActiveRecord::Migration
  def change
    add_column :pages, :deactivated_at, :datetime
    add_index  :pages, :deactivated_at
  end
end
