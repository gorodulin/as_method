# frozen_string_literal: true

require_relative "lib/as_method/version"

Gem::Specification.new do |spec|
  spec.name         = "as_method"
  spec.version      = AsMethod::VERSION
  spec.authors      = ["Vladimir Gorodulin"]
  spec.email        = ["ru.hostmaster@gmail.com"]
  spec.description  = "Bring Service Objects to your classes as methods."
  spec.summary      = "Call Service Objects with ease. Include them to your classes as methods!"
  spec.homepage     = "https://github.com/gorodulin/as_method"
  spec.license      = "MIT"

  spec.required_ruby_version = Gem::Requirement.new(">= 2.3")

  spec.metadata = {
    "changelog_uri"   => "https://github.com/gorodulin/as_method/blob/main/CHANGELOG.md",
    "homepage_uri"    => spec.homepage,
    "source_code_uri" => "https://github.com/gorodulin/as_method",
  }

  spec.files = Dir["lib/**/*.rb"] + %w[LICENSE README.md CHANGELOG.md]

  spec.require_paths = ["lib"]
end
