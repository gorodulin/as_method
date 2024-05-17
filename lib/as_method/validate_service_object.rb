# frozen_string_literal: true

module AsMethod
  module ValidateServiceObject

    def self.call(module_or_class)
      unless module_or_class.is_a?(Module)
        fail TypeError, "#{module_or_class} must be a Class or a Module"
      end

      return module_or_class if module_or_class.respond_to?(:call)

      fail NoMethodError, "Expected #{module_or_class} to respond to #call method"
    end

  end # ... ValidateServiceObject
end # ... AsMethod
