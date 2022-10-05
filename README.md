# Includable Service Objects

Usage example:

```ruby
class CreateUser
  include as_method ValidateUserName, name: :validate_name!
  include as_method ValidateEmail, name: :validate_email!
  include as_method Generators::GeneratePassword
  include as_method SaveModel

  def call(name, email)
    validate_name!(name)
    validate_email!(email)
    user = User.new(attributes)
    save_model(user)
  end

  private

  attr_accessor :name, :email

  def attributes
    {
      name: name,
      password: generate_password(length: 30),
    }
  end
end
```

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
