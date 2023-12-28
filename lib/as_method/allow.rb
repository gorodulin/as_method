# frozen_string_literal: true

module AsMethod
  module Allow

    def self.included(_)
      raise "Don't include, extend instead"
    end

    def self.extended(base)
      base.extend(Helpers::ClassMethods)
      base.include(Helpers::InstanceMethods) if base.is_a?(Class)
    end

  end # ... Allow
end # ... AsMethod
