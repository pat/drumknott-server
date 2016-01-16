class AddCacheToUsers < ActiveRecord::Migration
  def change
    add_column :users, :cache, :json, :null => false, :default => {}
  end
end
