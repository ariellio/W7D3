# == Schema Information
#
# Table name: users
#
#  id              :bigint           not null, primary key
#  username        :string           not null
#  password_digest :string           not null
#  session_token   :string           not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
class User < ApplicationRecord

    validates :username, :password_digest, :session_token, presence: true
    validates :password, length: {minimum: 6}, allow_nil: true
    validates :username, :session_token, uniqueness: true
    
    after_initialize :ensure_session_token
    attr_reader :password

    def self.generate_session_token
        SecureRandom.urlsafe_base64
    end

    def self.find_by_credentials(username, password)
        user = User.find_by(username: username)

        if user && user.is_password?(password)
            return user
        else
            nil
        end
    end

    def password=(password)
        @password = password
        self.password_digest = BCrypt::Password.create(password)
    end

    #Create is just a function to make a BCrypt Hash
    #New makes an instance of that class

    def is_password?(password)
        pass = BCrypt::Password.new(self.password_digest)
        pass.is_password?(password)
    end

    def ensure_session_token
        self.session_token ||= self.class.generate_session_token
    end

    def reset_session_token!
        self.session_token = self.class.generate_session_token
        self.save!
        self.session_token
    end

end


