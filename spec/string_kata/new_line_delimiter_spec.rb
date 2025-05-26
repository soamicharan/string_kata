require 'spec_helper'
require_relative '../lib/main'

RSpec.describe 'string kata' do
  it 'adds numbers with comma and new line delimiter' do
    expect(add("1\n2,3")).to eq(6)
  end

  it 'add numbers with new line delimiter only' do
    add("1\n2\n3").to eq(6)
  end
  
  it 'sum on empty value between different delimiters' do
    add("1,\n3").to eq(4)
  end
  
  it 'raise error on input string ends with different delimiter' do
    expect {add("1,2,\n") }.to raise_error(ArgumentError, "Input string is invalid as ends with delimiter")
  end
end
