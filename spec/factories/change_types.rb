FactoryBot.define do
  factory :change_type do
    # Default values for change type testing
    name "Test"
    icon "fa-flask"
    priority 0
  end
  
  # Manipulate various attributes for validation testing
  trait :without_name do
    name nil
  end
  
  trait :without_icon do
    icon nil
  end
  
  trait :without_priority do
    priority nil
  end
  
  # These traits let us overwrite the defaults with app-specific values for real-world testing
  trait :new_feature do
    name "New Feature"
    icon "fa-sun"
    priority 1
  end
  
  trait :enhancement do
    name "Enhancement"
    icon "fa-thumbs-up"
    priority 2
  end
  
  trait :bug_fix do
    name "Bug Fix"
    icon "fa-bug"
    priority 3
  end
end
