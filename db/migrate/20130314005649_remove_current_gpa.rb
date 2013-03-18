class RemoveCurrentGpa < ActiveRecord::Migration
  def change
  	remove_column :students, :current_gpa, :decimal
  end
end
