require 'openssl'

class User < ApplicationRecord
  # параметры работы модуля шифрования паролей
  ITERATIONS = 20000
  DIGEST = OpenSSL::Digest::SHA256.new

  has_many :questions

  validates :email, :username, presence: true
  validates :email, :username, uniqueness: true
  validates :email, format: {with: /\A[\w.%+-]+@[\w.-]+\.[A-Za-z]+\z/}
  validates :username, length: {maximum: 40}, format: {with: /\A\w+\z/}
  validates_format_of :user_color, :with => /\A#([A-Fa-f0-9]{6})\z/

  attr_accessor :password

  validates_presence_of :password, on: create
  validates_confirmation_of :password

  before_validation :downcase_username

  before_save :encrypt_password

  def encrypt_password
    # Если пароль у данного объекта, который вычисляем присутствует, то
    if self.password.present?
      # создаем т.н. "соль" - рандомная строка
      self.password_salt = User.hash_to_string(OpenSSL::Random.random_bytes(16))

      # создаем хэш пароля - длинная уникальная строка, из которой невозможно восстановить исходный пароль
      self.password_hash = User.hash_to_string(
        OpenSSL::PKCS5.pbkdf2_hmac(self.password, self.password_salt, ITERATIONS, DIGEST.length, DIGEST)
      )
    end
  end

  # служебный метод, преобразующий бинарную строку в 16-ричный формат, для удобства хранения
  def self.hash_to_string(password_hash)
    password_hash.unpack('H*')[0]
  end

  def self.authenticate(email, password)
    # находим пользователя по email
    user = find_by(email: email)

    # сравнивается password_hash, а оригинальный пароль так никогда и не сохраняется нигде
    if user.present? && user.password_hash == User.hash_to_string(OpenSSL::PKCS5.pbkdf2_hmac(password, user.password_salt, ITERATIONS, DIGEST.length, DIGEST))

      user
    else
      nil
    end
  end

  def downcase_username
    self.username.downcase! unless username.blank?
  end
end
