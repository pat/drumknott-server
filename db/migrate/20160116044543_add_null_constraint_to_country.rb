class AddNullConstraintToCountry < ActiveRecord::Migration
  def change
    change_column :users, :country, :string, :default => 'AU', :null => false
  end
end
