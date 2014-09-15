# coding: utf-8

class Country
  attr_reader :name
  attr_reader :regions

  COUNTRIES = {}
  COUNTRY_LIST = []

  def initialize(name, regions = [])
    @name = name
    @regions = regions.sort!
    COUNTRIES.store(name, self)
    COUNTRY_LIST << name
  end

  ARGENTINA = Country.new('Argentina', ['Mendoza', 'Calchaquies Valley', 'San Juan'])
  AUSTRALIA = Country.new('Australia', ['McLaren Vale', 'Western Australia', 'Margaret River', 'Barossa Valley', 'Clare Valley',
    'South Australia', 'Southeast Australia'])
  AUSTRIA = Country.new('Austria', ['Burgenland'])
  BRAZIL = Country.new('Brazil')
  BULGARIA = Country.new('Bulgaria')
  CANADA = Country.new('Canada', ['VQA Beamsville Bench', 'VQA British Columbia', 'VQA Niagara', 'VQA Niagara Peninsula', 'VQA Niagara On The Lake', 
      'VQA Okanagan Valley', 'VQA Niagara River', 'VQA Creek Shores', 'VQA Lake Erie North Shore', 'VQA Lincoln Lakeshore', 'VQA Prince Edward County'])
  CHILE = Country.new('Chile', ['Rapel Valley', 'Lolol Valley', 'Casablanca Valley', 'Limari Valley', 'Central Valley',
    'Colchagua Valley', 'Maipo Valley', 'Elqui Valley'])
  CROATIA = Country.new('Croatia', ['Kalnik'])
  CYPRUS = Country.new('Cyprus')
  FRANCE = Country.new('France', [
      # Bordeaux
      'Bordeaux', 'Ac Bordeaux Supérieur', 'Ac Cotes de Bordeaux', 
        # Medoc
        'Ac Médoc', 'Ac Haut-Médoc', 'Ac Listrac', 'Ac Saint Estèphe', 'Ac Pauillac', 'Ac Saint Julien', 'Ac Margaux', 'Ac Moulis', 
        # Graves
        'Ac Graves',
        # Pomerol
        'Ac Pomerol', 'Ac Lalande De Pomerol', 
        # St Emilion
        'Ac Montagne St Emilion', 'Ac Lussac St Emillion', 
      # Burgundy  
      'Ac Burgundy', 'Ac Beaujolais', 'Burgundy', 'Beaujolais Villages', 
      # Rhone
      'Ac Beaumes de Venise', 'Chateauneuf-du-Pape', 'Ac Côtes Du Rhône', 'Ac Rhone', 'Côtes Du Rhône Villages', 'Ac Cotes du Ventoux', 
      # the rest
      'Ac L\'Andeol Rasteau', 'Ac Alsace', 'Ac Bandol', 'Ac Corbieres', 'Ac Côtes De Castillon', 'Ac Cotes du Rousillon Villages', 'Ac Faugeres', 'Ac Fronsac', 
      'Ac Gaillac', 'Ac Julienas',
      'Ac Languedoc', 'Ac Languedoc Roussillon', 'Ac Loire', 'Ac Minervois',  
      'Pays D\'oc', 'Ac Premieres Cotes de Blaye', 
      'Ac Saumur', 'Ac Savoie', 'Ac St Nicolas de Bourgueil', 
      'Ac Rose D\'anjou'])
  GEORGIA = Country.new('Georgia')
  GERMANY = Country.new('Germany')
  GREECE = Country.new('Greece')
  HUNGARY = Country.new('Hungary')
  ITALY = Country.new('Italy', ['Abruzzo', 'Barolo', 'Barbaresco', 'Brunello di Montalcino', 'Rosso di Montalcino', 'Calabria', 'Docg Tuscany', 'Tuscany', 'Piedmont',
      'Doc Sicily', 'Sicily', 'Veneto', 'Igt Veneto', 'Igt Delle Venezie', 'Doc Vernaiolo', 'Doc Valdadige',
      'Igt Sicilia', 'Igt Toscana', 'Doc Piedmont', 'Vino Nobile Di Montepulciano', 'Doc Chianti', 'Doc Gioia del Colle',
      'Doc Abruzzo', 'Doc Veneto', 'Doc Puglia', 'Igt Campania', 'Igt Veronese', 'Valpolicella'])
  LEBANON = Country.new('Lebanon', ['Bekaa Valley'])
  MACEDONIA = Country.new('Macedonia')
  MOLDOVA = Country.new('Moldova')
  MEXICO = Country.new('Mexico')
  NEW_ZEALAND = Country.new('New Zealand', ['South Island'])
  PORTUGAL = Country.new('Portugal', ['Douro DOC', 'DOC Dao', 'DAO Sul', 'Doc Bairrada'])
  ROMANIA = Country.new('Romania')
  SERBIA = Country.new('Serbia')
  SLOVENIA = Country.new('Slovenia')
  SOUTH_AFRICA = Country.new('South Africa', ['WO Coastal Region', 'WO Western Region', 'WO Western Cape', 'WO Stellenbosch'])
  SPAIN = Country.new('Spain', ['Do Almansa', 'Doca Rioja', 'Rueda DO', 'Doc Navarra', 'Do Toro'])
  TURKEY = Country.new('Turkey')
  SWITZERLAND = Country.new('Switzerland')
  USA = Country.new('USA', ['Sonoma', 'Mendocino', 'Willamette Valley', 'Monterey', 'Central Valley',
      'Paso Robles', 'Napa'])

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
