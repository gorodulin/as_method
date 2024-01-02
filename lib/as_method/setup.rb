# frozen_string_literal: true

# Usage:
#
# Require this file to add #as_method class method to all classes:
#   require "as_method/setup"
#

require "as_method"

Module.extend(AsMethod::Allow)
Object.extend(AsMethod::Allow)
