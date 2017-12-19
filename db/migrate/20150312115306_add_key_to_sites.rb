# frozen_string_literal: true

class AddKeyToSites < ActiveRecord::Migration[4.2]
  def change
    # rubocop:disable Rails/NotNullColumn
    add_column :sites, :key, :string, :null => false
    # rubocop:enable Rails/NotNullColumn
    add_index  :sites, :key, :unique => true
  end
end
