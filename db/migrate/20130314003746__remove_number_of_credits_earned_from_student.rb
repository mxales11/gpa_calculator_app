class RemoveNumberOfCreditsEarnedFromStudent < ActiveRecord::Migration
	def change
  		remove_column :students, :number_of_credits_earned, :integer
  	end
end
