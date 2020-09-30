# Preview all emails at http://localhost:3000/rails/mailers/test_oiam_mailer
class TestOiamMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/test_oiam_mailer/test_fit_accepted
  def test_fit_accepted
    TestOiamMailer.test_fit_accepted
  end

  # Preview this email at http://localhost:3000/rails/mailers/test_oiam_mailer/test_fit_refused
  def test_fit_refused
    TestOiamMailer.test_fit_refused
  end

end
