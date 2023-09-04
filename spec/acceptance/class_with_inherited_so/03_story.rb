# THIS IS A STORY CODE SNIPPET

module Story03

  class DoSomething
    def self.call
      :do_something_call
    end
  end

  class KlassBase
    extend ServiceObjectInjection::Allow
    include as_service_object DoSomething, access: :public
  end

  class DummyKlass < KlassBase
    # we expect this to have #do_something method
  end

end
