require 'spec_helper'
require_relative '../../lib/main'

RSpec.describe 'string kata' do
  it 'adds numbers with no negetive' do
    expect(add("1\n2,3")).to eq(6)
  end

  it 'add numbers some negetive numbers' do
    expect{ add("1\n-2\n3,-5") }.to raise_error(ArgumentError, "Negetives not allowed - -2, -5")
  end
  
  it 'add numbers on hyphen as delimiter' do
    expect(add("//[-]\n1-2\n3")).to eq(6)
  end
  
  it 'add numbers on hyphen as delimiter with negetive numbers' do
    expect(add("//[-]\n1-2--3---4")).to be(10)
  end
end
