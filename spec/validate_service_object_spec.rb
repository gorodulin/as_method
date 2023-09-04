# frozen_string_literal: true

require "spec_helper"

RSpec.describe ServiceObjectInjection::ValidateServiceObject do
  subject { described_class.call(service_object) }
  let(:non_callable_class) { Class.new }
  let(:non_callable_module) { Module.new }
  let(:callable_class) { Class.new { def self.call; end } }
  let(:callable_module) { Module.new { def self.call; end } }

  context "when not a Class or a Module" do
    context "when a callable object" do
      let(:service_object) { Proc.new { true } }
      it "raises error" do
        expect { subject }.to raise_error TypeError, /must be a Class or a Module/
      end
    end

    context "when a non-callable object" do
      let(:service_object) { Array.new }
      it "raises error" do
        expect { subject }.to raise_error TypeError, /must be a Class or a Module/
      end
    end
  end

  context "when callable class" do
    let(:service_object) { callable_class }
    it "raises no error" do
      expect { subject }.not_to raise_error
    end
  end

  context "when non-callable class" do
    let(:service_object) { non_callable_class }
    it "raises error" do
      expect { subject }.to raise_error NoMethodError, /Expected .* to respond to #call method/
    end
  end

  context "when callable module" do
    let(:service_object) { callable_module }
    it "raises no error" do
      expect { subject }.not_to raise_error
    end
  end

  context "when non-callable module" do
    let(:service_object) { non_callable_module }
    it "raises error" do
      expect { subject }.to raise_error NoMethodError, /Expected .* to respond to #call method/
    end
  end
end
