class CreateAppointments < ActiveRecord::Migration[6.1]
  def change
    create_table :appointments do |t|
      t.boolean :booked, default: false
      t.date :date
      t.time :start_time
      t.time :end_time
      t.references :user, null: false, foreign_key: true
      t.references :booked_by

      t.timestamps
    end
  end
end
