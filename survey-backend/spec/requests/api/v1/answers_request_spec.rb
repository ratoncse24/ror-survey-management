require 'rails_helper'

RSpec.describe "Api::V1::Answers", type: :request do
  # Initialize the test data
  # create a survey
  let!(:survey) { create(:survey) }
  let!(:survey_id) { survey.id }
  # create two questions for the above survey
  let!(:question_one) { create(:question, survey_id: survey.id, option_type: 'single_choice') }
  let!(:question_two) { create(:question, survey_id: survey.id, option_type: 'multiple_choice') }
  let!(:question_three) { create(:question, survey_id: survey.id, option_type: 'input_text') }
  let(:first_question_id) { question_one.id }
  let(:second_question_id) { question_two.id }
  let(:third_question_id) { question_three.id }
  # create questions choice
  # If user select first choice of question-1 then user will get next question-3 and skip question-2 by logic jump
  # if use select second choice of question-1 then user will get next question-2 as second choice does not have any next_question_id
  let!(:first_question_choice_one) { create(:choice, question_id: first_question_id, next_question_id: third_question_id) }
  let!(:first_question_choice_two) { create(:choice, question_id: first_question_id) }
  let!(:second_question_choices) { create_list(:choice, 3, question_id: second_question_id) }

  # create questions answer
  # creating 1 answer for question-1
  let!(:answer_for_question_one) { create(:answer, question_id: first_question_id, answer_text: first_question_choice_one.choice_title) }
  # creating 2 answer for question-2
  let!(:answer_for_question_two) { create_list(:answer, 2, question_id: second_question_id, answer_text: second_question_choices.first.choice_title) }


  # Test suite for POST /api/v1/surveys/:survey_id/answers
  describe 'POST /api/v1/surveys/:survey_id/answers' do

    context 'when request attributes are valid and has logic jump' do
      let(:valid_attributes) { { question_id: first_question_id, answer_text: first_question_choice_one.choice_title } }

      # we are submitting answer for question-1 and chosen answer is first_question_choice_one
      # which will return question-3 as a next question of this survey because of logic jump
      # This will skip question-2
      before { post "/api/v1/surveys/#{survey_id}/answers", params: valid_attributes }

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end

      # logic jump here skipping question-2
      it 'returns next question-3 as next question' do
        expect(json['id']).to eq(third_question_id)
        expect(json['option_type']).to eq('input_text')
      end

    end

    context 'when request attributes are valid and without logic jump' do
      let(:valid_attributes) { { question_id: first_question_id, answer_text: first_question_choice_two.choice_title } }
      # we are submitting answer for question-1 and chosen answer is first_question_choice_two
      # which will return question-2 as a next question of this survey because
      # first_question_choice_two does not have logic jump
      before { post "/api/v1/surveys/#{survey_id}/answers", params: valid_attributes }

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end

      # no logic jump here
      it 'returns next question-2 as next question' do
        expect(json['id']).to eq(second_question_id)
        expect(json['option_type']).to eq('multiple_choice')
      end

    end

    context 'when request attributes are valid and last question of the survey' do
      let(:valid_attributes) { { question_id: third_question_id, answer_text: "My custom input" } }
      # we are submitting answer for question-3 which is input_text and last question of this survey
      # this should return a message that survey has been completed
      before { post "/api/v1/surveys/#{survey_id}/answers", params: valid_attributes }

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns survey complete message' do
        expect(json['message']).to eq('Survey has been completed')
      end

    end

    context 'when an invalid request without answer_text' do
      before { post "/api/v1/surveys/#{survey_id}/answers", params: {question_id: first_question_id} }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a failure message' do
        expect(response.body).to match(/Validation failed: Answer text can't be blank/)
      end
    end

    context 'when an invalid request without question_id' do
      before { post "/api/v1/surveys/#{survey_id}/answers", params: {answer_text: first_question_choice_one.choice_title} }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a failure message' do
        expect(response.body).to match(/Couldn't find Question without an ID/)
      end
    end

    context 'when an invalid request with invalid question_id' do
      before { post "/api/v1/surveys/#{survey_id}/answers", params: {question_id: 5555555, answer_text: first_question_choice_one.choice_title} }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a failure message' do
        expect(response.body).to match(/Couldn't find Question/)
      end
    end

    context 'when an invalid request with invalid survey_id' do
      before { post "/api/v1/surveys/#{666666}/answers", params: {question_id: first_question_id, answer_text: first_question_choice_one.choice_title} }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a failure message' do
        expect(response.body).to match(/Couldn't find Survey/)
      end
    end
  end



  # Test suite for GET /api/v1/surveys/:survey_id/answers
  describe 'GET /api/v1/surveys/:survey_id/answers' do
    before { get "/api/v1/surveys/#{survey_id}/answers" }

    context 'when survey exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns all questions of this survey' do
        # survey has 3 questions
        expect(json['questions'].size).to eq(3)
      end

      it 'returns answer for every question' do
        # we are checking answer for the question-1
        # question-1 has only one answers defined above
        expect(json['questions'][0]['answers'].size).to eq(1)
        # we are checking answer for the question-2
        # question-2 has two answers defined above
        expect(json['questions'][1]['answers'].size).to eq(2)
        # we are checking answer for the question-3
        # question-3 does not have any answers
        expect(json['questions'][2]['answers'].size).to eq(0)
      end
    end

    context 'when survey does not exist' do
      let(:survey_id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Survey/)
      end
    end
  end



end
