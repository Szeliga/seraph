require 'singleton'

module Seraph
  class Configuration
    include ::Singleton

    attr_accessor :pepper

    def reset
      self.pepper = nil
    end
  end
end
