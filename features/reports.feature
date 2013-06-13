Feature: Cellar Report
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

	Scenario: Shows the country reports page
		Given some wine reviews
		And I am on the home page
		When I click "Country"
		Then I should see the country report

	Scenario: Shows the this day in wine report
		Given some wine reviews
		And I am on the home page
		When I click "This Day in Wine"
		Then I should see the this day in wine report

	Scenario: Shows the favourite wines report
		Given some wine reviews
		And I am on the home page
		When I click "Favourite Wines"
		Then I should see the favourite wines report
