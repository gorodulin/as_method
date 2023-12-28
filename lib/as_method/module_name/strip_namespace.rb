# frozen_string_literal: true

module AsMethod
  module ModuleName
    module StripNamespace

      def self.call(module_or_class_name)
        name = String(module_or_class_name)
        index = name.rindex("::")
        index ? name[(index + 2)..-1] : name
      end

    end # ... StripNamespace
  end # ... ModuleName
end # ... AsMethod
