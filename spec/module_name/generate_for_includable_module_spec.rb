
require "spec_helper"

RSpec.describe AsMethod::ModuleName::GenerateForIncludableModule do
  subject { described_class.call(so_module, desired_method_name) }
  let(:so_module) { "MyNamespace::SubNamespace::DoSomething" }
  

  context "when method name is not provided" do
    let(:desired_method_name) { nil }
    it "returns *As<MethodName>Method as module name" do
      expect(subject).to eq "::MyNamespace::SubNamespace::DoSomething::AsDoSomethingMethod"
    end
  end

  context "when method name is provided" do
    context "when different" do
      let(:desired_method_name) { :do_something_good }
      it "returns *As<MethodName>Method as module name" do
        expect(subject).to eq "::MyNamespace::SubNamespace::DoSomething::AsDoSomethingGoodMethod"
      end
    end

    context "when same" do
      let(:desired_method_name) { :do_something }
      it "returns *As<MethodName>Method as module name" do
        expect(subject).to eq "::MyNamespace::SubNamespace::DoSomething::AsDoSomethingMethod"
      end
    end

    context "when contains a special char" do
      let(:desired_method_name) { :method! }
      it "returns module name with char replaced with a safe slug" do
        expect(subject).to eq "::MyNamespace::SubNamespace::DoSomething::AsMethod_ExcMethod"
      end
    end
  end

end
