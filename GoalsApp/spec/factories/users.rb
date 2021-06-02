FactoryBot.define do
    factory :user do
        username {Faker::Games::Pokemon.name}
        password {"password"}
    end
end