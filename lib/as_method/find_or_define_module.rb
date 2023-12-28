# frozen_string_literal: true

require "erb"

module AsMethod
  class FindOrDefineModule
    def self.call(**args)
      new.call(**args)
    end

    def call(module_template:, module_name:, vars:)
      @vars = vars
      @module_name = module_name
      @module_template = module_template

      instance_eval(generate_module_source_code) unless module_exists?

      includable_module
    end

    private

    def generate_module_source_code
      payload = @vars.merge(module_name: @module_name)
      ::ERB.new(@module_template).result_with_hash(payload)
    end

    def includable_module
      Object.const_get(@module_name)
    end

    def module_exists?
      Object.const_defined?(@module_name)
    end
  end # ... FindOrDefineModule
end # ... AsMethod
