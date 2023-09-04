# frozen_string_literal: true

require "spec_helper"

RSpec.describe "Story10" do

  let(:ns) { Story10 }

  before do
    code = File.read(File.join(__dir__, "10_story.rb"))
    eval(code)
  end

  describe "Story10::AggregateInterfaceModule" do
    subject(:mod) { ns::AggregateInterfaceModule }
    let(:klass) { Class.new.tap { _1.include mod } }

    context "when includes modules with SO-based methods" do
      describe "#do_something_else" do
        it "is private" do
          expect(mod.private_instance_methods).to include(:do_something_else)

          expect(mod.public_instance_methods).not_to include(:do_something_else)
          expect(mod.singleton_methods).not_to include(:do_something_else)
          expect(mod.public_methods).not_to include(:do_something_else)
          expect(mod.private_methods).not_to include(:do_something_else)
        end

        it "calls service object under the hood" do
          expect(ns::DoSomething).to receive(:call).and_call_original
          expect(klass.new.send(:do_something)).to eq(:do_something_call)
        end
      end
    end


    xcontext "when includes AggregateInterfaceModule" do
      let(:klass) { Class.new.tap { _1.extend mod } }



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
            "#{mod}",
            "#{ns}::DoSomething::AsPrivateMethod__DoSomething",
            "#{ns}::DoSomething::AsPublicMethod__DoSomethingElse"
        end
      end

    end
  end

  xdescribe "Story10::NonIncludableModule" do
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
