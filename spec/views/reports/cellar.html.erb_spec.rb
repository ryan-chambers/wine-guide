require "spec_helper"

describe "/reports/cellar" do
  it "shows all relevant fields for the cellar report" do
    s1 = create(:score_in_cellar)
    assign(:wines, [s1.wine])
    
    render
    
    logger.info("#{rendered.to_s}")
    
    expect(rendered).to include(s1.wine.winery.name)
    expect(rendered).to include(s1.wine.other)
    expect(rendered).to include(s1.wine.country)
    expect(rendered).to include(s1.wine.grapes[0].name)
    expect(rendered).to include(s1.price.to_s)
    expect(rendered).to include(s1.wine.year.to_s)
    expect(rendered).to include(s1.from.to_s) 
    expect(rendered).to include(s1.to.to_s) 
  end
end
