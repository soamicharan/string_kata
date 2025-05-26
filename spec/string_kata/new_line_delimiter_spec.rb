require 'spec_helper'
require_relative '../lib/main'

RSpec.describe 'string kata' do
  it 'adds two numbers with comma and new line delimited' do
    expect(add("1\n2,3")).to eq(6)
  end

  it 'add two numbers with new line delimiter only' do
    expect(add("1\n2\n3")).to eq(6)
  end
  
  it 'raises an error on empty value between different delimiters' do
    expect { add("1,\n3") }.to raise_error(ArgumentError, "Input string contains empty values.")
  end
end
