# frozen_string_literal: true

module AsMethod
  module RegistrationMethods

    module ClassMethods
      def registered_service_objects
        @registered_service_objects ||= {}
      end
      
      def register_service_objects(hash)
        hash.each { |name, so| register_service_object(name, so) }
      end

      def register_service_object(name, so)
        registered_service_objects[name.to_sym]&.tap do |registered_so|
          return if so == registered_so
          raise "#{so} clashes with #{registered_so} in #{self}" if so != registered_so
        end
        
        # puts "--- register #{self.name}##{name} => #{so}#call"
        registered_service_objects[name.to_sym] = so
      end
    end # ... ClassMethods

    def self.included(base)
      return if base.singleton_class.included_modules.include?(ClassMethods)

      puts "-- #{base.name} extend with RegistrationMethods::ClassMethods"
      base.extend ClassMethods
    end

  end # ... RegistrationMethods
end # ... AsMethod
