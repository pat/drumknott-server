# frozen_string_literal: true

class AddStripeAndStatusColumnsToSites < ActiveRecord::Migration[4.2]
  def change
    change_table(:suppliers, :bulk => true) do |table|
      table.column :stripe_subscription_id, :string
      table.column :status,                 :string,
        :default => "pending",
        :null    => false
      table.column :status_message,         :string
    end
  end
end
