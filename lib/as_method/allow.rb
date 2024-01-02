# frozen_string_literal: true

module AsMethod
  module Allow

    def self.included(_)
      raise "Don't include, extend instead"
    end

    def self.extended(base)
      if base.is_a?(Class)
        base.extend(Helpers::ClassMethods)
        base.include(Helpers::InstanceMethods)
      else
        base.singleton_class.include(Helpers::ClassMethods)
      end
    end

  end # ... Allow
end # ... AsMethod
