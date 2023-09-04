# frozen_string_literal: true

require "spec_helper"

RSpec.describe "Story05" do

  let(:ns) { Story05 }

  before do
    code = File.read(File.join(__dir__, "05_story.rb"))
    eval(code)
  end

  describe "Story05::DummyKlass" do
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


  xdescribe "service object" do
    subject { service_object }
    it_behaves_like "stubbable service object"
  end

  xdescribe "stub" do
    let(:injected) do
      { "do_something" => spy("#{service_object}#do_something") }
    end

    before do
      service_object::Stubbable.set_stub(send("injected")["do_something"])
    end

    it "-" do
      allow(injected["do_something"]).to receive(:call).and_return(:lala)
      klass.do_something_else
      expect(injected["do_something"]).to have_received(:call)
    end
  end

end