class CreateAdmins < ActiveRecord::Migration[7.0]
  def change
    create_table :admins do |t|
      t.string :first_name
      t.string :last_name
      t.integer :admin_type

      t.timestamps
    end
  end
end
