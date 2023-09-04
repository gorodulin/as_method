# frozen_string_literal: true

require "spec_helper"

RSpec.describe "Story01" do

  let(:ns) { Story01 }
  let(:service_object) { ns::DoSomething }
  let(:stub_module) { service_object::Stubbable }

  before do
    code = File.read(File.join(__dir__, "01_story.rb"))
    eval(code)
  end

  describe "Story01::DummyKlass class" do
    subject(:klass) { ns::DummyKlass }

    context "when INCLUDES DoSomething service object" do

      it "includes new modules" do
        expect(subject.included_modules.map(&:name)).to include \
          "#{ns}::DoSomething::AsPublicMethod__DoSomethingElse",
          "#{ns}::DoSomething::AsPrivateMethod__DoSomething"
      end

      describe "#do_something instance method" do
        it "is private" do
          expect(klass.private_instance_methods).to include(:do_something)
        end

        it "calls DoSomething#call (class method) under the hood" do
          expect(ns::DoSomething).to receive(:call).and_call_original
          expect(klass.new.send(:do_something)).to eq(:do_something_call)
        end
      end

      describe "#do_something_else instance method" do
        it "is public" do
          expect(klass.public_instance_methods).to include(:do_something_else)
        end

        it "calls DoSomething#call (class method) under the hood" do
          expect(ns::DoSomething).to receive(:call).and_call_original
          expect(klass.new.send(:do_something)).to eq(:do_something_call)
        end
      end
    end
  end

  xdescribe "DoSomething service object class" do
    it "has DoSomething::Stubbable module defined" do
      expect(ns::DoSomething::Stubbable).to be_a(Module)
    end
  end
end
