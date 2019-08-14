require 'rails_helper'

describe 'email', type: :feature do
  describe 'new' do
    let(:email_address) { 'user@example.com' }

    it 'has functional signup form' do
      visit new_email_path
      fill_in 'Email', with: email_address
      click_button 'Create Email'
      expect(page).to have_content("Thank you for signing up. You will receive daily recipes at #{email_address}")
    end
  end
end
