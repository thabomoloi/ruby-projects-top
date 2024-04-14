# frozen_string_literal: true

require 'spec_helper'
require_relative '../lib/caesar_cipher'

describe '#caesar_cipher' do
  it 'returns the correct shifted string' do
    expect(caesar_cipher('What a string!', 5)).to eq('Bmfy f xywnsl!')
  end

  it 'handles negative shifts' do
    expect(caesar_cipher('Mjqqt, Btwqi!', -5)).to eq('Hello, World!')
  end

  it 'wraps around the alphabet correctly' do
    expect(caesar_cipher('xyz', 5)).to eq('cde')
  end

  it 'handles mixed case and punctuation' do
    expect(caesar_cipher('Hello, World!', 7)).to eq('Olssv, Dvysk!')
  end

  it 'wraps around the alphabet for large shifts' do
    expect(caesar_cipher('abcdefghijklmnopqrstuvwxyz', 25)).to eq('zabcdefghijklmnopqrstuvwxy')
  end

  it 'does not change the string for a shift of 0' do
    expect(caesar_cipher('example', 0)).to eq('example')
  end
end
