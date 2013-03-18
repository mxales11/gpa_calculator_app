class AddCumulativeGpaToStudent < ActiveRecord::Migration
   def change
  	add_column :students, :cumulative_gpa, :decimal
  end
end
