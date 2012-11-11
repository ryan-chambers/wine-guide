# coding: utf-8

class Country
  attr_reader :name
  attr_reader :regions

  def initialize(name, regions = [])
    @name = name
    @regions = regions
  end

  ARGENTINA = Country.new('Argentina', ['Mendoza', 'Calchaquies Valley', 'San Juan'])
  AUSTRALIA = Country.new('Australia', ['McLaren Vale', 'Western Australia', 'Margaret River', 'Barossa Valley', 'Clare Valley',
    'South Australia'])
  AUSTRIA = Country.new('Austria', ['Burgenland'])
  BULGARIA = Country.new('Bulgaria')
  CANADA = Country.new('Canada', ['VQA Niagara', 'VQA Niagara Peninsula', 'VQA Niagara On The Lake', 
      'VQA Okanagan Valley', 'VQA Niagara River', 'VQA Creek Shores', 'VQA Lake Erie North Shore'])
  CHILE = Country.new('Chile', ['Rapel Valley', 'Lolol Valley', 'Casablanca Valley', 'Limari Valley', 'Central Valley',
    'Colchagua Valley', 'Maipo Valley', 'Elqui Valley'])
  CYPRUS = Country.new('Cyprus')
  FRANCE = Country.new('France')
  GEORGIA = Country.new('Georgia')
  GERMANY = Country.new('Germany')
  GREECE = Country.new('Greece')
  ITALY = Country.new('Italy')
  LEBANON = Country.new('Lebanon')
  MACEDONIA = Country.new('Macedonia')
  MOLDOVA = Country.new('Moldova')
  MEXICO = Country.new('Mexico')
  NEW_ZEALAND = Country.new('New Zealand')
  PORTUGAL = Country.new('Portugal')
  ROMANIA = Country.new('Romania')
  SERBIA = Country.new('Serbia')
  SLOVENIA = Country.new('Slovenia')
  SOUTH_AFRICA = Country.new('South Africa')
  SPAIN = Country.new('Spain')
  TURKEY = Country.new('Turkey')
  USA = Country.new('USA')

  COUNTRIES = {
    ARGENTINA.name => ARGENTINA,
    AUSTRALIA.name => AUSTRALIA,
    AUSTRIA.name => AUSTRIA,
    BULGARIA.name => BULGARIA,
    CANADA.name => CANADA,
    CHILE.name => CHILE,
    CYPRUS.name => CYPRUS,
    FRANCE.name => FRANCE,
    GEORGIA.name => GEORGIA,
    GERMANY.name => GERMANY,
    GREECE.name => GREECE,
    ITALY.name => ITALY,
    LEBANON.name => LEBANON,
    MACEDONIA.name => MACEDONIA,
    MOLDOVA.name => MOLDOVA,
    MEXICO.name => MEXICO,
    NEW_ZEALAND.name => NEW_ZEALAND,
    PORTUGAL.name => PORTUGAL,
    ROMANIA.name => ROMANIA,
    SERBIA.name => SERBIA,
    SLOVENIA.name => SLOVENIA,
    SOUTH_AFRICA.name => SOUTH_AFRICA,
    SPAIN.name => SPAIN,
    TURKEY.name => TURKEY,
    USA.name => USA,
  }

  def self.is_country?(country)
    COUNTRIES.has_key?(country)
  end

end

class Region
  def self.is_region?(country, region)
    if Country::is_country?(country)
      Country::COUNTRIES[country].regions.include?(region)
    else
      false
    end
  end
end
