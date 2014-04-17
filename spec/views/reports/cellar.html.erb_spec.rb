require "spec_helper"

describe "/reports/cellar" do
  it "shows all relevant fields for the cellar report" do
    b1 = create(:vineland_sauvignonblanc_bottle_in_cellar_later)
    assign(:wines, [b1.wine])

    render

#    logger.info("#{rendered.to_s}")

    expect(rendered).to include(b1.wine.winery.name)
    expect(rendered).to include(b1.wine.other)
    expect(rendered).to include(b1.wine.country)
    expect(rendered).to include(b1.wine.grapes[0].name)
    expect(rendered).to include(b1.price.to_s)
    expect(rendered).to include(b1.bought)
    expect(rendered).to include(b1.wine.year.to_s)
    expect(rendered).to include(b1.drink_from.to_s) 
    expect(rendered).to include(b1.drink_to.to_s) 
  end
end
