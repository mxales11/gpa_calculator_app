class CreateStudents < ActiveRecord::Migration
  def change
    create_table :students do |t|
      t.string :name
      t.string :email
      t.string :password_digest
      t.integer :credits_earned
      t.decimal :major_gpa
      t.decimal :cumulative_gpa
      t.string :remember_token
      t.integer :major_credits_earned

      t.timestamps
    end
  end
end
