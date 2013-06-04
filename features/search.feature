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

	Scenario: Filter by grape
		Given some bottles of wine in the cellar
		And I am on the home page
		And I fill in "grape_filter" with "Vernaccia"
		When I submit the form "grape_filter_form"
		Then I should see the search results for Vernaccia
