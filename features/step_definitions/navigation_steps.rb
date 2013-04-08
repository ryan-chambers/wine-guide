require File.expand_path(File.join(File.dirname(__FILE__), "..", "support", "paths"))

Given /^I am on (.+)$/ do | page_name |
  visit path_to (page_name)
end

When /I click the cellar reports link/ do
  # FIXME implement
end

Then /I should see the cellar report page/ do
  # FIXME implement
end
