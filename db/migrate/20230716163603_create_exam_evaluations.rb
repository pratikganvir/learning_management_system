class CreateExamEvaluations < ActiveRecord::Migration[7.0]
  def change
    create_table :exam_evaluations do |t|
      t.integer :course_id
      t.float :marks
      t.integer :progress_card_id

      t.timestamps
    end
  end
end
