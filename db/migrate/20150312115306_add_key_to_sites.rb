# frozen_string_literal: true

class AddKeyToSites < ActiveRecord::Migration[4.2]
  def change
    add_column :sites, :key, :string, :null => false
    add_index  :sites, :key, :unique => true
  end
end
