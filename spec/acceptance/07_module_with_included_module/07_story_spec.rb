# frozen_string_literal: true

require "spec_helper"

RSpec.describe "Story07" do
  let(:ns) { Story07 }

  before do
    code = File.read(File.join(__dir__, "07_story.rb"))
    eval(code)
  end

  describe "Story07::AggregateInterfaceModule" do
    subject(:mod) { ns::AggregateInterfaceModule }

    describe "instance methods" do
      describe "#do_something" do
        it "is public" do
          expect(mod.public_instance_methods).to include(:do_something)

          expect(mod.private_instance_methods).not_to include(:do_something)
          expect(mod.singleton_methods).not_to include(:do_something)
          expect(mod.public_methods).not_to include(:do_something)
          expect(mod.private_methods).not_to include(:do_something)
        end

        it "originates from autogenerated SO module" do
          expect(mod.instance_method(:do_something).owner.name).to eq("#{ns}::DoSomething::AsPublicMethod__DoSomething")
        end
      end

      describe "#do_something_else" do
        it "is private" do
          expect(mod.private_instance_methods).to include(:do_something_else)

          expect(mod.public_instance_methods).not_to include(:do_something_else)
          expect(mod.singleton_methods).not_to include(:do_something_else)
          expect(mod.public_methods).not_to include(:do_something_else)
          expect(mod.private_methods).not_to include(:do_something_else)
        end

        it "originates from autogenerated SO module" do
          owner = mod.instance_method(:do_something_else).owner
          expect(owner.name).to eq("#{ns}::DoSomething::AsPrivateMethod__DoSomethingElse")
        end
      end
    end

    describe "class methods" do
      it "are not defined" do
        expect { mod.send(:klassy_do_something) }.to raise_error NoMethodError
        expect { mod.send(:klassy_do_something_else) }.to raise_error NoMethodError
        expect { mod.singleton_class.send(:klassy_do_something) }.to raise_error NoMethodError
        expect { mod.singleton_class.send(:klassy_do_something_else) }.to raise_error NoMethodError
      end
    end

    it "includes modules of service objects" do
      expect(mod.included_modules.map(&:name)).to include \
        "#{ns}::InterfaceModule",
        "#{ns}::ServiceObjectCollection1",
        "#{ns}::ServiceObjectCollection2",
        "#{ns}::DoSomething::AsPublicMethod__DoSomething",
        "#{ns}::DoSomething::AsPrivateMethod__DoSomethingElse"
    end
  end
end
