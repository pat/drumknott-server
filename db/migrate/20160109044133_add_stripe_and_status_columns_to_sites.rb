# frozen_string_literal: true

class AddStripeAndStatusColumnsToSites < ActiveRecord::Migration[4.2]
  def change
    add_column :sites, :stripe_subscription_id, :string
    add_column :sites, :status,                 :string,
      :default => "pending",
      :null    => false
    add_column :sites, :status_message,         :string
  end
end
