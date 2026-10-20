require "test_helper"

class UserTest < ActiveSupport::TestCase
  test "Valid User" do
    user = User.new(
      username: "tester",
      email: "tester@mail.co",
      password: "thepass123"
    )

    assert user.valid?
  end

  test "Invalid username" do
    user = User.new(
      username: nil,
      email: "tester@mail.co",
      password: "thepass123"
    )

    assert_not user.valid?
    assert_includes user.errors.attribute_names, :username
  end

  test "Invalid email" do
    user = User.new(
      username: "tester",
      email: "testermail.co",
      password: "thepass123"
    )

    assert_not user.valid?
    assert_includes user.errors.attribute_names, :email
  end

  test "Encrypted password" do
    user = User.create!(
      username: "tester",
      email: "testermail.co",
      password: "thepass123"
    )

    assert user.authenticate("thepass123")
    assert_not_equal "thepass123", user.password_digest
  end
end
