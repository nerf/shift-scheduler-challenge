FactoryBot.define do
  factory :house do
    sequence(:name) { |n| "London #{n}" }
    address { "Middle of nowhere 001" }
  end

  factory :employee do
    sequence(:name) { |n| "John Doe #{n}" }
    house
  end
end
