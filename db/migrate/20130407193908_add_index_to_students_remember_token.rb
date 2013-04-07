class AddIndexToStudentsRememberToken < ActiveRecord::Migration
  def change
  	add_index :students, :remember_token
  end
end
