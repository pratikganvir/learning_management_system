class CreateBatchCourse < ActiveRecord::Migration[7.0]
  def change
    create_table :batches_courses do |t|
      t.integer :batch_id
      t.integer :course_id
      t.timestamps
    end
  end
end
