class AddHostIdToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :host_id, :integer
  end
end
