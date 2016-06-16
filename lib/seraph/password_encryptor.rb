require 'bcrypt'
require 'fast_blank'
require 'seraph/extensions/nil_class_blank'

module Seraph
  class PasswordEncryptor
    using Extensions::NilClassBlank

    def self.call(password)
      return false if String(password).blank?
      BCrypt::Password.create(password)
    end
  end
end
