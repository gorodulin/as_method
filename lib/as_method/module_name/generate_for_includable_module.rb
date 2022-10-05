# frozen_string_literal: true

module AsMethod
  module ModuleName
    module GenerateForIncludableModule

      def self.call(module_or_class, method_name = nil)
        part = GenerateFromUnderscored.call(method_name) || StripNamespace.call(module_or_class)

        "::#{module_or_class}::As#{part}Method"
      end

    end # ... GenerateForIncludableModule
  end # ... ModuleName
end # ... AsMethod
