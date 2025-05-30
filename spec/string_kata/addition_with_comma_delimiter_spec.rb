require 'spec_helper'
require_relative '../../lib/main'

RSpec.describe 'string kata' do
  it 'adds two numbers with comma delimited' do
    expect(add("1,2")).to eq(3)
  end

  it 'add with single number in input' do
    expect(add("1")).to eq(1)
  end
  
  it 'add with decimal number in input' do
    expect(add("1,2.1")).to eq(3.1)
  end
  
  it 'sum on empty string input' do
    expect(add("")).to eq(0)
  end
  
  it 'sum on empty value between delimiter' do
    expect(add("1,,3")).to eq(4)
  end
  
  
  it 'raise error on input string ends with delimiter' do
    expect(add("1,2,")).to be(3)
  end
  
  [
      {input_string: "1,nonChar,2", expected_exception_char: 'nonChar'},
      {input_string: "1,3i,2", expected_exception_char: '3i'},
      {input_string: "1#2,2", expected_exception_char: "1#2"},
  ].each do |test_case|
    it "raises an error on non numeric character input #{test_case[:input_string]}" do
      expect { add(test_case[:input_string]) }.to raise_error(ArgumentError, "Input string has invalid number #{test_case[:expected_exception_char]}.")
    end
  end
end
