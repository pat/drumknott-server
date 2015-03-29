class AddKeyToSites < ActiveRecord::Migration
  def change
    add_column :sites, :key, :string, :null => false
    add_index  :sites, :key, :unique => true
  end
end
