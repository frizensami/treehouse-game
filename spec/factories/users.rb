FactoryGirl.define do
  factory :user do
    name "Sriram Sami"
    matric "E0002832"
    room_number "08-163"

    trait :suite do
      room_number "08-162F"
    end

    trait :invalid_room_neg do
      room_number "-02-123"
    end

    trait :invalid_room_2 do
      room_number "02-123"
    end



  end

end
