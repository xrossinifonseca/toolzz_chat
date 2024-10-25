require 'rails_helper'

RSpec.describe User, type: :model do


  context "validations" do

    describe "valid user" do
      it "is valid with a unique email" do
        user = build(:user)
        expect(user).to be_valid
      end
    end

    describe "validations for email presence and uniqueness" do

      it "is not valid if the email is blank" do
        user = User.new(email: nil)

        expect(user).not_to be_valid
        expect(user.errors[:email]).to include("can't be blank")
      end

      it "is not valid if the email is not unique" do

        user_1 = User.create(name:"john",email: "john.doe@example.com",password:"password")
        user = User.create(name:"john",email: "john.doe@example.com",password:"password")
        expect(user).not_to be_valid
        expect(user.errors[:email]).to include("has already been taken")
      end
    end

  describe "Validations for password and name" do

    it "Is not valid if the name is blank" do
      user = User.new(name: nil)
      expect(user).not_to be_valid
      expect(user.errors[:name]).to include("can't be blank")
    end

    it "Is not valid if the password is blank" do
      user = User.new(password: nil)
      expect(user).not_to be_valid
      expect(user.errors[:password]).to include("can't be blank")
    end
  end
  end
end
