require File.expand_path(File.join(File.dirname(__FILE__), "..", "support", "paths"))

Given /^some bottles of wine in the cellar$/ do
  FactoryGirl.create(:bottle_in_cellar)
end

Given /^I am on (.+)$/ do | page_name |
  visit path_to (page_name)
end

When /^I click "([^\"]*)"$/ do |link|
  click_link(link)
end

Then /I should see the cellar report/ do
  page.should have_content('Vineland Estates')
  page.should have_content('Sauvignon Blanc')
  page.should have_content('2011')
  page.should have_content('$19.95')
  page.should have_content('2014')
  page.should have_content('2017')
  page.should have_content('Apr 2012')
end
