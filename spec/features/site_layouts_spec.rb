require 'rails_helper'

RSpec.feature "SiteLayouts" do
  it "moves through the site as it should" do
    visit root_path
    expect(page).to have_link("Home", root_path)
    expect(page).to have_link("Contact", contact_path)
    expect(page).to have_link("Help", help_path)
  end
end
