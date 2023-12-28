# frozen_string_literal: true

module AsMethod
  module MethodName
    module GenerateFromClassName

      def self.call(module_name)
        ModuleName::StripNamespace.call(module_name)
          .gsub(/([A-Z]+)([A-Z][a-z])/, %q(\1_\2))
          .gsub(/([a-z\d])([A-Z])/, %q(\1_\2))
          .downcase
      end

    end # ... GenerateFromClassName
  end # ... MethodName
end # ... AsMethod
