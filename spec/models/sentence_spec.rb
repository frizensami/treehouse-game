require 'rails_helper'

RSpec.describe Sentence, type: :model do
  it {is_expected.to validate_presence_of(:user)}
  it {is_expected.to validate_presence_of(:house)}
  it {is_expected.to validate_presence_of(:sentence_text)}



end
