require 'rails_helper'

RSpec.describe "Api::V1::Surveys", type: :request do
  # initialize test data
  let!(:surveys) { create_list(:survey, 5) }
  let(:survey_id) { surveys.first.id }
  let!(:questions) { create_list(:question, 2, survey_id: surveys.first.id, option_type: 'input_text') }
  let(:first_question_id) { questions.first.id }

  # Test suite for GET api/v1/surveys
  describe 'GET api/v1/surveys' do
    # make HTTP get request before each example
    before { get '/api/v1/surveys' }

    it 'returns surveys' do
      # Note `json` is a custom helper to parse JSON responses
      expect(json).not_to be_empty
      expect(json.size).to eq(5)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end


  # Test suite for GET api/v1/surveys/:id
  describe 'GET api/v1/surveys/:id' do
    before { get "/api/v1/surveys/#{survey_id}" }

    context 'when the record exists' do

      it 'returns the survey' do
        expect(json).not_to be_empty
        expect(json['id']).to eq(survey_id)
      end

      it 'returns the first question of survey' do
        expect(json['question']['id']).to eq(first_question_id)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end


    end

    context 'when the record does not exist' do
      let(:survey_id) { 100 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Survey/)
      end
    end
  end


end
