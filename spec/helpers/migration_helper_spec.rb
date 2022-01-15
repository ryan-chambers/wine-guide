require "rails_helper"

describe MigrationHelper do
  it 'should map single red grape to itself' do
    expect(grape_name ['Zweigelt']).to eq('Zweigelt')
  end

  it 'should map single white grape to itself' do
    expect(grape_name ['Chardonnay']).to eq('Chardonnay')
  end

  it 'should map Other White grape to itself' do
    expect(grape_name [ 'Other White']).to eq('Other White')
  end

  it 'should map mix of red grapes to Red Blend' do
    expect(grape_name [ 'Merlot', 'Malbec']).to eq('Red Blend')
  end

  it 'should map mix of white grapes to Red Blend' do
    expect(grape_name [ 'Chardonnay', 'Riesling']).to eq('White Blend')
  end
end
