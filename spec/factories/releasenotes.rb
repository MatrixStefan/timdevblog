FactoryBot.define do
  factory :release_note do
    title { Faker::DumbAndDumber.quote }
    release_date { Faker::Date.between(1.years.ago, Date.today) }
    intro { Faker::StarWars.quote }
    outro { Faker::RickAndMorty.quote }
    published false
  end
  
  trait :published do
    published true
  end
end

