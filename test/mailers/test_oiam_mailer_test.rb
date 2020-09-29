require 'test_helper'

class TestOiamMailerTest < ActionMailer::TestCase
  test "test_fit_accepted" do
    mail = TestOiamMailer.test_fit_accepted
    assert_equal "Test fit accepted", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

  test "test_fit_refused" do
    mail = TestOiamMailer.test_fit_refused
    assert_equal "Test fit refused", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end
