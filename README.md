# Includable Service Objects

Usage example:

```ruby
class CreateUser
  include as_method ValidateUserAttributes, name: :validate!
  include as_method Generators::GeneratePassword
  include as_method SaveModel, name: :save

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
gem "as_method"
```

To make `as_method` class method available in all classes, add this line to your application loader:

```ruby
require "as_method/setup"
```
