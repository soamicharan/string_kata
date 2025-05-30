require 'spec_helper'
require_relative '../../lib/main'

RSpec.describe 'string kata' do
  it 'adds numbers less than 100' do
    expect(add("1,100\n999")).to eq(1100)
  end

  it 'add numbers with some more than 1000' do
    expect(add("1\n2\n3,1000,4,1001")).to be(10)
  end
end
