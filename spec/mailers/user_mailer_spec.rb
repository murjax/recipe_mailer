require "rails_helper"

RSpec.describe UserMailer, type: :mailer do
  describe '#recipe_email' do
    let(:email) { 'foo@example.com' }
    let(:recipe) { OpenStruct.new(title: 'Fried Chicken', source_url: 'https://google.com') }

    before do
      expect_any_instance_of(RecipeGenerator).to receive(:generate).and_return([recipe])
    end

    it 'generates random recipe email' do
      described_class.with(email: email).recipe_email.deliver_now
      mail = ActionMailer::Base.deliveries.last
      expect(mail.subject).to eq('Your daily recipe')
      expect(mail.body).to include(recipe.title)
      expect(mail.body).to include(recipe.source_url)
    end
  end
end
