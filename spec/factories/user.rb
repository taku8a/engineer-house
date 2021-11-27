FactoryBot.define do
  factory :user do
    name { Faker::Name.name }
    introduction { Faker::Lorem.characters(number: 20) }
    profile_image { Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/factories/images/desert.jpg'), 'image/jpg') }
    is_valid { Faker::Boolean.boolean(true_ratio: 0.2) }
    email { Faker::Internet.email }
    password = Faker::Internet.password(min_length: 6)
    password { password }
    password_confirmation { password }
  end
end