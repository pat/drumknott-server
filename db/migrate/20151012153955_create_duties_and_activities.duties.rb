# This migration comes from duties (originally 1)
class CreateDutiesAndActivities < ActiveRecord::Migration[4.2]
  def change
    create_table :duties_duty_records do |t|
      t.string  :name,    null: false
      t.text    :data,    default: '{}'
      t.timestamps
    end

    add_index :duties_duty_records, :created_at, order: {created_at: :desc}
    add_index :duties_duty_records, :name

    create_table :duties_activity_records do |t|
      t.string  :name,           null: false
      t.integer :duty_record_id, null: false
      t.integer :position,       null: false
      t.string  :status,         null: false, default: 'pending'
      t.timestamps
    end

    add_index :duties_activity_records, :duty_record_id
    add_index :duties_activity_records, :name
  end
end
