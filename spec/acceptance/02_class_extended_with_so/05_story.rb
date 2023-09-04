# THIS IS A STORY CODE SNIPPET

module Story05

  class DoSomething
    def self.call
      :do_something_call
    end
  end

  class DummyKlass
    extend ServiceObjectInjection::Allow
    extend as_service_object DoSomething, name: :do_something, access: :public
    extend as_service_object DoSomething, name: :do_something_else
  end

end
