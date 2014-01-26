class User < ActiveRecord::Base
	attr_accessor :current_password
	attr_reader :admin
	has_many :microposts, dependent: :destroy

	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
	validates :name, presence: true, 
	          length: {maximum: 50}
	validates :email, presence: true, 
	          format: {with: VALID_EMAIL_REGEX},
	          uniqueness: {case_sensitive: false}
	validates :password, length: {minimum: 6}, if: :password || :password_digest.blank?
	# validates :password_confirmation, presence: true

	has_secure_password

	default_scope ->{ where(is_active: true) }

	before_save { self.email.downcase! }
	before_save :create_remember_token

	def check_current_password(password)
		self.authenticate(password) ? true : false
	end

	private
	def create_remember_token
		self.remember_token = SecureRandom.urlsafe_base64 
	end

end
