require File.expand_path(File.join(File.dirname(__FILE__), "..", "support", "paths"))

Given /^some bottles of wine in the cellar$/ do
  FactoryGirl.create(:bottle_in_cellar_later)
  FactoryGirl.create(:bottle_in_cellar_sooner)
  FactoryGirl.create(:bottle_in_cellar_now)
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
  page.should have_content('$19.95')
  page.should have_content('Apr 2012')
  page.should have_content('Cave Springs')
  page.should have_content('I Mocali')
  page.should have_content('May 2013')
end

Then /I should see the ready\-to\-drink report/ do
  page.should have_content('Cave Springs')
  page.should_not have_content('Vineland Estates')
  page.should have_content('I Mocali')
end
