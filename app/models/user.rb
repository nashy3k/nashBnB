class User < ActiveRecord::Base
	include Clearance::User
	attr_accessor :password_confirmation, :login_social
  before_save :validate_password_and_auth_existence

  validates :name, presence: true
  validates :email, presence: true, uniqueness: true,
    format: {with: /\A[^@\s]+@([^@\s]+\.)+[^@\W]+\z/ }
  # validates :password, presence: true, allow_blank: false, :if => !login_social?   
  # validate :validate_password_confirmation on: :create, :if => !login_social? 


  has_many :authentications, :dependent => :destroy
  has_many :listings
  has_many :reservations

  def login_social?
    if login_social == 1
      return true
    else false
    end
  end 
  
  def self.create_with_auth_and_hash(authentication,auth_hash,login_social)
    create! do |u|
      u.first_name = auth_hash["info"]["first_name"]
      u.last_name = auth_hash["info"]["last_name"]
      u.name = auth_hash["info"]["name"]
      u.email = auth_hash["info"]["email"]
      u.login_social = login_social
      u.authentications<<(authentication)
    end

  end
  
  def fb_token
    x = self.authentications.where(:provider => :facebook).first
    return x.token unless x.nil?
  end

  def validate_password_and_auth_existence
    unless password_confirmed? || login_social == 1
      errors.add :password_confirmation, 'password problem'
      return false      
    end
  end

  def validate_password_confirmation
      unless password_confirmed?
        errors.add :password_confirmation, 'does not match password'
        return false
      end
  end

	private

    def password_optional?
      true
    end

    def password_confirmed?
      
      if password.present? && !password.empty? 
       password == password_confirmation
      else 
        return false
      end
    end
end
