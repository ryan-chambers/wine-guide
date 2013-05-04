Feature: Cellar Report
	In order to see the list of wines in the cellar
	A visitor
	Should view the cellar report page

	Scenario: Shows the cellar reports page
		Given some bottles of wine in the cellar
		And I am on the home page
		When I click "Cellar"
		Then I should see the cellar report

	Scenario: Shows the ready-to-drink reports page
		Given some bottles of wine in the cellar
		And I am on the home page
		And I click "Cellar"
		When I click "Ready to Drink"
		Then I should see the ready-to-drink report