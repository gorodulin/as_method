# frozen_string_literal: true

module AsMethod
  module MethodName
    module Validate

      REGULAR_NAME_REGEX = /\A[a-z_]+[a-z0-9_]*[?!=]{0,1}\z/.freeze

      SPECIAL_NAMES = %w{[] ! ~ + ** - * / % << >> & | ^ < <= >= > == === != =~ !~ <=>}.freeze

      def self.call(name)
        fail ArgumentError unless name.is_a?(String)

        return name if name =~ REGULAR_NAME_REGEX
        return name if SPECIAL_NAMES.include?(name)

        fail ArgumentError, "invalid method name #{name.inspect}"
      end

    end # ... Validate
  end # ... MethodName
end # ... AsMethod
