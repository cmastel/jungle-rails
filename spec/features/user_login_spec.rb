require 'rails_helper'

RSpec.feature "Visitor Login", type: :feature, js: true do

  # SETUP
  before :each do

    @user = User.create(
      name: 'Test User',
      email: 'user@email.com',
      password: 'password',
      password_confirmation: 'password')
  end

  scenario "They can log in" do
    # ACT
    visit root_path
    # puts page.html
    page.find_link('Login').click
    fill_in 'email', with: 'user@email.com'
    fill_in 'password', with: 'password'
    page.find_button('Submit').click

    # DEBUG
    save_screenshot
    
    # VERIFY
    expect(page).to have_text "Logout"
  end
end