# frozen_string_literal: true

# THIS IS A STORY CODE SNIPPET

module Story08

  class DoSomething
    def self.call
      :do_something_call
    end
  end

  module ServiceObjectCollection1
    extend AsMethod::Allow
    include as_method DoSomething, name: :do_something, access: :public
    include as_method DoSomething, name: :do_something_else, access: :private

  end

  module ServiceObjectCollection2
    extend AsMethod::Allow
    extend as_method DoSomething, name: :klassy_do_something, access: :public
    extend as_method DoSomething, name: :klassy_do_something_else, access: :private

  end

  module InterfaceModule
    extend ServiceObjectCollection1
    extend ServiceObjectCollection2

  end

  module AggregateInterfaceModule
    extend InterfaceModule

  end

end
