class AddUserIdToSites < ActiveRecord::Migration
  def change
    add_column :sites, :user_id, :integer
    add_index  :sites, :user_id
  end
end
