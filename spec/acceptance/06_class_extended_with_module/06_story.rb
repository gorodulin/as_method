# THIS IS A STORY CODE SNIPPET

module Story06

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

  module NonIncludableModule
    extend ServiceObjectInjection::Allow
    extend as_service_object DoSomething, name: :klassy_do_something, access: :public
    extend as_service_object DoSomething, name: :klassy_do_something_else, access: :public
  end

end
