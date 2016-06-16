require 'spec_helper'
require 'seraph/authenticator'
require 'seraph/password_encryptor'

RSpec.describe Seraph::Authenticator do
  describe '.call' do
    let(:plaintext) { 'foobar12' }
    let(:encrypted) { Seraph::PasswordEncryptor.call(plaintext).to_s }
    subject(:authenticated) { described_class.call(encrypted, provided) }

    context 'when the provided password is the same as the encrypted one' do
      let(:provided) { plaintext }
      it { is_expected.to be_truthy }
    end

    context 'when the provided password is different than the encrypted one' do
      let(:provided) { 'wrongpassword' }
      it { is_expected.to be_falsey }
    end

    context 'when pepper is set' do
      include_context 'pepper set in configuration'

      context 'when the provided password is the same as the encrypted one' do
        let(:provided) { plaintext }
        it { is_expected.to be_truthy }
      end

      context 'when the provided password is different than the encrypted one' do
        let(:provided) { 'wrongpassword' }
        it { is_expected.to be_falsey }
      end
    end
  end
end
