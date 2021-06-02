require 'rails_helper'

RSpec.describe UsersController, type: :controller do
    describe "GET#new" do 
        it "renders the new template" do 
            get :new
            expect(response).to render_template(:new)
        end
    end

    describe "GET#show" do 
        let(:user) { create :user}
        it "renders the show template" do 
            get :show, params: {id: user.id}
            expect(response).to render_template(:show)
        end
    end

    describe "POST#create" do
        it "should create user with valid credentials" do
            post :create, params:{ user: { username: 'aldrix', password: 'password' }} 
            expect(response).to redirect_to(user_url(User.last))
        end
        it "should not create user with invalid credentials" do
            post :create, params:{ user: { username: 'aldrix', password: '' }} 
            expect(response).to render_template :new
        end
    end

    
end

