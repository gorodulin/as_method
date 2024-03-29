# frozen_string_literal: true

module AsMethod
  module MethodName
    module Validate

      REGULAR_NAME_REGEX = /\A[a-z_]+[a-z0-9_]*[?!=]{0,1}\z/.freeze

      SPECIAL_NAMES = %w{[] ! ~ + ** - * / % << >> & | ^ < <= >= > == === != =~ !~ <=>}.freeze

      def self.call(name)
        return true if name.to_s =~ REGULAR_NAME_REGEX
        return true if SPECIAL_NAMES.include?(name.to_s)

        fail ArgumentError, "invalid method name #{name.inspect}"
      end

    end # ... Validate
  end # ... MethodName
end # ... AsMethod
