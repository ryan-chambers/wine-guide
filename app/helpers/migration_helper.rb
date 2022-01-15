module MigrationHelper
  @@red_grapes = [
    "Agiorgitiko",
    "Aglianico",
    "Alfrocheiro",
    "Baco Noir",
    "Barbera",
    "Bonarda",
    "Cabernet Franc",
    "Cabernet Sauvignon",
    "Carignan",
    "Carmenere",
    "Cinsault",
    "Dolcetto",
    "Gamay",
    "Grenache",
    "Malbec",
    "Marsanne",
    "Mencia",
    "Merlot",
    "Montepulciano",
    "Mourvedre",
    "Nebbiolo",
    "Negroamaro",
    "Nerello Cappuccio",
    "Nerello Mascalese",
    "Nero D'Avola",
    "Nero Di Troia",
    "Other Red",
    "Petite Syrah",
    "Petit Verdot",
    "Pinotage",
    "Pinot Noir",
    "Primitivo",
    "Red Blend",
    "Roussanne",
    "Sangiovese",
    "Saperavi",
    "Syrah",
    "Tannat",
    "Tempranillo",
    "Touriga Franca",
    "Touriga Nacional",
    "Trincadeira",
    "Xinomavro",
    "Zweigelt",
  ]

  def grape_name(grapes)
    if grapes.length == 1
      grapes[0]
    elsif @@red_grapes.include? grapes[0]
      return 'Red Blend'
    else
      return 'White Blend'
    end
  end
end
