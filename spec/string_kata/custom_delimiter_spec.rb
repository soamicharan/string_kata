require 'spec_helper'
require_relative '../../lib/main'

RSpec.describe 'string kata' do
  it 'adds numbers with custom delimiter' do
    expect(add("//;\n1;2;3")).to eq(6)
  end

  it 'add numbers with default delimiter as custom delimiter' do
    expect(add("//\n\n1\n2\n3")).to eq(6)
  end
  
  it 'add numbers with delimiters differed from format' do
    expect(add("//;\n1,3")).to eq(4)
  end
  
  it 'raises an error on invalid delimiter format' do
    expect { add("//;1;2") }.to raise_error(ArgumentError, "Invalid delimiter format.")
  end
end
