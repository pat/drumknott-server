# This migration comes from duties (originally 2)
class AddErrorsToActivities < ActiveRecord::Migration[4.2]
  def change
    add_column :duties_activity_records, :failures, :text, default: '[]'
  end
end
