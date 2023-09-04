# THIS IS A STORY CODE SNIPPET

module Story02

  class DoSomething
    def self.call
      :do_something_call
    end
  end

  class DummyKlass
    extend ServiceObjectInjection::Allow

    # we expect this to define a private method #do_something
    include as_service_object DoSomething

    # we expect this to override the private
    # method #do_something defined above and make it public
    def do_something
      "#{super} overrided"
    end

  end

end
