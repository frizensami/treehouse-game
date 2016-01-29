class Sentence < ActiveRecord::Base
  belongs_to :user
  belongs_to :house

  validates :user, :house, :sentence_text, presence: true

  # checks whether only 1 sentence was added
  validate do |sentence|
    if sentence_text.present?
      puts "Sentence Text to validate: #{sentence.sentence_text}"
      puts "Sentence Scalpel: #{Scalpel.cut(sentence.sentence_text).length}"
      errors.add(:sentence_text, "has more than one sentence! Only one is allowed") if ((Scalpel.cut(sentence.sentence_text).length) != 1)
    end
  end


  validate do |sentence|
    # only allow user to post after > 2 sentences have been posted into the house sentences


  end

end
