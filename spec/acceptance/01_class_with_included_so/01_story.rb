# frozen_string_literal: true

# THIS IS A STORY CODE SNIPPET

module Story01

  class DoSomething
    def self.call
      :do_something_call
    end
  end

  class DummyKlass
    extend AsMethod::Allow
    include as_method DoSomething
    include as_method DoSomething, name: :do_something_else, access: :public
  end

end
