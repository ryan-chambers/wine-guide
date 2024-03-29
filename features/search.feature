Feature: Search for wines
	In order to search
	A visitor
	Should view the home page
	Enter a search term
	See search results

	Scenario: Search by winery name
		Given some bottles of wine in the cellar
		And I am on the home page
		And I fill in "term" with "Vineland"
		When I press "Search"
		Then I should see the search results for Vineland

	Scenario: See winery page
		Given some bottles of wine in the cellar
		And I am on the home page
		When I click "Vineland"
		Then I should see the winery report for Vineland

	Scenario: Search by LCBO code
		Given some wine reviews
		And I am on the home page
		And I fill in "term" with "123456"
		When I press "Search"
		Then I should see the search results for Alvento

	Scenario: Filter by country
		Given some bottles of wine in the cellar
		And I am on the home page
		And I select "Canada" in "country_filter"
		When I press "Filter"
		Then I should see the search results for Canada
