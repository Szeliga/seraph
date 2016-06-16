require 'fast_secure_compare/fast_secure_compare'

module Seraph
  module Utils
    def compare(a, b)
      FastSecureCompare.compare(a, b)
    end
    module_function :compare
  end
end
