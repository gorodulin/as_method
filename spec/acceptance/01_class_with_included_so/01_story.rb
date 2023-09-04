# THIS IS A STORY CODE SNIPPET

module Story01

  class DoSomething
    def self.call
      :do_something_call
    end
  end

  class DummyKlass
    extend ServiceObjectInjection::Allow
    include as_service_object DoSomething
    include as_service_object DoSomething, name: :do_something_else, access: :public
  end

end
