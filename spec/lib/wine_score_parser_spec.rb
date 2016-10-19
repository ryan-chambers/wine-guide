# coding: utf-8

require 'rails_helper'
require 'wine_score_parser'

describe 'Wine Score Parser' do
  describe 'parsing one line from file' do
    s = parse_wine_bottle_line('a', 'Canada')
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

  describe 'parsing the bottle info' do
    it 'identifies bought date' do
      b = make_bottles(['Bought Mar 2012'])
      expect(b[0].bought).to eq('Mar 2012') 
    end

    it 'parses cellar info' do
      b = make_bottles('$17. ?/100. From 2014. To 2017. Bought May 2012. In fridge.'.split('.'))[0]

#      p "#{b}"
      expect(b.bought).to eq('May 2012')
      expect(b.drink_from).to eq('2014')
      expect(b.drink_to).to eq('2017')
      expect(b.in_fridge).to eq(true)
      expect(b.price).to eq("17")
    end
  end
end
