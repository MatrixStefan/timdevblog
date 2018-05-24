FactoryBot.define do
  factory :release_note_item do
    change_title { Faker::Simpsons.quote}
    change_details { Faker::ChuckNorris.fact }
  end
end
