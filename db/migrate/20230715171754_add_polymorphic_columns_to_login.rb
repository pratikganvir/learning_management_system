class AddPolymorphicColumnsToLogin < ActiveRecord::Migration[7.0]
  def change
    add_column :logins, :loginable_id, :bigint
    add_column :logins, :loginable_type, :string
    add_index :logins, [:loginable_id, :loginable_type]
  end
end
