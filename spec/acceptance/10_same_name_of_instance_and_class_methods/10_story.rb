# frozen_string_literal: true

# THIS IS A STORY CODE SNIPPET

module Story10

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

  class DummyKlass
    extend AsMethod::Allow
    include as_method DoSomething, name: :do_something, access: :public
    extend as_method DoSomethingElse, name: :do_something, access: :public
  end

end
