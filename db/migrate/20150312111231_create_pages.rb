# frozen_string_literal: true

class CreatePages < ActiveRecord::Migration[4.2]
  def change
    create_table :pages do |t|
      t.integer :site_id, :null => false
      t.string  :name,    :null => false
      t.string  :path,    :null => false
      t.text    :content
      t.timestamps :null => false
    end

    add_index :pages, :site_id
    add_index :pages, %i[ site_id path ], :unique => true
  end
end
