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

      # rubocop:disable Metrics/AbcSize
      def as_method(object, name: nil, access: :private)
        raise ArgumentError unless %w[private public protected].include?(access.to_s)

        ValidateServiceObject.call(object)

        # generate method name from object, if none given
        method_name = name&.to_s || MethodName::GenerateFromClassName.call(object.name)

        MethodName::Validate.call(method_name)

        module_name = "::#{object.name}::As#{access.capitalize}Method__#{ModuleName::GenerateFromSnakeCase.call(method_name)}" # rubocop:disable Layout/LineLength

        # define module, or return existing module:
        includable_module = FindOrDefineModule.call \
          module_template: File.read(File.join(__dir__, "templates", "includable_module.rb.erb")),
          module_name: module_name,
          vars: {
            object: object,
            method_name: method_name,
            method_access: access,
          }

        # return generated module ready for inclusion:
        included_modules.include?(includable_module) ? Kernel : includable_module
      end
      # rubocop:enable Metrics/AbcSize

    end # ... ClassMethods
  end # ... Helpers
end # ... AsMethod
