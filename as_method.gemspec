# frozen_string_literal: true

require_relative "lib/service_object_injection/version"

Gem::Specification.new do |spec|
  spec.name         = "service_object_injection"
  spec.version      = ServiceObjectInjection::VERSION
  spec.authors      = ["Vladimir Gorodulin"]
  spec.email        = ["ru.hostmaster@gmail.com"]
  spec.description  = "Make callable Service Objects includable as methods"
  spec.summary      = <<~EOS
    Call Service Objects with ease. Include them to your classes as methods!
  EOS
  spec.homepage      = "https://github.com/gorodulin/service_object_injection"
  spec.license       = "MIT"

  spec.required_ruby_version = Gem::Requirement.new(">= 2.0.0")

  spec.metadata = {
    "changelog_uri"     => "https://github.com/gorodulin/service_object_injection/blob/main/CHANGELOG.md",
    "homepage_uri"      => spec.homepage,
    "source_code_uri"   => "https://github.com/gorodulin/service_object_injection",
  }

  spec.files = Dir["lib/**/*.rb"] + %w{LICENSE README.md CHANGELOG.md}

  spec.require_paths = ["lib"]
  spec.add_development_dependency "rspec", "~> 3.2"
  spec.add_development_dependency "pry", "~> 0.14"
end
