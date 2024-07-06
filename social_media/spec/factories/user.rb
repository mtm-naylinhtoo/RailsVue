FactoryBot.define do
	factory :user do
		name { 'John' }
		email { Faker::Internet.email }
		password { 'password' }
		password_confirmation { 'password' }
	end
end
  