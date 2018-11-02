FactoryBot.define do
  factory :party do
    title { Faker::Book.title }
    date { "07-08-2099 10:54:00" }
    description { "Viewing the Sample Celestial Event" }
    street_address { "980 Grant Street" }
    city { "Denver" }
    state { "CO"}
    zip_code { 80203 }
    association :host, factory: :user
  end
end
