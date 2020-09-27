class CreateQuestions < ActiveRecord::Migration[6.0]
  def change
    create_table :questions, comment: 'store survey questions' do |t|
      t.references :survey, index: true, foreign_key: true
      t.string :question_title
      t.string :option_type
      t.timestamps
    end
  end
end
