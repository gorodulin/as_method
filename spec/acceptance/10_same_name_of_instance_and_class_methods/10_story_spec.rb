# frozen_string_literal: true

require "spec_helper"

RSpec.describe "Story10" do

  let(:ns) { Story10 }
  let(:klass) { ns::DummyKlass }

  before do
    code = File.read(File.join(__dir__, "10_story.rb"))
    eval(code)
  end

  describe "Class with both class and instance methods of a same name" do
    describe "#do_something" do
      it "is public" do
        expect(klass.public_instance_methods).to include(:do_something)
        expect(klass.private_instance_methods).not_to include(:do_something)
      end

      it "originates from autogenerated SO module" do
        owner = klass.instance_method(:do_something).owner
        expect(owner.name).to eq("#{ns}::DoSomething::AsPublicMethod__DoSomething")
      end

      it "calls service object under the hood" do
        expect(ns::DoSomething).to receive(:call).and_call_original
        expect(klass.new.send(:do_something)).to eq(:do_something_call)
      end
    end

    describe "#do_something class method" do
      it "is public" do
        expect(klass.public_methods).to include(:do_something)
        expect(klass.singleton_methods).to include(:do_something)
      end

      it "originates from autogenerated SO module" do
        owner = klass.public_method(:do_something).owner
        expect(owner.name).to eq("#{ns}::DoSomethingElse::AsPublicMethod__DoSomething")
      end

      it "calls service object under the hood" do
        expect(ns::DoSomethingElse).to receive(:call).and_call_original
        expect(klass.send(:do_something)).to eq(:do_something_else_call)
      end
    end
  end
end
