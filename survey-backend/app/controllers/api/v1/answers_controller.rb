class Api::V1::AnswersController < ApplicationController
  before_action :set_survey, only: [:index, :create]
  before_action :set_question, only: [:create]

  # GET api/v1/surveys/:survey_id/answers
  def index
    render json: @survey, :serializer => SurveyQuestionWithAnswerSerializer, include: "questions,questions.answers", status: :ok
  end


  # POST api/v1/surveys/:survey_id/answers
  def create
    # store submitted answer
    @question.answers.create!(answer_params)

    # get next question depend on current selection
    next_question = get_next_question

    if next_question.nil?
      # return if no next_question left for the survey
      render json: {message: 'Survey has been completed'}, status: :ok
    else
      # serialize next question with available choices
      next_question_details = ::QuestionWithChoiceSerializer.new(next_question).serializable_hash

      render json: next_question_details, status: :created
    end
  end


  private

  def get_next_question
    next_question_id = nil
    # check if the question option type was a single_choice
    if @question.option_type == 'single_choice'
      selected_choice = Choice.where(question_id: @question.id, choice_title: params[:answer_text]).last
      next_question_id = selected_choice.next_question_id rescue nil
    end
    # jump in to next question if next_question_id is found for the current choice
    question = @survey.questions.where(id: next_question_id).first if next_question_id.present?
    # if next_question_id is not found then get the next question asc order
    question = @survey.questions.where('id > ?', @question.id).first unless next_question_id.present?

    question
  end

  def answer_params
    params.permit(:question_id, :answer_text)
  end

  def set_survey
    @survey = Survey.find(params[:survey_id])
  end

  def set_question
    @question = Question.find(params[:question_id])
  end
end
