class CreatePatientCounts < ActiveRecord::Migration[5.2]
  def change
    create_table :patient_counts do |t|
      t.integer :amount
      t.integer :host_id
      t.timestamps
    end
  end
end
