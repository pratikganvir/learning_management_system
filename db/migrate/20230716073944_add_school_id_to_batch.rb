class AddSchoolIdToBatch < ActiveRecord::Migration[7.0]
  def change
    add_column :batches, :school_id, :integer
  end
end
