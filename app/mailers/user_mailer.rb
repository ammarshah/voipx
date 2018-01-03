class UserMailer < ApplicationMailer

  def matches_summary(user, all_matches_hash)
    @user = user
    @all_matches_hash = all_matches_hash
    
    mail(to: @user.email, subject: 'Your daily matches summary')
  end

end