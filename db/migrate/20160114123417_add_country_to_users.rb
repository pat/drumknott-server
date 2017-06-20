class AddCountryToUsers < ActiveRecord::Migration[4.2]
  def change
    add_column :users, :country, :string, :default => 'AU'
  end
end
