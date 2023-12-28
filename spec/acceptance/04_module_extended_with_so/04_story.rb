# frozen_string_literal: true

# THIS IS A STORY CODE SNIPPET

module Story04

  class DoSomething
    def self.call
      :do_something_call
    end
  end

  module InterfaceModule
    extend AsMethod::Allow
    extend as_method DoSomething, name: :do_something, access: :public
    extend as_method DoSomething, name: :do_something_else, access: :private

  end

end
