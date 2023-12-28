# frozen_string_literal: true

# THIS IS A STORY CODE SNIPPET

module Story12

  class ServiceObjectBase
    def self.call
      :do_something_call
    end
  end

  class DoSomething < ServiceObjectBase
  end

  class DummyKlass
    extend AsMethod::Allow
    include as_method ServiceObjectBase, name: :do_something, access: :public
    include as_method DoSomething, name: :do_something_else, access: :public
  end

end
