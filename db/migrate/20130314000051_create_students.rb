class CreateStudents < ActiveRecord::Migration
  def change
    create_table :students do |t|
      t.string :email
      t.string :password_digest
      t.integer :number_of_credits_earned
      t.decimal :current_gpa

      t.timestamps
    end
  end
end
