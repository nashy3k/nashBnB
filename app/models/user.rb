class User < ActiveRecord::Base
	include Clearance::User
	attr_accessor :password_confirmation
  before_save :validate_password_confirmation

  validates :name, presence: true
  validates :email, presence: true, uniqueness: true,
    format: {with: /\A[^@\s]+@([^@\s]+\.)+[^@\W]+\z/ }

	private
    def validate_password_confirmation
      unless password_confirmed?
        errors.add :password_confirmation, 'does not match password'
        return false
      end
    end

    def password_confirmed?
      password.present? && password == password_confirmation
    end
end
