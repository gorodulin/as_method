# frozen_string_literal: true

module AsMethod
  module MethodName
    module ValidateMethodName

      REGULAR_NAME_REGEX = /\A[a-z_]+[a-z0-9_]*[?!=]{0,1}\z/

      SPECIAL_NAMES = %w{[] ! ~ + ** - * / % << >> & | ^ < <= >= > == === != =~ !~ <=>}

      def self.call(name)
        return true if name.to_s =~ REGULAR_NAME_REGEX
        return true if SPECIAL_NAMES.include?(name.to_s)
  
        false
      end

    end # ... ValidateMethodName
  end # ... MethodName
end # ... AsMethod