require 'rails_helper'

RSpec.feature "AnswerCrudOperations", type: :feature, js: true, driver: :selenium do
  given!(:user) { create :user }
  given!(:question) { create :question }
  given!(:question_1) { create :question }
  given!(:answer_content) { Faker::Lorem.paragraph }
  given!(:answer_content_2) { Faker::Lorem.paragraph }

  before do
    login_as user
  end

  describe "When I visit the root_url" do
    before do
      visit root_path
    end

    it "should have list of questions" do
      expect(page).to have_content question.title
      expect(page).to have_content question_1.title
    end
  end

  describe "When I visit a question page" do
    before do
      visit question_path(question)
    end

    it "should show the question details and answer box" do
      expect(page).to have_content question.title
      expect(page).to have_content question.description
      expect(page).to have_button "Add Answer"
      expect(page).to have_content "No answers yet"
    end

    it "should add and delete the answer" do
      expect(page).to have_content "By #{question.user.name}"

      fill_in_ckeditor 'answer_body', answer_content

      click_on "Add Answer"
      expect(page).to have_content(answer_content)

      fill_in_ckeditor 'answer_body', answer_content_2
      click_on "Add Answer"

      expect(page).to have_content(CGI.escapeHTML answer_content)
      expect(page).to have_content(CGI.escapeHTML answer_content_2)

      expect(page).to have_content "By #{user.name}"

      first(:link, "Delete").click
      page.driver.browser.switch_to.alert.accept

      expect(page).to have_content(CGI.escapeHTML answer_content)
      expect(page).not_to have_content(CGI.escapeHTML answer_content_2)
    end
  end
end
