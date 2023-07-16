class CreateSchools < ActiveRecord::Migration[7.0]
  def change
    create_table :schools do |t|
      t.string :name
      t.text :address
      t.string :contact_number
      t.string :email
      t.integer :admin_id

      t.timestamps
    end
  end
end
