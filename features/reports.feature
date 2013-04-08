Feature: Cellar Report
	In order to see the list of wines in the cellar
	A visitor
	Should view the cellar report page

	Scenario: Shows the cellar reports page
		Given I am on the home page
		When I click the cellar reports link
		Then I should see the cellar report page
