# frozen_string_literal: true

require "spec_helper"

RSpec.describe "Story12" do
  subject { klass }
  let(:ns) { Story12 }
  let(:klass) { ns::DummyKlass }

  before do
    code = File.read(File.join(__dir__, "12_story.rb"))
    eval(code)
  end

  describe "DoSomething" do
    subject { ns::DoSomething }
    context "when included in DummyKlass" do
      it "brings modules" do
        expect(ns::DummyKlass.included_modules.map(&:name))
          .to include \
            "#{ns}::DoSomething::AsPublicMethod__DoSomethingElse",
            "#{ns}::ServiceObjectBase::AsPublicMethod__DoSomething"
      end
    end
  end

end
