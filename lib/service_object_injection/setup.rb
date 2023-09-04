# frozen_string_literal: true

# Usage:
#
# Require this file to add #service_object class method to all classes:
#   require "service_object_injection/setup"
#

class Module
  include ServiceObjectInjection::Allow
end
