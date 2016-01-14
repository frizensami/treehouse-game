class User < ActiveRecord::Base
  include ApplicationHelper

  has_many :sentences
  belongs_to :house

  #have to have all these fields
  validates :name, :matric, :room_number, presence: true

  #make sure matric, room number and name are all unique. None can be shared.
  validates :name, uniqueness: true
  validates :room_number, uniqueness: true
  validates :matric, uniqueness: true

  #room number takes the form xy-abc[A-F]
  validates_format_of :room_number, :with => /\A\d{2}-\d{3}[a-fA-F]?\z/, :on => :create
  #check if the room number is in range
  validate :floor_number_in_range
  validate :matric_format_correct

  #check for house and set
  before_save do |user|
    user_floor = (room_number[0] + room_number[1]).to_i
    user_house = House.where("floor_end >= ?", user_floor).where("floor_start <= ?", user_floor).first
    user_house.present? ? user.house = user_house : errors.add(:room_number, "does not have a house!")
  end


  def self.authenticate(matric, room_number)
    #upcase everything!
    matric.try(:upcase!)
    room_number.try(:upcase!)

    User.exists?(matric: matric, room_number: room_number)
  end

  def floor_number_in_range
    unless room_number.blank?
      floor_number = room_number[0] + room_number[1]
      #people can only be from floor 3 to 21st
      errors.add(:room_number, "is not within the correct range (3 - 21)") unless (floor_number.to_i).between?(3, 21)
    else
      #errors.add(:room_number, "cannot be blank!")
    end
  end

  def matric_format_correct
    errors.add(:matric, "is not valid.") unless check_matric_number(matric)
  end

end
