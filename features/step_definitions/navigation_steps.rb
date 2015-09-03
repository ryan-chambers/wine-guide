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
  expect(page).to have_content('Vineland Estates')
  expect(page).to have_content('Sauvignon Blanc')
  expect(page).to have_content('$19.95')
  expect(page).to have_content('Apr 2012')
  expect(page).to have_content('Cave Springs')
  expect(page).to have_content('I Mocali')
  expect(page).to have_content('May 2013')
end

Then /I should see the country report/ do
  expect(page).to have_content('Canada')
  expect(page).to have_content('86.5')
  expect(page).to have_content('17.45')
  expect(page).to have_content('USA')
end

Then /I should see the yearly report/ do
  expect(page).to have_content('88.0')
  expect(page).to have_content('89.5')
  expect(page).to have_content('2')
end

Then /I should see the ready\-to\-drink report/ do
  expect(page).to_not have_content('Vineland Estates')
  expect(page).to have_content('I Mocali')
end

Then /I should see the search results for Vineland/ do
  expect(page).to have_content('Vineland Estates')
  expect(page).to_not have_content('I Mocali')
end

Then /I should see the search results for Alvento/ do
  expect(page).to have_content('Alvento')
  expect(page).to_not have_content('I Mocali')
end

Then /I should see the search results for Vernaccia/ do
  expect(page).to have_content('Vernaccia')
  expect(page).to_not have_content('Sauvignon Blanc')
end

Then /I should see the search results for Canada/ do
  expect(page).to have_content('Sauvignon Blanc') # from Canadian wine
  expect(page).to_not have_content('Vernaccia') # from Italian wine
end

Then /I should see the this day in wine report/ do
  expect(page).to have_content('Alvento')
end

Then /I should see the favourite wines report/ do
  expect(page).to_not have_content('Alvento')
  expect(page).to_not have_content('86')
  expect(page).to have_content('Kenwood')
  expect(page).to have_content('93')
end
