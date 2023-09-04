# frozen_string_literal: true

require "spec_helper"

RSpec.describe "Story03" do

  let(:ns) { Story03 }
  let(:klass) { ns::DummyKlass }

  before do
    code = File.read(File.join(__dir__, "03_story.rb"))
    eval(code)
  end

  describe "class with injected DoSomething service object" do
    it "has public #do_something method" do
      expect(klass.public_instance_methods).to include(:do_something)
    end
    it "has included DoSomething::AsDoSomethingMethod module" do
      expect(klass.included_modules).to include(ns::DoSomething::AsPublicMethod__DoSomething)
    end
    describe "#do_something" do
      it "returns :do_something_call" do
        expect(klass.new.send(:do_something)).to eq(:do_something_call)
      end
    end
  end

end