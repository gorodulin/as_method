# frozen_string_literal: true

require "spec_helper"

RSpec.describe "Story11" do
  subject { klass }
  let(:ns) { Story11 }
  let(:klass) { ns::DummyKlass }

  before do
    code = File.read(File.join(__dir__, "11_story.rb"))
    eval(code)
  end

  describe "BaseKlass" do
    subject { ns::BaseKlass }
    it "responds to :do_something, both class and instance" do
      expect(subject.do_something).to eq(:do_something_else_call)
      expect(subject.new.do_something).to eq(:do_something_call)
    end
  end

  describe "DummyKlass" do
    subject { ns::DummyKlass }

    it "has included modules" do
      expect(klass.included_modules.map(&:name)).to include \
        "#{ns}::DoSomething::AsPrivateMethod__DoSomethingNew_2",
        "#{ns}::DoSomething::AsPrivateMethod__DoSomethingNew_1",
        "#{ns}::DoSomethingElse::AsPrivateMethod__DoSomething",
        "#{ns}::DoSomething::AsPublicMethod__DoSomething"

      expect(klass.singleton_class.included_modules.map(&:name)).to include \
        "#{ns}::DoSomething::AsPrivateMethod__DoSomething",
        "#{ns}::DoSomethingElse::AsPublicMethod__DoSomething",
        "AsMethod::Helpers::ClassMethods"
    end

    describe "instance methods" do
      it "private :do_something" do
        expect(subject.new.send(:do_something)).to eq(:do_something_else_call)
        expect(subject.new.method(:do_something).owner).to eq(ns::DoSomethingElse::AsPrivateMethod__DoSomething)
      end
      it "private :do_something_new_1" do
        expect(subject.new.send(:do_something_new_1)).to eq("do_something_call overrided")
        expect(subject.new.method(:do_something_new_1).owner).to eq(ns::DummyKlass)
      end
      it "private :do_something_new_2" do
        expect(subject.new.send(:do_something_new_2)).to eq(:do_something_call)
        expect(subject.new.method(:do_something_new_2).owner).to eq(ns::DoSomething::AsPrivateMethod__DoSomethingNew_2)
      end
    end

    describe "class methods" do
      it "private :do_something" do
        expect(subject.send(:do_something)).to eq(:do_something_call)
        expect(subject.method(:do_something).owner).to eq(ns::DoSomething::AsPrivateMethod__DoSomething)
      end
    end
  end

end
