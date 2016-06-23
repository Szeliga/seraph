require 'bcrypt'
require 'seraph/utils'

module Seraph
  class PasswordComparator
    private_class_method :new

    def self.call(encrypted, plaintext)
      new(encrypted, plaintext).call
    end

    def call
      bcrypt = BCrypt::Password.new(encrypted)
      peppered_password = String(pepper) == '' ? plaintext : "#{plaintext}:#{pepper}"
      password = BCrypt::Engine.hash_secret(peppered_password, bcrypt.salt)
      Utils.compare(encrypted, password)
    end

    def initialize(encrypted, plaintext)
      @encrypted = encrypted
      @plaintext = plaintext
    end

    private

    attr_reader :encrypted, :plaintext

    def pepper
      String(Seraph.configuration.pepper)
    end
  end
end
