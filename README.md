# Service Object Injection

Static dependency injection at its best.

Usage example:

```ruby
class CreateUser
  include as_method ValidateUserEntity, name: :validate!
  include as_method Generators::GeneratePassword # -> generate_password()
  include as_method SaveEntity, name: :save

  def call(name, email)
    @name = name
    @email = email
    user = User.new(attributes)
    validate!(user)
    save(user)
  end

  def self.call(...) = new.call(...)

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
- keep bringing reusable methods in the old-fashioned way via `include` or `extend`, just like our ancestors did;
- make Service Objects (SOs) look and feel just like regular methods;
- have all used SOs listed as explicit dependencies in-place;

## Compatibility

Tested on Ruby v2.4 .. v3.x, but it is expected to work on all 2.x versions.

## Installation

Add to your `Gemfile`

```ruby
gem "as_method"
```

To make `as_method` class method available in _all classes and modules_, add this line to your application loader:

```ruby
require "as_method/setup"
```

or enable it in place:

```ruby
class MyClass
  extend AsMethod::Allow
  ...
end
```

## Alternatives

If you require dependency injection _during object construction_, you might consider using [dry-auto_inject](https://dry-rb.org/gems/dry-auto_inject). However, be aware of the following points:

- Dependencies are implicit and must be managed in a separate 'container'.
- Object constructors get modified, as explained in detail [here](https://dry-rb.org/gems/dry-auto_inject/0.6/how-does-it-work/)."
