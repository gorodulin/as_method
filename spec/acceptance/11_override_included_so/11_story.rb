# frozen_string_literal: true

# THIS IS A STORY CODE SNIPPET

module Story11

  class DoSomething
    def self.call
      :do_something_call
    end
  end

  class DoSomethingElse
    def self.call
      :do_something_else_call
    end
  end

  class BaseKlass
    extend AsMethod::Allow
    include as_method DoSomething, name: :do_something, access: :public
    extend  as_method DoSomethingElse, name: :do_something, access: :public
  end

  class DummyKlass < BaseKlass
    # override do_something with DoSomethingElse service object and make it private
    include as_method DoSomethingElse, name: :do_something, access: :private
    # override do_something class method with DoSomething service object and make it private
    extend as_method DoSomething, name: :do_something, access: :private
    # add do_something_new* methods reusing DoSomething service object
    include as_method DoSomething, name: :do_something_new_1, access: :private
    include as_method DoSomething, name: :do_something_new_2, access: :private

    # override private #do_something_new_1 defined above and make it public
    def do_something_new_1
      "#{super} overrided"
    end
  end

end
