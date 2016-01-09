class CreateSentences < ActiveRecord::Migration
  def change
    create_table :sentences do |t|
      t.belongs_to :user, index: true, foreign_key: true
      t.belongs_to :house, index: true, foreign_key: true
      t.string :sentence_text

      t.timestamps null: false
    end
  end
end
