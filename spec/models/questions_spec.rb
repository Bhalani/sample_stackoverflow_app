require 'rails_helper'

RSpec.describe Question, type: :model do
  subject(:question) { build :question }

  describe 'validations' do
    describe "Create Question with blank title and description" do
      let(:question) { build :question, title: "", description: ""  }

      it "should raise validation error" do
        expect(question.save).to be_falsy
        expect(question.errors.full_messages).to eq ["Title can't be blank", "Description can't be blank"]
      end
    end

    describe "Create Question with short title and description" do
      let(:question) { build :question, title: "test", description: "test test" }

      it "should raise validation error" do
        expect(question.save).to be_falsy
        expect(question.errors.full_messages).to eq ["Title is too short (minimum is 15 characters)", "Description is too short (minimum is 30 characters)"]
      end
    end

    describe "Create Question with short title and description" do
      let(:question) { build :question, title: Faker::Movies::HarryPotter.book, description: Faker::Lorem.paragraph }

      it "should raise validation error" do
        expect(question.save).to be_truthy
        expect(question.errors.full_messages).to eq []
      end
    end
  end
end
