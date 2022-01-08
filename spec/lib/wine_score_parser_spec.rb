# coding: utf-8

require 'rails_helper'
require 'wine_score_parser'

describe 'Wine Score Parser' do
  describe 'parsing one line from file' do
    s = parse_wine_bottle_line('a', 'Canada')
  end

  describe '#parse_wine_bottle_line' do
    it 'should parse wine with finished bottle that has to, from' do
      wb = parse_wine_bottle_line('Creekside, Syrah, 2015, Broken Press, VQA St Davids Bench. $55.0. 92/100. Outstanding leg of lamb wine.. Bought Dec 2017. From 2018. To 2026. [21 Jun 2020].', 'Canada')
#      p "#{wb.to_s}"

      wine = wb[:wine]
      expect(wine.country).to eq('Canada')
      expect(wine.region).to eq('VQA St Davids Bench')
      expect(wine.winery_name).to eq('Creekside')
      expect(wine.year).to eq('2015')

      # because of no db connection, can't query DB for syrah grape
      expect(wine.other).to eq(['Syrah', 'Broken Press'])
      expect(wine.grapes).to eq([])

      bottles = wb[:bottles]
      expect(bottles.length).to be(1)
      bottle1 = bottles[0];
      expect(bottle1.in_fridge).to eq(false)
      expect(bottle1.comments).to eq(['Outstanding leg of lamb wine'])
      expect(bottle1.date).to eq('21 Jun 2020')
      expect(bottle1.price).to eq('55.0')
      expect(bottle1.score).to eq(92)
      expect(bottle1.drink_from).to eq('2018')
      expect(bottle1.drink_to).to eq('2026')
      expect(bottle1.bought).to eq('Dec 2017')
    end

    it 'should parse wine with finished bottle and no from, to' do
      wb = parse_wine_bottle_line('Matchbook, Cabernet Sauvignon, 2019, Dunnigan Hills, LCBO# 478743. $19.95. 87/100. Pretty good steak wine.. Bought . [12 Jun 2021].', 'USA')
#      p "#{wb.to_s}"

      wine = wb[:wine]
      expect(wine.country).to eq('USA')
      expect(wine.region).to eq('')
      expect(wine.winery_name).to eq('Matchbook')
      expect(wine.year).to eq('2019')
      expect(wine.other).to eq(['Cabernet Sauvignon', 'Dunnigan Hills'])
      expect(wine.lcbo).to eq('478743')

      bottles = wb[:bottles]
      expect(bottles.length).to be(1)
      bottle1 = bottles[0];
      expect(bottle1.in_fridge).to eq(false)
      expect(bottle1.comments).to eq(['Pretty good steak wine'])
      expect(bottle1.date).to eq('12 Jun 2021')
      expect(bottle1.price).to eq('19.95')
      expect(bottle1.score).to eq(87)
      expect(bottle1.drink_from).to be_nil()
      expect(bottle1.drink_to).to be_nil()
      expect(bottle1.bought).to be_nil()
    end

    it 'should parse wine with multiple bottles' do
      wb = parse_wine_bottle_line('M Chapoutier, Grenache, Syrah, 2017, Mathilde, Ap Languedoc, LCBO# 644468. $14.95. 88/100. Good. . Bought . [13 Oct 2020]. $14.95. 88/100. Reliably good.. Bought . [27 Oct 2020].', 'France')

      wine = wb[:wine]
      expect(wine.country).to eq('France')
      expect(wine.region).to eq('Ap Languedoc')
      expect(wine.winery_name).to eq('M Chapoutier')
      expect(wine.year).to eq('2017')
      # TODO should be red blend
      expect(wine.other).to eq(['Grenache', 'Syrah', 'Mathilde'])
      expect(wine.lcbo).to eq('644468')

      bottles = wb[:bottles]
      expect(bottles.length).to be(2)
      bottle1 = bottles[0];
      expect(bottle1.in_fridge).to eq(false)
      expect(bottle1.comments).to eq(['Good'])
      expect(bottle1.date).to eq('13 Oct 2020')
      expect(bottle1.price).to eq('14.95')
      expect(bottle1.score).to eq(88)

      bottle2 = bottles[1];
      expect(bottle2.in_fridge).to eq(false)
      expect(bottle2.comments).to eq(['Reliably good'])
      expect(bottle2.date).to eq('27 Oct 2020')
      expect(bottle2.price).to eq('14.95')
      expect(bottle2.score).to eq(88)
    end

    it 'should parse wine in cellar with no from, to' do
      wb = parse_wine_bottle_line('Leaning Post, Chardonnay, 2018, Wismer - Foxcroft Vineyard, VQA Twenty Mile Bench. $40.0. 0/100. . Bought Jul 2021. To 2025. In fridge.', 'Canada')
#      p "#{wb.to_s}"

      wine = wb[:wine]
      expect(wine.country).to eq('Canada')
      expect(wine.region).to eq('VQA Twenty Mile Bench')
      expect(wine.winery_name).to eq('Leaning Post')
      expect(wine.year).to eq('2018')
      expect(wine.other).to eq(['Chardonnay', 'Wismer - Foxcroft Vineyard'])

      bottles = wb[:bottles]
      expect(bottles.length).to be(1)
      bottle1 = bottles[0];
      expect(bottle1.in_fridge).to eq(true)
      expect(bottle1.comments).to eq([])
      expect(bottle1.date).to be_nil()
      expect(bottle1.price).to eq('40.0')
      expect(bottle1.score).to eq(0)
      expect(bottle1.drink_from).to be_nil()
      expect(bottle1.drink_to).to eq('2025')
      expect(bottle1.bought).to eq('Jul 2021')
    end

    it 'should parse migrated wines' do
      wb = parse_wine_bottle_line('Ryan, Other Red, 2020, test, Melbourne. $19.0. 0/100. . Bought . In fridge.', 'Australia')
      p "#{wb.to_s}"

      wine = wb[:wine]
      expect(wine.country).to eq('Australia')
      expect(wine.winery_name).to eq('Ryan')
      expect(wine.year).to eq('2020')
      expect(wine.other).to eq(['Other Red', 'test', 'Melbourne'])

      bottles = wb[:bottles]
      expect(bottles.length).to be(1)
      bottle1 = bottles[0];
      expect(bottle1.in_fridge).to eq(true)
      expect(bottle1.comments).to eq([])
      expect(bottle1.date).to be_nil()
      expect(bottle1.price).to eq('19.0')
      expect(bottle1.score).to eq(0)
      expect(bottle1.drink_from).to be_nil()
    end
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
