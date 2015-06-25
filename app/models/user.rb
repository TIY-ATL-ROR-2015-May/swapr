class User < ActiveRecord::Base
  EMAIL_REGEX = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i

  validates :password, :access_token, presence: true
  validates :email, uniqueness: true, presence: true
  validates :email, format: { with: EMAIL_REGEX,
                              message: "is not a valid email." }

  has_many :curations, dependent: :destroy
  has_many :contrabands

  before_validation :ensure_access_token

  def ensure_access_token
    if self.access_token.blank?
      self.access_token = User.generate_token
    end
  end

  def regenerate_token!
    self.access_token = nil
    self.save
  end

  def self.generate_token
    token = SecureRandom.hex
    while User.exists?(access_token: token)
      token = SecureRandom.hex
    end
    token
  end
end
