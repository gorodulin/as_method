# frozen_string_literal: true

require "spec_helper"

RSpec.describe "Story08" do

  let(:ns) { Story08 }

  before do
    code = File.read(File.join(__dir__, "08_story.rb"))
    eval(code)
  end

  describe "Story08::InterfaceModule" do
    context "when EXTENDED with a module with included SOs" do
      subject(:mod) { ns::InterfaceModule }

      it "#do_something class method" do
        expect(mod.public_methods).to include(:do_something)
        expect(mod.singleton_methods).to include(:do_something)

        expect(mod.private_methods).not_to include(:do_something)
        expect(mod.public_instance_methods).not_to include(:do_something)
      end

      it "#do_something_else class method" do
        expect(mod.private_methods).to include(:do_something_else)

        expect(mod.public_methods).not_to include(:do_something_else)
        expect(mod.singleton_methods).not_to include(:do_something_else)
        expect(mod.private_instance_methods).not_to include(:do_something_else)
      end

      describe "module's singleton class" do
        subject { mod.singleton_class }

        it "includes new modules" do
          expect(subject.included_modules.map(&:name)).to include \
            "#{ns}::ServiceObjectCollection1",
            "#{ns}::ServiceObjectCollection2",
            "#{ns}::DoSomething::AsPublicMethod__DoSomething",
            "#{ns}::DoSomething::AsPrivateMethod__DoSomethingElse"
        end
      end
    end

    context "when INCLUDED into another module" do
      xit "does not have them registered" do
      end
    end
  end
end