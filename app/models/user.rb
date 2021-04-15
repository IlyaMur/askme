require 'openssl'

class User < ApplicationRecord
  ITERATIONS = 20000
  DIGEST = OpenSSL::Digest::SHA256.new
  VALID_USERNAME = /\A\w+\z/
  VALID_COLOR = /\A#(\h{3}|\h{6})\z/i

  attr_accessor :password

  has_many :questions, dependent: :destroy

  scope :ordered_by_id, -> { order(:id) }

  before_validation :downcase_attributes
  before_save :encrypt_password

  validates :email, :username, presence: true
  validates :email, :username, uniqueness: true

  validates :username, length: { maximum: 40 }, format: { with: VALID_USERNAME }
  validates :email, email: { mode: :strict, require_fqdn: true }

  validates :password, confirmation: true
  validates :password, presence: true, on: :create

  validates :header_color, format: { with: VALID_COLOR }
  validates :avatar_url, format: { with: URI::DEFAULT_PARSER.make_regexp, allow_blank: true }

  def self.authenticate(email, password)
    user = find_by(email: email&.downcase)

    return unless user.present?

    hashed_password = User.hash_to_string(
      OpenSSL::PKCS5.pbkdf2_hmac(
        password, user.password_salt, ITERATIONS, DIGEST.length, DIGEST
      )
    )
    user if user.password_hash == hashed_password
  end

  def self.hash_to_string(password_hash)
    password_hash.unpack('H*')[0]
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

  def downcase_attributes
    username&.downcase!
    email&.downcase!
  end
end

