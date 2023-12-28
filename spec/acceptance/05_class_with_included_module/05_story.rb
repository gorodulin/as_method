# frozen_string_literal: true

# THIS IS A STORY CODE SNIPPET

module Story05

  class DoSomething
    def self.call
      :do_something_call
    end
  end

  module IncludableModule
    extend AsMethod::Allow
    include as_method DoSomething
    include as_method DoSomething, name: :do_something_else, access: :public

  end

  module AggregateInterfaceModule
    include IncludableModule

  end

  module NonIncludableModule
    extend AsMethod::Allow
    extend as_method DoSomething, name: :klassy_do_something, access: :public
    extend as_method DoSomething, name: :klassy_do_something_else, access: :public

  end

end
