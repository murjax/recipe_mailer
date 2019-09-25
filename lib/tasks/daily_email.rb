namespace :daily_email do
  desc 'Send daily recipe email'

  task :send => :environment do
    Email.find_each do |email|
      UserMailer.with(email: email).recipe_email.deliver_now
    end
  end
end
