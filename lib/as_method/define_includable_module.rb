# frozen_string_literal: true

module AsMethod
  module DefineIncludableModule

    PASS = if RUBY_VERSION < "2.7"
      "*args, &block"
    else
      "..."
    end

    def self.call(includable_module_name, service_object_class, method_name)
      puts "-- DefineIncludableModule #{includable_module_name}"
      code = <<~RUBY
        module #{includable_module_name}

          def self.ruby2_keywords(*)
            puts "-- ruby2_keywords"
          end if RUBY_VERSION < "2.7"

          ruby2_keywords def #{method_name}(*args, &block)
            self.class.registered_service_objects[:"#{method_name}"].call(*args, &block)
          end

          def self.included(base)
            if base.instance_of?(Module)
              fail TypeError, "Can't be included into Module \#{base.inspect}"
            end
            unless base.included_modules.include?(RegistrationMethods)
              #puts "-- included #{includable_module_name} into \#{base}"
              base.include RegistrationMethods
            end
            base.register_service_object(:"#{method_name}", ::#{service_object_class})
          end
          
          def self.extended(_base)
            raise "Do not extend, include!"
          end
        end
      RUBY
      instance_eval code
    end

  end # ... DefineIncludableModule
end # ... AsMethod
