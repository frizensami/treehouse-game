class House < ActiveRecord::Base
  has_many :users
  has_many :sentences
end
