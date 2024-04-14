# frozen_string_literal: true

require 'spec_helper'
require_relative '../lib/substrings'

describe '#substrings' do
  let(:dictionary) { ["below","down","go","going","horn","how","howdy","it","i","low","own","part","partner","sit"] }

  it 'returns a hash with word frequencies for a single word' do
    expect(substrings('below', dictionary)).to eq({ 'below' => 1, 'low' => 1 })
  end

  it 'returns a hash with word frequencies for multiple words' do
    expect(substrings("Howdy partner, sit down! How's it going?", dictionary)).to eq(
      {
        'down' => 1, 'go' => 1, 'going' => 1, 'how' => 2, 'howdy' => 1,
        'it' => 2, 'i' => 3, 'own' => 1, 'part' => 1, 'partner' => 1, 'sit' => 1
      }
    )
  end

  it 'returns an empty hash for an empty string' do
    expect(substrings('', dictionary)).to eq({})
  end

  it 'handles case-insensitive matches' do
    expect(substrings("HOWdy PARTner, sit down! how's it going?", dictionary)).to eq(
      {
        'down' => 1, 'go' => 1, 'going' => 1, 'how' => 2, 'howdy' => 1,
        'it' => 2, 'i' => 3, 'own' => 1, 'part' => 1, 'partner' => 1, 'sit' => 1
      }
    )
  end
end
