class User < ApplicationRecord
  has_secure_password

  enum role: { employee: 0, admin: 1 } # default will be 0
  validates :name, :email, :role, presence: true
  validates :email, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP } # can also use custom regex
  validates :password, presence: true, length: { minimum: 6 }, if: :new_record? # only for create, incase user don't want to update password
end
