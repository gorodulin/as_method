# frozen_string_literal: true

require "erb"

module AsMethod
  class GenerateModule
    def self.call(**args)
      new(**args).call
    end

    def initialize(object:, method_name: nil, method_access: :private)
      @_object = object
      @_method_name = method_name
      @_method_access = method_access
    end

    def call
      instance_eval(generate_module_source_code) unless module_exists?

      includable_module
    end

    private

    def includable_module
      Object.const_get(module_name)
    end

    def generate_module_source_code
      payload = {
        object: object,
        module_name: module_name,
        method_name: method_name,
        method_access: method_access,
      }
      ::ERB.new(config.module_template).result_with_hash(payload)
    end

    def object
      @object ||= validate_object!(select_object(@_object))
    end

    def select_object(object)
      config.object_selector.call(object)
    end

    def validate_object!(object)
      config.object_validator.call(object)
    end

    def generate_method_name(object_name)
      config.method_name_generator.call(object_name)
    end

    def validate_method_name!(method_name)
      config.method_name_validator.call(method_name)
    end

    def method_access
      @method_access ||= @_method_access.to_s.tap do |access|
        raise ArgumentError unless %w[private public protected].include?(access)
      end
    end

    def method_name
      @method_name ||= validate_method_name!(@_method_name&.to_s || generate_method_name(object.name))
    end

    def module_name
      @module_name ||= "::#{object.name}::As#{method_access.capitalize}Method__#{ModuleName::GenerateFromSnakeCase.call(method_name)}" # rubocop:disable Layout/LineLength
    end

    def module_exists?
      Object.const_defined?(module_name)
    end

    def config
      AsMethod.config
    end
  end # ... GenerateModule
end # ... AsMethod
