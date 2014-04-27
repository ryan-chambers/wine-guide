require File.expand_path(File.join(File.dirname(__FILE__), "..", "support", "paths"))

Given /^some bottles of wine in the cellar$/ do
  FactoryGirl.create(:vineland_sauvignonblanc_bottle_in_cellar_later)
  FactoryGirl.create(:cavesprings_sauvignonblanc_bottle_in_cellar_sooner)
  FactoryGirl.create(:imocali_vernaccia_bottle_now)
end

Given /^some wine reviews$/ do
  FactoryGirl.create(:alvento_sauvignonblanc_bottle_drank)
  FactoryGirl.create(:kenwood_merlot_drank)
  FactoryGirl.create(:vineland_sauvignonblanc_drank)
end

Given /^some wine reviews over the years$/ do
  FactoryGirl.create(:alvento_sauvignonblanc_bottle_drank)
  FactoryGirl.create(:kenwood_merlot_drank)
  FactoryGirl.create(:imocali_vernaccia_bottle_drank_last_year)
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

When /^I select "([^\"]*)" in "([^\"]*)"$/ do |value, field|
  select(value, :from => field)
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

Then /I should see the yearly report/ do
  page.should have_content('88.0')
  page.should have_content('89.5')
  page.should have_content('2')
end

Then /I should see the ready\-to\-drink report/ do
  page.should_not have_content('Vineland Estates')
  page.should have_content('I Mocali')
end

Then /I should see the search results for Vineland/ do
  page.should have_content('Vineland Estates')
  page.should_not have_content('I Mocali')
end

Then /I should see the search results for Alvento/ do
  page.should have_content('Alvento')
  page.should_not have_content('I Mocali')
end

Then /I should see the search results for Vernaccia/ do
  page.should have_content('Vernaccia')
  page.should_not have_content('Sauvignon Blanc')
end

Then /I should see the search results for Canada/ do
  page.should have_content('Sauvignon Blanc') # from Canadian wine
  page.should_not have_content('Vernaccia') # from Italian wine
end

Then /I should see the this day in wine report/ do
  page.should have_content('Alvento')
end

Then /I should see the favourite wines report/ do
  page.should_not have_content('Alvento')
  page.should_not have_content('86')
  page.should have_content('Kenwood')
  page.should have_content('93')
end
