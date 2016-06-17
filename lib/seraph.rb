require 'seraph/version'
require 'seraph/configuration'
require 'seraph/password_encryptor'
require 'seraph/password_comparator'

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
