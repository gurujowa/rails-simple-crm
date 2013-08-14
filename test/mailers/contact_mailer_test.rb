require 'test_helper'

class ContactMailerTest < ActionMailer::TestCase
  test "today" do
    mail = ContactMailer.today
    assert_equal "Today", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end
