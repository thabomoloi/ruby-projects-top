# frozen_string_literal: true

require 'spec_helper'
require_relative '../lib/matches'

describe Matcher do
  describe '#initialize' do
    it 'sets the instance variables correctly' do
      matcher = Matcher.new(%w[R G B Y], %w[R G B Y])
      expect(matcher.instance_variable_get(:@secret_code)).to eq(%w[R G B Y])
      expect(matcher.instance_variable_get(:@guess)).to eq(%w[R G B Y])
      expect(matcher.instance_variable_get(:@exact_matches)).to eq(4)
      expect(matcher.instance_variable_get(:@near_matches)).to eq(0)
      expect(matcher.instance_variable_get(:@secret_colors_remaining)).to eq(%w[R G B Y])
      expect(matcher.instance_variable_get(:@guess_colors_remaining)).to eq(%w[R G B Y])
    end
  end

  describe '#remove_exact_matches' do
    it 'removes exact matches from the remaining colors arrays' do
      matcher = Matcher.new(%w[R G B Y], %w[R G B Y])
      matcher.remove_exact_matches
      expect(matcher.instance_variable_get(:@secret_colors_remaining)).to eq([])
      expect(matcher.instance_variable_get(:@guess_colors_remaining)).to eq([nil, nil, nil, nil])
    end
  end

  describe '#count_near_matches' do
    it 'counts the number of near matches' do
      matcher = Matcher.new(%w[R G B Y], %w[Y B G R])
      matcher.remove_exact_matches
      matcher.count_near_matches
      expect(matcher.instance_variable_get(:@near_matches)).to eq(4)
    end
  end

  describe '#find_matches' do
    it 'returns a hash containing the number of exact matches and near matches' do
      matcher = Matcher.new(%w[R G B Y], %w[Y B G R])
      expect(matcher.find_matches).to eq({ exact_matches: 0, near_matches: 4 })
    end
  end
end

RSpec.describe '#find_matches' do
  it 'returns a hash containing the number of exact matches and near matches' do
    expect(find_matches(%w[R G B Y], %w[Y B G R])).to eq({ exact_matches: 0, near_matches: 4 })
  end
end
