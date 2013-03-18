class AddCreditsEarnedToStudent < ActiveRecord::Migration
  def change
  	add_column :students, :credits_earned, :integer
  end 
end
