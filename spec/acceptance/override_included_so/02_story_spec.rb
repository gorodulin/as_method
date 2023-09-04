# frozen_string_literal: true

require "spec_helper"

RSpec.describe "Story02" do

  let(:ns) { Story02 }
  let(:klass) { ns::DummyKlass }

  before do
    code = File.read(File.join(__dir__, "02_story.rb"))
    eval(code)
  end

  describe "instance of a class with injected DoSomething service object" do
    it "has public #do_something method" do
      expect(klass.public_instance_methods).to include(:do_something)
    end
    it "has included DoSomething::AsDoSomethingMethod module" do
      expect(klass.included_modules).to include(ns::DoSomething::AsPrivateMethod__DoSomething)
    end
    describe "#do_something" do
      it "returns :do_something_call" do
        expect(klass.new.public_send(:do_something)).to eq("do_something_call overrided")
      end
    end
  end

end