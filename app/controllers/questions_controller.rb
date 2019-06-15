class QuestionsController < ApplicationController
  before_action :set_question, except: [:index, :new, :create]
  before_action :init_answer, only: :show
  before_action :set_popular_tags, only: [:new, :create, :edit, :update]

  def index
    @questions = Question.all.order(created_at: :desc)
  end

  def new
    @question = Question.new
  end

  def show
    @answers = @question.answers.page(params[:page] || 1)
  end

  def edit
    render 'new'
  end

  def create
    @question = current_user.questions.new(question_params)
    if @question.save
      redirect_to @question
    else
      render 'new'
    end
  end

  def update
    if @question.update(question_params)
      redirect_to @question
    else
      render 'edit'
    end
  end

  def destroy
    @question.destroy
    redirect_to questions_path
  end

  private
  def set_question
    @question = Question.find(params[:id])
  end

  def question_params
    params.require(:question).permit(:title, :description, tag_list: [])
  end

  def init_answer
    @answer = Answer.new
  end
  def set_popular_tags
    @popular_tags = ActsAsTaggableOn::Tag.most_used.limit(10)
  end
end
