# frozen_string_literal: true

module AsMethod
  autoload :Allow,                          "as_method/allow"
  autoload :Helpers,                        "as_method/helpers"
  autoload :FindOrDefineModule,             "as_method/find_or_define_module"
  autoload :ValidateServiceObject,          "as_method/validate_service_object"
  autoload :GetServiceObject,               "as_method/get_service_object"
  autoload :VERSION,                        "as_method/version"

  module ModuleName
    autoload :GenerateFromSnakeCase,        "as_method/module_name/generate_from_snake_case"
    autoload :StripNamespace,               "as_method/module_name/strip_namespace"
  end

  module MethodName
    autoload :Validate,                     "as_method/method_name/validate"
    autoload :GenerateFromClassName,        "as_method/method_name/generate_from_class_name"
  end

end # ... AsMethod
