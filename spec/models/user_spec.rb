  require 'rails_helper'

RSpec.describe User, type: :model do
  it {is_expected.to validate_presence_of(:name)}
  it {is_expected.to validate_presence_of(:matric)}
  it {is_expected.to validate_presence_of(:room_number)}

  describe "On create, bad input is given" do
    context "when wrong format room number given (negative)" do
      it "should not be valid" do
        expect(FactoryGirl.build(:user, :invalid_room_neg)).to_not be_valid
      end
    end
    context "when wrong format room number given (second floor)" do
      it "should not be valid" do
        expect(FactoryGirl.build(:user, :invalid_room_2)).to_not be_valid
      end
    end
  end

  describe "On create, correct input is given" do
   context "when correct room number given (non suite)" do
      it "should be valid" do
        expect(FactoryGirl.build(:user)).to be_valid
      end
    end
    context "when correct room number given (suite)" do
      it "should be valid" do
        expect(FactoryGirl.build(:user, :suite)).to be_valid
      end
    end
  end

  describe "When a new user is being created" do
   context "when it has the same matric number as another user" do
      it "should not be valid" do
        FactoryGirl.create(:user)
        expect(FactoryGirl.build(:user, :suite)).to_not be_valid
      end
    end

    context "when it has the same room number as another user" do
      it "should not be valid" do
        FactoryGirl.create(:user)
        expect(FactoryGirl.build(:user, matric: "E0002834")).to_not be_valid
      end
    end
  end



end
