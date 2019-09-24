class UserMailerPreview < ActionMailer::Preview
  def recipe_email
    UserMailer.with(email: 'foo@example.com').recipe_email
  end
end
