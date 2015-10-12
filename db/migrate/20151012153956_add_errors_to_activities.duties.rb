# This migration comes from duties (originally 2)
class AddErrorsToActivities < ActiveRecord::Migration
  def change
    add_column :duties_activity_records, :failures, :text, default: '[]'
  end
end
