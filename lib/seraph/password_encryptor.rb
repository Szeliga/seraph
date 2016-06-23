require 'bcrypt'

module Seraph
  class PasswordEncryptor
    private_class_method :new

    def self.call(password)
      new(password).call
    end

    def call
      return false if String(password) == ''
      peppered_password = String(pepper) == '' ? password : "#{password}:#{pepper}"
      BCrypt::Password.create(peppered_password)
    end

    def initialize(password)
      @password = password
    end

    private

    attr_reader :password

    def pepper
      String(Seraph.configuration.pepper)
    end
  end
end
