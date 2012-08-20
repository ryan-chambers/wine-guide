# coding: utf-8

# FIXME - move to model

class Grape
  GRAPES = [
    'Alfrocheiro',
    'Almansa',
    'Amarone',
    'Baco Noir',
    'Barbaresco',
    'Barbera',
    'Barolo',
    'Braucol',
    'Cabernet Franc',
    'Cabernet Sauvignon',
    'Carmenere',
     'Carignan',
     'Cava',
     'Cinsault',
     'Gamay',
     'Grenache',
     'Grenache Noir',
     'Malbec',
     'Merlot',
     'Montepulciano',
     'Mourvedre',
     'Nebbiolo',
     'Nero d\'Avola',
     'Nero di Troia',
     'Negroamaro',
     'Petit Verdot',
     'Petite Sirah',
     'Pinot Noir',
     'Pinotage',
     'Saperavi',
     'Sangiovese',
     'Shiraz',
     'Tempranillo',
     'Tinta Roriz',
     'Touriga Franca',
     'Touriga Nacional',
     'Trincadeira',
     'Zinfandel',
     'Other Red',
     'Albariño',
     'Aligote',
     'Bonarda',
     'Chardonnay',
     'Chenin Blanc',
     'Gewurztraminer',
     'Gruner Veltliner',
     'Pinot Blanc',
     'Pinot Grigio',
     'Riesling',
     'Sauvignon Blanc',
     'Rizling',
    'Semillon',
     'Soave',
     'Torrontes',
     'Vidal',
     'Viura',
     'Verdejo',
     'Vermentino',
     'Rose',
     'White Blend'
  ]

  def self.is_grape?(grape)
    GRAPES.include?(grape)
  end

end
