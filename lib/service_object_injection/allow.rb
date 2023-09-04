# frozen_string_literal: true

module ServiceObjectInjection
  module Allow

    def self.included(base)
      if base.is_a?(Class)
        raise "Do not include, extend!"
      end
    end

    def self.extended(base)
      # base.extend(RegistrationMethods) unless base.singleton_class.included_modules.include?(RegistrationMethods)
      base.extend(Helpers)
    end

    # def self.included(base)
    #   if base.is_a?(Class) && !base.singleton_class.included_modules.include?(RegistrationMethods)
    #     base.extend(RegistrationMethods)
    #   end
    #   # raise "Do not include, extend!"
    # end
    # && !base.singleton_class.included_modules.include?(RegistrationMethods)
    #   base.extend(RegistrationMethods)
    # end

  end # ... Allow
end # ... ServiceObjectInjection
