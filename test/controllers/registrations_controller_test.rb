require "test_helper"

class RegistrationsControllerTest < ActionDispatch::IntegrationTest
  test "Send a welcome email" do
    assert_difference("User.count", 1) do
    assert_emails 1 do
      post "/registrations",
        params: {
          user: {
            username: "newtester",
            email: "newtester@example.com",
            password: "Pass123"
          }
        },
        as: :json
    end
  end

  assert_response :created

  email = ActionMailer::Base.deliveries.last
  assert_equal ["newtester@example.com"], email.to
  assert_equal "Welcome to the Job", email.subject
  end
end
