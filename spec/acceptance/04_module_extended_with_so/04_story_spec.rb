# frozen_string_literal: true

require "spec_helper"

RSpec.describe "Story04" do

  let(:ns) { Story04 }

  before do
    code = File.read(File.join(__dir__, "04_story.rb"))
    eval(code)
  end

  describe "Story04::InterfaceModule" do
    subject(:mod) { ns::InterfaceModule }

    context "when EXTENDED with some service objects" do
      describe "#do_something class method" do
        it "is public" do
          expect(mod).to respond_to(:do_something)

          expect(mod.public_methods).to include(:do_something)
          expect(mod.singleton_methods).to include(:do_something)

          expect(mod.private_methods).not_to include(:do_something)
          expect(mod.public_instance_methods).not_to include(:do_something)
        end

        it "calls DoSomething#call (class method) under the hood" do
          expect(ns::DoSomething).to receive(:call).and_call_original
          expect(mod.send(:do_something)).to eq(:do_something_call)
        end
      end

      describe "#do_something_else class method" do
        it "is private" do
          expect(mod).not_to respond_to(:do_something_else)
          expect(mod.private_methods).to include(:do_something_else)

          expect(mod.public_methods).not_to include(:do_something_else)
          expect(mod.singleton_methods).not_to include(:do_something_else)
          expect(mod.private_instance_methods).not_to include(:do_something_else)
        end

        it "calls DoSomething#call (class method) under the hood" do
          expect(ns::DoSomething).to receive(:call).and_call_original
          expect(mod.send(:do_something_else)).to eq(:do_something_call)
        end
      end

      describe "singleton class" do
        subject { mod.singleton_class }

        it "is includes new modules" do
          expect(subject.included_modules.map(&:name)).to include \
            "AsMethod::Allow",
            "#{ns}::DoSomething::AsPrivateMethod__DoSomethingElse",
            "#{ns}::DoSomething::AsPublicMethod__DoSomething"
        end
      end

    end
  end
end
