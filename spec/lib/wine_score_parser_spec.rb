# coding: utf-8

require 'rails_helper'
require 'wine_score_parser'

describe 'Wine Score Parser' do
  describe 'parsing one line from file' do
    s = parse_wine_bottle_line('a', 'Canada')
  end

  describe '#parse_wine_bottle_line' do
    it 'should parse wine and bottle' do
      wb = parse_wine_bottle_line('Creekside, Syrah, 2015, Broken Press, VQA St Davids Bench. $55.0. 92/100. Outstanding leg of lamb wine.. Bought Dec 2017. From 2018. To 2026. [21 Jun 2020].', 'Canada')
#      p "#{wb.to_s}"
      bottle1 = wb[:bottles][0];
#      expect(bottle1.comments).to eq('Outstanding leg of lamb wine')
      expect(bottle1.date).to eq('21 Jun 2020')
      expect(bottle1.price).to eq('55')
      expect(bottle1.score).to eq(92)
      expect(bottle1.drink_from).to eq('2018')
      expect(bottle1.drink_to).to eq('2026')
      expect(bottle1.bought).to eq('Dec 2017')
    end

    # two bottles
    # in cellar; no from, to
    # in cellar; from, to
  end

  describe '#make_wine' do
    it 'parses the wine' do
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

  describe '#make_bottles' do
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
