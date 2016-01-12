class Sentence < ActiveRecord::Base
  belongs_to :user
  belongs_to :house

  validates :user, :house, :sentence_text, presence: true

end
