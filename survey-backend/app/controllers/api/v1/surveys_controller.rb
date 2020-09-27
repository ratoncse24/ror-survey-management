class Api::V1::SurveysController < Api::ApiBaseController
  before_action :fetch_survey, only: [:show]

  # GET api/v1/surveys
  def index
    @surveys = Survey.all
    render json: @surveys, status: :ok
  end

  # GET api/v1/surveys/:id
  def show
    # fetch first question of this survey
    first_question = @survey.questions.first
    # serialize survey data
    survey_data = ::SurveySerializer.new(@survey).attributes
    if first_question.present?
      # serialize the first question of the serializer
      question_details = ::QuestionWithChoiceSerializer.new(first_question).serializable_hash
      # set question details to survey data object
      survey_data[:question] = question_details
    end
    render json: survey_data, status: :ok
  end

  private

  def fetch_survey
    @survey = Survey.find(params[:id])
  end

end
