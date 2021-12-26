# frozen_string_literal: true

class AddNullConstraintToCountry < ActiveRecord::Migration[4.2]
  def up
    change_column :users, :country, :string, :default => "AU", :null => false
  end

  def down
    change_column :users, :country, :string, :default => "AU", :null => true
  end
end
