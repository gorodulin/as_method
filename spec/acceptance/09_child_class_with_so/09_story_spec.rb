# frozen_string_literal: true

require "spec_helper"

RSpec.describe "Story09" do
  let(:ns) { Story09 }

  before do
    code = File.read(File.join(__dir__, "09_story.rb"))
    eval(code)
  end

  describe "child class that inherits from base class" do
    let(:klass) { ns::DummyKlass }

    describe "when base class has service objects included" do
      describe "#do_something" do
        it "is private" do
          expect(klass.private_instance_methods).to include(:do_something)

          expect(klass.public_instance_methods).not_to include(:do_something)
          expect(klass.singleton_methods).not_to include(:do_something)
          expect(klass.public_methods).not_to include(:do_something)
          expect(klass.private_methods).not_to include(:do_something)
        end

        it "calls service object under the hood" do
          expect(ns::DoSomething).to receive(:call).and_call_original
          expect(klass.new.send(:do_something)).to eq(:do_something_call)
        end
      end

      describe "#do_something_else class method" do
        it "is public" do
          expect(klass.singleton_methods).to include(:do_something_else)
          expect(klass.public_methods).to include(:do_something_else)

          expect(klass.public_instance_methods).not_to include(:do_something_else)
          expect(klass.private_instance_methods).not_to include(:do_something_else)
          expect(klass.private_methods).not_to include(:do_something_else)
        end

        it "calls service object under the hood" do
          expect(ns::DoSomething).to receive(:call).and_call_original
          expect(klass.send(:do_something_else)).to eq(:do_something_call)
        end
      end

      describe "class modules" do
        subject(:modules) { klass.included_modules.map(&:name) }

        it "has included modules" do
          expect(modules).to include("#{ns}::DoSomething::AsPrivateMethod__DoSomething")
        end
      end

      describe "singleton class modules" do
        subject(:modules) { klass.singleton_class.included_modules.map(&:name) }

        it "has included modules" do
          expect(modules).to include("#{ns}::DoSomething::AsPublicMethod__DoSomethingElse")
        end
      end
    end
  end
end
