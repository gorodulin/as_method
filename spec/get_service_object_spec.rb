# frozen_string_literal: true

require "spec_helper"

# HELPER CLASSES

So1 = Class.new do
  def self.call
    "so_1"
  end
end

So2 = Class.new do
  def self.call
    "so_2"
  end
end

# SPECS

RSpec.describe AsMethod::GetServiceObject do
  subject { described_class.call(obj, method_name) }

  # -------------------------------------------------------------------------
  # |                       |  method_name  |  #method_name | ::method_name |
  # -------------------------------------------------------------------------
  # | class: -----, ----    |   not found   |   not found   |   not found   |
  # | class: -----, #mtd    |  instance mtd |  instance mtd |   not found   |
  # | class: ::mtd, ----    |   class mtd   |   not found   |   class mtd   |
  # | class: ::mtd, #mtd    |   ambiguous   |  instance mtd |   class mtd   |
  # -------------------------------------------------------------------------

  context "when object is a Module (or a Class)" do
    let(:obj) do
      Module.new do
        extend AsMethod::Allow
        include as_method So1, name: :instance_only_method, access: :private
        include as_method So1, name: :method1, access: :private
        extend  as_method So2, name: :method1, access: :private
        extend  as_method So2, name: :class_only_method, access: :private
      end
    end

    context "when method_name starts with '#'" do
      context "when method is not defined" do
        let(:method_name) { "#unknown" }
        it "raises error" do
          expect { subject }.to raise_error NameError, /undefined method.*unknown/
        end
      end
      context "when method is defined on class only" do
        let(:method_name) { "#class_only_method" }
        it "raises error" do
          expect { subject }.to raise_error NameError, /undefined method.*class_only_method/
        end

      end
      context "when method is defined on instance only" do
        let(:method_name) { "#instance_only_method" }
        it "returns service object" do
          expect(subject).to eq(So1)
        end
      end
      context "when method is defined on both class and instance" do
        let(:method_name) { "#method1" }
        it "returns service object for instance method" do
          expect(subject).to eq(So1)
        end
      end
    end
    context "when method_name starts with '::'" do
      context "when method is not defined" do
        let(:method_name) { "::unknown" }
        it "raises error" do
          expect { subject }.to raise_error NameError, /undefined method.*unknown/
        end
      end
      context "when method is defined on class only" do
        let(:method_name) { "::class_only_method" }
        it "returns service object" do
          expect(subject).to eq(So2)
        end
      end
      context "when method is defined on instance only" do
        let(:method_name) { "::instance_only_method" }
        it "raises error" do
          expect { subject }.to raise_error NameError, /undefined method.*instance_only_method/
        end
      end
      context "when method is defined on both class and instance" do
        let(:method_name) { "::method1" }
        it "returns service object for class method" do
          expect(subject).to eq(So2)
        end
      end
    end
    context "when method_name does not have prefixes" do
      context "when method is not defined" do
        let(:method_name) { "unknown" }
        it "raises error" do
          expect { subject }.to raise_error NameError, /undefined method.*unknown/
        end
      end
      context "when method is defined on class only" do
        let(:method_name) { "class_only_method" }
        it "returns service object for class method" do
          expect(subject).to eq(So2)
        end
      end
      context "when method is defined on instance only" do
        let(:method_name) { "instance_only_method" }
        it "returns service object for instance method" do
          expect(subject).to eq(So1)
        end
      end
      context "when method is defined on both class and instance" do
        let(:method_name) { "method1" }
        it "raises error" do
          expect { subject }.to raise_error NameError, /Ambiguous name.*method1/
        end
      end
    end
  end

  context "when object is not a Class or Module" do
    let(:obj) { Object.new }
    let(:method_name) { "a_method" }

    it "raises an ArgumentError" do
      expect { subject }.to raise_error(ArgumentError, /expected .* to be a Module or Class/)
    end
  end

end
