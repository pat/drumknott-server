class AddCacheToUsers < ActiveRecord::Migration[4.2]
  def change
    add_column :users, :cache, :json, :null => false, :default => {}
  end
end
