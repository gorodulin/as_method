# frozen_string_literal: true

# Usage:
#
# Require this file to add #as_method class method to all classes:
#   require 'as_method/setup'
#

unless Object.singleton_class.included_modules.include?(AsMethod)
  Object.extend AsMethod
end

# unless Module.included_modules.include?(AsMethod)
#   Module.include AsMethod
# end
