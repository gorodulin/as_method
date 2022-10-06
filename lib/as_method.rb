# frozen_string_literal: true

module AsMethod
  autoload :DefineIncludableModule,         "as_method/define_includable_module"
  autoload :FindOrDefineIncludableModule,   "as_method/find_or_define_includable_module"
  autoload :RegistrationMethods,            "as_method/registration_methods"
  autoload :VERSION,                        "as_method/version"

  module ModuleName
    autoload :GenerateForIncludableModule,  "as_method/module_name/generate_for_includable_module"
    autoload :GenerateFromUnderscored,      "as_method/module_name/generate_from_underscored"
    autoload :StripNamespace,               "as_method/module_name/strip_namespace"
  end

  module MethodName
    autoload :ValidateMethodName,           "as_method/method_name/validate_method_name"
    autoload :GenerateFromModuleName,       "as_method/method_name/generate_from_module_name"
  end

  def as_method(service_object, name: nil)
    includable_module = FindOrDefineIncludableModule.call(service_object, name)
    unless self.included_modules.include?(includable_module)
      includable_module
    else
      Kernel # a bit faster
    end
    
  end
end # ... AsMethod
