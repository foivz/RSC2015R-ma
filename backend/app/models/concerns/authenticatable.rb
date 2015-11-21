module Authenticatable
  extend ActiveSupport::Concern

  included do
    PASSWORD_LENGTH = 4

    has_secure_password

    validates_uniqueness_of :username
    validates :password, presence: true, length: { is: PASSWORD_LENGTH }
    validates_uniqueness_of :access_token, if: :access_token

    before_save :downcase_username
    before_create :generate_access_token

    def update_access_token
      self.generate_access_token
      return self.access_token if self.save
      nil
    end

  protected
    def generate_access_token
      begin
        self.access_token = SecureRandom.uuid
      end while self.class.exists?(access_token: access_token)
    end

    def downcase_username
      self.username = username.downcase
    end
  end

  module ClassMethods
    def authenticate(username, password)
      user = self::find_by_username(username)

      return user if user.present? && user.authenticate(password)
      nil
    end
  end
end
