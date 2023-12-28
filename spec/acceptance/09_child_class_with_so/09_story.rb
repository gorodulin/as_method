# frozen_string_literal: true

# THIS IS A STORY CODE SNIPPET

module Story09

  class DoSomething
    def self.call
      :do_something_call
    end
  end

  class KlassBase
    extend AsMethod::Allow
    include as_method DoSomething, access: :private
    extend as_method DoSomething, name: :do_something_else, access: :public
  end

  class DummyKlass < KlassBase
  end

end
