# frozen_string_literal: true

module AsMethod
  class FindOrDefineIncludableModule

    def self.call(service_object, method_name)
      new.call(service_object, method_name)
    end

    def call(service_object, method_name)
      # Note: order matters:
      self.service_object = service_object
      self.method_name = method_name
      self.includable_module_name = generate_includable_module_name(service_object, method_name)

      define_includable_module unless Object.const_defined?(includable_module_name)

      Object.const_get(includable_module_name)
    end

    private

    attr_accessor :includable_module_name
    attr_reader :method_name
    attr_reader :service_object

    def define_includable_module
      DefineIncludableModule.call(includable_module_name, service_object, method_name)
    end

    def generate_method_name_from_so_name
      MethodName::GenerateFromModuleName.call(service_object.name)
    end

    def generate_includable_module_name(service_object, method_name)
      ModuleName::GenerateForIncludableModule.call(service_object, method_name)
    end

    def method_name=(name)
      validate_method_name!(name.to_s) if name

      @method_name = name&.to_s || generate_method_name_from_so_name
    end

    def service_object=(module_or_class)
      unless module_or_class.respond_to?(:call)
        fail NoMethodError, "Expected #{module_or_class} to respond to #call method"
      end
      unless module_or_class.is_a?(Module)
        fail TypeError, "#{module_or_class} must be a Class or a Module"
      end
      @service_object = module_or_class
    end

    def validate_method_name!(name)
      return if MethodName::ValidateMethodName.call(name)

      fail NameError, "wrong method name #{name.inspect}"
    end

  end # ... FindOrDefineIncludableModule
end # ... AsMethod
