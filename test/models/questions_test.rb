require 'test_helper'

class QuestionTest < ActiveSupport::TestCase
  fixtures :questions, :users

  test "Create Question with blank title and description should raise validation error" do
    question = Question.new({title: "", description: "", user: users(:one)})
    question.save
    assert_equal(["Title can't be blank", "Description can't be blank"], question.errors.full_messages)
  end

  test "Create Question with short title and description should raise validation error" do
    question = Question.new({title: "test", description: " test test", user: users(:one)})
    question.save
    assert_equal(["Title is too short (minimum is 15 characters)", "Description is too short (minimum is 30 characters)"], question.errors.full_messages)
  end

  test "Create Question with valid title and description" do
    question = Question.new({
      title: "How to change favicon forcefully?",
      description: "Different favicon needed in different pages. Sub-pages uses react routing."+
      " Is there any way in Javascript so we can change favicon on run time?",
      user: users(:one)
    })
    question.save
    assert_equal(
      [],
      question.errors.full_messages
    )
    assert_equal(users(:one), question.user)
    assert_equal(Question.last, question)
  end
end
