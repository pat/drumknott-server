class AddCountryToUsers < ActiveRecord::Migration
  def change
    add_column :users, :country, :string, :default => 'AU'
  end
end
