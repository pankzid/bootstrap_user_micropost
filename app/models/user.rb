class User < ActiveRecord::Base

	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
	validates :name, presence: true, 
	          length: {maximum: 50}
	validates :email, presence: true, 
	          format: {with: VALID_EMAIL_REGEX},
	          uniqueness: {case_sensitive: false}
	# validates :password_confirmation, presence: true

	has_secure_password

	before_save { self.email.downcase! }
	before_save :create_remember_token

	def password_validation(state)
			User.validates :password, length: {minimum: 6} if state
	end

	def valid_user?(password)
		self.authenticate(password)
	end

	private
	def create_remember_token
		self.remember_token = SecureRandom.urlsafe_base64 
	end

end
