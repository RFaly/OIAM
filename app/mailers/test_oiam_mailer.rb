class TestOiamMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  # ▶ rails generate mailer TestOiamMailer test_fit_accepted test_fit_refused
  #   en.test_oiam_mailer.test_fit_accepted.subject
  #
  def test_fit_accepted
    @greeting = "Hi"
    mail to: "ramahafaly2.0@gmail.com"
  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.test_oiam_mailer.test_fit_refused.subject
  #
  def test_fit_refused
    @greeting = "Hi"
    mail to: "ramahafaly2.0@gmail.com"
  end
  #TestOiamMailer.test_fit_accepted.deliver_now
end
