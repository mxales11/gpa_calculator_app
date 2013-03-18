class AddMajorGpaToStudent < ActiveRecord::Migration
 
  def change
  	add_column :students, :major_gpa, :decimal
  end

end
