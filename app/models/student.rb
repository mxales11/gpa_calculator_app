class Student < ActiveRecord::Base
  attr_accessible :cumulative_gpa, :email, :credits_earned, :password, :password_confirmation, :major_gpa
  has_secure_password
  



  before_save { |student| student.email = email.downcase }

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  validates :email, presence: true,
  					length: { maximum: 30 }, 
  					format: { with: VALID_EMAIL_REGEX },
  					uniqueness: { case_sensitive: false }
  validates :password, presence: true, length: { minimum: 6 }
  validates :password_confirmation, presence: true

  has_many :taken_courses 
  has_many :courses, :through => :taken_courses


end
