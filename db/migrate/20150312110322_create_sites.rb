class CreateSites < ActiveRecord::Migration[4.2]
  def change
    create_table :sites do |t|
      t.string :name, :null => false
      t.timestamps    :null => false
    end

    add_index :sites, :name, :unique => true
  end
end
