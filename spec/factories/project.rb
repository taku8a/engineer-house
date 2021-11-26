FactoryBot.define do
  factory :project do
    name { Faker::Lorem.characters(number: 10) }
    introduction { Faker::Lorem.characters(number: 20) }
    owner_id { Faker::Number.between(from: 1) }
    project_image { Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/factories/images/desert.jpg'), 'image/jpg') }
  end
end