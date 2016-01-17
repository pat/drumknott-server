class AddCacheToSites < ActiveRecord::Migration
  def change
    add_column :sites, :cache, :json, :null => false, :default => {}
  end
end
