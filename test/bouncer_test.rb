require "test_helper"

class BouncerTest < ActiveSupport::TestCase
  test "it has a version number" do
    assert Bouncer::VERSION
  end

  test "event users are polymorphic" do
    assert Bouncer::Event.reflect_on_association(:user).polymorphic?
  end
end
