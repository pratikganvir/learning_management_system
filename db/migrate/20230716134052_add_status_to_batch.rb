class AddStatusToBatch < ActiveRecord::Migration[7.0]
  def change
    add_column :batches, :status, :integer
  end
end
