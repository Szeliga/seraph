require 'spec_helper'
require 'seraph/password_encryptor'

RSpec.describe Seraph::PasswordEncryptor do
  describe '.call' do
    let(:password) { 'foobar12' }
    subject { described_class.call(password) }

    it 'encrypts the password using BCrypt' do
      encrypted = subject
      expect(encrypted.to_s).to eq BCrypt::Engine.hash_secret(password, encrypted.salt)
    end
  end
end
