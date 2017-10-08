# frozen_string_literal: true

class AddCacheToSites < ActiveRecord::Migration[4.2]
  def change
    add_column :sites, :cache, :json, :null => false, :default => {}
  end
end
