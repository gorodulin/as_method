# frozen_string_literal: true

# rubocop:disable
module AsMethod

  Configuration = Struct.new(
    :object_selector,
    :object_validator,
    :method_name_generator,
    :method_name_validator,
    :module_template
  )

  DEFAULT_CONFIGURATION = Configuration.new.tap do |config|
    config.object_selector = ->(object) { object }
    config.object_validator = ValidateServiceObject
    config.method_name_generator = MethodName::GenerateFromClassName
    config.method_name_validator = MethodName::Validate
    config.module_template = <<~RUBY
      module <%= module_name %>

        def self.object
          ::<%= object %>
        end

        def self.ruby2_keywords(*); end if RUBY_VERSION < "2.7"

        ruby2_keywords def <%= method_name %>(*args, &block)
          ::<%= object %>.call(*args, &block)
        end

        <%= method_access %> :<%= method_name %>

      end
    RUBY
  end.freeze

end
# rubocop:enable
