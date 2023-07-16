class CreateEnrollments < ActiveRecord::Migration[7.0]
  def change
    create_table :enrollments do |t|
      t.integer :student_id
      t.integer :batch_id
      t.integer :status

      t.timestamps
    end
  end
end
