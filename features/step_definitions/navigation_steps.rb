require File.expand_path(File.join(File.dirname(__FILE__), "..", "support", "paths"))

Given /^some bottles of wine in the cellar$/ do
  FactoryGirl.create(:bottle_in_cellar_later)
  FactoryGirl.create(:bottle_in_cellar_sooner)
  FactoryGirl.create(:bottle_in_cellar_now)
end

Given /^some wine reviews$/ do
  FactoryGirl.create(:bottle_drank)
  FactoryGirl.create(:bottle_drank_2)
  FactoryGirl.create(:bottle_drank_3)
end

Given /^I am on (.+)$/ do | page_name |
  visit path_to (page_name)
end

When /^I click "([^\"]*)"$/ do |link|
  click_link(link)
end

When /^I fill in "([^\"]*)" with "([^\"]*)"$/ do |field, value|
  fill_in(field.gsub(' ', '_'), :with => value)
end

When /^I press "([^\"]*)"$/ do |button|
  click_button(button)
end

When /^I submit the form "([^\"]*)"$/ do |form_id|
    element = find_by_id(form_id)
    Capybara::RackTest::Form.new(page.driver, element.native).submit :name => nil
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

Then /I should see the country report/ do
  page.should have_content('Canada')
  page.should have_content('86.5')
  page.should have_content('17.45')
  page.should have_content('USA')
end

Then /I should see the ready\-to\-drink report/ do
  page.should have_content('Cave Springs')
  page.should_not have_content('Vineland Estates')
  page.should have_content('I Mocali')
end

Then /I should see the search results for Vineland/ do
  page.should have_content('Vineland Estates')
  page.should_not have_content('I Mocali')
end

Then /I should see the search results for Vernaccia/ do
  page.should have_content('Vernaccia')
  page.should_not have_content('Sauvignon Blanc')
end

Then /I should see the this day in wine report/ do
  page.should have_content('Cave Springs')
end
