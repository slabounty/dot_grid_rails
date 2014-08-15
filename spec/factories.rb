FactoryGirl.define do
  factory :user do
    name     "Joe Turner"
    email    "jturner@example.com"
    password "foobar"
    password_confirmation "foobar"
  end
end
