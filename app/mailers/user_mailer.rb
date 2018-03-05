class UserMailer < ApplicationMailer

  def matches_summary(user, all_matches_hash)
    @user = user
    @all_matches_hash = all_matches_hash
    
    mail(to: @user.email, subject: 'Daily VoIP Matches from Interroute.io')
  end

  def onboard_email(user)
    @user = user
    mail(to: @user.email, subject: 'Welcome onboard!')
  end

end