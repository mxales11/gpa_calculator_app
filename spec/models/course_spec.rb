require 'spec_helper'

describe Course do 

	before { 

	@course = Course.new({ name: 'Probability', credits: 3})

	}

	subject { @course }

	it { should respond_to(:name) }
	it { should respond_to(:credits) }
	it { should respond_to(:students) }
	it { should respond_to(:taken_courses) }
	
	it { should be_valid }

end