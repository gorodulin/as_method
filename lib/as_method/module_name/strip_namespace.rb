# frozen_string_literal: true

module AsMethod
  module ModuleName
    module StripNamespace

      def self.call(module_or_class)
        module_or_class.to_s.match(/[^:]+\z/)&.to_s
      end

    end # ... StripNamespace
  end # ... ModuleName
end # ... AsMethod
