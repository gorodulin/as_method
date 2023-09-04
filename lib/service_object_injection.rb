# frozen_string_literal: true

module ServiceObjectInjection

  module RegistrationMethods
    def injected_dependencies
      (@injected_dependencies || {}).dup.freeze
    end

    # def register_dependency_module(mod)
    #   [
    #     mod.private_instance_methods,
    #     mod.protected_instance_methods,
    #     mod.public_instance_methods,
    #   ].flatten.each do |method_name|
    #     @injected_dependencies[method_name] = value
    #   end
    # end

    # def register_dependency(name, value)
    #   @injected_dependencies[name] = value
    # end
  end

  autoload :Allow,                          "service_object_injection/allow"
  autoload :Helpers,                        "service_object_injection/helpers"
  autoload :FindOrDefineModule,             "service_object_injection/find_or_define_module"
  autoload :ValidateServiceObject,          "service_object_injection/validate_service_object"
  autoload :VERSION,                        "service_object_injection/version"

  module ModuleName
    autoload :GenerateFromSnakeCase,        "service_object_injection/module_name/generate_from_snake_case"
    autoload :StripNamespace,               "service_object_injection/module_name/strip_namespace"
  end

  module MethodName
    autoload :Validate,                     "service_object_injection/method_name/validate"
    autoload :GenerateFromClassName,        "service_object_injection/method_name/generate_from_class_name"
  end

  def self.helpers
    module_template = ->(file_name) { File.read(File.join(__dir__, "service_object_injection", "templates", file_name)) }
    {
      as_service_object: {
        module_template: module_template.call("includable_module.rb.erb"),
        object_validator: ValidateServiceObject,
        method_name_validator: MethodName::Validate,
        method_name_generator: MethodName::GenerateFromClassName,
        default_access: :private,
      }
    }
  end

end # ... ServiceObjectInjection
