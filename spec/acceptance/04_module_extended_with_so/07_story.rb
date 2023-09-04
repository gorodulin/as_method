# THIS IS A STORY CODE SNIPPET

module Story07

  class DoSomething
    def self.call
      :do_something_call
    end
  end

  module InterfaceModule
    extend ServiceObjectInjection::Allow
    extend as_service_object DoSomething, name: :do_something, access: :public
    extend as_service_object DoSomething, name: :do_something_else, access: :private
  end

end