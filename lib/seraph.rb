require 'seraph/version'
require 'seraph/password_encryptor'
require 'seraph/configuration'

module Seraph
  def configure
    yield configuration
  end
  module_function :configure

  def configuration
    Configuration.instance
  end
  module_function :configuration
end
