class User < ActiveRecord::Base
  has_secure_password
  validates :username, presence: true
  VALID_PASSWORD_REGEX = /\A(?=.*[a-zA-Z])(?=.*[0-9]).{8,}\z/
  validates :password, presence: true, length: { minimum: 8 },
                                       format: {with: VALID_PASSWORD_REGEX }
end
