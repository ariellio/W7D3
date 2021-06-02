require 'rails_helper'

RSpec.describe User, type: :model do

    describe "validations" do

        before :each do
            FactoryBot.create(:user)
        end

        it { should validate_presence_of(:username) }
        it { should validate_presence_of(:password_digest) }
        it { should validate_presence_of(:session_token) }

    end

    describe "uniqueness" do
        before :each do
            create :user
        end

        it { should validate_uniqueness_of(:username) }
        it { should validate_uniqueness_of(:session_token) }
    end

    describe "User#is_password?" do 
        let (:user) { create :user}

        context "given a valid password" do 
            it "should return true" do
                expect(user.is_password?("password")).to be(true)
            end
        end
        
        context "given an invalid password" do
            it "should return false" do
                expect(user.is_password?("passwordd")).to be(false)
            end
        end
    end

    describe "User#reset_session_token!" do
        let (:user) { create :user} 
        it "should not have the same session_token" do
            temp = user.session_token
            expect(user.reset_session_token!).to_not eq(temp)
        end
    end

    describe "User::find_by_credentials" do 
        let (:user) {create :user}
        it "should be able to find the user with valid credentials" do 
            expect(user.class.find_by_credentials("howard", "password")).to eq(user)
        end
        it "should not be able to find the user without valid credentials" do 
            expect(user.class.find_by_credentials("howie", "password")).to eq(nil)
        end
    end

end