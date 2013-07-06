require 'spec_helper'
require 'wine_score_exporter'

describe 'Wine Score Exporter' do
  before do
    @fixture = WineScoreExporter.new
  end

  describe 'it turns database records into sentences' do
    it 'turns a bottle into a sentence' do
      b = create(:bottle_drank)
      sentence = @fixture.create_wine_bottle_sentence(b)
#      puts "#{sentence}"
      expect(sentence).to include('86/100.')
      expect(sentence).to include('$19.95.')
      expect(sentence).to include('Okay.')
      t = Date.today.strftime('%d %b %Y')
      expect(sentence).to include("[#{t}]")
    end

    it 'turns a bottle in the fridge into a sentence' do
      b = create(:bottle_in_cellar_now)
      sentence = @fixture.create_wine_bottle_sentence(b)
#      puts "#{sentence}"
      expect(sentence).to include('$19.95.')
      expect(sentence).to include('From 20')
      expect(sentence).to include('To 20')
      expect(sentence).to include('In fridge')
    end

    it 'turns a wine and winery into a sentence' do
      wine = create(:wine_with_grapes_a)
      sentence = @fixture.create_wine_sentence(wine, wine.winery)
#      puts "#{sentence}"
      expect(sentence).to include(wine.winery.name)
      expect(sentence).to include(wine.grapes[0].name)
      expect(sentence).to include(wine.other)
      expect(sentence).to include(wine.region)
      expect(sentence).to include(wine.year.to_s)
      expect(sentence).to include(wine.lcbo_code)
    end
  end
end
