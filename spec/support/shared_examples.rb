RSpec.shared_examples "stubbable service object" do
  it "has Stubbable module defined" do
    mod = subject::Stubbable
    expect(mod).to be_a(Module)
    expect(mod).to respond_to(:unstub!)
    expect(mod).to respond_to(:get_stub)
    expect(mod).to respond_to(:set_stub)
  end
end