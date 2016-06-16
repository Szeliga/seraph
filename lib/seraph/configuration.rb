require 'singleton'

module Seraph
  class Configuration
    include ::Singleton

    attr_accessor :pepper
  end
end
