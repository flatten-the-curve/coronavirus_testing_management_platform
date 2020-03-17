class CreateLineCounts < ActiveRecord::Migration[5.2]
  def change
    create_table :line_counts do |t|
      t.integer :amount
      t.integer :patient_count_id
      t.integer :host_id
      t.timestamps
    end
  end
end
