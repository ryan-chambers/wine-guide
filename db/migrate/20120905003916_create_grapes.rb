class CreateGrapes < ActiveRecord::Migration
  def up
    create_table :grapes do |t|
      t.string :name

      t.timestamps
    end

    Grape.create :name => 'Alfrocheiro'
    Grape.create :name => 'Almansa'
    Grape.create :name => 'Amarone'
    Grape.create :name => 'Baco Noir'
    Grape.create :name => 'Barbaresco'
    Grape.create :name => 'Barbera'
    Grape.create :name => 'Barolo'
    Grape.create :name => 'Braucol'
    Grape.create :name => 'Cabernet Franc'
    Grape.create :name => 'Cabernet Sauvignon'
    Grape.create :name => 'Carmenere'
    Grape.create :name =>  'Carignan'
    Grape.create :name =>  'Cava'
    Grape.create :name =>  'Cinsault'
    Grape.create :name =>  'Gamay'
    Grape.create :name =>  'Grenache'
    Grape.create :name =>  'Grenache Noir'
    Grape.create :name =>  'Malbec'
    Grape.create :name =>  'Merlot'
    Grape.create :name =>  'Montepulciano'
    Grape.create :name =>  'Mourvedre'
    Grape.create :name =>  'Nebbiolo'
    Grape.create :name =>  'Nero d\'Avola'
    Grape.create :name =>  'Nero di Troia'
    Grape.create :name =>  'Negroamaro'
    Grape.create :name =>  'Petit Verdot'
    Grape.create :name =>  'Petite Sirah'
    Grape.create :name =>  'Pinot Noir'
    Grape.create :name =>  'Pinotage'
    Grape.create :name =>  'Saperavi'
    Grape.create :name =>  'Sangiovese'
    Grape.create :name =>  'Syrah'
    Grape.create :name =>  'Tempranillo'
    Grape.create :name =>  'Tinta Roriz'
    Grape.create :name =>  'Touriga Franca'
    Grape.create :name =>  'Touriga Nacional'
    Grape.create :name =>  'Trincadeira'
    Grape.create :name =>  'Zinfandel'
    Grape.create :name =>  'Other Red'
    Grape.create :name =>  'Albarino'
    Grape.create :name =>  'Aligote'
    Grape.create :name =>  'Bonarda'
    Grape.create :name =>  'Chardonnay'
    Grape.create :name =>  'Chenin Blanc'
    Grape.create :name =>  'Gewurztraminer'
    Grape.create :name =>  'Gruner Veltliner'
    Grape.create :name =>  'Pinot Blanc'
    Grape.create :name =>  'Pinot Grigio'
    Grape.create :name =>  'Riesling'
    Grape.create :name =>  'Sauvignon Blanc'
    Grape.create :name =>  'Rizling'
    Grape.create :name => 'Semillon'
    Grape.create :name =>  'Soave'
    Grape.create :name =>  'Torrontes'
    Grape.create :name =>  'Vidal'
    Grape.create :name =>  'Viura'
    Grape.create :name =>  'Verdejo'
    Grape.create :name =>  'Vermentino'
    Grape.create :name =>  'Rose'
    Grape.create :name =>  'White Blend'

  end

  def down
    drop_table :grapes
  end
end