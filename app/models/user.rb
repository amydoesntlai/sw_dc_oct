class User < ActiveRecord::Base
  has_many :event_volunteers
  has_many :events, :through => :event_volunteers
  has_and_belongs_to_many :organizations
  attr_accessible :email, :fname, :lname, :location, :password
  has_secure_password
  before_save { self.email = email.downcase }
  before_create :create_remember_token
  validates_uniqueness_of :email

  def name
    "#{fname} #{lname}"
  end

  def User.new_remember_token
    SecureRandom.urlsafe_base64
  end

  def User.digest(token)
    Digest::SHA1.hexdigest(token.to_s)
  end

  private

    def create_remember_token
      self.remember_token = User.digest(User.new_remember_token)
    end
end
