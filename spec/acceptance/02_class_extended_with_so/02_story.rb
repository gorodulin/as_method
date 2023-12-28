# frozen_string_literal: true

# THIS IS A STORY CODE SNIPPET

module Story02

  class DoSomething
    def self.call
      :do_something_call
    end
  end

  class DummyKlass
    extend AsMethod::Allow
    extend as_method DoSomething, name: :do_something, access: :public
    extend as_method DoSomething, name: :do_something_else
  end

end
