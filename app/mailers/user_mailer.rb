class UserMailer < ApplicationMailer
  def recipe_email
    while !@recipe do
      @recipe = RecipeGenerator.new.generate.first
    end
    mail(to: params[:email], subject: 'Your daily recipe')
  end
end
