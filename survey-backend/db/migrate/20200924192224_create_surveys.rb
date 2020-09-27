class CreateSurveys < ActiveRecord::Migration[6.0]
  def change
    create_table :surveys, comment: 'store survey information' do |t|
      t.string :survey_title,
      t.timestamps
    end
  end
end
