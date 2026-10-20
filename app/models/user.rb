class User < ApplicationRecord
  has_secure_password

  validates :username, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: {case_sensitive: false}, format: { with: URI::MailTo::EMAIL_REGEXP }

  private

  def normalize_email
    self.email = email.strip.downcase if email.present?
  end
end
