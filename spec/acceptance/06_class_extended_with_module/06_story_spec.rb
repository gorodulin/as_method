# frozen_string_literal: true

require "spec_helper"

RSpec.describe "Story06" do

  let(:ns) { Story06 }

  before do
    code = File.read(File.join(__dir__, "06_story.rb"))
    eval(code)
  end

  describe "Story06::IncludableModule" do
    subject(:mod) { ns::IncludableModule }

    context "when extended" do
      let(:klass) { Class.new.tap { _1.extend mod } }

      describe "#do_something class method" do
        it "is private" do
          expect(klass.private_methods).to include(:do_something)

          expect(klass.private_instance_methods).not_to include(:do_something)
          expect(klass.public_instance_methods).not_to include(:do_something)
          expect(klass.singleton_methods).not_to include(:do_something)
          expect(klass.public_methods).not_to include(:do_something)
        end

        it "calls service object under the hood" do
          expect(ns::DoSomething).to receive(:call).and_call_original
          expect(klass.send(:do_something)).to eq(:do_something_call)
        end
      end

      describe "#do_something_else class method" do
        it "is public" do
          expect(klass.public_methods).to include(:do_something_else)
          expect(klass.singleton_methods).to include(:do_something_else)

          expect(klass.private_methods).not_to include(:do_something_else)
          expect(klass.public_instance_methods).not_to include(:do_something_else)
          expect(klass.private_instance_methods).not_to include(:do_something_else)
        end

        it "calls service object under the hood" do
          expect(ns::DoSomething).to receive(:call).and_call_original
          expect(klass.send(:do_something_else)).to eq(:do_something_call)
        end
      end

      describe "class's singleton class" do
        subject { klass.singleton_class }
        it "includes modules bringing service objects" do
          expect(subject.included_modules.map(&:name)).to include \
            mod.to_s,
            "#{ns}::DoSomething::AsPrivateMethod__DoSomething",
            "#{ns}::DoSomething::AsPublicMethod__DoSomethingElse"
        end
      end

    end
  end

  describe "Story06::NonIncludableModule" do
    subject(:mod) { ns::NonIncludableModule }

    context "when included into a class" do
      let(:klass) { Class.new.tap { _1.extend mod } }

      it "does not bring new methods" do
        expect(klass.private_methods).not_to include(:do_something, :do_something_else)
        expect(klass.public_methods).not_to include(:do_something, :do_something_else)
        expect(klass.singleton_methods).not_to include(:do_something, :do_something_else)
        expect(klass.public_instance_methods).not_to include(:do_something, :do_something_else)
        expect(klass.private_instance_methods).not_to include(:do_something, :do_something_else)
      end
    end
  end
end
