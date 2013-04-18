Feature: Cellar Report
	In order to see the list of wines in the cellar
	A visitor
	Should view the cellar report page

	Scenario: Shows the cellar reports page
		Given some bottles of wine in the cellar
		Given I am on the home page
		When I click "Cellar"
		Then I should see the cellar report
