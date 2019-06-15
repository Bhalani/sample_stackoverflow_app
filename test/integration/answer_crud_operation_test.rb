require 'test_helper'

class LegacyEcardRouteTest < Capybara::Rails::TestCase
  def setup
    @question = questions :question_1
  end

  test 'Answer a question' do
    test_login
    binding.pry
    page
  end

  private
  def test_login
    visit root_path
    assert_equal 200, status
    binding.pry
    # post "/users/sign_in", params: { email: users(:two).email,
      # password: "password" }
    # follow_redirect!
    assert_equal 200, status
    assert_equal "/questions", path
  end
end
