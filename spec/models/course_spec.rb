require 'spec_helper'

describe Course do 

	
	before do 
		@course = Course.create(name: 'Probability', credits: 3)
	end
	

	subject { @course }

	it { should respond_to(:name) }
	it { should respond_to(:credits) }
	it { should respond_to(:students) }
	it { should respond_to(:taken_courses) }
	it { should be_valid }

end