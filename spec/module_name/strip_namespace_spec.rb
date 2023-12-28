# frozen_string_literal: true

require "spec_helper"

RSpec.describe AsMethod::ModuleName::StripNamespace do
  describe ".call" do
    it "returns the module or class name without the namespace" do
      [
        "My::Namespace::ModuleName",
        "::My::Namespace::ModuleName",
        "::ModuleName",
        "ModuleName",
      ].each do |module_or_class_name|
        result = described_class.call(module_or_class_name)
        expect(result).to eq("ModuleName")
      end
    end

    it "returns an empty string if the module or class name is nil or empty" do
      expect(described_class.call(nil)).to eq("")
      expect(described_class.call("")).to eq("")
    end
  end
end
