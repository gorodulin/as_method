# THIS IS A STORY CODE SNIPPET

module Story04

  class DoSomething
    def self.call
      :do_something_call
    end
  end

  module IncludableModule
    extend ServiceObjectInjection::Allow
    include as_service_object DoSomething
    include as_service_object DoSomething, name: :do_something_else, access: :public
  end
end
