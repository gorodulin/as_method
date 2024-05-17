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

## YouTube video about the Gem

Click on the image below:

<div align="left">
      <a href="https://www.youtube.com/watch?v=eX7DLJJUEI8">
         <img src="https://img.youtube.com/vi/eX7DLJJUEI8/0.jpg" style="width:100%;">
      </a>
</div>

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

If you require dependency injection _during object construction_, you might consider using [dry-auto_inject](https://dry-rb.org/gems/dry-auto_inject).

However, be aware of the following points:

- Dependencies are somewhat implicit as they are defined in a separate file.
- Object constructors get modified, as explained in detail [here](https://dry-rb.org/gems/dry-auto_inject/0.6/how-does-it-work/)."
- Resulting methods don't invoke 'call' on objects, they return callables instead.

## Benchmark results:

1000 iterations of a Test Service Object call. It does nothing but calls two other service objects, they call two other service objects each, and so on. (Depth 11 levels, 2049 unique classes, 4095 calls).

```
                  user       system      total      real       memory
pure Ruby         3.689327   0.047354   3.736681 ( 3.744128)   27440
as_method         6.219795   0.038531   6.258326 ( 6.298066)   37652
dry-auto_inject  22.121456   0.119032  22.240488 (22.467116)   55408
```

Ruby version: 3.1.2p20 (2022-04-12 revision 4491bb740a) [x86_64-darwin22]

## TODO:

- extra spec for circular dependencies (SO1 includes SO2, SO2 includes SO1, directly and via modules)
- extra spec for Base Service Object class that includes another SO
- spec for AsMethod::Allow (extending a base class and a module)
