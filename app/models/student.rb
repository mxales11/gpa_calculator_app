class Student < ActiveRecord::Base
  attr_accessible :major_credits_earned, :name, :cumulative_gpa, :email, :credits_earned, :password, :password_confirmation, :major_gpa
  has_secure_password
  
  before_save { |student| student.email = email.downcase }
  before_save :create_remember_token

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  validates :email, presence: true,
  					length: { maximum: 30 }, 
  					format: { with: VALID_EMAIL_REGEX },
  					uniqueness: { case_sensitive: false }
  validates :password, presence: true, length: { minimum: 6 }
  validates :password_confirmation, presence: true

  has_many :taken_courses 


  private

  def create_remember_token
    if self.remember_token.nil?
      self.remember_token = SecureRandom.urlsafe_base64
    end
  end
end
