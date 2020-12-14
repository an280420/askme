require 'openssl'

class User < ApplicationRecord
  # параметры работы модуля шифрования
  ITERATIONS = 20000
  DIGEST = OpenSSL::Digest::SHA256.new
  FORMAT_EMAIL = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
  FORMAT_USERNAME = /\A\w+\z/

  attr_accessor :password

  has_many :questions

  validates :email, :username, presence: true
  validates :email, :username, uniqueness: true
  validates :email, format: { with: FORMAT_EMAIL }
  validates :username, length: { maximum: 40 }
  validates :username, format: { with: FORMAT_USERNAME }
  validates :password, presence: true, on: :create
  validates :password, confirmation: true

  before_validation :downcase_username, :downcase_email
  before_save :encrypt_password

  def self.hash_to_string(password_hash)
    password_hash.unpack('H*')[0]
  end

  def self.authenticate(email, password)
    # Сперва находим кандидата по email
    user = find_by(email: email)

    # Если пользователь не найден, возвращает nil
    return nil unless user.present?

    # Формируем хэш пароля из того, что передали в метод
    hashed_password = User.hash_to_string(
      OpenSSL::PKCS5.pbkdf2_hmac(
        password, user.password_salt, ITERATIONS, DIGEST.length, DIGEST
      )
    )

    return user if user.password_hash == hashed_password

    nil
  end

  def downcase_username
    if username.present?
      username.downcase!
    end
  end

  def downcase_email
    if email.present?
      email.downcase!
    end
  end

  private

  def encrypt_password
    if password.present?
      self.password_salt = User.hash_to_string(OpenSSL::Random.random_bytes(16))

      self.password_hash = User.hash_to_string(
        OpenSSL::PKCS5.pbkdf2_hmac(
          password, password_salt, ITERATIONS, DIGEST.length, DIGEST
        )
      )
    end
  end
end
