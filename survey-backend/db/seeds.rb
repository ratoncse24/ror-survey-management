# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# ============= seed data for survey and questions ===================
# create default survey
survey_exist = Survey.where(survey_title: 'Survey one').first
if survey_exist.nil?
  survey_one = Survey.create({survey_title: 'Survey one'})
  survey_two = Survey.create({survey_title: 'Survey two'})

  # create question for survey one
  question_one = Question.create({question_title: 'Q1', option_type: 'single_choice', survey_id: survey_one.id})
  question_two = Question.create({question_title: 'Q2', option_type: 'multiple_choice', survey_id: survey_one.id})
  question_three = Question.create({question_title: 'Q3', option_type: 'input_text', survey_id: survey_one.id})
  question_four = Question.create({question_title: 'Q4', option_type: 'input_text', survey_id: survey_one.id})
  question_five = Question.create({question_title: 'Q5', option_type: 'single_choice', survey_id: survey_one.id})
  question_six = Question.create({question_title: 'Q6', option_type: 'input_text', survey_id: survey_one.id})
  question_seven = Question.create({question_title: 'Q7', option_type: 'single_choice', survey_id: survey_one.id})
  question_eight = Question.create({question_title: 'Q8', option_type: 'input_text', survey_id: survey_one.id})

  # create choices for question Q1
  Choice.create({choice_title: 'Choice-Q1C1', question_id: question_one.id, next_question_id: question_three.id})
  Choice.create({choice_title: 'Choice-Q1C2', question_id: question_one.id, next_question_id: question_five.id})
  Choice.create({choice_title: 'Choice-Q1C3', question_id: question_one.id})

  # create choices for question Q2
  Choice.create({choice_title: 'Choice-Q2C1', question_id: question_two.id })
  Choice.create({choice_title: 'Choice-Q2C2', question_id: question_two.id })
  Choice.create({choice_title: 'Choice-Q2C3', question_id: question_two.id})

  # create choices for question Q5
  Choice.create({choice_title: 'Choice-Q5C1', question_id: question_five.id, next_question_id: question_eight.id })
  Choice.create({choice_title: 'Choice-Q5C2', question_id: question_five.id})
  Choice.create({choice_title: 'Choice-Q5C3', question_id: question_five.id , next_question_id: question_seven.id})

  # create choices for question Q7
  Choice.create({choice_title: 'Choice-Q7C1', question_id: question_seven.id })
  Choice.create({choice_title: 'Choice-Q7C2', question_id: question_seven.id })
  Choice.create({choice_title: 'Choice-Q7C3', question_id: question_seven.id })

  Answer.create(question_id: question_one.id, answer_text: 'Choice-Q1C1')
  Answer.create(question_id: question_three.id, answer_text: 'my custom input for Q3')
  Answer.create(question_id: question_four.id, answer_text: 'my custom input for Q4')
  Answer.create(question_id: question_five.id, answer_text: 'Choice-Q5C3')
  Answer.create(question_id: question_seven.id, answer_text: 'Choice-Q7C2')
  Answer.create(question_id: question_eight.id, answer_text: 'my custom input for Q8')

  # creating question, choices and answer for survey_2
  # create question for survey one
  s2_question_one = Question.create({question_title: 'S2 Q1', option_type: 'single_choice', survey_id: survey_two.id})
  s2_question_two = Question.create({question_title: 'S2 Q2', option_type: 'multiple_choice', survey_id: survey_two.id})
  s2_question_three = Question.create({question_title: 'S2 Q3', option_type: 'input_text', survey_id: survey_two.id})
  s2_question_four = Question.create({question_title: 'S2 Q4', option_type: 'input_text', survey_id: survey_two.id})

  # create choices for question S2 Q1
  Choice.create({choice_title: 'Choice-S2 Q1C1', question_id: s2_question_one.id, next_question_id: s2_question_three.id})
  Choice.create({choice_title: 'Choice-S2 Q1C2', question_id: s2_question_one.id, next_question_id: s2_question_four.id})
  Choice.create({choice_title: 'Choice-S2 Q1C3', question_id: s2_question_one.id})

  # create choices for question S2 Q2
  Choice.create({choice_title: 'Choice-S2 Q2C1', question_id: s2_question_two.id })
  Choice.create({choice_title: 'Choice-S2 Q2C2', question_id: s2_question_two.id })
  Choice.create({choice_title: 'Choice-S2 Q2C3', question_id: s2_question_two.id})


end

