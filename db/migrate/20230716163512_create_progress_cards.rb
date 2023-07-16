class CreateProgressCards < ActiveRecord::Migration[7.0]
  def change
    create_table :progress_cards do |t|
      t.string :exam_name
      t.integer :declaration
      t.integer :student_id
      t.integer :batch_id

      t.timestamps
    end
  end
end
