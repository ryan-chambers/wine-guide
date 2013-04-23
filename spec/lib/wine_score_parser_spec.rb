# coding: utf-8

require 'spec_helper'
require 'wine_score_parser'

describe 'Wine Score Parser' do
  describe 'parsing one line from file' do
    s = parse_wine_score_line('a', 'Canada')
  end
  
  describe 'parsing the winery sentence' do
    it 'identifies all parts' do
      w = make_wine('Château Lajarre, Cuvée Eléonore, Red Blend, 2010,'\
      ' Ac Bordeaux Supérieur, Bordeaux, LCBO# 307017', 'France')
#      p "#{w.to_s}"
      expect(w.lcbo).to eq('307017')
      expect(w.winery_name).to eq('Château Lajarre')
      expect(w.other[0]).to eq('Cuvée Eléonore')
      expect(w.country).to eq('France')
      expect(w.region).to eq('Bordeaux')
      expect(w.year).to eq('2010')
    end
  end
end
