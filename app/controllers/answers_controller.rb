class AnswersController < ApplicationController
  before_action :init_answer, only: [:new, :create, :update]
  before_action :get_question
  before_action :set_answer, except: [:index, :new, :create]

  def index
    @answers = @question.answers.page(params[:page])
    respond
  end

  def create
    @answer = @question.answers.build(answers_params.merge(user: current_user))
    @answer.save
    respond
  end

  def update
    @answer.update(answers_params)
    respond
  end

  def destroy
    @answer = @answer.destroy
    respond
  end

  private
  def get_question
    @question = Question.find(params[:question_id])
  end

  def set_answer
    @answer = @question.answers.find(params[:id])
  end

  def init_answer
    @answer_init = Answer.new
  end

  def answers_params
    params.require(:answer).permit(:body)
  end

  def respond
    respond_to do |format|
      format.js
    end
  end
end
