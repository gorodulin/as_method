# frozen_string_literal: true

module AsMethod
  module MethodName
    module GenerateFromModuleName

      def self.call(module_name)
        ModuleName::StripNamespace.call(module_name)
          .gsub(/([A-Z]+)([A-Z][a-z])/, '\1_\2')
          .gsub(/([a-z\d])([A-Z])/, '\1_\2')
          .downcase
      end

    end # ... GenerateFromModuleName
  end # ... MethodName
end # ... AsMethod
