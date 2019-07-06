FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    job_title { Faker::Job.title }
    password {"password"}
    password_confirmation {"password"}
  end

  trait :is_approved do
    approved {true}
  end

  trait :is_not_approved do
    approved {false}
  end

  trait :is_dev do
    dev {true}
  end

  trait :is_not_dev do
    dev {false}
  end

  trait :without_email do
    email {nil}
  end

  trait :without_first_name do
    first_name {nil}
  end

  trait :without_last_name do
    last_name {nil}
  end

  trait :without_job_title do
    job_title {nil}
  end

  trait :with_nickname do
    sequence(:nickname) { |n| Faker::Name.first_name + "#{n}" }
  end

  trait :pref_name_0 do
    preferred_name {0}
  end

  trait :pref_name_1 do
    preferred_name {1}
  end

  trait :pref_name_2 do
    preferred_name {2}
  end

  trait :pref_name_3 do
    preferred_name {3}
  end

  trait :pref_name_4 do
    preferred_name {4}
  end

  trait :pref_name_5 do
    preferred_name {5}
  end

  trait :pref_name_6 do
    preferred_name {6}
  end

  trait :pref_name_7 do
    preferred_name {7}
  end

  trait :pref_name_8 do
    preferred_name {8}
  end

  trait :preferred_name_test do
    first_name {"Dwayne"}
    nickname {"The Rock"}
    last_name {"Johnson"}
  end
end
