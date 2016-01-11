class User < ActiveRecord::Base
  has_many :sentences

  #have to have all these fields
  validates :name, :matric, :room_number, presence: true

  #make sure matric, room number and name are all unique. None can be shared.
  validates :name, uniqueness: true
  validates :room_number, uniqueness: true
  validates :matric, uniqueness: true

  validates_format_of :room_number, :with => /\A\d{2}-\d{3}[a-fA-F]?\z/, :on => :create

  #check if the room number is in range
  validate :floor_number_in_range
  #validates_format_of :matric, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/, :on => :create


  #room number takes the form xy-abc[A-F]
  def self.authenticate(matric, room_number)
    User.exists?(matric: matric, room_number: room_number)
  end

  def floor_number_in_range
    unless room_number.blank?
      floor_number = room_number[0] + room_number[1]
      #people can only be from floor 3 to 21st
      errors.add(:room_number, "is not within the correct range (3 - 21)") unless (floor_number.to_i).between?(3, 21)
    else
      errors.add(:room_number, "cannot be blank!")
    end

  end

end
