# frozen_string_literal: true

require "spec_helper"

RSpec.describe "Story02" do

  let(:ns) { Story02 }

  before do
    code = File.read(File.join(__dir__, "02_story.rb"))
    eval(code)
  end

  describe "Story02::DummyKlass" do
    context "when EXTENDED with service object DoSomething" do
      subject(:klass) { ns::DummyKlass }

      describe "#do_something class method" do
        it "is public" do
          expect(klass.public_methods).to include(:do_something)
          expect(klass.singleton_methods).to include(:do_something)

          expect(klass.private_methods).not_to include(:do_something)
          expect(klass.public_instance_methods).not_to include(:do_something)
        end

        it "calls DoSomething#call (class method) under the hood" do
          expect(ns::DoSomething).to receive(:call).and_call_original
          expect(klass.send(:do_something)).to eq(:do_something_call)
        end
      end

      describe "#do_something_else class method" do
        it "is private" do
          expect(klass.private_methods).to include(:do_something_else)

          expect(klass.public_methods).not_to include(:do_something_else)
          expect(klass.singleton_methods).not_to include(:do_something_else)
          expect(klass.private_instance_methods).not_to include(:do_something_else)
        end

        it "calls DoSomething#call (class method) under the hood" do
          expect(ns::DoSomething).to receive(:call).and_call_original
          expect(klass.send(:do_something_else)).to eq(:do_something_call)
        end
      end

      describe "class's singleton class" do
        subject { klass.singleton_class }

        it "includes new modules" do
          expect(subject.included_modules.map(&:name)).to include \
            "#{ns}::DoSomething::AsPublicMethod__DoSomething",
            "#{ns}::DoSomething::AsPrivateMethod__DoSomethingElse"
        end
      end

    end
  end
end
