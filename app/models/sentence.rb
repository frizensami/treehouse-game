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

  # only allow user to post after > 2 sentences have been posted into the house sentences
  validate do |cur_sentence|
    unless (house.blank? || user.blank?) || (Sentence.where(user: user).count == 0)
      puts "House: #{house}"
      num_sentences_since = Sentence.where(house_id: house_id)
                            .where("created_at > ?", Sentence.where(user: user).order("created_at DESC").first.created_at)
                            .count
      puts "Number of sentences since last time you posted: #{num_sentences_since}"
      if num_sentences_since < 2
        errors.add(:you, "can only add a sentence after 2 other sentences have been posted!")
      end
    end

  end

  validate do |cur_sentence|
    unless cur_sentence.created_at.blank?
      if Sentence.where(house_id: house_id).where("created_at >= ?", cur_sentence.created_at).count >= 1
        errors.add(:another, "sentence has been created while you were typing, please consider changing your response :)")
      end
    end
  end

end
