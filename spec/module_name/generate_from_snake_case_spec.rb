# frozen_string_literal: true

require "spec_helper"

RSpec.describe AsMethod::ModuleName::GenerateFromSnakeCase do
  {
    "_name"           => "SPECIALName",
    "__name"          => "SPECIAL_Name",
    "_1name"          => "SPECIAL_1name",
    "__1name"         => "SPECIAL__1name",
    "_name1"          => "SPECIALName1",
    "_1name1"         => "SPECIAL_1name1",
    "name1_"          => "Name1_",
    "name1__"         => "Name1__",
    "name?"           => "Name_Que",
    "name_?"          => "Name__Que",
    "name__?"         => "Name___Que",
    "name!"           => "Name_Exc",
    "name_!"          => "Name__Exc",
    "name__!"         => "Name___Exc",
    "name="           => "Name_Eql",
    "name_="          => "Name__Eql",
    "name__="         => "Name___Eql",
    "[]="             => "SPECIAL_Sbl_Sbr_Eql",
    "-"               => "SPECIAL_Min",
    "ab1_a1b_1ab_"    => "Ab1A1b_1ab_",
    "ab1__a1b__1ab__" => "Ab1_A1b__1ab__",
    "my_fn_name"      => "MyFnName",
    "my_fn__name"     => "MyFn_Name",
    "my_fn_name21"    => "MyFnName21",
    "my_fn_name_21"   => "MyFnName_21",
    "my_fn_name_"     => "MyFnName_",
    "my__fn_name_"    => "My_FnName_",
    "_my_fn_name"     => "SPECIALMyFnName",
  }.tap do |examples|
    describe "examples" do
      it "has unique keys and values" do
        expect(examples.keys.uniq).to eq(examples.keys)
        expect(examples.values.uniq).to eq(examples.values)
      end
    end

    describe ".call" do
      examples.each do |snake_case, expected_result|
        it "maps #{snake_case.inspect} to #{expected_result.inspect}" do
          result = described_class.call(snake_case)
          expect(result).to eq(expected_result)
        end
      end
    end
  end
end
