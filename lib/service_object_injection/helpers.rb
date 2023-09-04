# frozen_string_literal: true

module ServiceObjectInjection
  module Helpers

    ServiceObjectInjection.helpers.each do |helper_name, options|
      self.define_method(helper_name) do |object, name: nil, access: options[:default_access]|
        # validate access
        raise ArgumentError unless %w[private public protected].include?(access.to_s)

        # validate object
        options[:object_validator].call(object)

        # generate method name from object, if none given
        method_name = name || options[:method_name_generator].call(object.name)

        # validate method name:
        options[:method_name_validator].call(method_name)

        # generate module name:
        module_name = "::#{object.name}::As#{access.capitalize}Method__#{ModuleName::GenerateFromSnakeCase.call(method_name)}"

        # define stubbable module:
        stubbable_module = FindOrDefineModule.call \
          module_template: File.read(File.join(__dir__, "templates", "stubbable_module.rb.erb")),
          module_name: "::#{object.name}::Stubbable",
          vars: { object: object }

        # validate module name (optional)

        # define module, or return existing module:
        includable_module = FindOrDefineModule.call \
          module_template: options[:module_template],
          module_name: module_name,
          vars: {
            object: object,
            method_name: method_name,
            method_access: access,
          }

        # return generated module ready for inclusion:
        self.included_modules.include?(includable_module) ? Kernel : includable_module
      end
    end

  end # ... Helpers
end # ... ServiceObjectInjection
