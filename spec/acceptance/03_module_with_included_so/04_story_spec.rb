# frozen_string_literal: true

require "spec_helper"

RSpec.describe "Story04" do

  let(:ns) { Story04 }

  before do
    code = File.read(File.join(__dir__, "04_story.rb"))
    eval(code)
  end

  describe "Story04::IncludableModule" do
    subject(:mod) { ns::IncludableModule }

    context "with INCLUDED service object DoSomething" do
      describe "#do_something" do
        it "is private instance method" do
          expect(mod).not_to respond_to(:do_something)

          expect(mod.private_instance_methods).to include(:do_something)

          expect(mod.public_instance_methods).not_to include(:do_something)
          expect(mod.private_methods).not_to include(:do_something)
          expect(mod.public_methods).not_to include(:do_something)
          expect(mod.singleton_methods).not_to include(:do_something)
        end

        xit "calls DoSomething#call (class method) under the hood" do
          expect(ns::DoSomething).to receive(:call).and_call_original
          expect(mod.send(:do_something)).to eq(:do_something_call)
        end
      end

      describe "#do_something_else" do
        it "is public instance method" do
          expect(mod).not_to respond_to(:do_something_else)

          expect(mod.public_instance_methods).to include(:do_something_else)

          expect(mod.private_instance_methods).not_to include(:do_something_else)
          expect(mod.private_methods).not_to include(:do_something_else)
          expect(mod.public_methods).not_to include(:do_something_else)
          expect(mod.singleton_methods).not_to include(:do_something_else)
        end
      end

      it "includes new modules" do
        expect(mod.included_modules.map(&:name)).to include \
          "#{ns}::DoSomething::AsPrivateMethod__DoSomething",
          "#{ns}::DoSomething::AsPublicMethod__DoSomethingElse"
      end
    end

  end
end
