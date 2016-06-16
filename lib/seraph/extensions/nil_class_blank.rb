module Seraph
  module Extensions
    module NilClassBlank
      refine NilClass do
        def blank?
          true
        end
      end
    end
  end
end
