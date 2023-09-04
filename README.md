# Service Object Injection

# Closure experiment

module MyModule
  s = "some name"
  define_method(:abc) { puts s }
  define_method(:abc=) do |val|
    s = val
  end
end

class C1
  include MyModule
end

class C2
  include MyModule
end

c1 = C1.new
c2 = C2.new

c1.abc
c2.abc
c1.abc = "new name"
c2.abc



Dependency injection at its best.

Usage example:

```ruby
class CreateUser
  include as_service_object ValidateUser, name: :validate!
  include as_service_object Generators::GeneratePassword
  include as_service_object SaveModel, name: :save
  # include method_alias SaveModel, name: :save

  def call(name, email)
    @name = name
    @email = email
    user = User.new(attributes)
    validate!(user)
    save(user)
  end

  private

  def attributes
    {
      name: @name,
      email: @email,
      password: generate_password(length: 30),
    }
  end
end
```

## Why?

This approach allows you to:
- keep bringing reusable methods in the old-fashioned way via `include`, just like our ancestors did;
- make methods extracted to SOs look and feel just like regular methods;
- have all used Service Objects (SOs) listed as explicit dependencies;

## Compatibility

Tested on Ruby v2.4 .. v3.1, but it is expected to work on all 2.x versions.

## Installation

Add to your `Gemfile`

```ruby
gem "service_object_injection"
```

To make `service_object` class method available in all classes, add this line to your application loader:

```ruby
require "service_object_injection/setup"
```

## Inject instance-specific service objects

Use `with_service_objects` class method to create instances with specific service objects injected.

This can be useful for testing your classes.

```ruby
dependencies = {
  generate_password: GenerateWeakPassword,
  save: FakeSaveModel,
}
CreateUser.with_service_objects(dependencies).new("Bob", "bob@myhost.local")
```

## Other approaches

If you do need dependency injection during object construction, try [dry-auto_inject](https://dry-rb.org/gems/dry-auto_inject) but keep in mind that it comes with tradeoffs: dependencies are implicit and must be stored in a separate "container", object constructor is [being altered](https://dry-rb.org/gems/dry-auto_inject/0.6/how-does-it-work/).