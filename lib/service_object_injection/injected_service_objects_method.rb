# frozen_string_literal: true

module ServiceObjectInjection
  module InjectedServiceObjectsMethod
    def injected_service_objects
      (self.included_modules + self.singleton_class.included_modules).map do |mod|
        method_name = mod.instance_variable_get(:@injectable_method)
        [method_name, mod] if method_name
      end.compact
    end
  end