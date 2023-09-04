# THIS IS A STORY CODE SNIPPET

module Story10

  class DoSomething
    def self.call
      :do_something_call
    end
  end

  module ServiceObjectCollection1
    extend ServiceObjectInjection::Allow
    include as_service_object DoSomething, name: :do_something, access: :public
    include as_service_object DoSomething, name: :do_something_else, access: :private
  end

  module ServiceObjectCollection2
    extend ServiceObjectInjection::Allow
    extend as_service_object DoSomething, name: :klassy_do_something, access: :public
    extend as_service_object DoSomething, name: :klassy_do_something_else, access: :private
  end

  module InterfaceModule
    include ServiceObjectCollection1
    include ServiceObjectCollection2
  end

  module AggregateInterfaceModule
    include InterfaceModule
  end

end
