# coding: utf-8

# FIXME - move to model

class Country
  attr_reader :name
  attr_reader :regions

  def initialize(name, regions)
    @name = name
    @regions = regions || []
  end

  ARGENTINA = Country.new('Argentina', ['Mendoza'])
  AUSTRALIA = Country.new('Australia', ['McLaren Vale', 'Western Australia'])
  AUSTRIA = Country.new('Austria', [])

  COUNTRIES = {
    ARGENTINA.name => ARGENTINA,
    AUSTRALIA.name => AUSTRALIA,
    AUSTRIA.name => AUSTRIA
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
