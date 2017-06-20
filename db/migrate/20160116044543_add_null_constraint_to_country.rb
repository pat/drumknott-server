class AddNullConstraintToCountry < ActiveRecord::Migration[4.2]
  def change
    change_column :users, :country, :string, :default => 'AU', :null => false
  end
end
