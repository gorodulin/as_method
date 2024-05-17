# frozen_string_literal: true

module AsMethod
  module Helpers

    module InstanceMethods
      def service_object_for(method_name)
        self.class.service_object_for(method_name)
      end
    end

    module ClassMethods
      def service_object_for(method_name)
        GetServiceObject.call(self, method_name)
      end

      def as_method(object, name: nil, access: :private)
        includable_module = GenerateModule.call(object: object, method_name: name, method_access: access)
        included_modules.include?(includable_module) ? Kernel : includable_module
      end
    end # ... ClassMethods
  end # ... Helpers
end # ... AsMethod
