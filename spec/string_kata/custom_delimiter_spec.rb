require 'spec_helper'
require_relative '../../lib/main'

RSpec.describe 'string kata' do
  it 'adds numbers with custom delimiter' do
    expect(add("//[;]\n1;2;3")).to eq(6)
  end

  it 'add numbers with default delimiter as custom delimiter' do
    expect(add("//[\n]\n1\n2\n3")).to eq(6)
  end
  
  it 'add numbers with delimiters differed from format' do
    expect(add("//[;]\n1,3")).to eq(4)
  end
  
  it 'raises an error on invalid delimiter format' do
    expect { add("//;1;2") }.to raise_error(ArgumentError, "Invalid delimiter format.")
  end

  [
      {input_string: "//[@#][#]\n1,2@#3,4#5#1", output: 16},
      {input_string: "//[,][abc][&x][****]\n1****2\n3&x4", output: 10},
      {input_string: "//[,][--]\n1--2\n3--4", output: 10},
  ].each do |test_case|
    it "add number with variable length delimiter input #{test_case[:input_string]}" do
      expect(add(test_case[:input_string])).to be(test_case[:output])
    end
  end
end
